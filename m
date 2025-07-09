Return-Path: <linux-kernel+bounces-723658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0C6AFE99A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E5D4A75A6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B472D2D8796;
	Wed,  9 Jul 2025 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUpkfdsw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B121CC4D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066267; cv=none; b=QMU8icvnGAGJdKN/6t/YqwgwURFtzur4NH5YellEv6g27Odjp8Sj1f/GvCfysnIJ9IbIAzvgoxrHqZZ6AFdwcT4uSlp6CKYHR1KEpV2obzvYOOlT2XM+BT0XbAsko32YteknqKicNlFybIwXMA2HTVeu86pxv6+1zzWXd7jqXMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066267; c=relaxed/simple;
	bh=xSlEba7/Me3MBHgdbdrycEQgNguAjPGNbCQq1OYfDv0=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=mY9YbJyP1KF6UaxGmuXGIIxJ1eUe+5KARUSGeZUGwciOcmMbLTK+zZBo3DHvwBi8ItO+s6d/yPC51lUl2Sn6EUWYJzcmVhpNgDMBSlTDDugLyajN5lxU9eKuLLLAUnPttm6T8+v1j4cpaG0W4FB9frlnteaPusiFdMyitZM/KwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUpkfdsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B46EC4CEEF;
	Wed,  9 Jul 2025 13:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752066266;
	bh=xSlEba7/Me3MBHgdbdrycEQgNguAjPGNbCQq1OYfDv0=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=GUpkfdswKkVMSkrYctRRZXgOaoqsJsZM9z6KVLamhZN5f12dIyAMDDI84YkbWn9Xc
	 t3ABZnOj4z71vXBJkSxBDSN86whXk8lDk1WZ5qFIPMkXJz9vUwMGLyoQsRfPvo+S9D
	 umAyPd469Qb0s0fMz36B9p7KjJUCypNkS0MbWLFQz2QtcpA4tAzbJBiNNgOk4WUMEo
	 YhDM/oO5rJscxZj6W3YzGuAbbSogPGfOW8x1jePdYvZPHT3nqMQsR5CQnSt3ifIaRy
	 KF62Zx68aTMuTkw7iDzyyETlKugI35ktVqVIbkvjM43kU1CYMENFjdG8Z4+sK/8LsQ
	 /poFrUiCbGaDA==
Message-ID: <a73a568ac9d3fa59cc491a1c9b1c299d@kernel.org>
Date: Wed, 09 Jul 2025 13:04:24 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Anusha Srivatsa" <asrivats@redhat.com>
Subject: Re: [PATCH 4/6] drm/panel/kd070fhfid015: Use refcounted allocation
 in place of devm_kzalloc()
In-Reply-To: <20250708-b4-simple-panel-api-convert-july-v1-4-630902123ea1@redhat.com>
References: <20250708-b4-simple-panel-api-convert-july-v1-4-630902123ea1@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Geert Uytterhoeven" <geert@linux-m68k.org>, "Jessica
 Zhang" <jessica.zhang@oss.qualcomm.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Tue, 8 Jul 2025 15:35:16 -0500, Anusha Srivatsa wrote:
> Move to using the new API devm_drm_panel_alloc() to allocate the
> panel. In the call to the new API, avoid using explicit type and use
> __typeof() for more type safety.
> 
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime


Return-Path: <linux-kernel+bounces-723659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A8EAFE99C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F131C476C1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1102DA765;
	Wed,  9 Jul 2025 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj9JZTCR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD9B28D83A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066285; cv=none; b=VbBM7wOekkQQbRlIJdQJZmjEdtNjj7JqyLxrQR/1b+0nVkm/yICQWIN9KUbkPULNMvySSxcKfVGnsVXonZkqCIkY8vH5ZuOUtpYWWZgAao5xv56nZGKudvjQIDn7BtU08Z5wrmtXPvpR6QPyDRa/KrmKZXdeQL8TI7RkKQ+JD7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066285; c=relaxed/simple;
	bh=E4QmnJBfVzoQ0/BAIJV41b1E9Z0Jit+/5FgOr0vgfAQ=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=tQ9lFqU1LGLcxKnz6TyYLAcsXbW70jcWeEt8o8phay1dWa6alLsUqY+hxRsg57MvLhAHDYPExXnh60lMcw68fdaLbJTz8yThLKJtoWBh3H9U7rpN7AueXpNG+LO0dpwTtTy7CxGn/k7DK9zUllhiZEeIy+1TT16NpOwV8sQlLT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj9JZTCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3603C4CEEF;
	Wed,  9 Jul 2025 13:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752066285;
	bh=E4QmnJBfVzoQ0/BAIJV41b1E9Z0Jit+/5FgOr0vgfAQ=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=gj9JZTCRvBDYCXOAb3A22H5HSKxMFEiwwEzsAz+AfkE0zEG7E1yI3PyhQ+t7Uko0B
	 5iioB5iEVAgf3DfiJqw/rF5V8lYtvc4OpNFU3Wl/0Vo2DaATnZ9KAGmqPGftva31gH
	 6pxhLyMbsHX7xCCpjaeyrWyOOwrkODjkAwkoexuFMNSOmxqaAhCtRH8qMYJpXkH/BQ
	 Sez2hHEM3E0jMVtIwtZqDF8z/xvfQJf3WXnx6p+xqFWqF/KaG5bms2wxNE3IJpLIZa
	 gqdmBIKlsbMU5sXqHA+2Fcco6vgmrmG0Almos642b4JZNlP3Ru2a8zxc1D8J9kRTgR
	 U+vB/g7aAFhDg==
Message-ID: <79f15b1a7f7e138807e25a4bc310fb11@kernel.org>
Date: Wed, 09 Jul 2025 13:04:42 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Anusha Srivatsa" <asrivats@redhat.com>
Subject: Re: [PATCH 5/6] drm/panel/ls043t1le01: Use refcounted allocation in
 place of devm_kzalloc()
In-Reply-To: <20250708-b4-simple-panel-api-convert-july-v1-5-630902123ea1@redhat.com>
References: <20250708-b4-simple-panel-api-convert-july-v1-5-630902123ea1@redhat.com>
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

On Tue, 8 Jul 2025 15:35:17 -0500, Anusha Srivatsa wrote:
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


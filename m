Return-Path: <linux-kernel+bounces-723657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E24A9AFE998
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B969D7BA5A9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61B226B763;
	Wed,  9 Jul 2025 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UB96tGYf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524092D8796
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066229; cv=none; b=In3qPdRDiqSkVu82QN4IepSdUdRw9CFoUnulTonIIvvl4b0XkRiGwZVENX+b5iCvNTmnlmoCjlE5jo2CWL5S1DNF+X2ioYXH3v2SaDIXe1jIyRWW205Qa42yXl20ohjYTrGdjx31kk1Y6f8oUFze+hLCAa+WcIlKLGzkYSMCdEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066229; c=relaxed/simple;
	bh=xUyoV1xWBdh6kvkOqBd/WOmpv0G99ChjoTaPBGI33C8=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=F+TVn2ymgEXmNqV2k4od+PaJU7WaAy03awk7rdM6Xcpe3Vegh2VkCKVqqewZ2HNjA1dE/bTLfRkLoqIninwCxUHhQQdXnRCP+r2tqb6mIl8znPKLj3vZzTcnVWxwfPsYhCUPXJZfgBOkNkHQNgVoJc0r3NvhdigKxGS8/XS3fGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UB96tGYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59935C4CEEF;
	Wed,  9 Jul 2025 13:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752066228;
	bh=xUyoV1xWBdh6kvkOqBd/WOmpv0G99ChjoTaPBGI33C8=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=UB96tGYf3oEnQqa4x4QYcguV2PEeeE/TZQ+G+uN/91Va/yBmfOjDnS1A0mfX3/+KZ
	 Bt08IarUmJVvjX7JTAduyozMyt3QfjmJY33sUGkHR5p4BVaYe8DRJaoALrUp8qvxpe
	 dpySz2T/nh8WknY/+HbY2ruIgdUQMQFykBDmgxW3EQGKvD7aQcT7jDDJztHrkKljmR
	 uTmkfV7cS9oS/OirnPmCENwWU3Ae68x+o2ljq2zGCclDNo2U2fZ0IS62RY4LAseZFj
	 CpyPRtZI4qsQrawMYjg8XFRrqTcDARIsAW3EiGEW637jlDqjUpj8/1W/D3bUKLBcRk
	 IfrWr9AddYssA==
Message-ID: <7622afbfbdc652881119fda54916561a@kernel.org>
Date: Wed, 09 Jul 2025 13:03:46 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Anusha Srivatsa" <asrivats@redhat.com>
Subject: Re: [PATCH 3/6] drm/panel/tdo-tl070wsh30: Use refcounted allocation
 in place of devm_kzalloc()
In-Reply-To: <20250708-b4-simple-panel-api-convert-july-v1-3-630902123ea1@redhat.com>
References: <20250708-b4-simple-panel-api-convert-july-v1-3-630902123ea1@redhat.com>
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

On Tue, 8 Jul 2025 15:35:15 -0500, Anusha Srivatsa wrote:
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


Return-Path: <linux-kernel+bounces-723660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FD1AFE99E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B0416FD8D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C34B2DAFAF;
	Wed,  9 Jul 2025 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1TyICAW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC45928D83A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066320; cv=none; b=Rl83AQv9Hr7gw7VGcVmQ9BEz6OttNrb9qCK1Lv9r9FQBrVrqRjMfUqFogIwZI6pkY+e89/8LoO/u9NlJ//tWlBOE3mzkRa/cG2ypcmbiSlcxDbUOu7uQ27+4IJqsyTVlvhqFQ/qXAZ1GwQXmvc3xz9YlJkZ28SGkUIhgGvfdSaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066320; c=relaxed/simple;
	bh=Z7p+841eYGb4XxPknQoCYIPx6Qe5ZgqRD3mqnnq/HAI=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=lVf1MUjkmmDGFBwz8AiGoICuFFELf5qTBpL3bIpeYUBSIx10IGvLFym6Fmompz5CzVCPMzHxOFh69ifQ8sVCyl8U5UWIPTqHvbAYl8bY+yJUsFM7WMYYOiG3Uscsw8Hpspkuhz84pN6rK/mEUgdXanOr3GlRAkDG0O2BlnMVH98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1TyICAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2741FC4CEEF;
	Wed,  9 Jul 2025 13:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752066319;
	bh=Z7p+841eYGb4XxPknQoCYIPx6Qe5ZgqRD3mqnnq/HAI=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=F1TyICAWgXYv2DYrJr4suF/35fGUquO1rd+Audoo2ieeq3HWK3NWWsovW5wPHVCLC
	 FbYL/Q1pRYYHkk2F9+qaAmV13clIr3th+hJJE1yCUB31OVNaqMMv+j0D6KM1exPGcR
	 Xbk1HzJClnRsxmKQ8DV6VndQYMxf20/NUE6fSGP5iiztzJa+nEl0Y+g27TqlKNSarc
	 B++IhsaNpQV0vxR8OG6oQ97qPg9XS71FhsR9keelKtNlt4R4tK3GJvReZ6qLcXYMNK
	 /hqDsAyocDB31YhA9z3Fy3Wi1ZCReGJE2YlidhWFezlZ7AH0M8v09QKtdnm9mMgnrx
	 WTScCufpLeoRA==
Message-ID: <5538fbdd17113989bfee16b7e6587907@kernel.org>
Date: Wed, 09 Jul 2025 13:05:17 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Anusha Srivatsa" <asrivats@redhat.com>
Subject: Re: [PATCH 6/6] drm/panel/samsung-s6e63m0: Use refcounted
 allocation in place of devm_kzalloc()
In-Reply-To: <20250708-b4-simple-panel-api-convert-july-v1-6-630902123ea1@redhat.com>
References: <20250708-b4-simple-panel-api-convert-july-v1-6-630902123ea1@redhat.com>
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

On Tue, 8 Jul 2025 15:35:18 -0500, Anusha Srivatsa wrote:
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


Return-Path: <linux-kernel+bounces-846625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A27D9BC8948
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF77819E5D32
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBA02DCF4D;
	Thu,  9 Oct 2025 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xa40BtJX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E7013E41A;
	Thu,  9 Oct 2025 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760006949; cv=none; b=mlRMk3tggWz0O7gTCtWcy8n5p5l0mF7iwTxUL+ycApQqfFoiKmK/tiyOekRjvTdpHiTfmOujxqLObf37/oWyD4veGGkXyPV6k/RIVEKm5rg44GCm3etXSIdX7JC/OQA1a/NSGMq0PuM0uG0aMSWvj2o7jbogDanGJfiV/GEP8wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760006949; c=relaxed/simple;
	bh=vP9HeJi0bXQzo1u6hZI+xUyxJCXb3b/WOUuQAuCYXJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyVixjAaC6p9gpOL6JJq0EJTzGmuGjC681PiQGyiDu2kTO0Jkyg5mEmkSDuQXGa2Ebe6gZiKgeFKgWBVBuUWTG/QkkeoXA3zzAj4nnxWYvGRFH5VtrCbxOIRGZvxohlJIWDE584WSAdEqtNOr2+3+dmPr7KbJ7R03g1a0WMYa50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xa40BtJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF069C4CEF9;
	Thu,  9 Oct 2025 10:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760006949;
	bh=vP9HeJi0bXQzo1u6hZI+xUyxJCXb3b/WOUuQAuCYXJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xa40BtJX2scHkLcabOL172JePmIvhkplIlCHTz1JQ38ZcNWYbwve8S0k7bW0B60qr
	 O2WnT59zxUQ3A52kHPS0T0PzR2COJ0u9/tyJj8G1DOdPS2u4RQLsLMPH4dy8sk85eI
	 OQ/sWTdc1DBsKErwxWVa4MBGRfVIy4Qh0NXY97H0=
Date: Thu, 9 Oct 2025 12:49:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: harry.wentland@amd.com, Christian.Koenig@amd.com, sunpeng.li@amd.com,
	airlied@gmail.com, simona@ffwll.ch, Alexander.Deucher@amd.com,
	linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
	amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH] Revert "drm/amd/display: Only restore backlight after
 amdgpu_dm_init or dm_resume"
Message-ID: <2025100959-denture-freebie-76b4@gregkh>
References: <2025100931-retorted-mystified-bd52@gregkh>
 <F64C306E-67BC-4ADC-AF8F-1DACAF695D9D@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F64C306E-67BC-4ADC-AF8F-1DACAF695D9D@linux.dev>

On Thu, Oct 09, 2025 at 12:00:29PM +0200, Matthew Schwartz wrote:
> 
> > 
> > On Oct 9, 2025, at 11:51 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > ﻿On Thu, Oct 09, 2025 at 11:23:01AM +0200, Matthew Schwartz wrote:
> >> This fix regressed the original issue that commit d83c747a1225
> >> ("drm/amd/display: Fix brightness level not retained over reboot") solved,
> >> so revert it until a different approach to solve the regression that
> >> it caused with AMD_PRIVATE_COLOR is found.
> >> 
> >> Fixes: a490c8d77d50 ("drm/amd/display: Only restore backlight after amdgpu_dm_init or dm_resume")
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4620
> >> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> >> ---
> >> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++--------
> >> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 -------
> >> 2 files changed, 4 insertions(+), 15 deletions(-)
> > 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> 
> Apologies, I was a bit confused by:
> 
> If a regression made it into a proper mainline release during the past twelve months, ensure to tag the fix with “Cc: stable@vger.kernel.org”
> 
> in the regressions page, but I see now the way I did it via email cc was incorrect.
> 
> Should I resend with that fixed?

Please do.

thanks!

greg k-h


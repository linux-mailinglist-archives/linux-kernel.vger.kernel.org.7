Return-Path: <linux-kernel+bounces-782750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA4EB324BD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1553E62435B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C6427A90A;
	Fri, 22 Aug 2025 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="iSaUa7a2"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9C01A9FA7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755899609; cv=pass; b=RsbilIw7kf7WpdSuywtCjtHx18QbSjMMCSHKcLULT4uHeJsJ62rQCU8J1/m9o0yk3Hr41E+93VLK4ARzyZgUWbqlKqpYbv2RgdYxzGgBYwzbJ1ppAUexREK90z3pURHHlBD0YZRuYUiZIlHHl07IXSm+IwrcgEX9xOPTgLroTu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755899609; c=relaxed/simple;
	bh=AjWPsPmZxyCqtDJpcMl4uvITTgatiNf2opr9t6IpqbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYEbeUF4uR42hhZwlcMmvxHLgUTaBIEIzC0ctSK+BHMaGi6I839jH/TkbWNWZTJmd9ddiIFTD3Gxaufu9gMRdxuROAHCjABdIqGX0FiLEz5yBt2OcSFpiNT4yyMG5bEnymX4l2rOJfsKsp9MpuXPhAGDPq7SswXxnkBKP3Sf+FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=iSaUa7a2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755899596; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DaeXgqa2mfRAFXQsvYwFnGOx5N/UdDLKPRI4H35tJwQx+SwVAMnl0amneiS5XBvLn1OTE0Xpxl+ajk5yMdjEGmslbLGRV2U0QZynDlZ1uCaoo8YtNx3EDWBAjWd+aQYXrgT9lvThlHsOx/4pV6T2kjE+LJ72rAgB3pUSDjuJXEA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755899596; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=klrRb34wKjAx4QD4DOsPfFa5Y+y4vc9xPa3T8I/olE8=; 
	b=bZ1yeQlkjA1buILpzDbO1uU4/+W0ZCFzleflKEKwpEL2fx+rLE4nVogYYyT3IVed3c3Azh8F9uKmJ2PTWei0kwPZir70CLK6ngk0owgYeySKL6QFgD8D+K5kaTwO1lVtS+/hhlVW1soSQ06sW4O6d6wFAezH6aIlxELR9AvIRlc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755899596;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=klrRb34wKjAx4QD4DOsPfFa5Y+y4vc9xPa3T8I/olE8=;
	b=iSaUa7a2jNmxQGqe7vXbTWhQ/nmEra/4nn8lzccL0eqk3c1NKO3Lyu0hJ0YJtvCN
	PfHdixcUHSL4GNliUGu095teO9PJZt2EwBvsdLVYuRK9hYmyUKEsrpP8UCsxsFyN2Iv
	1AyfHKI5yCLvXxh8skcZWeTEK1n/n3jM8PHvB4io=
Received: by mx.zohomail.com with SMTPS id 1755899594556961.1841976736891;
	Fri, 22 Aug 2025 14:53:14 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 3A4AE1808AD; Fri, 22 Aug 2025 23:53:11 +0200 (CEST)
Date: Fri, 22 Aug 2025 23:53:11 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: defconfig: enable backlight device class
Message-ID: <fozbq6otnko75e4zfsad4c3qp7zgh5n3r4yj3swjd24dxdg4ue@krbmtduwdapm>
References: <20250408134249.1131127-1-alexander.stein@ew.tq-group.com>
 <2385138.ElGaqSPkdT@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2385138.ElGaqSPkdT@steina-w>
X-ZohoMailClient: External

Hi,

On Fri, Aug 22, 2025 at 03:55:12PM +0200, Alexander Stein wrote:
> Am Dienstag, 8. April 2025, 15:42:48 CEST schrieb Alexander Stein:
> > CONFIG_DRM_PANEL_SIMPLE is enabled in this config. But it depends on
> > CONFIG_BACKLIGHT_CLASS_DEVICE which is only transitively enabled by
> > DRM_NOUVEAU, iff DRM_NOUVEAU_BACKLIGHT is enabled as well.
> > As simple-panel depends on backlight, enable this in defconfig as well.
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 65ec5a5be407d..b70257878812e 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -963,6 +963,7 @@ CONFIG_DRM_POWERVR=m
> >  CONFIG_FB=y
> >  CONFIG_FB_EFI=y
> >  CONFIG_FB_MODE_HELPERS=y
> > +CONFIG_BACKLIGHT_CLASS_DEVICE=m
> >  CONFIG_BACKLIGHT_PWM=m
> >  CONFIG_BACKLIGHT_LP855X=m
> >  CONFIG_LOGO=y
> > 
> 
> gentle ping. Any feedback?

You want to resend with updated mail destination:

https://lore.kernel.org/all/20250818-arm64-defconfig-v1-1-f589553c3d72@collabora.com/

Greetings,

-- Sebastian


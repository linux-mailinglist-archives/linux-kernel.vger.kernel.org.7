Return-Path: <linux-kernel+bounces-784099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99360B336B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F5F7A4BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301B7285061;
	Mon, 25 Aug 2025 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="qqZ+t6hw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="CBpO20Pm"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37AB24728B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104566; cv=none; b=rNwwzVEjPpgWlD3XBR48qfzyTcF/4EH0Ll/PQo2+Ibg9bKm1z4BQKBWwkNDQfal/jhXqLgoe5usHOxh6473HxFLIGVEpoJ7OjGkCvlPCcsxN4cOY0x0K9yXuDP77LdzIlyrpTC5WE6Vp0cIT/QyFmNSv4+I5eOKxJgrZZuOHSbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104566; c=relaxed/simple;
	bh=JLCQzWdgBNRboFHztGRIV1Wy+5zAjnkyvrwBoiaKDTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkkxZ+rDySf0Y8mcIU5u3Mx7Ov6f1Gs107xRzP0SRrSUggv+nkM5dneGKp0h+nKpdFd2Tdp/QWbQl9BmW7X4Q0NK81AOsqoXhFjQZUBcn6z/Ub/BEmWk8VRFncanuURxmg8SAKR5xkfaEvuwVsQpeWnTypgQbFXCDxo/cyXKwag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=qqZ+t6hw; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=CBpO20Pm reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756104564; x=1787640564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CPxnu8JjaM/yvdOpkZwcHlIZVYiDwFghDn0gsxBWGdg=;
  b=qqZ+t6hwoHUICAELw+5nD3rUC8H21zNq7DYCLl8yUoVME1TYBeZg6L8V
   6reCh34JI12YFioxHVTkdK6k1HfyVBPkZKiDHeuPSvbAixxJEqGjccyvE
   GWZIaVLyPrqPh2fN2lDL34TH7GOymXLFfx1UbQIwdCxQRQsEzyVPvtIcU
   B+Wg1xDLs+5ciJjlt5212edVcJsQamdGmNnmDsriR1WlvJBAe4CGJDkgi
   90VSb0RMaqoZUx7JBObSawaEiqK4IF1vV3DpFA6Se5jsNcmwcXrkDsrT7
   QamAdAmdlT8rSj0wsI1tdeXSdHbbWSNKGcx36Hq1/suPCNa+Kd+hVMnat
   Q==;
X-CSE-ConnectionGUID: EynKlmkURxCd3md4UWSzaw==
X-CSE-MsgGUID: PvNnWamSSwO7tl4Zz/f09Q==
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="45885091"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Aug 2025 08:49:18 +0200
X-CheckPoint: {68AC076E-8-20CAA7DA-EC9DC758}
X-MAIL-CPID: 835B404CD54FE37D8B940634E0216E79_0
X-Control-Analysis: str=0001.0A002116.68AC07A3.0064,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8DB3616626E;
	Mon, 25 Aug 2025 08:49:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756104553;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CPxnu8JjaM/yvdOpkZwcHlIZVYiDwFghDn0gsxBWGdg=;
	b=CBpO20PmHcjpgD0YMs8GbLgLQFIV7URaZdaqNCp8IXdnG3A714hhT3v1hWvc8p+1aIBsBc
	O26e2nu+imD88hGNenwH8vM3KYdbiWwG3KJAETknhc6aw4GOjUigj373L+eMAgk38s8uaH
	yIMmzKVKSHSMF/Q3+S78qNHfC531lVaj0AhE22VTq5WBOaXiwCcpK314/PAnZN+ilfbO77
	vstrp5X9rCetDfMVO3dYoh5PvahixFSR5IxqCdXIRB1GM7zTvdQcysiKACsD3aUATWgx3t
	eidBlT0T1SqKg611a2BpAyW14yYzAxAeYRL4RKyofriwVXfqZT/82ASKN84eqg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: defconfig: enable backlight device class
Date: Mon, 25 Aug 2025 08:49:12 +0200
Message-ID: <5012214.GXAFRqVoOG@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <fozbq6otnko75e4zfsad4c3qp7zgh5n3r4yj3swjd24dxdg4ue@krbmtduwdapm>
References:
 <20250408134249.1131127-1-alexander.stein@ew.tq-group.com>
 <2385138.ElGaqSPkdT@steina-w>
 <fozbq6otnko75e4zfsad4c3qp7zgh5n3r4yj3swjd24dxdg4ue@krbmtduwdapm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Freitag, 22. August 2025, 23:53:11 CEST schrieb Sebastian Reichel:
> Hi,
>=20
> On Fri, Aug 22, 2025 at 03:55:12PM +0200, Alexander Stein wrote:
> > Am Dienstag, 8. April 2025, 15:42:48 CEST schrieb Alexander Stein:
> > > CONFIG_DRM_PANEL_SIMPLE is enabled in this config. But it depends on
> > > CONFIG_BACKLIGHT_CLASS_DEVICE which is only transitively enabled by
> > > DRM_NOUVEAU, iff DRM_NOUVEAU_BACKLIGHT is enabled as well.
> > > As simple-panel depends on backlight, enable this in defconfig as wel=
l.
> > >=20
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > ---
> > >  arch/arm64/configs/defconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defcon=
fig
> > > index 65ec5a5be407d..b70257878812e 100644
> > > --- a/arch/arm64/configs/defconfig
> > > +++ b/arch/arm64/configs/defconfig
> > > @@ -963,6 +963,7 @@ CONFIG_DRM_POWERVR=3Dm
> > >  CONFIG_FB=3Dy
> > >  CONFIG_FB_EFI=3Dy
> > >  CONFIG_FB_MODE_HELPERS=3Dy
> > > +CONFIG_BACKLIGHT_CLASS_DEVICE=3Dm
> > >  CONFIG_BACKLIGHT_PWM=3Dm
> > >  CONFIG_BACKLIGHT_LP855X=3Dm
> > >  CONFIG_LOGO=3Dy
> > >=20
> >=20
> > gentle ping. Any feedback?
>=20
> You want to resend with updated mail destination:
>=20
> https://lore.kernel.org/all/20250818-arm64-defconfig-v1-1-f589553c3d72@co=
llabora.com/

=46ine by me. But this is not SoC-specific rather than a general change.
So who should be addressed then?

Best regards
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/




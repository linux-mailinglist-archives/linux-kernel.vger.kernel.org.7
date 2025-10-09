Return-Path: <linux-kernel+bounces-846261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 02784BC76B4
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 07:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1D3434F3DA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 05:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6C7259CAB;
	Thu,  9 Oct 2025 05:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPiKhc8r"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2F123816C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 05:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759987005; cv=none; b=YAwB0fgof2slosWoTswIUdQvIM+2wImWO/XeDnQfVkvtzsE45u4aYaXikbI3zOMRDisKyjHWiqFZ22ucnONKhclFMDX+AjXYkK71Yu+FoXj9uXY56tJC+3SLS2MCEjEjLa96ceA4H6+g46Jrys4Ug3Z4GB1lD8TCPCwVg4AF5yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759987005; c=relaxed/simple;
	bh=NyomanVTpqyQ1athgjpja4UteoPBDmygfwQcGTjsddE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPpDomwL7BmnMm8jgT4QmItuacZjDoiBeHA2fFzLrh2uOkZ6L8bQ2X9gyVDOQ48A+ZWXQwLsTb0QcckrV4l+qjnYGsMRKtsPmnusmJnRPnwR5xNepwmg9pSglMFh5mUx0LPcSjSu4lMWryLtaEkZLUTSHyW34VUOBll5fjlbb/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPiKhc8r; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-85b94fe19e2so54305385a.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 22:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759987003; x=1760591803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyqb1CztMqi3UzPCCUo4PJPR7YENee+9JSUveio1sPI=;
        b=aPiKhc8rjAu58P+Ul2xL0nPluKiCR5SWY9eCbKQHHmlZyP+44o9MuQks87Da3zn4NE
         oS9mO/PAMvxCtC3UPmAPfG9T0LV2LynALXUUktdniLXe/Niv/WmFPOgJb/m2wrfrtLR+
         nDhUbl6NO8g/TbtFA49HoBhLvmuduyHCIFB2sf3fCzSndaPo+nasG9jxIbTsKB7qcJpO
         tTvxBYCMjBdJ1T+afZBhC759SYJbu9xO8dYMjp319R/9/iyjufxtuKA6gpD/U9Sp84JO
         6+t6YU2+hVjgVVp/ag+YVRNUK7Txa0kxezZZiQIOScCZePLRYgRufeY6UrRhzMglwjW0
         KyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759987003; x=1760591803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyqb1CztMqi3UzPCCUo4PJPR7YENee+9JSUveio1sPI=;
        b=XKAA/8m4H8qaY2z0yYOnMnKM/PiRWfmA5TC1POFW5rJpNUgCfOuGElXPRa959Poztp
         GY/5QRdJIrWmM0Nf75U4vkEuM6BG5kbVof51fJie1tETwSuO4cDYZLkVHLW5kV/8u3n8
         HJsCQfQvO4ZdOuXYMci0tHb0IlN1A8g/oOGYrX0zPIvfSBMLaAb5H3N61lsW1NsDaNoO
         qTxSTIYcA7hUzsYw94VF0GHxl4J7znuEmYtIJzTk/3fCYfQhjzMkNAkC/v4kl8hcwZAG
         rMsAOcDRxN5yDo3YShUaldRGWYR8+PJgVc06Eg9ss/DDhDupfMUoG7MM1IfXB7JoxI3h
         yStw==
X-Forwarded-Encrypted: i=1; AJvYcCWhhrs1E22X/toNS9iR9oEhPW6A/GRZzU5UF9SwCyH4hFwP5DL3/eEtoK0W7u0ZxNU86jfX8MIDBcrYP+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaZIrw4MeH5siqTr8jgxe74rmtWwNghvay2r4/O3E2qKWPaIfB
	RBSKPRmOnQwv5bAydMuNI+6+VAdzeCExs2tZeKDqf2mTrdVtmzfDpIv7yJOFNvywHrGFcH5Vp9l
	7tt9ad17OOuYK5L9FFNfYJ6tTxzrxWjY=
X-Gm-Gg: ASbGncv6njiWcUiEDYC3fKpHLfCEMzjTNt5AnzTrZRTaoF4BK1OKlE3KBWj7TnbHPwD
	xaGvdToRsimzYqolL4vSqI7oLOU2R6VVVcqznmMwTp4LCuvp2MAI9DOHDFM+QmEhrn8bbLqiiLQ
	uSNPeMUass+IpzQUTtvLqLHgc3NGNg41DDyqPQfbYdU2QGF/rjvAiygbGfYAyb2OSF09brA5V9y
	pYwcHDOL0ANuZvQINlcQbcHhzMp/2AfzfPJf8doQx0=
X-Google-Smtp-Source: AGHT+IH7cynlxmysIGXABGaRxHRjaSOMuEx+1JjoUFV9WJpw/MAcUpWK0V9ARSZ1SYD2oraMIpI9j58hrMErsazHIU0=
X-Received: by 2002:a05:6214:2601:b0:80a:7bd3:e61d with SMTP id
 6a1803df08f44-87b2ef6325amr77155716d6.34.1759987002596; Wed, 08 Oct 2025
 22:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929065714.27741-1-jjm2473@gmail.com> <20250929065714.27741-4-jjm2473@gmail.com>
 <d8ad476c-d0c7-4e97-9e76-540a539ffb52@lunn.ch> <CAP_9mL4ofig-X-w9wx1A5D_eVXROo6AVFBSwp4mh=kj7webpPA@mail.gmail.com>
 <7e219aef-88a0-4184-9553-30dcbc8dbd79@lunn.ch> <CAP_9mL6utQjN_2EZ4vs3K8jzcxHxvKWNTNEXZ9fAx4HuA=DNXA@mail.gmail.com>
 <aOVgid5q0_AhPXFB@shell.armlinux.org.uk>
In-Reply-To: <aOVgid5q0_AhPXFB@shell.armlinux.org.uk>
From: jjm2473 <jjm2473@gmail.com>
Date: Thu, 9 Oct 2025 13:16:31 +0800
X-Gm-Features: AS18NWCLtV0rRwWtVTBZ2YLKRiIGf1OTLHzIEDkTF7un8JPPGbserUWPiMMjbPw
Message-ID: <CAP_9mL5UbWH_hn0AHm=OGZ1_X7yY-W-XXxx3hXC7iPNzHH+q+w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, heiko@sntech.de, quentin.schulz@cherry.de, 
	kever.yang@rock-chips.com, naoki@radxa.com, honyuenkwun@gmail.com, 
	inindev@gmail.com, ivan8215145640@gmail.com, neil.armstrong@linaro.org, 
	mani@kernel.org, dsimic@manjaro.org, pbrobinson@gmail.com, alchark@gmail.com, 
	didi.debian@cknow.org, jbx6244@gmail.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Russell King (Oracle) <linux@armlinux.org.uk> =E4=BA=8E2025=E5=B9=B410=E6=
=9C=888=E6=97=A5=E5=91=A8=E4=B8=89 02:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Oct 08, 2025 at 01:29:57AM +0800, jjm2473 wrote:
> > > Vendors get things wrong, including this. 'rgmii' means the PCB adds
> > > the 2ns delay. Nearly every Rockchip board follows Rockchip broken
> > > vendor recommendations, and then i come along, point out how it is
> > > wrong, and ask for it to be fixed, before being merged to Mainline.
> >
> > I will try `rgmii-id` and rescan {tx|rx}_delay, just like
> > https://lore.kernel.org/all/20250925092923.2184187-3-heiko@sntech.de/
>
> The current situation is...
>
> https://lore.kernel.org/r/20240304084612.711678-2-ukleinek@debian.org
>
> Notice that the tx_delay and rx_delay are removed - because with
> "rgmii-id" the stmmac glue driver ignores the delay values.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

I  change phy-mode to "rgmii-id", and remove {tx|rx}_delay, it works fine!
Will apply that to the next version.

Thanks!

  Liangbin Lian


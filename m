Return-Path: <linux-kernel+bounces-886423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AEFC358BC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E041896292
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC973128B6;
	Wed,  5 Nov 2025 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TosDpwPb"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AFC24DCED
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343973; cv=none; b=PhgNUSrrbOEC9Vni4g9FUCwYBI2GVyrwXIl/z67kr6CRr3KYbM95YdRRZgV6QBQ74yD92rbwJd9DCwYHl2QIeOeF8fFub9f9XhcU37+ykjSUKZcMfbTpa+8zvBS0DZXudospsknFG+EW0NlYIyFbkZyie+sFDUNpJx2HN+bu4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343973; c=relaxed/simple;
	bh=6+3jnfjqn43oyAtQe2q78IhrxJm5fdTl7F8JDNsbcgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWtOLcQ9WEXTaohLZ/xj4uc2M9Totvb1fN2+ls3oNiZ0OCOoEQIIQMK7PKOrqVs6IEt7pou/75oPvtQc8v5Qq6wRMRdErf5C2y7GLfXjY1nqMpcjLMd+tLBEwIzp/YZQJZq71sV3/pMRhiYupytr52hctgZ+RXqOj17I5E/oGKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TosDpwPb; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so7421179a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 03:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762343970; x=1762948770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGA4yt8JGp+St6is/Io1asPfAbg43aJnzQEEcQdlRFo=;
        b=TosDpwPbqkLe/8dQSzaeZK1VpZ1JqDNj/D/gsLCgU8zAW/z8q3ghRezuEz47BnrSdB
         a3VrAOvVrRXtPFF/BUW8sNARqzk4Tmfj83//vBAFWRB/tGh94Zu7EwzbcLE0Wqs+oGBH
         P+gUaSC8RjmnCYl5/QhXNsNWARIdOfHGM+W9De8T3xUFMzgTO87P5NXkXWaOEXeWsxF/
         ociG1Dg6QUtlBKcXqkn6pKHJypdpYTxuZlm+cKm6B2Y4qO23viexKpOhWtBkl11h9sMB
         /ddYlnjHZqEwUosQO8yikybqyzPxb0fiqB47SkDSPnDnX5jn48qzPc/xizzwCXfnGrcN
         71HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762343970; x=1762948770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGA4yt8JGp+St6is/Io1asPfAbg43aJnzQEEcQdlRFo=;
        b=wtyyC4yu4HgffcGmltm1dW719RI2FS7TvdsKwWa0+T6mwHjTyK68ejvF2piYRtTt7Y
         0j2hrYB6PeVODU0r2W8b6r5S7h7eQdlxjhjWQQJsg9OJbcpI1hUJDDyvXRZdealWb25z
         34B9oXAtV2m6+5mDmG6aYwzwj+EVmrNBE+6HpK0OWIQ1P3lpYZ80e7Xzh2U8iQDhNdkA
         mLxhvXnp+tdhpZ8Umoj0BG66PnEeWmFejJRautbWYioJ66/mMrG19elYH1AAQCHJTO+o
         tEgrPD3mXZ9kQRukFEzga/0r+6TfwxJCR4autPZJS/brIEd1DNBTNI/mVfRtRfEtwZ2I
         2w5g==
X-Forwarded-Encrypted: i=1; AJvYcCVZ0wb2HADIt0RwT5d5vT8AOJzV6mhvgRT16XWSbOZh5jZkxRAUDXtCcJLXEvk5COii4UdeLJ7csiz4P1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk/uNlq9OS6pTmvsncycnZW/KJ27EilSEN2hnfyuwz793T/YjI
	t1ePndx1KRG0iNGGJllfF9Ne6dvn9ONc0Fww8NVebkiOiIvmC4KdReegwNBaPYAMw28vLqTYGvB
	Sgv/jTFVMePDt0i4/aMsZs+CIi1irFXuLoawy
X-Gm-Gg: ASbGncu2tRpMjLq+ldwa4KlwtplQ6ZV97W33v0KSi9FUyUA5Ph5dR4AjczVNd+JkqJ9
	/us7H7xKurCaYz6YLcH+E1NYeYoCTIMLnJ2OCDrTp06/uO/MxZsAO/R4B5B8TTQ4SlBjSMPjLuJ
	MU4NKO/meqzr7LMtmuNsV4f4VA0MhE8IIaHZO3ORj38jII3mxQiVJP8aZRD5w3keDL4vxjI5Sma
	TafjPX/ZXA6FyjUiunKBMNrRDJin7iF009Ji5BxZjbzbzOA7hZ1lihpc8I=
X-Google-Smtp-Source: AGHT+IHz+PW+hI6DHk/+yycP53/owJKFK51FLmbG3Xn9iePHYqTjIDevvgVm2fd1OHm0B5cu1KiyF7i4XCTMNvcSxeY=
X-Received: by 2002:a05:6402:50c8:b0:63c:1e15:b9fb with SMTP id
 4fb4d7f45d1cf-64105a4c967mr2540436a12.22.1762343970155; Wed, 05 Nov 2025
 03:59:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017073954.130710-1-cnsztl@gmail.com> <08911ae2-fef3-432d-a236-d820c9cb67ac@gmail.com>
 <5af928c4-4b6e-489c-ad39-26cef3dd7473@gmail.com> <10751338.nUPlyArG6x@phil> <e52de2b5-bf10-ce0e-66b7-66b1c46525f3@manjaro.org>
In-Reply-To: <e52de2b5-bf10-ce0e-66b7-66b1c46525f3@manjaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 5 Nov 2025 17:29:12 +0530
X-Gm-Features: AWmQ_bkTo815Ekf1XKwqKW52Tftmcvjv3vglHmEOmCXrknL0gcm_NsK2eBkal2U
Message-ID: <CANAwSgRXwozYr8sYtV8RRb1jJAb=9VNPfsLGMmW=f38XV-u=MQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: fix eMMC corruption on NanoPC-T6
 with A3A444 chips
To: Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Tianling Shen <cnsztl@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Grzegorz Sterniczuk <grzegorz@sternicz.uk>, Jonas Karlman <jonas@kwiboo.se>, 
	Jianfeng Liu <liujianfeng1994@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

On Sat, 1 Nov 2025 at 18:21, Dragan Simic <dsimic@manjaro.org> wrote:
>
> Hello Heiko,
>
> On Saturday, November 01, 2025 12:54 CET, Heiko Stuebner <heiko@sntech.de=
> wrote:
> > Am Montag, 27. Oktober 2025, 18:34:25 Mitteleurop=C3=A4ische Normalzeit=
 schrieb Tianling Shen:
> > > On 2025/10/20 12:44, Tianling Shen wrote:
> > > > On 2025/10/20 9:53, Shawn Lin wrote:
> > > >> On 2025/10/17 Friday 15:39, Tianling Shen wrote:
> > > >>> From: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
> > > >>>
> > > >>> Some NanoPC-T6 boards with A3A444 eMMC chips experience I/O error=
s and
> > > >>> corruption when using HS400 mode. Downgrade to HS200 mode to ensu=
re
> > > >>> stable operation.
> > > >>
> > > >> May I ask you to test another patch I just posted to see if it fix=
es
> > > >> your issue?
> > > >>
> > > >> https://patchwork.kernel.org/project/linux-mmc/
> > > >> patch/1760924981-52339-1- git-send-email-shawn.lin@rock-chips.com/
> > > >
> > > > Thank you for the patch! I will ask my friend to test it but he use=
s
> > > > this board as a home router, so it may take a few days or weeks to
> > > > report the result.
> > >
> > > Hi all, sorry for the late. My friend has tested this patch and it wo=
rks
> > > fine after 50 times dd operation. A big thanks to Shawn!
> >
> > So I guess, we don't need the patch reducing the speed anymore, right?
>
> Exactly, the approach of lowering the speed of eMMC to improve
> its reliability is no longer needed, thanks to Shawn correcting
> the DLL_STRBIN_TAPNUM_DEFAULT value in the above-linked patch.
>
> We just need to test does HS400 work on the ROCK 5 ITX reliably
> as well, so the previous lowering to HS200 in commit b36402e4a077
> ("arm64: dts: rockchip: slow down emmc freq for rock 5 itx", 2025-
> 02-28) could be reverted as no longer needed.
>
> > > And hi Jianfeng, I found you made a similiar patch[1] for the ROCK 5 =
ITX
> > > board to lower down the mmc speed, could you please check if this pat=
ch
> > > also fixes your issue?
> > >
> > > [1] https://lore.kernel.org/linux-rockchip/20250228143341.70244-1-liu=
jianfeng1994@gmail.com/
> > >
> > > >>> Signed-off-by: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
> > > >>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> > > >>> ---
> > > >>>   arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 3 +--
> > > >>>   1 file changed, 1 insertion(+), 2 deletions(-)
> > > >>>
> > > >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b=
/
> > > >>> arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> > > >>> index fafeabe9adf9..5f63f38f7326 100644
> > > >>> --- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> > > >>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> > > >>> @@ -717,8 +717,7 @@ &sdhci {
> > > >>>       no-sd;
> > > >>>       non-removable;
> > > >>>       max-frequency =3D <200000000>;
> > > >>> -    mmc-hs400-1_8v;
> > > >>> -    mmc-hs400-enhanced-strobe;
> > > >>> +    mmc-hs200-1_8v;
> > > >>>       status =3D "okay";
> > > >>>   };
>
You can also try this patch, which enables stober in the eMMC controller..

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c
b/drivers/mmc/host/sdhci-of-dwcmshc.c
index eebd45389956..62c9faf8ec85 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -77,6 +77,10 @@
 #define CV18XX_RETRY_TUNING_MAX                        50

 /* Rockchip specific Registers */
+#define DWCMSHC_EMMC_CTRL              0x52c
+#define  EMMC_CTRL_CARD_IS_EMMC        BIT(0)
+#define  EMMC_CTRL_ENH_STROBE_ENABLE   BIT(8)
+
 #define DWCMSHC_EMMC_DLL_CTRL          0x800
 #define DWCMSHC_EMMC_DLL_RXCLK         0x804
 #define DWCMSHC_EMMC_DLL_TXCLK         0x808
@@ -660,6 +664,12 @@ static void dwcmshc_rk3568_set_clock(struct
sdhci_host *host, unsigned int clock
                        DLL_CMDOUT_TAPNUM_90_DEGREES |
                        DLL_CMDOUT_TAPNUM_FROM_SW;
                sdhci_writel(host, extra, DECMSHC_EMMC_DLL_CMDOUT);
+
+               extra =3D sdhci_readl(host, DWCMSHC_EMMC_CTRL);
+               if (extra & EMMC_CTRL_CARD_IS_EMMC) {
+                       extra |=3D EMMC_CTRL_ENH_STROBE_ENABLE;
+                       sdhci_writel(host, extra, DWCMSHC_EMMC_CTRL);
+               }
        }

        extra =3D DWCMSHC_EMMC_DLL_DLYENA |

Thamks
-Anand


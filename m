Return-Path: <linux-kernel+bounces-746580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 009F6B1288C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34C31C87882
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E95D17B50A;
	Sat, 26 Jul 2025 02:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TidJWbF4"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92692E36EC
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 02:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753496229; cv=none; b=U6z3h3RocoicbjmfuaQrEVcwC+D16jbEHi3Dzo2O20hAPz7rkXqjfBcGCqptIuT47SzE/6HJUakytXUfjM2zpzjq3PQ0g3JKl0jbuLlCNaLh5aisy3vuMOFtF+H2f7FRAo6gMFEC1i5UwGvQwiRZg2aBVDMGbmezurmTb5unIGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753496229; c=relaxed/simple;
	bh=igyobYhgJ3GkWizx5L5OTMo4HXLtvj0jTcJendxMnPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2GopOTtdtwOkKiRErOPZrHdk/lSb778n9p+NM6DY+0KQgJuM8GKMDGLaFcxtNYTxc/CrRO29XoCNEEyOZOUilutJn1ho9I15UXfsxftN1gn9Mlkg1jSqlDdW9Wr9sxItNbeUD8kzeGQyQtIOQsVeUKmCUDZGmKjGLxQBbfHcNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TidJWbF4; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e3b483daf3so21403295ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 19:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753496227; x=1754101027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJgRjn3YLVk27IsToicnqn+k2tZqaAwGO0Yoq2mc760=;
        b=TidJWbF4N1vrJv3PuZFnxReKGyNKDixq8dgDbsY7E5P+9Q4MrFHb60oYW9FVD1n845
         zP88tEZ64ampYxS8T2ewrtrfvI3RwOrPhowO4xXqon1v2oYOTnR9PajWQFoLXWXxTvVu
         6AqHRAMUoRx7oiLzYPSHg4fG1Tp3EHVFslIXazE0NRJF7BkNXbJqmuxmBSXLhLxXOrLk
         SHHLiy0zGByePdoJHrZm6B0R/PDushWrUhtszlScfvO/GBMyL1IaCHlKbWRgES3/amDH
         bvU0DQmhJ1xgHlhwEQ2yKY0T6Ig51iJl2ehgXF2H2pnXubBIqDfIJJHAv3Tqh8OPYvTG
         ncfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753496227; x=1754101027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJgRjn3YLVk27IsToicnqn+k2tZqaAwGO0Yoq2mc760=;
        b=jDQCbLvfyGHBra7Oh7LxDEHFr4UZ53uoT9685iEXmioXA++pKTy1JT96wNtIaPl+c7
         BYskq9+NUOYcIbZ/xducB6bv7YoUAS042aZ3VI1VGMa4pd+Ilslpj41rnnWHFoiEdAMQ
         5zCx2RxWCkzy68Gp7wNYTd7rfMzb/Ckt8dF10lDSM5aKw7OwyEaeKSCm7sdXyPwZYyIp
         aBvvPMUSUuZydKmTclQLr0XV2kpaaMcOD6OvkVtKQT6assoNX2g+bj853uqnRzxa3K1p
         Op5/CWIamyfarx1vc+L126OI1FvTUpz+iQdyM06VcgZ3lTjkwXfQ9hGDXnE6Kz6hQlN8
         goPg==
X-Forwarded-Encrypted: i=1; AJvYcCWs6i2HyEeWamkXKeRZshzVAyNrQiHwUc8Dg//Cqu2YAAAr4Sh9Duter1EAOv4iqFXvYpSh1P4gQAvtNNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx00IKbQ3WP/PoWjlGbf4FZMBbUI0ZkeVcdS+sSuVitrUO+7l21
	1/dv/2qIlZn2crE/QcEIn8FE8dv30HP747K8pBshpUHRKStWQdM613RcaRCCVThQdB8C4zOXflx
	yis7dm7ClVjuOOu9/5J/xDSUg8mOcy6M=
X-Gm-Gg: ASbGncsg57G65XM60e9+lJLx7ILNRsXfQOfXYvvNhZC2XS6CQMbThUBp7sF4PaPWUnu
	2Wx7h62dP+o30NXvsUWIR36poteiA3vM/FM0yj39vCVWoV9n8AUtdWsXE7nFTqE0yYETI+rzgrK
	a028KHIn2w4x8Cb/MWKwzTayQAegz42S9u82A3kAZMpHIVwCzf263OXpvYqi1O8Sv/JKIIGhWr8
	0PT+IpfJ7Juh7fuA6/dEcd2TN9u4fBx1t74yF/GEQ==
X-Google-Smtp-Source: AGHT+IGwmJFA0QO/fTUC2Zyu0RWKQi3oIuYamLY+kFrPVbF9MIQZqt0msGDVa8Ev0WPFgIG5n+LMEFpLDjc+8Cxo9Y4=
X-Received: by 2002:a05:6e02:2491:b0:3e2:c345:17f2 with SMTP id
 e9e14a558f8ab-3e3c5226dadmr81617365ab.3.1753496226738; Fri, 25 Jul 2025
 19:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725070310.1655585-1-yschu@nuvoton.com> <aIOKeClm/vOPp4IU@lizhi-Precision-Tower-5810>
 <CAPwEoQNfdit9fOiUY-WzQvS377nEqBu=s8S1zqS7tdSZfQeCHQ@mail.gmail.com> <aIOfLYIVE8NkYTxH@lizhi-Precision-Tower-5810>
In-Reply-To: <aIOfLYIVE8NkYTxH@lizhi-Precision-Tower-5810>
From: Stanley Chu <stanley.chuys@gmail.com>
Date: Sat, 26 Jul 2025 10:16:54 +0800
X-Gm-Features: Ac12FXxQspcgwBj2DhIBGT3V55FvnqyU52l4Wl8p6U_oPpKwgo1g9sLEszoQdt4
Message-ID: <CAPwEoQOG3qt9APbk5ULOHmJer-tXNPcrK_u09km7ye2qoTZcnA@mail.gmail.com>
Subject: Re: [PATCH v1] i3c: master: svc: Fix npcm845 FIFO_EMPTY quirk
To: Frank Li <Frank.li@nxp.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com, 
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 11:13=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, Jul 25, 2025 at 10:50:34PM +0800, Stanley Chu wrote:
> > Hi Frank,
> >
> > On Fri, Jul 25, 2025 at 9:45=E2=80=AFPM Frank Li <Frank.li@nxp.com> wro=
te:
> > >
> > > On Fri, Jul 25, 2025 at 03:03:10PM +0800, Stanley Chu wrote:
> > > > From: Stanley Chu <yschu@nuvoton.com>
> > > >
> > > > Prefilling in private write transfers is only necessary when the FI=
FO
> > > > is empty. Otherwise, if the transfer is NACKed due to IBIWON and re=
tries
> > > > continue, data may be prefilled again but could be lost because the=
 FIFO
> > > > is not empty.
> > >
> > > why "maybe prefilled", please use certain words.
> > The original code didn't consider the retry case, data lost happen in
> > the retry case only when total write bytes is larger than FIFO size,
> > not always happen.
> > In the example of writing 17 bytes (FIFO size is 16), the last byte is =
lost.
> > 1. Emit S+Addr/W
> > 2. Write 16 bytes to FIFO (FIFO is full)
> > 3. NACKed due to IBIWON
> > 4. (retry) Emit Sr+Addr/W
> > 5. Write last byte to FIFO (data lost)
>
> You need descript clearly at commit message about this.
>
> >
> > I just need to prefill FIFO in the beginning to make sure FIFO is not
> > empty when HW starts transmitting.
> > So, this patch adds a condition that prefill FIFO only when FIFO is emp=
ty.
> >
> > >
> > > >
> > > > Fixes: 4008a74e0f9b ("i3c: master: svc: Fix npcm845 FIFO empty issu=
e")
> > > > Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> > > > ---
> > > >  drivers/i3c/master/svc-i3c-master.c | 11 ++++++++++-
> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/mast=
er/svc-i3c-master.c
> > > > index 7e1a7cb94b43..34b6e125b18a 100644
> > > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > > @@ -104,6 +104,7 @@
> > > >  #define   SVC_I3C_MDATACTRL_TXTRIG_FIFO_NOT_FULL GENMASK(5, 4)
> > > >  #define   SVC_I3C_MDATACTRL_RXTRIG_FIFO_NOT_EMPTY 0
> > > >  #define   SVC_I3C_MDATACTRL_RXCOUNT(x) FIELD_GET(GENMASK(28, 24), =
(x))
> > > > +#define   SVC_I3C_MDATACTRL_TXCOUNT(x) FIELD_GET(GENMASK(20, 16), =
(x))
> > > >  #define   SVC_I3C_MDATACTRL_TXFULL BIT(30)
> > > >  #define   SVC_I3C_MDATACTRL_RXEMPTY BIT(31)
> > > >
> > > > @@ -280,6 +281,13 @@ static inline bool is_events_enabled(struct sv=
c_i3c_master *master, u32 mask)
> > > >       return !!(master->enabled_events & mask);
> > > >  }
> > > >
> > > > +static inline bool svc_i3c_master_tx_empty(struct svc_i3c_master *=
master)
> > > > +{
> > > > +     u32 reg =3D readl(master->regs + SVC_I3C_MDATACTRL);
> > > > +
> > > > +     return (SVC_I3C_MDATACTRL_TXCOUNT(reg) =3D=3D 0);
> > > > +}
> > > > +
> > > >  static bool svc_i3c_master_error(struct svc_i3c_master *master)
> > > >  {
> > > >       u32 mstatus, merrwarn;
> > > > @@ -1303,7 +1311,8 @@ static int svc_i3c_master_xfer(struct svc_i3c=
_master *master,
> > > >                * The only way to work around this hardware issue is=
 to let the
> > > >                * FIFO start filling as soon as possible after EmitS=
tartAddr.
> > > >                */
> > > > -             if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) &=
& !rnw && xfer_len) {
> > > > +             if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) &=
& !rnw && xfer_len &&
> > > > +                 svc_i3c_master_tx_empty(master)) {
> > > >                       u32 end =3D xfer_len > SVC_I3C_FIFO_SIZE ? 0 =
: SVC_I3C_MWDATAB_END;
> > > >                       u32 len =3D min_t(u32, xfer_len, SVC_I3C_FIFO=
_SIZE);
> > >
> > > if prefill to FIFO SIZE each time, such as
> > >
> > > replace SVC_I3C_FIFO_SIZE with
> > >
> > > SVC_I3C_FIFO_SIZE - SVC_I3C_MDATACTRL_TXCOUNT(readl(master->regs + SV=
C_I3C_MDATACTRL)).
> > >
> > The free space is SVC_I3C_FIFO_SIZE when FIFO is empty, no need to
> > check TX count again.
>
> My means is that if use above logic, needn't check helper function
> svc_i3c_master_tx_empty(master).
>
> Does this method work?
>
Thanks Frank,
This method is another option that also can work for this issue.
I will submit version 2.

> Frank
>
> >
> > --
> > Stanley
> >
> > > Frank
> > > >
> > > > --
> > > > 2.34.1
> > > >
> >
> > --
> > linux-i3c mailing list
> > linux-i3c@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-i3c


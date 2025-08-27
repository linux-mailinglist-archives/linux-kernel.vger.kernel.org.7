Return-Path: <linux-kernel+bounces-787444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F8BB3764B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F8A1B64D01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DCE1D63DF;
	Wed, 27 Aug 2025 00:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yrpw44kf"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4741BCA07
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 00:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256056; cv=none; b=o3HNrR7mR/SbpMBdF7zuNSwGB09Mp5cn4T5QV4Y7/Z4Bql0atvpOpo0rbujFxmuAPXlxTmR8QMFLzuMctJWRt+2LNtwk2J7zfmchIBSBsG2U7rw0ZTK4kl5CXY4TnIqSyYIqUHiG2t+uKaZoYXCYEq9OvhDLJzFJWWRbWPAVtt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256056; c=relaxed/simple;
	bh=nbCCJUMuxZzMFJOkqonwYJqWl5/yggxfoAW2BjWM+BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+Q21oCHWn9nmvFavjEKRh4XXSx3oO873pakjQ50weqQd95u1S2X/2b0gAJVqE2T2TVDdaDnK5/Ta2+hqhHDRx8u5+RO69A+oaNWMbQZMTXXSb2Wh7zosmmbwBCoU1VNBorYzDYNbT0KNTEfhACKpltPTX1ZyvDQlUnTrwXdNVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yrpw44kf; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ecbe06f849so14977885ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756256054; x=1756860854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEIQA4mupE+uey3jxAag4GNaEioXiVaRcLVR2T8bg3I=;
        b=Yrpw44kf9doe2YUbLYAUZauMdgNHzlFuUD3SthtE3Qb604gkCyM4GfK03NbgEupNGq
         lg2C7/lLN18D2YnAA3msbvd5K/lHh/KTR3YXawjbvVh9MitMOHDAb0ggZTdG5f4NS2hm
         doZRX3h+SJZ4P7ll0CVKBrqnx/OQ/FCRmIIw7CY4pOR0NgYo7rRK2LY/F1fsOqWEJeq5
         HM57JwbliY7r2UbNyFiikC6ga0MjWsskUwoN3T2th4YPZ/LecV04aZCCo6ld5zNfQTY3
         ZF8ltcZEDh8qLlkn/5u80CiDxMZLv0aUJ9AV9D27su4nij/TIBhHiziYHJGhkFdwyj2S
         pgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756256054; x=1756860854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEIQA4mupE+uey3jxAag4GNaEioXiVaRcLVR2T8bg3I=;
        b=Kk7IUHVYExpNykGHw9TCk75J6h+GOPBpgxyMYmlvk84VqhIg+CFGlW+WQzLRfJgY5K
         0pAw4HsrThCPjq/RKPGwcY3s/L31qKHdjpFzjwvIsC6KJSKFNX4zfDCMJXSvIlvjyAt4
         uMlUtikpGVoFXDCzYHa17TPRV5dTGQGvp42DB10ydlcHDszl3eEL4JJJ48Lgb+HeK/Cj
         VaRC7XciNMqWIyYxWHGybtc1hhc4R44QTc2m+cLYAXulf5XjBaJQIlyjVE74VfteK3yW
         eH8G1SiMBH2ijTbfnXMcO78R+PXx/6WtSj82bDlT0ZnkZo8YLvYcZ1i9sPav2J/iiGHr
         Z2yg==
X-Forwarded-Encrypted: i=1; AJvYcCXUvNQ2aQH05ifB70lU4xKASyu+7jEdF8UEcMqtDHGms7U4WsB/q4sPB+b0IORYTBnJsuwVO+bXyoukW2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhrNcywfKl2o8epJXvOgjKXfG3v1auFSLEOHeFguoHUrPm/jx9
	pqHCPavTWmqlphr2f6x76MGUuzfRMsLoCr2Qi6zrVFHzJNysWCu7QMTWcOqvhEHZqSAo8KUJd06
	2tddkTuCsFZzgpggx4P4kDkMDbbpigOY=
X-Gm-Gg: ASbGnctM/FbPPfj3bZcEBM7uWxUdnSV95xqymNB4p1JrLVM4RFKtt/ObAilSN0H8kx4
	wsB7EcuzFHBHhR1A7uApYQGUgsIVT5cbnSiXcVPLkfOFczvnGplrh9ZY5HTOMhCd89jEciAG3Vu
	Woc6qsfLunWhsaiERdeOR05pGu5RxviNXMgSpNRheeTebEf3wEU6Drztnd+/XmB0c0TJ2JjQkwp
	5VXBQ==
X-Google-Smtp-Source: AGHT+IHMa860sVvmP76YYQV08GUqofysOvoW1SKEDan/KYfRDqnrDrIQVLrmma7U62qXIljn4z3FZRh57lr8FaNRmmA=
X-Received: by 2002:a05:6e02:1a62:b0:3ec:2c8a:f34 with SMTP id
 e9e14a558f8ab-3ec2c8a1665mr135187095ab.17.1756256054394; Tue, 26 Aug 2025
 17:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819090831.3009647-1-yschu@nuvoton.com> <aK3eHkf31uIw04EH@lizhi-Precision-Tower-5810>
In-Reply-To: <aK3eHkf31uIw04EH@lizhi-Precision-Tower-5810>
From: Stanley Chu <stanley.chuys@gmail.com>
Date: Wed, 27 Aug 2025 08:54:03 +0800
X-Gm-Features: Ac12FXzme2BffR6ENnicTn8cdJJfQlkMXwuqX08H-q-6u-JN8e4csUHUF6z_dcU
Message-ID: <CAPwEoQPnxW2jRpcqE_QSW2rNm8-zHfkTF=Ns_w7szYj-k3bTXA@mail.gmail.com>
Subject: Re: [PATCH v1] i3c: master: svc: Use manual response for IBI events
To: Frank Li <Frank.li@nxp.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com, 
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 12:17=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Tue, Aug 19, 2025 at 05:08:31PM +0800, Stanley Chu wrote:
> > From: Stanley Chu <yschu@nuvoton.com>
> >
> > Using IBIRESP_AUTO causes the hardware to ACK IBI requests even when th=
e
> > target is not in the device list. The svc_i3c_master_nack_ibi() has no
> > effect in such case.
>
> how this case can happen since default target's IBI is disabled. Need hos=
t
> send IBI enable command to target devices before target pull SDA lower.
>
Hi Frank,

This is to explain that the original code svc_i3c_master_nack_ibi()
will never take effect when using
AUTOIBI with IBIRESP_AUTO rule.
        /* Handle the critical responses to IBI's */
        switch (ibitype) {
        case SVC_I3C_MSTATUS_IBITYPE_IBI:
                dev =3D svc_i3c_master_dev_from_addr(master, ibiaddr);
                if (!dev || !is_events_enabled(master, SVC_I3C_EVENT_IBI)) =
{
                        svc_i3c_master_nack_ibi(master);
                }

> >
> > AutoIBI has another issue that the controller doesn't quit AutoIBI stat=
e
> > after an IBIWON polling timeout. The following sequence is the case:
> > 1. Target pulls SDA low
> > 2. SLVSTART interrupt triggers the IBI ISR
> > 3. Target releases SDA
> > 4. Driver writes AutoIBI request to MCTRL
> > 5. SDA is high, so AutoIBI process does not start
> > 6. IBIWON polling times out
> > 7. Controller state is AutoIBI and doesn't accept EmitStop request
> >
> > Emitting broadcast address with IBIRESP_MANUAL avoids both issues.
> >
> > Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> > ---
> >  drivers/i3c/master/svc-i3c-master.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/s=
vc-i3c-master.c
> > index 701ae165b25b..17644e041b44 100644
> > --- a/drivers/i3c/master/svc-i3c-master.c
> > +++ b/drivers/i3c/master/svc-i3c-master.c
> > @@ -517,9 +517,10 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c_=
master *master)
> >        */
> >       writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
> >
> > -     /* Acknowledge the incoming interrupt with the AUTOIBI mechanism =
*/
> > -     writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI |
> > -            SVC_I3C_MCTRL_IBIRESP_AUTO,
> > +     /* Emit broadcast address for arbitration */
>
> Need comments here why Request_AutoIBI not work. I think it is IP design
> defect to make REQUEST_AUTO_IBI useless.
It is not an IP defect. Per spec, AutoIBI emits a START with address
7'h7E when a slave pulls SDA low.
A SDA glitch (high->low->high) can cause the controller to remain in
AutoIBI state.
1. SDA high->low: trigger IBI isr to execute
2. SDA low->high
3. IBI isr writes an AutoIBI request, the controller will not emit a
START because SDA is not low.
4. Finally IBIWON polling times out, the controller remains in AutoIBI stat=
e.

>
> Only concern here is that svc_i3c_master_ack_ibi() need send in 100us by
> i3c spec requirement.
The function svc_i3c_master_ack_ibi() executes promptly in the IRQ
handler, taking much less than 100=E2=80=AFus.

---
Thanks.
Stanley
>
> Frank
>
> > +     writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
> > +            SVC_I3C_MCTRL_IBIRESP_MANUAL |
> > +            SVC_I3C_MCTRL_ADDR(I3C_BROADCAST_ADDR),
> >              master->regs + SVC_I3C_MCTRL);
> >
> >       /* Wait for IBIWON, should take approximately 100us */
> > @@ -539,10 +540,15 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c=
_master *master)
> >       switch (ibitype) {
> >       case SVC_I3C_MSTATUS_IBITYPE_IBI:
> >               dev =3D svc_i3c_master_dev_from_addr(master, ibiaddr);
> > -             if (!dev || !is_events_enabled(master, SVC_I3C_EVENT_IBI)=
)
> > +             if (!dev || !is_events_enabled(master, SVC_I3C_EVENT_IBI)=
) {
> >                       svc_i3c_master_nack_ibi(master);
> > -             else
> > +             } else {
> > +                     if (dev->info.bcr & I3C_BCR_IBI_PAYLOAD)
> > +                             svc_i3c_master_ack_ibi(master, true);
> > +                     else
> > +                             svc_i3c_master_ack_ibi(master, false);
> >                       svc_i3c_master_handle_ibi(master, dev);
> > +             }
> >               break;
> >       case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
> >               if (is_events_enabled(master, SVC_I3C_EVENT_HOTJOIN))
> > --
> > 2.34.1
> >


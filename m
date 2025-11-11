Return-Path: <linux-kernel+bounces-895581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCC7C4E528
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AC314F07C8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A20A32827A;
	Tue, 11 Nov 2025 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyVH4sxN"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C9931195A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870263; cv=none; b=rabNAkJHGBkO4vwgitrG5f9hkk1xxDFIcyfPYzdCHFRbFIHRre65BqVsolNcBxyuyTvNff0yxVhoScoCBdLZtrKQxxrzJAlxztLgVorqPM76WBUQhTC77Id+PmL0CzRghqqdBzzGaxNHFU7jlqUlG8m46s0b+wR9G0FYXbWV6W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870263; c=relaxed/simple;
	bh=Wq9fyBoDFGXqHiJdhh3nryyd8f36FPRsS0VIkxdNrm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmLfJ65K0LD5ubxNTgcQAkK2hwIvbWWdAhr6Mbe0TKrFIqOLZXE012F1QdF6/A5y5qGCyVEDkN9rzCGb1u0h2BLatSYGNaaBNaqZJY4ubYVeUBwiIawQOg86kgkArk+ihI09sMbhQR6JUHRO5i2c6omSVI2ElCJAOh4vnMvpa1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyVH4sxN; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3e2d1477b9cso2329455fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762870261; x=1763475061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txdEdm40JEr5pC5+2I7HwpHNOaO4GAfSSqE8ztv0UX0=;
        b=dyVH4sxNdvVGDhKIqApGJKsO7lBd1NrwZRIfdyiRkAUyo4huX7tlI6vRg11Z75Sjiq
         vOlM+j/lqqx3nR/Ze3tsYnYW9Iog+TAbVrKDteO8ZgipDz5WTG0ipiK4o5vH0OPgDlD9
         a/26q4JZqEf592zU1tELRIXv8wZKjbbil137jvxuqa8ei5ZWIT8f4TfsB6iMm9y+u4ds
         r7JmMusGSR1g8cTQkbM/FOQ8YuhXOp0e86BYmCM+kZtFDGWA9R8VgJHlIpNIiBoDP+T0
         2jQGqp9Ad/TXsFq1QIlR50RHRGuXRNsT/4dpUr80PzASBr68cVETIfhm/rT1MVRg8mAo
         Rb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762870261; x=1763475061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txdEdm40JEr5pC5+2I7HwpHNOaO4GAfSSqE8ztv0UX0=;
        b=dnaH7h4trn/pkO8BBhxXjuwUt+fIAjhcrcWCDOeDaChdxYSTxoVT4RkVjEm7RF3/+o
         JTsyrXeMWeP87/i7cO/9GfBlRnU3Rs0EKGSbfMH2QICWc2fDoUxa6FK//fKVaAsb4HLt
         ksaUPjLiQp4ewUgAmkqvnwxFl6GXTEGAQLMB3biWOeJrac5LB2SL7spPulqGpXfIuMDK
         6mdH4rX7cTdTix0uq33NQ3JHWp/TcXj0IfG6LcKdFrLYicbEJt45yeviJPnywGYzuxDY
         EYlw5kWe3V99uvz3rKcckk7pu51PP0fWEz/81AoL22saFugGmEdD847YKvG7nEa1A/cD
         bRMA==
X-Forwarded-Encrypted: i=1; AJvYcCUFbb0JnzVlLPnBmXAVFlfNPNi4nHxT8Z//KRgjIrJsLUKf83645Pjwez16Y5l4dt8a30qO+6vx0TevkgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtg15y2G0DCKgwsCVYz1kfkbnUWEp3zT2c2ebABF3BYPgc2k+8
	VBazG4UD3VHqeLjJMXdJAlmK+kLvMNmB+zdEa01mMbm3XvQY6cdo2wfhl6oDwDI4u59HbRxbk0s
	Lqj7QwOhXc34QMrILWRVkdVIa4txQ6aw=
X-Gm-Gg: ASbGncv+hTbBPZ5TgiQHg8wkxH9rgkE8hxNapBsuOx2/djXO0H9y/SsuViSVAEj08yx
	EfL+LGIxXCY8i423mOrs8DaqY13P3+jbFICvn1sPqCl0arDkcUJEoWRIlZzCn6SD2HrAt45qZtq
	Jer5OuU9t4o55XwXgdhm4N40V5xZHCXVyY6I6tz1UUSkDi5B4VlOUuwYGQ2kGqhLLQCihyfBXYt
	nfwUYrEEDom5k+3/XSK/EvbIUASOG4s0cfhKtnYLVvCqV429R6Nqm1GOI+hiyiXEeZoFTgM
X-Google-Smtp-Source: AGHT+IH9NsGeAGXbfrkGaLkI4eT/HyQdZyA7+2QW2Tz3Nh3t6elSCgFx6DzEmvDROMRAAY0dK1BfQ/UaepIHAEj/9uQ=
X-Received: by 2002:a05:6870:899a:b0:3d4:760f:544b with SMTP id
 586e51a60fabf-3e7c294ab31mr8000185fac.46.1762870261279; Tue, 11 Nov 2025
 06:11:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111134400.5258-1-sef1548@gmail.com> <aRNBak9Xl_wsBJ6w@lore-desk>
In-Reply-To: <aRNBak9Xl_wsBJ6w@lore-desk>
From: Nick Huang <sef1548@gmail.com>
Date: Tue, 11 Nov 2025 22:10:50 +0800
X-Gm-Features: AWmQ_bkn9vJFX_qKrlLafWMdsY1_qiyP8xv9zY7kAo8K6GWks1Gw41ZZnCWDwno
Message-ID: <CABZAGRG-7T2mp3UYRaJ5c7eTi1B4hWybtJrfPwdo2aSEvhcMqg@mail.gmail.com>
Subject: Re: [PATCH] mt76: connac: remove unused reserved field in gtk rekey
 TLV struct
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name, ryder.lee@mediatek.com, shayne.chen@mediatek.com, 
	sean.wang@mediatek.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lorenzo Bianconi <lorenzo@kernel.org> =E6=96=BC 2025=E5=B9=B411=E6=9C=8811=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:00=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> > The 'reserverd' field in struct mt76_connac_gtk_rekey_tlv was unused
> > and misspelled. Removing it cleans up the structure definition and
> > improves code readability.
> >
> > Signed-off-by: Nick Huang <sef1548@gmail.com>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/dri=
vers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> > index 27daf4195..28cf46a5f 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> > @@ -1681,7 +1681,6 @@ struct mt76_connac_gtk_rekey_tlv {
> >       __le32 group_cipher;
> >       __le32 key_mgmt; /* NONE-PSK-IEEE802.1X */
> >       __le32 mgmt_group_cipher;
> > -     u8 reserverd[4];
>
> This field is used to keep the struct size consistent with the fw one so =
it is
> expected to not be used.
>
> Regards,
> Lorenzo
>
> >  } __packed;
> >
> >  #define MT76_CONNAC_WOW_MASK_MAX_LEN                 16
> > --
> > 2.48.1
> >
Hi Lorenzo,

Got it, thanks for explaining. Makes sense that this field is just for
size consistency.

Cheers,
Nick Huang


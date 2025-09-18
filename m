Return-Path: <linux-kernel+bounces-821971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B85CB82BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35584A3B96
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1667B217F35;
	Thu, 18 Sep 2025 03:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8El9c89"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A802C176ADE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758165395; cv=none; b=Blv9zG3EYZiQywi90pxY7q97W3NDrexjuuDXYrPirfeoW2tX/Obb4onlfYOdup8lNalgPh9574yuQy8zQJ2dcQh/z/t+gnZKBSMXly5uWD3vL5uV9kckUhD8E07xln9mu+C1eZcZjKDEYMCi0ptg/YL6VR6/9LSm/0T0rKuoMxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758165395; c=relaxed/simple;
	bh=npJn/dQ+Xd/IPDNtpwcQp+GICYLo8gdiB+4vh9mgxbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrDiqPK0O848UJaaIlIjAKwCJzaw5FYUFSmzKG+Cqq75mDdB2/4itY/g+Gzv9nwrxqiyMzro0tgeGtTEtJtptLJ21nwQuZk5VGC06usWj+4pHbHkjLJ/Xrf95vCXY+eNwma1sVb+MJm0QvAbUxOE3KmCFict1Uh13OIv14/Lm98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8El9c89; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62f0702ef0dso3072193a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758165391; x=1758770191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqtheR4wlZ9O/7gYx6fou+3S7q/CTsHieCqGSB995as=;
        b=a8El9c89OVraultZJf72WqnosLjJlxZ+EqXdywI3IJES1scNLfpzmV66QiVug8ClMJ
         GFgedY5nl9tQXTLV0My66plfthyPU/DfpnJJy4KlausG744nDns1LLdmV0/bduRtG6K9
         lB+D063DXLMtNLm6OdFGQxMTAoxfEY8VNvVVWcdW30dubsGfk0ckrmQQhW5Qmb0CjV0O
         RMXlzLScIlnVqMpPSfRc7hK5tudaQIx/m3wFBagYE5M5vB8B7rez6/GWWjx7XHLy5tTC
         o5WOjM0s06BCg5op1YOzKmXS+m4dCG6/Pe74cJE/tbFbcxA/K1EyYhHjMBRnLI8RZt4w
         251g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758165391; x=1758770191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqtheR4wlZ9O/7gYx6fou+3S7q/CTsHieCqGSB995as=;
        b=OelVJ2LsgrPBNzqVawo7kVK9nZDhYU0S+PSpEvG2w32uY/gG7qICb4M+vmrO31ysXh
         xNIJjslyVJJv5HQI5x8Mj1zu4Rvh29HM3umpzwui++yG+60MGxiieBas511H1AVK0kwi
         5BcwvNbh4OAqTWu3SKc8car7zMqLbixFMzRNVZ2PScfwv4wsNFB1xBQifWUunqNtcXt2
         saInTBTlxlJggUHbvuSfIcNiSSfVNAcm5OMz7PwspEJ37cbXB2BG1Ts6FL0pKJILqR/w
         Job3rsLYbYZrmEVIkT7DMRlmye96v2Gyt2+v2cxcLmnF38mpGnzySlg88T7xpDkV8RIL
         sReg==
X-Forwarded-Encrypted: i=1; AJvYcCW35BaGCgPL5HnAPDae2XrJRA2PNzeqBcbXoHylRbZAIrw+YMI2CLUYj2jHtYHCEpdKNZbsFr99pwgoR2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsobGQmKBERTgYR8juMIAiga1FdD2eotwRpUcBxU12fNjGNK3A
	mnXr2uB3mvk7drrcU8c3oRUhVaLNDSM1kwdVVw9W251OJhq0T8yWA5NZTvXvH3IH/Pw8Zl4URZ4
	IkcFe8bAKubh+7UxMX9r3zVNtSwzB8UY=
X-Gm-Gg: ASbGnctz49UhKSQ5dEA47tHrjNjHyXTFgUzMLDih/utS2mV1OMRy169hd8BJCCt0y8G
	CinxGUc0Dk72tHYv9VdYULB2bHmskyZnS/zfEdNNqdrOlq697XxQELnqxAtvvRzdq1oiEgYSB8N
	dbhcpL7feUUAUCSbhJVN58J0ueflJn5s0ali9vP1TrJKN/+U1fCV18K6ww4qPA8fVdwpvQfx4fq
	ou6S/VicHUomgjy6y294Unykh3QxcsrJuwL
X-Google-Smtp-Source: AGHT+IGcwnmFIhcAMhekBQ9Csbtm2KBwYd+IvWRSs6bThMpRF7oE7D7pBPctsa852qoDNH4x4lRvH1nM+zkO+sVrOFg=
X-Received: by 2002:a17:907:2685:b0:b0e:d477:4978 with SMTP id
 a640c23a62f3a-b1faf817706mr161465166b.32.1758165390737; Wed, 17 Sep 2025
 20:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJy-Amk5UTE2HN_Pcd5kbvCsa247CZ9sSMNX==itXeJkWuj-NQ@mail.gmail.com>
 <20250917110956338Wld0_KzYq21PXolbufuNn@zte.com.cn>
In-Reply-To: <20250917110956338Wld0_KzYq21PXolbufuNn@zte.com.cn>
From: Alex Shi <seakeel@gmail.com>
Date: Thu, 18 Sep 2025 11:15:54 +0800
X-Gm-Features: AS18NWAk3VZxovz2PZvQXlnhmoSZRX1fgsvWg7Jlofkyifb8onmjTFPYMm-zXdc
Message-ID: <CAJy-AmnK2fFJeoRzUXp7tME6HVYeGJreuXLSecnQLAr=SNzE5w@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Docs/zh_CN: Translate filesystems docs to
 Simplified Chinese
To: shao.mingyin@zte.com.cn
Cc: alexs@kernel.org, si.yanteng@linux.dev, dzm91@hust.edu.cn, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yang.yang29@zte.com.cn, xu.xin16@zte.com.cn, yang.tao172@zte.com.cn, 
	wang.longjie1@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<shao.mingyin@zte.com.cn> =E4=BA=8E2025=E5=B9=B49=E6=9C=8817=E6=97=A5=E5=91=
=A8=E4=B8=89 11:10=E5=86=99=E9=81=93=EF=BC=9A
>
> >Applied! Thanks!
> >Alex
> >
> Hi Alex
>
> Thank you for your review!
>
> Previously, Yanteng gave a review suggestion.
>
> https://lore.kernel.org/all/e0233785-b3da-4bd5-a37f-cf4704c49744@linux.de=
v/
>
> Additionally, I also noticed that the header of this
> patch lacks a fixed format.
>
> https://lore.kernel.org/all/20250826190719682yrVrd5e1DHRXx0-XjI19Y@zte.co=
m.cn/
>
> I am preparing to send a new version to fix the above issue.

Good. I have picked v4 on
https://git.kernel.org/pub/scm/linux/kernel/git/alexs/linux.git/log/?h=3Ddo=
cs-next,
could you do me a favor to send a fix base the branch?

Thanks

>
> Thanks,
>
> Mingyin
> ><shao.mingyin@zte.com.cn> =E4=BA=8E2025=E5=B9=B48=E6=9C=8826=E6=97=A5=E5=
=91=A8=E4=BA=8C 19:12=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> >>
> >> translate the filesystems docs into Simplified Chinese.
> >> v3->v4
> >> resolve patch damage issues.
> >>
> >> Shao Mingyin (5):
> >> Docs/zh_CN: Translate ubifs.rst to Simplified Chinese
> >> Docs/zh_CN: Translate ubifs-authentication.rst to Simplified Chinese
> >> Docs/zh_CN: Translate gfs2.rst to Simplified Chinese
> >> Docs/zh_CN: Translate gfs2-uevents.rst to Simplified Chinese
> >> Docs/zh_CN: Translate gfs2-glocks.rst to Simplified Chinese
> >>
> >> Wang Longjie (2):
> >> Docs/zh_CN: Translate dnotify.rst to Simplified Chinese
> >> Docs/zh_CN: Translate inotify.rst to Simplified Chinese
> >>
> >>  .../zh_CN/filesystems/dnotify.rst             |  67 ++++
> >>  .../zh_CN/filesystems/gfs2-glocks.rst         | 199 ++++++++++
> >>  .../zh_CN/filesystems/gfs2-uevents.rst        |  97 +++++
> >>  .../translations/zh_CN/filesystems/gfs2.rst   |  57 +++
> >>  .../translations/zh_CN/filesystems/index.rst  |  17 +-
> >>  .../zh_CN/filesystems/inotify.rst             |  80 ++++
> >>  .../filesystems/ubifs-authentication.rst      | 354 +++++++++++++++++=
+
> >>  .../translations/zh_CN/filesystems/ubifs.rst  | 114 ++++++
> >>  8 files changed, 984 insertions(+), 1 deletion(-)
> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/dnoti=
fy.rst
> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-=
glocks.rst
> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-=
uevents.rst
> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2.=
rst
> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/inoti=
fy.rst
> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs=
-authentication.rst
> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/ubifs=
.rst


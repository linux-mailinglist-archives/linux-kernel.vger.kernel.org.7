Return-Path: <linux-kernel+bounces-825552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1E5B8C37A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12203B6BE1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 07:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9362A26E146;
	Sat, 20 Sep 2025 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JynfH7aj"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142523A58B
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354638; cv=none; b=Wf0/tnVHSeJMbZcVCvlel2OZwdZn0Hcl+PHAg7m1zlN5IDJ1cNWvjKQfT9XpA0RIYXDpBHN4r+kfGr6vlvpnxprMFJm55zXDIJ0kNNaqiKAUBTQRBTRViAgJhkJ6GEz5oBCfA69HCi5udUq00czDju2oqTiFkR44nEVUwiKmaK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354638; c=relaxed/simple;
	bh=qmpkTUzydRQujIKnBGKdiN+Ji++u8QEmHCc0F/vPKUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBf3zQFJUU0/p4edLIvblGy0oVGR26/Too8C8b/X0X8cKgYHdiRunWaGjy8CFMD48CyUo4UDOVkdy8oulyoZqoQKie63gPLMkg6SiyelszHrOIGQPIZq6RYqC75iMJ7HJ3fLZA9e9o7+KJduJKHJKrmJfc/3rvYe+yoW/oQjKho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JynfH7aj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b07d4d24d09so468471066b.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 00:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758354634; x=1758959434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knrhMCywQQbRVUMOa6NYTtOeTCJV68hMiq9CpjYL5Ig=;
        b=JynfH7ajbCH3+wXOVxcC3gwazdpDg/wQdqWKCeUJk+rlfosl/0CyhdpTl+H1yky5xX
         tDwre3Yu5j5VH9PWWR/oprAXnkY92tibTgwXO/GGLz9ocN2CwdEsJOPgnD5cJvHtcDfF
         f8RajvN3QIVlKPYMj7W8mlgpmZqNPb7q8l6qamk3uCdLmgD1pGNY7FhWHrFTscrbVg5l
         9PbMioQse0BZfUAueLhA4XCQHFJbfgYcIGbIck9CTZrbh3P0n94LGKFLFFqDmIT+toA2
         GL7J/UljRDAuUcbOD5C/BIePlg3xRdURqOxRagDCVxQNe8+LfymS+gCNJveDbUQpjiia
         Nhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758354634; x=1758959434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knrhMCywQQbRVUMOa6NYTtOeTCJV68hMiq9CpjYL5Ig=;
        b=WV+5vWzgQvbeUYSpYrq6iX7J5j2rgW09+sRQ7vnqenSvgeGrl++WiXjpXk0bOR3bcv
         3tgOIKtuVZLt4+5ibMjcx6O/sg4KD8AeMCwKRNbTwD7yR+koEb/nKe6C/K7x5GOsbOEz
         2yd4t9GKU9qELGKhWkXGPPiIZltxFG5/xekxTGLytX3qa1A2qgVaNyJJ691nYgfVaH/q
         pXjtT58wi0vs5aeaUF2NabKcPi5VhJ9WbV/JCkJIl0Dwv9Phx9xRuEV31Xx0MHx9dI4C
         9UyIIn1IpeFBlCeEaX3OAH0UjEyBX8JLtoWnMh/rp0Sp8Ad7XKfrHGOvxWDJ3OQSHVeT
         3kZA==
X-Forwarded-Encrypted: i=1; AJvYcCUFsDGF420eziPCnalNH1Lj8Vx1iN6w9duGbnC89Jf2HT3+RUl2CSIagq+IQLHZkpkRL2o2/WpREoaAgi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi2zZLahlELqJJyoLLUFGyJcCVUKHx0aEw9vajP9xlz74KMj1a
	pl1yO9S745sen/8I92nD4DUyotUwmILqU72AwtgYdFC5fF+H3kQHXQZG/QyCxmfgCl+5junmTZE
	7BGaqv/dFTdP86/41lZNbzwEcZ99EBAI=
X-Gm-Gg: ASbGncsyEm6Ah3uc0r8m4jaE6D3ZUeJXxjm7XTBbh2aD/MMo0RqdP/VVRRt40LZRPoS
	nK6sXzxZxM74e1rs79+ZJvHYkJufEWuy6xwFaY1lw42qob6c2vsGnrGsKNBXnk3Zghn2h8gLmOc
	VGIyu3u9s6NZDUyoTlGC6i1nV+V+Py0Ut/o85Gm2+X2NtgEUAvq6OYv2cr9BoSAHCWPNSM60Iba
	2qqgKU=
X-Google-Smtp-Source: AGHT+IHmG1fxyCSJTQF/lVZDDieCsvChFigTVcILMjcYaPs1hBu7xmp9rm6MWNpYRtLeq9vcyYIobarHjZM0ACSqzJ0=
X-Received: by 2002:a17:907:3cc9:b0:b07:c715:31 with SMTP id
 a640c23a62f3a-b24f5f3097cmr625719566b.65.1758354634061; Sat, 20 Sep 2025
 00:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJy-AmnK2fFJeoRzUXp7tME6HVYeGJreuXLSecnQLAr=SNzE5w@mail.gmail.com>
 <20250918160701503LAL5d3yUvPccri9n1foeC@zte.com.cn>
In-Reply-To: <20250918160701503LAL5d3yUvPccri9n1foeC@zte.com.cn>
From: Alex Shi <seakeel@gmail.com>
Date: Sat, 20 Sep 2025 15:49:57 +0800
X-Gm-Features: AS18NWCndUXQ50dMCXwNE8epdcyfCdXUNYuQDgeFiwJDWXpwFBoSoRcCzVwXjDY
Message-ID: <CAJy-Am=wsBOC9QH4A_-784KZF3L8D6-s1Yttp62viwAoQ8G4rA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Docs/zh_CN: Translate filesystems docs to
 Simplified Chinese
To: shao.mingyin@zte.com.cn
Cc: alexs@kernel.org, si.yanteng@linux.dev, dzm91@hust.edu.cn, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yang.yang29@zte.com.cn, xu.xin16@zte.com.cn, yang.tao172@zte.com.cn, 
	wang.longjie1@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

All applied, Thanks!

<shao.mingyin@zte.com.cn> =E4=BA=8E2025=E5=B9=B49=E6=9C=8818=E6=97=A5=E5=91=
=A8=E5=9B=9B 16:07=E5=86=99=E9=81=93=EF=BC=9A
>
> >> >Applied! Thanks!
> >> >Alex
> >> >
> >> Hi Alex
> >>
> >> Thank you for your review!
> >>
> >> Previously, Yanteng gave a review suggestion.
> >>
> >> https://lore.kernel.org/all/e0233785-b3da-4bd5-a37f-cf4704c49744@linux=
.dev/
> >>
> >> Additionally, I also noticed that the header of this
> >> patch lacks a fixed format.
> >>
> >> https://lore.kernel.org/all/20250826190719682yrVrd5e1DHRXx0-XjI19Y@zte=
.com.cn/
> >>
> >> I am preparing to send a new version to fix the above issue.
> >
> >Good. I have picked v4 on
> >https://git.kernel.org/pub/scm/linux/kernel/git/alexs/linux.git/log/?h=
=3Ddocs-next,
> >could you do me a favor to send a fix base the branch?
> >
> >Thanks
> I have sent 3 fix patch.
>
> 1.
> https://lore.kernel.org/all/20250918151349743KS4zJHQOoG-yPHSeAY3dv@zte.co=
m.cn/
> 2.
> https://lore.kernel.org/all/20250918143643417OPRH_RjCXkCa3aCtQEX3Y@zte.co=
m.cn/
> 3.
> https://lore.kernel.org/all/202509181556503857h2V0skOmjONfEzUrZ-ok@zte.co=
m.cn/
>
> Thanks.
>
> Mingyin
> >
> >>
> >> Thanks,
> >>
> >> Mingyin
> >> ><shao.mingyin@zte.com.cn> =E4=BA=8E2025=E5=B9=B48=E6=9C=8826=E6=97=A5=
=E5=91=A8=E4=BA=8C 19:12=E5=86=99=E9=81=93=EF=BC=9A
> >> >>
> >> >> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> >> >>
> >> >> translate the filesystems docs into Simplified Chinese.
> >> >> v3->v4
> >> >> resolve patch damage issues.
> >> >>
> >> >> Shao Mingyin (5):
> >> >> Docs/zh_CN: Translate ubifs.rst to Simplified Chinese
> >> >> Docs/zh_CN: Translate ubifs-authentication.rst to Simplified Chines=
e
> >> >> Docs/zh_CN: Translate gfs2.rst to Simplified Chinese
> >> >> Docs/zh_CN: Translate gfs2-uevents.rst to Simplified Chinese
> >> >> Docs/zh_CN: Translate gfs2-glocks.rst to Simplified Chinese
> >> >>
> >> >> Wang Longjie (2):
> >> >> Docs/zh_CN: Translate dnotify.rst to Simplified Chinese
> >> >> Docs/zh_CN: Translate inotify.rst to Simplified Chinese
> >> >>
> >> >>  .../zh_CN/filesystems/dnotify.rst             |  67 ++++
> >> >>  .../zh_CN/filesystems/gfs2-glocks.rst         | 199 ++++++++++
> >> >>  .../zh_CN/filesystems/gfs2-uevents.rst        |  97 +++++
> >> >>  .../translations/zh_CN/filesystems/gfs2.rst   |  57 +++
> >> >>  .../translations/zh_CN/filesystems/index.rst  |  17 +-
> >> >>  .../zh_CN/filesystems/inotify.rst             |  80 ++++
> >> >>  .../filesystems/ubifs-authentication.rst      | 354 ++++++++++++++=
++++
> >> >>  .../translations/zh_CN/filesystems/ubifs.rst  | 114 ++++++
> >> >>  8 files changed, 984 insertions(+), 1 deletion(-)
> >> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/dn=
otify.rst
> >> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/gf=
s2-glocks.rst
> >> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/gf=
s2-uevents.rst
> >> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/gf=
s2.rst
> >> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/in=
otify.rst
> >> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/ub=
ifs-authentication.rst
> >> >>  create mode 100644 Documentation/translations/zh_CN/filesystems/ub=
ifs..rst


Return-Path: <linux-kernel+bounces-845217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C0BBC3F23
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 909F135148D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A872F4A11;
	Wed,  8 Oct 2025 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7m4j1ko"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B661F92E
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913580; cv=none; b=R6nh14hezKRVDWN5vU/pkGrisAj9FboV3hapICfOtA2G8PKJ9xedCHfr93rpIlx+vdLweEX79swEXsinchuWIXB5tMFS0fiZzHYOb3Kmti038PL5YYY2MaWW84BNE9SIKu9YPuWSF3FXBwi4HSKYvo8sVRCroC9WUXodIfcc0q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913580; c=relaxed/simple;
	bh=AYlPlEYnalDPu3mU+G9COpLgD9gYXaXXBqfIzZI0NhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjUBWidnpHZ3oZYHpyzHidIspfH/F7sLHLZTteAEg0xEYT/JP58Q5k+wCHxqHb4sRnaCEuvMynVWd64MQm67aOR7NuvCoeoj/hkTG0sQhV3VMy93NQtkT5n/F+BKdzfw3gX9t+b4SlTnEGac+oVbhN5T31fyOU6IsllJ64d1ddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7m4j1ko; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so81547675ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759913578; x=1760518378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JRe+Ysw3ed28Q5I6fD0FZJYvYHKIT6y/Zbw+MVV2NU=;
        b=X7m4j1ko+GpgLoWu+E+qXVENFgOVjCRRloSPKiko6o29gjI+idBHM/4+NvTbmMKc4S
         wrFJXQH9CUiYZvRRlTyolb+oCtzCgDKGB7S+9C9WLiAbT7D7eaebtGfECTSV1MPosw/x
         2eMtxarrphPZdU7R3Dc8+laGMb1KIcYliI6dprrV3QeP6GBrCSieQPFgBL0oqTGwI/ub
         7FciQBAG9qJf8ldOY8p4XfO+AvwUmE5IF39m+qW+D8/xnES9N6x5udqZu//0b/iF1p9k
         8ryrlxJ0kRVxGRokOTkH+zjIO8cedVeApFs6zGM4eGB3Pwjj6tWILyMMEbR3DKCNd9mD
         ZT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759913578; x=1760518378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JRe+Ysw3ed28Q5I6fD0FZJYvYHKIT6y/Zbw+MVV2NU=;
        b=tejov181MftX4O8AJnf++v2G6pMV6H2dsllzKiLwhzioyj1RaRyvqJqzn7b/Zp+C9G
         YMU61JDoQjB/YEMeAuxH6mB68SWqv03klXjUdtrtrCfLZMS2fQN6cOUMSM2Gjkphd7Pw
         u7cd9CqnvahzoNngF2hdU3J2A5c3PRuRJDVMEtMvKP9mux1UdqanyV2FdDHECmEfoZn7
         oh2u9EiDd33SLLo3H7gj9bw1BHlY32ARNsJwG6+pUfXJULtQ3fuNi+exmEJobzy7pUVB
         bxpWS2Gj5pBQS3zwUcBlnJivqyh/Qtw3dD+sDX6oaNP70dMWZBmEqKtWwpjzjiXCpoS2
         xuiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg7xC78lzqM8Pg0+Q5KmsPsEW+IDxR652PvVidXkIpsLlVyDRhaxnUVGrb+irdnfx5sUUE2NBnndo9T04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwJMgfjQA4kL9STxjx1/azkGRJsIxW07EN3iHMgLM+fmYZ8Va1
	J8Quxx/IJtV9hVT5cpHOWQYhv8oJXFpU6lHbVVq4CDMEbh2YwaXkXoRnek6eAXqlAaB2nIP4FpB
	yIVcfRhqu0KZJYB8tbSx4KuMJZC6it/E=
X-Gm-Gg: ASbGncsceYFSpNZm9uvQ5JZvtvmpvObWxKcsZTg2R1xlrGWEZ7d9PT1ZMI+vYh5HxE3
	JDjohn3KYc8of5cvrOlapk7E/6ZO31+NAAIKE/QRG/8opO+LhWE3S/hLmIOdET/r3Wp6qLAHVxq
	2xx0v6hTfF3Geurb158lo02jsdIgzkWnrsyvocttoikoxLy4E5A5/z45uy01CVPW7gOeCOKv+a3
	ZEsQbvyudfjmV41lg4DX5MDeHoeephs0t8YbCRsbsbh
X-Google-Smtp-Source: AGHT+IFKCMDzVKeMBL64zSYDRpRFM0H2rB7wq31qh9YFT8+du8n/p0Y5R8iH/2zbH4uxiGTK7bY6Wyb/b/TqjnRgSmI=
X-Received: by 2002:a17:902:f607:b0:25c:7434:1c03 with SMTP id
 d9443c01a7336-290273568e4mr34433325ad.10.1759913578515; Wed, 08 Oct 2025
 01:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006114507.371788-1-aha310510@gmail.com> <CAKYAXd8pyEBm6cOBLQ_yKaoeb2QDkofprMK1Hq1c_r_pumRnxQ@mail.gmail.com>
In-Reply-To: <CAKYAXd8pyEBm6cOBLQ_yKaoeb2QDkofprMK1Hq1c_r_pumRnxQ@mail.gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Wed, 8 Oct 2025 17:52:47 +0900
X-Gm-Features: AS18NWC61Zud4JgwiWJjoS2O6q9aZLnXpBR98-miFbKRgAfyGTqcKi4hwMhR8L4
Message-ID: <CAO9qdTHx-EYBeo1mfgVzcwQT5M6iwtVsBZTjAEVQugcfTsVtjA@mail.gmail.com>
Subject: Re: [PATCH] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, viro@zeniv.linux.org.uk, 
	pali@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namjae,

Namjae Jeon <linkinjeon@kernel.org> wrote:
>
> On Mon, Oct 6, 2025 at 8:45=E2=80=AFPM Jeongjun Park <aha310510@gmail.com=
> wrote:
> >
> Hi Jeongjun,
> > After the loop that converts characters to ucs2 ends, the variable i
> > may be greater than or equal to len. However, when checking whether the
> > last byte of p_cstring is NULL, the variable i is used as is, resulting
> > in an out-of-bounds read if i >=3D len.
> >
> > Therefore, to prevent this, we need to modify the function to check
> > whether i is less than len, and if i is greater than or equal to len,
> > to check p_cstring[len - 1] byte.
> I think we need to pass FSLABEL_MAX - 1 to exfat_nls_to_utf16, not FSLABE=
L_MAX.
> Can you check it and update the patch?

If the only reason to change len to FSLABEL_MAX - 1 is to prevent
out-of-bounds, this isn't a very appropriate solution.

Because the return value of exfat_convert_char_to_ucs2() can be greater
than 1, even if len is set to FSLABEL_MAX - 1, i may still be FSLABEL_MAX
when the loop ends. Therefore, checking the last byte of p_cstring with
the min() function is essential to ensure out-of-bounds prevention.

> Thanks.
> >
> > Cc: <stable@vger.kernel.org>
> > Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D98cc76a76de46b3714d4
> > Fixes: 370e812b3ec1 ("exfat: add nls operations")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  fs/exfat/nls.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> > index 8243d94ceaf4..a52f3494eb20 100644
> > --- a/fs/exfat/nls.c
> > +++ b/fs/exfat/nls.c
> > @@ -616,7 +616,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb=
,
> >                 unilen++;
> >         }
> >
> > -       if (p_cstring[i] !=3D '\0')
> > +       if (p_cstring[min(i, len - 1)] !=3D '\0')
> >                 lossy |=3D NLS_NAME_OVERLEN;
> >
> >         *uniname =3D '\0';
> > --

Regards,
Jeongjun Park


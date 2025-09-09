Return-Path: <linux-kernel+bounces-808124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F15B4FA09
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475764E2CC7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69F432BF4B;
	Tue,  9 Sep 2025 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6ZbdsjJ"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586232C311
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419958; cv=none; b=JOHh/IcqLkbD0gX92wJckTmZh4o+DIP7EquH3PLRNjvFJgISnzkCdOmPTEikb83zGDiRKBCDg/V3uVz3O1gmXhsCqaatY0hcCb0hN5HgoArHoM2R4gOAWrzCwemUkzGswosW1JtW/F4WotJMf6+t09bbudwMawtas3P3VT93PKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419958; c=relaxed/simple;
	bh=UMuLi+2sTu67SCflOdJc4PIQVaIvN944yy3ZwdMulbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crfh7z+atFGbrAqAGLrwpnO2E5TygviLnU/IkpXvRQuGLABEojizRvex0bGP4F4ljdHT2hMyXzW0cRRd4PaB/454ujA++AsoQ9bcM1WKlaAriJevmi07hlqnKv4n7Nf+AYfKpQhtFk2JzWYZiZ/oekSMq7ee+2s61UaKhgcIapQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6ZbdsjJ; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-401078bfacdso31156345ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 05:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757419955; x=1758024755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkBEP56Uel40DX62RGXYLGaihWp1S3NRQH+BuVUs8SU=;
        b=I6ZbdsjJjG5t9ErKwRQBb4eRgd54dCyVm4ldsfZA9MtP6IrDM2lwWhYRtvEZFpr5Ux
         MwHqYdG7meQBgRmXtp1aqPOWI5v2+DUF8lq+qizuPHq/pWM5aYNbcKL/14TEte57VNW1
         6ciQRXw8JPfs9+hRU5NZaX9T0WMkPe81JmE7gjSxv2rDlIFQQ5ngYiYtayKhtm6KGHVg
         GnhagMKSkEvYZslyQcucn9E4e8K0tzDcJ8MyAiPsTWlGP5p/rh0HfHdfKGz7WJb4NeBz
         oVNIVn/qbinOX44+9sNgnBQSvKhVoi4xxIFLVBX2erRujIEeH2YM3SjC3AtsQb3mgdXh
         ph7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757419955; x=1758024755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkBEP56Uel40DX62RGXYLGaihWp1S3NRQH+BuVUs8SU=;
        b=vs21hpXeqS99qreLXm/PToPClETv6EqbLVABFa3s5BWBMY87IYoBtmIxFAPYWjnrNv
         egMQmVQvLvyaush83lKV5Lr5CxKv+x7rQDMTEmE66fdwEpFELYAQc3sM9/D3aW/oTvfu
         z8jCPdDRBZARqkmZbFo6O1N1YVSTGbTPsjSiiL41HYXy65+GDyvWravOAoNJ2GJTbVfC
         V0IsM0+4bfazwk+vOD8HxKoxPTw8+49A6oI/ztuKQ3slRuQvpVFGqIzQYxvFXVj1bacA
         D4nEJrWCiI3fLE/D/oZfx8KONs7VBGxEoyXz73DO3utFY7L5mqn1Tic8aptNyYsKiq0b
         th0w==
X-Forwarded-Encrypted: i=1; AJvYcCWSoBXouxL7ITv6n53I9UvACIXGL9WaLjwPe6yWYfN8Lu7tAFUtEsc1agembPX0bEf+mliZ+OCg8xJq974=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYwmMz+YpcSdrDgjEUk6TmdlCr4xvileq9vqyxeEE+djVYw9sg
	osJhpwsd6/R9BnO+TuMvMezE+75tevRWWB0LZwsSeXe4/d+53EenaAaDrgRnyeSzzZxwy5fGlQG
	NojLJcwbD/9BeY0Xz3qMnAnPUh7Xvcis=
X-Gm-Gg: ASbGncuTR0HF0Byg7GLNXBSndir9fE8ewAZLMsb9inZXTUtCbvDRGoxYYnp7hUFAcBD
	Iw+mJ0O8YMAwN1VNXLDb9maMIufJVH+4yJnlvLeaR35YBeE50hv9QIRkufM9aj8iymy6x++VnIV
	RMwbTsN8IpzH5qPMhWUOyRFrH/a2pw9MHdicTa384Bjpn1CHI5Gqs7s4G1kqWNqGIl9N5Iolix5
	BWG4w==
X-Google-Smtp-Source: AGHT+IHttMERFW0A/KHZaBTOGR8TX/BI3COHvJIGooI6xnbMAbIF1hB7QCYj6I7hnqG3mC5gXf0qcw8Her+804dvKeo=
X-Received: by 2002:a05:6e02:2701:b0:409:58ec:2491 with SMTP id
 e9e14a558f8ab-40958ec2739mr74890145ab.7.1757419955264; Tue, 09 Sep 2025
 05:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908070124.2647038-1-rk0006818@gmail.com> <87tt1djtot.fsf@bootlin.com>
 <93578759.11447.1757322260340.JavaMail.zimbra@nod.at> <mafs08qinn92v.fsf@kernel.org>
In-Reply-To: <mafs08qinn92v.fsf@kernel.org>
From: Rahul Kumar <rk0006818@gmail.com>
Date: Tue, 9 Sep 2025 17:42:23 +0530
X-Gm-Features: Ac12FXzyioeKzeThxh8TxpOTJ5aYFfR6XxhutZ-VkjdtOnAXx2DXjKhkM9XUvkQ
Message-ID: <CAKY2RybqkE74EADTPnCUHAXpJLJmM9skPXQ6S3UOq8TK_y9EQA@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: sm_ftl: replace strncpy with memcpy
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-kernel-mentees@lists.linux.dev, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Thanks a lot for the detailed feedback on my patch. I understand now
that this change does not add much value, and I=E2=80=99ll keep your points=
 in
mind for future contributions. I really appreciate the guidance.

Best,
Rahul

On Tue, Sep 9, 2025 at 5:15=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> On Mon, Sep 08 2025, Richard Weinberger wrote:
>
> > ----- Urspr=C3=BCngliche Mail -----
> >> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> >> An: "Rahul Kumar" <rk0006818@gmail.com>
> >>> -   strncpy(buf, sm_attr->data, sm_attr->len);
> >>> -   return sm_attr->len;
> >>> +   memcpy(buf, sm_attr->data, sm_attr->len);
> >>> +   buf[sm_attr->len] =3D '\0';
> >>> +   return sm_attr->len + 1;
> >>
> >> Are we sure the buffer is always sm_attr->len + 1 long?
>
> Yeah, that was what I was wondering on the original patch too. Poking
> around the code, I see in dev_attr_show() that:
>
>         if (dev_attr->show)
>                 ret =3D dev_attr->show(dev, dev_attr, buf);
>         if (ret >=3D (ssize_t)PAGE_SIZE) {
>                 printk("dev_attr_show: %pS returned bad count\n",
>                                 dev_attr->show);
>         }
>
> So I suppose the buffer is PAGE_SIZE long, though the show() API is
> kinda poor for not reporting the size explicitly. If we do really want
> to make this safer, I suppose this is what should be checked for. The
> strncpy with length being limited to the string length instead of buffer
> length is completely useless.
>
> Anyway, here sm_attr->data is (SM_SMALL_PAGE - SM_CIS_VENDOR_OFFSET + 1)
> bytes long, which should add up to 168 bytes, which is perfectly safe to
> just copy.
>
> >
> > Can we please just stop messing with perfectly fine code?
> > I'm sick of the war on string functions.
> > First we had to replace everything with strncpy(), then strlcpy(),
> > then strscpy(), ...
>
> I had a similar reaction initally too. But TBH if the patch made the
> code actually safer I reckon it would be fine. Long term, these kind of
> things can help prevent unexpected bugs. But here we don't even know how
> large buf is so there is no point in using any of the fancy string
> functions. A plain strcpy(buf, str) is just as "safe" as a
> strncpy(buf, str, strlen(str)), or any other fancy variation.
>
> So yeah, I don't think this patch does much...
>
> That said, Rahul you seem like a new contributor. I would say don't be
> too discouraged. Not every patch ends up going through. I have had my
> fair share of rejected patches. Take this as a learning and keep looking
> for other improvements :-)
>
> >
> > Don't get me wrong, I'm all for hardening code paths where
> > strings are arbitrary input, but in many of these cases all strings
> > are no input or already sanitized.
>
> --
> Regards,
> Pratyush Yadav


Return-Path: <linux-kernel+bounces-808059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE52B4ACA9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 804684E2B39
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C2231B82C;
	Tue,  9 Sep 2025 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0O9oSA9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202C30DD02;
	Tue,  9 Sep 2025 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418315; cv=none; b=QWStmoFRbFqBEfoEKkaYKjesflGKIFcq5GAe1LOrO8h4+vrUuHEfxADV/IEGs6xZ5GULrtO3Jk19gE1dVNoP30EYXRSuTy1kqae/blhGuMa9EbY1CMkfbFP5/rA4TMapxM77+Vhse4MYXyYJCp5KTeibvGCrJtSkdldpNNJ52qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418315; c=relaxed/simple;
	bh=I1Zr6GfPdUae0GCJN0Q4GLwwgUaClw/TDrb4ATn1Wi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cTu/r1Ew73qeXXk21SdKj5cjspbbEnWAgri8srY9N7udux8ls0u0lCAdRSNpqGtpn8OuX95rKXgCSPt3N0Hzz1F4mRdLAC6gHsNu/qYy1xbwC8IHYShJzjTqrGN8Up8YCjwStmYOceJBJeERS4hOG9KIKJw0SvrQ9WaMIBsxCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0O9oSA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D883FC4CEF4;
	Tue,  9 Sep 2025 11:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757418315;
	bh=I1Zr6GfPdUae0GCJN0Q4GLwwgUaClw/TDrb4ATn1Wi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=D0O9oSA9/kDnGADolh+NtrobV41APUI0gxZCt+g98Jkheqv0ld0VPIQw1y5ipZDdK
	 pEViCp+8jlAP8bmYhdzaIa+4FD2LZa8UIEnHKf919YjoRYWPhS5ERwXTcbibsQcA7R
	 Q8/mdKoBIR9VcFwcRjENaO0NidjCVX+8aPaR7hdWeC44z0OtF/pG45H0i9KU5TLk7L
	 sywWS3Kzl3VSFwALy304kEI2G3Tyl1mdrIX5kRQiPy1lGMS73qVJSCGF3BOgE/SzW6
	 v2aUV6EIqb+HNh1vucshaCtzZmCacsU2gXQsuf4J8xFMIRfJkzeBgaCdkbCUZZU9CD
	 qbRWiN1P80xAg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,  Rahul Kumar
 <rk0006818@gmail.com>,  Vignesh Raghavendra <vigneshr@ti.com>,  linux-mtd
 <linux-mtd@lists.infradead.org>,  linux-kernel
 <linux-kernel@vger.kernel.org>,  linux-kernel-mentees@lists.linux.dev,
  Shuah Khan <skhan@linuxfoundation.org>,  pratyush <pratyush@kernel.org>
Subject: Re: [PATCH v2] mtd: sm_ftl: replace strncpy with memcpy
In-Reply-To: <93578759.11447.1757322260340.JavaMail.zimbra@nod.at>
References: <20250908070124.2647038-1-rk0006818@gmail.com>
	<87tt1djtot.fsf@bootlin.com>
	<93578759.11447.1757322260340.JavaMail.zimbra@nod.at>
Date: Tue, 09 Sep 2025 13:45:12 +0200
Message-ID: <mafs08qinn92v.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 08 2025, Richard Weinberger wrote:

> ----- Urspr=C3=BCngliche Mail -----
>> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
>> An: "Rahul Kumar" <rk0006818@gmail.com>
>>> -	strncpy(buf, sm_attr->data, sm_attr->len);
>>> -	return sm_attr->len;
>>> +	memcpy(buf, sm_attr->data, sm_attr->len);
>>> +	buf[sm_attr->len] =3D '\0';
>>> +	return sm_attr->len + 1;
>>=20
>> Are we sure the buffer is always sm_attr->len + 1 long?

Yeah, that was what I was wondering on the original patch too. Poking
around the code, I see in dev_attr_show() that:

	if (dev_attr->show)
		ret =3D dev_attr->show(dev, dev_attr, buf);
	if (ret >=3D (ssize_t)PAGE_SIZE) {
		printk("dev_attr_show: %pS returned bad count\n",
				dev_attr->show);
	}

So I suppose the buffer is PAGE_SIZE long, though the show() API is
kinda poor for not reporting the size explicitly. If we do really want
to make this safer, I suppose this is what should be checked for. The
strncpy with length being limited to the string length instead of buffer
length is completely useless.

Anyway, here sm_attr->data is (SM_SMALL_PAGE - SM_CIS_VENDOR_OFFSET + 1)
bytes long, which should add up to 168 bytes, which is perfectly safe to
just copy.

>
> Can we please just stop messing with perfectly fine code?
> I'm sick of the war on string functions.
> First we had to replace everything with strncpy(), then strlcpy(),
> then strscpy(), ...

I had a similar reaction initally too. But TBH if the patch made the
code actually safer I reckon it would be fine. Long term, these kind of
things can help prevent unexpected bugs. But here we don't even know how
large buf is so there is no point in using any of the fancy string
functions. A plain strcpy(buf, str) is just as "safe" as a
strncpy(buf, str, strlen(str)), or any other fancy variation.

So yeah, I don't think this patch does much...

That said, Rahul you seem like a new contributor. I would say don't be
too discouraged. Not every patch ends up going through. I have had my
fair share of rejected patches. Take this as a learning and keep looking
for other improvements :-)

>
> Don't get me wrong, I'm all for hardening code paths where
> strings are arbitrary input, but in many of these cases all strings
> are no input or already sanitized.

--=20
Regards,
Pratyush Yadav


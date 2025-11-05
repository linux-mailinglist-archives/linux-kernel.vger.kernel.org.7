Return-Path: <linux-kernel+bounces-886193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0559C34F42
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D835B4F1D8D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B32F3093CB;
	Wed,  5 Nov 2025 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB+bE+Y0"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A53B3074A7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336095; cv=none; b=XMkGIlOZkbGiijkegKpSsJ5ZmvkWj/glRSlQXWYitLqeyhnmKOPXLiJEYnP46R4qVgLO5DBw43askLOvelESUVlyEhd4K06ncpxc6UU1ei2jBiG392Ruf5uaDry7GyEzlWBzoRz5YZj1D8VC2RHH/8O7r5yC8g/GSTjcqHiSWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336095; c=relaxed/simple;
	bh=/l+lXyfzVl6LoJLldUXhYWWqz0KRyomsRBLp59Bxgkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5Sjdfgkjr5cnCrxmrw6yrDfeY8pIinzdxfGG9cF1NR34qRAGLmTDnjidOP8IQqvHApu/cJE3Yw4bVv4Jxe4QvWu0sHAQRyfLV8NPX0Al99VrLvgRY3xkjSK25oEVcYIU/FnVeZ0AIMcKsuTcBmYwnN2uA4S/OgIxxs3eeXMadI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XB+bE+Y0; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640e9f5951aso1178353a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762336091; x=1762940891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l+lXyfzVl6LoJLldUXhYWWqz0KRyomsRBLp59Bxgkw=;
        b=XB+bE+Y06AS8BNhpo2uYGd7LytKhc/uhMLC5fll0M2/GlI/cDwtuLVd4FlqF25n1t7
         NNKAO2nJZRtMQjZ5IVXI8Bq1UH5saMwN4jF5X1OEjE92B6B+mTTWYaCl8hWX5GsUCLFo
         j4zBsNSW3Dl+qkEDA8ih3OOGDw0aMh9P0JXYPaZI5RK+D/75UygWGO4GTtDpJ6btzP+3
         yMzVIFV1W0fNSChYaaEcczrkViJpbVeq5l8x96KElzpEVVHnAkL0p257I9O/+2bQr9zV
         nlZE8lprh8kscwPJ2kXeGbku/4dewS+2/qBjj0RJ5/2oB9FSayx/LH86t8bGNQBAy0eV
         TzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762336091; x=1762940891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/l+lXyfzVl6LoJLldUXhYWWqz0KRyomsRBLp59Bxgkw=;
        b=PmxrYlAewRQww8ekne0DooZObnn3bD4M1BoT4joKJiD6+6qcFSTpDd/vuXL7cPI5mc
         zKRZ3398tAl3RgvaOf0M0dzu22QK0yFAGsTFOwuQkEyDCz5rPrf2jSNjoOZ/iyCZT9XQ
         3ee/jBauc+oiqwY24jwgiULd7ToI9dHtLpbLF+sxzpVkxD34EPxnKLFKOEMWsjx4oI/s
         9z9kkH7KjZ9amdtBBUT9OdkK92CZ1BNomAbNt+HID7Xtw9ZyQQSKCHs3RznUPpjsZlMj
         gbz+nVKx419WlMvQ7mu2VOzzOl8m6BObdbVlknyxKPmMjRx/jhbrcsLnol4WUo/OXBCK
         AWHA==
X-Forwarded-Encrypted: i=1; AJvYcCUmJgCVPrU/jlEsb4kRignx5S3SvHB3HepznSe2G/zFIdk2nGh0SOU92UhCgSmxoVmiVOglyfQco+4YRVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQpKYEtf47N6/LtZ+oKxSxc+g1fhBPS/RUqAu8iXT3rN1RIDPO
	1tRjNmHUF2vGHmk3+USw/5veBnZY0nOGA6bLFlq2jQSQBf1DD8YVg3/ilIEK7uoY8+Pe4Txa7WT
	0r0DWIMY0+brIC7Jxv8yNWNpX8dJW0xzRlw==
X-Gm-Gg: ASbGncugJukEAwI+/AOOSjVaw3/AMU9+EbAsVmrYAZFgFnHDg5wnjMMncmbdJkrvKEo
	XQoIouV04Zya3ayCLMsEe4wiH4WmKsQFejlvVn0Ke3zaZ85EF4YvQGUup06RxwO+qI7rgw/A66S
	6vBltlOq9v/n3TW2vmN8x5aDM9B0jac9GR1zXT7qGKc3fXP5cv6PIZLBC7ysrdWl7r/EJS64uzT
	ksbA95lNyF+whEi0DVpJH2xlCfOh8Tw3SbD+UTB+RGklGW27MB4E4VNolOqPg==
X-Google-Smtp-Source: AGHT+IGVsthsIcYwTwTgwWV+wSwobemUM7g9CUnvEROrtiQpLrSDOge7liSIr6ymz0Gt/7YlK7M8KLcJX8SXOdMnDNI=
X-Received: by 2002:a17:906:6a25:b0:b70:e107:1918 with SMTP id
 a640c23a62f3a-b7263023887mr303545366b.3.1762336091308; Wed, 05 Nov 2025
 01:48:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOuPNLh4R=H0BfQ4f13woGzc82jX9LGB+kxAGeGVkhwYqKcg4w@mail.gmail.com>
 <19a481a7843.53422ba121754.4867625372707455852@siddh.me> <CAOuPNLhMcPJ_vkvyDKTW1c4TcSYusrzrAdu8khazHoy3txJGDw@mail.gmail.com>
 <c40a0a35-ac43-4079-80ca-361bc8c9ae8a@app.fastmail.com>
In-Reply-To: <c40a0a35-ac43-4079-80ca-361bc8c9ae8a@app.fastmail.com>
From: Pintu Kumar Agarwal <pintu.ping@gmail.com>
Date: Wed, 5 Nov 2025 15:17:58 +0530
X-Gm-Features: AWmQ_bmTKhAJwTtUvsl5qzrCsYkE1h8QiWBS6tfk3vaj9PoAWXaG5DDEqgnunsI
Message-ID: <CAOuPNLh5O0YuRi6=oOSCbaH0zy-kkKUcD__G0Ncw5yAFtko7=Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=C2=A0Query=3A_Y2038_patch_series_for_3=2E18_Kernel?=
To: Arnd Bergmann <arnd@arndb.de>
Cc: Siddh Raman Pant <sanganaka@siddh.me>, linux-kernel <linux-kernel@vger.kernel.org>, 
	kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Nov 2025 at 15:18, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Nov 4, 2025, at 06:02, Pintu Kumar Agarwal wrote:
> > On Mon, 3 Nov 2025 at 10:35, Siddh Raman Pant <sanganaka@siddh.me> wrot=
e:
> >>
> >> Mon, 03 Nov 2025 09:57:18 +0530 =E0=A4=95=E0=A5=8B Pintu Kumar Agarwal=
 =E0=A4=A8=E0=A5=87 =E0=A4=B2=E0=A4=BF=E0=A4=96=E0=A4=BE :
> >> > We have an arm32 based embedded product which is based on the 3.18
> >> > kernel and a simple busybox.
> >> > We wanted to support the Y2038 issue on this older kernel.
> >> > Is this feasible
> >> > Do we have the Y2038 separate patches available for both kernel and =
userspace
> >> > ?
> >> > Or upgrading the kernel is the only option ?
> >>
> >> Upgrading is a much much better option.
> >>
> > Yes, I understand, but upgrading the kernel on this older SoC brings
> > more complexities, challenges and time taking.
> > Customers also do not agree for the upgrade at this stage and they are
> > looking for alternatives.
> > So, we are exploring both the options right now.
> >
> > Are there any patchset maintained separately for this Y2038 issue for
> > each kernel version to have a look ?
>
> I used to maintain a 5.4 kernel with backports from the 5.6 patches,
> but I would not recommend using that. Anything earlier than 5.4
> is completely hopeless for 2038 because one would have to essentially
> redo the changes from scratch.
>
OK thanks.

> Which chip exactly are you using?
This request is for one of the legacy QC MDM 9K chipset.


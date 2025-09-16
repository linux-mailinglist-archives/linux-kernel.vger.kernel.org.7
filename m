Return-Path: <linux-kernel+bounces-818526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4137CB592E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CF24E01CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20E829C327;
	Tue, 16 Sep 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8gWpVX6"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79799224B01
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017078; cv=none; b=XZ8YOQeoNLtu5mCgqe4nGCZRCSKgcCQaiS0ojFEvGx3mMKtukluND+9ce+kv003N+SipiyqyRp6yVq/tz32jCfLYFEUWO3G/bmt8VHRqTu5VeWOMnS6F3iRwhOvgg2hukaTDxtl0cBYehD/Vp1478n1KCSB4DbCQTssKWYG+v0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017078; c=relaxed/simple;
	bh=9QDWXq+ckM2Own18uScrRB4h421cBu6n7SahYyLtGS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPyuiBRFXbD8xMp4EtmAZPjNpU+BeSM9VBpQhi6olhZGGBlAW44xCEqZwzH6Dconc7VDUAqN1hrE1dn7OmscHf4LCo9a++4RrIl2BGbS34HFvkYpTpecPYmSWh2+wYwlurj8oSCt+Nk/KZlkpIUjSO3mAJ8Av6fFCuv6cf5vAzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8gWpVX6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62f1987d53aso3277394a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758017075; x=1758621875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xvq0oFtPmi38XNhelZdp7JrUmNikqA6Z70LwGViEgDA=;
        b=k8gWpVX6ZIvFLv0Gb5R5clCcNL+9sNfaIu3f3jSEcDmn1maan/djkc6orlMEf0vSg+
         shkb9zxvOYIxb6kP8uprje8a0NveVRBkzJNpqLApnsfvIUxJt2C5RjsKMBNdboDtt1HP
         YxrndDHqTABVqt6ENseiHyjJxAwU/Vd8Kw9blmvDMUHe4sM1DubWCIW6mpFlC/E2pUy+
         /bcqDPS6F//9ZonZ96kxW+vxDsBTOisniJeK3YmzLQ1ME+f1erb6weG4cRLjvEW2cChX
         dH2HMmnxCYiZ2xQuKsyZoD+JJEzkaqeQKYMQzf/zb4gL2nqBiQjXxDNDZn+7b7mvhIG0
         +YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758017075; x=1758621875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xvq0oFtPmi38XNhelZdp7JrUmNikqA6Z70LwGViEgDA=;
        b=oV0OAIrok70VS23xe6sH2C7JjRXglVVTJBohVphk6BwnrgL2YjM9Z9nYiNlXwRSis0
         GtH5tENhyXMxW18zKHtZHzHPehmSGi8kRJ2bZQWcZK5AqoMwQ6/Pjf3gH2M6Mhs4R98j
         yHxwofsPimtJ1qMIzPhj0Wg6np22aBs+smIeyN8VYSB0V7t8gU6H2SYi6BQj3vCLpGn5
         e6OxAQvqW6kL1qIEMxKo1WMjso8R1LXejmi9whHkzREpQvWJcf8ldCDpFT/84Tc+oNNH
         T2qOlh4uNYk5PUe4aR+jSrSQffakqApVPcwOmpuHEGiiVHupouZ1Ut6pfeum03QOr87t
         iZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCVtoyVoEQLru6rx/rMnXjDkHF+S3wvCexV9r9wPThuHBqYbdH7jO0w6/tbzKuFawU2Lx9NZ66bkIa/HNKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvE1zUuzrzhBu0wPenSZVRct05opA+LbnnRM826KkmwsyG9RwV
	dJ+9AY1JI0WAFcOLsknajdjXPQQP9BdIo2R9m+Qdcwg1wNzDywrAg8FjOPtIsKHy6c8bN+141XA
	/nKlQNEl9yYIO59ZfGiZ6B7nMTbdyiyVMRCuC
X-Gm-Gg: ASbGncvNr/dZZoh0vEWVI6/AXMX7Pr7MgcRdSBiQCjdPIYhd5arcEru20dY7GxNNMnq
	ooFb65Bx0G4bUGuK9d9je5BOR4prwHdWAv0WivxvbWxtCkHx5XBe2sqV81Awrr1ittFqKFuDejl
	S7C7bqElIx0Qb0kUp5Psi8wLjBH2YYsdyVQV3bbwuo+4lJ8G4fV7jMNqWuxgfRjhu3fnayfTCF6
	umXzAQ=
X-Google-Smtp-Source: AGHT+IEPxRjXpipLqO1hanLT4Es6XaecDmd6j0Gs7/wn2Tp86zqgVa2ychH1gW5ousYZhRv8X6WtLF5xIPq0D+5VGFU=
X-Received: by 2002:a05:6402:1e93:b0:62f:2afa:60e6 with SMTP id
 4fb4d7f45d1cf-62f2afa64a9mr8308237a12.7.1758017074551; Tue, 16 Sep 2025
 03:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756987761.git.zhoubinbin@loongson.cn> <175760122164.1552180.16853979882678693472.b4-ty@kernel.org>
 <CAMpQs4JbQU3D-Bs2687BXSC=FKJBS6RMvWAKb6AJEtzit6hWqw@mail.gmail.com> <20250916084002.GF1637058@google.com>
In-Reply-To: <20250916084002.GF1637058@google.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 16 Sep 2025 18:04:21 +0800
X-Gm-Features: AS18NWANjn2G57nOU62SNxRQ6bZ8lIjTtYZPiruAZN2iRv_YMwXDLOAyZ_D0zcI
Message-ID: <CAMpQs4+J2zYgZaGYBSaf4UwzKZY-qMoD1oe2vmgJQXAfghqu=w@mail.gmail.com>
Subject: Re: (subset) [PATCH v11 0/3] LoongArch: Add Loongson-2K BMC support
To: Lee Jones <lee@kernel.org>
Cc: Corey Minyard <minyard@acm.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Binbin Zhou <zhoubinbin@loongson.cn>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
	jeffbai@aosc.io, kexybiscuit@aosc.io, wangyao@lemote.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lee:

Thanks for your reply.

On Tue, Sep 16, 2025 at 4:40=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Fri, 12 Sep 2025, Binbin Zhou wrote:
>
> > Hi Lee:
> >
> > On Thu, Sep 11, 2025 at 10:33=E2=80=AFPM Lee Jones <lee@kernel.org> wro=
te:
> > >
> > > On Thu, 04 Sep 2025 20:35:04 +0800, Binbin Zhou wrote:
> > > > This patchset introduces the Loongson-2K BMC.
> > > >
> > > > It is a PCIe device present on servers similar to the Loongson-3 CP=
Us.
> > > > And it is a multifunctional device (MFD), such as display as a sub-=
function
> > > > of it.
> > > >
> > > > For IPMI, according to the existing design, we use software simulat=
ion to
> > > > implement the KCS interface registers: Stauts/Command/Data_Out/Data=
_In.
> > > >
> > > > [...]
> > >
> > > Applied, thanks!
> > >
> > > [1/3] mfd: ls2kbmc: Introduce Loongson-2K BMC core driver
> > >       commit: 67c2639e1fc1a07b45d216af659c0dd92a370c68
> > > [2/3] mfd: ls2kbmc: Add Loongson-2K BMC reset function support
> > >       commit: 2364ccc827e44064e9763f2ae2d1dcc5f945fdf3
> >
> > Thanks for acknowledging my patchset.
> >
> > I can't confirm why you didn't apply the IPMI patch, but this appears
> > to break the patchset's integrity, potentially causing missing Kconfig
> > dependencies (IPMI_LS2K select MFD_LS2K_BMC_CORE).
>
> Pretty sure this doesn't break anything.
>
> What build errors do you see as a result?
>
> > Additionally, as Corey previously explained[1], this patch can be
> > applied through your side.
> >
> > [1]: https://lore.kernel.org/all/aFVtNAY4u2gDiLDS@mail.minyard.net/
>
> We only apply cross-subsystem patch-sets to a single tree if there are
> good reasons to do so.  In this instance, I can't see any reason why the
> IPMI driver cannot go in via it's own repo.

However, there still seems to be a text dependency issue. The IPMI
patch modifies the MAINTAINERS, which depends on the first patch.
If the entire series of patches cannot be merged together, does this
mean the IPMI patch can only be merged after the MFD patch has been
merged into the mainline?

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

--=20
Thanks.
Binbin


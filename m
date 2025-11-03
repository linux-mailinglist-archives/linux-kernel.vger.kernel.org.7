Return-Path: <linux-kernel+bounces-882172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ECBC29CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDB21889417
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 01:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B4E27B4F7;
	Mon,  3 Nov 2025 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxdxtUAg"
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DCF1898E9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 01:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134474; cv=none; b=CTf3rbeWE3zjFW8vb7TCqFKFtFxVQnXUWqjmk/+540PT3CB8XqVk/ZboVSWYw50WewnrjhtDzJL3AM6086xLBWjY9+lyNwIaB2vg2xKviDZwWSP7NUfmo8ngr/hbKPecqV1798N0Vb2nYzH521JIK/NhyM2Z6H7E3dG8yaweYiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134474; c=relaxed/simple;
	bh=YZ3yBN4jr1x/fUb9ZCVQSzD4SuGYjPdfzr1ToxdWkys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZpf7/Xaj+PN5riXuhybbUFhX0bHMVHqfZuvxQxduT4v3KNWzxK546xKYPuwfeRBRgdCv17mmFtjc3NU8538VoQgJHVFL5hgZuHR2mrNRkzvc9ii2WeEqyk7IzXf2d9Mo0yBjy6yhLJ4hlyY/ey0wWFjj/jy7wTEYnQegR2S2LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxdxtUAg; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63e16fbdd50so3349559d50.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 17:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134471; x=1762739271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiTjJNto5b180B3ollqzmYVOhF8fUFEDZCeDW5FJ6nM=;
        b=RxdxtUAg4GrI6PKybPvc3vqk8rBR4uoF+IMYUN+Q16wQNDj0bmTyAdtwzqHOECdmyg
         Lm50VqmG5XV55KlZxtX+f9aACe0G7CQoRpbzDLiIJ3d0GBaF31S3TyJm+zq+O0lGLxvM
         3ZVmdAe1IgvPZA5gf0/+JWxcExaSva2IzSEMxmqbQKxWjwl+gU0Jh6+9L40uCHPmXDp8
         784u12lZEIfrHTGkFjcTprPkzLeLB02nFfokjXPd83eD9t+LVGJNTI9VLEX7CSjHkvyD
         H9RLYNt3Fb55NkhePHc3YzvsB71j3yEKXS2XcCwdFxPAj4Rb3FY46AA66h7BDm3HTK9X
         QYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134471; x=1762739271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiTjJNto5b180B3ollqzmYVOhF8fUFEDZCeDW5FJ6nM=;
        b=BNqWoriStbLqcHHEja6oUvUXmKorc8bG3knTkwHSFtcxyog/fWmcezMuVSPdLM/NyG
         lMI4pCmQP8oY5btRR7rbeuWqp939ors2ORuOLaFjID5Yu8hwPQtl70QRixv+LABaW+33
         ITCI9duiItvLv9yEC0WLTRv3nmbFDVq0oVaTdkn5VAH55O8qHgdg/C2iaWjvxWic6yZe
         GQ+qoXKf4ZpyowzKUKvAJ77NQGnekKXXFPicC6Q7Y6cg+ZdXjbmaZMBa3etJpGMKSHCq
         iTSGx9wOpdHzHO/UKS4fSBOl2VO2sTizpk+bpwBPXWIdA6KXjyZ5wlhKHvlt3S9Y7Yfp
         O8DA==
X-Forwarded-Encrypted: i=1; AJvYcCUN+OFuxZkAkdCMp7ICtw42nkFisUZpZlaDNfVaqkOZfm1A0xVFQ3xVPwjeEn2BTGbBiQmRKkmAq/dVshg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0y68JEBDwOOxWCtPjx9LnDPxd1w7WiVrPNwK83ly5ZaCGhi2/
	pXBfKEMvEfBcVDVFnNR8plPDXQ2Omqlb6lOisKiBZoFgEgglkV3lak2GDAImAB3TytfR22hyIkg
	VnwgS5q+EQ55+Fwez8vEKP7UqR0U8aYo=
X-Gm-Gg: ASbGnctmrGlkiQ+NsjeRNNZYA1lcckZBieLvL+TUE8PzdBAQiFHS75G6CaWGWoSe+1C
	oWpJqeRDX6YtN1fcQIQDS8xUX+X1l9TAjJ2M2LyG8DFitLbbjc31LFOu4+sKz8XP9me0Gu+REEK
	uc9D7EK/hBv910Z3TL/BZwvFTmq9tp+Zc+9xr+3/gMYBokYVKoSOrgSqw6yCh8tiqXxlVnPZnso
	3E0zOkf6VxWZEe1WXv8GI8S54zuFF3g7kcnVQhg49b658LJyG2H1LnPuFDDs9xPw+7zyk9tuUGv
	8g82+1lTe+baJmAMJMhBirPWFg==
X-Google-Smtp-Source: AGHT+IHg3lV1tdMCqLOA4qQhZkQr0Tb0A3ETymH2M9xcUgAC/jEFPsBSuTrEOCTZ5597TZoN572CBcmPgfOPlOu5mOo=
X-Received: by 2002:a05:690e:1518:b0:63f:b082:4d5a with SMTP id
 956f58d0204a3-63fb0825418mr2711835d50.57.1762134471396; Sun, 02 Nov 2025
 17:47:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030035114.16840-1-alistair.francis@wdc.com>
 <20251030035114.16840-4-alistair.francis@wdc.com> <20251031140541.GB17006@lst.de>
In-Reply-To: <20251031140541.GB17006@lst.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Nov 2025 11:47:23 +1000
X-Gm-Features: AWmQ_bmAc1hVM3wcde6ERYGL7zprBagyx13YvD6LBE2RcY5YlTixr9EGWA5Kzqk
Message-ID: <CAKmqyKNr8N4r=9RvgErr-zj929gd8oRfdKGgrhVajK_UxR828g@mail.gmail.com>
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, hare@suse.de, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 12:05=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Oct 30, 2025 at 01:51:14PM +1000, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> > This can be done by writing the queue ID to te sysfs file.
> >
> > echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/replace_psk
> >
> > Note that only QID 0 (admin queue) is supported.
>
> Why pass the queue ID then instead of a boolean value?

I liked the explicitness of passing a queue ID instead of a bool and
it allows supporting more queues in the future if that changes in the
spec.

I can change it to a bool instead if that's preferred?

Alistair

>
> > +static ssize_t nvme_sysfs_replace_psk(struct device *dev,
> > +                                   struct device_attribute *attr, cons=
t char *buf,
> > +                                   size_t count)
>
> Overly long line.  And very inefficient annoyoing to modify indentation
> compared to:
>
> static ssize_t nvme_sysfs_replace_psk(struct device *dev,
>                 struct device_attribute *attr, const char *buf, size_t co=
unt)
>
> > +     rc =3D kstrtoint(buf, 10, &qid);
> > +     if (rc)
> > +             return rc;
>
> Nitpick, but nvme style is to use the slightly more descriptive
> error and not "rc" which doesn't mean much in general.
>


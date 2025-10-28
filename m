Return-Path: <linux-kernel+bounces-874474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10385C166D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D6C3A7788
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C3134F48C;
	Tue, 28 Oct 2025 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELOeluRD"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC063225402
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675328; cv=none; b=gg3LEilF1asVePTn2JCDWhGdWXoc2BB6e6bhDUjREI+9kzq0t+s8eViHV0h33+UTtjwMn4uE36EWRylA6A6Gk/26HFgZBV9VdDSOR5tKnsFoNmSRsEFBUMkbtzN6cWOXygdIb3N0MWAf4di7Z0ofd1miwjB8E+ixRLlIMB0OMfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675328; c=relaxed/simple;
	bh=5WpZIjU3vZRlh4s+sIJCWxtPeiYN4XxIR5X+ZiNFmw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRZe5diFRVy24B0lo8pf8bizBkDLBPK29mBn76bTnGFEH2qulwPK/Q1/AVFJApdh3hGWrkCrRVOp7W7DPxu8affdwWyZXQqDdkq6y2xwEolofiKI4V5g6UA/1AYaofj+TDkGrpy1eJyXxWV9tsWNmeY6NHd3pBjPCJQWubwVOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELOeluRD; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33bbc4e81dfso6768060a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761675326; x=1762280126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGx129xGJHCUEyi8yrRqwoqLs5WghBGkgEJD5/+GNIQ=;
        b=ELOeluRD6/J3HyboSBmbFqzG8FSfjnNq0ooe8KDx6lEDg/kJu6+CTb95QRk6RjRx+C
         qEBpmle5d5mhu+aqEOFa5u6Cx7lVNb6/E8294NwQGKxcvSX/66ucy8h+T//nFsLjCmqc
         GY1sRebPU3iq3bJdCjmUsEUo0D9Ezo7itE9ZqPXacS22hUa+qEeUcIKDEuuNFzu1Uu5a
         S7jMjuAm4pJAlIczkDhDfDdCPGN4GYAyrOnH0Dm+Zo08RmBGGgUH/OWvEabrXCwYbWFO
         XbnO6ZoXyFuEX9OH145JD0q6RW6xNMDJWX+rfYRbpRfGN+1LUXugHY9YyR4OIBwR8ZvG
         UFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761675326; x=1762280126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGx129xGJHCUEyi8yrRqwoqLs5WghBGkgEJD5/+GNIQ=;
        b=WNADwGdTcbfQUReT6qZc3AZZ+aI2mfqo5O28hXYaWfv9Qe0eP2/IvtncY6bmnu7go4
         y4Q2AVCUcSr3SIvu/6XFn8j9lDYhHVS6A0JQMWLSeS+ZMJ1mmQcctqeIAVjsvxG7NAi3
         2G7MX3gSztQ4P23zZ6hy5NBEktLTugIjrjhxa5xTLXjFIlwzMJYmg9WdiEmtWuhDMqUK
         OOjkoejITx7eraFnbh0j25USL0S/kcVj0I9LS8mPkZ/3f8OG6QAfBNCsG/LUlcE01AFb
         Dvpx7BRhDZl940aEyh1/wgJabfAARVepNbcfzgeo+9ob4LbcP52T8CfEiX453hT6W45z
         Z24A==
X-Forwarded-Encrypted: i=1; AJvYcCUu77ghNqjtzi0iEkwtlfYYLW3bdh/y11EwOajwuvdEeD45FebgkCpKGyrlnvyt6AExuQbMliST7B+e65Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyowkbvN/Snal2dzqP5Bkve/Kac2/+y0yYRecNzJeI04zxfOloV
	xFuOnjojjYND/kInX1tyfEsg6ckFXOC5p0a5GFNE4b3Q7ZVpDzV2yBp/t1A8R3FpZCATKX+AvRU
	CvY4Tl5WlNH0ilHwe31aq4G30dRaptyM=
X-Gm-Gg: ASbGncub4QDCEge8UlJ0bHJAuiEllIRMLuSa4M7RkafM7uFm8dOBeBoRKafFRekilGV
	AzbId08rr1AKMsXkFFJY4wHKp/H+g2aOrNiRGhVx51POKlnPNWWX6dES20+SL+CdRFBq0cBW+0q
	+bNOpQnS7S8ZIVeQRr7SECNbWNpI0QbOa5YkcLEgunSB3QGeSLJQmp5TYmDdNoKdh7qM+PoQeEm
	LLyfRBkEOow9lF2blHkLU169I+ffFKsuP8B3Lpl1Aui0qTPkO6bCskme1cUZnvmuIrDEu7Bgpfg
X-Google-Smtp-Source: AGHT+IHm5jlyHeNwn+vBvLXnVorxjDAnNS5AZt/p/LsQbZSRV1l8xOnIkmz8sYHqXVavHLJQV6i2OCIuH0O61QQrsn8=
X-Received: by 2002:a17:90b:4f48:b0:32e:38b0:15f4 with SMTP id
 98e67ed59e1d1-340279a6046mr6460300a91.7.1761675325669; Tue, 28 Oct 2025
 11:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027135423.3098490-1-dolinux.peng@gmail.com>
 <20251027135423.3098490-2-dolinux.peng@gmail.com> <6e7ef94cb4e2d7fbc82676b2af1a165cac620aae.camel@gmail.com>
In-Reply-To: <6e7ef94cb4e2d7fbc82676b2af1a165cac620aae.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Oct 2025 11:15:11 -0700
X-Gm-Features: AWmQ_bmmbpLvkuh_1R9j5BTqvfj4F1UsYNmzPFb036veLfLoy23IKui0AWrduVQ
Message-ID: <CAEf4BzZQgFBRH0yqgbQXeptcN6vUKmEpaHUDWw=qcKr747JMog@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/3] btf: implement BTF type sorting for
 accelerated lookups
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 12:06=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2025-10-27 at 21:54 +0800, Donglin Peng wrote:
>
> [...]
>
> Question to Andrii, I think.
> It looks a bit asymmetrical, that there is btf_check_sorted() in
> libbpf, but library does not provide comparison or sorting function.
> Wdyt?

I feel like it's fine. libbpf will opportunistically use
sorted-by-name property (because it checks that), but it doesn't
dictate exact sorting rules within groups of types with the same name.
I don't want to get into that business. So no, I don't think it's bad.
If names form alphabetic order -- great, take advantage. If not, great
as well, linear search (or if we want in the future, create our own
sorted index on top).

>
> > +static void btf_check_sorted(struct btf *btf, int start_id)
> > +{
> > +     const struct btf_type *t;
> > +     int i, n, nr_sorted_types;
> > +
> > +     n =3D btf__type_cnt(btf);
> > +     if (btf->nr_types < BTF_CHECK_SORT_THRESHOLD)
> > +             return;
> > +
> > +     n--;
> > +     nr_sorted_types =3D 0;
> > +     for (i =3D start_id; i < n; i++) {
> > +             int k =3D i + 1;
> > +
> > +             if (btf_compare_type_kinds_names(&i, &k, btf) > 0)
> > +                     return;
> > +
> > +             t =3D btf_type_by_id(btf, k);
> > +             if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
> > +                     nr_sorted_types++;
> > +     }
> > +
> > +     t =3D btf_type_by_id(btf, start_id);
> > +     if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
> > +             nr_sorted_types++;
> > +
> > +     if (nr_sorted_types < BTF_CHECK_SORT_THRESHOLD)
> > +             return;
>
> Nit: Still think that this is not needed.  It trades a couple of CPU
>      cycles for this check and a big comment on the top, about why
>      it's needed.
>
> > +
> > +     btf->nr_sorted_types =3D nr_sorted_types;
> > +}
>
> [...]


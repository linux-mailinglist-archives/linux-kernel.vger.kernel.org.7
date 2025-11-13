Return-Path: <linux-kernel+bounces-899326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3998C576B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F984218FC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7922734DCFF;
	Thu, 13 Nov 2025 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AStJlE7p"
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF46734D92C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036641; cv=none; b=GO8C+kRYdn6DWuImUoKg9Tb1+4GSOAqbLoXIG17opW74uOkZYzoB7pXEBXydVozCP3D+J/MFayDf09/D5FvG3+K+D8QSUJUahdrf5nS5PQekHeR+q2jcp8rffxk1/BikWzNuX/i15TH1jREPQ7C56mdLXtSpMrdw8IdxUZkjFHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036641; c=relaxed/simple;
	bh=yBAhZdNqS4Blup/eYCo1qh0aJJBTec2/OZDOVWgfjaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KrFe38lU0/JmFoVlDk1Ps6+vA5mQpjkPZxLl3MwqIcDh6qb9Syia0oMaBNlJMvHfIEW+9RbOeVOBL9VJq/+CCTbqj8YRDjmELNoCzzlkHPOrc2ILLa7h74aRDDjN2uAKO7f6HYoy2OhthO8WgEM8M2DrZ/y4e+8dp0hrpwhEyfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AStJlE7p; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-640c857ce02so641022d50.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763036639; x=1763641439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96n00582KRfAzbP9HmUAwW0SECp6ktvz1svZCc5/Luw=;
        b=AStJlE7paTdK9wK9qBykcgTf7mRRSO0VIyS4XlHQVH6ATAjgiXdaxFSafy1WcCdEhW
         M8tr19mYzzL2FFo5kHt5k+cKv38rYbEWP9GS57cZJb3UWzfcbej/tSkUGVrXYa7pA9KL
         DxkTXk8qIdQ8kRAbJ4n8z6CFQd3Q4O3d87ev4GFPLgcEE5FlTOjOUzwWF0PiRTQGvYB4
         o5ouoluH8t6sUou3L+fDpwThiMoKjmMkNiDIo9yz/H1fpbuop4ubmQY3ybT5cGRsR3Aw
         NF8K0EMJehovizxWDxoul0mgCaMVVr4mJBXuoRlI8NDSQ5/LQa+J27kNCI5k10r6y9MR
         x0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763036639; x=1763641439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=96n00582KRfAzbP9HmUAwW0SECp6ktvz1svZCc5/Luw=;
        b=JIj+d0cMXzdwn4UfNLePfqjBiRyxBeRuNfZQ8UsiJ5jvwEcJnvQWczOQ4pbFEiLpKb
         aziynQgDR2F8hrGTREOHdI0gpEjo3fkmsu0o64fD/N1aZBSV6p1z+hSwxfp/48xflZII
         +gxt2yw1x6PD/8U17Lw6WJ+VCUgXZ0HJBrJHJsIH6ywOzX1l5ZY9Gl9r15jt5vwunEuQ
         Yg7Uf0aY2U2PDU2QGrE6sE6vu3rVTRc9X3vW1owb/kjnOUIK17p0Wa/0MfEyxgYWqMIZ
         GIyRo7/ogDgiQQKAKVTZJDi3ozHE4Bh8peasjyGjdYK9Sjhn7z4FztuH1bpzEg7pH5ss
         rmUA==
X-Forwarded-Encrypted: i=1; AJvYcCUO+o+dmCY++GamFWDor4eNhzxrukJO1NU8FrNChggtkd+s7qDKcrnXzo12YszoMswYUyakO6wzo6D0Kbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfSJgNAJTou/FclvmawrE3D3EKDJSZM8iKZqtTXUUsO2/zohRM
	f1ayaGWoAhvR4zL8Dj/Dmh4RMKH2YvFbrLDuK/vdiiafkLs6CJlSZPIyGn+RjliaKFUY5b6NJDb
	vVSK2yP2TXggE2DvuNhJIJiCPu7IXR/s=
X-Gm-Gg: ASbGncvdx/1DyeviBbe8jFn5I4aKzP/+lTu93BXn1JPw449M7c1HCTFvfjsMxnlXmBS
	j2qpxD06okhxu1JDSspAkK52rHrANf70gbAlWu1qfSLFZ+R5LA5+SSmAye/C4KJX5cIYcz2kKAT
	RFt8AjO2jQkDhtggD3mUBgaZoaQBazT5vCMh4IxUqQBqENLP93OJLvxD5gWPZa5/7iSXB3H5h6N
	OCWea4sVWaHbBXZ4RjGOwD5vX+j5U3ML3MlN/I+H9Ej63VshN6DPQe4MQFD5rPqbTmacx9/Dtgh
	fZbPEI84LKBeW1I=
X-Google-Smtp-Source: AGHT+IGyWmfE8lnNSETzpsam1FziO25e2MZBJM9bAC2smHtK+EvCnDtF+WCQIw4wVIWrdLrFAFWemlz3Bj1M+g7hA3Y=
X-Received: by 2002:a53:d047:0:10b0:640:d009:e998 with SMTP id
 956f58d0204a3-64101a0b2bdmr5030018d50.12.1763036638749; Thu, 13 Nov 2025
 04:23:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
 <20251111234519.3467440-5-alistair.francis@wdc.com> <20251112065653.GE4873@lst.de>
In-Reply-To: <20251112065653.GE4873@lst.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Nov 2025 22:23:30 +1000
X-Gm-Features: AWmQ_bm2ZdiPzFPd48NGdHsGyOt4QuKhzjv2Kb9fjvNcUPYkKnuCpretzVc_oKI
Message-ID: <CAKmqyKN8nv+D1BzDTAm4AayM0NgWWUY8Z7-o2Ru6CSq7nU9ECA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] nvme: Allow reauth from sysfs
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, hare@suse.de, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 4:56=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Nov 12, 2025 at 09:45:18AM +1000, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> > This can be done by writing to the sysfs file.
> >
> > echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_key
>
> This now takes absolutely any write, right?  I think we should at least
> be strict to force some value, and document it.

Yes, it now takes any value. I can change it to a bool-ish (so write 1
to trigger)

>
> Which reminds me that Documentation/ABI/testing/sysfs-* is missing a
> lot of nvme attributes it seems :(

Yeah, that's why I didn't add this one. I'll have a look at updating this

Alistair

>


Return-Path: <linux-kernel+bounces-882195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871B6C29DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 03:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE877188F7A4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 02:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7A628031C;
	Mon,  3 Nov 2025 02:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLdYFsyG"
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E68158DA3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762136714; cv=none; b=b6DyRclB3FooYh2uJWXRWm2yay6x2bjvfMgLLz/SVc2RHp8HEwaRugXByq6+I4uFNBo6mM3Ux7NmL4OUvPqpqDlPjGpaBDAn2q+/F20n5vqipd/qa4MGalidZdgPXwJjU94VlH7olXlXLZq0yooR/WRUZKzwfQlyKwtevKUk3oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762136714; c=relaxed/simple;
	bh=tOBiGMjKhHhNm9iRoWYtTXCHrvcBZZIink414T14gME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMMZNh4ihQAbKQiwu3bXwDVCJAlaKxVwB3BTR+n+/va5urJPmTgKJDjxIcL5SXItWbxG4GF5w8oyGVTuYPNqKdGILIhI9t09rE4glFTCa1p4HB3jgcjlWPvi8C8gJ7e7z0Vt8iWAp/kevRo43YyrzOQ/Qp5jcsp6VCnjZW6NLFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLdYFsyG; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63e393c4a8aso3779412d50.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 18:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762136712; x=1762741512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOBiGMjKhHhNm9iRoWYtTXCHrvcBZZIink414T14gME=;
        b=RLdYFsyGQdMHACWQisIFlF1KwWYdGFbhscsQr/Vr2AAJju+zhFsCPiSFbh9wHPk55r
         e9+rf5qaBwEawoAf2uqKX2lR86cny/yVNXYxxkr5gcsIBkc7k+wMADoqkXgFjLYfSa+r
         iEXInejzOPWeHm8ElRNNMIgyL3VgmQ+S1pzZLup2nRn/DVNqlVQnnWFd/s0ylzB7DXD5
         0alWz2WlcAn+ZGD6y/iv1Q6YhEQJnmMO5s2c6NgcgmLTWt566kozNniwRODSo0kPe29V
         00kBjNfO/LkvlEKIRITLUilbqIJVqayHvCYxVXSyS4omv/7q93NXCxc48UE5iTf+Easc
         b20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762136712; x=1762741512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOBiGMjKhHhNm9iRoWYtTXCHrvcBZZIink414T14gME=;
        b=PU2QaD/NMXP9uBnXoVh7XJ2EjHqFpPulAgKhosg43it3wi98VgoZ0pVo9NDb7qs6KP
         ZcwIAiRMJQ/N/bxd+TNCxMxaOZMk+SOYv5KU3EID5844wFQqVRRAT9SlI+ZVA5xLHqIb
         OUxCG6nJ8CHxG5JGfNu9s+CpR38VNGidiKUG/NbRC4zIP/xBvtx+KbxO4cslLn4EqkcH
         W0/tbCwqKH2Dqeo+iwn+0arXpesKQc1i7NiQDSgUr7Ea8FxYkQBNgIzI+PYzJU874zum
         X1xQGbutsnTNTpO9h6ULUQew2quiVpkC8qFwRkUuIlDZyqB0gQFf3HCkY86VsPWDk9Yv
         s7Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXM2TSKduErJ4kzeRBerNUnQc3y1ryFkV/hqjZBKrhNIxSJJoqFQ+xlV3uUAQ1+uYRNuvktVkgruwx0gLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy7dSjly9CeD4XySFAhNos0FNJBHcdnb3g54MhLpivd28z1C9D
	nDHW1YDrFI2LdisQnu1CeZb30O9BuXRXECW+zyf9oHBsYC9GadnYd4ofnip8qiJjZMBK3j3jA+T
	u9aA47TgQvffL08JGohS6eQp8xtNcR40=
X-Gm-Gg: ASbGncvk2RmpZPf94IOTqZeCCB9ao6pFqXXl3MX4+u6Md5UQb26Uw96Z1+jmUloqZ/g
	cxQePazeJDefVMkxeFmJhLlI2xk+pfVnn4PGWQ5y6bcKu7BJPcta8we0NUwUo1OcVpcyoTrIuEn
	CM0uhKlXO3oorM+fhK6f8ZphqALtVqxoq0iU/AczfdJ4o+5vuUBoLlYHqMLyPAXOmVr9i/jfUkU
	VxJlmOD40PUCgDB8IbN2bfC8yi7g4lLFijr9+ELWmmEOADc+rHojc7i42Kh+zwqRRMvOthZYE46
	0kwyndl0X3jNGzXgiNypbwbOJA==
X-Google-Smtp-Source: AGHT+IEeBkFXELLCeDFxu+34BDAmWRmEEj7nNPJXW/YWouHM1T8Z4qQirvrUHGiy48XsOmU05GjJwP0NmEXrQU+38P4=
X-Received: by 2002:a05:690e:154f:10b0:63f:b366:98d5 with SMTP id
 956f58d0204a3-63fb3669c8amr1892576d50.9.1762136712170; Sun, 02 Nov 2025
 18:25:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030035114.16840-1-alistair.francis@wdc.com>
 <20251030035114.16840-4-alistair.francis@wdc.com> <20251031140541.GB17006@lst.de>
 <CAKmqyKNr8N4r=9RvgErr-zj929gd8oRfdKGgrhVajK_UxR828g@mail.gmail.com> <b684812e-8ade-4adc-aa08-2e4fcc9811d7@nvidia.com>
In-Reply-To: <b684812e-8ade-4adc-aa08-2e4fcc9811d7@nvidia.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Nov 2025 12:24:44 +1000
X-Gm-Features: AWmQ_bmKh7TFL5lTYmkXWdj2JituwISVLIf_nQtPpzZV3P7FriZGvVY7GennhXg
Message-ID: <CAKmqyKP4sWF_HbP4FNK9w1AP_MxnTNBjzO+uYaumT9p4UigepQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	"sagi@grimberg.me" <sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alistair Francis <alistair.francis@wdc.com>, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 12:05=E2=80=AFPM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 11/2/25 5:47 PM, Alistair Francis wrote:
> > On Sat, Nov 1, 2025 at 12:05=E2=80=AFAM Christoph Hellwig<hch@lst.de> w=
rote:
> >> On Thu, Oct 30, 2025 at 01:51:14PM +1000,alistair23@gmail.com wrote:
> >>> From: Alistair Francis<alistair.francis@wdc.com>
> >>>
> >>> Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> >>> This can be done by writing the queue ID to te sysfs file.
> >>>
> >>> echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/replace_psk
> >>>
> >>> Note that only QID 0 (admin queue) is supported.
> >> Why pass the queue ID then instead of a boolean value?
> > I liked the explicitness of passing a queue ID instead of a bool and
> > it allows supporting more queues in the future if that changes in the
> > spec.
> >
> > I can change it to a bool instead if that's preferred?
> >
> > Alistair
>
> do you have any plans to add support for the I/O queues in future ?

No, it would require a spec change

> OR
> have a strong usecase for I/O queues to support this feature ?

I do not, but it does seem like something that maybe should be supported

Alistair

>
> -ck
>


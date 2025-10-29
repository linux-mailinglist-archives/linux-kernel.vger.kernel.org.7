Return-Path: <linux-kernel+bounces-877080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD77C1D25B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FF974E29AB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2244127A462;
	Wed, 29 Oct 2025 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI2woHjh"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE751311C20
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768457; cv=none; b=sufMlA0CNXoXhsZdbGbVZX8psrRjBn1TKOODQyz1rGoVF4Yegd5HeGI7pD0lUAqz4tx4R0DyPl2Cfp85LAs1oUJV0yxxybojun2/fN14Ow2SuLzAKqyaChvueXJyd39bLIchNYJ0MRqEV6RAfNg6XEXFJKN4SWfjoZsyUgqXxL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768457; c=relaxed/simple;
	bh=pZaHWLnpTm4rrytEkoh5yTEdNRCEeH0blnuDC4rLf2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCoSDucdMC4eEIj//rpV1+fKpi8sy/t+tMOGPU3sqeQJY1xgN3PhMoBw378YkTuYzYISg6U0Li/sL7x9AFjdXB2vWjexPYZZTU/dJVLLwC5ChU1Tk/7KOXbilGZLQ3NOgLnF1e7aYW+6nkJIzCe3ZRj6z9tQqSZxi3F2RixswHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI2woHjh; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-92b92e4b078so12259239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761768455; x=1762373255; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jTJUS/pVwI0IDkcIInux/dRF79F8L7jw3CBAkxp6Zu0=;
        b=PI2woHjh9RwD97sICcToeJJ7XtuNPZgtWODX7Y78iR3DOGIvjcBwpQapTC45kKK9hS
         819bx28VLYg/LwIx7H6Son3wxZ3GDeAuqL5+mGHPFDYuG7bimK93UHSHXz2N/lsST5BR
         Q++bJf6O+Bgyh+ca0rSeQWZrDN97qrliIayrerGw4yxAvMelwwgt/oR46tlo2T/8K2lB
         AhRZTCOqNn0eK58r/PDlspt/EjZGO0tTYQQW6DPl0zTwn5PMGnFm37foLG9N4jXyTtDp
         GeMdfRcz55ulwMWhaVd7L3GcgttowlyFS4Ck+PDzlgbIOWlxdxm03RQoD2QRZhwjfiJU
         HPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761768455; x=1762373255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTJUS/pVwI0IDkcIInux/dRF79F8L7jw3CBAkxp6Zu0=;
        b=avgprznV4S3mFBRwuC6PW7Oajaky+nFiyDNHd2IO9QZzQkmJ1tb8FDcagxZth7e0A3
         maHsPaug4oQ2fB17CCQ1+nlHsLzjLUn6Pj6lKyh1fTmeGwMxNpwIE2teGWx4xtdhN7CV
         y7ZtmO3LkOH2LO4tetDLmfmzG3vcfE+BVuBQP0ddaDeL4cwfQg/nY4S2rTo1f3/w5njD
         eP5UW93Q50bje0vLVVGPZFGXnykK7PPRH1bVUrJqj8LkHGbjYQsHq8LADOb5aCPOwnQ4
         ayHpNfQBWpHmkQgvHcXOupfOW4kfH4GxoqfwqrxgyTs96ZVnjvt1vNtCs7qNQ5moFWFM
         nVXQ==
X-Gm-Message-State: AOJu0Yxw6fyVNDwCPSFH3jd11ljDtDttvxUvXrtNVz/5fE5urc9cUbg+
	f1I/6nTrGpmQJRi/7l1GmAe2CdQL6vV5TSx50eioO+a86bE678uXXTYzwluOOLjJEinZpBSvm/a
	ZxmMxkxN0dEMSZX2FW3aP3Bhs7mHZNAg=
X-Gm-Gg: ASbGncsrJuj8xOzKq5zkrzAsV6WYujUQ50obtMB5wJBNsLfoqx/VnTkC0WuTnVy5PCT
	seGMa2NZH7u/pAf+ze2uXpq2bfpcJLXyYBGhqe7mrGW51b4zAoXSg5b0RqIIoT/okMX7CXl3rwQ
	Ygr5DnaBRkYGYFjkdKVdJ0PIw/IVW3Wgdy4D+Qxb/ILgUyhEl+oyy7sEQg9tykFL8XY5psqNvrs
	3s+7GRAamw4kIaXmBlHeU92IQj6vEW4xAdlO2pfTSreigefxC9gfS+xXfjUUdqdS7QCRSC6bgFo
	a0p09fkX3TBILZ4l4g==
X-Google-Smtp-Source: AGHT+IGtjrYZer4FI1YJLLUryJr2u12Oxxi68IekbTqa0gKaxK2t+cR0qj0KuA/ltTWIdAl92YuboktMW4NGvazDdkM=
X-Received: by 2002:a05:6e02:3c04:b0:430:d5b8:6160 with SMTP id
 e9e14a558f8ab-432f907430dmr56490765ab.29.1761768453044; Wed, 29 Oct 2025
 13:07:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB95QARfqSUNJCCgyPcTPu0-hk10e-sOVVMrnpKd6OdV_PHrGA@mail.gmail.com>
 <20251026211334.GA1659905@ax162> <CAB95QASG1pZJT7HyqxM90_FExhSVjoHmPqYHeQWXnrAzCNErmA@mail.gmail.com>
 <CAB95QARmr9b-jVdgDLpA4Qq=3WN7CYS46YEH4Ok4gpSdZHpq5A@mail.gmail.com> <20251028174541.GA1548965@ax162>
In-Reply-To: <20251028174541.GA1548965@ax162>
From: Eugene Shalygin <eugene.shalygin@gmail.com>
Date: Wed, 29 Oct 2025 21:07:20 +0100
X-Gm-Features: AWmQ_bnFTLtd5rghWRzz34YmOoNt-X_vsjjNzVFZIKDYvVQjofq9CQTlIFqsHUE
Message-ID: <CAB95QARtzDWensRzui3d-7+jhymcFBOBi78ev9LMy=ZFJMDCTA@mail.gmail.com>
Subject: Re: Can't boot kernel 6.17.4+ via rEFInd
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kbuild@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d21d05064251aee5"

--000000000000d21d05064251aee5
Content-Type: text/plain; charset="UTF-8"

Hi Nathan,

On Tue, 28 Oct 2025 at 18:45, Nathan Chancellor <nathan@kernel.org> wrote:
> > Replacing CONFIG_KERNEL_ZSTD with  CONFIG_KERNEL_GZIP made the kernel
> > bootable. What does that mean?
>
> Hmmmm, I am not sure... That seems rather odd within the context of the
> flagged change.

Huh! The fourth of my machines with the similar config (also fully
updated ~amd64 Gentoo) with rEFind boots kernel 6.17.5 with
CONFIG_KERNEL_ZSTD enabled.

> Could you post the output of 'readelf -S vmlinux vmlinux.unstripped'
> from the broken and good builds?

Attached.

> Does rEFInd have any sort of additional
> debugging to see why/what it is complaining about not being able to
> find?

No, unfortunately. However, I was unable to find the first part of the
error message ("Not Found") in the rEFInd sources.

Cheers,
Eugene

--000000000000d21d05064251aee5
Content-Type: application/zstd; name="readelf-vmlinux.tar.zst"
Content-Disposition: attachment; filename="readelf-vmlinux.tar.zst"
Content-Transfer-Encoding: base64
Content-ID: <f_mhcf682j0>
X-Attachment-Id: f_mhcf682j0

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
--000000000000d21d05064251aee5--


Return-Path: <linux-kernel+bounces-859983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28B2BEF14A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6373AEA5B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BED280308;
	Mon, 20 Oct 2025 02:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="UM2ybodg"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47B1FCCF8;
	Mon, 20 Oct 2025 02:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926867; cv=none; b=TzynPkxYmvwEpyJB1jlValx6T53ooOzD4+q/B1Si+oX+2DGI6d/5gdOYw0JmuJDLLPxD0xaiqQP/7uRx9ACfNhkya79MbFr6EPxePs0s7eL0/cPMdtIp7kZDGGdewwXlhNlcii6egI9gBMP2y2Jo8mtkYpOQSGUflJj1pkAjP9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926867; c=relaxed/simple;
	bh=BIa5EgOPw4ajYBRbLnJWbtkALVb5ei1vgmx+sAXuj9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwJy5uAnsnF1CEokgZprhF8iCxWSFE3PHbsWvAPSRDgxbLc1yfGTUsRPH1UTr1PH16RPbt8SkChs8y+YK+yLD7Yf7X6YSIgcssGecXj+b5b9YOuPYx4xjVS7B2NV3WAkKTcw9ucBAgta7GjVBE531VPKS6PbIoAkquYU53z5wEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=UM2ybodg; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760926851;
	bh=bsEnjHoM06iVNxKJujvN5KqKt3gikmfLFHIz5VO2vUY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=UM2ybodgy6KTWvPAEAHdaGrUSj0ttxCdKVOKRWEHtNwXJvQhPUOTiyQmgNn6Z0ObU
	 9Yxy0tkmVSLMhTrCoQtN4cTCpSTxV3c28l8IHLnLjwkqJ7tCiZP41z6PCGcjKV32UQ
	 nA1nYh8AJTLPfI+kWgvYa7RkyC43RdWF0ExOnGEo=
X-QQ-mid: zesmtpsz4t1760926846tf33a5c17
X-QQ-Originating-IP: 34Afq1jEbXgyQF21XpjRvyPm0b5xHTb1ciTJuNmoGVM=
Received: from = ( [14.123.254.135])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 20 Oct 2025 10:20:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11458405615915761153
EX-QQ-RecipientCnt: 14
Date: Mon, 20 Oct 2025 10:20:44 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Yixun Lan <dlan@gentoo.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] riscv: dts: spacemit: add MusePi Pro board device
 tree
Message-ID: <28DCD6FACACACFCE+aPWcfFSvEsFfw4AD@kernel.org>
References: <20251017-k1-musepi-pro-dts-v3-0-40b05491699f@linux.spacemit.com>
 <20251017-k1-musepi-pro-dts-v3-2-40b05491699f@linux.spacemit.com>
 <20251020015204-GYF1506524@gentoo.org>
 <52A7E982E5B11F53+aPWYHMbImTxJy7pJ@kernel.org>
 <20251020021846-GYG1506524@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020021846-GYG1506524@gentoo.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NafziRg7Bx69uOq+yJX9d/gVeT8EwRYDVK0QKUcl0dpWnufn4onJVnBJ
	i1YAHcJNahZj5Nuc1P4QDscgstChGMi795vUq4dn4RyPOR7HOAFu0JOvIuVoQAHVa1ocXs8
	vszZpGea7wrIffv6r06nReRlqfwwcdgnjBz1j1RF5kR0NnvNp3O88Tj9Oh41hjBp5zOGZoD
	qZNw5IZ8h/gjm38toCvlLbgvdcwUfph7hNT/vUCuG/J2JRCji0BHq2NRENO5ICOKuUZdRE0
	BQcxOYXO1Fc5QCHwgEoYMPBOW/Ceh3IsJqpGOHP6S3cinYzJwdH6zOpJspvQVMygnE768ED
	d/sfUsrkL1A+y27LWWq2k+fgKW4KT5nA0vItK7hCSbnKg1NMgxYfqrRbexl5n3PSx9wJWpo
	jQNrggB1meaBTMJ4uFQLwk98o5GYu+O6MbMod8GdtsX7Id3jnhTpXZpJdsmejjgJZSW+ATC
	jVyh6L7TV6i0TIUavYlZ56t1ubaSouaum+oToDq7NN8Xr8waSAQJ0vQlUE0GrY1CuILRtJu
	oTpKIhJUt89AeBMDsflUX6RiSiotoyclGKllIIaxM/WKdd08zIQKEnbGG0pFGW6yTnZ0+an
	b65h72ocSTuBD+elNvgx/gFwp41YocViltS/ElN9bN+Ux/qcKTAiEK5D975/cq4npRbKxx3
	zSEE/WWWVwfD/n1CRZXZBjnnmYrEYmLK1/UMjwQZOEiWvic2xUfQxLp8Q90K7CNoPRSCHmN
	AV4H/CbEXashnfu1MiLS3aCKoqkyc2gQDd9INi7gtgLnK78sNNqlZMN4iR3hs1B4R9hyqaK
	r9qPB1o/Ugih95/dp6dU1hOQJmpvH/URckdQHdmB7BiAbJEGKweFde6V0gtW7TZ7XVw6g01
	3hEt7PMOUVycxEVn1NAz7ZrIecPQy5Bf98GiQl9YNbo9P2RlxNbdD85sMRNVPwDW5jLO3ZR
	Rd4L0zDoObQrkodn6if9RFgEiTGnW4rAa5UNMYpvMT6tZn+LcwQhVRFFRYV/RhTavFRzgUt
	9/QLNBCimW39lYQZeWAEyqOyvVmlQZSAP4SSho3rWUA/EvtG6J8Ed5+x2JhwBdMufR/yggq
	RO3MSu6Zw1xeEN3oOilurFEIH6+ANPogg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Mon, Oct 20, 2025 at 10:18:46AM +0800, Yixun Lan wrote:
> Hi Troy,
> On 10:02 Mon 20 Oct     , Troy Mitchell wrote:
> > > > +++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> > > > @@ -0,0 +1,78 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > > +/*
> > > > + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> > > ..
> > > > + * Copyright (C) 2025 Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > this isn't a big problem, but I think it would be better to use SpacemiT
> > > Corp's Copyright, to reflect you're not doing as individual contributor..
> > I understand. Since I originally wrote and now maintain this DTS,
> ..
> > would it still be acceptable to include my own copyright line along with SpacemiT’s?
> I think this is good
Thanks for your confirmatioin. I will update the copyright line.

                    - Troy
> 
> -- 
> Yixun Lan (dlan)
> 


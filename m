Return-Path: <linux-kernel+bounces-838353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B96EBAF038
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3BD192772A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08AB255E53;
	Wed,  1 Oct 2025 02:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="BZS10cwL"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7552019CC3E;
	Wed,  1 Oct 2025 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759286147; cv=none; b=NslGDyUPqYo7Kfsp2XVwzXIetrGtMp5aXe8uavd8s3a4cEkVFSrfZXKSLFg+8j/ecSZlfC/lo7KwMQytycBrAxdXxNpEYmcspsXsSPV9gLqEdJYn3UnuIasD9Ig66uuPF+6cx5XbLHl6ylX1x8S6kTH6mRBpKY/GqlizZnTa7NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759286147; c=relaxed/simple;
	bh=K9fCsMOCdUbvRNo/t+o2bC2PyvUlczEgu2UBaPD1egI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mo+pUaw2HmBngh0DUOZY5Ztv3kuo5gMcmh9QSPbpJSkqm7puwRkF1skCQUeA8KlXw/ku9P79R8+WVSy4uJJLQuTuW8UBXXr6iENR/WieLpLVxc/tcSAz9T3iZ8qxW5ih1fjPmONxRjY1S9rRjYydJWQkc/dcIPqOrB5AoNJQGFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=BZS10cwL; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1759286143;
	bh=K9fCsMOCdUbvRNo/t+o2bC2PyvUlczEgu2UBaPD1egI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BZS10cwLGFLV5nsN0uVkLFHIq48Oo2il5WbyDSJvHm3dHPjdTV8wixUYy5gUITgc0
	 Jyx8eIPnhDSPxODugl67iAIXBGYrAnuuNV0m8yiiz/+klC2aHN4/PzO4YJ4yEzUWsF
	 xhEVltPYvy9tosuvwWUrB8rKBgJpe90p7deCnbFp+a40msHMA6uyxPB3EVctuJwO6E
	 3wGaeCNu5f4IgFDQ2/M6MAC53VQUcmGn6XchruaP2BRoaOvcBulzpYnRPTD362gqYB
	 IzkD40nZKAx/QBIIFJXTNmOReFZUB5cOSvX45trBXVN6NzJPDVrJIwISBEVZCmtCXb
	 GGLBCpTvd9RyA==
Received: from [IPv6:2405:6e00:243e:cd99:1d87:95e3:706d:5dc7] (unknown [120.20.48.42])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 49F6F749D1;
	Wed,  1 Oct 2025 10:35:40 +0800 (AWST)
Message-ID: <045c7bcd3a852e626f11e5b78c07939feac0e298.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 0/3] arm64: dts: nuvoton: add NPCM845 SoC and EVB
 support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, venture@google.com, yuenn@google.com, 
	openbmc@lists.ozlabs.org, benjaminfair@google.com, joel@jms.id.au, 
	krzk+dt@kernel.org, tali.perry1@gmail.com, conor+dt@kernel.org, 
	avifishman70@gmail.com
Date: Wed, 01 Oct 2025 12:05:38 +0930
In-Reply-To: <CAP6Zq1jmmhqYu3C7KHFK2tz9zjW352Bbw4cXeOYSjNSTELrp5Q@mail.gmail.com>
References: <20250925200625.573902-1-tmaimon77@gmail.com>
	 <175890301752.880349.2331946518360447485.robh@kernel.org>
	 <CAP6Zq1jmmhqYu3C7KHFK2tz9zjW352Bbw4cXeOYSjNSTELrp5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-29 at 12:15 +0300, Tomer Maimon wrote:
> Hi Rob,
>=20
> Thanks for your comments
>=20
> Most of the warnings occur because the compatible strings are located
> in .txt device tree binding rather than in the .yaml file.
>=20
> The only change that needs to be done is in ti,tmp100 that
>=20
> Could you approve the patches, avoiding NPCM845 compatible warnings?
> Meanwhile, I will work on converting the txt to yaml

I think it's best we get the conversion done, and then subsequently
apply the apply this series. See:

https://docs.kernel.org/process/maintainer-soc.html#validating-devicetree-f=
iles

and

https://docs.kernel.org/process/maintainer-soc-clean-dts.html#strict-dts-dt=
-schema-and-dtc-compliance

Andrew


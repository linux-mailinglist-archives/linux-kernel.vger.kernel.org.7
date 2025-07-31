Return-Path: <linux-kernel+bounces-751505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 952B5B16A64
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0722B18C6820
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F33923643E;
	Thu, 31 Jul 2025 02:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZT1Knmkf"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC6339A1;
	Thu, 31 Jul 2025 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753928443; cv=none; b=j4oMKmiCn4h28MI4hBVubdDTfAGLdjCuxjozIG2YBkhK0unJxc3Q7rd5Bwhe2q9xs8wK6DvoUHwghGQIcbUSevNukdkkPYBNXWoTPF/sA01XxjnSCYpRd8xqYSqNRk3W2v7DlsfxiGJye729PgHztG88P9XjfxiM9kAZHYQxLoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753928443; c=relaxed/simple;
	bh=/+TfOEWR0Nli29bN6WrEzJLsG9aHc0r+gNTRjB2A+GM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hBnYjelAklUNeZk6bgrVR916e5/KeTK+nDCyxZTHreoE960Oko9M8xcIvTMG1d7mLszY1k1+GwkI/hBLPUhC2ELsJqmTjxausa1LikBxDUI5PB06AIk+fS+M/MY+sOnco/yz3jstwbrGeM/b9Azy99TTwKK7EPcNDgPhEUGBGHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZT1Knmkf; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1753927882;
	bh=/+TfOEWR0Nli29bN6WrEzJLsG9aHc0r+gNTRjB2A+GM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZT1KnmkfhOaJuo/p5h6IVFRznALO76XlJ+P7ddQ5Flf3pmvBxi2pO8e3vOFv6Vkvi
	 aAeCv8ORPyqaUSuNoJl5JZXACdozJcdnThpGcjeX5Vob97c2cR7gNP+/DhIX2Hm9J/
	 MucMr7u76yYSOrLlZ1al+FxuhjMQSP3Xez2lv0/84y0cxXffF+icO7Rv+V7SmWzx3T
	 6IMAX3CjnOpj3oKhk7px0mFuLwD3Qxt4bNymA+mzz1DO/fa4j/mlQwoOluBPvV3mt3
	 dojq2p5DGHhCRH8mh3w9XT87GBJgtrjWCiW/MzNVNNYeNvzmUe4sUhcK8LXOaXbETJ
	 ZbJVaPUlNdBSA==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7D5B569374;
	Thu, 31 Jul 2025 10:11:20 +0800 (AWST)
Message-ID: <2de9da0e95d3e1284a29170c99f7b69baadb9518.camel@codeconstruct.com.au>
Subject: Re: [PATCH v7 0/2] Adding device tree and binding for NVIDIA
 GB200-UT3.0b
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Donald Shannon <donalds@nvidia.com>
Cc: conor+dt@kernel.org, openbmc@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	krzk+dt@kernel.org, joel@jms.id.au, linux-aspeed@lists.ozlabs.org, 
	devicetree@vger.kernel.org
Date: Thu, 31 Jul 2025 11:41:19 +0930
In-Reply-To: <CAL_JsqJwgbWa0sPVgdxMchPfa1hR8o-=wRh4UgoK3QfDdW+S+g@mail.gmail.com>
References: <20250723222350.200094-1-donalds@nvidia.com>
	 <175341328135.3754696.5873094296930738476.robh@kernel.org>
	 <CAL_JsqJwgbWa0sPVgdxMchPfa1hR8o-=wRh4UgoK3QfDdW+S+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-24 at 22:25 -0500, Rob Herring wrote:
>=20
> All of the below warnings you are introducing...
>=20
> And yeah, all the ones above are existing, but I don't see a lot of
> progress fixing them. It seems no one adding their board cares about
> the SoC warnings given the lack of progress on aspeed stuff. Maybe new
> boards need to be rejected without some improvements...
>=20

I had an old branch with a series that reduces the warnings. I'll
rebase it and tidy it up a bit wrt more recent binding submissions.
Once it's mostly sensible I'll consider pointing people to it as
suggestions for fixing existing issues on the path to getting their own
devicetrees merged.

Andrew


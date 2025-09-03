Return-Path: <linux-kernel+bounces-797846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C7FB4161F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A1C548763
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647552D97BE;
	Wed,  3 Sep 2025 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="JWW4LWs3"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683A72D6E64;
	Wed,  3 Sep 2025 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883922; cv=none; b=tsGqi9xprfMzmeaaHGrY0pFAQ4jaLEBNhDDV+1n9j7X19kyZkKcjE386Xz1ZfYdWxs1uGH8sJX/hWoZCNuri8JJHCUogXhW/R8oQIsQmwhaxiPaHNzwRuR8kTxAxv/VFltJECQZTrYhiGKpt8FHHZZYGwbcQHKmv4Mbj/EpbMPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883922; c=relaxed/simple;
	bh=uRXv1zst4Bt7hVDwEw6Xuli+96Oj2bzsZ/K5tIhZjAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CohFySzDiP0ZdewxMPAncp9Ye5nriScZabU8C/8U8L10kbjP8Hp8BBFCc6iI8YtOyo0+aiU8DSt568x3oSSLRh2Ok5nz83mSGwQuUS/fpHHOMTD/YrVMNRsqpTEpMLsNubAaqqkNY+4tcEpJ26sO3LRaHgJnEOTcAEbds3C5FCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=JWW4LWs3; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756883919;
	bh=uRXv1zst4Bt7hVDwEw6Xuli+96Oj2bzsZ/K5tIhZjAE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JWW4LWs3tbhpRxs8lsvP7o9byunRuzY8Y/VBgveoTqQl9Dirf9r8oPqMZnthfs7SI
	 JsaPYQi9d3XbOv6tZx+8BToq3JP1fuGozp8BYG47j9oV0wKXxe6cZZtCTu7p4iB3wG
	 CjE1xqbiJKOZeEgxdi74oJht354j7I6voOV/835gf9swmq65Miftl144m+DwoeiYw6
	 P/5yZsKogLm6udutuVBHBG8gJYk0qovUk6MEQKhzEV5758hXC8OnZPCM8qfPN+lfO5
	 GNOw8zx7T/X9CA9uHx9o9bm4dDgUSj4zWiXoii+2IP59VglNDGt1TlNYAY2tzzfFEB
	 0EaFEmy/Y9E9w==
Received: from [10.209.99.88] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A474B6FE7C;
	Wed,  3 Sep 2025 15:18:38 +0800 (AWST)
Message-ID: <0c815a7562551caf3960cd38b5d867c80747de4b.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: Drop syscon "reg-io-width" properties
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 03 Sep 2025 16:48:37 +0930
In-Reply-To: <20250829211330.1336274-1-robh@kernel.org>
References: <20250829211330.1336274-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-29 at 16:13 -0500, Rob Herring (Arm) wrote:
> The default width is 4 bytes for "syscon" devices, so "reg-io-width" is
> redundant and can be dropped.

I had a quick look in the syscon bindings and can't see that this is
documented? The driver implementation behaves this way though.

Andrew


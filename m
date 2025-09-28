Return-Path: <linux-kernel+bounces-835146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E406EBA6606
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F24F3C06DF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 02:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F070C24676C;
	Sun, 28 Sep 2025 02:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="XwNUjyHV"
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E10E34BA3B;
	Sun, 28 Sep 2025 02:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759025103; cv=none; b=LMNBxSUkvipMx8W3QoiKfCRh8A+NYZ2Cbzog1++bbhFBtOxn1NW/Fy4jFrb4DAzw12IxYbBgedg/1k1OFh4syPi14diEex8tUdOSMu1vbXh1W0VCXLq2iifxRACUfhbGoXNDWYA2R8BvEcx6b/bgTIg1OXgUlWBsB2xTwmuGt2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759025103; c=relaxed/simple;
	bh=dd8aTFM2Eb5B8r1iK/jAwaTrG7N7Mae22af5ILS5Ej8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3BLk0rkKg3FQUjDotgNZ57X6BjD+aaPCqszfm7TLqfqPK6d2vTbfBBJWijq4ElLG6J09IQTlB79D4PMj7mJU/cASCsZFd2JetYDB8TGYhrJATty1jNR4PaSWoxF/ugTCQRv6mlMoSchyYgPDjBVN0uojXch/Um5jTMjBUr89x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=XwNUjyHV; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1759025079;
	bh=m9Kk7QA8lWfdkzkFV5B/KM9BWqdwJsdsHEE8+TGRrrM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=XwNUjyHVA5k32M95YQy28JjhMeaiz+GPu5bSxH6+lgtKwbvte3D2mUezhprlpXDd6
	 6DjfWyoxKA8sI64pKNTzLWGiD12+94LDll+/a7bUbvxnhmsey3+H3hK9kuD9IhZf8y
	 XHTT0vqjmPqsyQU9Bp3byH6tVyQxXVQ0lYquP3VY=
X-QQ-mid: esmtpsz20t1759025076t46662b3f
X-QQ-Originating-IP: lQaZvluawJANmPALLJ4FldAi7OUDYe5AwRXmjd29L0E=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 28 Sep 2025 10:04:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14352669615158593729
EX-QQ-RecipientCnt: 14
Date: Sun, 28 Sep 2025 10:04:35 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v3 0/3] riscv: dts: spacemit: add 24c02 eeprom on BPI-F3
Message-ID: <20B16B97E8F735FE+aNiXswZes4EM2abP@kernel.org>
References: <20250926175833.3048516-1-aurelien@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926175833.3048516-1-aurelien@aurel32.net>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MsL7hwqo9bYsR1OWVt4oZigvDxkbg1rKsg2qsis4ncj6W0ft7V+cDOve
	ZPjWGsSHCnTvL7bysNAZKM6hOr9b2vmI1qB1A/ubwsTyWINEeRVTQ7Vz1cjoIpk/TnouYft
	RfzCeCbFcCxWHZ++oZWilhCiP2xbB5M5H4nsM59aKs/4Z4dSRtX53tx1svwSUCnbUAyiiD7
	EOr476MTBSpff4XtLfXoOXJDyC+1RuNQcSB3Eq891w+TpghbBIQIEvgUJCw6UPexqrsZqkI
	02dzbT0G8xeRvxtIdEOIOmHl7GTaliVNuHS+X/CDZOZgdFbMtMJ2/uDmS2bXpUHM2q39v+A
	8g9QOcLqSh4VldwvGCmoMmTC4ip3cw9tb4m7rRLSsY9hXT7lMRi4stMzGnwqCyJUFYzHhnD
	2r3M+RVhC+FR0ozmENpLu53PVyRKwkOIo2PHkk22sucPh0qgm2Myj4bpb9hgatRuHe6DyP2
	CPQ6EAPWCvE38zGdVDBOaPfQXDjc6z2n0fw3l9C1uIDryjDT9AD8K58e8Vp+CHzZ5GtE3xX
	stkxcyVVIT+a0B5Uwob98i8ukFeaNf+2qKX6uw9rFLvzRXwp9/9O28bZS1tCq7hWkzmiuOr
	/hjqlom59f87gA8HCaroic6OhLZVGLMqCzXVToUhpiyfVypsC/P0PIp36h/+2L7As87da78
	aCSleyf5n9FVnqJfRsd0jgZlqUIiMFSXRwTVeQdgw1nWp2KYzkIKBkaUy4JVQPClhDLMqNL
	dQ/qQoPqzz84IhYJBdGUZlMpJwoWeNUpTTN0kf70+bAg58OpZrYmMHO8ftSXGcBiZjXodrn
	LOTcVqX9l8l8OdieRWQUByqXJBS61LxgUB1zg6z2qkWNnak+hZCxdpIxZOTNqGy/Wfgnwiz
	ZRMFt5m3XR9RvsWtxmU7ECACXTXG/excxcP8Y4V2V9vISgZ01R/Wd5bvm/1TuXN6dBJYIk0
	z0pTUCuynSUhNo1J4jdYRz2klf6geY1obFkvRDfSawuJZfUH2iN0XwOIhTB1gWDlQo968Kh
	pGWhom4haigIpJ+xpIFMcqTJf9QYYIcZM+uGXW0aPBSTrBNdDILXvCp47BP2eBmrmhUu2hx
	qHse4w+Sldf
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Fri, Sep 26, 2025 at 07:54:36PM +0200, Aurelien Jarno wrote:
> The BPI-F3 board has a 24c02 eeprom connected to the i2c bus #2. It
> holds board data. This patchset adds support for it.
> 
> Changes between version 2 and version 3:
>   
> - Revert the name change for i2c2-0-cfg and i2c2-0-pins, the second cell
>   is not a function number, but an index.
> 
> Here is version 2 of this series:
>   https://lore.kernel.org/lkml/20250923205028.2355244-1-aurelien@aurel32.net/  
> 
> Changes between version 1 and version 2:
>  - Rename i2c2-0-cfg and i2c2-0-pins into i2c2-4-cfg and i2c2-4-pins to match
>    the naming convention encoding the function number in the second cell.
>  - Rename the 24c02 supply name label to buck3_1v8
>  - Add a onie,tlv-layout nvmem layout describing the content of the 24c02 eeprom
> 
> Here is version 1 of this series:
>   https://lore.kernel.org/lkml/20250921210237.943370-1-aurelien@aurel32.net/
> 
> 
> Aurelien Jarno (3):
>   riscv: dts: spacemit: enable the i2c2 adapter on BPI-F3
>   riscv: dts: spacemit: add 24c02 eeprom on BPI-F3
>   riscv: dts: spacemit: add i2c aliases on BPI-F3
> 
>  .../boot/dts/spacemit/k1-bananapi-f3.dts      | 33 ++++++++++++++++++-
>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  7 ++++
>  arch/riscv/boot/dts/spacemit/k1.dtsi          | 13 ++++++++
>  3 files changed, 52 insertions(+), 1 deletion(-)
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> 
> -- 
> 2.47.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


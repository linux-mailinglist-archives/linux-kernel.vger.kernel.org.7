Return-Path: <linux-kernel+bounces-793213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73125B3D095
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 03:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEDD443AFE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 01:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EBB1C84BB;
	Sun, 31 Aug 2025 01:40:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AAE4502A;
	Sun, 31 Aug 2025 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756604448; cv=none; b=MAHCGRfI7kCafgAj7NIakBBZgm3HJ6E669CG1OxtqZoQa/lZnSfgIVT9b4aEWhMQAC69P6wgDgY2BQ+adtZQKQ4DSJhgQ6JXKlznpPB+mC7eMX0TwBcxjTaUuPRKpCjpWd1IZjfdqj3QVuvuvWG3m5WarkkhGrj25f0nR3lJGYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756604448; c=relaxed/simple;
	bh=878wiNWTsy/MqUwMdILYoZjCi3hb/V76DP4rIsFWyc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iNIw/WF4BmYac8JDEvCoSHtGQZAQLAyD5l57cMmi2XKierXxjDAYmYrI39HQZGgKVOCjURZ59W7S9tv1F0gD0MHRjZv5YwfdDpgiA7Abo5fDggir1wqAE+FB252QKBGiRy/9GwkeIyuo+nw3CFS4MXFJ1oUZZr9VINA3aAkmJC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38036C4CEEB;
	Sun, 31 Aug 2025 01:40:47 +0000 (UTC)
Message-ID: <9e56d3e2-b9c4-41ee-aab2-220733fbd658@kernel.og>
Date: Sat, 30 Aug 2025 20:40:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: socfpga: n5x: Add 4-bit SPI bus width
To: yankei.fong@altera.com, Dinh Nguyen <dinguyen@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <cover.1750747163.git.yan.kei.fong@altera.com>
 <c55786bc081c29e9819dec3090d96230bd6a369c.1750747163.git.yan.kei.fong@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.og>
In-Reply-To: <c55786bc081c29e9819dec3090d96230bd6a369c.1750747163.git.yan.kei.fong@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/24/25 01:52, yankei.fong@altera.com wrote:
> From: "Fong, Yan Kei" <yan.kei.fong@altera.com>
> 
> Add spi-tx-bus-width and spi-rx-bus-width properties with
> value 4 to the n5x device tree.
> This update configures the SPI controller to use a 4-bit
> bus width for both transmission and reception,
> potentially improving SPI throughput and
> matching the hardware capabilities more closely.

Please use 80 columns for your commit message! Like this:

Add spi-tx-bus-width and spi-rx-bus-width properties with value 4 to the
n5x device tree. This update configures the SPI controller to use a
4-bit bus width for both transmission and reception, potentially 
improving SPI throughput and matching the hardware capabilities more 
closely.

Doesn't the above make it much easier to read? Please do this fall your 
patches from now on!

Dinh


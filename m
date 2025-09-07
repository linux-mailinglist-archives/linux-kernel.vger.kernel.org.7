Return-Path: <linux-kernel+bounces-804786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA84B47CF5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 21:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63EC3C04FC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 19:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F8027A462;
	Sun,  7 Sep 2025 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPghQDwE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23BC315D43;
	Sun,  7 Sep 2025 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757271761; cv=none; b=SqJL9Wwp4OLZKrjZRn66t+CSvTWcxh7n3ZcYc1+j8jQ8x5UF+i6wmjoLowoOlLkUNB47+TYQVqqlEdzevqY2dS/uC2JvrlmCAm53vmTFusb4DETTQgrF6SZ+9ZV+vcvKMiQk/9OJ1sdV82MY9t1Cw3D4dzTdYA+VdNC35hzpboA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757271761; c=relaxed/simple;
	bh=oCLELgIBeep9ZVlxy13VvPQGLOoUE9donTEF1yMVwJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbeg4b2NE+oGe7dSPIXRM/oGwOPUkk1aMl8AAFBI3WU6uuUREXRBnWScmxrPirMJuN7pXv6kg9PtSY4LPhmsJa8roscKNLE+3Fv2np/v98LVg7Edo7vY3SEM4ZIK5aLbSUnXoww07GUybgtWHEMXBbNZtyTEnDJSLlkxyd5hhPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPghQDwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79608C4CEF5;
	Sun,  7 Sep 2025 19:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757271761;
	bh=oCLELgIBeep9ZVlxy13VvPQGLOoUE9donTEF1yMVwJ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qPghQDwEBlowBEth9fyjp4vjY5wZh04XJFkbFxS85DYfRxVSLTclt0Tm0PbzqVlNX
	 M935vCEYzcsbk4iD6E6BJkMIxuRPGwFpTQGJghxOJ5/zjCrGjecLpDofYagYrA8t56
	 bh2yzv4UA53Zaj1A5kF81C23Nll8suCUaR4U/EHhmtOKptRSeLdswBtR3iqxq9vixk
	 nkATV7LU5KAJrv4DvdjClLWYAqdXkygCO3aHjCXv4nI/fj2xamFy5LE+ghMUy0eO9r
	 zR7TaQXYAXIpjaqiQhBi6L5ilXeIuBrvZqDXOylAv2LCZ7nBkztRas9+ZO6389TevX
	 ep8IsixfMLrMw==
Message-ID: <2b950163-dc2e-4753-b411-5c694d55eafd@kernel.org>
Date: Sun, 7 Sep 2025 21:02:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/22] arm64: dts: apple: t8103: Add Apple Type-C PHY
 and dwc3 nodes
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 Hector Martin <marcan@marcan.st>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-20-52c348623ef6@kernel.org>
 <20250907-zippy-auburn-koel-d6da32@kuoka>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250907-zippy-auburn-koel-d6da32@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.09.25 11:47, Krzysztof Kozlowski wrote:
> On Sat, Sep 06, 2025 at 03:43:33PM +0000, Sven Peter wrote:
>> Add all nodes and connections required to make USB3 work on M1-based
>> Apple machines.
>>
>> Co-developed-by: Hector Martin <marcan@marcan.st>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> Signed-off-by: Sven Peter <sven@kernel.org>
>> ---
>>   arch/arm64/boot/dts/apple/t8103-j274.dts  |  12 +++
>>   arch/arm64/boot/dts/apple/t8103-j293.dts  |  12 +++
>>   arch/arm64/boot/dts/apple/t8103-j313.dts  |  12 +++
>>   arch/arm64/boot/dts/apple/t8103-j456.dts  |  12 +++
>>   arch/arm64/boot/dts/apple/t8103-j457.dts  |  12 +++
>>   arch/arm64/boot/dts/apple/t8103-jxxx.dtsi | 137 ++++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/apple/t8103.dtsi      | 105 +++++++++++++++++++++++
>>   7 files changed, 302 insertions(+)
> 
> Please do not combine DTS patches in patchsets for Greg (e.g. USB). Greg
> expressed that many times, that he takes all or nothing, and DTS cannot
> go via driver branches/trees.

Okay, thanks for the hint. I wasn't aware that he prefers related 
patches that go through a different tree to be split off.


Best,

Sven



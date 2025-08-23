Return-Path: <linux-kernel+bounces-783012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB35B32859
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 13:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D92D5C693A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 11:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF703258EE1;
	Sat, 23 Aug 2025 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjNwp0ui"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0412024BBEE;
	Sat, 23 Aug 2025 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755949336; cv=none; b=iyD8i7q3xb1lH2MKz1lueSCMcxLe5rW7WHzZH4Key59ne7Dj7NW7btGDwjjTAt1SZX6zNilvQVwkaKN4k7ZTRZJJREheFZfdO3T0IJqt1XpZMxtvNeKFc0PowOjG0snyzy/vi9QNK8tGkR6jDmQ6cXeuggWDfQng5mXjxGR+8eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755949336; c=relaxed/simple;
	bh=Z4TA0OORd5nq/VOXrmsLKOQ3PrHPQ4mtK8elrLgVns0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/1SVPKdRIzWQBBnbNRgJw5e2pReGES6a54mBVofJnzZvfHPyi2xWA4qLi9mwFua8D7Xb2BSLvzmRFWvzl3dAoBUjGQQtqSBXIo2sIX5CXXVzeQNy0SNCez+HvOS3qXpEdpK63cQpGPSIn93quepKPzQA4zuguHUmrH1vGvtWQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjNwp0ui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C4DC4CEE7;
	Sat, 23 Aug 2025 11:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755949335;
	bh=Z4TA0OORd5nq/VOXrmsLKOQ3PrHPQ4mtK8elrLgVns0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AjNwp0ui/uADg+X4ucpgn1s6FF8CXSUBXc/Jz7Ak4Z+Q3bcm0tDi9nuRj0ves0dwH
	 c34w/S5I1jgXInE96uhXZeOkkNwvuyxGfVIz9aEJmJRIfWmgbsUDHAOfPOIxfiZzLW
	 JpPI9tBgizTCPSqqcD/SYXA7tVG9xCtttIkTHrYZDzDEw1NlXXpCh9/XE7j8Nnjgb+
	 H4xz2GVXRNrqp3aJmEFBbyzEwb5skBgFkpMxe+lOBvwUfEzAq5QeSiUX1wa/tMs4uH
	 vqbmqQrbMQ8mr78GOJPNKB07GWoiyBF6XUyi3vOVd+cBMbayP4x96nOZKzt6pkGEL6
	 zdfg6ZVOhi+Vw==
Message-ID: <c052860b-c239-43a6-b05d-c8495bc1c731@kernel.org>
Date: Sat, 23 Aug 2025 13:42:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 05/22] usb: dwc3: apple: Do not use host-vbus-glitches
 workaround
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-5-172beda182b8@kernel.org>
 <20250821222842.fqrxjp56czc7ubok@synopsys.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250821222842.fqrxjp56czc7ubok@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.25 00:28, Thinh Nguyen wrote:
> On Thu, Aug 21, 2025, Sven Peter wrote:
>> From: Janne Grunau <j@jannau.net>

[...]

>>   	/*
>>   	 * Some platforms need to power off all Root hub ports immediately after DWC3 set to host
>>   	 * mode to avoid VBUS glitch happen when xhci get reset later.
>> +	 * On Apple platforms we must not touch any MMIO yet because dwc3
>> +	 * will not work correctly before its PHY has been initialized.
> 
> This doesn't make sense, the phy should've been initialized by this
> point. We already access MMIO before this. Even your [PATCH RFC 7/22]
> attempts to access MMIO before this, yet accessing here causes problem.
> Do we know when the phy get initialized then?

You're absolutely right, this doesn't make any sense!

dwc3_power_off_all_roothub_ports uses ioremap which will map the XHCI 
region as Device-nGnRE. That just doesn't work on these machines and 
actually explains the SErrors.
Resources on these machines generally have the IORESOURCE_MEM_NONPOSTED 
flag set (via the nonposted-mmio dt property) and then use ioremap_np to 
map them using Device-nGnRnE.


Best,


Sven



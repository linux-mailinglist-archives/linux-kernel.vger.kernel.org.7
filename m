Return-Path: <linux-kernel+bounces-782979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7D1B327F1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 11:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C629EAC1780
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 09:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3587123D7C6;
	Sat, 23 Aug 2025 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhjPaQhP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ECE4A33;
	Sat, 23 Aug 2025 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755941550; cv=none; b=jzC0F9mC0l6mW/8ZxiDocjYSNKyIwk8kcaWIJWS5Y2kclRxyIKgulk1BwfCvMwvI71kxGy5mT+YZsueGmsrU61o2sPh//ujCe4sg41wc/c8A9uCiSyTBMy543NBZjooLM7irUxSczlZPoHMa5+1xMlWG0zqkoVy9bgc677PbSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755941550; c=relaxed/simple;
	bh=+gmaRG4bCJwAnZiedCk4uT+ovE7FPGaq2RQsy9fyihM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EMs7bwROMqY+sVejCCj18upGupFvCcM8Xnt0r3anWC/GN1meLirZeKCS13bdNwnYFN8zrwM7tW4vy4DNEwMhYDlGJOpcVshqh1q1qkFUDtEF54WGLtGPJ1G3/ifjvpiP1r99L74mJhzqaArx3j754zJWP2evx9JpgAddPCxAB/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhjPaQhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2E1C4CEE7;
	Sat, 23 Aug 2025 09:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755941549;
	bh=+gmaRG4bCJwAnZiedCk4uT+ovE7FPGaq2RQsy9fyihM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=FhjPaQhPe0F68Fk8Xg+5uYwyCCuS30Qb3gJ47QfVRuDzDVENxq/NbNpZI/Am7oLbf
	 +aAUIa9Qk/rz5HZeQ2srhbwDNhMs/cz2aeDfaHpfYlAuH7f0T/JsyrArRXpNjEjjZs
	 6pbeqYT1CrU2lWc24aBYLB5HgJbetmavjZFWWVlV2Mcu7ZPGQMPItkt/9ww1vNnILp
	 Jp/xLMUbklEpqp3VlycKxM4hbuQXSGOR4LeFtVIWnzuKJKQZPON9fEn6hcwHiCknk9
	 gAblSTs8LXPsE0SRQBdAECmv/RK3U3/rY8dhFXrA19yQ8eMUzUQiKYaXrJZfSFZVVf
	 7s3OE9FSPbxdg==
Message-ID: <0289f92d-0d18-43d2-b98a-da8bb08e9342@kernel.org>
Date: Sat, 23 Aug 2025 11:32:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sven Peter <sven@kernel.org>
Subject: Re: [PATCH RFC 07/22] usb: dwc3: apple: Adjust vendor-specific
 registers during init
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
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
 Hector Martin <marcan@marcan.st>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-7-172beda182b8@kernel.org>
 <20250821221832.zsn4rk7nomsbgytx@synopsys.com>
Content-Language: en-US
In-Reply-To: <20250821221832.zsn4rk7nomsbgytx@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thinh,

On 22.08.25 00:18, Thinh Nguyen wrote:
> For this patch, however, I'd prefer these vendor-specific settings to be
> in their own glue driver. I can only imagine more changes will be
> introduced in the future with this vendor. See if we can use the new
> glue interface in glue.h (some call this the new "flatten" model) when
> creating a glue driver.

Nice, thanks! Hints like that are exactly what I was hoping for when
I sent this RFC.

When I originally started working on this I tried to use the 
parent/child model but didn't really get anywhere. This flattened model 
looks very useful though.

I think I can even move some of logic from the previous commits to 
dwc3-apple.c if I extend the glue a little bit. I'll see how that works 
out and maybe do that for the next version then.

Thanks,

Sven



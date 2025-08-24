Return-Path: <linux-kernel+bounces-783686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DC9B33137
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 17:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6F11798F7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 15:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED53259C84;
	Sun, 24 Aug 2025 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIg7lPy3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33ACA5A;
	Sun, 24 Aug 2025 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756049452; cv=none; b=YBW3khtbCMglgveUM871wZglOfHaNrqGhw9RtjZq//jmYZAS/BXz32lG06GOX+TRAICbI3V6Rud3auE5j7LDQG7rGgIMXMLo8xYZ0vRT+IHIq/L+pdLcUNRm55ez875VAil4ZSB0gWVWD9pd/IEE1SER50cChrJuYbAMYwsGphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756049452; c=relaxed/simple;
	bh=ELLwqf337+Rd50ax2qN36UfLgzngTVAA0cqVt1cHHyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J47Z3V6WCyQozxLyAQCLUUZjlpw67r53/IBjIj3o6WAxiA6OHL/N5g0141HnfsHdGu91W5VGV5aw7kk/bUkdg4QyJtAj9VkKYeYJVvrsDRE7T28yxuuz2+d4dRub/5ZdStYhBdo8N9l5IosJkr8H93ysJFU+H71BuhuOHWxB00w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIg7lPy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FA4C4CEEB;
	Sun, 24 Aug 2025 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756049451;
	bh=ELLwqf337+Rd50ax2qN36UfLgzngTVAA0cqVt1cHHyE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HIg7lPy3Sgx8WOylmQSBMhEjLKRNW7fydmaIE3ZvCCmlsEHrLxejsws4nqDSfn2HY
	 Ymh6+xtYDx9K7b0OgLWsrXjjJa/zVe9kWDsBCb3VLbQzZKaS2TR5r80S+OmiT5tI2D
	 S0YeBDT50nkosDRlJ5uFwjuImOKOW4JrAN0l9ysax8fKgNSMYzij1hTROpiC23XPLq
	 L408tHOYgMkiJTgahdacgK+llPRyEcQJ8mwSUX+P7uoV/43iS1ge34HnnUkiSgA16t
	 kS1pFQ2ghgeFqdOZ5SKDOmMNedlDgf/F5U87w5xjEYrM8VhQdCjwgrxS/en3buO++r
	 ZX5vwrf+OGawQ==
Message-ID: <8e6b19e1-e1fc-40fd-bf5c-e36180aefd19@kernel.org>
Date: Sun, 24 Aug 2025 17:30:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 02/22] dt-bindings: usb: Add Apple dwc3
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-phy@lists.infradead.org
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-2-172beda182b8@kernel.org>
 <20250822-banana-ferret-of-opposition-0bcfad@kuoka>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250822-banana-ferret-of-opposition-0bcfad@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.25 09:24, Krzysztof Kozlowski wrote:
> On Thu, Aug 21, 2025 at 03:38:54PM +0000, Sven Peter wrote:
>> +
>> +  The common content of the node is defined in snps,dwc3.yaml.
> 
> Drop sentence, redundant. Schema tells that.

Ok, will drop it.

> 
> ...
> 

[..]

>> +
>> +unevaluatedProperties: false
> 
> This goes after required.

Ack, moved after required.



Thanks,


Sven



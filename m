Return-Path: <linux-kernel+bounces-788618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2037B38756
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21E01B230F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545EC3176E3;
	Wed, 27 Aug 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4QVOu/5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E9A221543;
	Wed, 27 Aug 2025 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310830; cv=none; b=W3K9jtdoY+/E0I631+AAzothFUHIuuPKUFOVvTp828QfKlyoCJrjbnkOtR/y86LMaTJgf4+VwtsM6E5xNZVCgDSoB2TZLmoM/PkpJoty2eYAFo1cEnsX01meaSLAblpTUpTkZqdf5rkz2EtLnWPKMiJbtTTY9MYLwrFqDI6IyZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310830; c=relaxed/simple;
	bh=8/nHBBY+4VBhT+YC6UcqQvlwOolIbFpQ9L4LggP+E0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YH1jI9ykMyOoKi7+hKwNhKoGCleFDy4IQobA5ZzpOGzujEuNLD5/JEoXfHHyNvtwtSXIfqJqu94nqc/ZgaUAwrKm2SdHI/9hB2eHtIWlNdhBgf0o+UL402GAGZARD7m2xWLtXubLVj4dsZcigMiUWM0ywhRA75ecUiTMvVmo6fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4QVOu/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D71C4CEEB;
	Wed, 27 Aug 2025 16:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756310830;
	bh=8/nHBBY+4VBhT+YC6UcqQvlwOolIbFpQ9L4LggP+E0w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X4QVOu/5Y1nL6frM1iU4gWhATYdfU0A2DDYCR/HCU+tNO4/rv0GSkcWe1bav1YKZS
	 qQ9atRMkj6ljLH8X6u7yydleAg+yG4d+QuB4R9PB+FsmKZHxZWYZT5clhh/lDkLG5O
	 6ypIT8ddQeiXDVgm1tRCXvHlGmz09/9B97PucyrKh+CY95TSCS3PyV+bs1LCKbtegx
	 xCK8S/DKDtQ+GQvVGCdsQAmlNIqDcAHa9h3iYaW+VFn+19EiDRkU4WreLRRBGX3K78
	 5OQgM0pEeYdx+hlyoKl4p9avrBArAhHYmoJqIXBj61VIx1Uzmy2MLjog6VVU9OZnmF
	 I2IwA8MCBqDvQ==
Message-ID: <a89ba427-b174-42c3-b3b4-5e4079942c3c@kernel.org>
Date: Wed, 27 Aug 2025 18:07:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/22] dt-bindings: usb: snps,dwc3: Allow multiple
 iommus
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
 <20250821-atcphy-6-17-v1-1-172beda182b8@kernel.org>
 <20250822-skinny-clay-harrier-64dc58@kuoka>
 <e4c730d2-6ee1-46d7-850b-8ebbe0a1bfcd@kernel.org>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <e4c730d2-6ee1-46d7-850b-8ebbe0a1bfcd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.08.25 10:31, Krzysztof Kozlowski wrote:
> On 22/08/2025 09:22, Krzysztof Kozlowski wrote:
>> On Thu, Aug 21, 2025 at 03:38:53PM +0000, Sven Peter wrote:
>>> Apple's dwc3 variant requires two iommus.
>>>
>>> Signed-off-by: Sven Peter <sven@kernel.org>
>>> ---
>>>   Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> index 4380bb6fa2f08a475b557e80467abc2861f622e2..6d35dcc605c01977f4fc6fdb6f12976f1cef2b9e 100644
>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> @@ -60,7 +60,7 @@ properties:
>>>     dma-coherent: true
>>>   
>>>     iommus:
>>> -    maxItems: 1
>>> +    maxItems: 2
>>
>> Never tested. You anyway need specific constraints.
> I realized that's pretty vague, so clarifying: you changed all bindings
> to have two iommus and that's unexpected. All other devices have only
> one IOMMU mapping here, so they need to stay like that. If these IOMMUs
> differ, you should also list them, but probably that's not the case here.

Makes sense, thanks for the detailed explanation.

I don't quite understand why this controller needs two iommus but they 
must essentially be programmed to the same mapping for xhci to work.
All of device mode goes through one of them and xhci buffers are split 
between the two iommus (iirc I saw the command ring using the first one 
and the event ring the second one and then just decided to program them 
the same since anything else would result in a big mess).



Thanks,


Sven



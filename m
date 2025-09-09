Return-Path: <linux-kernel+bounces-807618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DD8B4A6F2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BB4174218
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8BE27BF85;
	Tue,  9 Sep 2025 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="w2YD8++8"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7672C275AF6;
	Tue,  9 Sep 2025 09:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409125; cv=none; b=eWycFrfbQRSCXisNPbGTzcHPmoEw2PW+xqQND6ylBbCdNAdlZ7OLWGWFBoRWplpKXHUnIPTTyYL2gAxz6sAzUJBRdPJekwX/y1K49hm2P/wZkR/b8M72xqYEeNpaCCFWh+R5aiPNRxwc0xMkaideFAtOkN0m439C7TRkeHuogcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409125; c=relaxed/simple;
	bh=2e83reysY5H5m6nmYmalJnlN7Al1n9K+XBXCcduWVMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1locKq3JH5WybspQj2ODOK4D9WGv49/sdF41ZkQ1zNdU7J56d0yZctaq0sdDMd+xXrZ9+C8oPLgJecSYvrLlOeNYPr9kD274mQSRgfba087q3cXK1Dkajl+A/THkG2tJ3MeYfFLepIn60oOs4pjgJuoFOTSLQkFGxdNYvhkIjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=w2YD8++8; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6ECA0C6B39B;
	Tue,  9 Sep 2025 09:11:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0A4F460630;
	Tue,  9 Sep 2025 09:11:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D070102F27D2;
	Tue,  9 Sep 2025 11:11:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757409113; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=YyeFSv8G8VagVLbPZr7Jz9cHj6+OjDL5VXZ6S6Zjn4M=;
	b=w2YD8++8nnm1tP/wIanutigjiur6Mjwhvnyc4ddj9jKMkjcLvS3U8FmCSmazKypDlcfN1g
	tLYeD1aFrKF5oLM76zkM0iSkGvx0ffgKNyhiSqtk/eu1aQBGBVIxFxIYt6gB7kzIs5lT9S
	EH/8sGIAEfGsx6A8FB39bPj9bTBgMbSFOH+SdK1QFM/LGRCLgZ0KPSf5eCQ5rOQxGL4Qs7
	KxTTV2lAITO1Sgyc6Bgv2U4E9EJCjPU/KgO8AFxAxRncyEamCuvrw+nXQmDDnwKu/YSO68
	hVt9mkMcOMWRtA9TfGorsArgxvCf83PAQE/oCS0q45DKBmuOogv88s4ISjAGqg==
Message-ID: <464f5995-be7d-41f6-8e95-7d724e2b5308@bootlin.com>
Date: Tue, 9 Sep 2025 11:11:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: usb/ti,am62-usb.yaml: Add
 ti,lane-reverse property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Aswath Govindraju <a-govindraju@ti.com>,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250908162052.355341-1-richard.genoud@bootlin.com>
 <20250908162052.355341-2-richard.genoud@bootlin.com>
 <20250909-curvy-happy-pug-eeffda@kuoka>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20250909-curvy-happy-pug-eeffda@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 09/09/2025 à 09:32, Krzysztof Kozlowski a écrit :
> On Mon, Sep 08, 2025 at 06:20:51PM +0200, Richard Genoud wrote:
>> On some designs, the D+ and D- lines are swapped (on purpose or not).
>> The PHY can handle that with the LANE_REVERSE bit.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
>> ---
>>   Documentation/devicetree/bindings/usb/ti,am62-usb.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>> index f6e6d084d1c5..ba894d610af0 100644
>> --- a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>> +++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>> @@ -36,6 +36,11 @@ properties:
>>       items:
>>         - const: ref
>>   
>> +  ti,lane-reverse:
>> +    description:
>> +      Should be present if D+ and D- lanes have to be swapped.
>> +    type: boolean
> 
> What is not working with existing data-lanes property?
Hum, indeed. data-lanes could definitely be used here.

> 
> Plus, lanes are swapped per port, not for entire device, no?
I'm not sure to get what you mean here.
The use case I'm trying to address is:
pin AD10(USB1_DM) of the AM625 is routed to USB_DP pin of an USB connector.
And pin AE9(USB1_DP) of the AM625 is routed to USB_DM pin of an USB 
connector.
And using LANE_REVERSE bit of MMR_USB2SS_CFG_PHY_CONFIG swaps the DM/DP 
lines of the corresponding USB instance.

Regards,
Richard

> 
> Best regards,
> Krzysztof
> 



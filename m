Return-Path: <linux-kernel+bounces-800696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EB5B43AA5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80F9A7B0A75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C670B2ED170;
	Thu,  4 Sep 2025 11:47:34 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F192627FC;
	Thu,  4 Sep 2025 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986454; cv=none; b=PwI2hk3qnhlkcIwva0dy7AsFKl/UiuSmZz/qLqn3Z6IfX1uunyn9mcxqozQHPEmG36ctUUGs8ZSdP2JCnaCAAPZL6zXAqd/io/RDCQcTh6qyQTn1C6yTrRvwiZrJMVmZPMUrbdZ/eamFrNGYsRaw9l5To0tlrat+j0BIb0k3lgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986454; c=relaxed/simple;
	bh=c3VrT1iZNiKGnElPx+n5S9798I9O0fi2SAybCahpS4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIgnh81mL10avwVlvwq3e2Yoy8En4pDlFISN6eulZVZca2UTTt9v1gWYo0gRHmKflu1kBMPIOi5nKXzt0DvDN7hQmOdcNTC/RWf399wN3dMsDyu4//u9ZBfSdkIfm+Gc2BM/Bo7VfmF+yOoEyxM/0oc7lXAmkwlZ4wHlqThs+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.89])
	by gateway (Coremail) with SMTP id _____8Bx379JfLlo16UGAA--.12732S3;
	Thu, 04 Sep 2025 19:47:21 +0800 (CST)
Received: from [10.161.0.102] (unknown [223.64.68.89])
	by front1 (Coremail) with SMTP id qMiowJBxD8JEfLloHet9AA--.40538S2;
	Thu, 04 Sep 2025 19:47:19 +0800 (CST)
Message-ID: <3d5ca9ac-c5a0-4553-bce6-0c937390f53f@loongson.cn>
Date: Thu, 4 Sep 2025 19:47:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ASoC: dt-bindings: everest,es8316: Document
 routing strings
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>, linux-sound@vger.kernel.org,
 krzk+dt@kernel.org
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, drake@endlessm.com, katsuhiro@katsuster.net,
 matteomartelli3@gmail.com, KCHSU0@nuvoton.com,
 patches@opensource.cirrus.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, shuah@kernel.org
References: <20250903160119.83625-1-jihed.chaibi.dev@gmail.com>
 <20250903160119.83625-2-jihed.chaibi.dev@gmail.com>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20250903160119.83625-2-jihed.chaibi.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJBxD8JEfLloHet9AA--.40538S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF1DCryDury8Zr45tF17CFX_yoW8XF1xpF
	Z29a98tryFgr17W39xG3W8Gr43W3yfCF45uFZrtwnFq3Z8Xwn2vrnIkrn8WF4q9FZ5ZF1U
	ZFW7uF1fKFyYywcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU


On 2025/9/4 00:01, Jihed Chaibi wrote:
> Add a list of the es8316 pin names to the binding's description to make
> it self-contained and improve the user experience for board developers.
>
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>


Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>

>
> ---
> Changes in v2:
>   - Rephrased description to refer to device pins instead of the
>     driver.
> ---
>   .../bindings/sound/everest,es8316.yaml           | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.yaml b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
> index e4b2eb5fae2..81a0215050e 100644
> --- a/Documentation/devicetree/bindings/sound/everest,es8316.yaml
> +++ b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
> @@ -12,6 +12,22 @@ maintainers:
>     - Matteo Martelli <matteomartelli3@gmail.com>
>     - Binbin Zhou <zhoubinbin@loongson.cn>
>   
> +description: |
> +  Everest ES8311, ES8316 and ES8323 audio CODECs
> +
> +  Pins on the device (for linking into audio routes):
> +
> +    Outputs:
> +      * LOUT:     Left Analog Output
> +      * ROUT:     Right Analog Output
> +      * MICBIAS:  Microphone Bias
> +
> +    Inputs:
> +      * MIC1P:    Microphone 1 Positive Analog Input
> +      * MIC1N:    Microphone 1 Negative Analog Input
> +      * MIC2P:    Microphone 2 Positive Analog Input
> +      * MIC2N:    Microphone 2 Negative Analog Input
> +
>   allOf:
>     - $ref: dai-common.yaml#
>   

Thanks.
Binbin



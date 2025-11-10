Return-Path: <linux-kernel+bounces-893145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9007C46A12
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29FA54EB39E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD17430E0F6;
	Mon, 10 Nov 2025 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQnfRAJv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3287923EA88;
	Mon, 10 Nov 2025 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778167; cv=none; b=Mjjw+dRFxwYbJEXNQF2wHbp+1ExMhapGgcO6hCsEcdgMeNE2XeuRGKkFzj2zcZo8TTnl6pb6uVKl5ciHQ1Zqdx0Om3AjLkTb8MmLhSlHrQjNhkklK9KkmDSa1iPdX4RngGDME5UOhpBTuli7fTo+WUgFy/Xx/pPNEOy+uzn93SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778167; c=relaxed/simple;
	bh=5y8I8nhnPfdGddmx1zRY5sajFbNRe4oAnoyYuhJzI3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kCSM3MOPHyLZvelpD5G4lak2JjXXioaStKFo2EeooAbLdJf1gdHN89dm2T5rE2fd0ShdEggVmB0A5W18WhVkwSW6WJ1HAYuboUulu7BWMDkN3Ia+x7VBFmcYwN81wecikKWrPhJzKUJAUFNUT05Zi0yziVgiYjZG8OIuQiy6iek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQnfRAJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1932C116B1;
	Mon, 10 Nov 2025 12:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762778165;
	bh=5y8I8nhnPfdGddmx1zRY5sajFbNRe4oAnoyYuhJzI3s=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=lQnfRAJvrLSkoAVLPppVyq53Ci6ucOj+dGozBajSsoqdRwKBj4ZOe57cbpl4mCToK
	 vWBeE/v64Xeh0K8d19cNSPpknfpulCn78KVdWyLtYnoia2717P8xOUp4jLBSS6geGH
	 wDkDr3hRkQaSSfhYk3Vpj8qhHz707Du8xm/B9WfbeNkhWJhC0osMbduWdil2J22Wao
	 5K04yMEohCxk+a1QnvjJNqPjpW5eyOLLfxlDOJDle/poTQd3UZT45Ey8H94lqGNwIq
	 K91TTSA64iV9bpocdVzVqzIv/hzTQ3yl6pYI00Hjh5AhiBYIrYiZ/jlKi8TAAUwgdr
	 +7rzCUI2jNb6g==
Message-ID: <03d6086f-0a84-4cca-b668-5b8902cd866f@kernel.org>
Date: Mon, 10 Nov 2025 06:36:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: intel: Add Agilex3 SoCFPGA board
To: Krzysztof Kozlowski <krzk@kernel.org>,
 niravkumarlaxmidas.rabara@altera.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1762756191.git.niravkumarlaxmidas.rabara@altera.com>
 <51ecc7f4eb7e419c00ee51fc26156e25686dfece.1762756191.git.niravkumarlaxmidas.rabara@altera.com>
 <1c879d71-a4a5-4241-a0db-bfd2c61bf32c@kernel.org>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <1c879d71-a4a5-4241-a0db-bfd2c61bf32c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/25 01:53, Krzysztof Kozlowski wrote:
> On 10/11/2025 07:47, niravkumarlaxmidas.rabara@altera.com wrote:
>> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
>>
>> Add compatible for Agilex3 SoCFPGA board.

>>
>> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
>> ---
>>   Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>> index cf7a91dfec8a..e706c4eff019 100644
>> --- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>> +++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>> @@ -21,6 +21,11 @@ properties:
>>                 - intel,socfpga-agilex-n6000
>>                 - intel,socfpga-agilex-socdk
>>             - const: intel,socfpga-agilex
>> +      - description: Agilex3 boards
> 
> Agilex3?
> 

 From what I understand, the Agilex3 is the same chip as the Agilex5, 
minus 2 CPU cores. So I recommended to Nirav, just to add the binding in 
the Agilex5 context.

>> +        items:
>> +          - enum:
>> +              - intel,socfpga-agilex3-socdk
>> +          - const: intel,socfpga-agilex5
> 
> Or Agilex5? Decide. Cannot be both.
> 
 From the explanation above, could we document the agilex3 socdk this way?

Thanks,
Dinh


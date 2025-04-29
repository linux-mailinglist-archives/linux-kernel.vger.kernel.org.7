Return-Path: <linux-kernel+bounces-625373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 170ECAA109D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 17:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E631C844F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 15:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AD5221F0E;
	Tue, 29 Apr 2025 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="nx0ym0oN"
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E1A22172C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941069; cv=none; b=DUtjnNtUNBX1qw1m1d5Q1phf3m9J0PJRWlwWABrXAFkP6bHAucuCpqrcDjL+SbbuJeGYid3f3mzfqiF8GATgf6gZ3qPm5YOCmDeEq5ApZR6/KYGgXDhtmSc2L5Cu6JIuXJE1L9fdhNjsyFLpY8c70SN1SdbjOSnUw28rrkTdgtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941069; c=relaxed/simple;
	bh=7HjtdAatTMxO2fIKw9ilY3O1msot9+K4zOaYeTD0L+8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bhKu3Sdufpe9apP9y1yy7t7QIJrM3eyeGISXtdocdZZxN0DQ1YZkpwx3i36inUWj+zp36hm26apr/mQ7QodUB9oWuAvNe6wJt65YDFso33Qjh5EwRTLp3BABDKFxaVeUbEmHBVIqyMws0hIBfWJ9cTc9+NwwzCn5EZpANcpVvx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=nx0ym0oN; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1745941063; x=1746200263;
	bh=3roM25TOO3IQr63WcJp/bVj3et2BBAqHoVYsNwHrYPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=nx0ym0oN7ObSD7gTXP1+lE5B8wg/MG/t7eq41CNw5jHEUT3lDRB7riVJrM/BTZsCq
	 o++k7uXWsngUbcU41HIY8UGVICl3EvPFIu8g99+foWEcAJKoQEsJvAab0cB6/ji521
	 i3akn0xWjNyIbwFDFdOlq/HVmuI90YgzaWX2TFYQgV6br/FlQv10/PG3Uc1BwjML4r
	 KX/MaceA8uX9W0YKZt6Xts7hXbAXOQjAbipb12kQPQLDkasFSVI6u5uKoC2p56gV+r
	 NgpSbfxRv2z8JFQxq0HhWLXsSrIHbKTVwasOQOvpGTi0Dlx/XgaOaGdfxRQ6LA0p/X
	 yzCc9Sijbue/w==
X-Pm-Submission-Id: 4Zn4FW2fkCz44t
From: Esben Haabendal <esben@geanix.com>
To: "Conor Dooley" <conor@kernel.org>
Cc: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,  "Rob Herring"
 <robh@kernel.org>,  "Krzysztof Kozlowski" <krzk+dt@kernel.org>,  "Conor
 Dooley" <conor+dt@kernel.org>,  "Hans de Goede" <hdegoede@redhat.com>,
  <linux-input@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: input: touchscreen: goodix: Add
 no-reset-pull-up property
In-Reply-To: <20250429-effects-subscript-58eb41737816@spud> (Conor Dooley's
	message of "Tue, 29 Apr 2025 16:31:51 +0100")
References: <20250429-goodix-no-reset-pull-up-v2-0-0687a4ad5a04@geanix.com>
	<20250429-goodix-no-reset-pull-up-v2-1-0687a4ad5a04@geanix.com>
	<qql72NifdMmJKSRJmT2927URaXnbRAbz9Yjzn9lBrOwjka7NxVvy5YKJUSLmBp435aYJiTkPqeuW1hMDcKKC4g==@protonmail.internalid>
	<20250429-effects-subscript-58eb41737816@spud>
Date: Tue, 29 Apr 2025 17:37:34 +0200
Message-ID: <87selrt1vl.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Conor Dooley" <conor@kernel.org> writes:

> On Tue, Apr 29, 2025 at 11:56:11AM +0200, Esben Haabendal wrote:
>> This should be added for boards where there is no pull-up on the reset pin,
>> as the driver will otherwise switch the reset signal to high-impedance to
>> save power, which obviously not safe without pull-up.
>> 
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  Documentation/devicetree/bindings/input/touchscreen/goodix.yaml | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
>> index eb4992f708b70fef93bd4b59b9565123f7c6ad5d..21ac13046b6e021eeb403d854aabc945801dd29f 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
>> @@ -45,6 +45,10 @@ properties:
>>    reset-gpios:
>>      maxItems: 1
>>  
>> +  goodix,no-reset-pull-up:
>> +    type: boolean
>> +    description: There is no pull-up on reset pin
>
> I have to wonder, why are these system using the reset property if the
> reset is not usable? Shouldn't the property be omitted?

The reset are fully functional. It just have to be controlled in
push-pull mode.

Because of the lack of external pull-up, configuring the reset gpio as
input (to save power) puts the reset pin in an unknown state.

/Esben


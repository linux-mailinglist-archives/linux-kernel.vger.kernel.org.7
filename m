Return-Path: <linux-kernel+bounces-816131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB588B56FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875A03A795A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 05:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2EA20E6E3;
	Mon, 15 Sep 2025 05:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFLfLC91"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C9626F2AB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757915652; cv=none; b=J/07hkf1wqSwqkoWzpwgJapA/GsVis2LOhCCMyHE+MtUaUrRGOC23eHnPcf8F1bIo5SQjDM2SjwW+VLlFUPiuD2Upt93A4ZXSE1tEajlWJnq0DkpW3AXwy9U0wttbudsX6eZv77UVbR9lHS/gTHfnh4yuDa43HYi+Ggnoo9T9z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757915652; c=relaxed/simple;
	bh=kB9Xgjc7sC2n0PUcqqjH03i7/90qjI7OVjgcV04vYa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYwhtz5qEgrZCZJFERXAH2n/ESGqp0vaJtHOoSks+2opzuuA/ZSooPVoTtr3FLdMcNMmJbZXTJaz/IMThF38B8O92jq6UmL2Kfn8v6017tZ1QgOXLdjgpHlFLEWngG8N/MOSNZBFNRmz1bssohr0vOTj7lpwvUuHk6W5+ab+Apc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFLfLC91; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24b13313b1bso25136595ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 22:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757915651; x=1758520451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0xJriz50pVJxCGFehied0kNKF8rdeYvm/MI+kjVAGO0=;
        b=TFLfLC91Nb2w0ASEJe8nX4/7TRx5S7a1oarIFgdCvrouWzojV/7VuzWBOB7K72Xmro
         BJNKXyw8DiJpe9Q6B8GGLAAzlzt63RFQjOV/ZNKRQL9J7CmJJQHI45TyW2/M9n/Dv/jQ
         9PUf1M2S9u5K7F+N14lIYP7CPF4FCAHTEfyW+T7qQNr0CQS4RRNgGPVFu2vw0UzBY5Qs
         FDaZE5eFD2c7XIQN//ULhErfyrApE1iEu1bbJZ+4tNX2unbupZZCyAWGZu2O1M2JGy3C
         mZVvvaUvA6A0QhXSzhR5vGz7MM6V9urrEcRqHQBo+ojqzTNXBgk33u+fhJYxSO/N1B8F
         rpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757915651; x=1758520451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0xJriz50pVJxCGFehied0kNKF8rdeYvm/MI+kjVAGO0=;
        b=JvmLZ7ebU3GzMPrFZiEvA8QZgXom1gD5N839mgkQTyBpFAd7KP09lrmokZaiLKxUZL
         NsFQ00iExjsPra+7WuMYMeDWGr5KKCYdFOCBpyILzPuwBSTFdsIIGcbcy0idNRhft1xF
         Cj5ff3lqfZs1YSYTnCocIaPbIkxlbkMJQXvz68VFpLXzrePSz8xl7eq/wiLa17RxIb3d
         +q280dN7zIjEisyf+NKwsnTRppWSKJiKs3CkKbNDY0KWSVw1iSs5VoBVOieykNWZsWyR
         BxSLEIvDJ+89+nrtkllG565+KQ9VQksDrencbwBYwHVYiB0GGkDRWSQCYHvSHro63riy
         G4og==
X-Forwarded-Encrypted: i=1; AJvYcCVLADm7y6VhO9K/RJoqU/vhHkkjNkWS1HJMrgONqbnNFOi7+lAD3ITs7k088WuVLMH6vdze1/D+7xClxJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgYPxxqSOZzkgfvWek43zXNg9SaFQH8erTEVg491j0AWIoGup+
	mn2f2/14NvLwlKPCt3FmBoJat2PfkjKzEFclxj2DY11+MHYOHSPzVRQR
X-Gm-Gg: ASbGncvDBVD9kkUZfx3mfbzSOQf4cNrT4OaXYbXyzFf7Qey4NwedO5hSohzSmX5CLjp
	eddtb8X6qnuLYTyXQA0zss2/ou2nk84FJbRW/pEqOUhg6mpyQJ/uYfQOFbe6MYi2ieSY4DpGMnz
	IPbP/M17grKvE+aJbCMsx4aUnz0mudk+Tq3ewnIE3AORtPztFn9RuLn1edtUU9hSE971n7zURYY
	X0zn2WS6aJcxxGrY7W5pAfvsFxCly5yO+dxGeEUIWe2tARYfoPvpKjQsmtQXSYnYIS9aqubsf/x
	sLcesgMTlcrMlf7b+n35mU5pA0B2V1OMMD8c9y1g6X8v2O8OjQfG9eZVsCF24m/drP2sXFs5DXx
	GxTZanDYLvb+d04pwwCcufANQuxlCbUASANqO/E1kn4c=
X-Google-Smtp-Source: AGHT+IEJVYaEmuUexNhRqGO7tkehxpSdx8qtkzbg9zsJFEDr0LSZYoc24Ea58IdB11ffQysDsreYOg==
X-Received: by 2002:a17:902:e78b:b0:249:33db:34b with SMTP id d9443c01a7336-25d267641bfmr127285115ad.42.1757915650523;
        Sun, 14 Sep 2025 22:54:10 -0700 (PDT)
Received: from [172.17.44.75] ([49.249.92.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ae283fdsm116165945ad.107.2025.09.14.22.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 22:54:10 -0700 (PDT)
Message-ID: <ea15d474-dc40-4a58-948d-e8311ca9e2a3@gmail.com>
Date: Mon, 15 Sep 2025 11:24:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: add bindings for QCS615 talos
 evk board
To: Bjorn Andersson <andersson@kernel.org>
Cc: konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 tingweiz@qti.qualcomm.com
References: <20250909125255.1124824-1-tessolveupstream@gmail.com>
 <qq4aak33bn3mqxd2edu6zgkkshby63mmitg7zqkly2rj4c2lh7@4s7sndb7e2jr>
Content-Language: en-US
From: Tessolve Upstream <tessolveupstream@gmail.com>
In-Reply-To: <qq4aak33bn3mqxd2edu6zgkkshby63mmitg7zqkly2rj4c2lh7@4s7sndb7e2jr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09/09/25 19:57, Bjorn Andersson wrote:
> On Tue, Sep 09, 2025 at 06:22:54PM +0530, Sudarshan Shetty wrote:
>> This adds binding support for the QCS615-based talos evk SMARC platform.
>>
>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 03a7d3c92ecd..a5dbe6af68ac 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -952,6 +952,12 @@ properties:
>>            - const: qcom,qcs615
>>            - const: qcom,sm6150
>>  
>> +      - items:
>> +          - enum:
>> +              - qcom,qcs615-iq-615-evk
> 
> Can't we make that qcom,talos-evk?
Yes, I’ll rename the board compatible to "qcom,talos-evk" in v2
> 
> Regards,
> Bjorn
> 
>> +          - const: qcom,qcs615
>> +          - const: qcom,sm6150
>> +
>>        - items:
>>            - enum:
>>                - qcom,sa8155p-adp
>> -- 
>> 2.34.1
>>



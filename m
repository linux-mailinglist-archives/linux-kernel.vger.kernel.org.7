Return-Path: <linux-kernel+bounces-737100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869CAB0A7C7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5560D5A842B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37B62E4983;
	Fri, 18 Jul 2025 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1P8AJ5C"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8542DFA40
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852821; cv=none; b=khaZSFUm7FR/Z7urzQ4MK0C2wWqPdNUd+GriHPkVQDz5euniHN1f8LZbncJKKUtF2T3w5xoNhzsCcrjH6JCowkTnz0Y4q3U8i3F41vrH7R/bdImvUCTiMocTceeJKb0fFpkcPl4RwANZiIrp6/7/e2w75faYQchvnhTujvYx+1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852821; c=relaxed/simple;
	bh=NUPPjzQw7dGgTkvCLFi5dWXDBs4P8eRQSl4qCNFSjo4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=st92cs3tLdwOgJ/oydggXZRMyPKI1g6WG1rSmWEyvnoIaI53wZ3BKAhh+QbHyLz7m4o5tTsf4xlM7lQ1G3l4n3GweZwHnu6rAJbvMA+nzUfa0qGM2gF22Kc90wkrBQN3dQGWDLmeipjoOTFJuQzR/o342i4KcGwtfmEP5jqN+iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N1P8AJ5C; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-45600581226so23284755e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752852818; x=1753457618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5mLNgva7o4H9P0w+y2sRHhUB0YorutSqhR/DNWyiJiU=;
        b=N1P8AJ5CAxdBLZZ392Wls4DcyXShOATcZwByQS0JBZlgvHPSTxFVe8oC3mpUa6A3Gn
         rtDnyzzjzQbMs4Dqws8yo2Jj+gPMrql+DL1CGvAhnnuu6g0xiPZVCtjOxde3sq9iTUgF
         qT3TZmjoz08MBh4tJ3aHpGOb3lsbiG+1QFQcx0E+drBt1Sgsf5cITQETrZRbgGLtP2BX
         ia4Yaokk427PrgOJN6Z1Cc+I48aMQbeSiRTP5KAdoB2Fzp/tHar3tiof/i99aWqPs0jc
         GytHCn+8iHnftQgPdoC3KDMLx1pKMFjGeNYvEeuyaIh4mkr14MR12/wkYZeM416aa65I
         q1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752852818; x=1753457618;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mLNgva7o4H9P0w+y2sRHhUB0YorutSqhR/DNWyiJiU=;
        b=SF8shXvrJsqm906yv/eBBDIAYvDtKXqrN0IK6nHAYBfQuqmVXoB6sNZ4geH1F25gx4
         Jz4OBRA0CR47GFNQAJrAhXoCCJTGfzYws+9TwD9hMwXzX7SWbdJLwjYwJeeAD+sSwLDm
         XqwR3yaPVD/OzILUtoB6XQKp5Ha10dMjOThplxWP+BNBonrKirXCYjiWMt5wrZCqCHXT
         OILHf4323C0tmxgTxR7dlcTZa54A+EX6vMlIU1h12k8tF7rWNNOiux405un7W1ZdcqLz
         64vnYx8NtBLgy1D4VDpT2Uneq85i0W/BYqu6dyYQeF4Q37liiR2In5ZVqHRn0moWkUpy
         4gPg==
X-Forwarded-Encrypted: i=1; AJvYcCUhjZDfKKcyLEoTThMQlUtme09lub6NMguieBJqMRY/QX+P2/bnjq0xsnHtk2opEdjCKyQZAwOTHrQYhkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYCwzO5jFB/h2dlrBO6Gg+wI75gRXEctsRc8tktNKPltyL0Sb7
	NV4ZTWrJ3Qy4pm1WMwq5U2vwhfEpntMNbXOW7/iiTVv2gvOSj6iMBbFIYYkCHn4+kbc=
X-Gm-Gg: ASbGncsoVkGs4ASOCQSsmU01BS63QMQXIBTrzJq/AO8pLY6YsNkKAAu7XWEduKlguqT
	AsFA7ittuvy7NfPHy2if4VDv/Du3rZtctN25wY68g4owWlAASiYNPpvfG8Y2JshMjmfw9GHcjKy
	9HRcQJ7rDYQ5juPptSi7fe48tOhk6qYNNcd9qbOGDLWF2E+RLYEe7WJMiBSfhyX/zeZdxJZttNd
	GcchQC4lFYJWJh9smssFCZbMwygjvLBtQUly/6oV9rjLexehAEVGuyTLbcjJQdicDDyOnxCkrGs
	OfUSG1G5LtaTdBuZrQ7FaKCh1H71uY0OLFiR1QCPNIV/EqHSCcQfEtrJ7OYr3EefcLCaznjcvBP
	1xOI876Wc25cCx5v10XQNT+cf6XWATVuFWb+AISUlCPEf9isJ6TCrCddtY9i4LbQ=
X-Google-Smtp-Source: AGHT+IEOv5eYenwRTG2hZckYeMdjm6KgDbHwVUbcn3C9vLpAWVl0GFbqjTSswGAchOI7AcxMI/rkRQ==
X-Received: by 2002:a05:600c:820f:b0:43c:ec0a:ddfd with SMTP id 5b1f17b1804b1-4562ed57638mr102816315e9.6.1752852817737;
        Fri, 18 Jul 2025 08:33:37 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bc6fsm2227347f8f.28.2025.07.18.08.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 08:33:37 -0700 (PDT)
Message-ID: <316007b6-6e24-4095-be24-fbd4ae7d425c@linaro.org>
Date: Fri, 18 Jul 2025 16:33:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add Dell Inspiron 7441 / Latitude 7455
 (X1E-80-100)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Val Packett <val@packett.cool>
Cc: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716003139.18543-1-val@packett.cool>
 <a2681844-a96a-465a-a48d-49e1ede526c6@linaro.org>
Content-Language: en-US
In-Reply-To: <a2681844-a96a-465a-a48d-49e1ede526c6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/07/2025 11:53, Bryan O'Donoghue wrote:
> On 16/07/2025 01:26, Val Packett wrote:
>> Since v3[1]:
>>
>> - Applied R-b tags
>> - Skipping the eDP panel ID patch now since it's been applied
>> - Fixed the last remaining '-names before -0' order issue
>> - Changed usb_mp: keep the unused PHYs enabled in the DT
>>    (to let them go to sleep), like how it is done for the XPS
>>
>> [1]: https://lore.kernel.org/all/20250706205723.9790-2-val@packett.cool/
>>
>> Bryan O'Donoghue (2):
>>    dt-bindings: arm: qcom: Add Dell Inspiron 14 Plus 7441
>>    arm64: dts: qcom: Add support for Dell Inspiron 7441 / Latitude 7455
>>
>> Val Packett (2):
>>    dt-bindings: arm: qcom: Add Dell Latitude 7455
>>    firmware: qcom: scm: Allow QSEECOM on Dell Inspiron 7441 / Latitude
>>      7455
>>
>>   .../devicetree/bindings/arm/qcom.yaml         |    2 +
>>   arch/arm64/boot/dts/qcom/Makefile             |    4 +
>>   arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi   | 1666 +++++++++++++++++
>>   .../x1e80100-dell-inspiron-14-plus-7441.dts   |   52 +
>>   .../dts/qcom/x1e80100-dell-latitude-7455.dts  |   53 +
>>   drivers/firmware/qcom/qcom_scm.c              |    2 +
>>   6 files changed, 1779 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
>>   create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-dell- 
>> inspiron-14-plus-7441.dts
>>   create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-dell- 
>> latitude-7455.dts
>>
> 
> Just tested on the 14p this updated version seems to work just about 
> fine - or no worse than previous.
> 
> Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Ah I was booting my old dts with the spelling mistake "inspir I on" 
booting the insprion.dtb here is a no-boot for me.

Please hold off on applying this, until its root-caused.

---
bod


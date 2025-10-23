Return-Path: <linux-kernel+bounces-866510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E252BBFFF64
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F265A4E22EE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0F52F7471;
	Thu, 23 Oct 2025 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="r7AZYcWu"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291330149F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208676; cv=none; b=peISZK6oRd6nyMW4riUdztkwCMiiNPljpnDp/zOngmQK51UfYwQILqMqrkV89t1ie2Ndl3P42xsv4eyO1mSzZVqXKelH6/0oNrACfPcaSnZYST0brffE67LkmdGe3h48hMvguw8KpIa2vJDj5g2YXojqA1tmrH8J2zZg2a51crA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208676; c=relaxed/simple;
	bh=VZznkxUfOBBjwHVbcPT69mPGH8TLJ3qlknTOpaEzyh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Es7d7Z/Hl50nrFsZCVIMd/TPPUDIW/4ou1AR120pgo7vLONkEGk+iafRBuLcmGKexEZfrrFKLwdVJEJoEqdsVnQglv7smKvCGJ1bMAEjkbHDr+GTat7cH3f8PZiV0wwGFCJJZ4EwGojPGB15E8XqAwerGglKvxW0vHF06rq1eB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=r7AZYcWu; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso119177466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1761208671; x=1761813471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kylES56a95Zr7XFZY/19713ISQDXB6XnworKEnMUaPo=;
        b=r7AZYcWuK1BvlxQDGTIu2Y2lA+oWbUQPvEX42vMD+1hP2Si5AzoVdZm5lvwXlZq47C
         MfdxUCGIGORJZIZ+AECc18BXtmkazScbzkYG10K4ELSvvOHf/wP0Ixf8vGf/m6jy4Rs9
         va9OFzrytZgALeeK473tWrn9a9KYXjx3o1konxcmBCrZ1DOQHRNaU+1OGmffKCJe2xOF
         5KV51PECPj6wf34HvyMVL+Z8k2d8nf0qNzi181NsNfr70uAy0GvJvnlU4au9jtAjzUYh
         XSx+PDRJccKZmUidcSmCCjDYtHNkV7FzWg0q6Bx2abuURC99Jl/NZcvGzgDTbeJ8EZVJ
         Jd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761208671; x=1761813471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kylES56a95Zr7XFZY/19713ISQDXB6XnworKEnMUaPo=;
        b=jyMc/hkrnEKNqAb65dNUboYKjs4d3KPXP1/rwQtkcx6B9ioacT9H0mAFy6PgErQiZM
         SgS/0l1mZhCT1Pca8FykmgMFvIRx/nQq5cFrUuNibAqyQxjFLAMhZwk6Fso20B9FVsEJ
         Jt39QgfJCgaZ+sKHMZUbKCRPROAd2UItq8+05G/48xYjnHBTIdlbEA/iPrTM5HUnja9G
         LxZBWPhdVz4QYZj9mfZ1N0QS3V+zZG4oLJxUmRfk8RPe9S9687/oTpn58dVqQNT0WA2n
         zebvSouayadRCxfb6Z3s4OXtXAorcqZ1HjfSW3RngEZRPlxJCym8GwjCk0P551G8Natd
         pygA==
X-Forwarded-Encrypted: i=1; AJvYcCXLyAPurm62ExXTLllxdetqD+XRggZsPxOW/v9mns3Hw67bDLKpDJq2aKTcfkCGqgwhFfAKzU4DwbzSW4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnfWgu2PlpG2kWgwwRDI+BDJKgd9t6j7xfcRUkDgSNzloIv/mo
	Obl/PyBWXT3JFVnKmnyBRnM4Qlv5jY5e3QLsVZwNI1DwdOC25vobv1jIUJC3KgDdZNg=
X-Gm-Gg: ASbGncsppIOWQd6/Sl3lfbu6yTmh7vCOqaYl40UOu+se8pp4kBUaVaQMK5KRzcBBiTt
	yNF6zCdBxx6W/76RCFRXcvUL9wY1G66LoTUhLbsoSq1XqDISFFYgzkb3ap80vXkJv5Gq+K0DwCG
	gM+tMSOt/tmBtSQKfdMQR7uiWOqMVMkUK9idvlDIQDQYhh9izhTUfB/EnqXL6w2yosr+3kMI54E
	KSemf68rtPWA7rP2VZEkiyaPCHnJqOM5fG9KLRj8HzZzzS6suK1ZVbBOWR3kdlVWpZlAUu8lpVt
	l66agn/A1MPAx650shPbKNmz19swL2tSb8VxrMUo7SybJPl8jidjOqoMXy6T5KYIfYH2FglAczG
	zySMrMts6rT8rHg1SZmxHMD9zUFqiJp7U4zJVdX7VtFSj/aq4lhxJHPp9QKwi4ihrxopZsA6ghD
	jfE3KJStG19dIOYOyZA/vvUZanha57u1+jsYf+vfzjOge56hrDvcltSPKlzw==
X-Google-Smtp-Source: AGHT+IEF207BQMo0Dq88FSaSGXgKTLyR81jf+3IPYp4cFuUOJkWkUOJ0k7niMWfu/ZSG5bxpQZi0ZQ==
X-Received: by 2002:a17:906:c2d0:b0:b6d:2c92:a5f with SMTP id a640c23a62f3a-b6d2c920ademr642397266b.3.1761208671128;
        Thu, 23 Oct 2025 01:37:51 -0700 (PDT)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5144e4acsm151529866b.63.2025.10.23.01.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:37:50 -0700 (PDT)
Message-ID: <cd083217-27b1-4959-b80d-0189f178208d@fairphone.com>
Date: Thu, 23 Oct 2025 10:37:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Add cam
 actuator
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Tianshu Qiu <tian.shu.qiu@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20251009-ak7377-driver-v1-0-29e4f6e16ed3@fairphone.com>
 <20251009-ak7377-driver-v1-3-29e4f6e16ed3@fairphone.com>
 <c1d09672-e8a4-473a-88dd-fc91e81aea52@oss.qualcomm.com>
Content-Language: en-US
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
In-Reply-To: <c1d09672-e8a4-473a-88dd-fc91e81aea52@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Konrad
On 10/22/25 19:29, Konrad Dybcio wrote:
> On 10/9/25 2:23 PM, Griffin Kroah-Hartman wrote:
>> Add a node for Asahi Kasei AK7377 actuator, used for focus of the main
>> back camera sensor.
>>
>> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>> index e115b6a52b299ef663ccfb614785f8f89091f39d..49654f0f914fbe18080d2f55bb6877c8ab7baf0e 100644
>> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>> @@ -616,6 +616,13 @@ &cci0 {
>>   };
>>   
>>   &cci0_i2c0 {
>> +	camera_imx800_ak7377: actuator@c {
>> +		compatible = "asahi-kasei,ak7377";
>> +		reg = <0x0c>;
>> +		vdd-supply = <&vreg_l7p>;
>> +		vio-supply = <&vreg_l7p>;
> 
> The dt-bindings suggest vdd is 2.8 V and vio is 1.8 V (at least
> on AK7375, although this isn't stated explicitly..)

This AK7377 is integrated into a JHS-M15342-A2, which only takes in VDD 
as a power supply. VIO was only added to satisfy the dt-bindings, as we 
are not sure what the exact pin layout the AK7377 has.

> L7P on FP5 is 2.7 V (default) - 3.0 V (which you should probably
> tighten to the actual operating value), please double-check this

I can confirm that L7P is supposed to be 2.8V on the FP5, I will update 
the dts in my next patchset.

> Konrad

Griffin


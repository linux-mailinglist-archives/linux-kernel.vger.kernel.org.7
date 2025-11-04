Return-Path: <linux-kernel+bounces-884163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FCFC2F7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 07:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061594200CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 06:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143A228C035;
	Tue,  4 Nov 2025 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfbsVTWy"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934D51E8337
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 06:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238992; cv=none; b=kMKA51GpZ8Eu50RzsElap1vrUgrajFM+dPTzAvjmWosbqFJLVyw99Hwa29E8jbXCrdsGoIrF5Y0wRcEXpJdmxcH+N/8dEIH+DZiIgKyXcLdhT4J7fPZAWiA/QmDhQxBEfTC29AYRjoacgQIP3VvHy2T55UxQD2yLF9IlJPd+5o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238992; c=relaxed/simple;
	bh=NJOCVz5MroppKnut51FiDQEHUPBOq3DOVGvw8aLkcug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mciZSAeEtonhldybkjOsOQHXnZe6dUXOnHQeNMxzQDEHg3Rv5gB/jNo7ouRiJzlxIDCsdacCjzX29xLISj0F0P/G0normsFEr+NYPApm/5LMFKlGM5rBSUnmfVy6aLD1AeoIQ4jwQeO4LsY/amHCVUm/4ni7Ub7+F+d2+HGZadY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfbsVTWy; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781997d195aso3891389b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 22:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762238990; x=1762843790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tW/53RW6rEekhtt+xO+zvnpZMbXy1q9vpyRxFPgykUk=;
        b=KfbsVTWyTv/xIr1VtK+073Pj/0ncX+yeIL7k5zHtfddRgA2R/FUwQaIJjoPy0RGaEa
         ZIe4seEyO8Uw6ykuTSXVfLI/oAUghVDzQOQ8qWwnPIlijvU07yrTU3sYtzSNZlZoYaqx
         QJ4HxLX4WHxWy44k/7x5PLcyYK1HMyb573gDS/NcGCZD6iVJE9nMAeim3g55YZgQEHyD
         yKbKKR8D9p7XLNt6mAHDtEpsYIe3O0nVqSHi0tmtA8px7+N/vVe3lomHksdTwtavVi/p
         RAuyfpduFtjAEQ8dPY/AiM5ryVdM5kVSuup89uDOLJ+nc/+WvctOOL1bwScOTB1e0mnV
         SMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762238990; x=1762843790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tW/53RW6rEekhtt+xO+zvnpZMbXy1q9vpyRxFPgykUk=;
        b=dVCpJ/aeZawyOIzbSw8lBnEMlj9H7n/LkI+4zFuxtf5W2Vsi5j3CvSHDj9MNTOfPaf
         39S84n03SDUNMgySjMW7eFaEAUS+/QKRIowkAcLhlkb0+uuoYeoiSoLgOSy9m/QS9/v+
         DTn2654VVZ1rD5i/+7TXDyQYaBpFGhOHw0nypLC1rjwmL9DTk6/1JNEotXBU3Cv3b2cH
         iIsoPoLcNBqlq726/J28ELTOuYFvqwiEw3rlv+gIml57iz8S10O0fDuXvvkhT974lrxW
         4kf6w+hXfU1cRWzY0P9FoBT0qppsKKKaUCGOQPaWZwOqyztXjhw5azH2GTD5KOvgJLG1
         7g4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjQc6k23/DeV7yHSnHbBlbq6tmI2syq/cqbBPOoHEHQd9zgIychBsWfhVfcYxLEaTnYb7HHP9Ihubr3mE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1rdfM/siUy4wTE7xtbYQeteZNgxQibsJqUbe4e0AYODmZuiLD
	0hcCwjQuEqetBfhMiiM598gAX6399Pys77NcMFaSLvtO6XlzsEQ2i3xO
X-Gm-Gg: ASbGnctLKa2IlinE7w+IkK5tgnl0fWzh4k5HoAktl+GaGWFdMu/aFwk0nzigKTKXRed
	LT/Z/ayoEyMIyf7mTcYt1PFfxJxZ5LzHW/H4dUCXhhka8DcogNA/r4VpfCy5Wxxgox20D3hjmY1
	48y7avE83yNebPEGRCq2JP5PyIh3GRrohs7AFJHOrwMxXgh5WJK+JeD9+B02gqx6po1Qz89MLF2
	Zh51r6oqoBJ9IMd46ePjfnTIPZDbbuf/Q9kFl0hkc1nXixGz1UjcHpcmGxsQETPONA8UU8vetg/
	viGYW3aPBuuFUcpbwQ0deP2kmNFfzO7bdRzyg5SvUIRmiPa9tRxntAxU4aWazPN3E6rPY44Tq8L
	/EadY8rXTJkicGq9pqgz9aRcSAN8L87B+7OlMhKSQyrMW1cB3C22TmMcLNpx0/JyzTEhLqAC+DM
	HfPGcyjMA3k1w+
X-Google-Smtp-Source: AGHT+IGrm+tNJtPLCyzMtrvqLfMaKtU4RUb7+6lmtxWS+dvTZ42AjXUAivx8MB3Fr7QZLEDtdIpSFQ==
X-Received: by 2002:a05:6a00:99f:b0:7ac:3529:afbb with SMTP id d2e1a72fcca58-7ac3529b5bdmr4022169b3a.20.1762238989735;
        Mon, 03 Nov 2025 22:49:49 -0800 (PST)
Received: from [172.17.49.162] ([103.218.174.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6241aa3sm1627821b3a.57.2025.11.03.22.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 22:49:49 -0800 (PST)
Message-ID: <52c27c60-65c2-4a36-b1c6-3edb7e97969f@gmail.com>
Date: Tue, 4 Nov 2025 12:19:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] arm64: dts: qcom: talos-evk: Add support for
 dual-channel LVDS panel
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251028061636.724667-1-tessolveupstream@gmail.com>
 <20251028061636.724667-2-tessolveupstream@gmail.com>
 <fvtwdsthi242vxxlaqsbvqec4xkduch3fcslwqsjzkz4fidewn@mku374rrwlp7>
 <90185600-c08d-4548-8e66-16d3d0de8765@gmail.com>
 <3genyggxae5ejlpi2k2zflliaujdov6f2nd5nppzxtg7fmerff@52dac4oh2c3z>
Content-Language: en-US
From: Tessolve Upstream <tessolveupstream@gmail.com>
In-Reply-To: <3genyggxae5ejlpi2k2zflliaujdov6f2nd5nppzxtg7fmerff@52dac4oh2c3z>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 01/11/25 14:13, Dmitry Baryshkov wrote:
> On Fri, Oct 31, 2025 at 02:42:05PM +0530, Tessolve Upstream wrote:
>>
>>
>> On 29/10/25 21:18, Bjorn Andersson wrote:
>>> On Tue, Oct 28, 2025 at 11:46:36AM +0530, Sudarshan Shetty wrote:
>>>> This patch introduces a new device tree for the QCS615 Talos
>>>
>>> "This patch" doesn't make sense when you look at the git log once the
>>> patch has been accepted, please avoid it.
>>>
>>> Please read https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
>>>
>>> Start your commit message with a "problem description", describe what
>>> this LVDS talos is, why it should have it's own dts file etc.
>>
>> Okay, will update in next patch.
>>>
>>>> EVK platform with dual-channel LVDS display support.
>>>>
>>>> The new DTS file (`talos-evk-lvds.dts`) is based on the existing
>>>> `talos-evk.dts` and extends it to enable a dual-channel LVDS display
>>>> configuration using the TI SN65DSI84 DSI-to-LVDS bridge.
>>>>
>>>> where channel-A carries odd pixel and channel-B carries even pixel
>>>> on the QCS615 talos evk platform.
>>>>
>>>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/Makefile           |   1 +
>>>>  arch/arm64/boot/dts/qcom/talos-evk-lvds.dts | 128 ++++++++++++++++++++
>>>>  2 files changed, 129 insertions(+)
>>>>  create mode 100644 arch/arm64/boot/dts/qcom/talos-evk-lvds.dts
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>>> index d5a3dd98137d..6e7b04e67287 100644
>>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>>> @@ -307,6 +307,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8750-mtp.dtb
>>>>  dtb-$(CONFIG_ARCH_QCOM)	+= sm8750-qrd.dtb
>>>>  dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk.dtb
>>>>  dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk-dsi.dtb
>>>> +dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk-lvds.dtb
>>>>  x1e001de-devkit-el2-dtbs	:= x1e001de-devkit.dtb x1-el2.dtbo
>>>>  dtb-$(CONFIG_ARCH_QCOM)	+= x1e001de-devkit.dtb x1e001de-devkit-el2.dtb
>>>>  x1e78100-lenovo-thinkpad-t14s-el2-dtbs	:= x1e78100-lenovo-thinkpad-t14s.dtb x1-el2.dtbo
>>>> diff --git a/arch/arm64/boot/dts/qcom/talos-evk-lvds.dts b/arch/arm64/boot/dts/qcom/talos-evk-lvds.dts
>>>> new file mode 100644
>>>> index 000000000000..7ba4ab96ada6
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/qcom/talos-evk-lvds.dts
>>>> @@ -0,0 +1,128 @@
>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>> +/*
>>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>> + */
>>>> +/dts-v1/;
>>>> +#include "talos-evk.dts"
>>>
>>> We don't include .dts files, split the existing one in a dtsi and dts
>>> file and then include the dtsi here. Or provide provide this as a dtso
>>> overlay on top of the dts.
>>>
>>> It's not clear to me which is the correct way, because you didn't
>>> adequately described how the SN65DSI84 enter the picture. Is it always
>>> there, but not part of the standard dip-switch configuration? Or is this
>>> some mezzanine?
>>
>> Thanks for the feedback.
> 
> You didn't answer the question. It was about the hardware, not about
> DTs.
> 
>> Currently, the Talos device tree hierarchy is organized as follows:
>>
>> talos-som.dtsi — defines SoM-specific interfaces
>> talos-evk.dts — adds carrier board (CB) interfaces such as MicroSD, power
>> button, and HDMI
>> talos-evk-lvds.dts — enables the LVDS display (includes SoM + CB +
>> LVDS + disables HDMI)
> 
> So, is LVDS a part of the standard board or is it a mezzanine?

Yes, The LVDS SN65DSI84 bridge and panel connector, is part of the standard
board. 
> 
>>
>> The LVDS and HDMI displays share a common DSI output, so only one 
>> interface can be active at a time. At present, talos-evk-lvds.dts 
>> includes talos-evk.dts directly so that the base SoM and carrier 
>> interfaces (e.g., MicroSD, power button) remain available.
>>
>> However, as you pointed out, including a .dts file directly is not
>> recommended upstream. To address this, I am considering the following 
>> restructuring options:
>>
>> Option 1: Introduce a talos-cb.dtsi
>>
>> talos-som.dtsi: SoM-specific interfaces
>> talos-cb.dtsi: common carrier board interfaces (MicroSD, power button, etc.)
>> talos-evk.dts: includes talos-som.dtsi + talos-cb.dtsi + HDMI
>> talos-evk-lvds.dts: includes talos-som.dtsi + talos-cb.dtsi + LVDS
>>
>> This approach avoids including .dts files directly and keeps the carrier
>> board interfaces centralized and reusable.It also cleanly separates SoM
>> and CB content and is consistent with how other Qualcomm platforms 
>> structure their EVK variants.
> 
> This sounds okay, but please respond to previous questions.
I hope I addressed previous question.
I will go with this option, and update v2 patch accordingly.
> 
>>
>> Option 2: Move CB interfaces to talos-som.dtsi (disabled by default)
> 
> Why? What happens when somebody reuses the SoM with some other base
> board?
> 
>>
>> Move MicroSD, power button, etc., to talos-som.dtsi with status = "disabled";
>> Enable these interfaces in each top-level DTS (e.g., talos-evk.dts,
>> talos-evk-lvds.dts)
>> While this also avoids .dts inclusion, it may make the SoM DTS 
>> unnecessarily complex and less reusable, as those CB-specific 
>> peripherals don’t belong to the SoM hardware.
>>
>> Let me know your prepared approach here.
> 
> If you yourself don't like the second option, why do you propose it?
> 



Return-Path: <linux-kernel+bounces-744021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45640B10705
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0316F7B7BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E93257427;
	Thu, 24 Jul 2025 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fwvQs+l5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD47255F33
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350658; cv=none; b=D/4wUuoGlmd9O/Sx9lmSYv2mTyTMuQHJ5dIRFHPy5HNpgZ4SCAPLBLISbWim+wnqClkzDfQBsQ7CDcUwcWP0mwbCrSyHsO/mkpdhVEgQaGCQS7CwTZ7mhFSYKURxkbpRejf87S8ASrowqhBbDk18urfbaXk3+SUbS+LasA2TYUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350658; c=relaxed/simple;
	bh=4wvMik73OSV2CEqOTXqPlx9t14lnBK/J7SXVWLD539I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTYFyOm08Eur7ZdkF2DezN63VVsq4Y8mmgH/3Voe4wkbkP1wRgmlJeAw8iVDCQArBfk7AyMiGiGebp/akyu1oergjvnZreH7pBI3AS0y9yN2EqTg4mYmYhiIpao4Y3PUkoxGRTHZf1Wc97hc6mbIpFT7cnxcQ/vGCwXMd1vXLCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fwvQs+l5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6dA7N025292
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xNeKHGonkT5h2RvkiyvQ4JGa2uJGQzDvErKLXyO9F9g=; b=fwvQs+l5P2btGpdw
	iLMWuGSpy1E0KkFb2i1nVW38Zr86RgUNMiC2DJvbiHW1cr5BUMNtyodt7qpPxo+q
	1xbOmVC1+Nk/G+YdBv7IbUukxxTGKMspp0Wm3rWXZWsRS7muA4UG/M798IQQotTJ
	UYF/ZMJnxmXhq7ekU5rmoYr9xasTo2pHvMylLcx7Qol9esFf2ntuzCCyhal0l0fu
	ugS44uzpZhqD6yNd3pUkR43L/AjcHjcVRxdmStRqX49WMMKNoSdUZdLZP7z7XNE3
	V6oOHFTDGDcYWOxGu1RJN0j7GUYZ5lbrWekWStTahQgugQT/n3hTPZOCNLVSXpvP
	zRrTng==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483frk0jpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:50:56 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7070970cb2aso14411956d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753350655; x=1753955455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNeKHGonkT5h2RvkiyvQ4JGa2uJGQzDvErKLXyO9F9g=;
        b=U2U7owhLHo/lxySfdrlX2o7kE+ri57b/f1OMjS6rONu9MpQXB+NJ+Z9BY6214YHScW
         Nw7OPo5nBROiDG4Z2azAWfgMVr8P4bUf7DZutVfZhVfiDt/FqEMjp+60Ytu1t7WqSEEu
         4mmHAgDLm37GGsD88HtJuOLM242DfMgm8xrGbvqe595PjpMbIp41bcoBQTbEe+bUDhQY
         rtzud56FbeQ8BApxOZY+vaKYHqZ9BaYRFtTZuK328dO8sq3v5wYdQc10viPkMjO+LVXf
         TzFePdF3ZC0xl65w2AokPicEOJGylpATxPpL6homQGi8e12UIhrH4fhkYy2Yb+okO5wX
         8BVw==
X-Forwarded-Encrypted: i=1; AJvYcCUYyIm6yOBBu7zg/oW234S0bypdLD6qVCUrch19kp49Qj6Sw5fo/1OSVtFSl3KFNFtpXPs7+YW6TLGk0gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ7pvUy7qkBM3tvFubcOY0dFSpLnh1GOLCf9SJ2gd/YuQP42KX
	Jk1m6WazA2ZkwH40AHUc0qquoR21knHaZ7c/Ve+fIgnZMnPvR7pdCtEzyvJ99yJEOrArd5WoTW/
	UMSE7C/tB6v9xQE/Pd8n2waCabEZY27OtOIMqkpKA45kHHEOnxfESklzTD3/YWBU+S+g=
X-Gm-Gg: ASbGnctb6RFPTOxZXQnWnjTgEtjKUpB2drUZ5fTsTNnrK1x/ATL01ps74g7CVpcTRgL
	Sc75Ri7xyKCDJqNDrfBjEDsRMOBZ7AVzExRgqdpXqdJyuix+YN0lTckcAuH9qnJF3jwexwEREFK
	JEYk8h6apP7N4CDPVa5G7EXekWClBapBaBnluYUZXKRs+AzkFy5VtTNEahbrTQ1of6wom3yoryY
	6YO0Hc314fdGp+PPkhI8UTVD9KDPtD5jGk8Q99h6EAUGQLjac/QbxMakJI6ZDHuv8cVGAd7xBNf
	PcHdT6K8ArwAnIQhaM9JswpgmDAj+Pslh4JdbFZ/IGDvupXM9P2gvNjhrepBMNsV9v4=
X-Received: by 2002:a05:6214:767:b0:6fd:cfe:ebab with SMTP id 6a1803df08f44-7070058cc6dmr90659696d6.7.1753350654274;
        Thu, 24 Jul 2025 02:50:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeU31vHKHIOSi63Yzpx4a6r6m3m24wxg9LNxc881kubkz6Bhs1a8eXFJj6MAXrH+z9RIoqcg==
X-Received: by 2002:a05:6214:767:b0:6fd:cfe:ebab with SMTP id 6a1803df08f44-7070058cc6dmr90659306d6.7.1753350653677;
        Thu, 24 Jul 2025 02:50:53 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458705c4d91sm14456695e9.23.2025.07.24.02.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 02:50:53 -0700 (PDT)
Message-ID: <d0fd03c2-141b-47f5-8133-1b09d40d082c@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 10:50:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/23] arm64: dts: qcom: x1e80100: move dsp audio nodes to
 dedicated dts
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250723222737.35561-2-srinivas.kandagatla@oss.qualcomm.com>
 <aIHfPZaRmTjI7w8D@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <aIHfPZaRmTjI7w8D@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3MiBTYWx0ZWRfXw2dXRKO6Q5VE
 rI9zwRkxFKDS15uLcX+zHSnWlAP3+o+s/3Y2qtIf41uD+55p/vK3/4IeMAi8fwHEjtdkxw6otMo
 e0itb/uj4uT1g8EqRLuURKNlWqUZGoGEg5v13u9i1ekjVO2xjlrG28XaLaA6RZ2DHPMPfOvZr7Y
 DSLLEYJtaSPg5OKD+49AlNK+kbpcG/cz/JB5TxLVY//MEgTusYG5I61TKDEW9KEpE88d/0ytmmS
 t3W867OfGFKRruageP94j14Rus+YDimjRMdi+r1B+/PHSultUSMJIO7CnTgbTyyc6KLt/46wQn/
 7qeWq7ggPDUmNfinNeCl/sqjTzH8ij8NUe9qSTqXsEF4cyYNzVlT1C5rneM6rlqg2YjIQMFl5zz
 UTPHbsetvZIF6mXjnc/jcWFXL1wzl2IQau1vZe9GQqukejN5lF9hhBGs3bp+2Ww/2US1qZpA
X-Proofpoint-GUID: P8RhCfs8ty3xR8GI_gY2LW7BDwMMOYp5
X-Authority-Analysis: v=2.4 cv=WbsMa1hX c=1 sm=1 tr=0 ts=68820200 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=7Qcv1IfLpfmIBQ-b970A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: P8RhCfs8ty3xR8GI_gY2LW7BDwMMOYp5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=679 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240072

On 7/24/25 8:23 AM, Stephan Gerhold wrote:
> On Wed, Jul 23, 2025 at 11:27:15PM +0100,
> srinivas.kandagatla@oss.qualcomm.com wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>
>> All the device tree nodes for audioreach dsp are duplicated across all
>> the SoC dtsi files, Move this to a dedicated dtsi file so to remove some
>> duplication, make it consistent across all device trees and also make it
>> easy for new SoC's to add audio support.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> ---
>>  .../arm64/boot/dts/qcom/audioreach-audio.dtsi | 45 +++++++++++++++++++
>>  .../boot/dts/qcom/x1-asus-zenbook-a14.dtsi    |  1 +
>>  arch/arm64/boot/dts/qcom/x1-crd.dtsi          |  1 +
>>  arch/arm64/boot/dts/qcom/x1e001de-devkit.dts  |  1 +
>>  .../qcom/x1e78100-lenovo-thinkpad-t14s.dtsi   |  1 +
>>  .../dts/qcom/x1e80100-asus-vivobook-s15.dts   |  1 +
>>  arch/arm64/boot/dts/qcom/x1e80100-audio.dtsi  |  6 +++
>>  .../dts/qcom/x1e80100-dell-xps13-9345.dts     |  1 +
>>  .../dts/qcom/x1e80100-hp-omnibook-x14.dts     |  1 +
>>  .../dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  1 +
>>  .../dts/qcom/x1e80100-microsoft-romulus.dtsi  |  1 +
>>  arch/arm64/boot/dts/qcom/x1e80100-qcp.dts     |  1 +
>>  arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 43 ++----------------
>>  13 files changed, 64 insertions(+), 40 deletions(-)
>>  create mode 100644 arch/arm64/boot/dts/qcom/audioreach-audio.dtsi
>>  create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-audio.dtsi
>>
>> [...]
>> diff --git a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
>> index c771fd1d8029..1d8a75fba301 100644
>> --- a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
>> @@ -11,6 +11,7 @@
>>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>  
>> +#include "x1e80100-audio.dtsi"
>>  #include "x1e80100-pmics.dtsi"
>>  
>>  / {
>> diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
>> index c9f0d5052670..19b993fdd17f 100644
>> --- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
>> @@ -9,6 +9,7 @@
>>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>  
>> +#include "x1e80100-audio.dtsi"
>>  #include "x1e80100-pmics.dtsi"
>>  
>>  / {
>> diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
>> index 2d9627e6c798..6df3ee553bc7 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
>> +++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
>> @@ -10,6 +10,7 @@
>>  
>>  #include "x1e80100.dtsi"
>>  #include "x1e80100-pmics.dtsi"
>> +#include "x1e80100-audio.dtsi"
>>  
>>  / {
>>  	model = "Qualcomm Technologies, Inc. X1E001DE Snapdragon Devkit for Windows";
>> diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
>> index ac1dddf27da3..cf2cf3e520fa 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
>> @@ -13,6 +13,7 @@
>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>  
>>  #include "x1e80100.dtsi"
>> +#include "x1e80100-audio.dtsi"
>>  #include "x1e80100-pmics.dtsi"
>>  
>>  / {
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
>> index 71b2cc6c392f..82b08350da17 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
>> @@ -13,6 +13,7 @@
>>  
>>  #include "x1e80100.dtsi"
>>  #include "x1e80100-pmics.dtsi"
>> +#include "x1e80100-audio.dtsi"
>>  
>>  / {
>>  	model = "ASUS Vivobook S 15";
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-audio.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-audio.dtsi
>> new file mode 100644
>> index 000000000000..e03441bb2a79
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100-audio.dtsi
>> @@ -0,0 +1,6 @@
>> +#include "audioreach-audio.dtsi"
>> +
>> +&q6apmdai{
>> +	iommus = <&apps_smmu 0x1001 0x80>,
>> +		 <&apps_smmu 0x1061 0x0>;
>> +};
> 
> I think you should inline this into x1e80100.dtsi and drop the extra
> #include from all the device DTs. x1e80100.dtsi already references
> audioreach nodes, so it's not possible to build without including
> x1e80100-audio.dtsi anyway:
thanks Stephan,

Yes, we can not build it without audio.dtsi, as suggested inlining this
in to end of SoC dtsi should help.

--srini

> 
> ../arch/arm64/boot/dts/qcom/x1e80100.dtsi:4098.34-4114.5: ERROR (phandle_references): /soc@0/codec@6aa0000: Reference to non-existent node or label "q6prmcc"
> ../arch/arm64/boot/dts/qcom/x1e80100.dtsi:4320.31-4436.5: ERROR (phandle_references): /soc@0/pinctrl@6e80000: Reference to non-existent node or label "q6prmcc"
> 
> Thanks,
> Stephan



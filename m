Return-Path: <linux-kernel+bounces-861142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFABBF1E37
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D74F3B0373
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7BD218AB0;
	Mon, 20 Oct 2025 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NrYSO5+O"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C934A3E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971207; cv=none; b=BTJ5OLTEgUqUObgd75R8uWJD3VA5JW4k8KR9gGirTVqLlBQZMA1qQ1j/X5y5jKfDtabRwevpPD8qMPV8HcgeQycpfQrfUPW9OtX3lP45+zDReNcAcK7Htz8M4fIARB8EitQxRtgK5GjbpTGmPupxadpFekcCXA9QRsatCvFDAHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971207; c=relaxed/simple;
	bh=IKm0z6iO1hIaheLCdQScebPMc2ctCaCdPFDDsMKTMK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZrfozfhd2Ri/JuGryYdzq5HtjZDKqxEBQHbDwcTZVBIibpc0bJFKXERswfyqdUTelFRijg85eMiMVssBmRMfcfS0YBAN0BNLSgfl/MicVjB6tSNV45Izv2vNJm4cjKWK9Q7XUKNmRDB9Sqinuu81/muz11PVePDWVgjC/ovx+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NrYSO5+O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KClZvG006937
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Zu6f+vYXQ3o69XdqhkZydYNTKJw9PQzWWyZv/yxYgk=; b=NrYSO5+OddTicNM8
	NDpvdGDeS882JLzuYd/rX6sgk55YMSvvn56Hxviyl3Jm2/YRmW9YX+0nM5mNsV+s
	+VEczKS4S8mGLpvqaUvleE8IJhTy1Be+Fv1VMG0qQF+imN4ovukzGtTKb2oJZy3T
	At2uaEAHaB2C8XtWm6m7PXiIlhZIRbV8DnDZF+1y2Rkz6ruZoiFejuUScODgMmZM
	zyd1e0cWMd4Fiq9ImuTB5kUf43/vBbcSyJLI1qFSEuSxOo7BIy5hjmvp7rfz6VUJ
	8wRU4R/+ChGz1ao9nqiaIUGmnY34hTXnF9eRIgJ3vG0mYQgYLJMn7ofdxR0LMddv
	69ydGA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3984ykb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:40:03 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-873eac0465eso16390766d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760971202; x=1761576002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Zu6f+vYXQ3o69XdqhkZydYNTKJw9PQzWWyZv/yxYgk=;
        b=E+1bWvlYn6mhnBqhxsa/xg8ozhdcYTDAKtiie2LOOd4VRsVbLcvP7kJGbGK2NJMHuy
         YVEo6Z7A0cXxigl4Dl8/K2Prlh7VKPaY6oNGF7mcom7QeG1cqA8xYHyFiRumJ7VGE0Mu
         YX+QCIJemHJW7oYO6ZeaYK1FQoC4XutdmyUy2KDeT/gWbtL5Gt1PDGE9hL9tUvBsQ34t
         jpn5eA/pJy/2wRaZVN6RuK/AbeC1B+zoBOh3+YKMraKcrDbU0GNkBCa8n7ZLoRuMW80N
         n/vLo/uxpka4+kNK9lol6rcqoq9JwqcsPILuavBnUtEAAW312S3kD+yO+5dunJiqrTLt
         cffg==
X-Forwarded-Encrypted: i=1; AJvYcCVodUCGaO0jAQTbuXzG2YJUBVmSamPXl9qrLuW2dVpOwoIPdBl3aUDxfx2T21B4fSjIwiwVqESXdyQ1Ndo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyVHgUNbVuthTC+MwgbuDacZXLzZKtv1IT2rW6hTfXYZ4TVLZ2
	uC+wotKOSGQ6gy/pIWDsmQvUBqyVL/8y2wV58fcBi1YjrYjowV0DnbORMR+602zk2r4qkiGZDMV
	7lglxVth7oq7viGJjCEkq8ODj27dyKKdWDVTC0CXVFST/wXjvkzshh2BQZ2Jk10mSrgA=
X-Gm-Gg: ASbGncvPZJ9AL+VJN51zpdKWR7RMeFMYMA83w987/YYLb3ghXq2ocxlyjSV3M+bvAQ+
	ptaiAnspBrz28No2FJe2MZpaOoycqh7lTl88Adl5CPFuErEn79GoXOY5KPKzNUkTE0E6pusZjwm
	FXauHP4v5wpXXXVVL/mvTKdINutnrHXx6vL0UEJBFd+k+XHsSjRZ588IvayGwZtniw0al7oJofB
	hpPUlGrmVVFylfMSUmSc2htBnEmsQk9pbcTJlI4RAw26IchqNwq7lt5pF+9UOWi0MPeIda/f4pV
	B3vYOQGH6xDi3NsFPlBQj3q16Z+mTd24Nn0vBSh1GsxaIK7CzqSh/dHIhB01cDMClhJ9XKn9EEL
	Zx7xFUDfw7JwYch4lv773Ar2DA9p4VmKUMsavOHjL4krShC4mzlSaww7d
X-Received: by 2002:a05:622a:2c9:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-4e89d30dfccmr120394581cf.4.1760971202332;
        Mon, 20 Oct 2025 07:40:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzno6zE7d8ywaNnHDQb/mNOI0HSKIv2hIac/LvxNv4AS9Wp4Sv7j0diyZ/CVmZsJCO7Mn8DA==
X-Received: by 2002:a05:622a:2c9:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-4e89d30dfccmr120394271cf.4.1760971201756;
        Mon, 20 Oct 2025 07:40:01 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e89713ffsm809097366b.36.2025.10.20.07.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 07:40:01 -0700 (PDT)
Message-ID: <60a48dfb-e266-425d-8cfb-574c637f5e9d@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 16:39:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] ASoC: qcom: q6asm: handle the responses after closing
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Alexey Klimov <alexey.klimov@linaro.org>, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
 <20251015131740.340258-6-srinivas.kandagatla@oss.qualcomm.com>
 <DDN83LOTCUIP.5O05FBN02AZB@linaro.org>
 <7c0dad34-cb4c-4912-9406-2e559b91142a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <7c0dad34-cb4c-4912-9406-2e559b91142a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KcvfcAYD c=1 sm=1 tr=0 ts=68f649c3 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=iwlf0Vfv9nm2vOHXmi0A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNSBTYWx0ZWRfXwTYBdQJ5qoU/
 uAOpBBpXBxs+SRTHaVilgbJElVOmhngXOkj4SUmVrzJlRm8WniMcrkCmi2/9e4q6WrNvDwz3v+3
 ZOTjXlQCSp4dpq5PP8Gaw4Mp70KbALFvliCDRz9S2ICFz3Kd1hTP6OIlf6CWLYo7WPKNnOQypkB
 W4pW2hAf9zDCZ80sdJRgqWEVWtdFR2IE/A9r9Rjs91z6nWU2vqb1ylTc3D7W9/yTkvfKaKFxXTC
 fTfJWJA+FVyKuKzwfwcoO8CTdX+yAdqK2r6T6xtAq1ML8kvGA6rADBKkmgFHAE6BfPoqPG4xOCy
 rcsULDrzs8GUfsBAGtCreITZdDItwev/QBbI62ERi0CG/vj0Qoqo269hv2XSKdnPUW3mncT93nr
 uoE4kIOrzqY/scdoGwNUfVopgSV4sQ==
X-Proofpoint-GUID: yBMYVA3XuzsIOqHiiF9IAbONZM-ZfkyA
X-Proofpoint-ORIG-GUID: yBMYVA3XuzsIOqHiiF9IAbONZM-ZfkyA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180025

On 10/20/25 4:37 PM, Srinivas Kandagatla wrote:
> On 10/20/25 3:35 PM, Alexey Klimov wrote:
>> On Wed Oct 15, 2025 at 2:17 PM BST, Srinivas Kandagatla wrote:
>>> For record path, multiple read requests are queued to dsp in advance.
>>> However when data stream is closed, the pending read requests are rejected
>>> by the dsp and a response is sent to the driver, this case is not handled
>>> in the driver resulting in errors like below
>>>
>>> q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10dac] not expecting rsp
>>> q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10dac] not expecting rsp
>>> q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10dac] not expecting rsp
>>>
>>> This is same for both write and eos.
>>>
>>> Fix this by allowing ASM_DATA_CMD_READ_V2, ASM_DATA_CMD_EOS and
>>> ASM_DATA_CMD_WRITE_V2 as expected response.
>>>
>>> Reported-by: Martino Facchin <m.facchin@arduino.cc>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>
>> I was also reporting this error months ago.
>> Thanks for fixing this.
>>
>> FWIW there is also DSP timeout error on Audioreach-based platforms.
> there should be only one for SPF get state command.
> 
> qcom-apm gprsvc:service:2:1: CMD timeout for [1001021] opcode
> 
> This is expected as we are checking for DSP readiness and it will
> timeout if the dsp is not ready.

Can we make the UX better by adding "bool timeout_expected" in the
path that we "want" it to fail?

(I have no clue how this is tied together, this is a high-level idea)

Konrad


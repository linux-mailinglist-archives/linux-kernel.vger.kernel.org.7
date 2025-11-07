Return-Path: <linux-kernel+bounces-889693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E56EC3E436
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 03:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160743ABC65
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 02:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B902EBDD0;
	Fri,  7 Nov 2025 02:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nXILmI2K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YtsE4UmZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F532D876F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 02:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762482961; cv=none; b=PX3vXHIMnUSdKb+G7xLJXdHXaaGR1RB+ln6e1W8ejUPa7kZSycHSA2vbH0SRLISeVm3MDMSbmxrDAysH0jy/TlIHDB0dyuG/diUtsMkcRm7gtAavvZLLzmen+Hbo/nO/98eSGVscsfsbSfy7UrXXV/i2rMPFu58hg7IuF4j7Gaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762482961; c=relaxed/simple;
	bh=hVUEwFUdTmrnOmPrh9hHeC9Lb8l/ziqOJLnnKvgo/KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctJGy0KCUu+1O5hBAZ2gXMfMY6qXP7evdSfrMn/EzpZhYVuZTYTX8xYsmW6sHHe9SBy7vDt3Wi2c4Ido+RQkoNgKT8rgbH2KTZW3plcMHuoT7eUCemRopfRm2PFdyp2G+6vaIHHJisYSDkcymqbRA6JQhSe9zFgMLabkGBzQ+jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nXILmI2K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YtsE4UmZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A72H2Rh3156994
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 02:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tpVjCnvayEUx7PEyaalgd7xuD7D1sS4+VgrdUxyRuIY=; b=nXILmI2KP4oKkNRc
	7IGAUlfZVDOs4ls148jeKxyufAh6cvzrVvm+kfmwwOWR8gjSGzUIrCvmy1kjp9HP
	NE0gXxDEIRZ5vk9EYl66YJtLuNxCnl+Sl7s080HSMvdS1BtCnGTw11Xy5pXoX+ey
	wUZ3GuEOs/EG1jvC3rlqHcSI5Hj85/Qp72llFZun9S/5gnoCJnDEb5Cx0L4R075l
	Kh3rUkmrCo989as6EanA3RN56cSvjD0OABy+ZuWasUUDKRJBBrpmGDyvNcy3jHyb
	tLAj0Eq80IhivAzmsh8Oh5k7Iod8AOLgZ9iFXwzhYB9qr9FZrgMRvSCAHZ/uz3+H
	huEV8g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8pu0k953-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:35:58 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-341a72e4843so354411a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 18:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762482958; x=1763087758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tpVjCnvayEUx7PEyaalgd7xuD7D1sS4+VgrdUxyRuIY=;
        b=YtsE4UmZNEIkm0p2nWVpMofN5oOHj0s2AKK9hLs316o7JX5l6txp7LuxYzx6vfyC2n
         0Nj9qCipLwqQ9XagfFRtbhEPiR1YiZ0v44F6qFUTE6V6otQweDnw/MXORfWZ4PuYZ3JB
         rpKVTtYZ3wz0ZDnygxRAPTW2clygCC0CWFl/s/hJTALJfM5CS7GTVpYPBMBEXTWgb8jY
         bjsfaNeR/IqCke8lOox/btt6QMUF43zJhxjGmGFgUNt0qYBXa6rMI3DOo1fUAh+QehjH
         EbPq038+JTsF1arpA109WDTm4yhCZ5ZI7nWQAqzBc3PBgr9KRpft24zKUwKy09Fs7rFg
         7K3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762482958; x=1763087758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpVjCnvayEUx7PEyaalgd7xuD7D1sS4+VgrdUxyRuIY=;
        b=v42XKu7z/Z+0YfsJQdtOo/sYZtxxJcMgfVrnqgtnJb3xfWDyiz3UYZaF1jbPl4Kpn2
         /bHqtnLYtxhSdky7W0EVLUAri+q8rNyTaEzlfoxpaV7ydQuj5wokCgj4fhxBj9QtVxyq
         aETwSOYjpSJuFobiKv56OaH3V5mUwbxTr3AzTEvZbdCKErHZc1FbupAzs6Yn/glRe+j9
         M62GT37tfClxESyGAi3EjdTfL3XH+n23nkBWzUVG0gXNDmxFN0elAGmk3yBQ0lR+gAvU
         eppfaJCv0i05T6bB7ttXFnHXFUZx1uVEANDBb2gsQfttYLK1ExSgbfhH/151tIHrEKBO
         h7dg==
X-Forwarded-Encrypted: i=1; AJvYcCX/0I91HC2frdGib1DOmUHSQVgdQ45EA1MHj1AeRV97PLzw5F4B4DpspO2j4VMqkyV4sumv4TaVkCZsAaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFAgXgFF5vyycxA7gxd/1HIlu4lUq7ZxtNhJGFgrwM1RLCyOB3
	3t+NCDEX3dUGO0X0tpGFxM5+hVdpwuGvKdMI3VSoMz7MZOk5Tt0cGfMB/+2K/9dWx7iEx7xqoaO
	G9UB2yUl5OlxdT4AjCiuSoufWUlEwqyBbGpMyan5OhLcbJ6YEbzmejmz0aZpMaFVQOmY=
X-Gm-Gg: ASbGnctllziFF9eekbcwKuLt9p1HLsbjcXwLYpWFnpTakOeFZfp5YvELlZidxdFxvxx
	dzvhy9Zr917ykKBFshHJExfhkS3JRNtzB1NvZ1aoEc47DX4fGuHZBb44ZPH4PXP7GkAk/fxL79x
	IK5mIbd6BWGGEvFxo32YQk9J0OZ4iFfQbpC0BwwfUVm9FNR5cwXOvnFuANOzAW1KN7cUJfPE7V1
	aTw7UG+2gWT8KxOSB4e1PtAFge9MDaYYW2q4pUQg6YFbClLdJukb1NSIFf/b+9HZ8kn8A1FloCy
	y9nEnEAAMsnrld6iyrv0DTd2utnCgK8ytpwLWCInt2NQdJ1fOPFFQx8Aju5/uabpFwYOJuYqIUJ
	7XTFgSOXS54kD65zr7dhbrjE3JAWkTC3aHPA5jv2XPnZN+PFEu0UdSksMqvkVe9Znih5ePxY=
X-Received: by 2002:a17:90b:4ec7:b0:341:8ad7:5f7a with SMTP id 98e67ed59e1d1-3434c56eb97mr1520820a91.18.1762482957803;
        Thu, 06 Nov 2025 18:35:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkAB9G9VGMbR0AqlVK2RCHMNZSlrYP5lqcm+ufNtzCJ6HxBTjM3ZlbyYk/P372znle6bKa+g==
X-Received: by 2002:a17:90b:4ec7:b0:341:8ad7:5f7a with SMTP id 98e67ed59e1d1-3434c56eb97mr1520778a91.18.1762482957201;
        Thu, 06 Nov 2025 18:35:57 -0800 (PST)
Received: from [10.133.33.179] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c30b96dsm885866a91.5.2025.11.06.18.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 18:35:56 -0800 (PST)
Message-ID: <09160a81-0a2d-4e9c-8710-3c172e07284a@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 10:35:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: hamoa-iot-evk: Add backlight support
 for eDP panel
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251106-hamoa_dvt_backlight-v2-1-9f844c8f8110@oss.qualcomm.com>
 <29ef2def-4073-4a77-8437-41cdfac2fa9d@oss.qualcomm.com>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <29ef2def-4073-4a77-8437-41cdfac2fa9d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDAxOSBTYWx0ZWRfX7VpyF7Jz5GtD
 i0FLI6OJ2jg4nLew383DVR5AUmrle+49otuOp/P4iSrDIkF8nPnPlNB4PMGS+szUvkvc+X97BWO
 1W4i6ciGePuWEsL9T1g/CCJTz0AvX2U9koYibU/2Zb0m7Wg3lrsUVGJFUQLD+MiLzWKFV7k1rgH
 zbEWR9q2PS14UtlbBIm2xZlWRKBp6FhO9R4/NO0DcxLxuZQ+Ox0DmXVyYjXrQLZTnehgAI3fQ94
 dBTfqet82YZPQPb5tBCBPu9z93ea8y2GcnWrCZsdVgNLzwmR3uYuGuxWy5UpHN6hIJ67zkzVWBh
 M1rdm++F/G51zWeJRPoQb+OSCXOzvVoC5wNL+cxdsuL1CkqpqFVRiQoAc4V+ZdaU5DSTurgLtSN
 x0XE5RzQ2/CDgm12oMDvBzCo29NrzQ==
X-Authority-Analysis: v=2.4 cv=bIYb4f+Z c=1 sm=1 tr=0 ts=690d5b0e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kwwcOb5VwNRYn0aRTlAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: rYXqWQn642nxaaiuCuJShgBqUarC5YKV
X-Proofpoint-GUID: rYXqWQn642nxaaiuCuJShgBqUarC5YKV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070019



On 11/6/2025 6:15 PM, Konrad Dybcio wrote:
> On 11/6/25 8:12 AM, Yongxing Mou wrote:
>> Previously, the eDP panel backlight was enabled via UEFI. Added backlight
>> control node in kernel DTS due to some meta may not enable the backlight.
> 
> Adding the hardware description to the DT with the reason that some prior
> boot stage might not have taken care of it is not great
> 
> How about:
> 
> The backlight on the Hamoa IoT EVK is controlled through a PWM signal.
> Aligned with other x1e80100-based platforms: the PWM signal is controlled
> by PMK8550, and the backlight enable signal is handled by PMC8380.
> 
> Describe the backlight device and connect it to the eDP panel to allow
> for brightness control
> 
> Konrad
> 
That's great. Thanks for your comments and suggestions. Will update the 
commit message next version.


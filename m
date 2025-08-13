Return-Path: <linux-kernel+bounces-767639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3381B25713
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228BC1C81CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198C22FB991;
	Wed, 13 Aug 2025 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kvOe4hR3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D3B2FB97D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125757; cv=none; b=YYRXSiCeibf68+gaVfLYlxppjGXqxo0QpE2MsNxPamzo9QdH6ACjnqO2hDvvhIL30mB8djNwGJRwMQ68tu0pXup7YIrQ+cPdzUXhN8fluVNv4F0i9PhJYGqYyI0MYyk7qTevyCZFdRaB2/UOk8cmvVWESclYFI7I3B6IL8la5u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125757; c=relaxed/simple;
	bh=jAnNKoc8OIVx+dw7TrFVfvfY8lmRFsZzlTTw/qR/0dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAACSfT84KviGkwynPyLmCSUB4f7ZsxIUwjoPvBrz63sAo5+rkdif50BpHpOZv+3L0Ifoo/bivivrfJeXYHmBotDK8ZMVzvJpuNA1UF0gwmQOO5dd5LgP33EBPY1jF8VuFTbNzoQ9jWVclisk/Xqv9puxm4hPtXG+aon51XoPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kvOe4hR3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DM0XXj026999
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8e0ZVNprxYNA0/9coeslBrJajBup8IpRB7mgWlinU3I=; b=kvOe4hR389WJMGpr
	pSwX613gEZv7psgmjtiDKWNew9mN/oaXMWt7VZsUGZ0BYhGuur1Tz3LOgjc4ZcK8
	/ynBUUlLlkC9ecKh/1uPZUlS49gpcuwVRp1AIl8jtwpxIE2wI758QNLtqcuIMjqI
	u5Iu1TIo6URF61zeq0ZC83H3d+6cTgEDcqZXQq6s97Yqr1aWTmz2quWNfvCk2QFF
	euT8hKEvGddJZWYZKTRwNVXCQURNZieBYj52C5lJvsE4tofLzHsd4HIGpe++dhTC
	2hnP3czq2OO5mp5AJoSFJhPJvDbMPVyR6GLoI3PXpoxprIRy8abBaUsC7jdJ9wdQ
	0fkCvg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3gdegh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:55:55 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2445823bc21so5299885ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755125754; x=1755730554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8e0ZVNprxYNA0/9coeslBrJajBup8IpRB7mgWlinU3I=;
        b=UW2q763Wyi53w0bw6DExxLeodYoyojOOtw8moDYkTlbWocsOouozGyIe1Eprm/iv/C
         sdJeYNhGMszjMi7OAVZkp5MF31y8yHwcWPaqfnOV6hjYEEr5FzivjS+7RXo7bRKKFQv6
         g2wPpqrmptVST0OTUuHT/OnFC51tPvBX6VWBLwWfW8qlDW/F5mC7TfMvd6KXubJKfB1O
         2rCm64qlxtNtyZpcaZAANBbTDrccZHx/09HXX4FcJyUEdvROYSWxlkczrpagOSkD61gW
         vVDX4DrMjJ4V0AEQ4cuJ+mlXpE/MTeEGyujotRBUX8DVl/OkCjJIIgbztCz9+VXxYUcP
         nCDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNXM65B/MoOW5FcTEQqhQqjrGALlsIpUCey/uhIOvU66qzxxstd/FBksQUrvwNtkSEcx7vT+rwA8ncE8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrDumu0uujgNXB/EQEqMIve6e6hWHmYSrNwA1TtwsWa8LtrB8q
	bYTa7duowx4X/ZSPAe883oBBB/HzrAcuta0wFhEpzX6f2PVGx76w2lo/tmKeNn650hQNsxE7qgv
	T1l7S/6/ReBTzJ8cOCpfmTccmQY1XdrzbbJAsmuA4vcQ98l+ed3/qtwfeyZKVTYz1lg==
X-Gm-Gg: ASbGnctUc1++oBlX+SiYv+BtcHyI7J9ppi7twet7vObZzeokqHltpzwpS2VJxkjyez6
	y6EfiJ6yjyOJAq9CY+DFWK53x1ALZ5hQ1G9NvX/Xtx9chSUNWSB6nUUoUtxitr9qxyyDxZ5Qm/d
	cWr7uln1frSkN1LY1/79YRrB7ghLeypWexmKAlXhSbluhfa5Vgj1GW+anNXh8Bh9AaI80MxASVM
	il4LL/PD5c6F32SURnxsHRIm2ndTkpvpLNRInq4LK+OREqfuRw/nICl0wnJ7J/Uq2cBvhkJTOks
	2YfKY9BWOUDTNfFWnjQz8N1I1UzelBpTNge/bZzo7FpCO8X2VypiBU0oENNdB1dh/3dN2eCW+q2
	4tORsQc67hlL6La3Ul0GXdD0/GBZn89pyFSBB5g==
X-Received: by 2002:a17:902:ef48:b0:243:38d:b3c5 with SMTP id d9443c01a7336-244586d6812mr11282965ad.47.1755125754316;
        Wed, 13 Aug 2025 15:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwyZkPhdjRr1DNqf2XUlzMie+QCuji1zBonY4NxpkKvkrR7x/LGRt8rtlqOJlwD4OUaeYUew==
X-Received: by 2002:a17:902:ef48:b0:243:38d:b3c5 with SMTP id d9443c01a7336-244586d6812mr11282655ad.47.1755125753877;
        Wed, 13 Aug 2025 15:55:53 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2429b4ca995sm202959025ad.177.2025.08.13.15.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 15:55:53 -0700 (PDT)
Message-ID: <1874e02d-993f-483b-bcb7-dba7c0611376@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 08:55:45 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/11] firmware: qcom: scm: add support for object
 invocation
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-6-ce7a1a774803@oss.qualcomm.com>
 <f015c644-1176-47b3-8ce2-2567e529081e@oss.qualcomm.com>
 <a93b9788-92ef-4b5a-89ca-7e7733697eed@oss.qualcomm.com>
 <176361cd-a095-4b81-9e36-f933d159d249@oss.qualcomm.com>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <176361cd-a095-4b81-9e36-f933d159d249@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689d17fb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=T0n-DW2OHO-Z3PBZrcMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX6XF8Kw1DbFuO
 y9wTMOY42QrRWVW6/e8UeUyKyQzAqdaxMTFMixsRzjCxqjIVZxxpTZvPaiZploD6nMGANGdBFeJ
 Z9EPOhwgB6OSBOFdtUvEkRCY+LC2cKKKDt33nesBnPFJrYzj+wCdcRO6YP66uR82FwFknUzI9TG
 wGIKN29wmi3lT3IrCmFPdNZIIgmhSayyURm0DZPACqnNQoKGACk9CgcFxIIvA3mgyVsEsFxcnDe
 UbaopFt8EbMgamq6Wg9TEwLeF8/xaYL53F786OgPEyxjnDyXJyLfbjnOBhaq6Rffk0sifqR9AKs
 oYLZxKmlv2AGWYHZs3FkS77mTv7WvXtZHcEO3zHPLf5MckFWEpOD0JJIklLEl/4J4Sq8/cZcs70
 K22Kw5/1
X-Proofpoint-GUID: L45gRje4WRM8K0oybApelH1hDPZiXk94
X-Proofpoint-ORIG-GUID: L45gRje4WRM8K0oybApelH1hDPZiXk94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031



On 8/14/2025 8:52 AM, Konrad Dybcio wrote:
> On 8/13/25 11:37 PM, Amirreza Zarrabi wrote:
>>
>>
>> On 8/13/2025 7:53 PM, Konrad Dybcio wrote:
>>> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>>>> Qualcomm TEE (QTEE) hosts Trusted Applications (TAs) and services in
>>>> the secure world, accessed via objects. A QTEE client can invoke these
>>>> objects to request services. Similarly, QTEE can request services from
>>>> the nonsecure world using objects exported to the secure world.
>>>>
>>>> Add low-level primitives to facilitate the invocation of objects hosted
>>>> in QTEE, as well as those hosted in the nonsecure world.
>>>>
>>>> If support for object invocation is available, the qcom_scm allocates
>>>> a dedicated child platform device. The driver for this device communicates
>>>> with QTEE using low-level primitives.
>>>>
>>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>>> ---
> 
> [...]
> 
>>>>  /**
>>>>   * qcom_scm_is_available() - Checks if SCM is available
>>>>   */
>>>> @@ -2326,6 +2444,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>>>  	ret = qcom_scm_qseecom_init(scm);
>>>>  	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
>>>>  
>>>> +	/*
>>>> +	 * Initialize the QTEE object interface.
>>>> +	 *
>>>> +	 * This only represents the availability for QTEE object invocation
>>>> +	 * and callback support. On failure, ignore the result. Any subsystem
>>>> +	 * depending on it may fail if it tries to access this interface.
>>>> +	 */
>>>> +	ret = qcom_scm_qtee_init(scm);
>>>> +	WARN(ret < 0, "failed to initialize qcomtee: %d\n", ret);
>>>
>>> This will throw a WARN on *a lot* of platforms, ranging from
>>> Chromebooks running TF-A (with a reduced SMC handler), through
>>> platforms requiring QCOM_SCM_SMCINVOKE_INVOKE_LEGACY (0x00) cmd
>>>
>>
>> Are you suggesting I remove the WARN? If so, how should the user be notified?
>> Should the error simply be ignored?
> 
> I suggest using dev_info/dev_notice, WARN prints multiple dozen lines
> and taints the kernel
> 
> Konrad

Ack.

Amir



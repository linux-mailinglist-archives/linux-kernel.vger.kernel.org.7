Return-Path: <linux-kernel+bounces-767635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D04B256FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE8307BAE11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A432FB97A;
	Wed, 13 Aug 2025 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fjd/24VX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBEF2FB976
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125539; cv=none; b=ZT9+2Z2FhAIHlA88uCHPzMACglr1BjOOTNVGslXiHdGaltFyvg19cGzKtkQ0V/Qtg7AN75/Y0MwcCljX9yaTX08N3Syre++OWKPbWCDK68DWVXdEoipwli8VVod2WrUNx6UKPpxlhHrwsAjOBK+HtKQfgB/KFNsSt6eOVVyIOGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125539; c=relaxed/simple;
	bh=gpvubl7IBMGZ3fNhTgbXzyPTB7BEybWTWqj8EEGwPiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9zH6TKubT+5rAC16yPPpaVBaYgzSmuXBVUbzNMGLo5HZ/lybXo9qOfj5ODu/myA6jKly/4bxt0qQGymvSaHwjbRYKcWewzPzU4jRj4oG5586Pc5KwY+tkjr7maT2IFLkB3Tc5Xi5nIp3zDLgh56m6XCT7BsOnICRTRd44CPrJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fjd/24VX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMRKnD020600
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t42PazxIAwcY8zhaSfswxJzoFRiL77Ql0tEpJIyMuFY=; b=Fjd/24VXocnkshuC
	d00CX9XpBwlgTwwRriOLYf7uwSvAm8cs1rWazUkX4qDzJgFYycUVeGbRoujWltSG
	HwSuWa5l/p0Iz5QISvF8myCaFiA4NKiLJQKcCPbOZHKnw6qgBcoUxsHVwLf+9ubM
	0Lb8tppanA1gEPCy6TO2avDw2BYmvMA7j7bjOcUadWvTV1rndO+g7894Y1+k0yr+
	4+WJFfDx3v1JbNIOVXoijYZzDLXD9UzZ3DRO9KlS/VljDE06Bqp2mNVjUMIz3W7o
	9tXhUGZuYatTyGlTF7uyQ5cOE+xB42i5KSlV1J4McSHLJOC+1R/BZ0/FT66lXYRO
	sPbLyw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmde70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:52:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e8707254e0so9656985a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755125536; x=1755730336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t42PazxIAwcY8zhaSfswxJzoFRiL77Ql0tEpJIyMuFY=;
        b=J3oWpaf6fMgVbqjfF0W+f5bMljJUkUlWVRQ3KTGnl6XS/4P8OU9oU091SIaerglaU4
         OgYS8rEenE+msfAGpoE9pabw9gDhOmaP9TRwjkV4LkeGtdf43PDTVHzDx0obKBx0Vr7H
         QKwLwc7U7/qakk737EM0zhWnJ6j9QdJq/G8dmtDmg/O20PqcmlyF/pUZrIfz9pCDcl4M
         WNUS/G41KJNLiCuIwALhg83g8zsrpDXZYPaE9jif37sAjPfohDy+qwlg22lcY34D+EID
         MWfZwwdw4JKhTrVo1V4KXUUFcArinqCF+lhejgTI2lmYZDQ8mjaAk3UQz3eRXiHzjsfj
         AFdg==
X-Forwarded-Encrypted: i=1; AJvYcCW3I48l2Pi5MVrADK2njshSky3SQ4ToV0OEJCVG5zJTP3bxo3gOzb5I1VS2vGCRZS9gO/TgIF7+CDwo+gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw09DEv4jGxg6bMHav4quHZnby3HYZdE/nmSwOiAcBZrc8tXPuk
	PczgzBs5n5soSE5Gj3w7fqVbbxw2aQHVAE1syV5gVUhO7bGXS7pG/8rHqnM+Z2oUDi8Bv8Us8WN
	da0ZDn9Q7+n01BBekQU71r8Sx5LUScrPeAsw9ny+E6ESf135Dlnu0VTKllMpoD4CMd88=
X-Gm-Gg: ASbGnctDj3ckbEVR5DxwLAbb/RJd43WTzZDu3uIU7SUnEViv9opZPGCWrManbJU3l8v
	1fdZN+E0rNtIO9gu5pKYknzTzV25n+Ea1kJcc7c75zgH8eHijG/bfHWrzx+bZUyUZ3dsglo+mrl
	hS+KB/qOgRvw/5pZWtFW5e4NHLz0IqDGYeMIIYy5S20AjpdganlHoo6WYSRDYmoLcTpccpt2V7h
	Dy2XvtkSCaQCy6KtOowNjgr5f5qUiIL3UMXrGoOQk9cydeOkiTPoKfJXFUzp8d4zPrU6rkWR+Tr
	FiXizdNhReiAy6jywDKzfq1uEKnvpDz/ckfQMIq13kRz0XCfw2d0Xy1i1HQiScyipYSshxVU0oP
	SpsAaomlXbqsOupC5dA==
X-Received: by 2002:a05:620a:4623:b0:7e6:5598:1fc6 with SMTP id af79cd13be357-7e8705a3275mr89870085a.8.1755125535632;
        Wed, 13 Aug 2025 15:52:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHclD7EUgbPfmus8NrnhqiEVqDLALZXNIA0vOZsJQC8vPRZCLtqwvV5bJV25qlMQ6s/DbEOQw==
X-Received: by 2002:a05:620a:4623:b0:7e6:5598:1fc6 with SMTP id af79cd13be357-7e8705a3275mr89866185a.8.1755125534989;
        Wed, 13 Aug 2025 15:52:14 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6186bfee29csm2338635a12.15.2025.08.13.15.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 15:52:14 -0700 (PDT)
Message-ID: <176361cd-a095-4b81-9e36-f933d159d249@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 00:52:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/11] firmware: qcom: scm: add support for object
 invocation
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a93b9788-92ef-4b5a-89ca-7e7733697eed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX0e47fi1kIaCm
 ka97h4lgeAKuYeNS0uk36bj7m1tID1X7w8vHuaIujndMd1fD5Vg3B8GzgEAva/HEaOh+DeEQm+V
 Tr7FbbfxyWU2xWrWxRDXeE2ITN90/YXzLlvUtJGeqBadttN4nNa2Sc0Tr4lx5Q8lQY/3ratBGvG
 1dM7y3bIRr3eLUDOvjbnAFnNBSFhhWEgWdE9jwD/1Q5X0wnsVL8jnsMaxV8orEwOazMlFtm4l1i
 76xW2rEhh6Ce4I1LyeSyG+PGYKipkcc4GpfKJIVF/AnQ7tJ0etvH8vd53QfD3A334Ng9kuFxjg2
 8tatk7IJydM/9V+J7ZhCY7E8c+f9a2FnludqdhMMS/Ss0hCYlh0g+sQK02RVZ+FL7kRX5mrEH5/
 YmPDFELi
X-Proofpoint-GUID: I3zvbNas_G58pqMp3rM6yNPBtSOKaDiR
X-Proofpoint-ORIG-GUID: I3zvbNas_G58pqMp3rM6yNPBtSOKaDiR
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689d1720 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=pfBxzQCg3Pwb8BljcmgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119

On 8/13/25 11:37 PM, Amirreza Zarrabi wrote:
> 
> 
> On 8/13/2025 7:53 PM, Konrad Dybcio wrote:
>> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>>> Qualcomm TEE (QTEE) hosts Trusted Applications (TAs) and services in
>>> the secure world, accessed via objects. A QTEE client can invoke these
>>> objects to request services. Similarly, QTEE can request services from
>>> the nonsecure world using objects exported to the secure world.
>>>
>>> Add low-level primitives to facilitate the invocation of objects hosted
>>> in QTEE, as well as those hosted in the nonsecure world.
>>>
>>> If support for object invocation is available, the qcom_scm allocates
>>> a dedicated child platform device. The driver for this device communicates
>>> with QTEE using low-level primitives.
>>>
>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>> ---

[...]

>>>  /**
>>>   * qcom_scm_is_available() - Checks if SCM is available
>>>   */
>>> @@ -2326,6 +2444,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>>  	ret = qcom_scm_qseecom_init(scm);
>>>  	WARN(ret < 0, "failed to initialize qseecom: %d\n", ret);
>>>  
>>> +	/*
>>> +	 * Initialize the QTEE object interface.
>>> +	 *
>>> +	 * This only represents the availability for QTEE object invocation
>>> +	 * and callback support. On failure, ignore the result. Any subsystem
>>> +	 * depending on it may fail if it tries to access this interface.
>>> +	 */
>>> +	ret = qcom_scm_qtee_init(scm);
>>> +	WARN(ret < 0, "failed to initialize qcomtee: %d\n", ret);
>>
>> This will throw a WARN on *a lot* of platforms, ranging from
>> Chromebooks running TF-A (with a reduced SMC handler), through
>> platforms requiring QCOM_SCM_SMCINVOKE_INVOKE_LEGACY (0x00) cmd
>>
> 
> Are you suggesting I remove the WARN? If so, how should the user be notified?
> Should the error simply be ignored?

I suggest using dev_info/dev_notice, WARN prints multiple dozen lines
and taints the kernel

Konrad


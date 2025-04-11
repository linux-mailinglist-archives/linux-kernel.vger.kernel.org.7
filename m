Return-Path: <linux-kernel+bounces-599455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5F7A853C6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 08:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A29162226
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 05:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5522D213E61;
	Fri, 11 Apr 2025 05:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kA7Hi7VG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA51E835B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 05:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744350970; cv=none; b=hxQ+iHvkozF9aBahqy8admlbZjPBKIm7AP5LAEG7VbHqKbE18AlfDNibA0+d7hvO29bxepd9mkV2vh8mL/4vj6lm2o96qJTmxHLx/KTwxWSGrQ1Ydn/DLPMr0fSYf7ThdDXc8i79fsmfwwcOGBoD2ccBLqVZr8qcS5+LeWTj15Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744350970; c=relaxed/simple;
	bh=iLBUHKjuVqQ3m/GPfpB6fSCezDoPsvWRuESJUOrS8tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AocYjMlM2O1tLB2K92jsAm6JDqX3sMzp5zG3PUld3aRuDKKGu1tULXKSsIpy0tVV4RvIzU2HqDMJyNJ9p+WahTA4HiaEL0nv2LqzZFikIL6Ht2YEmFzLXUKR0pxCHUnWAqNhgHNkFvl2dSobPJNAMMDWnou/5oRk6bKHFs4Lqu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kA7Hi7VG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AGndrh030663
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 05:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hiJL9gm31yw0bQAasDBSLUH6dX1vXd/xj0HwqgM0X38=; b=kA7Hi7VGrsRvsB59
	kSeX/drqa7jj1eGvjSLUkp0AETlwfwlmIXU2p4oenc8Sy8imipd0+OtPlKFwJEog
	Jo/o2jguscE5D8Htv17GZ5Bn/nRyOvBKoM2gsHiHWyNedS/UNa3p42hHGRCiC2mg
	MSuRV19tmRu1SrXL8KPoVxzRbF4UnPDUOMcnaX0pU77COA/8Yg6laJY47j8XqYvM
	rFMRbJksMJAoFqPFK4Gr4gl9AjiM5vo8RffOUPiVejqFrQPWSften5K3WfxXUbZQ
	ZpBDgkh56jnbx0MN+8NZ7pZOq2MZSBkcUe6Cp56LDqACLFF1hra9q1q0Lzk7eOat
	AlMxXA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twfts43j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 05:56:06 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e90788e2a7so24554536d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 22:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744350965; x=1744955765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hiJL9gm31yw0bQAasDBSLUH6dX1vXd/xj0HwqgM0X38=;
        b=wwI7B61WUQ/AClfj3/LFch5DUqC0VQ+uoQAzZu13SHVxQm3jRSjsJ2yGP0ZR+vbsVh
         3eAPvexKppYzH/7oPKltoQNOvmkkpxXdO5QTJkR3r4S7/6v9iZ1wH+U2cPHPi1r05+oZ
         QRHdPAEPPAkY3S0ROJ9I6udr4Zn3sJ18zofGiWbrwpjOT0h7jhNs/iT2Ax7qYkQpH62I
         ufL8ceY1TBLNbS8/hAchOsRi2HBjkM/VRYhtX+iB6NNjCFNAzvVIP5bNk8Mb2LlKe1ox
         eWCgaeu5SB32bG3Sr6MSgii+dPKEvrPdKIZXxoy5NXjHNhBLYemfC7NO10ixL124zC/I
         F6DQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/ey2FbP2lBpWJRQDu3iqZaaxMI4pG4UFrJRSNw+I3pf4IxF5yR9Dc4qWXkeyH85k7FOtD6M5RbcHqKLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrN8Glci7Vhyp0fFWRTv8Edrzn/ckyT73fM8mEuaCukeFCI1T2
	beQ56XzCJvbkuRvqEK34S0DSYriHPBqcQ4thMgt0xKCn32vz7asBai8DQ0NWhWTKrnhSMctC90g
	a2VuHsyNAPOfoskXZ9Jduxkx+1twChtu2p7Da0P0pl1BStRY7vNSrX3GD6cGiKw==
X-Gm-Gg: ASbGncu4wyVlyNgAAL0SyFeHn7C2CCmJ3wYnISnbQ3wO4ihab62/l7CGkH5ANh3+sx9
	Z+OTu79j9plDbLsDV3WHxKMH+RnQPi+GSeEXNT+ezRaihmEKjHYNMEmBltBPw+axrbVDiEkMM9h
	9q2i6eEZHs6WWsysi+vBQnq66BGcfdoqz1fC5/NyP/bGwRE6p24WznRENQYha8nf5b6euCd6DXW
	9Thge4QTlj9qKLzbUYYALde3yxupu89CaIMa2x+N821uYI/wPpQ6IkrwEjgIgXKhR50yJjZuuOd
	Byz0bD9M3oTFQzlsVMNf30+cRqDGRyZ4aAFYwGG2vpHPgWnSB2QpWjxzpaP9ByyOy8ZpfEVdp61
	hP8BwR14T5g==
X-Received: by 2002:a05:6214:2347:b0:6e8:f387:e0d2 with SMTP id 6a1803df08f44-6f214188c9cmr27095256d6.11.1744350965353;
        Thu, 10 Apr 2025 22:56:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgaSN2bvRtxO2VRFuAICmCNHXAgn07LA4XCPCSzZfDv76SHfmMmXSddsh5w90oNbJR+TdAgA==
X-Received: by 2002:a05:6214:2347:b0:6e8:f387:e0d2 with SMTP id 6a1803df08f44-6f214188c9cmr27095116d6.11.1744350964984;
        Thu, 10 Apr 2025 22:56:04 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de982674sm32586096d6.67.2025.04.10.22.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 22:56:04 -0700 (PDT)
Message-ID: <0af0f9c3-7b6e-4ef7-a637-3e8490e5d46e@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 15:55:57 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
To: neil.armstrong@linaro.org, Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-doc@vger.kernel.org
References: <20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-0-7f457073282d@oss.qualcomm.com>
 <fd9ac8f1-94ad-460f-8ca7-e56724416fcf@linaro.org>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <fd9ac8f1-94ad-460f-8ca7-e56724416fcf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=B5+50PtM c=1 sm=1 tr=0 ts=67f8aef6 cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=cOB8zNAdNQxIbZ9Dt4MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: YNgR7sCNPpzhpJVy3cGVcZmr0yYmCH4x
X-Proofpoint-ORIG-GUID: YNgR7sCNPpzhpJVy3cGVcZmr0yYmCH4x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110042



On 4/9/2025 6:30 PM, neil.armstrong@linaro.org wrote:
> On 28/03/2025 03:47, Amirreza Zarrabi wrote:
>> This patch series introduces a Trusted Execution Environment (TEE)
>> driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
>> and services to run securely. It uses an object-based interface, where
>> each service is an object with sets of operations. Clients can invoke
>> these operations on objects, which can generate results, including other
>> objects. For example, an object can load a TA and return another object
>> that represents the loaded TA, allowing access to its services.
>>
>> Kernel and userspace services are also available to QTEE through a
>> similar approach. QTEE makes callback requests that are converted into
>> object invocations. These objects can represent services within the
>> kernel or userspace process.
>>
>> Note: This patch series focuses on QTEE objects and userspace services.
>>
>> Linux already provides a TEE subsystem, which is described in [1]. The
>> tee subsystem provides a generic ioctl interface, TEE_IOC_INVOKE, which
>> can be used by userspace to talk to a TEE backend driver. We extend the
>> Linux TEE subsystem to understand object parameters and an ioctl call so
>> client can invoke objects in QTEE:
>>
>>    - TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_*
>>    - TEE_IOC_OBJECT_INVOKE
>>
>> The existing ioctl calls TEE_IOC_SUPPL_RECV and TEE_IOC_SUPPL_SEND are
>> used for invoking services in the userspace process by QTEE.
>>
>> The TEE backend driver uses the QTEE Transport Message to communicate
>> with QTEE. Interactions through the object INVOKE interface are
>> translated into QTEE messages. Likewise, object invocations from QTEE
>> for userspace objects are converted into SEND/RECV ioctl calls to
>> supplicants.
>>
>> The details of QTEE Transport Message to communicate with QTEE is
>> available in [PATCH 10/10] Documentation: tee: Add Qualcomm TEE driver.
>>
>> You can run basic tests with following steps:
>> git clone https://github.com/quic/quic-teec.git
>> cd quic-teec
>> mkdir build
>> cmake .. -DCMAKE_TOOLCHAIN_FILE=CMakeToolchain.txt -DBUILD_UNITTEST=ON
>>
>> https://github.com/quic/quic-teec/blob/main/README.md lists dependancies
>> needed to build the above.
>>
>> This series has been tested for basic QTEE object invocations and
>> callback requests, including loading a TA and requesting services form
>> the TA.
>>
>> Tested platforms: sm8650-mtp
> 
> Does it requires any DT changes to be tested on other SM8650 devices ?
> 
> Thanks,
> Neil

Hi Neil,

No, it does not require any DT changes.

Regards,
Amir

> 
>>
>> [1] https://www.kernel.org/doc/Documentation/tee.txt
>>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>
>> Changes in v3:
>> - Export shm_bridge create/delete APIs.
>> - Enable support for QTEE memory objects.
>> - Update the memory management code to use the TEE subsystem for all
>>    allocations using the pool.
>> - Move all driver states into the driver's main service struct.
>> - Add more documentations.
>> - Link to v2: https://lore.kernel.org/r/20250202-qcom-tee-using-tee-ss-without-mem-obj-v2-0-297eacd0d34f@quicinc.com
>>
>> Changes in v2:
>> - Clean up commit messages and comments.
>> - Use better names such as ubuf instead of membuf or QCOMTEE prefix
>>    instead of QCOM_TEE, or names that are more consistent with other
>>    TEE-backend drivers such as qcomtee_context_data instead of
>>    qcom_tee_context.
>> - Drop the DTS patch and instantiate the device from the scm driver.
>> - Use a single structure for all driver's internal states.
>> - Drop srcu primitives and use the existing mutex for synchronization
>>    between the supplicant and QTEE.
>> - Directly use tee_context to track the lifetime of qcomtee_context_data.
>> - Add close_context() to be called when the user closes the tee_context.
>> - Link to v1: https://lore.kernel.org/r/20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-0-f502ef01e016@quicinc.com
>>
>> Changes in v1:
>> - It is a complete rewrite to utilize the TEE subsystem.
>> - Link to RFC: https://lore.kernel.org/all/20240702-qcom-tee-object-and-ioctls-v1-0-633c3ddf57ee@quicinc.com
>>
>> ---
>> Amirreza Zarrabi (11):
>>        tee: allow a driver to allocate a tee_device without a pool
>>        tee: add close_context to TEE driver operation
>>        tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
>>        tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
>>        firmware: qcom: scm: add support for object invocation
>>        firmware: qcom: scm: remove unused arguments to the shm_brige
>>        firmware: qcom: tzmem: export shm_bridge create/delete
>>        tee: add Qualcomm TEE driver
>>        qcomtee: add primordial object
>>        qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
>>        Documentation: tee: Add Qualcomm TEE driver
>>
>>   Documentation/tee/index.rst              |   1 +
>>   Documentation/tee/qtee.rst               | 150 ++++++
>>   drivers/firmware/qcom/qcom_scm.c         | 132 ++++-
>>   drivers/firmware/qcom/qcom_scm.h         |   7 +
>>   drivers/firmware/qcom/qcom_tzmem.c       |  57 ++-
>>   drivers/tee/Kconfig                      |   1 +
>>   drivers/tee/Makefile                     |   1 +
>>   drivers/tee/qcomtee/Kconfig              |  10 +
>>   drivers/tee/qcomtee/Makefile             |  11 +
>>   drivers/tee/qcomtee/async.c              | 160 ++++++
>>   drivers/tee/qcomtee/call.c               | 759 +++++++++++++++++++++++++++++
>>   drivers/tee/qcomtee/core.c               | 810 +++++++++++++++++++++++++++++++
>>   drivers/tee/qcomtee/mem_obj.c            | 172 +++++++
>>   drivers/tee/qcomtee/primordial_obj.c     | 116 +++++
>>   drivers/tee/qcomtee/qcom_scm.c           |  38 ++
>>   drivers/tee/qcomtee/qcomtee_msg.h        | 239 +++++++++
>>   drivers/tee/qcomtee/qcomtee_private.h    | 264 ++++++++++
>>   drivers/tee/qcomtee/release.c            |  48 ++
>>   drivers/tee/qcomtee/shm.c                | 146 ++++++
>>   drivers/tee/qcomtee/user_obj.c           | 710 +++++++++++++++++++++++++++
>>   drivers/tee/tee_core.c                   | 159 +++++-
>>   drivers/tee/tee_private.h                |   6 -
>>   include/linux/firmware/qcom/qcom_scm.h   |  31 +-
>>   include/linux/firmware/qcom/qcom_tee.h   | 302 ++++++++++++
>>   include/linux/firmware/qcom/qcom_tzmem.h |  15 +
>>   include/linux/tee_core.h                 |  15 +-
>>   include/linux/tee_drv.h                  |  52 ++
>>   include/uapi/linux/tee.h                 |  54 ++-
>>   28 files changed, 4434 insertions(+), 32 deletions(-)
>> ---
>> base-commit: db8da9da41bced445077925f8a886c776a47440c
>> change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c66340527
>>
>> Best regards,
> 



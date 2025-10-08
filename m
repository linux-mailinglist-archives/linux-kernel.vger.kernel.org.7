Return-Path: <linux-kernel+bounces-845261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31E2BC430D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CD119E0C8F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631882475F7;
	Wed,  8 Oct 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TyGMxtSL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57942459F3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759916999; cv=none; b=FP8uODKuhZxfjRhRGPmGcAXGVFNSTsHLCfyT/+4GY/vTwj8NmSR1HW0KLPvZ4iFJF5XXmx+jcznzhC7AfQTPTY5W+IP13qgCW7VjwkfYSDBOjKgQIQMIWhARwXYbt9NNJLjjTUWxrl79AVbv1lbmHdUbBO1JFIa23KDUwUT8ty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759916999; c=relaxed/simple;
	bh=YLPbbGKuA7ad+uu7UDrX6Hi8Nr584besD46aL/up2Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmJG3NuJJDNmiGtrsOiJEFZRTu3U3qpMIDTb/E4aE0qdUsO7Ln5AdcMSZQT5OTEr6O55uduZ+mreiEgioTy640WoV9DrZQy1n/fHXxNHiYHRqpwq2yQno58pWpOExuyhpUKKwDJs+GMeu9+FVcAeaqmoizvoufFtuu44J9ILPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TyGMxtSL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890Pe4015814
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 09:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t7CuvV2u6L4yniEX/2Hwh9AlupGQ4BQt15mf9CCb1dc=; b=TyGMxtSL0NiA31Fr
	TFkeWztrxxQNPVTz2HWLJ8Qno0CLFOHP88evX1HpJzQ3icJMH5wtxJeKvk08s3Ke
	Sbyf3M/PdrjDLu456GJHAIukEa4d38BDOs3sg5YUW7XI5L+QyQI4E899EnaBSFRO
	fFLTInS0FqHmCiDz56QapAHljACEZyqQw/fr+2jF9tDmf+3HnqsqsdVq+atvxOKK
	IvWnM6aIY6x2eIER7xkjxPDK6k8HgWCsUUYWKHnD45NkMHC7kDUgeZb7w+jgGswY
	9niRo1zlfW+LaqUPy2tkKon+0y+qdKHQjdKhbUWsjkpuBO3lYs3Hu5//dsASnu0Q
	2CIMvQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk721m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:49:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-819d2492a75so334634285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759916996; x=1760521796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7CuvV2u6L4yniEX/2Hwh9AlupGQ4BQt15mf9CCb1dc=;
        b=DNyqtM7r1To2VgcvZKUjEZmNOnLZ0V7NVLJhknPXpJrQctdPAHPExVkrjMLWaLU71i
         3kNQS5ykIlCEUz+KX2yqK0tSfhLS/mrC0d2xpc1Swi1DWfN7oB/Hoqxa2teCIso2XsDO
         u20ojIYupyTmj6I0pUAOIMTqjIPkHPBlPd4ZQXHkMtSJdRLtJWti80JqcWtts21AA3hU
         1MA1djIEQp+jh7S84VeS2LGPEjnowJVn7ZxZckOVt7czYf5lOz/qDvPOM92E/auOzq46
         PkZbryvBLMGcQMsEB9Ts1ZEWDM9d7i5BZW/xRrTjUrloGKxqyNNsRmFqNOebx5xAIFf/
         DYRw==
X-Forwarded-Encrypted: i=1; AJvYcCXfVxBzQUhRxSnY+oyduHy/DmZTLim0iYQ6yC/TgHhvyZImyDlc3cNulfxpAho2xrZmZ3q7qHzhqhFlgco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd4WgcO/V3pv+5z6Cz+kA6vBPvm7CXs/1GAZmNCOOAtLD7Nl2i
	0zZAcpe83iLLA9hsUV3q0Sh4FupOX2wK9You/4DmW2zlIwxj6IjBBM4O+85BwpYTJMZo9s185V9
	vVzcapfGENDT4gcSq1qXvqAtlBHGbhsYSqL49R9McNa28C5smJpcS9heQDb1ajFGgMmk=
X-Gm-Gg: ASbGncsq8VO5oLTETsy4HBT+q7SO5h0Gn7mEaOZGXEgz8VMl+i5fLR/AYugnmhN76V8
	5408VOTdeDyp6kxHD7CxGXt1JaHE4Zi+lurYnFh0ZRK/6sdXIXTY7RAXNhJojELaZnsuF7wZxe7
	boHaEIOE7tE/Drp3LMg6AfS41XGHW3cECMd+7f4sAbgSCP2T+5+vl5vZMS5JIwDkH+L6GbeWJWa
	CCiDfIU53ThCX7WMZAWsm2iRBOOBHjeGHpkkKu3RkXp4hjlXUnkzhLwvviAPouTOV6g+PqW9Cye
	nMXgA99Wg+J+jAr1+6VSqVdISYCpuCLPu4XOG2YBbpiW09QNQEam/b+KM94q7DP79mXzZuWGNed
	NP+ZbjdJC8yFBxejLhL9vsXZkbV0=
X-Received: by 2002:a05:620a:1a2a:b0:834:bb79:1d71 with SMTP id af79cd13be357-883525bfa60mr270824285a.2.1759916995578;
        Wed, 08 Oct 2025 02:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6ShkQ+HXLLf6CWx570a8HRdqjNiQWHzj9O/Ol/Pm6+ApIb7tMauB43gjAAY27lh5dA80prA==
X-Received: by 2002:a05:620a:1a2a:b0:834:bb79:1d71 with SMTP id af79cd13be357-883525bfa60mr270822185a.2.1759916994867;
        Wed, 08 Oct 2025 02:49:54 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865a83482sm1629255366b.26.2025.10.08.02.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 02:49:54 -0700 (PDT)
Message-ID: <2a5f3286-7f79-4003-afcb-082dc61b6d2d@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 11:49:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] Peripheral Image Loader support for Qualcomm
 SoCs running Linux host at EL2
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com>
 <aNEEglLZTJuR1sLi@linaro.org>
 <20250922094732.6tupym6ulroctm5m@hu-mojha-hyd.qualcomm.com>
 <aNEcngb2T62HYlMq@linaro.org>
 <20250922103327.ylyqwo5hpmtsbx6q@hu-mojha-hyd.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250922103327.ylyqwo5hpmtsbx6q@hu-mojha-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfX6BgoZTXc0KG7
 CQWVUrFkAgyGoKR5DoxC0OgSAPde9EXK5U9Q77T38FVOZ8LLgCQzpdtcWoJPeRn9l+FsVuojF6w
 3gHHU7PSefsvYXc0wRak9h4aBJaeOLwSvdRaYJJhG9e2vG6McJtwfchehiyq9VoDfAH6nV4Tr54
 ozg6bE8xaF0KRd9XQX4SkZNl4DKBTXqetHck7o1LiGP+zFFYlLL3suHwsWBP5c/S+dkti/xz8V9
 Xf35hIT2dn6snxNN8hZUuDheeXS+IRQDlXHseLW3sPJ/n9cH/rJKQfu7SphLDpgLU/oJIG815f/
 +i/dS92lWNCqwFDEFTYvrSL9qjlxHch++OYoy0jWVLnYv4jnQ6iJzUzh0t9nzCQUt5Wbvou4GSE
 7eiKgREgkUoGjamn1LhJZYOsCG7CLQ==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e633c4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=wlnWjB0Fb1V8A_MKSHgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 7hdVte1kwoV2NmxC_29i26EA1BNPn0DH
X-Proofpoint-ORIG-GUID: 7hdVte1kwoV2NmxC_29i26EA1BNPn0DH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017

On 9/22/25 12:33 PM, Mukesh Ojha wrote:
> On Mon, Sep 22, 2025 at 11:53:34AM +0200, Stephan Gerhold wrote:
>> On Mon, Sep 22, 2025 at 03:17:32PM +0530, Mukesh Ojha wrote:
>>> On Mon, Sep 22, 2025 at 10:10:42AM +0200, Stephan Gerhold wrote:
>>>> On Sun, Sep 21, 2025 at 01:10:58AM +0530, Mukesh Ojha wrote:
>>>>> A few months ago, we discussed the challenges at Linaro Connect 2025 [1] 
>>>>> related to Secure PAS remoteproc enablement when Linux is running at EL2.
>>>>>
>>>>> [1] https://resources.linaro.org/en/resource/sF8jXifdb9V1mUefdbfafa
>>>>>
>>>>> Below, is the summary of the discussion.
>>>>>
>>>>> Qualcomm is working to enable remote processors on the SA8775p SoC with
>>>>> a Linux host running at EL2. In doing so, it has encountered several
>>>>> challenges related to how the remoteproc framework is handled when Linux
>>>>> runs at EL1.
>>>>>
>>>>> One of the main challenges arises from differences in how IOMMU
>>>>> translation is currently managed on SoCs running the Qualcomm EL2
>>>>> hypervisor (QHEE), where IOMMU translation for any device is entirely
>>>>> owned by the hypervisor. Additionally, the firmware for remote
>>>>> processors does not contain a resource table, which would typically
>>>>> include the necessary IOMMU configuration settings.
>>>>>
>>>>> Qualcomm SoCs running with QHEE (EL2) have been utilizing the Peripheral
>>>>> Authentication Service (PAS) from TrustZone (TZ) firmware to securely
>>>>> authenticate and reset remote processors via a single SMC call,
>>>>> _auth_and_reset_. This call is first trapped by QHEE, which then invokes
>>>>> TZ for authentication. Once authentication is complete, the call returns
>>>>> to QHEE, which sets up the IOMMU translation scheme for the remote
>>>>> processors and subsequently brings them out of reset. The design of the
>>>>> Qualcomm EL2 hypervisor dictates that the Linux host OS running at EL1
>>>>> is not permitted to configure IOMMU translation for remote processors,
>>>>> and only a single-stage translation is configured.
>>>>>
>>>>> To make the remote processor bring-up (PAS) sequence
>>>>> hypervisor-independent, the auth_and_reset SMC call is now handled
>>>>> entirely by TZ. However, the issue of IOMMU configuration remains
>>>>> unresolved, for example a scenario, when KVM host at EL2 has no
>>>>> knowledge of the remote processors’ IOMMU settings.  This is being
>>>>> addressed by overlaying the IOMMU properties when the SoC runs a Linux
>>>>> host at EL2. SMC call is being provided from the TrustZone firmware to
>>>>> retrieve the resource table for a given subsystem.
>>>>>
>>>>> There are also remote processors such as those for video, camera, and
>>>>> graphics that do not use the remoteproc framework to manage their
>>>>> lifecycle. Instead, they rely on the Qualcomm PAS service to
>>>>> authenticate their firmware. These processors also need to be brought
>>>>> out of reset when Linux is running at EL2. The client drivers for these
>>>>> processors use the MDT loader function to load and authenticate
>>>>> firmware. Similar to the Qualcomm remoteproc PAS driver, they also need
>>>>> to retrieve the resource table, create a shared memory bridge
>>>>> (shmbridge), and map the resources before bringing the processors out of
>>>>> reset.
>>>>>
>>>>> This series has dependency on below series for creating SHMbridge over
>>>>> carveout memory. It seems to be merged on linux-next and pushed for 6.18.
>>>>>
>>>>> https://lore.kernel.org/lkml/20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com/
>>>>>
>>>>> It is based on next-20250919 where above series is already merged
>>>>> and tested on SA8775p which is now called Lemans IOT platform and
>>>>> does not addresses DMA problem discussed at [1] which is future
>>>>> scope of the series.
>>>>>
>>>>
>>>> When testing your series on Lemans, what happens with the additional
>>>> SIDs from the peripherals assigned to the remoteproc ("DMA masters" in
>>>> your talk)? Are these running in bypass because the previous firmware
>>>> component (Gunyah?) had allocated SMMU SMRs for these?
>>>
>>> There is no DMA usecase present for Lemans but can exist for other SoC.
>>>
>>>>
>>>> It would be worth mentioning this in the cover letter (and perhaps as
>>>> part of the EL2 overlay patch as well), since it is unclear otherwise
>>>> why your series does not result in crashes the first time a remoteproc
>>>> tries to use one of these DMA-capable peripherals.
>>>
>>> As I said above, It is not present for Lemans;
>>>
>>
>> Ok, thanks for clarifying. In other words: The IOMMU SIDs you have
>> specified in the overlay so far are sufficient for the current firmware
>> use cases to run successfully on Lemans?
> 
> Yes.
> 
>>
>>> To handle the DMA use case in generic way, we might require extention
>>> change in remoteproc or generic iommu framework to handles these
>>> scenario like its SID and memory resources should be communicated
>>> through firmware resource table or device tree or some way.
>>>
>>> And same scenario when resource table section not present in firmware
>>> binary ? like most of the Qualcomm platforms, how these cases would be
>>> handled and I believe this is similar to the problem video is facing for
>>> non-pixel case.
>>
>> It is sort of similar, except in this case Linux doesn't really do
>> anything itself with the mappings. In the video case, Linux dynamically
>> maps buffers (or similar) into those address spaces, while in the
>> remoteproc case those are fixed(?) for a specific firmware binary. At
>> least if I understood the explanations in your talk correctly.
> 
> Memory region used by DMA use case would be fixed with subsystem
> carveout memory but need to be mapped with DMA SID before subsystem
> boots up so that it could use the DMA. So, it looks to be subdevice
> for remote processor but programming of DMA taken care by
> remote processor firmware and those detail would not be mentioned in
> Application processor device tree.

Sounds like something we can just stick into the resource table too,
then, along with all the SID data if/once that proposal gets through

Konrad


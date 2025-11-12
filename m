Return-Path: <linux-kernel+bounces-897310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50973C5294A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54A43B609F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9DD2248AE;
	Wed, 12 Nov 2025 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DkzSjzv7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K0fHVHyo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E807222587
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955113; cv=none; b=ZvtWIWXeE/6vTiEpr14qfd+tmL12mdlwDODAsLMMkBN6p827PYD4RQIYeaaupNVL8NbVJb1/AcqktTgnZR7kv4yEpNIeh6LGToAzxRFYbivQfpXyp3Pg+KGoQ4KNivtw7svx03w+ddAiOvt519GX5mZdYUafJ16nvHWhEN3ejts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955113; c=relaxed/simple;
	bh=yZlm64Xo7tNfkx1+xvSIHbmWeEwKfmd5rKUB4NN5lWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIWRlLZ3WDBsYGnBc2KNZ0NVvRVE+mubgWCEEyxiHrVE460uzLUXZDjgj7QxQavKzMgGZ9irm6KPV2g1Cz3Fu4fVY6/mLgEgtJ1rIrZ6zWlS9YYaqX8yY1TmxiCfVLhaDH8TkUSDDY+fAuV3f6GCVOtX+yM0lX+dV4iulCaiX7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DkzSjzv7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K0fHVHyo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9hcA2908048
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qGXDUZfwsFaeBt+mI+uOkjAH29Y58afQeL3Rc1JtMjU=; b=DkzSjzv7o890FYzS
	PBiPzp55r4DJMOP29CmA8Sqo05Q4TKIbmj95EaPeqWWnkd7n7ssJzT3K6OzItw+S
	SiyjcxBWTAHBfIoyfvSdtNrjopSWDFF2z0DEOUztvgtFdJptwCS3nI/ef67tW/ho
	kmDq/sUiFJYzpxvmVLww9GJAyVxCl32gu1Apg/6oi4GqVGn9smOkS/cDbPDlC50T
	7YvxvQyN4QIevIwB6DvVJkSWE50k379exeVVACRgedoP3kTRA+dI8cmfXTrIhfam
	/V6u8uGdGYwaE02sycCc6ANZDLWkvMkv6fosAbUnSW/isUMVUfi/9uLrywQ4/sLQ
	4nyjVw==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqur8n6t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:45:10 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-3e13cddf515so248012fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762955109; x=1763559909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qGXDUZfwsFaeBt+mI+uOkjAH29Y58afQeL3Rc1JtMjU=;
        b=K0fHVHyoQeGOhQdmxM97swZwb1AQVzGAVRetCQ5XaLhP5IVFAaolUtzI6B6dtNAD6j
         XHGDtUjFUttIs0Q4ma9OiMT0MBcEtQbcs53nA88V2D1pDiKkg3N7dX9XH12oY14+llW7
         iwuPvxboKEZDdNbLKFqQZ0JbxTSKxwPO5K5UenpBqofFWwDgOwiUXVvGYYhNd1xsWMwU
         D6bXN5YhyprcFWmIJ4IKwYAPBjnxajYOOWV2fLYBVfW2AtZkFzBryl7iy4zyK21ncMOq
         7nxfGibWl7Q2A+axz93EnyAziuxS8QuXLUaWFBk0zEoel+KU5QdZPi/oNbRrWGlsPCC+
         dxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955109; x=1763559909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGXDUZfwsFaeBt+mI+uOkjAH29Y58afQeL3Rc1JtMjU=;
        b=wqPQ2QCFJjU+g7Gns1LMvK4Z9BEHbOw7/QnLaWPW58A6RmEWNp5smIL5d7w4E82B1A
         Seq0mf77gpBYFdq6ZcrpgF6wnga2WCOFk9YPoLoPUY53qfMCnDURQF/WHYINmEEh5FAS
         ufp6ONHNI9/zvMPloj4bPniYOLAxb8jXzacpAc8ub0QKcgAw/Cz3nqysreExvO9Epdk2
         tOlXr9xlFXGDmZ3RVv2pgTyCLQHq363lgulqLSliDomKr0iAgObWcI7DKFKAhDC3kSU/
         qGwyj4OcfqNx1ApMHdoXg8+hySY9tEFHuJWRMaBAFZG0RFd7H3alHtIWoOHbz2acAQ75
         cnFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl6FMr5DTwYV/A0qMwyV+zyIoqgG/cnyH6wNBKrqPZIX0cYI5q9dFQkMeGc/lS74cean+rIGYxmwsOi5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzai9e09LxJv8eutcQQClahvAHHhb5wf+8foopDabZIWDU+Cepk
	83E+KGJpH61T8CiOhFTDrZIRxST4h41Ezhj/AH6SYnD/v+fUVfTRhWFa3sDKD0bMbJcYjL9FdOH
	jmBtDSIJYYm31R7ws4LsdgAjSCw5Y6rJGYGj/pStnu/tzVlbMLPQE12x3yXutuLYZz5Y=
X-Gm-Gg: ASbGncszQBURKOWjrnscKkeTAZ9zvJvFYWsdImycMvViR2zNhNs04MjIRQHvDqgsjM/
	p323PPjh8fooxYS3LdzDbslBz4UL9P8yv6C9FYaGzikyOPwwDOPdirZdAGYBxXZcWl0SVpmlANs
	eOywmqkRFBe23zMumUA+cRp1YQsdDV9zVWUE2u+IQJxyDV1wvNdCCCmWUsINrpNyL9oFyeAdaaI
	f9kcxsz9aQt5vhEmMg9YzCeOXkfrS3TegJ1NCtSdPKfIGlhBOsD7ZCplrsdn5wHeQZnwDc7iI/G
	9wEd7Uh/iy4tJlAy6OezLanzpfm+zRHct69recGjWD08YuT4ymuN87HgydHJKdpE+BIdk3KPSAP
	XInO/uFNBp3yhZBaPNO0h3jK9QS8lR4Gu+8L2UUCQk9LT0DbL+U/kbWwT
X-Received: by 2002:ac8:5808:0:b0:4ed:a8f8:307b with SMTP id d75a77b69052e-4eddba75ee9mr26331581cf.0.1762954467852;
        Wed, 12 Nov 2025 05:34:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxtX+WAajjcT2p8bWAOl+s/zxUhDfeHoxA5vB04XFWyNVaIXKxhv+DFjlp7i/O3F94Gm5Rmg==
X-Received: by 2002:ac8:5808:0:b0:4ed:a8f8:307b with SMTP id d75a77b69052e-4eddba75ee9mr26331151cf.0.1762954467258;
        Wed, 12 Nov 2025 05:34:27 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7339a7078dsm105318066b.6.2025.11.12.05.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 05:34:26 -0800 (PST)
Message-ID: <5a1aaf4a-c5d5-42e1-9044-d12a6c231904@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 14:34:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 0/5] iommu/arm-smmu: introduction of ACTLR
 implementation for Qualcomm SoCs
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Enric Balletbo i Serra <eballetb@redhat.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com,
        dmitry.baryshkov@linaro.org, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Eric Chanudet <echanude@redhat.com>, charan.kalla@oss.qualcomm.com
References: <20241212151402.159102-1-quic_bibekkum@quicinc.com>
 <CALE0LRupg93WsBVc62Lqt-T9qmK5MdEYoScxyP7=ttKJYXAsUA@mail.gmail.com>
 <33826089-54b5-47bc-8a5b-6004c7a276b8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <33826089-54b5-47bc-8a5b-6004c7a276b8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExMSBTYWx0ZWRfX4uZig34jkzo7
 2YbURgaadFfg3fyUD2Cf5gX/46wmu2Q7LXYtLaE50PsqKamQ3VUKWe+DoAIyTZFiM22wAgZvju/
 D6f/Y/HGhScP3VynChKkAYGj4gRmqfpPYObXRE0KsNCN4Blq0C+fXSvLZ8qpAyq5ogfPggDSRZA
 h5ohUcmY95haGn5LpzzGiAfTxOoLpa7kkVDGprSX13CFMN96arRtPDl5NTz7QFLxfHBPrR3JdV/
 6M1zJCQxJtqTrpvXUoxtfp1+i2LOOMQen5sozaEeIztkKlulr359DfCIyEvMtM2QwfB72eOQivo
 PKxpnelKLWp2LrrJJqOkAYPjtWkrtzdDN1PivaBG9UdFGvTPR2X11+WWukj4+pfAvhJSo0wPmLT
 57fG494IbuWZRDDBP3UwT1alcpdfXw==
X-Proofpoint-GUID: _MrMCjIP3-rNwWwJYSCEw23wCXN54h5Q
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69148f66 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8
 a=i3X5FwGiAAAA:8 a=EUspDBNiAAAA:8 a=SKrgUew0zp_WtuwtRiYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22 a=TjNXssC_j7lpFel5tvFf:22
 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-ORIG-GUID: _MrMCjIP3-rNwWwJYSCEw23wCXN54h5Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120111

On 11/12/25 9:45 AM, Bibek Kumar Patro wrote:
> 
> 
> On 11/7/2025 2:58 PM, Enric Balletbo i Serra wrote:
>> On Thu, Dec 12, 2024 at 4:14 PM Bibek Kumar Patro
>> <quic_bibekkum@quicinc.com> wrote:
>>>
>>> This patch series consist of six parts and covers the following:
>>>
>>> 1. Provide option to re-enable context caching to retain prefetcher
>>>     settings during reset and runtime suspend.
>>>
>>> 2. Remove cfg inside qcom_smmu structure and replace it with single
>>>     pointer to qcom_smmu_match_data avoiding replication of multiple
>>>     members from same.
>>>
>>> 3. Add support for ACTLR PRR bit setup via adreno-smmu-priv interface.
>>>
>>> 4. Introduce intital set of driver changes to implement ACTLR register
>>>     for custom prefetcher settings in Qualcomm SoCs.
>>>
>>> 5. Add ACTLR data and support for qcom_smmu_500.
>>>
>>> Changes in v18 from v17_RESEND:
>>>   - 1/5 : No changes
>>>   - 2/5 : No changes - reviewed-by tags collected
>>>   - 3/5 : Addition of
>>>     pm_runtime_resume_and_get()/pm_runtime_put_autosuspend()
>>>     around register access of PRR related private interfaces
>>>     as discussed in v17_RESEND.
>>>   - 4/5, 5/5 : No changes - reviewed-by tags collected
>>>   Link to v17_RESEND:
>>>   https://lore.kernel.org/all/20241114160721.1527934-1-quic_bibekkum@quicinc.com/
>>>
>>> Resend of v17:
>>>   Addition of minor fix of the build warning reported by kernel test robot [1] by powerpc_random config [2].
>>>   [1]:https://lore.kernel.org/all/202411140748.6mcFdJdO-lkp@intel.com/#t
>>>   [2]:https://download.01.org/0day-ci/archive/20241114/202411140748.6mcFdJdO-lkp@intel.com/config
>>>
>>> Changes in v17 from v16:
>>>   Tags provided earlier not collected yet on patch 1/5, 3/5, 4/5, 5/5
>>>   due to the following revisions:
>>>   - 1/5 : Move the CPRE workaround out of qualcomm specific logic and gate with config
>>>           , update the silicon-errata.rst file
>>>   - 2/5 : No changes - reviewed-by tags collected
>>>   - 3/5 : Move the compatible check before assignment of callback as suggested.
>>>   - 4/5 : Add the actlr setting for *adreno variant* of MMU-500 as well.
>>>   - 5/5 : Due to changes in 1/5, minor refactoring had to be done before adding table.
>>>   Link to v16:
>>>   https://lore.kernel.org/all/20241008125410.3422512-1-quic_bibekkum@quicinc.com/
>>>
>>> Changes in v16 from v15:
>>>   - Incorporate Dimitry's suggestion on patch 4/5 to use dev_dbg instead of dev_notice.
>>>   - Fix kernel test robot warning [1] coming for 32bit architecture configuration.
>>>   - Updatingthe tags
>>>   [1]: https://lore.kernel.org/all/202409230343.Q8KnYl2w-lkp@intel.com/
>>>   Link to v15:
>>>   https://lore.kernel.org/all/20240920155813.3434021-1-quic_bibekkum@quicinc.com/
>>>
>>> Changes in v15 from v14:
>>>   - As discussed with Robin and Dmitry modify the actlr table and logic to use
>>>     compatible string instead of sid, mask for device matching which is
>>>     similar to qcom_smmu_client_of_match mechanism.
>>>   - Expand the comment in qcom_smmu500_reset to document reason why CPRE bit is re-enabled again
>>>     after arm_mmu500_reset resets the bit.
>>>   - Rearrange the series in order to keep prefetch setting patches in the end.
>>>   Link to v14:
>>>   https://lore.kernel.org/all/20240816174259.2056829-1-quic_bibekkum@quicinc.com/
>>>
>>
>> Hi all,
>>
>> I've been looking at the evolution of the Qualcomm SMMU driver
>> (arm-smmu-qcom.c) and had a question about the design change for
>> configuring the SMMU_CB_ACTLR register.
>>
>> It appears there are two different approaches:
>>
>> 1. The "SID" Approach (Older): In some versions, a driver would use a
>> large, platform-specific struct (e.g., sa8775p_apps_actlr_cfg) that
>> maps individual Stream IDs (SIDs) to specific ACTLR values. This
>> allowed for very granular, per-SID tuning. For example, a device with
>> 10 SIDs could have a specific setting for just one (0x2141), while the
>> others used a default.
>>
>> 2. The "Compatible String" Approach (Newer/Upstream): The current
>> upstream driver appears to use a client_match array (an of_device_id
>> list) in qcom_smmu_init_context. This maps a device's compatible
>> string to a single ACTLR value, which is then written to the device's
>> assigned Context Bank.
>>
>> I want to make sure I understand the implications of this new, simpler
>> approach, as it seems to introduce a trade-off where granularity is
>> lost:
>>
>> Multiple SIDs, One Device: A single device that uses many SIDs in the
>> device tree (e.g., the video codec, which might list 0x2141, 0x25C1,
>> 0x2161, etc.) will now have one ACTLR setting applied to the Context
>> Bank that serves all of those SIDs, even if the old SID-based list
>> only specified a setting for one of them.
>>
>> Am I correct in this analysis? I'm assuming this was an intentional
>> design choice to simplify the driver, based on the assumption that all
>> SIDs for a single device (and all devices with the same compatible)
>> can share the same ACTLR tuning.
>>
> 
> Hi Eric,
> 
> If a device has multiple SIDs, all serving the same functionality and grouped under the same "iommus" field, for example:
> 
> iommus = <&apps_smmu, 0x2141, 0x0>,
>           <&apps_smmu, 0x25c1, 0x0>,
>           <&apps_smmu, 0x2161, 0x0>;
> 
> In this case, all the SIDs will be associated with the same context bank. Even if the three SIDs have different ACTLR settings, since SMMU_CB_ACTLR is per CB setting, all SIDs attached to that bank will share the same ACTLR configuration. This is why we designed it to be "per device / per compatible".

Does that suggest the settings may be slightly suboptimal?

There's some work being done to allow more granular association of
the passed SIDs:

https://lore.kernel.org/linux-arm-msm/20250928171718.436440-1-charan.kalla@oss.qualcomm.com/

Konrad


Return-Path: <linux-kernel+bounces-798429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90826B41DCF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B7868518D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4923D2FCBF5;
	Wed,  3 Sep 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hzvw6X4s"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB86A2F83C1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900585; cv=none; b=RO7xQwGXrCIFgXt/h1USLYSkki3szybge5/xh+LYuZjQDKygbQ4KVwFJouYEr1xRK4XIO4QG6mrOiaqYxJathChnUtJ+9FuTOQzu9l4F6lD8CcV6WN5dU3SEctTJZhnZtiSEPn9NDz5qDtiumQwJ6e9okreVD4jg+S+Z2K49C/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900585; c=relaxed/simple;
	bh=sejB4B1VrSQBOMLPVXX5bt2MvNQlg+CmI1uFhYHvW2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BDOjy1dJpY4fasdj7Fbm4Se6XHxTSJai/zyYOf+gCZdEpGEmnVlFHfiqdmRfb85JKHqo9FHDbfF5qDEf/59Ozwsaq3Igdf7FI1EeJJspZnTvBPJzfNNzjsiD7tGQ5CnIdn9UsVzf6zm+KUEGCWyzLMNzF3uESbf3o/BQq9idHMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hzvw6X4s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF1eT013822
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g4aQ0pxQ8JYCo7v46mupCXOW5xYkzPzISF/wAL9cnQE=; b=hzvw6X4sTdBJaXNp
	UEw15rWanYGYyWThODLfG9E7gFuIIyN+6ZLD66WeqXnvyV4d//My/IhDw6syRkUO
	TJnBA8r7cUug17RA6ToiqUs3UzLCCjCmuLnzWphuSFjkAL67+mtafghYkQMXXpdz
	tWjrIrajWgEmVnLcixne5p8zHfKdXqTLsBd/i9zH3SEI37dL2xbBt+VihBewwOmz
	OPgLW7eI50k3jmQSPEUpNHgFZl4GiDB5PgxQY9QHRceGQWyX25X2DPeMSO/r6VNF
	ARemFZKdurbWXGa23Mqy2qXblbr1/D/Gw07k1FZVDim8lliyUWTe8z/xF8fTQX7C
	w33IXg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv3njn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:56:22 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b4bcb1e32dso512251cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900582; x=1757505382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4aQ0pxQ8JYCo7v46mupCXOW5xYkzPzISF/wAL9cnQE=;
        b=e2Lonq98k01ZIM0WQuBOgJbUioSyRz4qCTMKOrEMcsVwJz+3IK4Ryp6fAudqvE6mBx
         fJkigM4VA0c3wTLbcaFmOiCo+tp8Pxwj9MrqkRCpvpPzbzSK96ApDMbWeFX7gbn9hfUB
         9pOaLJWFvyJ2hXi7avmKbAGP5CkdRhVzSC/MF2Tuq9NVu2wTYEydBaqGdKI3gCTrPHdh
         TipDY8iNXK3qv56upRvkvpvZIrpZjix8Zf7ke69IRvzcn/mmgB3JyZ7CT3pyr3zvre53
         VMazu25vL2HZfFuYr1sQrraUxP/eOebBdj8aPlPezwokfRRQoyfkzqTqlYA6UcN054YY
         wMmw==
X-Forwarded-Encrypted: i=1; AJvYcCXnZ0GdT3o2+BExntMurs2/EQqZ10sRNIuoATqE+RKbGkQfL3WHPBotwz3Sjm5xAFkAlkX8EdiDFFXnxgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx75+/is57Gsf+Gi+ZeODFH2MCWX31AafRDZNdNtXnrUQ3cYzG/
	kvkhlsDS7rjV0Fj7Izod0XSROOO5eTWT31HvdBmSlQash/nXDcsT/6+i0cXVJ0fCufWhXI4wgXj
	G6Nx7yNy+6Pr07Nkd+VfsRbrjTSKTJsogm2qKgQADynR+dWTWGf2iqA60120DKMvgZaQ=
X-Gm-Gg: ASbGncsAT4bXIQGFMM+EorVIWAraz35rC6tz2lFqij8uZjRKx4rGxC11y23RPDF5fSt
	ofeP4rFO+VXQZ6t8QVoKzJjYJn7KLS2whFW1KMYJ8fLrvbM1hu7I4rSuPeYzu3i0XUBpOAnRMQi
	j8SR2StFxBOr0mfB+iGNb9i79aRaD28HqFhiIkZEuEOx0YGxnS1Kk403iC/6+xE2y8hKRHTJ6Rg
	7ueaUmWYrw+26NJrXKAIoCewGCE6oSVIRa1jPqUIQ88nTxgrTbpMVR4Mx4a6Q2ZWq1X2P5ajKF/
	vffj9W5sE2+M+W940KOPAN6vdraT1MAbiumQY3Ar10EnEutfDeUgwnDm6Kb2mL/navKHG+L0n8G
	TyIJ0fidENUp0eSJWdvPyAg==
X-Received: by 2002:a05:622a:1992:b0:4ab:7633:c58e with SMTP id d75a77b69052e-4b313dd0295mr146230031cf.2.1756900581647;
        Wed, 03 Sep 2025 04:56:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWs2OE38njma1pgqxQrhEt1KbpBuqDAUfzbSzk/nuiAqrnphje0GRaFExIVuEIMTabORkNTg==
X-Received: by 2002:a05:622a:1992:b0:4ab:7633:c58e with SMTP id d75a77b69052e-4b313dd0295mr146229801cf.2.1756900581153;
        Wed, 03 Sep 2025 04:56:21 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0427c0d4cbsm760372866b.45.2025.09.03.04.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 04:56:20 -0700 (PDT)
Message-ID: <f5582304-8f55-4c3b-b752-9cefa1e4df96@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 13:56:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] Peripheral Image Loader support for Qualcomm
 SoCs running Linux host at EL2
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <660c2594-9a93-450e-9a2e-17ef6b4c696d@linaro.org>
 <20250820112242.usd4sdd3avxdlcas@hu-mojha-hyd.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250820112242.usd4sdd3avxdlcas@hu-mojha-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX/P/0RfdMVRWV
 q7ZU8uCEJXBQC5tu3c/7cIbN0m+G65cQaifP2xIyzQ2JmENO4EkQXHfR0iY8k7hASIp2hC/6pDh
 Wa0pcu6LcNZJymSS9AIiPpZyz4XvIEUu7tF41+l6oN593yZ29hMKvRs0YntMgM3cs6V6Mvx3KCS
 aTK/7HquMEVHfz+sykEcGKlPrmvjueFMTf2Tqi1r/FTPNE93lCDxZOJeLr4RM8k2Ii5nOiNIDVX
 ASS0OfxjbVDv51DQGJN0fjVfSP7nhYUsCrqaGbBNwSzrDc5v/J5woAVy9bZ+iljS24yk5inMPfr
 lGLsI6E3RdGetweWyZDjL8kDkyzfEt6jE4KnkIa1xs11VGDGa2e8WwNISw+sHfB3WOWQX8k8FD1
 kZzYzPQF
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b82ce6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=eCxR2MOvM2WBuziOM_EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: cZvKM2qG4yMN4t_lrWg967gZ0fBFDW1u
X-Proofpoint-GUID: cZvKM2qG4yMN4t_lrWg967gZ0fBFDW1u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

On 8/20/25 1:22 PM, Mukesh Ojha wrote:
> On Wed, Aug 20, 2025 at 12:03:16PM +0100, Bryan O'Donoghue wrote:
>> On 19/08/2025 17:54, Mukesh Ojha wrote:
>>> This is a further continuation with a new approach to the topic
>>> discussed in [1] regarding the enablement of Secure Peripheral Image
>>> Loader support on Qualcomm SoCs when Linux runs at EL2.
>>>
>>> A few months ago, we also discussed the challenges at Linaro Connect
>>> 2025 [2] related to enabling remoteproc when Linux is running at EL2.
>>>
>>> [1]
>>> https://lore.kernel.org/lkml/20241004212359.2263502-1-quic_mojha@quicinc.com/
>>>
>>> [2]
>>> https://resources.linaro.org/en/resource/sF8jXifdb9V1mUefdbfafa
>>>
>>> Below, is the summary of the discussion.
>>
>> Which tree does this apply to exactly ?
>>
>> git-log-graph linux-stable/master
>> * c17b750b3ad9f - (tag: v6.17-rc2, linux-stable/master, linux-stable/HEAD)
>> Linux 6.17-rc2 (3 days ago)
>> *   8d561baae505b - Merge tag 'x86_urgent_for_v6.17_rc2' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (3 days ago)
>>
>> b4 shazam 20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-7-ce7a1a774803@oss.qualcomm.com
>>
>> b4 shazam 20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com
>>
>> Grabbing thread from lore.kernel.org/all/20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com/t.mbox.gz
>> Checking for newer revisions
>> Grabbing search results from lore.kernel.org
>> Analyzing 18 messages in the thread
>> Analyzing 0 code-review messages
>> Checking attestation on all messages, may take a moment...
>> ---
>>   ✓ [PATCH v2 1/11] firmware: qcom_scm: Introduce PAS context initialization
>> helper
>>   ✓ [PATCH v2 2/11] soc: qcom: mdtloader: Add context aware
>> qcom_mdt_pas_load() helper
>>   ✓ [PATCH v2 3/11] firmware: qcom_scm: Add a prep version of auth_and_reset
>> function
>>   ✓ [PATCH v2 4/11] firmware: qcom_scm: Simplify qcom_scm_pas_init_image()
>>   ✓ [PATCH v2 5/11] firmware: qcom_scm: Add shmbridge support to
>> pas_init/release function
>>   ✓ [PATCH v2 6/11] remoteproc: Move resource table data structure to its
>> own header
>>   ✓ [PATCH v2 7/11] firmware: qcom_scm: Add qcom_scm_pas_get_rsc_table() to
>> get resource table
>>   ✓ [PATCH v2 8/11] soc: qcom: mdt_loader: Add helper functions to map and
>> unmap resources
>>   ✓ [PATCH v2 9/11] remoteproc: pas: Extend parse_fw callback to parse
>> resource table
>>   ✓ [PATCH v2 10/11] remoteproc: qcom: pas: Enable Secure PAS support with
>> IOMMU managed by Linux
>>   ✓ [PATCH v2 11/11] media: iris: Enable Secure PAS support with IOMMU
>> managed by Linux
>>   ---
>>   ✓ Signed: DKIM/qualcomm.com (From: mukesh.ojha@oss.qualcomm.com)
>> ---
>> Total patches: 11
>> ---
>> Applying: firmware: qcom_scm: Introduce PAS context initialization helper
>> Applying: soc: qcom: mdtloader: Add context aware qcom_mdt_pas_load() helper
>> Patch failed at 0002 soc: qcom: mdtloader: Add context aware
>> qcom_mdt_pas_load() helper
>> error: patch failed: drivers/remoteproc/qcom_q6v5_pas.c:235
>> error: drivers/remoteproc/qcom_q6v5_pas.c: patch does not apply
>> error: patch failed: drivers/soc/qcom/mdt_loader.c:302
>> error: drivers/soc/qcom/mdt_loader.c: patch does not apply
>> error: patch failed: include/linux/soc/qcom/mdt_loader.h:10
>> error: include/linux/soc/qcom/mdt_loader.h: patch does not apply
>> hint: Use 'git am --show-current-patch=diff' to see the failed patch
>> hint: When you have resolved this problem, run "git am --continue".
>> hint: If you prefer to skip this patch, run "git am --skip" instead.
>> hint: To restore the original branch and stop patching, run "git am
>> --abort".
>> hint: Disable this message with "git config set advice.mergeConflict false"
> 
> Very sorry for the error.
> 
> Can you try with this next-20250814 tag ?

You sent it on the 19th, so it's in your best interest to run a quick

git rebase --onto linux-next/master $(git describe --abbrev=0)

and giving the series a prompt re-test before sending, because there might have
been incompatible changes, whether ones that would prevent applying, or break
things functionally

Konrad


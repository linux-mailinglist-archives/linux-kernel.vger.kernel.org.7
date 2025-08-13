Return-Path: <linux-kernel+bounces-766455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D783AB246BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1640D165880
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111F92F49EC;
	Wed, 13 Aug 2025 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TPoeXl4I"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DA32F2916
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079627; cv=none; b=lj7W/mSUknHrvuTiZ9bieQvovyXxVynnyNYnwX6QeLRQ6MprGdY3+eTjt1n3N7cJQfvY+0A033tMmR+LBXu3gPDjJEVNqJeYuspj34m2aNgHuLrzFxgJLyrUqaqbS1cBBbCwdQ8frOqBOIyLG0FQbXgIQFe/9jp/06fxmmJL6Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079627; c=relaxed/simple;
	bh=CRPKsVAhqXLyl5B9IWZbInaWZbGzzt5vGVn6BvQJQis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFDeQsjqkFP9ro5dUCkBiswlzfbitL5uxr4dH79taWIw4wzSthk31TBaqZTtsL7SLoYFTmVInZKQKG1o+96MMTah+0RoepA3CtIGmMmFL7eD65UOkZzhwp22c9DMI2DcwFucN8Gh7ZV19Anr4v+YkDs1s9dmfgzqNWnkpeSIGgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TPoeXl4I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mJh7002439
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lo/uyCg8eI45CIAczel8wExuTSXtA1VT9FQTS1gDCiI=; b=TPoeXl4IjXVD2YQV
	7PgGj9r/3vk0QoRPKTnaIosHjf093O/ALUsVq61RqOpmDap4f+w999tmLJ9urEst
	Nl7bDUeKgmBth6OefCysUvALMPvErT66ikBQ3GRPjzM0c21pZfj6H7pUbnLkUlp2
	gzHM4yEy5pzomSygB2CLW5ggaKuY8TiOJmkAMhHp+jfz5z0el9m1cbsm+IaaDiWa
	Y1R8WWMZwz84bWml2GpnvdbBo3sb48jZU8MDTVBYu6AKnzDOtm5C48/hM/iXu/Oo
	sxNah/WcqjrvA5pbCeYWSOeMIYin4eFMs4IcVl3hkQQnrhkTGpE1/sHlh5WWjSMJ
	wFZHoQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjq6ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:07:03 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b0dfcd82ebso5938471cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755079623; x=1755684423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lo/uyCg8eI45CIAczel8wExuTSXtA1VT9FQTS1gDCiI=;
        b=Pg10+QB2SyUv5CD4zIjWkJ2/LxlLDCSxt0yI6H4qifXecvIIUTN2RtF9NYahvIgvGL
         Dd0cDpmIjrJzQAdUR//WfZ0XkLWz4ZpljRQnmqgEtMbOuS9CPTEOnZC6rlYasNlYoIb/
         GFUZDu2Q3PzzTqvQzMnC5i6P50ubHgR77dkBZOSzCgvED+5pCLd/YIymZ8wPenm5538z
         f+UPiv13IPLHOMbPusGjr84nsQGa9dlWwDinHe7C4wCbi4f5j7K9RsYJkRLHWUKkY0Sy
         i9xqxsolnbnugaOOUBj5GOaIdjOFIgwovXTRlpsVAG6VKQOyn7X9qJn1hF6SBi7ldvkn
         EavA==
X-Forwarded-Encrypted: i=1; AJvYcCWrMP29KMlppzrLlKTZwV/9WMH7pcYAalYr+uIyfCLfD3wDwlhpspyY624xbtQ9B2yqJEMqwSzH07yuIFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDVpeYEyz1yGIhkey37+MjjTC4Mf15mFWDt/gQVPR4SfoblhIS
	gvmVEphXI8dvyp0rQOXXO8cQC3VnssP6Z3Gd7+x2qVLcxYxJFe2ZF+QKkoKa8eO1fqO4AaTENC4
	AmLR4a6fgZHytaaPwq0mN52v0xBTU6x2CwgoShUf9JjN6Imhams59O53xbaMgHJxKdFI=
X-Gm-Gg: ASbGncs2TEkvVKQ3wD8ZVEzZSb4b5VG5ztlodWPDNrcB9Ndu2SpszupVMPFL2xVu/mn
	AatXiz1iVVrNtPF8udOIbOpzCUbq39XVaVLyKrr87JR6hvswSLr4bRY6FQ8//s68/SZn2AyRUdT
	B+1ml+xhtY2pWjQTGTqnHIbmtapD/IMZl02LtifbDW3J77v2VsdomWPMI0NP07OJOYgI1ZVaktc
	U5zb5LqCrOCVFDWCEt2Uk+QE7G6CfW1Azx+TdD0rnVwymqpSrk2S9hQm+dpDTXfTwqq4V/YgcPR
	Mtsi11HfnAIuz4hS6DfHViP/lD6aM51ToHEjNhV7f+FCCVvYUILUVxLrZqUYfowwWJfLWySEWHU
	zpvoWXfWkWK2vc4H79w==
X-Received: by 2002:ac8:5dce:0:b0:4ab:609f:d7d1 with SMTP id d75a77b69052e-4b0fc6cbd31mr13706741cf.4.1755079622750;
        Wed, 13 Aug 2025 03:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbEx/52bIrz3cKGljrcyVxad9pOt/IN1rRcYfZiJuhcUb6gPtWuoMusDjEvu/er5MYTpmlKg==
X-Received: by 2002:ac8:5dce:0:b0:4ab:609f:d7d1 with SMTP id d75a77b69052e-4b0fc6cbd31mr13706491cf.4.1755079622218;
        Wed, 13 Aug 2025 03:07:02 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3b6csm2371260366b.48.2025.08.13.03.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 03:07:01 -0700 (PDT)
Message-ID: <f10f1602-972a-491f-9c11-95e5e7bd80f8@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 12:06:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/11] firmware: qcom: tzmem: export shm_bridge
 create/delete
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
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-7-ce7a1a774803@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-7-ce7a1a774803@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfXzOhBecuyzZ3c
 Qa0UgM5ktDY9KLgoSw0j9DB0FJZ/5RgRhFioXIYx6VxP/Q+5jppB+RqnvehMRBgSvgzG1g/c+Rp
 RRCesvxnA6vn0DIzR1KNrbp865Vy8NhENxaNuVQM+palyMWlVx4phHlmfKDlSgdXGs7QWUJ1+i8
 YANTOq4WFSiFnERXwuXc62QUwxmUTZSl4K1S7qz9Jq8L/XHMncaHPtYF8PY+z0THlCJ0jWpEfCL
 ZqeERg8h2mMDWbN+k9mnJVs6yU/HGja3nUYwQBxXj4r051qIIIdQ9haiVaw4SYFt/TGHtqJkT0M
 +E+bjI7ZxLQ+3U4VAyRGCfqi6a031L+Jh5U1IVQTv+2tLOENWl30Mgflsjfjo8HIIhkZRO61ytZ
 wAKQedrU
X-Proofpoint-GUID: oDCND0IdVZJw4-R3BfmnR1BFVUJfTWH5
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689c63c7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=clTIM29CJtwRRT_IFxsA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: oDCND0IdVZJw4-R3BfmnR1BFVUJfTWH5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
> Anyone with access to contiguous physical memory should be able to
> share memory with QTEE using shm_bridge.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---

Hm, I thought the idea for the tzmem allocator was to abstract
these operations to prevent users from shooting themselves in
the foot, and this seems to be circumventing that..

Konrad


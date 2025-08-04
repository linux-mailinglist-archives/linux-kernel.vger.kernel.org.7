Return-Path: <linux-kernel+bounces-755303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4954AB1A456
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA3B3B30F1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6B4270EA3;
	Mon,  4 Aug 2025 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FbNECHKS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456F81DED4A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317029; cv=none; b=ctHFRhbG1JHziaeXuHq4NKxEct2TcawZdDz9L9q6GEkxvi0JDVufeCdb8NyW82PiqDhl3lgsmqJLbuWJDTmLw2jF0RHbyx1+eDPHH29AWoLZc/NGb1i8/xVLtTzm3XxALJE5pPchxlWD8LnKh1bfZzunt4IfbElM9vjY0i9kaH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317029; c=relaxed/simple;
	bh=A8DC5GZiezWSG87vEws0C6j85Kf6YPZuvC+TN+JTLpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dpas/5F7kxS+HKcrHO+EqduUztmU0vQUebcVOhEUli3juTdMwqq+M6c4XNJzLxx/znYuHwKeW5x7BqqIUuwjNvd9VMuk9tPE+FfQIVGOrIZBgvnqUmRb111/oedNFcemrNwE62IFndeQs45Zi9nQxf6Tk47MN6T+eTiA9S7koDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FbNECHKS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5749iO3I028174
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 14:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gvpm8a+Po3AvQHyqTVypgq8YhFb8qXLB0jdSvQ5uttg=; b=FbNECHKSPMlvxaR8
	+1TSgffV1F63Cw3pBysSRWE9dSLwjhlmI38dZO7d5+Jqc0QI3LNC71UP5oyfzjtH
	U7xCmKbE7z7Too77s3Y6z8NNOyMJcQ7++P/yiPnavxDkEFpZWazXr7HJr3jYh+Lq
	J++xkirzs7DGhQgqnzB0Lj5JhSjnmjWQ4XfL0Oq6giJowZ4arispTlZdSwPiCQy0
	4f91W0VNc4vW4j5/6+I2wTwn5W0McWr0FiCjhBr9rSQbqSxViluw4/UbwXOhjAby
	P/tR6sbAV3I1rMbRakVDTzel2h8rhXk98hp0G2ZSpOGGJaan8/2OnyF3rpZb70XU
	ALC5OQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48981rngf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 14:17:07 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b38ec062983so2928233a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754317026; x=1754921826;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gvpm8a+Po3AvQHyqTVypgq8YhFb8qXLB0jdSvQ5uttg=;
        b=MvNf7QNLz42HIX4uCrBWjy7CV2rvHE2hfl9VhD35vEHfiPPvoYZIml7+fLwwztLrqI
         L9Rmso0b8/pUZUdtDq6aocEf3F8+ebaH3cg1huhC+Bq2XrConBsmUWodpAq2+5U9Cc7w
         gC/a15llllbyMHUmroMrYL46vfSKixDERRtBuntpASuywtP1QSgt+9s7+9bxQbD6Rf7W
         LCFmdK+Hb2fK80x8vWB8GnzTcA5jQlsup4hNKPDPVuW87RBgODpYZ9LIN8SwVsUL81ow
         IMsjlWNzHGiRvod+EGFG7JkPWBkbM/2uSlMDI04oniW4NwcAPuvYNHPSh3WH25zb6ZsQ
         +iDg==
X-Forwarded-Encrypted: i=1; AJvYcCWBwbnW5Ra1W/7g/1QOJ+utSJHC8dNgGXz0YPrN5kMpLZFqOwa0qjAPcML9D8mJe2Cn9uMJZl0qgt4yai4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGcnFRDitY0v1hdwB0eYzo4Qf6+6v7i3CYohkdEGy2Fyf1pfL
	RCSPkGFD+7bPm7cuKkGg+ct7M88KMsKxjBieS+2O7d2WcQ85AufYR31CxuK12pNcFX6lk9mwrig
	KGSm8PS7KTjGBKKC2EoIzt6TbovKzfhSyEifVoDrnHVT3M24s/+i34FAPyVuy/lmhfig=
X-Gm-Gg: ASbGnctQX8yYvxIOqOxAxSzGwW8mIEJHzI8WEO3F64h7xindqQTtF56SaxZ0MUg4l96
	EUFZgZkIQw71ew6pjaskxcH38sEtpKvGmVTtYGwHcVaWtkyU7WnIJTK3i5gNSl3x/hE1P9lrfU3
	xcI3+4BrhEHYKIlQsdWb5dpDETDCqa4/iRi1O45fUINrzxj2tBWLp+OGS5Us4H9NSlQOUqy3SQR
	1FfIklD/JlKG9qIsxAIl52g5AJG+r/taD20C6mTWcFckUuOQ4ZBtFASdN+OCa4HMoL+aaSPikZ1
	LvchMw/QZQzVolrJhGPQm08lRYmi5iLfKIi9bT1/EQWCYafl6/evtxKt0QLeYfkgRRn///PE12+
	BSmuay8bW+cR5sTSmKQXzVZ4WWNZrPo2B
X-Received: by 2002:a17:902:ef45:b0:240:3dea:b269 with SMTP id d9443c01a7336-24247033fc0mr139082285ad.48.1754317025686;
        Mon, 04 Aug 2025 07:17:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHaeEa9NWdmU9v/K3+J+uYiBAHxa0ZMd4TXiIz+8nIet/FavC5/MvKeVD+zMUzhg/+SbvBVg==
X-Received: by 2002:a17:902:ef45:b0:240:3dea:b269 with SMTP id d9443c01a7336-24247033fc0mr139081745ad.48.1754317025156;
        Mon, 04 Aug 2025 07:17:05 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a81fsm110766825ad.120.2025.08.04.07.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 07:17:04 -0700 (PDT)
Message-ID: <658d7d55-fd5e-42cb-bc5d-abcc0b47a168@oss.qualcomm.com>
Date: Mon, 4 Aug 2025 07:17:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] soc: qcom: mdt_loader: Remove pas id parameter
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
 <20250804-mdtloader-changes-v1-2-5e74629a2241@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250804-mdtloader-changes-v1-2-5e74629a2241@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KwU_rfOShbaPmUYmlGAHpykQrvfix1Zg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3OSBTYWx0ZWRfX25Qg5zqmjQCi
 +fyPSpwWa/9D2hplNPS6W05cIIbajzCRAwIBSdYTWOxQefeSd2dlfDoZjD9XpxhE7QReB4btZ+P
 bvFT6OaUw/LhMlLg2pOaMTX3grn5JHDB3KvzEtO1K+jAm/bNL4NzVqC+ung0POPqZ+kwmL+Mi0r
 3WezJQTFSBefWZdleCkYdHtKcpG/5+Q1Debb1leCMhWsMUoQ3Gh8G3wg4T+SwD8R/O9hirnJ590
 OqV7BKFancK+a3Mu1ps6oxCQg4w4i+72oKtrcUX6nhg2uJEEQRgWIfp9Q+EPBRomWsgf9ql469p
 yAqOsbqeQIRAub1esjXe4tiHSOh+hPextPoY67R5/3gGL9tI03mrFCYd+Nq6VQWxZOwNqCOxfSa
 WqIoRYcgzD7UmX1Nwh/4vgIDcs+f3rvOqj9CnMHpfQMmgZ/bBb1PmSYZWkcTaawogm1VXuKO
X-Proofpoint-GUID: KwU_rfOShbaPmUYmlGAHpykQrvfix1Zg
X-Authority-Analysis: v=2.4 cv=a8Mw9VSF c=1 sm=1 tr=0 ts=6890c0e3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=IDvrs2r2PCma8_SM7s4A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_06,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=948 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040079

On 8/4/2025 5:41 AM, Mukesh Ojha wrote:
> pas id is not used in qcom_mdt_load_no_init() and it should not
> be used as it is non-PAS specific function and has no relation
> to PAS specific mechanism.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/venus/firmware.c |  4 ++--
>  drivers/net/wireless/ath/ath12k/ahb.c        |  2 +-
>  drivers/remoteproc/qcom_q6v5_adsp.c          |  2 +-
>  drivers/remoteproc/qcom_q6v5_pas.c           |  7 +++----
>  drivers/remoteproc/qcom_q6v5_wcss.c          |  2 +-
>  drivers/soc/qcom/mdt_loader.c                | 14 ++++++--------
>  include/linux/soc/qcom/mdt_loader.h          |  7 +++----
>  7 files changed, 17 insertions(+), 21 deletions(-)

Since this patch touches files which go through different maintainers, do you
have a plan on how this will be merged?

I can ack the drivers/net/wireless/ath change once I know how it will be handled.

/jeff


Return-Path: <linux-kernel+bounces-758196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E94DB1CC4C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7570156537E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C518D2BCF75;
	Wed,  6 Aug 2025 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JeWbuwM7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B330626E146
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754507232; cv=none; b=P64PgkHwSkHjPxVORXRTHDqy9bSMt0EEiWjf33KGkMDAnL5G/Dl/srhZ3A3oHX0RCfvpGZItjDpKGykPOGMlehlH0q8Pa93BxpplR+kqkcfq4t1M7dyQzAeLMtwGfuUrv1wrvSD0uahiNN8LlLpEsomz94ZiosAAkklpKkD7PEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754507232; c=relaxed/simple;
	bh=D2fRxsjumskahvRxe7m7fBnGGGqxjZOKk26cSPbI7OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXOM65ATPyq50eWS8cnhYNS9sHFOdMwfarHuLfxHjUNMkklHH2IwZqWzbGXGnC9T0TrTSTfJMSlzN1/pmraHsAc9CkH790aIsq/JRzn3eU+TZ19o65y2n1RRqSsZ2FBS+6iCWaR8bc0awhmgy/pk/oxEkzjBfb5qoT2D6ay8fNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JeWbuwM7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576Dni2s010412
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 19:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pLFDFgtgIMICdEJ792w168OyKixfYM5BYvfWCMHrn0A=; b=JeWbuwM7PL0zAmGW
	+VETreTAUCzm2n053JSNWrko8eWL6LoLI1ezrYAhMJtsVrM+wRZeh3pnIl5k8OV0
	IdE5Y4F2MyaevZLKAcQ5sd9PyxGj8JmMvTgHFxoCGMdr6uUrLo2EfuBT6qdkmKYn
	k3+ifV38vlVJr9NPx6atLCZtMVPbTRo4uzBIFc5v56+rn5NAkjd8IoUV+x4CjQJy
	3baZtNqsShLgsD5rEk8GJMOSGW/wvI4FMys+cNtla66buSDnWRjtmeOMbIKleOfw
	k7X1v0BMLkW/ynYrT1WYBtUCTdbD+D157ShPCNbrdk71zyvtHVbk19hHLzU9mLHs
	4P91jg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy7uu3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 19:07:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-242aa2e4887so3763935ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754507228; x=1755112028;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLFDFgtgIMICdEJ792w168OyKixfYM5BYvfWCMHrn0A=;
        b=OO0gWSJNhT9i7I2GIpt1CRSlAQF0+mkwesbAytPCgvgHZcQ/6po9yuCAkLGuu4PMK9
         d4uuXGQnh5XNqOcjfugib2pcOmnA0h3aCZO6dydgm39yaMueEnwXh+TGb5NdBFlHeetI
         cT7erhNqyVfV8i7AYha5Ygq/+bTQYHSFZnGFfSjqgEz3uu5ubHCEfgZyBbd0BGKK8yNw
         LVn32tk0NWFVDaSc57oAescDNzK1sdvvucmoNgL1Ggwx1631xITtLH1RDI37wdT181Id
         dUUmAoehymSV2CifuKDSZyf4zhbcHjtS4OXTO3+bVQRatFvJai+lN6e7ixgrGvz4G1Yr
         ACKw==
X-Forwarded-Encrypted: i=1; AJvYcCXDhAaRwkUuvUB4cL1Rp9KJOv+esvKOWzShOAAi/SsgZRRj1EHKPTN5sHbaUAJhyxU0O/kPwxMbhWFsvfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOK6KIc9hNUMBkVFiMyz2n3CjNLSvHD3ZoqAV5kOzZm+ayYd8s
	1auGDxSGU89oAK+L+ima4b4pGM6Yg/7pss5OorEirfdRxCWUN2QWoa1r9xnNzWimXW5osqg15Pq
	xLQ5svTMuZoW02DI8zWROPLLI/cCzTwqbAuxyrKKLZddh0SVBJnpHYDL38+9aDbGDoL0=
X-Gm-Gg: ASbGncv6/Y1hOxWAi80HpgOUuwY8ajy2GGSg9B9U6gUMh392atg0qWFRIeWe+DycV7b
	ibWEwn+m8RYCGoeMZ49RxhlGm6QuEfhl///tUJvDT0jseFgrly24Ex0FnlfNWXXQ1XZh/RAcSpD
	qtpDDVXnYBrNI2Ve/fHNKJUEDg8SMLnzsBOfqU/zh1/k6sWSYYD/ION8Ky9qul2VyPl8djgMpPf
	GhRDgfTr2aGMuRohOyiVgEJWtj6EVD81SaBOpUk3n4YHktQAwj191S3dXQLSw2HrTIdvVV1Vy17
	uE9enG1nDfEmhW2mVSjs0Eer1gePv97J1ewDRQ8j1AjE9qHWwNvZTMqHzWDSuetAW9hbKsaHAdT
	ymdf0qIKjmmqSnKzLvmwobxv52tZayTDv
X-Received: by 2002:a17:902:f612:b0:240:469d:beb0 with SMTP id d9443c01a7336-242a0b6fc4cmr58557395ad.31.1754507228309;
        Wed, 06 Aug 2025 12:07:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw/V0KLHuGmmP97g4XfNxYYUiYQuA+Las853A79Nu5Cd7FLuHDuerRqAPRejldbNHXAC6rXA==
X-Received: by 2002:a17:902:f612:b0:240:469d:beb0 with SMTP id d9443c01a7336-242a0b6fc4cmr58556965ad.31.1754507227919;
        Wed, 06 Aug 2025 12:07:07 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef75bdsm164814515ad.11.2025.08.06.12.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 12:07:07 -0700 (PDT)
Message-ID: <c9d761a2-7121-4ce6-84c7-232a6c4ce976@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 12:07:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] soc: qcom: mdt_loader: Remove pas id parameter
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
References: <20250806172531.1865088-1-mukesh.ojha@oss.qualcomm.com>
 <20250806172531.1865088-3-mukesh.ojha@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250806172531.1865088-3-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Mftsu4/f c=1 sm=1 tr=0 ts=6893a7dd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=IDvrs2r2PCma8_SM7s4A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: FX-m4J-7GOerYlQUA68la2FtA6-SfA6A
X-Proofpoint-GUID: FX-m4J-7GOerYlQUA68la2FtA6-SfA6A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXxSGuzbcbkNzT
 JMPEA+97TRlxvEpoFzAfnb5NwueGrHm5EmIwJM7mrrcx34OTlbLK2mG71MGV+yHN7LJXckvZ5bK
 0l7wHQxKhzBhbQE+pJ97zciOTGH9HkAYCpfo33wadsIGpfbOcC4aLPAVHGM3t1FLY4Wph3mOfVS
 Ld34ThoddDfQSwY9w1zkKn7UgKv184CG/htKJN1E8SQY0c0usn158Kj45LwgMord7fbuDcFlRtf
 YOI+Jzu+WAE9Aah4dVOXGAAb0vMIdYEbuZJTtg2KnX1EK1LGdhyGMII0UJ+O1lfsWxphoQxvkjn
 S1qnPHJuXUrB+kkAdyxW3iO/ZRs4TmPYRqkhbu+6FL7Dzzz99dl8AQEHLoxDacfgnpvB5T3wy+B
 E7ZYOLNX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On 8/6/2025 10:25 AM, Mukesh Ojha wrote:
> pas id is not used in qcom_mdt_load_no_init() and it should not
> be used as it is non-PAS specific function and has no relation
> to PAS specific mechanism.
...> @@ -353,7 +353,7 @@ static int __qcom_mdt_load(struct device *dev, const
struct firmware *fw,
>  	if (!mdt_header_valid(fw))
>  		return -EINVAL;
>  
> -	is_split = qcom_mdt_bins_are_split(fw, fw_name);
> +	is_split = qcom_mdt_bins_are_split(fw);

this should be in the 4/4 patch



Return-Path: <linux-kernel+bounces-759342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 668EDB1DC5F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2554A18A0501
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C93273818;
	Thu,  7 Aug 2025 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bz6yMIvr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046FA79CF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754587120; cv=none; b=EZy7poIgw9u5rGlOOlAlFXZ90CNacEuzsZ0lq4iHl4Qkn93mDJ0DAN+rkY04KY8j3UiecL1qgFNb7A1zw3/j5g1vpxuNRlu3nwPpKkd/uuL3FtN1/7FQ7jPPhBYSkQrdTf9rFkcw/3s1hfp+/NZ1dH1qAHOlyhUj3bz4SBeSDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754587120; c=relaxed/simple;
	bh=ix4wfzIRuANwVsXaP/80+i/iUtqcmQAOhg9cFDtjiV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XL9MVKfzIJ90X5RBFhB9TSQwl/ljVVQMW3arrpnUhCBKpkOM7DL7nk+dq2BvaN6JNeQR5mjhd72WKXbb5xN5SeTk44Yen50lFU1Csx8WN7+DtJfIplZUlxuC1sxaI3GC80p+RA061neGQmpZs3ljoInpg/jS4J/8cGzKM2aKhCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bz6yMIvr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5779DH5O008215
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 17:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nLC8GBJ52JS4DT8cnivnM/XJofTs0u4QYcTbqVdpwM0=; b=bz6yMIvrF9kz4XD5
	JXh1ZKRAyPHsw7ms/x/AUct7v/ZICwoDIGWBEoXLH+y3rHmxk0r2ynysiQgGvbK5
	M1NeeLuLYhvy6mhM3394k5ccr3MZ6tgu54fwlz1o+LVJbRoRdvMbRq4zz2hqrQXc
	Klmc41t1EACwREobXBIWgMsIqpIb2TI4id8u3aWiwszLy8ISiEzfp3e2gSL2xCN1
	SlryyDV+M26I+zlwStMSAxdGM4AG8wsFy8c9HS18M+Z4ZGYqD/xyoMy0z0TQ+j7o
	mhIRzysGp+bw0kpmFtT5fTjzrl5jsOVQvzLOOdXJIzeEYIkATxpAVsyK9rYrtHr2
	ij5G1w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy6y3fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 17:18:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31f322718faso995468a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 10:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754587116; x=1755191916;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLC8GBJ52JS4DT8cnivnM/XJofTs0u4QYcTbqVdpwM0=;
        b=XBr5WVH+OWYJ2UuP9+5T8hrLwnSl3HEsv4PG3MjOe2HbQpDIJxTDFUF73qwUbL4jrn
         5zeuQnvbaNY9d5riMfTFTowMt0Xa5opb1eeKLAlVogMJB4Up74UI0XJwjDONgGBsh+lO
         I5/KVXP5o9B+6pr52xJDGKOn3uoKjnh8rUIbAKY9zjyWGus2I5SNXywZqk/4FZdBSJh+
         ZdbhQsPNoal1/DU0uyHmnSmR8QP+cOHJqs4mnZQFeuaNyklaMg1IpZEM1p4a4wQqwsWq
         s27gEkONqQcqPL/32uq94zHnxCF2xH7ZPRe8oKS1GTKcLA9ROyvdDohhReFiAwn7rTOA
         Z4Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUEoEuiIe94OmWp0Od+T1CaJxasOoUe7JabkXlFTy/cFWrh4D8UJMCC+Qiqli/aDD8rHu2hX8UY6hOTBQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh6eJc7SoEaVcWrl5EWIuqV1hNHdxbbqpGjNmozQP8W6r9SYes
	7hIgomAiN08z4IvRWNzkMUDdjaMg9KR5KD7IHaQ98H1WcINp7vbuuiJZpVOeLmGQyhUk38tTD2T
	zj3vBVCSlptLg2KEfxdPoW8/hPHM1xQ7JAwJgVwpa8asNYqNvFrZ02NOSKBNbJTSE/4c=
X-Gm-Gg: ASbGncv53C0vcuGWMOxyw+9xvQCKMTFhTuGS9a0X2hRWLg3d2f/WjWn7oQyelL0XMSc
	55PZGtzDDEp3G+E6thnd3ZhKfh2Wk29JGlIGstBSGoclLOH5XkPksLngXdz6gocEYVtXlgc2Uez
	ZEsWXoSkUZsMxeN/t6oi3d/yBvithIuuwF+RhW4NQstaz1jGJb7E/d4ocDq7A1Qz6xHtgkqj96y
	maXTmSp7ka1ZMht4EIEc0WioBbDhtFyv2UZfDUJ/3S5ZARQL4CCGicB2mh/yvhN0ym92DtdtEs3
	1PsYMb/WNG5VKSNrhWkiJ8OyHtuqpcQPW05sgD1iS3+o5FeHjh5XajDbt9z0OGQIcuYIatAf9X9
	Wi875SkWdD+MapPztfeA=
X-Received: by 2002:a17:90b:3806:b0:311:d05c:936 with SMTP id 98e67ed59e1d1-32166ca78dbmr12228083a91.17.1754587116448;
        Thu, 07 Aug 2025 10:18:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDSBIxZMtyLHjJ8ZZPSYmQQchctU93wo3YtjIAb6ci0mllkfGZXT4TLleL1LzuppQ6KSZiwg==
X-Received: by 2002:a17:90b:3806:b0:311:d05c:936 with SMTP id 98e67ed59e1d1-32166ca78dbmr12228044a91.17.1754587116004;
        Thu, 07 Aug 2025 10:18:36 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3216129c8cfsm6088656a91.34.2025.08.07.10.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 10:18:35 -0700 (PDT)
Message-ID: <9b1f4ea5-2948-4807-a4d2-0efe7b672a4d@oss.qualcomm.com>
Date: Thu, 7 Aug 2025 10:18:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 3/3] soc: qcom: mdt_loader: Remove unused parameter
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20250807074311.2381713-1-mukesh.ojha@oss.qualcomm.com>
 <20250807074311.2381713-3-mukesh.ojha@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250807074311.2381713-3-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: j2jFB3XSkaDCBCdbVePMlWL9fmp1RcI-
X-Proofpoint-GUID: j2jFB3XSkaDCBCdbVePMlWL9fmp1RcI-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX1VHz4cTxfTvI
 jRfUQkOFPmgOH0emPAjKjycnR3n4SJ4VIOdYaJiRTam5++wSPyUz11HQdtYlg/ET20AgI9hbuj5
 kI98u3/Dh1LugF7LJegkpazi3NrpDt0FeWfMuO6MK/8oqSz2BbKpHGYUH3lX84axXDcZodpThjj
 54JzsyY6PCD5Z85AmfjcsDQrtrdOXf5a9M33k2mRqHfgYn5UrummHLS1wNwBZjjQ/97kiLDCgGx
 h4e7+G5c3T5t6K4YtZv9+6LuqGRWT5EyJGxwHjdv/JjRW+W9Cmb+mJrZD5RZ9qO0QK3csTE08wY
 0sALxq1Hm3piLgSR9AOa2xp5s6moMm2+ygtH2YLEhB2LTY9ARTVux3LA0NkOAXpb9OZngb7Y8sx
 EwJRvvWt
X-Authority-Analysis: v=2.4 cv=LNVmQIW9 c=1 sm=1 tr=0 ts=6894dfed cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=NyTICe1PHtTOfF-B13wA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060009

On 8/7/2025 12:43 AM, Mukesh Ojha wrote:
> fw_name in qcom_mdt_bins_are_split() seems unused now, it may have
> used in the past for logging it but due to code refactor this parameter
> is unused now.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Reviewed-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>



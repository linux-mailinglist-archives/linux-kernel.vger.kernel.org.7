Return-Path: <linux-kernel+bounces-764563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADA1B2248B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBD81A2505F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3BC2EBBB0;
	Tue, 12 Aug 2025 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CEzzw8J5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC0F1A9F84
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754994340; cv=none; b=Vtmub+506R3GHVopYs5+lomRzkarZcaLkAU2AwZIwenpKFfaq6IryZE3TJvE0MZjmt+9nOvs8sRf/sRfGB8vVasJcIwNQO7C7ZLaCc4cz/r6zGziDJRY7EOiQlCPBeP5nrNpJ1q7CQ7fV6MVxmDb9qjSvV74VFCB41MeCCvspbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754994340; c=relaxed/simple;
	bh=kPPuaswxwsoGjiS70z4R/GpzZWbmk4tdm1gnkzx6Rx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KH9NJhHjXw0SNP1OkzmFw+ou26oUNOoA45xjC6pah7VhP7EQh4xE/Oa0SnflA7nZBpGrkSQczW+UfMHrE/usH2e+Q7lo/uNZMu/sR7WJLAj3bK5YPl8KytKrQinCYZ69o4p6KF3H1J30r20RJFcMPNVbHsRJ92m3OH3DCOJN54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CEzzw8J5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C96pxD028942
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fl1ygk+1H/NMb3Ro5wivLL15aqHhmZrUJSFbMCh9wRA=; b=CEzzw8J5Btb/DoJM
	414rDABSw/6tYWkIacZ8TQu16IuxooWv1bte9EU4PR8aOemnj6zQYetuMZ5cCaDL
	k/hP1Epet7XDBJcTJE2Me2Q39GRSm7mgiVC5P0zcLJphI8oVshQ2jfW1S4yfOLuO
	FCTozQfT/vdDPBN1hfQR7gwaT+nWZx9k4Zzs5MMZDgdu9dgzz/E1iIb4C5SPO0rA
	riYCber+KvcVqR77U4sL60aTrz/45t9ECIfQYLw7GfErh2Bc/Y3U+aWr9ysCEgtG
	mwpIACE96JFgjqa0mslvRjWZ76aVHHiQng/WpFHfBEGVGNY5A/42Wy7e0m+QZMMd
	08Qgmw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9sqwwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:25:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-242fe34add1so7158885ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754994336; x=1755599136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fl1ygk+1H/NMb3Ro5wivLL15aqHhmZrUJSFbMCh9wRA=;
        b=kEpNf0Z3SCGSCKNH6NrWEUyjkc+bpeTBWkSfD3OTiooe//CkuQO1LzgfIbX57Cq8KI
         lvcgzSTH6Dlx7XY8ykrMG+XjZsmn+ekoA8BZ3CZfHkp/6UlhkHXBx8uwK1S6CIGnNT/S
         6YZoVJcMrI2wgtONTN0DaVaZUpWYoBY+ollt15ZKyR0pGuJIdC6FEf0Pk7TV0WMfQdYy
         NgZXVQLlxy+4L/d5dy2+waO7RB+eb+vzHVvFplKrZsqpsYZnRrd3oSZJPHFg4lOsmvu+
         mE6D2R/NcrlyQZ467hkKXDnS5T8Ms/W521GFUz9K74Hz8yf/Ddwlxn9MqZL4FCfa00v7
         cMNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWERfVfH1q7Cf19m694r2bpZk2214zeVLl5jv1GgiGOD3GjcJn4E+haFcIRz2Vn2HXpizTJC6+KdxpVQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUXKUk5hJRW294OqGN3ougcD9CejOOhMSuz+1/VJ+QQrMQpu+s
	oQfU6/dktZpF+/V12N86PSNG3dAJOcQC2EfKNoX9Ry6yIaE8HWd6NNaS9m4tSn32qTN+6zukSRn
	zMwXo4u8HQMcY5+yI3mKyD7fbnNSZk+4/4R5b3bybnGqGvKWsXL/+mFqPNHEeKPND7uc=
X-Gm-Gg: ASbGncv7INnQRVMgXx8n4tp0juJxs4GeBjjGWvei4I0Xb0rv97f5Ekm4z04M0vup0+i
	bPg6JCvJiEaFzAXDd2c4/zYQhkdyu9OUHA/s7CK6cVk4/g05aEILkd8r+G4nmH+ZwqvsJWaa0VU
	z+xTfzrnv6IiDElEogJaM5r/RFsAYYqaUYosQqe9xAB+2jJuyKQRlLJAma2HxXOQiPQXTNyKV5x
	KSkB3hqXLPotDD5RG4oZS8IBUmJ64QH7kBHMI5vJ6mQp3X9KjezKSpTMRd85VsPWT8ecjJffMPv
	0Sbg6TpRayYHGC4yBMNSYgD2scW5FWlKaW6RTPJd19Q9Me2UTNEe0uFPscXYGczzAUny3aEv
X-Received: by 2002:a17:903:2d0:b0:240:8f4:b36e with SMTP id d9443c01a7336-242fc31a558mr50178825ad.34.1754994336503;
        Tue, 12 Aug 2025 03:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhW84RupltOd7oYpjSDnmy/Z1WFZCo3v4UmpgKw/WVJ1C3vhkkf5vDczM3TxczTksqAgL8EQ==
X-Received: by 2002:a17:903:2d0:b0:240:8f4:b36e with SMTP id d9443c01a7336-242fc31a558mr50178275ad.34.1754994336053;
        Tue, 12 Aug 2025 03:25:36 -0700 (PDT)
Received: from [10.217.216.215] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-242ffd9e3besm13858015ad.106.2025.08.12.03.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 03:25:35 -0700 (PDT)
Message-ID: <c783b319-3b88-45b0-8a0c-8c3ba9c462af@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 15:55:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] interconnect: qcom: sa8775p: enable QoS configuration
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
 <20250808140300.14784-3-odelu.kukatla@oss.qualcomm.com>
 <sdp4moiiii5zjz7m7ysds3je4h66biuusilc4fx4bq2j4dw7ur@5d3c6gkk6wb7>
Content-Language: en-US
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
In-Reply-To: <sdp4moiiii5zjz7m7ysds3je4h66biuusilc4fx4bq2j4dw7ur@5d3c6gkk6wb7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689b16a1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=wifMmZQcaQcT46JyXskA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: UtZMPs1UU5FGRCtl9ndYrW8m3CaNpLFS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX1uXRp62XfMgW
 1tcwM4q4AK/WjpgZL92exvn1RLwUk8WaHbORUWRK0oCcxE0dSGFPqeJEvFWxGtlUnqEDoZWhaGt
 wNTEkm3FcZtXcq8aeXh/7XgDKJJxX6c3VBZmYHqQIAZt0bbb4vCsJSgZCbD68cWU+dmnrgnFro0
 ktsbjS2PwLIrr3S6jFELYoAAORAubE1/b2f5oxnfDgb72iE1LmjFLI/8fSw/bLmV6bwe7f4OKSP
 xWbAZVh9lC775GkZH4z4sK+BbL+8sqTAMTvPogsgwTnTUPzRmJMkGoWcpDhwlUwf+sLE8Vdz7g5
 xR/02U/p3mIk7zChzSUOULhZjVH8/KZ2mCf2SvPrIF/swRWGHMiO+DDGYVR1DudN0JtfWAaYvGA
 lYmiv8N3
X-Proofpoint-GUID: UtZMPs1UU5FGRCtl9ndYrW8m3CaNpLFS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015



On 8/9/2025 1:05 PM, Dmitry Baryshkov wrote:
> On Fri, Aug 08, 2025 at 07:32:59PM +0530, Odelu Kukatla wrote:
>> Enable QoS configuration for master ports with predefined
>> priority and urgency forwarding.
>>
>> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
>> ---
>>  drivers/interconnect/qcom/sa8775p.c | 439 ++++++++++++++++++++++++++++
>>  1 file changed, 439 insertions(+)
>>
>> diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
>> index 04b4abbf4487..5bf27dbe818d 100644
>> --- a/drivers/interconnect/qcom/sa8775p.c
>> +++ b/drivers/interconnect/qcom/sa8775p.c
>> @@ -213,6 +213,13 @@ static struct qcom_icc_node qxm_qup3 = {
>>  	.name = "qxm_qup3",
>>  	.channels = 1,
>>  	.buswidth = 8,
>> +	.qosbox = &(const struct qcom_icc_qosbox) {
> 
> Please follow the design on milos / sar2130p / sm8650 and add a separate
> struct instance outside of qcom_icc_node.
> 
> LGTM otherwise
> 
Thanks Dmitry for the review!

We discussed this during patch https://patchwork.kernel.org/project/linux-pm/patch/20240306073016.2163-3-quic_okukatla@quicinc.com/#25749420, 
it was decided to follow embedded structure notation for QoS as per comment for sc7280.>> +		.num_ports = 1,
>> +		.port_offsets = { 0x11000 },
>> +		.prio_fwd_disable = 1,
>> +		.prio = 2,
>> +		.urg_fwd = 0,
>> +	},
>>  	.num_links = 1,
>>  	.link_nodes = (struct qcom_icc_node *[]) { &qns_a1noc_snoc },
>>  };
> 



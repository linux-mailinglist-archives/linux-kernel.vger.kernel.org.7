Return-Path: <linux-kernel+bounces-733838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071E3B079A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B2BA4441B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5CF2F6FA0;
	Wed, 16 Jul 2025 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mTl83bTp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92562F5C43
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679288; cv=none; b=icYW18Z0Oxn0eKKc5aiw0uNtuuOOx11vEJEbDEGEUClqUnSS9h+OiTxPvOWwPjcaCfc0cLExrMTiO05np76F25lyOxJHOyjigNca5eI7UcqdSf35TOlB4n8BuQXCmKRBWbHccHd5Z5tgT3avuabdm5/w7d2pkaaFTijo/Akqyz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679288; c=relaxed/simple;
	bh=fqG7B+T81R/Frg225wIMjY4KZA4GxqPDhh4R3ITn1qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VBnPXuXrXIs2zkPK7hh1l3EBv8xEwWI9IYcOsqWKlWGBUTxVGdxHWClOlzwnlOtynCWp/Dc77cIzGf6MUzUVFYyrPA7TWtT5XQCX9l4AOuAZAge6zMLC3P3goGQCxxJOS0BJky8bm8Y9IP1KQnicRKcp+KGKlB/fXpFveD+JO0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mTl83bTp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GE3iIj017997
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1bUnE3yh/20Ghd5aYHGrfLlbtIsqPiIKnsI6KRLyQjk=; b=mTl83bTptn7jOjj1
	YljHgzUQtkN3PYRa63msvRQktH3WO7HRs58VbyD+6CIPoFQShma+bof1Srfau1vh
	E8cTHyOcBLeOymJiZz9781O3UEo2D7Ffeo7xvJZuSWS5mztZ3XqPJn6kcxOWpEav
	ckPuTztKdhdPgmHhQhifhYsonxfr77owcXbMSJ3IYB6jtehRI1scdz3qf6DZY7Lp
	vECtjuj4n8irBB2TyadW0RaAIJ+XK1RsIh9FS0Q6RcMe/WTjIyoWVmBpE9mVIQxk
	s+eH7uDtwFIKzDKbF03szmSAMB2TG2UupsOLtPlLg/fAw4LGufiTwsxb1w6gzdRf
	efS8DQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug384kmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:21:25 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7df5870c8b1so77827085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679285; x=1753284085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1bUnE3yh/20Ghd5aYHGrfLlbtIsqPiIKnsI6KRLyQjk=;
        b=iNzvBfrP9R7mOmw1GyhLeZsteu1m7PrsExYj0VH9kl2fBI3z4NM1Yl/B0kVSlEj9FJ
         UPsJymJu/ERZmoaEgH+8ZERjrpPhuSC6k/A9DokUQdXZFUK7oD2qrRnorrMSNPxiZo8a
         +LxDSAvC+6kMhIt2ilIJWLuAoMZ1HpEuC+ygOh78kwYSnc112M/xFbK68a+Qf4r19fBD
         5A0mhFo7rt2ghH6BGyghkqIMSfeglycwNyUzJhbPResSmXHqq+1oW15fX8akt+jS9xL3
         n8Rlg8TzSh4YsFfmSfBIQTxwWayCrpyf2fQpyvC+qPH+7alQAuOIqmCE4G+Nyc8Etym/
         K61Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwkklKsoclFN0udCcXsCCCJrcE1RLwcsG3gKJtkHaU+EgKGyLskdtzgtnF2hb7Pn+e4mYsXTCPjwm9RWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGQN0ysybBPLPvzJrbnlmcsm2+PT+dmNkthePFRfHxECQ+fOxH
	grajhzWB/lz+06Ka7LnCHmzH22Vi6pRkZT7uD6tSsb7L/jV2hrm7BPTKLe7g7P7CYkUJl9dclLB
	rqzdl7Vh8+2AXkAEQ6V6nOldMUtmwdKWirOp2WyObqqgFkKRUW1037INzu/V0t14Y0sM=
X-Gm-Gg: ASbGncv5I+zARRCF2Cwk7sZwoM/PuG/JUeETx9+awnNfTIXfyPHoLjMBEAR/jMoWIBz
	W20z4pkhG6iAWAhi06D0legzGKtFqYn480zpYmVqyx5Id1LANL7wAAvyRgffgYp6u7khNAo4X+n
	Jv97D918jTx+kvB0CxGRyj0giVTmA/uFYD9cDXhDhPBiG8f/nQHNvCqotN/hQz6LpcEBAe0cStT
	HGik3H10LbxhdJUeImtmkS6OUVJrR2RSyMYSt0TzDOepSzZ9IcZn9QvAvyU50op0fMjj370jrDE
	3jYjOvjcoKW0fNFVXKtLirK3Kz5co01DmoC9Rd0OhIA9IITx1VAySe2oTopoB703ol4niV7sEjz
	gRM3p71KWPY4wBo9FVO5J
X-Received: by 2002:a05:620a:1a27:b0:7df:d668:22ff with SMTP id af79cd13be357-7e342ab1936mr216253985a.4.1752679284880;
        Wed, 16 Jul 2025 08:21:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwUL4aOiOFKQWY6fr2mKEYH24z1mhZ4m8g2O2+qGwqBgjEmZmm+7igGSQAEYX3auu8FEpU1w==
X-Received: by 2002:a05:620a:1a27:b0:7df:d668:22ff with SMTP id af79cd13be357-7e342ab1936mr216250485a.4.1752679284383;
        Wed, 16 Jul 2025 08:21:24 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8291bbesm1194624366b.126.2025.07.16.08.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:21:23 -0700 (PDT)
Message-ID: <9075ba23-cf47-411a-a6a2-96f89114b14f@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 17:21:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/5] misc: fastrpc: Remove kernel-side domain checks
 from capability ioctl
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Ling Xu <quic_lxu5@quicinc.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        quic_kuiw@quicinc.com, ekansh.gupta@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250716132836.1008119-1-quic_lxu5@quicinc.com>
 <20250716132836.1008119-4-quic_lxu5@quicinc.com>
 <aepmtv6mxlzhpncwcwlmgfrb3m2c4xe2edl4y5qsnjpxmvivla@gwufrh37y473>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aepmtv6mxlzhpncwcwlmgfrb3m2c4xe2edl4y5qsnjpxmvivla@gwufrh37y473>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOCBTYWx0ZWRfX5X7bUeuHxV3Q
 VHL+k2+9KgAXNVh8Uh/T90AnP0zbBb6pMwK58pckgmcA3HbaTQ/N7q+CXrzUSNs3UmsPhEUttzb
 LWEHEDNwaMZjLdcSsyYyfHIusKf9PhealsvMADWh2SPkZVVkEEyTttSrY+VaFhVOY46BC6ULhdV
 s6xVNBcriXP8PgI2UDDiqda2xmsSHk2tQeWN0KG22ySxig6nZSLes4vdJMtd3RGOxrFfia1dN0X
 bQHFjbDynebl+JcvfTuxjfP/SRHwT+Ie+XYNq8C/YJoLw8n8b8PFd1lWFIJpwnEQsDiKGExN1Ud
 eWj25z9vus1KIh54stl/RXHUlDAC5DOoXVpndY4OqFIDUtk0YXbhWzDnHv7CwjOsRT8YCH2egL1
 4xMxvb2VCEzI5nnQ7XpnG6lUEpALywk2z7RkSoTwvMBRTdWYeEdlpzI7vm9pVZHPbpfR3Rck
X-Proofpoint-GUID: z2qyUxXT0s1eUQ18foRe5ZnwBfMc90U-
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=6877c375 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=d1jN1tAPt5WcxSkl4i4A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: z2qyUxXT0s1eUQ18foRe5ZnwBfMc90U-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=768 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160138

On 7/16/25 5:00 PM, Dmitry Baryshkov wrote:
> On Wed, Jul 16, 2025 at 06:58:34PM +0530, Ling Xu wrote:
>> Domain ID in the uAPI is misleading. Remove checks and log messages
>> related to 'domain' field in capability structure. Update UAPI to
>> mark the field as unused.
>>
>> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
>> ---
>>  drivers/misc/fastrpc.c      | 14 +-------------
>>  include/uapi/misc/fastrpc.h |  2 +-
>>  2 files changed, 2 insertions(+), 14 deletions(-)
>>
> 

Dmitry, your message is missing

Konrad


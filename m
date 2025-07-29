Return-Path: <linux-kernel+bounces-749307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0A8B14CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B84717FE40
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CE228B417;
	Tue, 29 Jul 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aEqizHj2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CE01E5710
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753786924; cv=none; b=hy1W5lfng+NPRYhF2OPTPKNqnhWFiQ+UnXt/1JIJvcQKK/HPrS9xJdTuWMSdtBMOGV73DmxtIL3lGhcrCz3JEL+FtdPbshNvii2rTcpON7hsIDKSr4d4lB1mmAMk6RdBghI6mBmyktoFGuXOIyt4MQslH9sfk7Ia26CppVmCdak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753786924; c=relaxed/simple;
	bh=XVix4h4ceY2Xwr/lN/uQqxvS53ppNxZxv1InKMiykeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ke6NYgFnfrwfxFZ9D6rN2chMr0iwJCFISJe6ng4VSV/KURJ+Cc5QgyJJ+Sfy7HIQ7+SYPXnXmKdR3MiB3+49PWaSP3dFZZGo6ERQLZsyeFTwznHv+v94oCbtH1JbizLGikW2dUWUxGWE4+R8Z6aCYQ0r4NI2J9CTD1LJqqc1euM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aEqizHj2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9qdDe019418
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lCgpTWb2pFj+aPasfvmfGcuvsh4RyX1FU0VMwXXWjSA=; b=aEqizHj2IQjTNntJ
	SIngebJyEO9IYcQqxBdCSy4jxKhZ5gqJIomrezK1n6px4Y1fJIcN9okBUOCYpdFe
	Vt4dVpAKefzQMTwiX16WAfN/DpWArMrXSA0Trab7ul50Z6P584RWwfYvwTcXgHMA
	Hgh3DHglLBSYpCtqoc4ZI4sunVeNF45EeoETkNXOu9Rfw7UWT+xkTNjl+qDUrEGL
	MBr1UvYiUnnQzAcUAnb546wEt/sPArW2k3lbAARU0N/cxlFUb/61oqnjyKB6e5Fl
	Ju1qoZ7/CYM27UOTlS9w+715iQ0/yZsGVvyF66O80v9P/14X2lUeZGjZ6r4rwBZA
	2mYUaA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2frgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:02:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e34ba64a9fso26089285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 04:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753786921; x=1754391721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCgpTWb2pFj+aPasfvmfGcuvsh4RyX1FU0VMwXXWjSA=;
        b=o/5HRMFcUZpyVSNDgscPIF9Xu2tnTxmcRyqaJcffJidVtvQ3dUb6hP7+4QLimA/CL2
         Fyxoap/5zWeyjLVWLD3S3igjFSSdlomZXHLSllrA3CrfgYWSWlslEzSo9z2cjMb80eUn
         TWwnA3Wl6yuOXjEGZXjG3jOhuCtfYvVM0glZXsDw4+D52cEQIjBa4/bHQADi/v8+A5Bl
         uORoZsFM5BgTnvkCkHYCh8pqpGt/T3Nn+MMFmXGS5LHwcGX6YjUoD6Ur5IJhvpNflSsO
         h/kNoBaUVR7SnnyCVRRCrE4AwZJn3AI7T+NqrDP/1PLiEwkAwn/zNgHsUjrG/X/sI/W6
         SAdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBBKs7lo5O8p4fTVDSydL600kiDWE/Z2d29CpvreLjPFjdrTh3wIQ5c2MmnWg6IZTgrHBypqeurSFx5E4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7MPoKn15JkKCOudBr4CActNHYbn++estKF58xRaBzb63jILnu
	S80bcgzyMLf3QuDK7RZ4W0RKCkzbbDSXcm8HaH70YSjQgaD8YSUTHPkmetLyz1QeaLHDeGhVpEE
	/MjQghbKGXHAvTmoruEM0U1gzJP8DEUqz8OJDf81vyiXQxIIQpZ1bobF4TrYeIJZDevE=
X-Gm-Gg: ASbGnctZfcP4ec6NXvR5mZ89rYcD3Ly/7uvtxd5t8ce/7H2IeZiYkM0rrZwSKY3FyDe
	Z9TWAbup39rO2UWiSc0ZoRVCU1mQe9fybnfbLpHtrgBxFC1EBSYLk1jWu9mLNChxxHrYFOQAcud
	3s0c2xLmVj7LDZr3WhMdzibDxlR7yMXIjlEIW9F786mS8qYDQLbaYOgjshk1129rWnSXVwu91sO
	/jcXfPvFSWcijMLSgvUUW8R0rpU4u2+er9B2Il7uQOZNUfBJAD1jmIMMAYEJkUjByCb9lqreF32
	a89oOIEcDyfObc/SNb/gXkc++fiia6LKMy3X6UJQ8Hhus8n1xJBWrCOHVw4o6Mx2ZhL1CU1N0fW
	g7Q4Xf6iLVZ1Xa5U6FA==
X-Received: by 2002:a05:620a:1993:b0:7c0:b3cd:9be0 with SMTP id af79cd13be357-7e63bf8da83mr781135685a.10.1753786921102;
        Tue, 29 Jul 2025 04:02:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExAqarmEBR1zQRIy77n61jfsMAguEhYG+dqLER2OFrCjn6f1Hp6XAxZssc0TSMS9seDzZBYA==
X-Received: by 2002:a05:620a:1993:b0:7c0:b3cd:9be0 with SMTP id af79cd13be357-7e63bf8da83mr781131585a.10.1753786920392;
        Tue, 29 Jul 2025 04:02:00 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a6685fsm569901766b.89.2025.07.29.04.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 04:01:57 -0700 (PDT)
Message-ID: <8cdb5f5c-89ba-4215-8b27-1ef6761cc729@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 13:01:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] leds: flash: leds-qcom-flash: add a separate
 register map for PMI8998
To: fenglin.wu@oss.qualcomm.com, kernel@oss.qualcomm.com,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729-fix-torch-clamp-issue-v2-0-9b83816437a3@oss.qualcomm.com>
 <20250729-fix-torch-clamp-issue-v2-2-9b83816437a3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250729-fix-torch-clamp-issue-v2-2-9b83816437a3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ni1iRjc4fPyH6Gg_m1lirWiZPhacOTb5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA4NSBTYWx0ZWRfX6P6mu7bSqW/w
 7CBbyyAEpoSKE3W/zbE4azZ0rZlvnKs+FVMqsL7ggfqs0YCK5560SkKEsgibXdGfgoEyr/d8Nl8
 jXj62Hp8fmQN3TJBs5JGrYa0aoTF75UkuHGtG7C7OjONTXGSSqX6AwWqQjYfDuxL9fesxQs4n1I
 sl6OQQocZbHd/emJWbZLQ6s9qJnlHhVdOhzL3uc4llTqZ+MemqHdzAC6/oue1Ril+xUdm76/3SN
 cUG+CGjYW8V7ybkX+MsWYbNRUyMzfxJrChlHKBUustMD8OkDmjwTFKvVgvxWdYnK/1oA9zX4DPf
 xqiWjj/dGpf47DwB37954wWikZOznIJF+SFewi0IL57AXDPGnFhjEia1tl+lB694jb1Cz1+dN9n
 viuXehivpPTclCN5VrJ4hdEXBJheATHGpRqRyMErVgwoFzSddoiNntaYHcg6yz3JZDJjwl8/
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=6888aa29 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=_Y3n-bpnCnicWpd-f54A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: ni1iRjc4fPyH6Gg_m1lirWiZPhacOTb5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=664 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290085

On 7/29/25 6:51 AM, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> 
> The 3-channel flash module in PMI8998 has several registers different
> than the others, such as: torch_clamp. Add different register fields
> for it.
> 
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


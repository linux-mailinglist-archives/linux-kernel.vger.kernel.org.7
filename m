Return-Path: <linux-kernel+bounces-769421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 609BEB26E69
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A0760249E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA413101D2;
	Thu, 14 Aug 2025 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cvYMDrSp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE633101B1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755194113; cv=none; b=UE6F5pggueUzo5r2T0uWU4KV0CX7zbV96rnsh/9z8zpNUjY8mvy7h5UovGLR/pat8YK05FU8c2z7VNHNlM38sl9VPBmHtFkMd/02CiD2nYCVF/6+YQp1HMxQ6sCC2y2wKLN1x02a72kq/zkLnm/lQ7j7PRu4khKuoJ0RnzJ/TTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755194113; c=relaxed/simple;
	bh=ORCr42UJalAW1unb7vVLUdGNfgegDf8AmnRiPFr+gZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyyVK3QgYe2m/wjDfKI+48qFVdAcY16MKPXucOYCo2piTiKVfxRkNil8s55JyM4NenahgCg7l23qZDrPPZ5f+QZVHL8YVROgsJMGRCvtpjAxknG0MmfrAw/J5FyY1skGJk3c/t4uwuco1oRG9Ty7zc1XZapLYOpMIXfb4OedXCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cvYMDrSp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EHWU6c020683
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JZv3VRcqeZuhnmVMXAw6lrB7bSuJ+i+L/0SR4ZWbkJE=; b=cvYMDrSprDWLWbxp
	zaw5oMUMuGctihW/6VWy80KPDvx76RKWLbOaKudnoAZethxxV6FRe4H/3XnFqxVv
	nlNZ9uJnC9idUa02KXVNM4VLyK9RiFJVYaDIKBsKWH2mSl4MB1z791VetiZxrDh/
	n10Hl2sfMZJbbMNC2RKCqDKvbxYkIWJ7OkE/c0IpGeiE0eSWakvLIzTSojPXz8b5
	HUQXcBJzuGEuewQl3X1KD86aRqCDOr/04hckvzQcHRNnHFdzy367cXyXx3YL/3vL
	i7xdDIBFsyBjTU30jdvmwNcopub4ExOjdSONjgDd4+hp4sDIDS+lOFGWRXVtSe9A
	tyJ3Pw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmgpd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:55:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2445806b2beso26638315ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755194109; x=1755798909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZv3VRcqeZuhnmVMXAw6lrB7bSuJ+i+L/0SR4ZWbkJE=;
        b=hfsHS2bqvniwmgX+oYOJmqy+lHCABK8stWJnj6rddGCdR+03Av9L0KtXLVv/u1tgBM
         rNQJdn1RgidSSc6FzDtTFKE3L6aujhXnuG3irK9//A14Z+KkB8WmpOj1P6IKM3F8fAbV
         jWcQgB3Mm4m7am7AYoPpwdOETrRwoZojbS3MqI3oESu+f5L9pOCl28HE0reU+XOS9TzN
         vbk2j02Tg+vHpqr0sSbU4m52cMD4cL6+SHq/UHz9pX4aBuFlYcp3ozEL4FnvAKu8Ph6Q
         HyLJkRNozHayPliKLtFH4dNVgyQqHBZl27c0FAnGqWDgJvaAgTOHMQe8neoHj6vH0lro
         6PaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0ndjyOI8JRk2J9PrrL5LYwTTILBSLcq33jWRatzKv3TzM1V6TYSaST3oqLKZpuZkGSdwPbLrP+WkmAmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9zM7CS9HmNwoBaKtfsuGPRHB2n/jcoTHAE3CplRortHXGyPhF
	b5PcGoCpcKcnpQ+5DqHFbJwu3k3seF9hbix9NIfzA2jiBNAuIcfP4wk5OYGtyKtvleJR9A9Fd9M
	qIk+fQUVi+F3cAbY4yKGjp9vU7/3TOYgCd9UqyTItANlpHVAx5JQpr2XE+4JVdNsPc5g=
X-Gm-Gg: ASbGncucekvHgKBNBUc6BbAEYNgHd5+8mVy0VUEhjxBRpkHnol83s45jCr7A9ER7Qqe
	T+bd0l9Kdq0Jk0gglMO4JrYFGlDv7ze4yI0T97Wn0AwtS4+W195Dhz5dUbBZw/V3SqXZbf4ra1b
	SP7eSYa+eE6hwZ7Q4gfPMb/y5z9toX9RAGOStO7xGZWKd1bhOcgBb2MbdNmvY7JGs1eKi05dobj
	3ggY8UTKiB0ROrTcWkei+3t5k+lmTHboxApD063T6zAq9SPxqmxZVzvS9Xhoat7/DfQqCaszgwb
	osejq1hs8cax047rc0Bitm8bacLux7K2W1I3dyeSH/gTpj2FF2WaiITE411e75Pquh3p
X-Received: by 2002:a17:902:e78e:b0:242:460e:4ab8 with SMTP id d9443c01a7336-244586dbc4dmr58394015ad.46.1755194109356;
        Thu, 14 Aug 2025 10:55:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7GjEYwKJ4eUG2s8iqD1mFqhdTADJ5UyumLsiIQwOIDf3LkbwscHxfBfaO3NFffYdyQqpu4g==
X-Received: by 2002:a17:902:e78e:b0:242:460e:4ab8 with SMTP id d9443c01a7336-244586dbc4dmr58393645ad.46.1755194108881;
        Thu, 14 Aug 2025 10:55:08 -0700 (PDT)
Received: from [192.168.0.195] ([49.204.31.133])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac0391sm29539707a12.37.2025.08.14.10.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 10:55:08 -0700 (PDT)
Message-ID: <9994318f-4c66-4400-a588-721e7832bcb1@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 23:25:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] dt-bindings: clock: qcom: Document the Glymur SoC
 TCSR Clock Controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250813-glymur-clock-controller-v4-v4-0-a408b390b22c@oss.qualcomm.com>
 <20250813-glymur-clock-controller-v4-v4-2-a408b390b22c@oss.qualcomm.com>
 <20250814-warping-hawk-of-brotherhood-0a34be@kuoka>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20250814-warping-hawk-of-brotherhood-0a34be@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX0vSkVFBNggg2
 z3G7qDDcbYogYlIl7RAzbMhXGX5rA+WxzdNONtqX9dOr8MgyohSaZJGWL1Dq4S+JlkLfSzMX89m
 ScAIzNkr/72znEjgCFgTCbnzJlOZBwsLr22+gOHcQpEVWG6oNSBbaStbaW9evuYmyCA+7QyAuOK
 vPKelhvwAN5yPMTogeQfFLOcbnkoV+lYWmOSLUz4gamYfl5oZVf6wifGu5r5wocfJISKW9+4zTk
 MfgPciBr+PTHBE9ICZKAbZevjW4U65TNVIwZl0PS/q9WJY+42vEl+9BJWS8ddWwtPGwv5oqwoGQ
 JfE1yk35XN5V1db5LG5kxAj7/t9iTUnwlJeKLMb+vEdXeE17wrCvdcVlaanyKOJSTSdaeJdb5AH
 2FkGU8jD
X-Proofpoint-GUID: e5NknCZqgEK-4e_mANUADptcy4anhxYS
X-Proofpoint-ORIG-GUID: e5NknCZqgEK-4e_mANUADptcy4anhxYS
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689e22fe cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=/kiP2gCwObMqexHosDfpNA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=P-IC7800AAAA:8 a=rVg30yMsodvzwDQ_i0MA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119



On 8/14/2025 1:37 PM, Krzysztof Kozlowski wrote:
> On Wed, Aug 13, 2025 at 01:25:18PM +0530, Taniya Das wrote:
>> The Glymur SoC TCSR block provides CLKREF clocks for EDP, PCIe, and USB. Add
>> this to the TCSR clock controller binding together with identifiers for
>> the clocks.
> 
> If there is going to be resend:
> 
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597


Sure will fix Krzysztof in the next patchset.

-- 
Thanks,
Taniya Das



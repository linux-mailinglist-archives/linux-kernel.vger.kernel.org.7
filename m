Return-Path: <linux-kernel+bounces-751929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF347B16F75
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1178B1AA634F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9FA2BE055;
	Thu, 31 Jul 2025 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UzxX0n9V"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C91230BE5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957563; cv=none; b=WWs6IRaBCd1Zfe1TcTnyL0IZmDeKnmy5hP3wxg8QiCny4Nps17fjfY2OcwMjlK7MZNIkzLlpj+B4+lUvYaTozEqcwSyD/ivqAN4oBBNMzP0qAq+okPYhSTaZw6s6RLNLGnVSGj27dhkOHGn8bWfd1u56X2hiIqUH7Kta7gD+KeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957563; c=relaxed/simple;
	bh=pOesqc3nlck8rVFgKqK9ggTjpcYdy+Gbb1ulQcN/kpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gjdBxi7spuS/kPF/dwAircKH1ElX+csj9Oo/gk/DVXs2cspFF9uaiFD4Z7YQOhfNiGR0HTxou1sP+sYLtVv7Lq+Pki77M4yeAWCbwnY2DvsEtuix7SknIvOFEN09/Zv98J2KHHCIorKav6iS77eQkpVnpQuPVWlJmWBcU5lGZ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UzxX0n9V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V9fNgB013415
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n81MtA2X1Y1YyhrlPlq4hNnzgx9bpd8NuR1dYQdg2w4=; b=UzxX0n9VpMqAv/sn
	DpQk+9hh32Id5CMtjQHZVMIj8CloLbAB5X9GBYOdZ7dqXcgnxx/aig/HglLZDdli
	WBWJ3XhxTcwjLHSA5hbTbu1f8ugrdVe7zHufvUPyIc3+kdh2QDEJvdP9C1newZ0u
	+UZO1FlWPSL6nv3kLFkCfe47JpBQQnyQ3ieolsAf8KdJ+ZtLTvbcZuXBhB5SKyW1
	5C8colKztf58qZHq9Y/wsWf0be+JXGKkRmsx5P6nhKG2PIAckx144noYkkUwZjzK
	BpNLEf382+fudtZuWyaPSEqghckUJebm27d8mJhgc8XrD8E4bfgBqJ0sBh3sL6nC
	Z/YIcA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2q7m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:25:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b350d850677so205114a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957555; x=1754562355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n81MtA2X1Y1YyhrlPlq4hNnzgx9bpd8NuR1dYQdg2w4=;
        b=Pik32Hrq4KBO9IRfFI8PDagLOX+Pv8qo1Vzt1tQgkPhvAogOeG3CY6KfijheTgmNWO
         +PYaFi8FyGXoZrc6Y0RzAa2NoiVTi3dTMgMy+6MfYKZjh5nnK69gZW2P8BoInNZSxWlt
         sBVnAk4QtAzLDFcqSUdkDNW27duMvWlKNRq26Ng+U5JgwjAoulTGKAENKlhuHjgZFWa3
         NZe0+HEMmauJVXG+jBfpYBLS3KsqS3Tz2whFCTSEo4IsGdIYIYghLDwH+dlMeSp4MxjQ
         GNB6ChJgIVow+TbI+AR6ydtRV5GRL/dmGw1zDqBhkXWpSqVPEgCVrdO2uBC3PKpuTveO
         Yjow==
X-Forwarded-Encrypted: i=1; AJvYcCViu3gPol/5l31vgC+tHHW1CTD4BroPVX6wl2rcBDf5gOCZi2cSf9XXuPmG8BxK5ROS2m+Q9wdP4UenCEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsEODr3i8v7E/DCDO0qXB6exBAlFyza0lgznQYVmqxSlVr9/Hm
	ZO5s9KiIa+Elq0Ck5Cwck5DkOXjn1wta2KI4WZdbw7AyaOr/M2rd2Hk7C8v8jaAefgchrDCj+z0
	AgEHsuOG3KAHBkKbCM4gO+Du6Ys/wgFwctgGHQApFyaI0Fa6+kxEWdNN1XnkjiauO8+o=
X-Gm-Gg: ASbGnctLnUgKVioYbpHIO3CGOvt3UKSi5VEF9VGSGdC3SNdnLWiOCHd2eRgP2TF1P0r
	0poifkv28GdNz/dKRwzFJdcJ65JZKE4BaZneArL13c2YonAp8N5OR1rFMMCy25mpSMCBcFWx7Jk
	iQP9/GvbK5HfARBqUHS1L0lOy/QBqIpA2GEHziYIv974ZFO3Rnd6TBEb4V54ZsdI/9Ts34diskV
	DAjeukk+dQb+CTlP4NowkAO+/YfJXTY93ggUCfxp+wr6lh+gHk4oXvi6ZH+QHvtTgPHprKwF7ne
	Edt+/uJYmaQSHqIGVj0mKAbVi7Z7zzTtZ15W+8/QDz+wcoB0YAIbQDBBLRv7rjIy5fM=
X-Received: by 2002:a17:902:d50a:b0:234:8a4a:adad with SMTP id d9443c01a7336-24096b17831mr94319345ad.26.1753957555581;
        Thu, 31 Jul 2025 03:25:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEM5m9qng+CoWEOBFNqS5T93w6/fczPEEuuvGdp/UVzwiAltE668w8GzzZdGOMC3LU4BzfyQ==
X-Received: by 2002:a17:902:d50a:b0:234:8a4a:adad with SMTP id d9443c01a7336-24096b17831mr94319105ad.26.1753957555017;
        Thu, 31 Jul 2025 03:25:55 -0700 (PDT)
Received: from [10.217.216.26] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a917sm14198885ad.116.2025.07.31.03.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 03:25:54 -0700 (PDT)
Message-ID: <e490ce65-4f09-418d-83f5-fa0755b36aec@oss.qualcomm.com>
Date: Thu, 31 Jul 2025 15:55:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Add support for Clock controllers for Glymur
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: kernel@oss.qualcomm.com, Pankaj Patil <quic_pankpati@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com>
 <20250730-axiomatic-colorful-gharial-1e6060@kuoka>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20250730-axiomatic-colorful-gharial-1e6060@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jsJTdztO9ky5F7_wC1kKNsiGnAf7OZTX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA3MCBTYWx0ZWRfX0uC8+fxJ9HmH
 L/Kwl197wDIKWHaUiPKEsUVDFHPX+tBWXFVBWVLWcM6u/Oz1vwAsVcnmb6KI0lyuiv0a75eaQfq
 /wG02KUfpk7QX4QlIq8FAdVWVzX3O1QmiqKSeiWXMBq86iQTPVqjwc41TYZMyrfwR5TlUuCB3GQ
 EQipDeLc2s0WNvOVy7yLsYRXEukhl5kUQH8BrjEu0V5CO37oMs1rncnSv0HtfNUQbYW6QGFZPae
 /SD3OQ8pEzeZTyxzsqtq3H49aij5XkUUaWFViKtodJsA9TEp+uYOgvQ43Qw1ASQWNR2j+lTa7XB
 bzlhsWB2cTDTI21vT8Ph3o6pPfGM2hsYs3ul9E3eKqZSVSF86IULwr015KFN+LvcQuCB/IRTBJL
 0YFvWV0cGy94/SRhYXwyVqwcTVxVnR77Ek/7jXVBEuG7nZLFJ8Y72z9VcjqxCmtVXVd0Tg2u
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=688b44b4 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=1-OmqgVFb38NX0Eqym4A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: jsJTdztO9ky5F7_wC1kKNsiGnAf7OZTX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507310070



On 7/30/2025 12:45 PM, Krzysztof Kozlowski wrote:
> On Tue, Jul 29, 2025 at 11:12:34AM +0530, Taniya Das wrote:
>> Add support for Global clock controller(GCC), TCSR and the RPMH clock
>> controller for the Qualcomm Glymur SoC.
>>
>> Changes in v3:
>> - Update the commit message for all the dt-bindings [Krzysztof]
>> - Update the commit message as required.
>> - Link to v2: https://lore.kernel.org/r/20250723-glymur-gcc-tcsrcc-rpmhcc-v2-0-7ea02c120c77@oss.qualcomm.com
>>
https://lore.kernel.org/lkml/20250724-glymur_clock_controllers-v2-0-ab95c07002b4@oss.qualcomm.com/

>> Changes in v2:
>> - Drop second/last, redundant "bindings" in TCSR and also align the
>>   filename [Krzysztof]
>> - Update the year to the copyright [Krzysztof]
>> - Align to the new Kconfig name CLK_GLYMUR_GCC/TCSR [Abel, Bjorn]
>> - Use qcom_cc_probe() for tcsrcc [Dmitry]
>> - Add RB tag from [Dmitry] to patch #5
>> - Link to v-1: https://lore.kernel.org/r/20250714-glymur-gcc-tcsrcc-rpmhcc-v1-0-7617eb7e44d8@oss.qualcomm.com

Not sure why these are broken
v1:
https://lore.kernel.org/lkml/20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com/

> 
> None of the links work.
> 
> Best regards,
> Krzysztof
> 

-- 
Thanks,
Taniya Das



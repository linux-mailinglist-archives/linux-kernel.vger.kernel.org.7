Return-Path: <linux-kernel+bounces-742537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B14B0F349
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2EC1CC0098
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52CF2E8893;
	Wed, 23 Jul 2025 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RreGXii/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0AC2E8894
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276001; cv=none; b=UVc5GJGY3Mk+kpcqky1011t2a8oEN6MOS2Cm1+M8QTEqL2rn8SAx3UHygOWoJOqUdlhU0+coYp5x/jDjLKVSdiwGGYQEbX+rNubOakiJhrlzLjmIZMJtUmLvgXtcdfyW7mzHHeQBbEumVrpFuBVix+IeaxSILBqQK2miqa3IDeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276001; c=relaxed/simple;
	bh=HCpPcP1++9JXtPVhSMZtVXW/xDeqe8ilKiIpJh1wrRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8tKpWzKdEijMGNtQ2wqCWi3s2dioibIXwKNCG3TtHeoqtkevnhOBSXzuwM+qhF0ER5XGGZFeaj+Dt2Noy3pxHHbALP3Dlyisxebc4kCseSJQ/vfqwRqB0Nqo2IBEmTG4l1LtqbzOUUP1v4MBfoh9q2PJrGmZ4m1c7OYfnwqj6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RreGXii/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9fJ55024458
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gk+9lQo8OLB83ZmQKGeqhkdZVjnwAl1R2lXLUIpQERk=; b=RreGXii/7t9qNNrq
	DbFUiqGFPpcSsP1x+0q0SSuLU3f8PJogH6cufEOXdeX+gFz/Dn32IeKeEKvLT1C5
	iWpL9q816FjFMx+F+TnHboV4c3+QSvhWwQqUEzs+0RNZ5rNgz0jEZawq1KVWJisV
	wlBurbDpJMa99lauhWu4rWj1IaPBxz7DwfqFJJnSsLB/RCKP9MfE+IVEoz1Kz0Ch
	28pjoGdllyNkPG6oJPzR9kfa24I2OLtFVrD2299e9ls4GKbsRc7ViqkZCG4C5x/n
	jIX60c6BYiqsZMrs/UV1I0NXV1dj2+amT8WjgeHN5Kh9Zz0e1Ssfb0N/g9tis4x6
	M0N6PQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6qd87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:06:38 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2369dd58602so56326895ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753275997; x=1753880797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gk+9lQo8OLB83ZmQKGeqhkdZVjnwAl1R2lXLUIpQERk=;
        b=gAfVMcI3UEvNpeYKknjiuvV5Sz7YxzO6D98WLq3h1VV1gMIsjuCII4zdJiSyh6NLrA
         iy2IqCivvZmhNe0utRdmYR9ypeA1boFEt9K4OElPvQA/39xJdoj0gjyOYIJwIO2yf3Nu
         yyo++vUoRsuUam+5It/4Z20CBjY4tV6jqu+6wHW1Ui240QiUsJuNwSK5VAuZG2X6iV19
         jo0zux7w9ywyQxu7ezmE+O4xU+gWBZ9DEUdHTfxRCYxeG87C+yJpSMe15S/JbFt+49vb
         AU0pTODquRHsxPd0Os+XeDGEgax7gk7me73PEa10bjuH1byTf6h/hs8PveD42g3sT7AK
         gnEw==
X-Forwarded-Encrypted: i=1; AJvYcCVLxQ70n8i/esOq9vq8rtEOr642HsauAp5cIOSKsB3wpOTRjhwtlXXHtf9S///IeTbeln50rtunWHm2Hl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJJ8c610grObd3s75PViJivqLARAQJzEj1b3ANy5yrymbv3j+
	w0yE/Ilo9/W4JeuypNnP+ZIOlld3Y4sVnT6SyzShqiPa9DB/7wUS9+zJXsh4PVAuWv9wMFifa7q
	u85yoXGX5HneltkzghSEW3zgX96X2fJSKVQqgYZswaWJJTrcvxd8+yCWqsfFTtOzRPFk=
X-Gm-Gg: ASbGncsVa3sDq/ceHsM7W0P022PeVw9yPbZ7hcA3hFHeWFXaOKpEfWn3PTCSxXoRUHN
	9iEggR3mfk9zJR58VhtXttJVKaKQYlFEcn04pBBK3Yr/o64qLGNpeToGsOwQgMbOMF72YG4FjNY
	o/v7aLWmo0sBW0yHx07ac9mOlwtIf6GSkKHdM9iBI9pFc1BPNjA0kv4sTnS7b/QutY5vtA3ZyRc
	P3Jo4Bmp19zBlA8Kfltm+RyX5/cKE3k2iZ3RZ1kLh/dyQ4YXGEO1Y3dMDXqoeetvZyk9FS8VNxK
	EU1Jz2Ep98V6+vm08EOKoCL6mzwEqWt1JcNZqOOUGvLTTze5RwgSizcB9xdXrJ13W9LMolPPyZf
	CdTLfwMXj65L6/wGbjNi2W/eThpqr6Kfa7fVS7CRq4toXc8QgVKDPQg==
X-Received: by 2002:a17:903:2a8f:b0:235:be0:db4c with SMTP id d9443c01a7336-23f981d70d0mr37484675ad.41.1753275997073;
        Wed, 23 Jul 2025 06:06:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyFR09d0346jm0sDaEVMHx8YhV6QKTGDzDqC3peZGOi5ZhCvo3sbJzMUXqkg13bKxJY6DVNg==
X-Received: by 2002:a17:903:2a8f:b0:235:be0:db4c with SMTP id d9443c01a7336-23f981d70d0mr37484365ad.41.1753275996639;
        Wed, 23 Jul 2025 06:06:36 -0700 (PDT)
Received: from [10.190.201.48] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e2e51sm95859345ad.19.2025.07.23.06.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 06:06:35 -0700 (PDT)
Message-ID: <e3d04cf8-6d9c-4514-9d8f-782e2d1505a7@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 18:36:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: qcom: Add Glymur pinctrl
 bindings
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, andersson@kernel.org,
        linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_rjendra@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250723103644.4058213-1-pankaj.patil@oss.qualcomm.com>
 <20250723103644.4058213-2-pankaj.patil@oss.qualcomm.com>
 <70277682-94e7-4905-823d-25ae76f72ee2@oss.qualcomm.com>
 <790fd85b-fb24-4d44-bdb1-706c534d1da5@oss.qualcomm.com>
 <d37879af-a1fc-41d4-8e31-2abba6fd6d57@oss.qualcomm.com>
 <d31c5e0f-dc50-4e7b-bd81-256269c82ec3@oss.qualcomm.com>
 <0aa2b07d-8c66-456d-aacd-c554bfa7664f@oss.qualcomm.com>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <0aa2b07d-8c66-456d-aacd-c554bfa7664f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=6880de5e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ABa4ZnCp-855lqKztdsA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: OwK_3W5lWKId2-qAksypoXITtobt59xk
X-Proofpoint-GUID: OwK_3W5lWKId2-qAksypoXITtobt59xk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExMiBTYWx0ZWRfX0TgWx/xolqPw
 v7rwgg8FkFg3hPXvnfZIiVX35v3+vKot5150ALD9BPrYWV5OMsl0+/Dm01SAro+j4vnQgBytYoi
 5tM2YGYSUH3j5zmN+uOmPLq7+ln4tXwOF7hLwHn58lAN5ZXoUzE2XqwtrSXT5zYTJJ5s2MtsgGp
 jSFlDYFZHOKqnlrU6kz0TM6dqfL206rIRxy5oEMwa2nX9AvoIknlFy1mJQrNRkSe0+cenj7IFZ1
 yjFG/m2o9hfTcl+p+0wqwhrT24QKku6Xztp711RXifgm9p0gC38L4CODzPNxmExhlhLi7P49sYE
 uWvjmaBmH2RQesuiC7uuJVRqadLkRUpXSzMUW+GbgBLu+eLJQ/r/ECBxcGQWJJ59FjkuVpjUzAK
 OUtT1h4UFEAmC4jEXz54bSvQGzpMJY4ZIt6GnnCA4tN1Zb4KUwTjCigjqOLktReQP+wMBomM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=933 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230112

On 7/23/2025 6:23 PM, Konrad Dybcio wrote:
> On 7/23/25 2:07 PM, Pankaj Patil wrote:
>> On 7/23/2025 5:25 PM, Konrad Dybcio wrote:
>>> On 7/23/25 1:48 PM, Pankaj Patil wrote:
>>>> On 7/23/2025 5:10 PM, Konrad Dybcio wrote:
>>>>> On 7/23/25 12:36 PM, Pankaj Patil wrote:
>>>>>> Add DeviceTree binding for Glymur SoC TLMM block
>>>>>>
>>>>>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>>>>>> ---
>>>>> [...]
>>>>>
>>>>>> +      function:
>>>>>> +        description:
>>>>>> +          Specify the alternative function to be configured for the specified
>>>>>> +          pins.
>>>>>> +        enum: [ gpio, RESOUT_GPIO_N, aoss_cti, asc_cci, atest_char, atest_usb,
>>>>> Any reason for           /\ to be uppercase?
>>>>>
>>>>> Konrad
>>>>>
>>>> glymur_functions enum members fetched from ipcat,
>>>> this does not exist for sm8750.
>>> I'll repeat my question
>>>
>>> Konrad
>> It's in uppercase because of the way it's in the driver,
>> I'll update only the bindings to lowercase and repost.
> No, the driver must obey to bindings. That's what they're for.
>
> This value is only used between the OS and DT, so it doesn't matter if
> the docs refer to it in uppercase, so long as you keep both in sync.
>
> Konrad
Okay,
Yes both driver and bindings are in sync.


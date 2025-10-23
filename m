Return-Path: <linux-kernel+bounces-866539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63153C000B7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DDE84FDD5F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C1E3043D6;
	Thu, 23 Oct 2025 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pBU9ZY1U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA19930146B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209846; cv=none; b=F88qQrZ43GdbNpWMlog0nVZQbFHfHoBLHWjkkEjn1S0gOzQalqk6dSJeiNyj68XV6hrj9KhOwIuTIoVpClVeJvR72U4m/uKlmqTq31obeiDN/e+9qkoOOav99OWwBivT+uzpJzDnqWdkTf36quX0H3rPQydDFE6ZvR/OAgM9z3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209846; c=relaxed/simple;
	bh=GN8FHCsrsPnDNWstdMgMgM/l7uURXyrK0WDb4zEmAmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPnVECrQqob9S+8C+LSUmSLomsekH0YdFMtOdFTLvGVZdCqKsFNBn2HM2l4NjE4sdSmnCso3szUNDg+kHFzl8yJ6SRY1sK1xzTetNdWjYy1AXW53jD3iJMbnwmJ8+UrJAEWQVadLYtFpS5rmxUyAP1YXNhhfqIk6hG4TB02yN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pBU9ZY1U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6rGq5010394
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yGLPkdsVaasKwnR6ZtrxVHVvAanH3ZikRwOR3VNhX1c=; b=pBU9ZY1UM7qHuYvh
	nRSr+rR21jVYqn0+Vo/i2VtWVnH4i0xpxsbekNd3ZutuSt3Wi2WMa5Bfl9BHlXWg
	pJBORb5DQKUsqH+D3xBSP3Vwi9JJhOkV6hJAr05Nd/UC7MLx4XcjF7voqQ440/BB
	JmzQjLTFyftjIOX8CWr/RF4H2QVGywxG/RqHimPKPDTQQe283cVaFR4eDy4LGm+e
	eyP5XKzVqiWzqvtb+QoECRputQ+bDCpDxMtETDG7Xt/+b5eihr9PI9bYx4+vS94A
	c3oaPnSRP0/9szRWD3QSl2llTp3rx3/2l7wNNZCdlfB+sDC8rPNtoqh9OH1rXuC5
	caR7Nw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3447ssr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:57:23 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6ce7f76617so986314a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761209843; x=1761814643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGLPkdsVaasKwnR6ZtrxVHVvAanH3ZikRwOR3VNhX1c=;
        b=W0HJmizK9s/SebfqdswAWuJw7VDLmij1HdZkU1L1HXjEo4DtFonfFHgvteUvo/x1jq
         /sx7fgQwdCq/9wcT0YxFlMReQyzqJ3bd0Rok3d1pCZP8enO7oxVi4Geups9yNt0RXLll
         mhDiD0sgcyESQyCGDDF3e2fjybs5+9LdJPaC6qObOI8wzIYhP4ot0S9TVqakFDld5Gti
         CWRA3tL5bSpE7mM1RQ7izWTKLYdEhH0jG+Zfclz5ZleGofVj+Wq/U4B0OV7z+fEWa7eN
         F5N2S5EqqWFL+KBm3WITPSa/bs7y0JR/k3H610UKboPU0N5Y5Qd6GjXPusmAMB9cBlhI
         OoPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMjqgx7SU3pi8eIcNnd9pEVy7MxhGfjuZ2MGJCQIQfel3hKsSpVDFoHwyDVLrzDSlrJrZzw7Y++MbIuEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9qJD3iGEYaz3kEKEpdlic2iY3EX1Wq+pBSFQ43P+6OtzYSTXX
	QpFY7HEhTdfHdgxrsEZT2pkNG5WTn/0MmOnRepGJMEHRwm4NwH28d1eTmPacuRmJzM5ffpmVWBg
	yWDiIag34pH0P4Khe7KCgAUcFe5/MesSXfu9iqXJrG6CMUU16CP1N+pGQVe7wIucvJAI=
X-Gm-Gg: ASbGncszRGebnHXMnBX74hPds35f/vZo8aXMZWjfzyYol+VtEFaqv6s6pSyrs23knTd
	91d6y+RudEaOn/uZ5YIhcrSmCOs3F4/+fNA29Er+9krraWKipvnTsqQOFf+3YYw6GnsytsEL71K
	43L+dy0X8ZRbQNepbm9G2MI2b8WxxfnUH0JRREuXhuYHNi3vYqa3QJoxBTjWzF18+CSGCKbOzMF
	NI7rRRX1cmQomvAWX9/JhlE6856zOUyIWYU4gKZ+ABkSJ/tkvdsbsFlBaz+1baQCpKhLY/oTiPK
	Aq8ccPbPwSxDztEyznZPDMN2rcnW426XvlI8ygyH5fo/g6OUEglsIr6F9Nqf21LlTWo9aQiNNz1
	CF0VHSESLsNYUjjN/56zgvE4=
X-Received: by 2002:a17:902:8696:b0:290:ab61:6a4a with SMTP id d9443c01a7336-290c9cb6289mr200060395ad.13.1761209842702;
        Thu, 23 Oct 2025 01:57:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn+sb0Mvygut+Ymh970tn+M8ZVtZ/Q8b0BK2KOaDZWHjuN7b9AbEljFsPZ1XZeFM9t8iBkRA==
X-Received: by 2002:a17:902:8696:b0:290:ab61:6a4a with SMTP id d9443c01a7336-290c9cb6289mr200060255ad.13.1761209842268;
        Thu, 23 Oct 2025 01:57:22 -0700 (PDT)
Received: from [10.217.199.21] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de1a6e3sm16303325ad.52.2025.10.23.01.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:57:21 -0700 (PDT)
Message-ID: <cb361d77-6845-45c9-b418-67649880495e@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 14:27:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] soc: qcom: rpmh: Add support to read back resource
 settings
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-2-5c7a8e4df601@oss.qualcomm.com>
 <litd6qcxuios7uwwcrz55ea24kj26onrjo2aekouynsce6wslj@vatjbulg64mb>
 <4831d12b-a42a-464a-a70f-e0e40cf4ae4b@oss.qualcomm.com>
 <5c0b4712-4a54-4a1a-ad73-dc3bdb21a0ff@oss.qualcomm.com>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
In-Reply-To: <5c0b4712-4a54-4a1a-ad73-dc3bdb21a0ff@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: var7jvNL4UqpWe7JiQCM5WMbqx-oWXJL
X-Proofpoint-ORIG-GUID: var7jvNL4UqpWe7JiQCM5WMbqx-oWXJL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX4XN0B5G1tmt3
 SOApchzo5k2pLDKRqurmhyp5CbFllalj2tqBOaMGrCdlUwpxsk8IGiPzr1BXTZdrKSJL4tscg7a
 Ah0KXSbRSdp2gVq8LcXPIoTwkyqq8IBrIrpgEHpgMCuBpDhvRHm/pmeh6ffBdKfAh6JKGfcpxYl
 IYeV1DzailEcdorZNySmzxYLUmRVghz7RCQEXDaqP+fHcT2ToNOFy1xrcNz9H3TKBLXTWzCmxH6
 pD2u9xoAvLWA0oM1IYBqp4vTAU2nSPhdAAc9CwABBAJYDBQKAgTnVjhebGaEeBXOTE7eY/+yt2g
 7kguABipxTwTTQbN+kh95P6VP4JYdyEOsWK7/2dz1Nkkwd3uGr6jnm0RajU5ayV6O/8i5Hd5SaN
 bfkKW9PkJn8+LywbtKnKgy9NhIhrWQ==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f9edf3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=YAA2XIu200uozTIaui8A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023



On 10/23/2025 1:47 PM, Konrad Dybcio wrote:
> On 10/23/25 6:46 AM, Maulik Shah (mkshah) wrote:
>>
>>
>> On 10/23/2025 2:51 AM, Bjorn Andersson wrote:
>>> On Wed, Oct 22, 2025 at 02:38:54AM +0530, Kamal Wadhwa wrote:
>>>> From: Maulik Shah <maulik.shah@oss.qualcomm.com>
>>>>
>>>> All rpmh_*() APIs so far have supported placing votes for various
>>>> resource settings but the H/W also have option to read resource
>>>> settings.
>>>>
>>>> This change adds a new rpmh_read() API to allow clients
>>>> to read back resource setting from H/W. This will be useful for
>>>> clients like regulators, which currently don't have a way to know
>>>> the settings applied during bootloader stage.
>>>>
>>>
>>> Allow me to express my disappointment over the fact that you sat on this
>>> for 7 years!
>>
>> This was a dead API (even in downstream) with no user since SDM845/ 7 years.
>> Read support was eventually removed from downstream driver too for the same reason.
>> There were early discussions to remove read support from RSC H/W, due to lack of users.
>> Its not realized yet and all SoCs still supports read.
> 
> Can we read BCM states from HLOS this way too?

Yes, Any of ARC/BCM/VRM can be read to get HLOS/DRV2 votes.

Thanks,
Maulik

> 
> Konrad



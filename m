Return-Path: <linux-kernel+bounces-757016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 971CFB1BC6B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13AF7A1985
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 22:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E100025B309;
	Tue,  5 Aug 2025 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L90XrZQf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C21255F39
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754431733; cv=none; b=j7s6rnpYWtcvR8A2RUaCYoFSR7cZCJYK/lCXEFUBtrOIkpp1F1ArjHQHkAq0JsaTxJw7wCtmybFFRp3hQbdgpU7AsUfjxeVgIBBiSKn9pp6SqVjgeGstwhMseoE51+Q4U/O182RtYKXIl5MnKB4Kgj7OjF/zNi0oI8ocbBQE4ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754431733; c=relaxed/simple;
	bh=C4aF0jhnSDNzgCpC/9MJ35IS2P6qdTHutz5MBfw8VPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1vu7yONxU7OwbwxNCJ66p1krLPniirzM5TsnrWQ9oYaqUIsDiuFPonXEmq3hmnk6N+YR9aJyzRt+oYRUMoOrFSB5osoMCCoqp3hCHw12NVFeUJi6eLVF1AvaGQ5OKkHDQ1qXaDAktZdUbN0C01+sN+J/PsXpMTrFuJUYSD5rQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L90XrZQf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575I2wOn012472
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 22:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NPGNwiXRp88kNPj5T9C7eKWaHt3n1T+xdGhFfZ8qfi8=; b=L90XrZQfg0e/SVV5
	hnJOKrC93kx5V44KikYr3CH8RJsRDp4v9t6jNOV9v6ig0dEbvn/BQhiIHm6Nuqv5
	8B/nWVhfNdJHAL7p6iw5uncWCNh25Oo5KdaloshaBt+u52upFL7Fg1M0+NWwIqWs
	wS6Cdj0usjPaNQdJYeWr7Z/P+f856S2ghV0/OdSAgQ14rtDPGreGLFREZZXmKD3+
	zTxxDAzBRoixo8InXokNVTnS8l/q+EVa5NM+pMe+s20BZu05Q6i+lVC0KQJLUVA5
	m98cd/jZUUyRz99QBiVQ1N4OfyqlQBbdiEMOIJVflcUD9kkRsTuWrZYbEtu6866d
	raJO+w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw2rk29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 22:08:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23fe984fe57so67758245ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 15:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754431728; x=1755036528;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPGNwiXRp88kNPj5T9C7eKWaHt3n1T+xdGhFfZ8qfi8=;
        b=LiGuLvJaYcs7PD5SBc2g8Giunw48izoxKGWkFl/+91S1iXxcufnlL+oYUUV6eoCGmf
         G5zxXIJ58Ynqq8yiCgsrHaWjdMOlRcH3PpdxAPHTfVfU3RjIrtki0t1Xis3STemH59R9
         +yjShh1ZLYQqJnLDh2vrxYVESajZvZZ+47ygRKbSjZab4rWHVtoLdZXn4nivIch0rFIE
         LZdAu/IiBnuQx4h08LwfJXM2O3U7n2aeYtO8sn5oBS35dTDlNK7LKgXfzBdT0z2nVw1A
         IxByVJjDnh33pgtRyQdsKJv2nbePS/hFJbtvfGMHhwavoW/CsqGNnVz1zvcOga6XfyMs
         uScQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM2byWL2RrEXfb1oDlBTwPGB+JElP+TCha6xxt0SWHqEb3zMF6Y87Thiu53/yiVmeAQ3ooKC7E2+VR2TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK2pGHVocKnCayr7dNnjheAaX9wCui7B1TeuJVIlJE8rChBcIZ
	6PLEW1oBxhhicagu7Ytl245qh06JDsvx6UuY1sOZqXqS54FKKPUjXFllJslsSpU7hO1kTxu85Eg
	FMpFoqK013w65uJrLZnLCCfgFYyhNNtYP5bd6MmNI0Xe8zyUzj//Z3eOZ5cE29Jgaf3jpJZ1wsw
	U=
X-Gm-Gg: ASbGncuqeiETnN6P4R9inNVE7O9b/ytVDZuevMF5hp5K2kOeEQZmDT1QUhLALq/atEW
	I7O3sxcUVm3w+x0Xlr982tKX35/mZwB9JEob4+Q0KkS3J17s/lw1bDyVMciVFEZhSAjM5LGH8Kn
	qAhJkgw4ZA356bADXP8wjM38ANX8zX7MEtPRHSOtcMjp9XPuvYoKVeGvjNvux6hPPTl7TOJikA0
	jJYCEuDO8UaiOvK46yxRZMQhT/0o+yZeAdqInXWn+GPdZHzoTmCY+y+AXgeZNciruswSFSoPdWQ
	kjJ8vhrwWLReVkHtVC3eLcUMugCMlurG+kYUw52WFDIK8BUBgb2n2hFKshAjDPXQIle4tzvTiEq
	dGdm2Om6l9wV1jZn2sz+I4HhT/nwLSYCJ
X-Received: by 2002:a17:902:ce83:b0:23d:d2d2:b511 with SMTP id d9443c01a7336-242a0ac1ecfmr3280135ad.19.1754431727855;
        Tue, 05 Aug 2025 15:08:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Kul0H2qbAtCnTZWaSV2/tYAXzYWabMFDcnnTPF71+z9fGCHROeCrM/g1vJAXwk5dY+X+Wg==
X-Received: by 2002:a17:902:ce83:b0:23d:d2d2:b511 with SMTP id d9443c01a7336-242a0ac1ecfmr3279765ad.19.1754431727402;
        Tue, 05 Aug 2025 15:08:47 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21c65sm143695185ad.73.2025.08.05.15.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 15:08:46 -0700 (PDT)
Message-ID: <771aef93-df3e-4a9b-b6d9-3a5057f77ddb@oss.qualcomm.com>
Date: Tue, 5 Aug 2025 15:08:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] agents: add legal requirements and agent attribution
 guidelines
To: Sasha Levin <sashal@kernel.org>, corbet@lwn.net, linux-doc@vger.kernel.org,
        workflows@vger.kernel.org
Cc: josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-5-sashal@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250727195802.2222764-5-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vbz3PEp9 c=1 sm=1 tr=0 ts=689280f1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KGwrKJCAF6cQJkUQTlQA:9
 a=QEXdDO2ut3YA:10 a=mLIokOBbMDMA:10 a=W1xJO3YbG5cA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: bKYHxc74N3W1Mlwc2TQzkQ2iktW3thVi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDE1NyBTYWx0ZWRfX3heUqTWKJjZO
 eCnFwL3plxB5u6sJq48gXlwGg+zKyyBG6XdPpTCfhGWPF7Q4C6vT0EdoMVqltvtUlP5KCCedKgM
 eyh+T5ydivmGAubqu10wd6nw4aDbvFo7iy34Kx8mg/EG8aJGeUYGybWlXV4iM09IFRlNUzrS5IO
 gmx4+LlXLQBAk99vQmLe+K7FWTCbSVMbgcL++WK5Jz3/0GZIU/vW9kJgPebLShMMPKfMmNqAAgF
 zVcdGJI8vnTh+ik7NjtVZUtaIr5f14NCAusvH/1vAQaQfkxic39dNu2Yf054ouywW77tWeFey1Z
 72zu5iKZMBxj0t6ZR6AaBwa9Z82tG5msGigQGexlWlr4gbvS2dA/QEXpM4XDRi7hibGPo4Vj8sb
 HoVTqe2HOZJeMHhLGundyAT3OiYRhWz8+q65C0VOpR1fITLzT++Twqhd9oOsBQ96Be4avfDW
X-Proofpoint-GUID: bKYHxc74N3W1Mlwc2TQzkQ2iktW3thVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=796
 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508050157

On 7/27/2025 12:58 PM, Sasha Levin wrote:
> And below is the first test of this scheme:
> 
> Co-developed-by: Claude claude-opus-4-20250514
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Documentation/agents/index.rst |  3 ++-
>  Documentation/agents/legal.rst | 42 ++++++++++++++++++++++++++++++++++
>  Documentation/agents/main.rst  |  5 ++++
>  3 files changed, 49 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/agents/legal.rst
> 
> diff --git a/Documentation/agents/index.rst b/Documentation/agents/index.rst
> index 354af3f025e5..982602db3349 100644
> --- a/Documentation/agents/index.rst
> +++ b/Documentation/agents/index.rst
> @@ -9,4 +9,5 @@ Agents
>  
>     main
>     core
> -   coding-style
> \ No newline at end of file
> +   coding-style
> +   legal
> \ No newline at end of file
> diff --git a/Documentation/agents/legal.rst b/Documentation/agents/legal.rst
> new file mode 100644
> index 000000000000..67e6b2cdff9d
> --- /dev/null
> +++ b/Documentation/agents/legal.rst
> @@ -0,0 +1,42 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============================
> +Legal Requirements for Agents
> +===============================
> +
> +This document outlines critical legal requirements that coding agents must follow when working with the Linux kernel codebase.
> +
> +Licensing Requirements
> +----------------------
> +
> +**GPL-2.0 License**
> +  The Linux kernel is licensed under GPL-2.0 only with a syscall exception. Coding agents MUST follow this licensing rule with no exceptions. Any code contributed must be compatible with this license.
> +
> +**SPDX License Identifiers**
> +  All files must have proper SPDX license identifiers. For most kernel source files, this should be the first line of the file in the appropriate comment format:
> +
> +  - For C source/header files: ``// SPDX-License-Identifier: GPL-2.0``
> +  - For scripts: ``# SPDX-License-Identifier: GPL-2.0``
> +  - For documentation: ``.. SPDX-License-Identifier: GPL-2.0``

I believe the agent has not processed the following correctly:
https://www.kernel.org/doc/html/latest/process/license-rules.html

1) C header files use /* SPDX-License-Identifier: <expression> */
2) Contributions need not be GPL-2.0, "individual files can be provided under
a dual license, e.g. one of the compatible GPL variants and alternatively
under a permissive license like BSD, MIT etc."

These two issues jumped out at me...

/jeff


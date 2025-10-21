Return-Path: <linux-kernel+bounces-862519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BC9BF581E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCD934FEB37
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310EA32ABFD;
	Tue, 21 Oct 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eEsB44ae"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124A232A3CF
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038969; cv=none; b=CUluolBd31zJ6hLVf6N2yME9NXZYyjnOvkFE2MlpEAljHDhW3D2GSCWwk6wvJbmlrrkx8MevjYB2rWVbI39c/fqii6NGu1CH1ZBKuab8J1150zNBgVB4VBGo4dnGsLet6KtecDRqRxd3hGJxnajg7ot7NJt5LdXqez6+Z6dUE/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038969; c=relaxed/simple;
	bh=Lgkx5HPDkqjxZ87HJBcNSye0fzmxDpuWBWFLKUcBuJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5Hto3r2B9S5Pudr+KSR1pHX+eiOvzWpYzerT3D6px2uALpPEBHABtocn6X9hH3eU7aQZdsnDN+UnFb2GidSPsgOzojSFRzaDF/t9ztP0lpbSndjYB6dRE4GPCwDMTDa6ELr7jx5eUm9DUovrr/kTSHMjhFtjnV0JIQeKUBnIYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eEsB44ae; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8MSuY010752
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vchtIDKRTnCYbic8XdnIHZKcKNAB2qHtd73EA57D55U=; b=eEsB44aefSWI41BE
	W7FmzAAbWsxaqRsbY7BhATESzbG+ZjNUet20iA02h/pSCGzDK8Cl7N4LFSjHrzcY
	TFpRLlQwPy8xCqxuF427bUZbU8FpV/rgC+OObwb6mIF3z4tmDfRa2DSaGuyVF05p
	OIaeAKGOt5KfegvFUMq4RJsDVsJaGCsX7CZWervhYAPmVYc+G0WrF272NJZ/bjwi
	tYXms/jvasWANdWp/n1Y3QC/8h/xkR/27oQxcFsjtByow+wQBUFmyjOegxMZbfKd
	woLJa06Zf/ocJtCOWGIXIxj2wgmEKNpJ6H8qtP1SZ4t610GcIeU+i0tp9oibIiUS
	SY+NJQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wtgetdpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:29:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290da17197eso69373835ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038966; x=1761643766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vchtIDKRTnCYbic8XdnIHZKcKNAB2qHtd73EA57D55U=;
        b=hHLztHAD+gTqO4ydSNqqvps5/0OJV90rkEE6cml5sgb1hNzjOdgU9jXegdajHi+pbv
         IQl0I/XdEHLbzK4iAKW4qtE5LovBeH/cWitLeqU8rp2MgOS8/t/4qTXObjB6HJYjzX58
         3sGJOIG83ixCbakRlKxpUCahNaNwdgSKPRDcJPQyt7ThtQn6iI8OTh4ejr6E45IfWLkS
         RjF/W77J+PJDpNaYD70CB5uYPYUGFFwOThxQXMVi1HinIz0rOlHEqGHdFZavH0F71m09
         b5wxUKwxF4O53wQhtyFiBrTNWEpKwFKDDb0ShwQnflBYuYxLR8+vHBb/Bb+UCvD7JTGN
         yhhA==
X-Forwarded-Encrypted: i=1; AJvYcCVfG5MR/y+WNGqvzc0GDndt2Ae5y7u41ce2ZJFW2X8hWusqPuhnbaDd9rJUOkoOCD+mQJydh3LtvJdVh2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YybcFQ+y+SRrnhK32mPiriCbcpHkd1Hc9ae4A/p6pavfZkdbLUi
	NudNg8bzXLNMMR63yFrkY0vdlhvHcX58YP3Wr6AAP5GPUMlExRWP85fQ59p3rlJYKfLMY/SQmpX
	xqqPWKBPffE/3E6c5EOLn6rlPalLNphQaK8+fWrXPYp/kE5/7iJjnWUKjJqc4rX4exec=
X-Gm-Gg: ASbGnctInuWPqpFLdHkd5IXIzl/7U0W3OVnWOKMhj2S3NJIqI7WN7Rpe86zh6iYIzRF
	16SjFOPzP2NkXJ8ysO3z7Z2PDy3LEvzcE6/X16XkjVdBn0XKt2jgonGnbdrygN1+LTCeTNrgc9R
	Ycmpapo7/yoFjquCh0EZpkrr/tTLJNtgZ5F+IT5u01R0bVwkUTZJOthAH8Y35ueqYztM9t0lhOS
	LPE9SgA8OWA/b+NjU7t6+iHVfO963R6N++X+RM3uUlufh5Xb4CKGjxnBPStQyg12dy85tF7XHA0
	mhW/UPZHJss5TWp1JxXeHZFc+nUrrIC+QEhk6OAi8sabO5Tmnn1gTKD8/b9XBJYGEc1rLFo4uvz
	lQZ5rCCNSZYKt6hop2EqSyRWpeGM=
X-Received: by 2002:a17:902:ce0e:b0:292:324e:24bc with SMTP id d9443c01a7336-292324e26damr175702105ad.16.1761038965716;
        Tue, 21 Oct 2025 02:29:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOGC7PHugaE2XtwN/5ogJH3Nu6q4RR8mM10kZpgisPKy4YenMfCVuiNGzBa4/+043w5e9f1w==
X-Received: by 2002:a17:902:ce0e:b0:292:324e:24bc with SMTP id d9443c01a7336-292324e26damr175701785ad.16.1761038964961;
        Tue, 21 Oct 2025 02:29:24 -0700 (PDT)
Received: from [10.217.217.147] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcde4sm104829805ad.5.2025.10.21.02.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:29:24 -0700 (PDT)
Message-ID: <fda2da11-719b-4552-ab5c-d197c9f29092@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 14:59:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc-x1e80100: Enable runtime PM
To: Val Packett <val@packett.cool>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251012230822.16825-1-val@packett.cool>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20251012230822.16825-1-val@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cllXo_SGBAz6y95Vcd9K1c0UmZD32V0C
X-Authority-Analysis: v=2.4 cv=JeaxbEKV c=1 sm=1 tr=0 ts=68f75277 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ol272ZaqoCEH_NYozqoA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: cllXo_SGBAz6y95Vcd9K1c0UmZD32V0C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE1NCBTYWx0ZWRfX96pMHq5JEhlK
 sbT+rRwxkzgJBll9t5icQ99asgirMMIybDlQV9lWuClGdyQa0tsPnw6Syt7vLOsvukZPdlB/Kbp
 WWMJ3E7Ie6uADpp/nHGsGu72kpXEI9FZMQlEsbQOWvqOupi32WSsa1PgSiytX2q5LftOqy5SoPF
 Oksr7vaiNzomjbe49dTTlWVaVc6sJ695SLSX1YpvCUP0Bi5hebyF65a7WWBIGeHIRDljaXxn9j0
 LtihpX3muPuhN1zMtbdbdl2RnEYfEL0T/RC3pSI9bRp09DU/CiKH8SKXdbGVRFw5lYwZ4/er2b3
 lhNBHe3lAIdpBe1y1gW00TAJGmPNKF+NAHF1IWilvUg3kpGaQKBRhM+suiieBUH1BClIKG1EH+R
 zgYZv1rFNft/0SUkJbXCrj9NWuPA8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200154



On 10/13/2025 4:36 AM, Val Packett wrote:
> Enable the main clock controller driver to participate in runtime
> power management.
> 
> Signed-off-by: Val Packett <val@packett.cool>
> ---
> Seems like this would be one of the prerequisites for actually reaching
> deeper power states.. I've been running with this patch on a Dell
> Latitude 7455 for quite a while, did not see any harm for sure.
> ---
>  drivers/clk/qcom/gcc-x1e80100.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
> index 301fc9fc32d8..96bb604c6378 100644
> --- a/drivers/clk/qcom/gcc-x1e80100.c
> +++ b/drivers/clk/qcom/gcc-x1e80100.c
> @@ -6721,6 +6721,7 @@ static const struct qcom_cc_desc gcc_x1e80100_desc = {
>  	.num_resets = ARRAY_SIZE(gcc_x1e80100_resets),
>  	.gdscs = gcc_x1e80100_gdscs,
>  	.num_gdscs = ARRAY_SIZE(gcc_x1e80100_gdscs),
> +	.use_rpm = true,

This is not required to be set for the global clock controller as 'CX'
is the rail powering this clock controller.

>  };
>  
>  static const struct of_device_id gcc_x1e80100_match_table[] = {

-- 
Thanks,
Taniya Das



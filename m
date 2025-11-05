Return-Path: <linux-kernel+bounces-887232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AE2C37A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DF5C4E7FA8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23654342C93;
	Wed,  5 Nov 2025 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cPAOTvzg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cPNaRd7U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186E26FA6E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373254; cv=none; b=IzP312OaU2PT9ICWD0IoQUQ4g4QW9+tdA/f8nBh+AE/9waP4ts4eINF/UBYW/zD/vh+3p2DqWgGHEjRpjjwZFrImuL8xS0vBcXigT+3PcaVTVNlKeXIIGBliVKYiQUFckxAObZH20Y/bI/hbeTK6KVqzu0q+bH1+Y8hvWUC7RMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373254; c=relaxed/simple;
	bh=NMfZdwLuKCWDLotomeU5T4Jw2Q4y5hJM9LHYzZIYy4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4YTesx61q0qRvYCMpSs1vS8cPdwlPyL6q3sZtDlHt9DT3ng77eUP/jEJJK+SPRC+Z2YH8ZE5UwGtURqsMfyna3Oz9exhE4jiIEUo++0KVem6cnOFze0x2Z4bXRJEm/PX69h0MIDwB3VeOF+pCB66cKRB0w7Tk3x2L+dtJVS3Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cPAOTvzg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cPNaRd7U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5E8C4O876651
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 20:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UXte70UJlya0FT2yR3CqJtnYujIzRPJsXjE3Ppjs8Lw=; b=cPAOTvzg5lAEd2EF
	lYisfM2Hwy1tX1JH+vr6ceJLB9ASRM2pxNOsGGwt6jlHEPXGNgzM6gELB8YmzOvp
	vVlmnjqT7njvR3/M0WjDMgKrOMMN6U0LsQY1qRFjMkzRMKn08WHbF2aHYQizH3ow
	wOAVNZLeOX0Ntef5K8KV54tPvVoZlEBVCJa5Hra13Bf2vlGhQ1Rbg5ggafuYaq1w
	5EBGAFBTPtGfVZxlOoodMKSzfdNj0gzLUC+QeKCjFGM3eUoTfKCVKChP/FS1Z2y+
	Iu/95+KqTUHXZCsoHH8RKxSErcpYvo/B/YuXw4LnwJmJxX3GJMatuYgCGZjNi9oD
	rKlZvA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a883194ff-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 20:07:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340d3b1baafso656176a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762373251; x=1762978051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UXte70UJlya0FT2yR3CqJtnYujIzRPJsXjE3Ppjs8Lw=;
        b=cPNaRd7U8mMZhEtVQs1vaxZR6/I9b6blIGEHDJ64lH2xQqxJr0YF3dCjACt4ruTTQg
         zhZS1OoP62fWuFZy3AnMhryYHUKwEAALLXWj7Pjo7djuZQq1pUhLTbkrFWk8tRKTqJ6t
         IjkY2JhDHVSa0ny/rQmW0eMc7MxQ+gner/6HR+1aQqnZutSUEJMJRm6WwjDTnPhXl2qX
         yyg/L5f8mjtWM03v7IPFN4rL/xWJLicp8hGHSeG8olO2juhKbTnQHo9sEEWk96hQddnG
         KFPQDe0nQyvq8DitAn/4I6o6dNQvmPT/Bfv7CPI21vZ921H51JtN1kBmxI3yO5VPeMtM
         TJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373251; x=1762978051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXte70UJlya0FT2yR3CqJtnYujIzRPJsXjE3Ppjs8Lw=;
        b=hF8ddhUA/mxs8apbMYXZLso97YQ53NSUgz03d3z/gM3RBuEgTQlHC84jZlJaruCUF5
         B+WOOqnzx1roemWR0I/GGLTS+kwRdTf/A1QzdbAmXm0XGBNrxFfXdCHdo7EWycKtL5gX
         XQWVATyNNr0Hgse1oKJh3aWw/tYCvlHBGvVDI12aO0+CRVCC0vy21MQtHJ2PMvf/qYJ3
         BWXRjvFKIBd6GXU4ItPlNLSBnWJhQJiDnrPRlm51gchSUw5zNmMdIToIznvP3ESIge0g
         Lvog+w2tRlTZQlC5fyMWiBsmcSpinWT3k2BitajpP7gSySFcbGv/X3EMy4TlU9elvO8E
         hHew==
X-Forwarded-Encrypted: i=1; AJvYcCV8hmOLMCCNDxVfOoJNTWs7aiZ4RnrDmoCAUBGxYn7fhCjXFeHdL5K3IIhgRZM8ZLozarCfMTd9bZtURaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylgMNslcH6W+mI418rTMDSkvBwXL0OW+8PxmmCT54b9SvJ04yr
	CYN0Ap+lvNrAXdV/IaERBhoKeZ646FLIH7McTy30Pq1efiR6BrtngYgcIGzlI79cTmUfe+1uqJN
	Ot0LS8OrI3SwxKvekznl32div1H1Ix2V9/TYSeLnfFF3eHOBJzI2JmOUNYLrYWGD3kfo=
X-Gm-Gg: ASbGncvb5Bv2C9mK8ZzxYaxv5LJvkic36X30ujJ7rgrbGFdvkN+D1OCwJLsUx6NGJAf
	1gzm1CA6VPjr281oi6iYNLJpi4cy35zcA6Z/dU1ge09ZHO0epoTukuELsIKvqbhrtDef/7jiWrS
	1k7Z8FT2qDK3v+Xud2V7V65laMJAajr5BmFcHbwOvocZfJ6DMhQVrU/84aWxZ8vKsUXDZAOeOTW
	05nq/2ALz/r4pNMPP2Va+swdLz0OjjYbZn2yHqnztLt+vNqKipddeFIbr37aqzrj/fRTuaRqP2m
	ldD4lOzBOXwztGqaZCdY4/d4r6hJk46ZnwGx88jcPwFZcu0R5RYjJPcVlvXLAaJ920KmVNrnlV7
	73a9BKK6wJTnVrPnuoC7nDA==
X-Received: by 2002:a17:90b:5288:b0:340:ec6f:5adb with SMTP id 98e67ed59e1d1-341a6c4188cmr5494448a91.3.1762373251273;
        Wed, 05 Nov 2025 12:07:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2oIiT5cT/KgSMsE2GwnvmyY4tzqt3RdX+bPD3MBkVZw1rSLCCavXhikt/7M6yGLPegG8zwQ==
X-Received: by 2002:a17:90b:5288:b0:340:ec6f:5adb with SMTP id 98e67ed59e1d1-341a6c4188cmr5494413a91.3.1762373250772;
        Wed, 05 Nov 2025 12:07:30 -0800 (PST)
Received: from [10.204.104.20] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417d1fd921sm3792163a91.4.2025.11.05.12.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 12:07:30 -0800 (PST)
Message-ID: <2948af7b-799d-4754-9460-c50f3f49ba8f@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 01:37:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: thermal: tsens: Add QCS8300
 compatible
To: Gaurav Kohli <quic_gkohli@quicinc.com>, amitk@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        robh@kernel.org, krzk+dt@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_manafm@quicinc.com
References: <20250822042316.1762153-1-quic_gkohli@quicinc.com>
 <20250822042316.1762153-2-quic_gkohli@quicinc.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20250822042316.1762153-2-quic_gkohli@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ouecqCTEqf0R3W-aZUF_vN4Hm_VC2eOq
X-Proofpoint-GUID: ouecqCTEqf0R3W-aZUF_vN4Hm_VC2eOq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDE1NyBTYWx0ZWRfX4nNKXfoukoOj
 8kbIxahn0U7Nqa1StGBTasb4OzXrFcFNrcCANN5r2b6u8d8iLwUiogzSjesKkgFQFUuSGVTkxdX
 eOlFmL31+rl9u81i51sxatm5FGnVnRpiA8BAXx7zioX3VdHHMMLm3aozUeX8hwfg60OnitjM5aU
 ekoa/rMj1BPepko4ONiOCq97jwRPQoDeuH2N7jbmQP7f4YbHw7hUfM/kq6UfKXbhBOvVfeO01xd
 vjEUNYQNEhJoQpPk4mdifcPaKwQBwhfDKhoZzozvHTGjAzXILC4NL7Pn6vnh1379B7Xic3LNru+
 zkDVmafl0XKB6eHXoxptxQGRam+guwh9sHhRHRA3gvjqhbSwG7TNTNWz66LG2O/b//6VQDc/Po9
 zby43MKR7xddcXHjgne7A/+puqYkMA==
X-Authority-Analysis: v=2.4 cv=Mdhhep/f c=1 sm=1 tr=0 ts=690bae84 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=8netTnWCcZyjVmEasa4A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050157

On 8/22/2025 9:53 AM, Gaurav Kohli wrote:
> Add compatibility string for the thermal sensors on QCS8300 platform.
> 
> Signed-off-by: Gaurav Kohli <quic_gkohli@quicinc.com>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 94311ebd7652..7c1f121fb417 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -54,6 +54,7 @@ properties:
>                - qcom,msm8996-tsens
>                - qcom,msm8998-tsens
>                - qcom,qcm2290-tsens
> +              - qcom,qcs8300-tsens
>                - qcom,sa8255p-tsens
>                - qcom,sa8775p-tsens
>                - qcom,sar2130p-tsens

Looks like this patch is still lying in the mailing list.

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil



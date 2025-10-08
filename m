Return-Path: <linux-kernel+bounces-845418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2BFBC4CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39143AA444
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFAE248861;
	Wed,  8 Oct 2025 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l8wzapt9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CF223D7DE
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926684; cv=none; b=CS+jc3E0ZtcKf6b9pYTg/jouJWWpOeVVp6Zzj0cFIgI8Mwlww9hI5ZcDVNCtcp0hYA19azklYiV4iKZo1KrRxMnA2aHF6o0BkiI5qPJ0fXq6CyrICJ81Ud26OnkkHVVs/zXNP4VK3PeNE/qyMAA/9eo09mud5Vcm05TDN7Jxj4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926684; c=relaxed/simple;
	bh=NBUAGxB/tBXvLkcWyZOr1Q4qRMURG2fiZWYNgPUworQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nay6dBiGdGqT6az0/PF7rmy38+QfG1BYV+dUwiQev4gUot8GW0Ck5XBdTGmluzrrTEXl/jqti4wUe2NePX9JpIGb27SvRdpwzZXd+f7HN7zEEUTOejfo1992Fu8Fmcb99P255AXpcpi29Vqt+V015C1utPWHUXZkZockkqKNbRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l8wzapt9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890fQ5023098
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 12:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x6QmyeNzk2DWtq/5un0rKTrn3/g/0gZ7LHuSs6FDi+Q=; b=l8wzapt9DQeNUk38
	umAl/VcnvDBK5n3FOf3BIKAPQ+KdxaePFfsJ8Wr750zDZ/b9/2e8nRdNtRSL2vHK
	ilu0uyJCvdptf/b0F/XOoAeJ6xiFDSUAmD37jLxBrDCzHjKiM5D8+Dyw1Tm6mxUe
	eP00gzUg+DDXKtCjwrrU2Qy8v0n2uLUUI+zlcXDo0bTZyytMPdkJzIfY0NpRUWnh
	AeRLdUX9BVaqHyOAupU+dvvckN/zUWo8tr2H5HLTNBGvOjE15+N3Jdf3MGTurhbk
	oe3hF/s/VuRt/vHO7YdDa74GShsJRt6exp6kpbMKpS5Q5YSB5JbA9anC3qqq9UvF
	fHYe+A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49n4wktx39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:31:22 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ddf2a2d95fso26239201cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759926681; x=1760531481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6QmyeNzk2DWtq/5un0rKTrn3/g/0gZ7LHuSs6FDi+Q=;
        b=FNXTkGo+zYaNsf5A3qEVNezAXBoCLBhaXm90XeJZWy+S+yR58/u4Kt/rFBMl4BMeXi
         RZCaWO4TTI8PJ4Vblnx9lI5sQnhhl3B/GZC84tyrgugNgm64POBY+AciH4jVkNXxY5GJ
         Wvv6wCPhKqqjnFVwAZjWZ7j9PYVm4aDM00xH5XMz8bB6X8t+l9iA7RJGxkKiApHIj7y4
         huZKwiDHyfqHKSmy8wfhUnKdj3p2P6wkKQddyURT/3luRJiudQPmBOo9kGTCRwzOfU1y
         tF9xaQFS+CV5V2KHNj9U2pBkhGiKYF+vrat0ZgdOUD+55eJ8IVEBpd97rBi1aut3UlPh
         jyGw==
X-Forwarded-Encrypted: i=1; AJvYcCXpnX98U1PJ2RlX3FQBEnOj+FonaeIml9P6j/FamKh7xBl6XSlKOs+tjGE5Z/GM8ZVEMCxssoMIOce9odg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2zgPt5btEDOjkUlkGPueNqifTQ2EBZ9L5VFxVNZC7C227n3zv
	A4lCzviwdot33eGWPuC8sklgLVcQKPM91Th7YgtGQ9/RlpV8z9cMthmeiIoXM5uoliX+Wm+oBEz
	ZfRJ9rWIqfGZNWRnN8hHo9xQlXzJrNPz6My5wT9z1tiqWuZ8ZbnLp9fV64emI8JBX2Xw=
X-Gm-Gg: ASbGncuGCN67gLtngqyypTusK9eN+xpjPpJKIXnlwjHymwsT5M+qPm1CptRWOJQxQVq
	GbOqkQKDt1J/m0dja4vdGgli9nvgGfNPQHnH3eamcTKJzH+H5Y7AScTXD9ak5dTvGjR1ox66EB7
	8wGzSlU3SYzaJvMxssqw6EBXDNcXcXaM3vB88uxQ2d7L1kQ3gpU9DMigGaxWj9Tva/4CnD/R2Ha
	g0VZ6QY14vKtI5oT/hMN3Myym/IaOQ9HZu+jw4oqD0ECIypdGof5tRET2bmPeZynRO948C3ppS/
	Ch0E8k6A59Q7yIqPG1S2wnfGgxCwTz9jIHmtEZPAkNwsWb7Q49TjCVxAL5P195N5C8o7PMgjZWa
	DL91dlWcvsugoT/GP3FIq68MREVk=
X-Received: by 2002:a05:622a:1391:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4e6eaf1f297mr27572691cf.2.1759926681023;
        Wed, 08 Oct 2025 05:31:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4pwI1MduX8smavHYwiDb2mslV760+0IPE3g2CfsrQdd9P6KG/JHQdrqd0yDzYls3wRPT0LA==
X-Received: by 2002:a05:622a:1391:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4e6eaf1f297mr27572141cf.2.1759926680377;
        Wed, 08 Oct 2025 05:31:20 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4f93esm1660139866b.83.2025.10.08.05.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:31:19 -0700 (PDT)
Message-ID: <eddbe8c5-56ab-4007-8df2-87927696bda8@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 14:31:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] arm64: dts: qcom: ipq5424-rdp466: Remove eMMC
 support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
 <20251008090413.458791-9-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008090413.458791-9-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDExNyBTYWx0ZWRfX+rR9HXuyCIeC
 X2t9ifFZ/EX0Wb4CivHPh0Of2TsBu+x7QTaZPeoB2zKwYacUj7tur+cxXjk5ih7qBSd24USTR5d
 gErgSukFM4Lt01JOxF/A0Mi5mXQFg7UG1vl+nE9YzoUxjwdzDwmDOKQ6V+G+5l/DgEIUPCjJSql
 AwGXt8zZA3Q2ISx/LDcZROr9Q6p1wQRGqGTB2IEaRIT2925DUtxtt0g35Tn6Ss6PaBf6Z5nSe2n
 GlvLKK2HGuETbNap3wzNR+sOhZOhNl3x/MoLyc303D8aDq7522TTty6OyLV7TPQ1ZRkK7i1qWVU
 cBETsA8Cz4vgWVyCJdJt+Vef6ywcW3VPwFznPouw84gROnfllPgOvZ1Pk7lN0KX4KWwcp2PgEtJ
 8UiDXDTZD3vXuZPa/Z8btK4OB3UZCg==
X-Authority-Analysis: v=2.4 cv=BP2+bVQG c=1 sm=1 tr=0 ts=68e6599a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=be57XhxKj-X5Z9eHZJAA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: rvsx_IAhIZZjb1k6wnzcpdnRfURos-cL
X-Proofpoint-ORIG-GUID: rvsx_IAhIZZjb1k6wnzcpdnRfURos-cL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070117

On 10/8/25 11:04 AM, Md Sadre Alam wrote:
> Remove eMMC support from the IPQ5424 RDP466 board configuration to
> resolve GPIO pin conflicts with SPI NAND interface.
> 
> The IPQ5424 RDP466 board is designed with NOR + NAND as the default boot
> mode configuration. The eMMC controller and SPI NAND controller share
> the same GPIO pins, creating a hardware conflict:
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


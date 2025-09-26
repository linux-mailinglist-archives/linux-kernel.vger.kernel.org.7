Return-Path: <linux-kernel+bounces-833672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973F8BA29F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5664C7129
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3140A2857CA;
	Fri, 26 Sep 2025 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VdeGhIFr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E1D28468E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758870400; cv=none; b=Ozx/SGRGaOT+cejhlFvNr1TYgu+duP6AmqDyaIwid4kvkP9+uNBZr50Gwzg9dFRuuq/tPUIoiDiQDhQEI3gyxEZZM4cuDFaQfhm5L21SMNKf03JPxhOqOTkvbxKY4F3dooSmAhcU+BamQKgvlsIO3fNEuQTSXelyfLgASrwqWRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758870400; c=relaxed/simple;
	bh=PxIyYiPf4XBEPu58oCPBVQYBlGZTT3vIV7tjE0E41ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/nIEtPFy9yJ+hJm7gKGqZaNWy9IbFzcroUk+NyPdISRXMDSIGHYvctb4BPxjV5V3z65GGT/2SzBLIlciQaQocfEZSYW+fwKDVYwMCVrXaiL+vemb4gun8qYb5iezsYYmQU4xjmekD+uLov5SqRrxj3HLpzZrj/u+BfvmNFNfX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VdeGhIFr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q73Lft023329
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VfsAs5yiAxaYFB0ndDb5atfCwLOCQ2a0n9K8ajWXJTQ=; b=VdeGhIFrddl8aPhy
	qwsCpJ0VEXQf1zHy+ga7hXD6MLL/w6G4dRe6p7UminlE04zS6DC6yTcxT3v12YRE
	87lKfuGlSqUUy02HNh1b9G4IyIwdscIAjXsuWqZW//RycZpSMHjYyn+Adm1a9ofW
	TNuVzuUJrkO+h/lQjCmdCU2xwdrXxpEtP10ftclb0jcpQ9kZfnG2zGDWEPgq/I04
	hIKva8agjYhyqIUiiI3Weyi8f1JfymXvOdGaJ2hCQu0SWImyU/IlZrtRp1mqiZVQ
	SOyDWo6Ec5S4X2UXU1YJkHM3PqObcitwJ5t6NnzJPXMbbHo3JQUAjBQq1ObVCaIk
	8EQ9vA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0qsse3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:06:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-26e4fcc744dso13394295ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758870397; x=1759475197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfsAs5yiAxaYFB0ndDb5atfCwLOCQ2a0n9K8ajWXJTQ=;
        b=b4N+NXja25R1zQKq7odk3kwfQacUXlLTL/YP1p+vPnrdWuophKEVfWArARQJwS77z1
         YEjaJUF++qKAHkfzW61zLzzqIQe107XSHG9UII8GazTSrkOQyrs6yq1RplWMm0vYqm3/
         xmKXqatb/nkLiCuthftrMPodyWOj9OTcwQVDhem3a6fgdIK9BCsvuY3p45vuYvczHOMO
         uqU0Sgydqt4PVG+FiLV3mohLAjk/9geqe2+N3znITovkKnI1V5kasTS7DbsTj8IaB7Nw
         mktdrVOBn5ceYDYm9ZuG7CWmiuWHDJJGc1ltq2HQL1oVu0x90LVe0EbNT13AAu368t5O
         zgsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhKafG22tjvTUABLkrl9Kq9w18ZegD/aNG1gcyQazRhgEIGA3l0qmUJK7Nmq+JU5Q224EWt14KZUW6Op8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5qppjlRX0IPEiRO/yV/Vbb4hE12TXl++GFr+sSc6+2s3QLFhs
	D4ny9gF8NRUokQWSctQUisWB6fq7h677oTwbciTEIAUUtvhUM/r0hVKGN7UX91vvL0pmP1kAV5k
	tvDVT/piGVhnKwMzuqcP3RMotXF89P6ZjxbupkaS6Z8w0XYsbvNZAtRNwnPYmFR08j7U=
X-Gm-Gg: ASbGncsSOJwgfaoIttnUDpszPy5hr+9916A1C/wRkDeiMv4/tlJ6bRAlOssRbAAEKet
	b2b3TengG1mUF/tgE1L1Jr391qQDH6Tj4Bmohsr3Mmt++952c3eiUH7tFP0X/B6rtQ7vBnNVbxX
	oGcJ8LxrhviH9QRIFQNle74CEt+d+YLyJm41ItZs4KolylDc879BSnyHBoU9RIl87TX7HhyRVW9
	38dDsU07LdRjPv2Q8hfgdvbjJX7iqueTMLxaJ/Z9JSCMWGGKSxHiV3baSm+XYe6Mcb/gnKDolnc
	KOia2jOYzMcLSCqXPfMP7Q1G0rX6h/3Ae5rEPV5tV6c0ZvnG5ElLgcEUVAixlqubYIbk
X-Received: by 2002:a17:902:f611:b0:271:fead:9930 with SMTP id d9443c01a7336-27ed4a78d72mr67605325ad.59.1758870397184;
        Fri, 26 Sep 2025 00:06:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkrMZxqylZt6nJiE1ocYHpxscY4Q1brp546AbBdNAbAkmq0vd5XGrBNZjqUvbPQf9USLOYyw==
X-Received: by 2002:a17:902:f611:b0:271:fead:9930 with SMTP id d9443c01a7336-27ed4a78d72mr67604775ad.59.1758870396700;
        Fri, 26 Sep 2025 00:06:36 -0700 (PDT)
Received: from [10.217.216.188] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821desm45499775ad.91.2025.09.26.00.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 00:06:36 -0700 (PDT)
Message-ID: <5aa92e19-bb80-4628-baf8-887199ba2ec1@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 12:36:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] dt-bindings: clock: sm8450-camcc: Remove sc8280xp
 camcc to from sm8450 camcc
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-mmclk-v1-0-d7ea96b4784a@oss.qualcomm.com>
 <20250924-knp-mmclk-v1-2-d7ea96b4784a@oss.qualcomm.com>
 <34esqueoush5gnawnzl7hmnpwr77vip2iqf2w7eiac7jqyghvl@nquuefkyjive>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <34esqueoush5gnawnzl7hmnpwr77vip2iqf2w7eiac7jqyghvl@nquuefkyjive>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Wnvcsa_XwQygkXCpwckR_SL208Mbmkip
X-Authority-Analysis: v=2.4 cv=bJ0b4f+Z c=1 sm=1 tr=0 ts=68d63b7e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=0pmg7TuxG_D_0s_mfB8A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX8/gikw+p4b7m
 2kbEts2gQTkIwCCzMeMM7/ABvr1GuR/3FzkWkmO/X/JS7Hi+O0+wHBxGRYPyAlz5d+nXSL9Rquo
 5hwpZXhfPk2dwl9jFyBOsi4mGYqaYkys7wWJWFzCLWwc9rpyTa6w1sG86buf2SmqEat2g6l7uBL
 w/QaxYnD5sVqqlT808x9wRcG77cIVuUWF87v0DlPono1SHadyU2GztFwez/vYeWEgn28Fn2tw5/
 8kv1yWhMjVdqlHI1nxLdTYBpIcpl9hwAudNDoqvwAg80mj7JBBRDlh155thUvMiwAdFQW6g03Jn
 J3MsE6SL/O+SVFU1yCYYkvndUm5ArI+B0eJMr3demiKk6qXfmhKb4ZuDMsKKNtL62ZHXft6fz4X
 39BXOpq7Oij4PhUfTzQeFtuuxQYbQA==
X-Proofpoint-GUID: Wnvcsa_XwQygkXCpwckR_SL208Mbmkip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171



On 9/26/2025 2:50 AM, Dmitry Baryshkov wrote:
> On Wed, Sep 24, 2025 at 04:56:43PM -0700, Jingyi Wang wrote:
>> From: Taniya Das <taniya.das@oss.qualcomm.com>
>>
>> SC8280XP camcc only requires the MMCX power domain, unlike SM8450 camcc
>> which now supports both MMCX and MXC power domains. Hence move SC8280XP
>> camcc from SM8450.
> 
> The commit message needs to be change to describe this change instead of
> the generic facts about SC8280XP and SM8450.
> 
>>

Sure, Dmitry, I will update it.

>> Fixes: 842fa7482915 ("dt-bindings: clock: qcom,sm8450-camcc: Move sc8280xp camcc to sa8775p camcc")
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
>> index c1e06f39431e..dbfcc399f10b 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
>> @@ -63,7 +63,6 @@ allOf:
>>          compatible:
>>            contains:
>>              enum:
>> -              - qcom,sc8280xp-camcc
>>                - qcom,sm8450-camcc
>>                - qcom,sm8550-camcc
>>      then:
>>
>> -- 
>> 2.25.1
>>
> 

-- 
Thanks,
Taniya Das



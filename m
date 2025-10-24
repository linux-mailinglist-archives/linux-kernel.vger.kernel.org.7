Return-Path: <linux-kernel+bounces-868360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB3EC05098
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7312A1887EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B770304BAF;
	Fri, 24 Oct 2025 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ihw2QGcN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E4D2FC88C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294384; cv=none; b=ZIKolrTP9JQOYm5arr3olED7OSRZcg9hXOSJYmonDSVEcOQFb24QgAnepjUzq5JKDKtK7oaGYCr+7MemP2tmbrDQ3Qjg2sXOWuvr/AxUHcef1TnCO+wqbPEOUntfjeAPSSYlEikg8s7G9YGNEXKPZjpCF3TtHhrXrMvL1kI8Bjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294384; c=relaxed/simple;
	bh=3wnHXXUbxvNC7AueLagvjDdvYpIN3luXco1Nv9HWe1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1mMuIcVsfqHbFVUosSsBohyw5B6c7QT+UzRj/kmXyyV4IGMzUHmVID6ZzxzHUCpZOb0Y7LNwI4FyNIiRHMBevQ9O0on+FmckfyfkZbV1aTj7H9HbyPqM3w9NBrGqXFnSSFmn8EKb/xfdKAOqnbA/+qpQsq8Q7in7+hqxWiJKS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ihw2QGcN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FLE9020355
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	376XFuF7lnjqNU0g0kqMrsqRp3dXMifm6+om7j0VY3E=; b=Ihw2QGcNGcc69+eG
	Isj4MqXGrpud8K9PQ3Hs0n9nMPbXFjUX43m/dTOq2VvSvGA1unEfwd5MXOCqe8Ii
	7KBCcKF1TLXNIlh2egiGZrgSAcLicrz0i4//t4IZL7pa748VrWijUGe+695/9yPT
	Rn82t9JQBxEE81Idn0GG7xjYYIxhhdRm0TZwwOT5/vLsRHLVM04eKHOPmKnVhFCt
	V7tbTITyXp59YTV7WlZu7dtdvrDjRJfxEcxbqhaQQyRpUrTsxYr2b3MoDKiWPZlA
	t/8gD/mm2W267tc9KMkQ6FKC4RDBYY04zjATvCnB0o6QnC3SpvW38XT71GL1kl2A
	YU7lYw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0satq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:26:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88e965f2bbfso61564585a.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761294380; x=1761899180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=376XFuF7lnjqNU0g0kqMrsqRp3dXMifm6+om7j0VY3E=;
        b=rYFRjzb4LYs27nXn37Yf4y/Jyc/LWPeC5QAO+BBemX5nDhs6c7Ja1B/YJr29pAdrf/
         vBJHsN4WRVeo9Chrhwm6MOyFSzW1BO59Xuxt7smZtLMZ+a7ES++oq37euybkRafg0zYf
         lkPR1Amb6gahTk8VJtpe/BpnJf+ytGi2rISs1YFatvtc9/NsAN/H/cF5h4DGup6Gzx69
         O7/DgbvncG7K/jF3lnV3hlozrLmJa/Tt5PAiluX+cDS2zoU+/z2Gnsvb2ZS3e9qzh95h
         vOaRM52ArM/oDe+uedzaY2lDBKQyWSYxpIw1406HG+Opa7f1NsLbT/zCn//Dg7uqi8cG
         O38g==
X-Forwarded-Encrypted: i=1; AJvYcCUHgBB70t0d4gi+QS1BDm4wJg7Zt2JxrvAEjZkfLeLFqFDdYKd22YPoIZqpaXmHDTw7uM35hsubZcbbflM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3m1xS/SlNIJdPZqlGXTSl0NDMrj0qrU+onXrcTAns476PU1Q5
	MKARR/5HnqdDa60dDTlCULQlxvDnOnINoJw6FUcYvQKvtA+ZegNmdgg0X1ZbohIiEWvo6cQNWGa
	8qFrHfKRxthB7PpfqNDQdv/j6O9aCb1qWWPeN8+SjBLiGtMKR7N1QKx0IZlBQuxWPt4Q=
X-Gm-Gg: ASbGncuvd7G81WAe77UYJFRrEkyHxDsPZAyZT2Ve5ldC6Tkxl8F2l2ZYO5iiLqOUKd0
	FuG7CEhG0MtZodeDridVlarDJQAOuQteKcXQSsBY0Ti73GqEk4eo2AxmY3ZB7DuhLrPcC8ucEvH
	wuC2ZwG8cNIggk5PIo3rr8GSgZNwcAlSB6JdpQLmMUFbqpN0sHkawNjeJKRMqJxsb3PdJhjMzcr
	999PJYdTSZqn5/qIlB+9LtFWqhJGbAO/GM7ISF5PUzuPH8eot2gyq1I2fPoj+X95RkFekq8IZcp
	vAMaCxeVXSerOYJaYJoGm06wKqUIJHWB+RnL7k2G3D0WatiqubEGXunsy0BX3+GwG7kaA5zSbKR
	IPtzIxeW62B22xXtJRcZP6TdN/ejPXDdaPJ1sRDgNiqAwHMlTtZzXagWg
X-Received: by 2002:ac8:58d1:0:b0:4b5:e4dc:1ee5 with SMTP id d75a77b69052e-4ea116a3a18mr118992421cf.3.1761294380472;
        Fri, 24 Oct 2025 01:26:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+kaZi0Hbg5k3D9owRXyS9MsGI1IZ5n8ScVBwkhSrJAmMxzXcl7R5offEga6X9VsoIJFEXhQ==
X-Received: by 2002:ac8:58d1:0:b0:4b5:e4dc:1ee5 with SMTP id d75a77b69052e-4ea116a3a18mr118992281cf.3.1761294380006;
        Fri, 24 Oct 2025 01:26:20 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d7971c8b2sm16029266b.45.2025.10.24.01.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 01:26:19 -0700 (PDT)
Message-ID: <229c1807-e534-4f9c-b459-350be0a12888@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 10:26:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sdm630: Add FastRPC nodes to
 ADSP
To: Nickolay Goppen <setotau@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org
References: <20251023-qcom-sdm660-cdsp-adsp-dts-v2-0-895ffe50ab5f@mainlining.org>
 <20251023-qcom-sdm660-cdsp-adsp-dts-v2-3-895ffe50ab5f@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251023-qcom-sdm660-cdsp-adsp-dts-v2-3-895ffe50ab5f@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX3xJYel25GnaZ
 mwtoIRvAfehNHfIZPhqHaz2F+SBUxxNdlT9zZHsFeoPyMvH9Fo98bp5Gu2JzTOf2I+0HeLG1ccm
 N1mspGiC8BkLaCyPFpWPBtpHxpL4kvFRfFxNFQItS6yrm2p+8Ia9ZsyWUnBv5QYK4eQ9y/TqXRa
 H+o+27MRv0HG9808WdUwBDU0jn5xGCW7xQGB1Vv8BqsBXbBwBWfMS5of9Cl0FC49nPG0Y4FPfYm
 1Nfl5gqSvGFCaOfi+LvbdkRp7WlWrrEPcl4uhLA9Cg4x/7xOY1sqpZWrg1vkuOR/hEQySkSmse0
 UvBdcf8CTsIo21xH8I2lm3HNt3GVU/hjpld96cl/GptxI1BV6ELzUjZ0N2slix7bO2y3/6XGMNe
 e++gYFwVF2yI4Q+MleYf7vH7sK/2/Q==
X-Proofpoint-ORIG-GUID: PcTvrfGkqRhdG4ufCrSvzsadNcXVEfiO
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68fb382e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OuZLqq7tAAAA:8 a=2ipkEsje13vFSbuXtY0A:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: PcTvrfGkqRhdG4ufCrSvzsadNcXVEfiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

On 10/23/25 9:52 PM, Nickolay Goppen wrote:
> Add FastRPC subnode with compute-cb subnodes to ADSP node.
> 
> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index f4906ee3f0c3..2764666714e6 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -2342,6 +2342,39 @@ q6routing: routing {
>  						};
>  					};
>  				};
> +
> +				fastrpc {
> +					compatible = "qcom,fastrpc";
> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
> +					label = "adsp";
> +					qcom,non-secure-domain;

I'm not sure this property is valid

Konrad


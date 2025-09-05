Return-Path: <linux-kernel+bounces-802896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA38DB45823
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7375E1C229F2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18615350842;
	Fri,  5 Sep 2025 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hi6yo34A"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192B52BDC10
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076489; cv=none; b=WUjREuQf1TZWQ1pFiDbS+HzlTlXch/DIuIVzaO2h0bpmWO1ZKTjccPl9LexOipDoS5EL5qrdsU4mTsD6i6ZkRj4Jt2T7vvZ6PBdx3Jl4giTWRpB2cWQh90Fm3TsWncfUGev8KWhix9B56QjH8IFZovQZTplCUFUmfRkg6upyobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076489; c=relaxed/simple;
	bh=eP867im1PNQSlQH0RP105yUK43I1I7etGb230DP2KcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oct6XnHCQeCDZFlVbWVualIOUgGzHWHsMebf+9pwMJgT9CnAaSjhpMs+xXAdmjBvH+xUDi19p6XlG66xkHsfEALcXisjtU4AAY5wUwuIwVoOQ+G3971d6grnV4dXOiEThyyB0h1oQBo6qTfU/MtdJUup3m1JC5ilI5pr+kx0bFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hi6yo34A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585B12HR017419
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 12:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1ZVoQZK/NUQF8NTLJXml9/Jc9mpKZVnyeUkELKpWfaA=; b=Hi6yo34A4CSECkEy
	in3l+VwwNrdQ6GuihEaLSZ8pdMPQDi9lXGOksR3My2YGA1VKteV4zqqlwdEMzoJl
	B4lQpu6s1rmjeIWEqbH0YsMJANl8znAiyzkOH9Y2LO+pgTd5FsSw/xkI0Egp7tKu
	SC35tPxJBmHl2caBubK6NAHEwBUQzgKVbyGQoIXsZ/kEx65UwN6UqxGrGt3nMEFw
	PATPGNA4XaOZJ/VXljLilvqq075X2eXhmRYvbXfvaUqIka/dwLDHlY7oifDaUyNV
	ohIH/PlqNWtFc7RGCkMv6NYYYGfliyTPtPjOyhs2hInzVExp/zykB/clpvO1jzd8
	ufcaLg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk9b0tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:48:07 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-715c9cad6f8so2684296d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 05:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076486; x=1757681286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZVoQZK/NUQF8NTLJXml9/Jc9mpKZVnyeUkELKpWfaA=;
        b=AdGsG8T6WyszXtlI0Zvhu+F7ikADLJRQtW9lo47i0t0/KB/slvle6OjHTCMOG+Ygc3
         00qvSad37RQRdg8A8SwSUFogd/srQB7g5uOwfT+15iy2Bc54Sign9jx5/B/nbhH6vQAL
         DPFXn+dWppMXXVhM4Y0W3wrBpdMYQDScbcLD7kKUgirMgpqlyJOG4T7yIygnx37+3Dp5
         BjWbea3ijj532/FkuXrTbvp0SZheudt0jBVBJ9AJi2xjLsLENvvzPXvcoMQNmrlUgtCu
         WS21iTlOPd6Owu0xQBJ28vWasmcbixD0LYp9Ie/2Hv67Os/ZX0jLSHMpRQ/DOqu5R2wF
         WASA==
X-Forwarded-Encrypted: i=1; AJvYcCV+leNVW0ss078V63RnXCA8XM3GhvsNcgu8nkX9j3fPUVEJKrwINK7UqeEdu17k07pyA/mPe2IqBQs0TZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyHsppwlmxki1IBBE2B3RdVL0ZrewIT5uXAkos45prn1s9v3SQ
	hE9W8qagQ1g0DpMMcPMcjrcJ45XhROUrG41iz0S/VrQmzb5csxyggqpDqEJKizqeGqvR2A+HqaI
	7Mv2Fu0fNMX+1h8dCE0UJRe++USH4ghi63aYYW1zLeTsa7aZFgwfIXfLrR5Uj9qczb5E=
X-Gm-Gg: ASbGncujBYbEGr3cfwGaLV/1c1cOe/SxlWLW8gRg2t2D+c4wn6RXYJTjiVA7a5j+OPl
	v+thXj00MsEnwQ0slj0DoIIFf2aHyQiUAOHRwdSwYfpMVeOa+aS8hITm/PRjrx8KvhG/cU2Lzu3
	oUiU0ZVeKwqxlilArXGgSn/1LrOroRXgsHca4qMDKYiQI0doScoLhZDTiaZ2V3fmTU2Kpf8IeM6
	OJXfumvpb8s1bwdfAzrObh94Q07+J1mckmVM/IJdsOQS2Z+j5PmDrfawkuwZzLK9uLV3hWphypR
	7Q11jZMLeCWG468im2icGhy90fIUPaGc0MjETj2i3r4yLmfJEK6K99TihkkyqH2T7YqR3SYOezu
	MEwKgzsygIkDds0P2Yt83Lw==
X-Received: by 2002:a05:622a:349:b0:4b3:d2c:f2a0 with SMTP id d75a77b69052e-4b30e9a9735mr211937231cf.11.1757076486023;
        Fri, 05 Sep 2025 05:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2ElF7QOoyt6gf6FW/4zDA+dbADMgok/NNv8+HL6CTAMy+7viHFeskOkCiSzRQ+mmOfHHfSA==
X-Received: by 2002:a05:622a:349:b0:4b3:d2c:f2a0 with SMTP id d75a77b69052e-4b30e9a9735mr211936971cf.11.1757076485517;
        Fri, 05 Sep 2025 05:48:05 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0466a962c4sm694167966b.71.2025.09.05.05.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:48:05 -0700 (PDT)
Message-ID: <25489432-7cdc-4e99-b5a7-eb976df302f6@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:48:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] arm64: dts: qcom: lemans: Add SDHC controller
 and SDC pin configuration
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-2-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-2-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: k4vSdpxs_4vlqSji80Ns5lCpd-ozWNyk
X-Proofpoint-ORIG-GUID: k4vSdpxs_4vlqSji80Ns5lCpd-ozWNyk
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68badc07 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=EaOeOJoe_TH6RZfqOFQA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX2XzMYLOtXBeg
 EHL44mj3mvS2KDOjof8ww1xglEpQODi9QAcZUelMNG4qcRR0GoF6DsXQlgwB+hIHMY3ayYMGyFw
 G+A/uItM7DVh7K1n/gre8WQu/gVjJQkmsKSL7r5D7OdckkaH+mEYiAvl1IT+nNvIMkVQffUhc8o
 M8HGlSH4vsYNsAyUTeCQDeLUooHLccE+cTGtvUdaqpQeGqIlBFMWHytq1az+WISK2h5AqshpUjz
 xVdLIkP0zJQag6K1PmBtizLU+5YBQJTq5N00Bmb8aTbiu8IDNBUt4ODyDJ2SKBQq16I+0PgeDCc
 nLdplxhU63TPMtwrB+l4ckUiy8Iy4nrxghXJYfU8sHLpNe3gqBYRz/AtbvIeVbHmgt+AOcbvHp/
 qm8wQzaa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

On 9/4/25 6:38 PM, Wasim Nazir wrote:
> From: Monish Chunara <quic_mchunara@quicinc.com>
> 
> Introduce the SDHC v5 controller node for the Lemans platform.
> This controller supports either eMMC or SD-card, but only one
> can be active at a time. SD-card is the preferred configuration
> on Lemans targets, so describe this controller.
> 
> Define the SDC interface pins including clk, cmd, and data lines
> to enable proper communication with the SDHC controller.
> 
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


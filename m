Return-Path: <linux-kernel+bounces-884703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3636C30D6C
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5207A18946AB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947F82EBDDE;
	Tue,  4 Nov 2025 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PiXSVv76";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XemmKF3m"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694D32EAB66
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257337; cv=none; b=CSphhS3FF+eTAdDKvS6usTaGQ4OgoZbudgbv1t+ACzFmGC+KBGKAM88lhl5IkXPKZXaXkHIv+5mQz5p9MNxdV8hMjRRrRXzQ9MqTQpyqf4iZ++zkEiAEKZ5Ijgd3j5VKTTLoc8mz08cLViBvcqBC+Sp0k4qSWEdazmELHOn7Sso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257337; c=relaxed/simple;
	bh=iQhS3BtA5W1bGYkcBI6SxgmHh1GEQDjx65ORueWdtNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oIKztlMyW7qdCa79gQajGvtu7av0qGM+ynPFGMf61e2Z8tVhRP3F9ZY+mBBYkHfQZtFN6WRQbdplAsZkqAIybEN/MBl9bK01Gp8NPo7qC63Ua0TIh7dk+DW2BhsaZKolRbJB3jEN0IAwdQwjJHKyhbAphPNRhzH82phgE22uBP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PiXSVv76; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XemmKF3m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A49dtew1659690
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 11:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YaeLh1DzXsP54cr2u9onqg6gMyD8ArAyK01quRXud5c=; b=PiXSVv76Fd0AZMgO
	6iI5IpAY426x3PpNUjRtnDT4esKYo9V+c0yIhkmffkB0ZVb82rOnPow97S4lJYph
	iXCf4avL2A0TBtG4dlXBGGLPh2psl/PshJxQXny5+7J1b3XH49FTK0++oIsvUFOb
	kBcXR1z32sVFaXoOeo3SsEa4Zm3cG1jh67yJmAmZQmucn2gGN4+F6Dt98A+8m0Sc
	CkDiSOSBImtdahF15Xa/l6WHqIODhbjkr1MUiTjXzTFQiM6WzDbfRiY5QGL2ywXO
	PRmgaSAuDO0gLMI/RKzxKEubLY1extWFm3XMlYrtC9FUAMGorq6QpiPIYyMR+sHK
	H9blCw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7f250b3w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 11:55:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4eced2a52ceso19862761cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762257335; x=1762862135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YaeLh1DzXsP54cr2u9onqg6gMyD8ArAyK01quRXud5c=;
        b=XemmKF3mZqgIKsmgRlvlR0xtUJj7ZdOM+oURCEL/Qn5BNmY/0jgRziAimYJjc1dmue
         ffR4X5PB1QWU5TIOA3RGVAoeCOdM5mfe+1aSLXGMO2l5YbctEs9ZAOSxoJeVZuJNYgu3
         7u0s41/fHqMYpa4i7s9cllynyt2rq/utoRWwUoqNTGI35DSlL2XgOXhGd1eCwF98EOsv
         u9RfHQ8cQedsEYs92hLiybCdKAQ5yw2qK2Tx6RztQj0gEoreIYcBZyfLo765uoJvbtv7
         NAqA3ZN+w/N5obvwAqZHfJ35yTvY9dGRFaKJoYsTC/r31LfI2QLkzCznabuMKf7jNfG9
         y2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257335; x=1762862135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaeLh1DzXsP54cr2u9onqg6gMyD8ArAyK01quRXud5c=;
        b=o6vmzEDbnXswVw2h4PF6vmjupKIKHknV8K9bVZsHWI57546nQafWD4UaXAkbcoDEw1
         eausZmV6/9NeKvk2dEsx6zCWs0lGXkE1FQMTnZr2DmOQL88IKEQDHQNY5dsQhYtIz40j
         nkBPQ4ypcHkR/TK1S5qhSZ6tSr9KhFzWM7yhHEd8HGG3tjEYlJ5t/GSUj2QGO1mK+nC5
         kL4fickL5zdQWqFZ0atQHgCLbmaojMrZCy/ixwgtg/4QSvLET/xS8hVNhsnAG65iHkgr
         41UutzyzJTTSD5OOAXWhsew29iVBKTpzGKQt96T4X44Njhey1EwPwnEo8OXxu6xqKQlV
         K6DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWq+4B9mIMsDhwqHXQLpHBQtRx1lge8CCNv5C6FkCTLK+lymzRi1sU9wL902KPt4EK9xaMs6Bm8lqPghs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPkTgTWdI7foqgQJsqzJaoWfjf0OpF8/LcsEf+oaFN6wLMlCdI
	qErsvKSRaCOIZVW7Wi8dIuk3TnPe29gnUtqN8zfprfGm4n+k52k0kKycydSNh8QLMJ5OQBCzXGA
	VZNb4C3hqUvdut8Ppt8PKt9nwt8TJ5KwScxDWKPBR7oUt4wbOhobms6jtPTtJAI5BW3g=
X-Gm-Gg: ASbGncvVYY183g0sesfLzMrWW4dlNa5R0TW51Ij2fTwt6v5bt89+Gv09EPUQTu/7U0X
	jT15OKJu+l5O0pa3yCaVALFXNgl4zvrR6K0S9D1mOViJsrUVQfSC5jf4qZUbbf+KfYUbTTUhs/V
	OxalZK0o0G9h4+CgSDk3ylsEsTsvSJBPpOIlsk6uqeM6ZAwN4oJP44H1CKlXuaS/kFemYv09nGM
	SZ+rk5+nrB52wAasSj4M/3QClRv462Tn0JyZ7xu7umPm8JuSOyZflCob9E4insWhT+JIgFKANRD
	0ZJrnppX5o5FwgzXwyeSn0nxvLbjxEl+XKJtomrGrwm4V7yylkBpCuuYXlwrKm7tBCfMsYHuX8m
	gsNlIZJoakb3bNM/6mwMZGTlIUctRS0nluPyqZq88LmQC2Fxcqe57YYjG
X-Received: by 2002:a05:622a:1801:b0:4e8:a54d:cce8 with SMTP id d75a77b69052e-4ed30df22bemr147621961cf.4.1762257334716;
        Tue, 04 Nov 2025 03:55:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFx6cBsKczwCY8cK6C1lPEdHIYYD9cqw5rldprbbWnmFR1yVcFP9y2M/7m/IksUx6qsKVVJ6g==
X-Received: by 2002:a05:622a:1801:b0:4e8:a54d:cce8 with SMTP id d75a77b69052e-4ed30df22bemr147621821cf.4.1762257334278;
        Tue, 04 Nov 2025 03:55:34 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f33aesm190274666b.19.2025.11.04.03.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 03:55:33 -0800 (PST)
Message-ID: <e80e3937-3e82-4769-a2cf-26fc5b3ccfa9@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 12:55:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: kodiak: add coresight nodes
To: Jie Gan <jie.gan@oss.qualcomm.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251104-add-coresight-nodes-for-sc7280-v2-1-c67fa3890c2a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251104-add-coresight-nodes-for-sc7280-v2-1-c67fa3890c2a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dNyrWeZb c=1 sm=1 tr=0 ts=6909e9b7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=NbFZ082cz4qFTsEVaK8A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 7GJyzkXX2D3Rok-6GqgvldDPlZHq-lSy
X-Proofpoint-ORIG-GUID: 7GJyzkXX2D3Rok-6GqgvldDPlZHq-lSy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA5OCBTYWx0ZWRfX1SVX9k8B2mye
 4gY1gqQOt7TqmpY6oCaBhmpBf2Hg4GMvJcGbNe4CdM8EkZBpd1uEAiQHgIAW6iS7ilytPFvxyJ5
 /EPEi13hdXYRJxwhyYwOXmiUSll98OZaIoIms7ryDA8+wjMt1GZkyzk7hIuq760bLm7ml5YHb9v
 dQUCG/nXQaB2qjVKRW+pIYoD5eW9PG/3P5KEb8v0kob5ZLyXwCjzGRqOwCEPIklzeTvo4mA5pb2
 0OD2MhHlTtrAXRlKqXpJaA2YQ2pTw/dBadjrDmJnSpSfw1sxJXBRWWGqnm27JZRhjyTk7d7e9GZ
 a+MiAtq+v2jWbM9LYIGmclhwb8L3cnU+UD/yg6f7HaImL4dQcfi0xFXPg3lhRgvZNZ1Bsrw/CdV
 8TJSpGXDyHJcGQ8lzJ8aVvGm3z617g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040098

On 11/4/25 6:48 AM, Jie Gan wrote:
> Add TPDM, TPDA, CTI and funnel coresight devices for AOSS and QDSS
> blocks.
> 
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


Return-Path: <linux-kernel+bounces-764488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B165B223B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2101B61D16
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09D028726F;
	Tue, 12 Aug 2025 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mg6n//dN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2762277020
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992319; cv=none; b=Z5AbqID1hdysYYiBNl82ceaA59vZVLi5JrnfVhz2gzWeti4xyc6Vc+UGU/nY7kpwLSKB9+Ybnq9AezJ1o+IWFPJdPuxrYCthp5oAe+pCRLgza/ZUNaGl94dRT2o/MiYQ9HIJhKPUpaI71lvrKVVFlopJNbWFbdnd3zSiTOPbADM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992319; c=relaxed/simple;
	bh=jd+E5iukvLUB/eB2TM0K/oVyyoLawcNM8WFyG7kRj8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMIvqh1rbBjUE8IP0jGV4TJ0g7Kc0K8fQ9LrkIz0LY6WW1JZutwc9I3yDPFcgBAK9RusFTE7tKneuuSsb9S7X8aM0CuQHKIKTCZOqCknK7DZYNjGKeaJIrqz54gFupiAzwG0yYmgfj+EJXSEZcE63/FSlcldLnwlbT3tDhukSEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mg6n//dN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5YLej029264
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/lSBKcNhfzLdUg9Kuw93+xqCsYQfCxwmTkPBOpkw/Mg=; b=Mg6n//dNinmh5sTO
	HqQaBWZlPKZaoxThd1ahlMB4z/w1l4XsUiJEJBlXgT9evSEifZi6+1EyDzoX9DvR
	IfPf9pkO9kgEb1LxH6e2SGYDmBEDhttHnFw+ADJPkaxuVtYu6Fyb1WloGxhBT1Y9
	LxAYr9On01J1+b3qOQv76esSlTbq9GnBANpFREBsYbwNYislGBzocVTHyBH0vi/K
	3ifCp5flG5u95S+wNNrzzFq8BfW2bwM6wYTj2BGtrPhrYSEBvq0iIAZqyA7D/hQd
	QfiqylN+WfsQQJOGg3/G9aTwU1pDlLgf9XMMwB0BJgwaCA7N3rUgB+uSj6KeyspL
	wX0i6Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmfm2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:51:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b07b805068so11880451cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992315; x=1755597115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lSBKcNhfzLdUg9Kuw93+xqCsYQfCxwmTkPBOpkw/Mg=;
        b=DXFG+J3zrP4QkuoWYQZPVQ5Kv8xuWqodH1XL2JSmVB3B3K4czkxXj6N3NLoBuI/Kuh
         I5/RBSZlKVSyh9BHcOE4T2dr+wcnq04YFXU1jX6S3Kd6FTsbm7nvxanjoOU+fnixCrCK
         5fJAx1gdNHUul15IdG4Gtfujld11+v7MIh/SIAKXy7xqco6PPheqmiRJDOMk1DrPS5z/
         6vneY4UwkhMFO/elX3uG1LYzRpfzFvX4CpPDPzOGndojhSXUlY4E4DWF56MxGk40p/cp
         ijnSw+qXfQKhm1xQD08Owtiatn5eaj4m0FvKfW+j98XDXi1aLIEyfmKxZcvRA03m5as9
         MDEw==
X-Forwarded-Encrypted: i=1; AJvYcCWDw1EQLHftXPJ/5MPdPtm4EK92lxd6LRHbRqxhfMGO7+OT29d8uek+WqC6eKM3m7/geCsuG3ZFCZqaft8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7I1RjulH7iwpV09HrTBGIMCpdmhXQ8claTcsBN9VZsx0RAoOK
	jxTpBKLrEgUNr4KmYhd13wr9U8IpL7x38vKDYjOs45CRCqwoRdNGJj9MO7KKykmVGaHuNwXa6i1
	apCyvXDrchFP6Nr1E8G5/yIeh4QECqAtqePW98TDpPEkUKmcHSDJQnD+VbYAf3yMrdwlyd0MVrj
	U=
X-Gm-Gg: ASbGncvDPj6Gbv61M228m2N1EecwatJi8aEcoiTHt2ITnEX4ay5fS6wCpnQRJ0QrqzH
	esjngczpoDzq1r55oEcE3tkFpjOFsaJjhii7DciK6fbWOFsqQke1vqyW9yNxUI7VDUTGkz9dCp9
	GslsubRwfMiR1N+NCkgDSkgMxLbB5K3RLtCtnXDao7NpZyg74xCLTkAi7ifDdM4mNGRZB0gtHnx
	XV9q/u2dU+iKK9GDIMviHj8KqQJni1VxGzAkK9JQfCzez19+8R43pip/AUqix/8aD2CxVkU1zAr
	QYiw+wTZFXvDA6CFACkijwmvOOZnzE2/rMSy0ZbPUMmFdvR7nXb1ZHkyHuUaMXETh048qQ3jmHc
	RJvLDha81ElVk3e6ZfQ==
X-Received: by 2002:ac8:590a:0:b0:4ae:dc5b:5fee with SMTP id d75a77b69052e-4b0f49eec04mr3747631cf.0.1754992315574;
        Tue, 12 Aug 2025 02:51:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMkGZ42DZIE9vi6e/XnKS20D9Bo9TKQfpGrdhAifj0KEa4CZRyyn2UFU/k80p2/ZCuRsbrfQ==
X-Received: by 2002:ac8:590a:0:b0:4ae:dc5b:5fee with SMTP id d75a77b69052e-4b0f49eec04mr3747451cf.0.1754992315103;
        Tue, 12 Aug 2025 02:51:55 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0766f9sm2219676666b.24.2025.08.12.02.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 02:51:54 -0700 (PDT)
Message-ID: <857f56a9-0fe7-4c10-a55d-b00740a8be02@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 11:51:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sa8775p: Add clocks for QoS
 configuration
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
 <20250808140300.14784-4-odelu.kukatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250808140300.14784-4-odelu.kukatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX6cSgUc1UyjMy
 s9lZcp3p4/61ZHpO53IYLVUr8h3WczV70eaLH1eatMAEPyG44bTySRnWrucSLZcZAeEOeIWDCB1
 V9VwKWrG/RfcBxeRmOaj9MZNPTnmUQRnjBwNbSijwUBnEPAYqnb08H/zbg+9G5Thn9PkKs2wQAz
 lxL+xtjfP60ANoSLQ5Se11tzEVuC+lH7lUnr9nFGGLGjlMNRKNijOrLoUhndmq6t8clr9v81vkn
 yFD9mm/SyLjz5FErp6Wy+D+bjt+orKPMw66FVmFdzVz6hgypRiOUyOus75aLj0+r/v1iTUaXTDq
 L6Uad3J4WSBf7nwr1WC1bhLTAlw+SnAznQh2OT0d8Ifl02jmcQvH3T2HJDw372PIUHLK33Ksmw6
 Ip6/6EcL
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=689b0ebd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=M9tGKf1UEhd6l-wMVe4A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 1R2tzE1Dbm6DZLiyoQMLSs302JTpQ16K
X-Proofpoint-ORIG-GUID: 1R2tzE1Dbm6DZLiyoQMLSs302JTpQ16K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

On 8/8/25 4:03 PM, Odelu Kukatla wrote:
> Add register addresses and clocks which need to be enabled for
> configuring QoS on sa8775p SoC.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---

[...]

> +		system_noc: interconnect@01680000 {

stray leading zero

I also see there's a camera noc.. are these controlled internally
by Titan nowadays?

Konrad


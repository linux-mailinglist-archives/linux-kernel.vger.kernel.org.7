Return-Path: <linux-kernel+bounces-832017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0C1B9E25C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A9107B2DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80371279DA6;
	Thu, 25 Sep 2025 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H7IzIFfg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344A277C8D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790583; cv=none; b=bP6dxBZc5ZtneGpO6vPDVApgoDRhsPwEzXezCZ7K4kr26MtJs+n7lPO8EONP8BTRrvqzrtBHNcE5yqIPiCdFXsLvcj32wHIvo7UTTkQ5zUZVXhhLGBLDYPoIwSiZWqSW1e2pQKNK1BHKQ4LbRgjFN3h6pZCXsuz3AWmffUhTsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790583; c=relaxed/simple;
	bh=mfBuiVc1jTrNnBpkc5m0CUezfJaYbkMF3CihobTqPNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GF8H/om6l9n4GRGyN4aqhf/Isp5IV4kPxk5OcfUfbWKshGaqI0yq/G3flRoyQzrZRnzSDJQ3wyVAxZIouXVTyU1GmhcIYZJhCetEQWODF31ZP9M6wvOPFPjViKZeSg3igzZ4opg2z5M+mQtHkMh71G1j4RAQqQJ5uq24BUztIRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H7IzIFfg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0Z4PG019915
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MyjBhb2r/gU69fmaCmZ9Ifgn+LhunjwusqmSUhFSlqQ=; b=H7IzIFfgCOJyK1b7
	3oIvxiWtBbOozTBiscC8shuYKwGgMy06PMjokEx58soMCQv4XlpK84L+atmXamPb
	yRbal4CIQL8zhDX7vG53lyD0KRTWGGEcRENGP4lqjek/+DUPNiyenRlze9kRfjhX
	FqB7mEH0acP3v6CLFYNFmqLD7jRlvUYiTxEDqu5us7DSd2JwvhhYtxfSHlR3ZeIf
	Y1Y/0kE5z+8vWWnRSsQs4WS/Cl339iOqEd6MZ8cqFq0CrCkJWBRfOzLtH3QZEXPT
	HNwycXhCrtwp0xX9i0XlOVPR88gmE8OVWNRBoz/uUYEElC1broCTnjj7/n8YXg1k
	sAKtmw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpe0p89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:56:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-85d43cd080eso9338185a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758790580; x=1759395380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyjBhb2r/gU69fmaCmZ9Ifgn+LhunjwusqmSUhFSlqQ=;
        b=AXJN7gj8Qd8z+h7blMTJ//m6S+Z+toFRdNRdlAdN6fCIw/GN367jc0nY1x6oD6+GRJ
         jLMlyOGFX63C82xiwbHsPCx+hRM5DA/4wgobbMmDmKZYdMYvOUHXFBkV9s6uHCpeRwCj
         6RmnbXsnD6JJBB8RgKmpEsNF2YClAkd9iC9u6lvSH1C+ghQ86yUvKytgLnW2nQxiXKxN
         s/sBogct/+fVHheU1mBdnfaQj9JVKgQMKi8PLOjqWDj1KiRTImYozwXFbfT0E/A6TsZN
         71EERnpxIPrpLNHgqMcvoRVWkiWtzPClnMn0ZCPv679ZR3RkP++b7R7sepiEcEQK3ila
         TMGg==
X-Forwarded-Encrypted: i=1; AJvYcCWF58971eKzY9O1szEpyRhOUeO8PF3BobJZmutPZo4F+02Brhwb3ke6qBehTpROblNSDBgWPWV9khhP1dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHGCal5rYy+FbKTGVySwqeVzF/WElkXOEsZysbDug0IWKak7MT
	imcFrQPREbxIDf5JE7SaWoO2wo5SxMxSOfxOtBgbpa6/zk6rfAHuy6fLC6iIZ6WCdh5h2jfNmQY
	rrSqB5A/OXU8CXY006naf81+urhZ3yCd59lknxz7RcuuzjAL6eCsK0fHBtsf7dlbwKLM=
X-Gm-Gg: ASbGncvtd4dDlmjm0KrLHsOzoVSowF0GEN6PIp72rQurW/MnMQpzlPesqdkLU8YkdW/
	1K/SOb73TI8R1eQw90TzjQqg9DmjzQbkr2QQVrxe/yNHSnONwyuEWm0MT+SkeonGpx21AOhJfoz
	Vnqmy49qbP3+R4id6iAht0xRszSe7bDrmou7Wh2rt7CoqMYAUtSceKcfduTXNwae/EJXKKaD4B6
	K7ZL9KHhd1ajjTwQL2AzGGAXHfixFj2dV+ZvnMRPoeNXy7u425+LCLeQ6A4rr727tbdAc8iaELS
	lwA/8eKxmccj5QG60zfQxinZ7gVxb3Jeg77eIDn3awFsJgPUS27LeQMoyc+mZb0/SXlj6QnXTSd
	95hyAK4jeMu8r0EqCZI1zhQ==
X-Received: by 2002:a05:620a:2946:b0:827:d72a:7b45 with SMTP id af79cd13be357-85aeba1f4b1mr214524585a.12.1758790579916;
        Thu, 25 Sep 2025 01:56:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvIE5OPFID+YJREvS0boNYXOcv2oaoxwC5+Hv9MQUwY7sobh6xykrZTLcHUGRL/Jq8V+GX/A==
X-Received: by 2002:a05:620a:2946:b0:827:d72a:7b45 with SMTP id af79cd13be357-85aeba1f4b1mr214522685a.12.1758790579433;
        Thu, 25 Sep 2025 01:56:19 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3539347676sm127658066b.0.2025.09.25.01.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:56:18 -0700 (PDT)
Message-ID: <c85c00b4-cd73-4672-8a9d-8c97aa0094d2@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 10:56:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] dt-bindings: leds: Add bindings for Kaanapali PMIC
 peripherals
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
References: <20250924-knp-pmic-peri-v2-0-32316039db2f@oss.qualcomm.com>
 <e06694ec-41a9-4d31-9fd7-8f24f6aa17ba@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e06694ec-41a9-4d31-9fd7-8f24f6aa17ba@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Pj718IMdgtTsa1nVue4ipawafi_AIlSH
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d503b5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=cUfx7Bp6FHvb-ErLiqwA:9
 a=QEXdDO2ut3YA:10 a=UzISIztuOb4A:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: Pj718IMdgtTsa1nVue4ipawafi_AIlSH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX88PzVPl6pBix
 W2QMywGxjvUkQ9HHbf0QEcOvAgp8OySub7V/3EjaBgqeD2jbCOEMVfrQkftjJHSoHV77Vdarv2P
 51a3VtMWy4UJN7UAMkLmslYAgxBFcj+P53AqbbTWCt9sy2rJCTRTfTMh4n3d1cCh4ZiJmoCh5a1
 CpNAHrGrInJUhise8P3JHUldn5AQ7s8IF7yeJTjthtE9CVUIMZEAWrG+db8kEXZRFLFCbRIV0rx
 MmLK7VSUhtc4FE6wLh5fY5mD7ov8/YNstvZASa1ZZP967fh8cNkofwxecGSXEtKbAmz6t6wQLpj
 bMrbkW+3oWIA1wrUFnQ4oCJOpHCTKcOiqzcgU9Tn/KDSbRujQVLzKih4OSym45+rcrJhd/lD+eL
 G6sZmJpj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

On 9/25/25 1:55 AM, Jingyi Wang wrote:
> this was accidentally sent twice, please ignore this.
> 
> Thanks, Jingyi

No issues. When sending a follow-up, please make sure you'll send
a *v3* (so that two parallel v2s don't show up on LKML, confusing
tooling)

Konrad


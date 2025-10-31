Return-Path: <linux-kernel+bounces-879830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B68C24230
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B87E04F68AE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AAC25A2AE;
	Fri, 31 Oct 2025 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eOWi6KF1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sdvu7OWO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461CB330B1C
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761902490; cv=none; b=sGke2BEDO+0dQW99L1jdqIhVbPIFtLE+tZZdI6UsMLud2RblGxReL+iXXhQuGc8+8L6CYLbhBMwdYoDUaDxK/sGlnWK3GNhQK1/OpDFEhqbriFc8adqhm0QjebOVgHZa1l+ri1sCH7dXqLyQY5lTG1pJHP51t2oEYzrq0vPeHEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761902490; c=relaxed/simple;
	bh=w8yfOd60KDdKJreuFqthqsd4fR7/UZE2/5nBgUt6onQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjqKM7MLOgogR0xSS7D7ePMGfYl8wPKqi+Cq8hRYlbb+qZxRICVF0reK9SHuaaTEWeJi6srZhlVtmJMPgDx76Ek/f9eeidIKTCbXv+VBmVbn5xhJeDxknn+m61NCEmbajKlNJb0Mcg6cVIbBM7Y7AwE4A6N2zOwO9Iw6rAJGRzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eOWi6KF1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sdvu7OWO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V80Edc872520
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1gAPrC5tF4vPjEpXPBO+URBh6gx1S2+j2eTdd5IbfCM=; b=eOWi6KF1gNtTSuYt
	DmYPGZ4NdfZ1wmCWN1MdjC9u/96ET7d3GSgO5A48EQyJT0xiuHJgoCfF3YlK2z6K
	0qBqUReETVN7U3lwt0MMul6+CApYb5wbWsVGkEJmNwtA+r2YqWj60u9BqHk2oxd9
	Ds6xElCR8XGK3qiNPIbuk7lGCbeGxWIHdoMFWx7561j1JGi8x+5KmCWzdve7dDYb
	BbyFXq66M7bn0UtWIWdMnu45mwcn4tc34FmvWSQE44os1du1JKVLrSMhoFybqyS1
	VHLeH+g43gZjqteDHcbHC0Hq7dzr11ZHN63JAchU4ywtHvnFWZ8xdCyiNzu5s02D
	jEuKiQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4fqn1m1t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:21:28 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87c262c72b5so6068436d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761902487; x=1762507287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1gAPrC5tF4vPjEpXPBO+URBh6gx1S2+j2eTdd5IbfCM=;
        b=Sdvu7OWOEBUOh6sEkV+23PEZoRiA0PXC4Rj+48h+qFVrjLN04KhwgCL5CZGwPPFE8D
         kFsw/gUrGa1vFDxbbIQllFhT+rijZyg72pCjf7kiyVTQnAgjc0lgywP58Z+qCYVKLSAA
         W+8hcaLErczgqpJ/vP4zODSoJ8Jp62mLk/ZApfAlngTIa2FeTHLN8V8qVre54X46V/57
         ZBRQ8ITH590gk166jmTelDo+ENHGlZyTxSfqC8Li/GLiClfK+gRn2bKItn97xoYisJBr
         DgtwKz0SMw72ohLcr+GaLNKfGzQCjOyxYuVPasWGDzIemDR1R17nHCOa/p2mLQF1Ym/q
         5Cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761902487; x=1762507287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gAPrC5tF4vPjEpXPBO+URBh6gx1S2+j2eTdd5IbfCM=;
        b=VN6VGrYm7IfNzWgW84xUVkqGN7LTb+Z0VqaFQU2PLjIwUE5CFdTnofVSXjFZnIlCBm
         gWdP4ZQUk+ez13iiyvTQwIcUOnjBXzvjdtTf5V+h4gayiYrHG9npxNHijhDNl8bve+g2
         d/xHwpgWSkx3goOWc0Ry0k3qVhRElFABVrQjfktMVJeS4JMKlA7sfYlg4aD6TG1yyDV/
         7IALu3vmM80vetRFHmErCn4Cs6TGCxlUJASO+olQPnQdKsqiM3gbmdwRI+mc8FOnispD
         DZcCYSji9JPv65XbYgqSMhtGZJTqHO/aMQH470WmOxoiPRxpH9LVU+lScRgLkTM+4cVi
         WBpw==
X-Forwarded-Encrypted: i=1; AJvYcCWtvTpeesyorxc7UdgmIUxc5+xS6dMps55+Xpr43VSaL2B+2+73otZBJIyv1v8dNbv3t08ZkMdL0pYIGsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLpQzvBXM4m6UOuRV+5+ezCZAq8PsomBhU7k9r9YeDEY14NFrs
	xuX65jwJSa/QZd12/nxn7kc5QXSxU2s0n77aKgzJfgGZVM0WJOPj/8QsRfxXoFcSx1ooRZjD48o
	NMPdj133Ff6rn1GtA2yFUiczQaCjvjnb1XwpFRrE7PBYgjPLhrRSNsbipeXUdbwHQZu0=
X-Gm-Gg: ASbGncsgBuc3sSnyO3MoCwFG57m9NrF4qFgxEFaxXG8gUZiRV+psBEpzNZFn4L4lray
	L6jDpj2l7rbcnvscrbk1dY8yz2BpT3z6+2Q0MspH7m6LiZTMjN6L0fjzQ3c3oFl8iYKgeUK8XYG
	0497lW69IffaiHauRGR+fSLxmQkZksLWJFnDsl+o3uoJfwFqY8fdeDO/jk98XuUMmEqq7x3fDp4
	hzG3E366J3QDlfFXUY4geGNTx4YTj/BENLAcijnWwudAzkIBTTmQ4RjtJ/zTTEobx0TeUOU2lIn
	UqB7PqKf+tBRAnhY9j/PgSeGFXqQ2S/K/i+lGw8wjqCbzPvTdmp0phK+3ZFSCEH5diK4r6mKs6u
	Uf12g3Eo7xyBst5hXz7bN54NEpj9d/VVjPFco1xhcRX/4MgVa5Xk6le5R
X-Received: by 2002:a05:6214:2aa2:b0:880:1eb1:fdfb with SMTP id 6a1803df08f44-8802ec2ef50mr21081216d6.0.1761902487467;
        Fri, 31 Oct 2025 02:21:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNUAdNYmumEqNj+QhWtcRqw7r8QN5GKfMaLwnY2Fp+tH9FpwHXyXjINbqWk1YR3C2goLdtzw==
X-Received: by 2002:a05:6214:2aa2:b0:880:1eb1:fdfb with SMTP id 6a1803df08f44-8802ec2ef50mr21081026d6.0.1761902486985;
        Fri, 31 Oct 2025 02:21:26 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b438b05sm1120434a12.27.2025.10.31.02.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 02:21:26 -0700 (PDT)
Message-ID: <25579815-5727-41e8-a858-5cddcc2897b7@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 10:21:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] SDM630/660: Add missing MDSS reset
To: Alexey@web.codeaurora.org, Minnekhanov@web.codeaurora.org,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Alexey Minnekhanov <alexeymin@postmarketos.org>
References: <20251031-sdm660-mdss-reset-v1-0-14cb4e6836f2@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251031-sdm660-mdss-reset-v1-0-14cb4e6836f2@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RL2+3oi+ c=1 sm=1 tr=0 ts=69047f98 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=LpQP-O61AAAA:8 a=Gbw9aFdXAAAA:8
 a=QdJS1fbVFv8XyC4bU-YA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=pioyyrs4ZptJ924tMmac:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-ORIG-GUID: GMSc7qHmHyDL46rpEp02Fh-4MSaW2BJ_
X-Proofpoint-GUID: GMSc7qHmHyDL46rpEp02Fh-4MSaW2BJ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA4NCBTYWx0ZWRfX53KHqElz6pAA
 0qGqxtfusvBWb1qiNpaM9hzDSn80x5MZaFzit7C9KzNARLsVs5b1dQyE8JxxqQgdsO0sKyqN205
 nGwNM0+8VkRY+0aHxkNJJ84h2IS57CxrBRXrKjEuyzzL/pFlxPUtQk+YpnDNl3sfHAZwpAYZKPi
 2U/CYsWkGU67AcJEVMjE3Hjy7LMiO+/Kpnc+wZN9XjvSh3lTmzb+35noOXGjXpLDm68Yyx9Omx+
 d7+p/FN/AgyUlGtiMX9wOj/+mbHe7SUspUZDGxecon0N1029ImwTV9FFewHVDFMV6EjatMTIrXp
 iGVX1qqOAKUDzXWP+FP+6Lolq9TetB8aUCzZxzuJiGt+5xIy59tfVvTgVFd/M7f0UtvKtCgaU3A
 PnYvlp2gXSMLkOT6fW+s7XIuAaTu0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510310084

On 10/31/25 3:27 AM, Alexey@web.codeaurora.org wrote:
> Since kernel 6.17 display stack needs to reset the hardware properly to
> ensure that we don't run into issues with the hardware configured by the
> bootloader. MDSS reset is necessary to have working display when the
> bootloader has already initialized it for the boot splash screen.
> 
> Signed-off-by: Alexey Minnekhanov <<alexeymin@postmarketos.org>>

You git identity has two less/greater than symbols

Also.. thunderbird argues there's two of you:


Alexey@web.codeaurora.org
Minnekhanov@web.codeaurora.org

plus.. I thought codeaurora was long dead!?

My DNS certainly doesn't know about web.codeaurora.org specifically

Konrad


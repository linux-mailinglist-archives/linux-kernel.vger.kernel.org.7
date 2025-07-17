Return-Path: <linux-kernel+bounces-735950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F3BB095BA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B8E1C27FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499B422259A;
	Thu, 17 Jul 2025 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F/SLgeZb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00317AE11
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784227; cv=none; b=DB5Q736kT8JEaWCBYH1xyEi/qUtUAuq7HKEWVNrxQrvfZ42mzTUXKCKJK7Fmsm87iCweaPgTeMa8nxwCiKlQufqcFibOD5eV9hteItqFKWdMeuGss2jdvFoGDFcdcCUt/YzyBmf6PaLUx+CCiG7hueiqh/G8TUGQ9TwLkDF4ohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784227; c=relaxed/simple;
	bh=yXaZJh1s97QoYyV0dVGHOmfFM5k9la8f3WzB5GWF94k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5RvpIAVwKiRO0Bz/7bkiUj0eXQzVG2kOtiDQywp/W9gc4K7KQ2H5bR8KRZvVshNmVlg3XCX47eOexeteO3RAN6rjxBe9e2EtwZmkXdFGbohOyPvOjf2J0vKRoh63YvL388BNpcn0d6dAN263zci435e8zflyUubS5PE+RZgoHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F/SLgeZb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HJAGGN022220
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CApBvgecuTLwhooPFQ9wWb7BYDsOgt6qyTee0GMRDwY=; b=F/SLgeZb6J3acNlw
	fg3DMnKLtiYoPw1xQN1Dj2lUccY73AoQCaRtkjHlgN1g54GjeQp4O2FH1NbdM9JE
	T0pT5l8Qm4j7P1qFBbLAu+h3Hwlt5JsOaClIESX0V6FpwFmwGOdpeZZrYY737Ess
	UoLyNo8kAFVoikcl4Dt4qXKDRa0VY38UfHqggQ7Tq452aXCstjGyGKdY8MCADWAM
	vsSPswkPqdagEDbVQTXYkD86IkGo9s/9DBiNWLFjepYIwdwcBj7sE2eziYNYNERr
	SJLrs4IwZPrvatGqz02XKyrekimQ+IQwm51O50gkw+tHId+JTESk0yNIXY2Oz/44
	t/cbeg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy92dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:30:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab7a01c38cso3005931cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752784224; x=1753389024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CApBvgecuTLwhooPFQ9wWb7BYDsOgt6qyTee0GMRDwY=;
        b=YGiLq8CoV7f3XUXCV035HZG2r4cQa13y9iCq+okS8mcuvleU7QyJy4zB0NKLE2fmRd
         9Zp6W0b8xMp4KXF4YARR/sQU9RG8WtiezzFAQJa78m4gCoFi/GOB+R04Khv/i483Zu5+
         Xts703EpSd01P9nTuWF0fmiq9fageNYlCWWFvRft1cV4VGcWo3Wt5+5d5OJazc1QlwcR
         3E/N4q4lm5ded+PcUFge7szymdjagZafAjVXr4aRlSRAUPHGFfvSd3MyGXzsFihpUDqe
         HZG07eNaKfNuTeaKx5ujcQIqeZeZTqjNNuqBuRbYc0/Z3cwk0KZ++CZ45yAGjML6sID5
         dvvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMQlJT/g3x36N3zYsEbi7hmg/BpaV+HNzz3FEqHvWweA/4wDimeiyra9PSP3y6+CDOtdI1DvoY7sIj5Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1gdfyuTBIlirN8N5eB9m2dNBYaLHa511YLevjzNk98b/RlC3b
	enxLYYvkHdKZQboG+JaQgClBDUr1ZCeOkUueSPxu3gh9yrlHf+p8jeUG8TQ+60oPXMTqKeLrcQJ
	5rOW1Pnp8/abOul5NG46z3TG+vNrUI+2k/SDnbu6v+wczAC0Sss4xBNttLZ0xC83b3UA=
X-Gm-Gg: ASbGnctBY0De/hFk5xah6PPMYTmKJLWUHeU2OTRw/B/fGL38QRDw20nIWk6f3+iZx3I
	6D8/KDNTbIVk3O7/w5Q2gHeclBvVow8Te733N1E27CUJR3aLfqBFBs7ujNOf+jCkpMmBhLPW0Zd
	GJWSI8JfCD1CRn1l+ftItgS3A0p36BVVIQGU/52vWYSLZmv0mnEV2iJML9WPrQ2mhBePEu8VaRf
	QCyyyjBgydQJsDqybGRZP8rXHKkg9GEqJvbkF++6XdHKtY1rDCtubpbOqP5ebGmni4/IQ21tmxn
	xT5ht1jJETWoN1kfgfdY3P/2pSbevoWmrCAqDXxdJuSOviMYE0fgwEHaXvPE7dDiHqIjobZMH3s
	g0VppwE/Hl7vxndsjzO3d
X-Received: by 2002:a05:620a:2b49:b0:7e3:3419:90d with SMTP id af79cd13be357-7e342adfc02mr464596985a.7.1752784223651;
        Thu, 17 Jul 2025 13:30:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh7efxMPiaABCqMznB8bM0sGwzfCMhBakRHFLmRQQii5O7L2SQZ/AT4w5DU1nWhvzljOpuBg==
X-Received: by 2002:a05:620a:2b49:b0:7e3:3419:90d with SMTP id af79cd13be357-7e342adfc02mr464595485a.7.1752784223247;
        Thu, 17 Jul 2025 13:30:23 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294013sm1420624566b.118.2025.07.17.13.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 13:30:12 -0700 (PDT)
Message-ID: <5e3dcc7b-c929-4f2c-86d7-dd57b08eb939@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 22:30:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8250-xiaomi-pipa: Drop unused
 bq27z561
To: Arseniy Velikanov <me@adomerle.pw>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Luka Panio <lukapanio@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <ffc3b329-6d46-41f3-9780-05369d29f9c3@adomerle.pw>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ffc3b329-6d46-41f3-9780-05369d29f9c3@adomerle.pw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE4MSBTYWx0ZWRfX+YdD4OJ4lHzJ
 bFJjJnJ3M38TR6AObTOuCpIko0YH0DNTOVN88T32jPKNKl6Phy/XcONZ7nyXG317D1Hn0HyrgbJ
 7eKNiOF+cl8Te/M4QqzvPV0jRNu1LsiT3hK8oyKlQh6CAOjG1hCHiG1bszMZH98Dm08GqXOBDlf
 Tdfcy3YF/F6JyttSJ8IkOP1Z1VdPva8PhS3G+zWFD8li+KXDyjSqQp2HoswiiBdTTBPGFYN4sgc
 ZPWGjdG+bTBsjrKi606/EQ5iNHBBf7JFWbjYJZ3bYPPTBjo6nW6v5YaDMxiCiQryR8SHzf9zlMn
 gy9CX8AgKKVbZPaGfuvI7u4nBiKEGyJCC0yfpozCyedNQHEKwL0updlz22+yNRMBM+m6Md/uLz+
 487QixX1mtz9/sZ8HSjzFZBFQwOWqAsrvXUZvJWw7HrXSwOAsm7wGeqX+AxkP8eQ6umUdn6g
X-Proofpoint-GUID: Rg4qrcWX0tPosZ_wkNDDcYbTi_U65sPR
X-Proofpoint-ORIG-GUID: Rg4qrcWX0tPosZ_wkNDDcYbTi_U65sPR
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=68795d61 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=Fl1iwlySYO9TATX8aXYA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170181

On 7/16/25 8:18 PM, Arseniy Velikanov wrote:
> On 16.07.2025 20:00, Konrad Dybcio wrote:
>> Since it's actually onboard, it would be fair to assume it's there
>> for a reason.. Does it also report nonsense when running a
>> downstream build?
> Well, as I said before (looks like i sent reply wrongly), it's disabled
> in the vendor's kernel config:
> https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/pipa-t-oss/arch/arm64/configs/vendor/pipa_user_defconfig#L413
> 
> Also, pmic fuel gauge, which works with the WIP driver in our
> close-to-mainline fork reports mixed information for a dual-cell
> battery, instead of each cell individually, and I think
> this is a more right way.

OK this is a more convincing answer, thanks for confirming

Konrad


Return-Path: <linux-kernel+bounces-721731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025EFAFCD2E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C648D3AA162
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1076E2DE715;
	Tue,  8 Jul 2025 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QiG9r98x"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C0E1F09AC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984167; cv=none; b=NGLhmPKwcZ2QElv0OK5dDoSU1VBwfGSHSNflaIe3PbsQZ8AFrn2gRNrrrKVV5ndyyOuLBm/1oJNnZ7RX6SPVdWG6+ggHJ1D3gvWBtHinVndACf16LxCoWEJQKj3cfyocXz9rL/QfXgQKXCa9n+2nb5g0D0ncyaanupeZbcSatfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984167; c=relaxed/simple;
	bh=E3lfaH1esoHl+ru8dt/bh3KVLlHTXxish5JJputhM/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4crkY/uP1HrF1X6P+fh8VkH2cOcuturCswQ4h49JS/SJwN0uRwTYOWsw7f2qEilPm0yScQGntthPg/27lzEuihr7QuDvRZLwAeTjtn8R0lC/+LDu73HARq4d/Esxlg2teFyySXdawfkPkCVp6pG7MeRGS8u1f8UpPooKFAJR0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QiG9r98x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAFNV000345
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 14:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DZQVHr6h2vbACH/HxbUVPyBgPPfJWbpb9xJOT/3ejgk=; b=QiG9r98xOc7yxMot
	4Pyj/5ng2VQ1vd/ThuyA/rlbm1NoQ+H8jlXCA79GkKYltN7+HzFEpAk4lLCKZpkb
	HgYsUW6I7qS4xnWzV+F95qUKIGBc7Gjkpp7FT1B3XgrhIWeSCrdodkaSN1nqrnJm
	8Mt3uEi5H1I6zW1xlKpC/WbNtMo2HQldVjR39HDMHYKHt253f8rsIOz3SDZVkgXm
	wLb7KHy4jQcW82z8Uloe0ofDSodFHrlEoHOUVkQ7w8wGgzivv8t8R9jZQ1nBHsCU
	YY25cDA7AUiwpckwupN32lKA023RqQK3bPd7OsWP+UlA5AwYjbBHW1iBkY+NCJTz
	SKqL8A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psrkp32s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 14:16:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d440beeb17so48221585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984164; x=1752588964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZQVHr6h2vbACH/HxbUVPyBgPPfJWbpb9xJOT/3ejgk=;
        b=btYDMjaRUZdTqSLPFYpbTEvyAdybp53qxPyf28PhyFJuj9ax2+qw6kCDEO1/6a3unm
         NGWDXE3qdMBejwUs6VQO0VJ6BeH303902Mh56TrkRS02yxSrO+hj4Jfd6O/CumUId7Lq
         rRtqauhEfBsxrFYf9/8JlSiauXKyc3rM8dMNGS9KMESKZC2oculiRIHwVXpZpYLgF5nV
         KrDTMmde3r0XI1VlxJcy1U60W9WX6FNpYbgABG4coySygXVJMesjIiiT4SE83eBKTqjt
         pE2THTgSrr3+fbGmxn/a5paLVnf9qEfrUB/11oe5oyEy3TNZoQIElTzM1mQR7XV7vLC/
         HSDw==
X-Forwarded-Encrypted: i=1; AJvYcCXyJpiC6X4EPusljbFqatIyUt4k1yhs4ZafWIARfPGmSEhMATr3Q3ceXHJY0WPAz6+lVcM8GUAQPiTm2fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwObZZYy/ymHttSx3mFwdtNzVudyqzZdbJEDOFUDP5RJGZsc44b
	t+q7PVIyjMI8GxBrsD0vmTJZfQPPIPevrZps+Jd24RBnTOWTIkLSSm0NfM10F/1QJ3FPWGYCmzL
	WPczLbl2xGGrhveW7lXQ+h0MRAT091qBtGICFDaWSBeZSY4jzjRGQNimvK+ko77kiV40=
X-Gm-Gg: ASbGnctRl0A5tcbfZaWoA62tYCMuMGHDoZfju8d7ufHQBIrOPFMFczDSnpVSwmDwBzx
	jzH+c0InXc5OuAgb0VBGorMYsbvzbxnzISXLRDNjmCF1gr6Zwo9WgxseTvY/a2A5Zcf3C7knr9j
	3B1olhN6+dNQXDWvE+5rwZ/n+UuFxBcaVKc+p4bYGqKB5GfBfqx41I1fBxvcDpWcD5rsUQSJCKG
	TrUc4Mja3e+/qUEACU38mEjjBsWxuYfxgtIgVrzlchAaYwmaM68Mbw+FrDlWqruXvLGemxxeIek
	yuQZ8Uq3iSdKfPBjc0dxBGcMqEbGRTlN0GEdvaXZHOblO0gpfGeExR+HwPFR1aldMnkyHx8Wzsj
	zfmw=
X-Received: by 2002:a05:620a:170a:b0:7d3:e9b7:7121 with SMTP id af79cd13be357-7d5dcd42af1mr823710485a.12.1751984162979;
        Tue, 08 Jul 2025 07:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoRxKnbbwSsxFhWpE2/NEaVUl1RaxHp0HVlyQd5O1NsiVnVWQKCituQF6abehsg1sXoy3qKA==
X-Received: by 2002:a05:620a:170a:b0:7d3:e9b7:7121 with SMTP id af79cd13be357-7d5dcd42af1mr823708285a.12.1751984162353;
        Tue, 08 Jul 2025 07:16:02 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383bae7fsm1700290e87.50.2025.07.08.07.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:16:01 -0700 (PDT)
Message-ID: <2ada89b4-adc7-4462-a9fc-ebe692623fff@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 16:15:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: qcom: msm8226-samsung-ms013g: Add touch keys
To: Raymond Hackley <raymondhackley@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20250708122118.157791-1-raymondhackley@protonmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250708122118.157791-1-raymondhackley@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bnUEBlph6oJtJZSQbc47taUP3KbFoGu1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDExOCBTYWx0ZWRfX0I1ssE/Vq+Mf
 EWt9ei5gVsZCOsPrAgGm/3W4N9EzDqGTX1G0PoaLraOLnYF6tfICzQfhAy3gmwwXegC7PsklrHJ
 CsTycQMO5aNe2yEKYsZ+41KFoDSap83OHaKV/imr1sA6g/37FYRglxpkg/X7KG3oAPFvXhiARPq
 7NqC/HL5/MJZ9jQ1BiVrZcgpJHhm2X3nd4ul9KW3sY78RXPrLJW5JD1IBIw/G7BTOXgonq3f+8Q
 E15MHJmAxlvsCD0pjtiCVG+y9yXrEU4n5wK9XH9sJnYKUuVX29iJl7mjzi/Y0NzKfcYT3z+VCh4
 sxXtu6WhPlDSMgUwAYPEPuQ7d5s9FmLAiVn7qJn68CbFrjaa691RWD8ZTFdlm3/evly8o0n+Xpf
 jP+QCt10X3h3w9b253Tbmw0k22Q7rOc8IESKramnhfmI1gWgXzHtcNHGMXIEHUkeaSGPojQi
X-Proofpoint-GUID: bnUEBlph6oJtJZSQbc47taUP3KbFoGu1
X-Authority-Analysis: v=2.4 cv=GtBC+l1C c=1 sm=1 tr=0 ts=686d2825 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=sfOm8-O8AAAA:8 a=EUspDBNiAAAA:8
 a=DCnaCfRbCLLe1x2JEeAA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080118

On 7/8/25 2:21 PM, Raymond Hackley wrote:
> Touch keys feature on Galaxy Grand 2 is provided by Zinitix touchscreen.
> Add property linux,keycodes to enable touch keys.
> 
> Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


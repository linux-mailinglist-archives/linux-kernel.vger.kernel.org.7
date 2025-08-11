Return-Path: <linux-kernel+bounces-762506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDD0B207C1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 156E17AFE14
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6822D3ED1;
	Mon, 11 Aug 2025 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YcuDWubB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F4F2D3A7B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911610; cv=none; b=PHs/nIdF15VmNMKZUT8UQyoooahZcUg3o2iSoBDVmxX4e0zrAdKLKFD4VeKU9EuN5UJoj/SyVuGEs15AdYHsbcwcbgCyo0dZDzw2ViP/uLTZcfT7FHoVgwVpwJ36067GJaZm5XIS5lkLNaKZbEcJkPSlPxiklWrPQPQauzFCNJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911610; c=relaxed/simple;
	bh=SjIiRwkUuW69/oZGblmkKyoI/24xQdAns+MvUBljizU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0XZvPEnLTrKMcHcIk4LygGsqNGNhyjcr1WI3BYlyIwZ4MTLd9LgBsR3HZ3hlMGr27ndI0NGKN06eQNyrhsVRYnznii1FWtOiNGC6y9W0WgyVMcZVxVRhaXPiPQvTiAx+/M7YMRJj31DBtU0Y9SKslWSECNebG3uzLMixKGMscQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YcuDWubB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9d9vD007563
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X3MpL2rgvGRtzT3qycNG0CQC8CXqgfD3OIxhOY8bvSY=; b=YcuDWubBPQXZRXRs
	2mlcuWkYLTqabLlUE9PSRqp31qGmPvZjqCba5DZjJ0Dy+j3xi6PDMGn3DHRcKI+m
	RenByX2TmikuXUpqKqf+YBujkFj65lWZJQLH1KJZnKyev6DIsZg/9tUvAr1GngZt
	AFs9fCF9Mwh9dBssMCB9pqFhx0U25ec8+rcsCzNiXJ+pi1kdYjhI0DzGENXRZl8g
	2n292MVtixdPWU5eBm6aAXVSuLSX1zaR6Hl1abf5lyTPzNe8XKMferF5evURVCHd
	aEXb+fdYM6oidzxtoj8WWAF5VRxgAjJTPskHzYZVwavR/uswnoeGzxAHttp3kt/F
	uKClFA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dv1fmcq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:26:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e7f74bb018so75450285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911606; x=1755516406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3MpL2rgvGRtzT3qycNG0CQC8CXqgfD3OIxhOY8bvSY=;
        b=GJAhPDfyyoaf9KetYNeEzC/xvWnnnXPPO/BFWKytUq7NXfLV2GSMU21zcxkQ/m/hvw
         xYt+3ev0Zl/bw/BISd18ORfbITR5EjiE/Xn+50qL7Lv55+IqrByf2zDRbxmJF4QoABvt
         As+FsmZoztM7urxropjfQK8EJRzdlKUZTqzHjWEfqENpofVIECxWZswCQKbK8DAyJrm0
         IkxOc95rQP8ahuJhCD2B4pX38frAU21/RXIbt7s+VAbUv+UBAQe1TRCb3vIKx4VjJrzA
         +2aVJeu4f/GESmZl/DfLv1fBLG2gBAeYPewlSk+/C4t3JEXzHKsydTW7XwVqANFUct/I
         Hztw==
X-Forwarded-Encrypted: i=1; AJvYcCUwxNMd1akqAbYLrj6I7SCsgc0lRXXEbTYhfQU2Dtpw02obHnGua7g/vQhHDzNGm9k4x8Edvke9l0EXkC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzain3Np6GNWUqS1fTRDUK1YtpbpLRWdWLgfbC0tPmzwl3jjuCt
	ZjZz0E+K/obrZkCxQqgtxijHxhwitF8ktYNnfEc7TDUjPpQywvi1ukEMIU5zsRkAvT5tc5/B8hP
	uR9Vb23pd6sWWSWw5o3YG+9ebTTlByyC5OpAGo+FkhLlQpOO9cLadL/csILV7cnQro/U=
X-Gm-Gg: ASbGncuY8bpIzMSShpT7vl180rHbL8AYNbpH+UKQbAtFwDj7CIBcuPRUcjgyS/qnZO9
	s3JsAPgEPCZqlmgtQKN/S0CMPsZx8WcH+ZuwxsPRVqt6kOupzKOIWLfj99ZN4sqUaNxE7AAA40q
	HXPAu9t7iPqc81dgj1uZs8RvzOATBAYDJUSnzSyYz4SMKcg9VvGKGmroR6Vi3Je9l1bdTZrQj0y
	PzitQR+gBb90nD+RzuKvLZ14p41XyUmQPNGPe/2t3fD+yR002WBunO2UdywC4fbpSOuGFIg9drD
	D5UxOSQgwsPTeUbT/R06PIr8KngIm3eJq3yKhVFtQECp1GduXOayrOwpElVPiutuV31N2zQ0wvg
	okCeQhqkYnS7cC6/0tg==
X-Received: by 2002:a05:620a:2596:b0:7e6:6ed8:be6e with SMTP id af79cd13be357-7e83b69fc23mr475556985a.2.1754911605917;
        Mon, 11 Aug 2025 04:26:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyjAl0KldBBqrP2dkmKQEiG85HhgslHvNvUuKaCDwmYjM+dyvf+iuE8pKHOehKA/6xP5UTMg==
X-Received: by 2002:a05:620a:2596:b0:7e6:6ed8:be6e with SMTP id af79cd13be357-7e83b69fc23mr475554885a.2.1754911605480;
        Mon, 11 Aug 2025 04:26:45 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c076sm1978002966b.102.2025.08.11.04.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:26:44 -0700 (PDT)
Message-ID: <23b8ef03-58ef-4cc1-a467-0fa0cccddf31@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 13:26:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] arm64: dts: qcom: msm8953: Re-sort tlmm pinctrl
 states
To: Luca Weiss <luca@lucaweiss.eu>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250810-msm8953-cci-v1-0-e83f104cabfc@lucaweiss.eu>
 <20250810-msm8953-cci-v1-4-e83f104cabfc@lucaweiss.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250810-msm8953-cci-v1-4-e83f104cabfc@lucaweiss.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3PmyJ0XiyPlCxrHw_Ta7Xm-It0llcGPI
X-Authority-Analysis: v=2.4 cv=cLTgskeN c=1 sm=1 tr=0 ts=6899d377 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=dlmhaOwlAAAA:8 a=EUspDBNiAAAA:8
 a=o2iUG9rTFtLDcKp-zFwA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=y4cfut4LVr_MrANMpYTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAwMyBTYWx0ZWRfX4gRVGJteD5H2
 ogNlR2Z5CX5bNBU3sQyGmOI0ZHqYl2S/Kgi/ElZ4cMFxerI+IWsAKs7xekQWNp+xy5xK3X0mJWC
 xHf8pA2GxH88HuODHUPmX0P/unNbUMtOSxnECzS8tqFg6lVahlUhQ0sG7Vhyk1sfiaxxb+Kjmt7
 DkJp48UvydmPVuXPlJxahIb8U5gseHpIlXYl/QLuaJJBhs5WFy0D56bBUDgEOcNxvG9P+nWjUuw
 30GlWex0wTHPNE/c5gspqJQ4xNaLZ3g8SUxPu8EYOLY62MLDy9nz4V3wkZ0mO/G9F3Nj6CeHwgN
 KWQL5+Gj9lE9v3AIEVXFGu7jAKZJECXIccY7aNcgcQruHCFu73XGDXDtORtaEdfgdYFoojHG9Bk
 tsuR7xJy
X-Proofpoint-ORIG-GUID: 3PmyJ0XiyPlCxrHw_Ta7Xm-It0llcGPI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090003

On 8/10/25 5:37 PM, Luca Weiss wrote:
> Follow the Devicetree Sources Coding Style and sort the pinctrl nodes by
> the pins property. This makes it simpler to add new pinctrl states in
> the future.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


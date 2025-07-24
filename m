Return-Path: <linux-kernel+bounces-744259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E8EB10A37
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C29C16C41E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBEA2D131D;
	Thu, 24 Jul 2025 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AAO0QJrN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0312D12EE
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360244; cv=none; b=nNwwhzHMh1wOiTNR9wN6arBc3I/4xre9jGTQNqD5J/30qY8yXR30ysUQwdmj+8lG/qTTb0I82Qlr5LU/7dFPDe0IW6UQ6zGeagMasvxcawnqk65L3+6NPbsaE0S4VhWDOkIVMwcGoSI6RnAed6+LbhYcq7lYKrFpdIjgbOnxgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360244; c=relaxed/simple;
	bh=VjN6lbJbyHpAweB3RWq9GB2CLDrf935zwW4/aLCMId8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZ14ooSYPSoCMKkpsVN7YXeTOaBWlajn8pL1/CIg7bgdFKlTfzMVjOJtV7NWm6Ly5iif4NR4DnIRDm8JeblQnDonmFzoIjoKJ/65aW6j9ESFBxWpmWS3eDD8Q0rubLiuuNp6dlvrucxGVOEQ0/79/UQnEcq2OacEubH0kK5CMcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AAO0QJrN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9gfnu001684
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZPo/Ix4t9i2gm3mSTVtuTKh3mZMxwYpbauxF/Ix+DHk=; b=AAO0QJrNJO5XKt75
	BE4FV6zHQtVErkXSh3ORhRsbtCdaX2aDKQ0MvhG/4AkdB6WtHaUeSo+kdXjgQkoD
	/fWEiRgKCPhSwu5AfUBzMGgbxiAU7NJFrvwSS5V+30+LVLq6EIrrpnTRRmb2XBJ+
	f46n6UCk+jJvqeOQyeonV+yTvpFOYD/b+4S9rL+kWC7MEUJ6yWo6iRyB+Z4K/OH7
	fJ4ukcKtv0fgBqz/3G/DjeL64UnGWF3bqsJ7GKFxe4I00ADMNYUaVXEWj1GtSSii
	/Bvr+i6RA2iVPQ4JyVfaIVJoUMV3TiC5rus+Vzpg0cs0ldQK1i9Q1q9jeQSBI87U
	/1UHNA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1uf9km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:30:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e33e133f42so28325185a.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753360240; x=1753965040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPo/Ix4t9i2gm3mSTVtuTKh3mZMxwYpbauxF/Ix+DHk=;
        b=ckjxQdfBwYep9peSvUh4ZT36YyPbL4sHJahGSqTIs81Pd5QcGYy4llP6w11tOCYY1R
         FVs4hg/JTBKsuF7qPcah6b8i+PAqynhs75kAqPUiN9CYIf2U3ltjNVL0nVrCnEwERtg/
         u/wVHAW5SD4m7V2sFOrom43KsOzGqP9J2IKZy01PQadvUNmJ7oZhLeUFLnkEOw0tPwCk
         Pv/SvXUGHo4b+M1JU0zu6e1MJ4hO4PU0UNGJLbOrMQXggtzCHyCo77LrlLX1FDNEiXe3
         YLDXn/JHOFQ/rYHB3ftwbNchb2bxAJS66lgmc6Clp4Ah9dupRCN+kmLlrwL3jurrEmCd
         t7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVN6RZ0ZhGf5AO6FhwZIXfdgPVdjTsaf7yqK3IWg4nUhh+o0lpnylJ8y5sEpZ8ftZ7TB8+s+qwwZcdrO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcNodIXyrNhkDwzR+bsJmPdlgAm+IuzJFgXTGytgXl6FQz1Cqf
	5bmeXHh3FBsfeMeOxRmgmBxEq96fgEygtAJD/iAJeD89lB9PShIl8rHb655Evf947gbTMn8+7SQ
	vnj5bRR48XWmFYdxrzS10mCT4zRM33CrXOH+yemw7AyP0ntKcSFTgsf45J+VlMBTOyB8=
X-Gm-Gg: ASbGncsujBTaYcjwBtDOXI0fYBKNJBO5SmM4zufyIFgW5wevj97gYWEX7WYLqAK8AF+
	58RjO/yo1m8cdfO8T2fFoirlmnbO1soQMPFVPi9P394s3QAIMxQ37mhU/Rl/x+Plfwl5/hWuxT1
	PvsAhbVEdoT19FI0+qaFuxOZs2hV9NoqzYER3QWOToxxWGdJ4CuE6VlTxEi4GgdbfWCHdLWwl3x
	yeQj4eEoAqCYUuxonhn98yCWyBEDAns+bN4xq+/d7NcEn6sKCtjkduTh9vicO/W/ERxUZbq2TR1
	cuKqtL4FGFenj+ABL+un7xK2WOdnCzUA52K8PQy8C0+EYu9DJjnpVIgknjaUIwwRFkXrI4TZVB9
	aElyH9uC2xIH9n6fapA==
X-Received: by 2002:a05:620a:9633:b0:7e3:3029:44c with SMTP id af79cd13be357-7e62a112c00mr308565785a.7.1753360239341;
        Thu, 24 Jul 2025 05:30:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4hC5mZlym8Ol+EKXuySdjS2BLHVDFr6pVPZuR+2k3WOI8gV0/mpW3MuNGzlmCf3tCkTQPQg==
X-Received: by 2002:a05:620a:9633:b0:7e3:3029:44c with SMTP id af79cd13be357-7e62a112c00mr308563385a.7.1753360238812;
        Thu, 24 Jul 2025 05:30:38 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47fa4bc8fsm104236366b.114.2025.07.24.05.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 05:30:38 -0700 (PDT)
Message-ID: <860eb914-201f-4ccf-93e3-95596bb73730@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 14:30:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sc7180-acer-aspire1: drop
 deprecated DP supplies
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250724-move-edp-endpoints-v1-0-6ca569812838@oss.qualcomm.com>
 <20250724-move-edp-endpoints-v1-5-6ca569812838@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250724-move-edp-endpoints-v1-5-6ca569812838@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=68822771 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=As10ZbdmuqajYgUSL9YA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5NCBTYWx0ZWRfX1WJH7oaWxPzv
 eZjw/PF92xfozTjppMDMUSPx0HuZFLADgp/oP3crdJmR6CRqi2SERE60RZLXoHR7Q8PDpVO1ayY
 FJW+Xy4RK7rr8cQCDuKwAawrzqdcdw0XceHZ+5k+TfhNl37TdhK2qXYymHemYWI4UoOEzv6bheQ
 vmK0hrpWsuKuyXy84zxSWGBtKKJsk9x2+1u7BMs1j+0PW6JfprAnplpFGNgWD0NZ2jpJJUkofk5
 mezJU3CdxG5bgwxcDvLN7FeupSp2t6J/Oy0LLdPROo3xeuh+UpqkW78rPKk1O2f6Z0KKW0wF/s6
 T6XzpSDJz8jMcWU4olt+dnWWSpbQejrZvaw3fo+sLjri4CSwbjt3MpY4UqlCYetyRp5/ZVgC8h2
 hlipUfbwXtYpQSJCkqwEP9vcEKR8PmBPDg4zPimH57vNb9tZ+SXAat2vdcwawvpP4GKs/xk9
X-Proofpoint-ORIG-GUID: 6-KLBsUiBYvRB0ny1euzEB3HF5vEi7Wy
X-Proofpoint-GUID: 6-KLBsUiBYvRB0ny1euzEB3HF5vEi7Wy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=634 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240094

On 7/24/25 2:23 PM, Dmitry Baryshkov wrote:
> DP supplies were migrated to the corresponding DP PHY. Drop them from
> the DP controller node.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


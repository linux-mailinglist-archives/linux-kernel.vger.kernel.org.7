Return-Path: <linux-kernel+bounces-796391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3AAB3FFD4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644601B22006
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1311D30DD24;
	Tue,  2 Sep 2025 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eeyr4qBs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4D62FFDD4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815102; cv=none; b=WfdtYHEe2BFSPR6vW/npaAa3LKmuQXQZTK4u8JqjQHICZ1WevgurAsWszaQVYqFlpM+d+fDZkcEUXDaw8y5i6ICDLaO/nH+KcmcNOP8cAwB+8djfgSA0LQMeE9KjQQ6ULMUNnyhIFPTN6UwTmdlcpiv6G04RPHOXzxc7CuM3iwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815102; c=relaxed/simple;
	bh=VKPh/ct5Q5m08hxDCp/EDthmOiS6ucPULO1VHGN1G3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjjSFeIXWTjG2pzrBu5aCN5CSSFbhT4NvVgCAl7ElOBqrZF+kOlzZcCBr4zo6nSSnMCfyW9Ae2vATX+AXmVgQdUIRUxlw0ra2XGKyoDsF6m58cdByCe6AxTdl2sj0dQcmAFPikCP9nJkMQJlfJI7m+IhjHZZdIN+gYy/e7Y0v44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eeyr4qBs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582BAXST030605
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 12:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R9+3e9dP2WaVs0y05qgMULMfCunUKyox0pXutflnw2s=; b=eeyr4qBskZ6+frZT
	07ReQadFBKOtqTEhsmyQ9kul7fEYeJO+8J+mQQrnwuO9rQRVpNFrYaAe64uu/GEo
	6/5vGMmjfknMejSA6PujLNvCS6EFRzRGKZqestEKJJa/sn9048M+hHwnRTOFHwAy
	E6Er00oehkoLqYqQ7+xhusvQpk9CZjTw2AxrXLBpj7XC57NlJtCG3EUpc+wzZGWl
	UvM1H/10mMCF6qEEBcDTql2UJQtV8v4MUJ0si0QCTMQcphEJy8Egtbsj8tmbJyh0
	ZGoavm0dRVgWfvUM70fAqplEaWxM/mMs1p5punMdgb1qB9AIRCyAf0tLumVPfaFP
	sw1wtQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8qp7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:11:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b2967fd196so16300831cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815098; x=1757419898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9+3e9dP2WaVs0y05qgMULMfCunUKyox0pXutflnw2s=;
        b=swypkNJ72vphb5IoowrURSHIkmE6o+acArUFdam9knog/8Y8cQWPKCvkHIlkk0boyY
         P7Ee5onru8lpzIr/gjHlEUd66asyOPiXm1scnJpURDb06ErFZYnyKlyJcu7K+0E2j1dq
         Ao6ZTzdTS6pjJSSlOzz7k0BvadgFL5QiCcONPED58oyddy7eVLjsOysX3UK2I2Zpn+nt
         qRK6+xDXOlRBZRq33ZA0GPaHrv1/tcxHB73xIbkBCn+UywciGndAgKkDyOMKt6y6KbnT
         QV0jcc6gusLd4V15VxI2Y/PQBMjiIU0cFMKz9j7rCp3pZYi6e3FwJcbbHkrH+XbvoRWz
         OjYw==
X-Forwarded-Encrypted: i=1; AJvYcCWrefKMimgVVt18yvZCkbIOyeld3gDHkYLdksmQ81Psg9j0cUxSM5CGweZCp6w/xA+9ZXLa7Iw4zdeqzfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVvHIVyxUkhb9bZUIrA0jcNd+uNk9nR6SqlvIoxu4TJXNOjuMp
	55nPSMm2Pv4GmS8hrdORvWjkcjxcthNISnSk5LYAqupOLZL/TJyO2BKQJ84J+QsI0lcCjcvS6kK
	vsEjXVRtgBOofDH9H4kHiF+yERo73QLaSxH9P9ssjSMQxC6wN9qE7Hpe6Xj7F4ZzxuGU=
X-Gm-Gg: ASbGncu0D5JcvcdXnjLtBh/6LsymdHDASJOA95DSKqY/YOKVC3B7Ot+8yvJ7NH1Bh/l
	FXjcDqxXC4e4Vvh1CmyMnI9xwBsqilpctbbR3hN9+8wJ4JuFxmNSbDQMyYHdKw8BeFJvxEINgJe
	6PKE0nWfntxG3tPtc94byL9MHlHazBVbBXQwmXTKYYOmkdlElddTNHEOQO0trLaofmrgY7k/pZA
	WxuPS6VwZjQkIKA7NcTrM+xUCa3+bdKMmfyiPRamUj9aLu0Fw7dl0VK2h3D9f6R74+mR4Ip3DJ6
	IxQY7SSPDRXHOxpIFf3b37VPtJE+TMl1MR1L9hCKW+AVNSus2vRBazW6HeICLkDM9yyNtk3Tro8
	/7eLcTayU689JB2K3vtrp6A==
X-Received: by 2002:ac8:5710:0:b0:4ab:723e:fba7 with SMTP id d75a77b69052e-4b313ea00camr114042841cf.7.1756815098020;
        Tue, 02 Sep 2025 05:11:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwW4G4jjkaUKtXkdS+GHMSUK5ZRdAh64PysqQIkVPG7KSVbGILFSKErYbYiYkdMuTYCelzhw==
X-Received: by 2002:ac8:5710:0:b0:4ab:723e:fba7 with SMTP id d75a77b69052e-4b313ea00camr114042341cf.7.1756815097447;
        Tue, 02 Sep 2025 05:11:37 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-affc2fac683sm873825266b.83.2025.09.02.05.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 05:11:36 -0700 (PDT)
Message-ID: <84c48543-815c-44fe-9334-ec1f688e9639@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 14:11:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] clk: qcom: gcc-ipq5424: Add gpll0_out_aux clock
To: Luo Jie <quic_luoj@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
        quic_suruchia@quicinc.com
References: <20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com>
 <20250828-qcom_ipq5424_nsscc-v4-5-cb913b205bcb@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250828-qcom_ipq5424_nsscc-v4-5-cb913b205bcb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LyYi9HoGgeompIpWrsoU_VIDILe31QUd
X-Proofpoint-GUID: LyYi9HoGgeompIpWrsoU_VIDILe31QUd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfXyLAWRyXMKEZB
 Ko0K8wA/CUyUEi7XPCOR3AXvgyVZOMt30Lyq5Z1dw+7JJdV7Wsq7mXvHsBmo+kv8erpfPpuEOjC
 4tYS3cpcP3zyArSklgrG+mCHeyMqsOju4ojeXBegh358U0nUUXgtv/FurtyKz2dU2Ahah2MrIBi
 r5gjqTJZhpylhO6WWV6TyYKAGMHJqiML3gSSGpvQQAfShlY2BOb/t82u7fEcUt7K+HVsV+EGxs3
 yePbTpvipKMnIQtgHm7uSJxiDe4fgf0cqRXGrPuHZJTH4+iFeJfRoh5GUh4GDuhPmtJkxnplT8v
 8KL+o7+4ELQ5idX+JbhbDm4cilAL590KD2Jnvc9m6GeaFocyD0h1b7MzLjBlXXI5lD9bwtvw/ot
 ORpHxnnY
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b6defa cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=xy1T5CxqftMPibTtt60A:9 a=QEXdDO2ut3YA:10 a=jh1YyD438LUA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

On 8/28/25 12:32 PM, Luo Jie wrote:
> The clock gpll0_out_aux acts as the parent clock for some of the NSS
> (Network Subsystem) clocks.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


Return-Path: <linux-kernel+bounces-842742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F60BBD70F
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8D71894464
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3F6269D18;
	Mon,  6 Oct 2025 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BNMVWT1x"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A08267B01
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759742879; cv=none; b=IW2sPZ0jDnhNSMnd44b7OLXjhXNU0Mdohz4SK1pMe9fQYnxQ/VmfsPepMNtIw25kaZpaDmWhCk6kQj2n4jjKI6eqfLiDjnRYLTaa5HYpr2le/dPDbYnPqko1/GkjfY/m6M26rKyQU/USfM4VWJ6QCCSEovRtUpvjFUrGS0cOwd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759742879; c=relaxed/simple;
	bh=QU58PgIDoxyXxvtrv9nIkUTP1aP3Ji5RwiYuSuwuyDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcC+QXbd+RB7yGp1pTxRmKuOSl7aZhCoIjr/SH/s2nT31zOKhlTgjV3l5ZtisFh46uUGuDmPBJBAT1jX3jJki+hHT/RaPS5VcVYqiw0g3AjTkFBVjBsKulZ56uJyE0Qg0PXIkZbnhPax29Il/imOG/NBiZnrjhEjcszaKChBnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BNMVWT1x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595NK1DO012815
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 09:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/pcwlnjS2vmra4LDe4EMuIdtHHOf5Cpr9bJvDe22TZQ=; b=BNMVWT1xSfVjrHr6
	prZKemFBfBPrpPFDPdzuWXdSw/eyvjjkfTuK4EC8BfbYyenDb0KTt4araD0L1j9t
	pTlpG5+WoZtokGsVfQ5tw2Y/mOKz59A3ZRjCfQdUI6jaXjJdcvYyoIygeobayeiO
	9181KHoE0VCsa0eljEi/nfPmUr4T5gmOAjV4p7IDEwwQVcCRyKGeQFJlOzdsajkg
	8az/qTMih45U1obx60ypgShyItRAqI3HITH/Ux8heegdywKkizP4dnk0yQa8hNOL
	ZuVeet7oenEJQJPfT3bT5E19z0cSKhefPipEG9jRw91eBAw5CBRLNCNHseODcqzv
	92N6MA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk6uhka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 09:27:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e0f9bedf1aso15132291cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 02:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759742873; x=1760347673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pcwlnjS2vmra4LDe4EMuIdtHHOf5Cpr9bJvDe22TZQ=;
        b=QVcThKlhLbqdy7nO6ftszbfocwXVk3jAvBMIirgrYAXKB3d3ROGDFFYnRoW1KCplAK
         NgTYL7qRQB9kl2WCEJA5gKtUrQ1Cp5k12AzDsWPQccyPSm59Qj2/W0K52Pg9UAiPipPS
         yU37zX6eEhEBlxzGF1K1+rMB/CGrIncWDlkgptQbNSnhCm1rHGhrjoudTIW0Ck0EA+JE
         wJ2J89yk1lij+FVOltac3p0bHtoDpml+1qSK5tjwGRBIlTNPYZw3UCqHVNLTRDPBxAKS
         IKyVcIq3+qeMUzldymlWjx4F1WPUsTmd3hNyFG5dcqtghLtu4GOZBMVTcXAA6wUUhf4t
         02IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGfWhs8r73xboUwhM0gdM1FZT+mwEg9Mxp7xkFWe93L+SICO77bD95M4Su6vhlGGoTreFGfP3PjJcETa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8j+r7bQiR484mKpNH6GkH962c4XW0fj7hYdx/woH7/b2gWQ2E
	yr1RFaU5HUMgKEoD8a/8yEmlcDZ4V03SMFNs3Z0OG8z4xS0+6j1on4VtC8k7E/bz7sDqmwfv9R5
	2aNUI+QzPdqI/eX3jl0NsxOAx90hKlkYhn8rHiKuBelmoTJ65UReELRCJXNPvi/xCejA=
X-Gm-Gg: ASbGnctUllQlBGTP09KIpC0YA1y6hn/7LGYs5PJW6qlV9kwn7ZM7BjG3V8oTTQ3d2RW
	bx8hczGYEO7Y46RNJKV0t2I+buhwsaxMFRYIFgcOBEtf809DLvIQZtWZlzNAEyqZvfh3R7fuaju
	QPgmbG8BjZVf0mge8ItLlQSiU1u406XHzcdXmueCC/G6GyaLGTutyUq83guO2Yb3PkEGfrIgQwp
	4YFlBgmj0XxPLoXZ3OmF5sPxmqzDDXd6AF0W8fnSx3DIVeurJnllvHNhY+I2h5aCEa7+ODllwue
	BJ6YZlty/ozJdeqcJw1j/rUjVP4qEVdQBZMoKN17ZK+n0HTU3unCHRVL++NYZDZ2EYI28g2RGEf
	1uFINfhaoPd6zWjjwdS+ATCtXUuw=
X-Received: by 2002:ac8:5f91:0:b0:4b5:eaee:1c04 with SMTP id d75a77b69052e-4e576955b55mr107433201cf.0.1759742872914;
        Mon, 06 Oct 2025 02:27:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk+OyISCU/gYVLyFTdyZBlaX8VxXHWghQ/t1CCKjFjUKk15AZPAUHnnfYB9omxMiCPUC3/Ww==
X-Received: by 2002:ac8:5f91:0:b0:4b5:eaee:1c04 with SMTP id d75a77b69052e-4e576955b55mr107433051cf.0.1759742872419;
        Mon, 06 Oct 2025 02:27:52 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4f1d1sm1089257366b.71.2025.10.06.02.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 02:27:51 -0700 (PDT)
Message-ID: <4a442f02-405d-4a88-bca9-92233e602653@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 11:27:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8996: add interconnect paths to
 USB2 controller
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Yassine Oudjana
 <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
 <20251002-fix-msm8996-icc-v1-2-a36a05d1f869@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251002-fix-msm8996-icc-v1-2-a36a05d1f869@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfX0W96YD2VI/sc
 COAuetC4dW/3YNTuuNuhZC+KRAEEikUD8Xhs+El3ekiDtH7/K/aPXHqbKxr5pgHUibq9P11VRTY
 4IvtFc6Uq3wsk2ZTTdIICXDg0q43uUqc7PZ/7e0VSzBR68HmpwPjgfw1zailsA6sXBO6OQ41FdX
 z7gya1DYGE5qiRQe2VStJKNTNi2B0yaQpxz1NH1LemvrJLqpXdkYsLkNGGWxq0+oBbmjAof1de0
 pjx/5mf10NIj5E37ERAZBde9dRoHZ2g+YsMBNmFdiELKrLYf89fRkVgaEYuWX49PBAdyiuAGlRM
 3WDxnShbdkFXnttf/x/NvMgQR398czuu4izf17SbwZUMEGAV4BJSsaLilqf/BFUbw67XKBA+crK
 tpL0gKq0loQsyl8y2AiDBzGL6qRMNw==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e38b99 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=81On53fQ4K8t90Y-VgIA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: AMgHVp_sS1jmvqIIJQmzpYM6bG3Qh5zP
X-Proofpoint-ORIG-GUID: AMgHVp_sS1jmvqIIJQmzpYM6bG3Qh5zP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017

On 10/2/25 10:53 AM, Dmitry Baryshkov wrote:
> Add the missing interconnects to the USB2 host. The Fixes tag points to
> the commit which broke probing of the USB host on that platform.
> 
> Fixes: 130733a10079 ("interconnect: qcom: msm8996: Promote to core_initcall")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> ---
> Note: without the previous patch applying this one can result in the
> kernel stuck at booting because of the EPROBE_DEFER loop. I suggest
> applying them through the same tree in order to make sure that the tree
> is not broken (or using an immutable tag for the icc commit).
> ---

with that ^

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


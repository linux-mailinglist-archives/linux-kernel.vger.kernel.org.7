Return-Path: <linux-kernel+bounces-805361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCD2B4879D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25CE034018F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003852ECD06;
	Mon,  8 Sep 2025 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T6usiIBP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ACA2E7BB5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757321678; cv=none; b=BmnOTf5w5+2y0IXUiIIa4i0pnZZEce80SomF/c4FZzW5vyVSwJCiB2WpbT1Bd0CFYhx8ezR+gJuFo3ddoFlnq8OKGZnZLe4JfDRBeb/Fru7nwkU/yV28yhmfWJHictkxoDK4P6rM4eIzB8yW2GjujZo73VzmwlONWfAA5HSM1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757321678; c=relaxed/simple;
	bh=U/BzMoUvt1p+lrlzfnWM130TYZNT0we5cA8Qr/q5vl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D/eK0zbN43L+yif6B6LSdvOd0jYvmOwZrS/25YsMO8Mn/GVLubGbJF+EJsCHaz6F07JZATTlt+IGcryl/sI1Jut4JIY+jvqkXMUsargiMDvfNKgjnwpy3KTpR0+4iErtPDHSI9WVeJyZcnw6lRVCqFO90UKN2Ik3s6SrulhhTU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T6usiIBP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587L25WG019187
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4hWa8Xzz78GSzXajFVYXPHM0TIhQ9mpklAO6KpkgFcw=; b=T6usiIBP7TwK4R4g
	Fz8v3EI1VV9Y0b7oLQum5vOwmpTctf0cuc4whkRkoQLhy64q1Skfvt3cKBwvRS+p
	RWy521tjysolVY7C+mYSMlAi7VMthHV72Y0XpWdupUJx1Gzbj5xAuCQrxTxrD3to
	baQGyk3dxUBSyWs3lBcgCgjUVND1INNrOIjNXzcOuiJbIkGv8QlRAI1VVTbEnVUo
	rX3t45heLjPRx9hMQgPFCQsAXbKXuIS3nj9TRFWs5U5q+wTG/ogMhAZPoMART6IA
	XZJNfRRW93ZaD8MvzMogGdIskkwO/vPYhIAM09L2BYfhVVLsvKl/0D9phHAvMV0+
	CynHmQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490d1vbwrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:54:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5f76fe6f6so6131021cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757321675; x=1757926475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hWa8Xzz78GSzXajFVYXPHM0TIhQ9mpklAO6KpkgFcw=;
        b=BDK/4Z9DArij4QT6Gou0uQWbOyRdUxKTVWkXSpjY1JKPux7XGoMcmoqaGwFOiPIwA3
         /St0CM1G2yBOoJqUmsXIZFfpvEoKnR0+lAwWXhJFk73UWYRbQZPxgZP59vpi1n+ayZg2
         3f1g+Da/Pmw53Woh4OD4koBWJvGY2uZQiaGQVbTYi+dUZzQYW03SslJrqnYEvt2O6do8
         oBA0NrQjwoFNelaWblHdWImd67arZSD1hQn5vOAhStc9QTnKwLVawiwqCJn3T8wknuTD
         ZbjIZ/jcIAKn/K3jbe1n8T/aDjPpOiqoo+8c+3eUPAHuDJPQEl2EqGpQYrGaoK21GqcD
         LwQg==
X-Forwarded-Encrypted: i=1; AJvYcCW5Yfcmp/1Prk8WqDUTAg1TUQIbztaboa0QP6nkWktC4GnoEdeaLQqlgTzSLYJYF3DSIwQCoaim0fq3tUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUKc5PEJrHXlM/emOmCbTAkrqjNsMonEIv3rQJd8XqcRxF0aW1
	dpW2MSJIZ1tP4tmRmxeizYnzXjohNG/X7LUv+RbeYDOBcBA5mYYDHp/KK8hsBXFwPdlU6LuqBcl
	nIZxdKhvB4T9vpOFOdHo0cAnmOKzlckAOScPoK1WQgyZwKekMML9KYDIS/01hEHdUnww=
X-Gm-Gg: ASbGncup6mOuuH2trLCATGZgjtuujJdONNm9seeBYSk2EzdI0Oj4sC6TZGUmNeElGBH
	7ZnIQSW3tF0ksSesvxqHSNZBUbaaYTq5fr2T+YevCK/UJqbojHANjAGjivOHuML/020hiBrEGPR
	NorpUHrIqLjDV2GiosWzXpeLHvzxPz0b8M5MKT/iEpEEsL9cGxlTj2MnZtobhyidvOf3tHNN68G
	JQV7nMNmwAWxYEPKfrmN0jpfdb0ep4pOSOpQN9X6TwygzEPjpEhOZxYBXyAQPdnoSEAHhHLujBn
	uHb1TkIMNVo/NCsehEtzEQboJtlBZv/nioG5mP47BxiECwrYUywl/cz1ByTJQHMPS/ssK8Zuv1M
	LAciqlnTF0XZ0E0rP0dpUYQ==
X-Received: by 2002:ac8:5ac4:0:b0:4b5:f7fe:4e25 with SMTP id d75a77b69052e-4b5f856938fmr48023171cf.12.1757321675116;
        Mon, 08 Sep 2025 01:54:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK5LFVgwRRvjtMNlYZC6Trbu+B1dQjaVDsf1H2EzED22a4qBEYHJG2Wl2zUnnaD9f3yOvJ0A==
X-Received: by 2002:ac8:5ac4:0:b0:4b5:f7fe:4e25 with SMTP id d75a77b69052e-4b5f856938fmr48022971cf.12.1757321674518;
        Mon, 08 Sep 2025 01:54:34 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b041770913fsm2018216666b.107.2025.09.08.01.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 01:54:34 -0700 (PDT)
Message-ID: <0b3a6bd7-74a8-4a43-b1de-775efcf3d6c8@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 10:54:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: Drop redundant status from
 PMK8550 RTC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250908085331.56478-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250908085331.56478-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nNRq7cCmMoiFBi1wqpoCfASVBIY68LwG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNyBTYWx0ZWRfXwA4uMYql0FNm
 cHFYKrQKMxny0M5S7pXCKBPW1sZOCUGj4UkquCI9+fmeITJ2uaR+bOdMJArMgrIKBWks47IXmPa
 G/X00YHvX4bhENOl43PV1m9Xw4mKtQAPvB3HbBWEPTggBBtFCMFKv74bhEQnKgE++FsVBksqdIz
 TlH2t1a4DPou0xk5BGvy++bNBmdPSkYWKCqDEweYFkF4G6EZLavjPU5IA5TjPlsTVAytEz9gaSD
 mzs8JaY6dr9itg9DVz8n0aNT7rgJEjiES58JEV74cmUjMqnPAQ8AebqM/lhbn86OJSBztOe5OxG
 mm3D3h06MayKi03iD6xVOepBKPKi6/cvwZb4Hy7tc1mT/weIB5slq+scf24yHbmThDaES06lv17
 3dAvLQKa
X-Authority-Analysis: v=2.4 cv=cYXSrmDM c=1 sm=1 tr=0 ts=68be99cb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=v-xH-oZzectvFPV3Ef4A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: nNRq7cCmMoiFBi1wqpoCfASVBIY68LwG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060027

On 9/8/25 10:53 AM, Krzysztof Kozlowski wrote:
> The PMK8550 RTC is always enabled in its DTSI file since
> commit a791fc19965e ("arm64: dts: qcom: pmk8550: always enable RTC PMIC
> device"), so drop redundant status=okay in SM8650 boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


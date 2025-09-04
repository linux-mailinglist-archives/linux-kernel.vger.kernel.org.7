Return-Path: <linux-kernel+bounces-800343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D061B43685
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAAA3AAC78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E7B2DBF48;
	Thu,  4 Sep 2025 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IAaXnSLZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8492D63EF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976595; cv=none; b=So+vo7SJ9OLW27pgYDRII/VAAw5SmN40YPsLmTkhb7pTGirmeqQEMtcqWj4pLhW/ZFFHeLxS0MjRhN/fQk60Apc9gAdrKR804XAPbFirqrDk0riN3gci9KEBUWjGh82ib/Vuhem37mVXSHnH3t/J8jTJcJ+aXRzoP8snvOITtdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976595; c=relaxed/simple;
	bh=PpYWG0Bjw7Xcz83Fr7zQIEJIntOwcuHatKNx6YBA8Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AOZ+qhnPN1+Y21jqkO1lmCVy25w7q1SPJNNVjqVHfOo0PSlZUZ9uiAwmQ7XcYBsbm+K79zTxFlBhWFqU19pVi/qnbRl0CsWwjSdrOkaHLWr3I+F6bGO0WvG58jl2BJRxHu79dnu7co00f2BSHWxFVc7lFAqrOwQqO+J0Ej4KVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IAaXnSLZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5841FwfG005260
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 09:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GOkHmK1X6utHVg6lksjhhYY3cmPafHwC8mul7BxpLiA=; b=IAaXnSLZl73fvOj7
	4OnTx8g28FrJ634V1uzwdIr13148t2fLHCp7NsmGVMQWP27gnLUrc9ECpkDbtIUG
	Q320qjCI9d2lxgnAv6hCV66I4fQPirejPeIUBBGY77EsvS0TOAjJ+t5OhMIHRfx6
	f+mnTiZUNz2nym42n7J0wxgobt7No8fdv6rNPW06brhHXpwxeE/I+2CRHzMq5ZzT
	Pj5EjPCJaE2TZVwCQGm6GPVp8oBnTkbOmgXMR5N47poN1rTkS3m+xapmEr/+MG3h
	A/X+ftgvnRYjWQZTEeewL1/m8niYhOgCQnQyrlQJ/Z/IopkRbN2mcedycnRoVgxS
	lcRh1g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjpukb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:03:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b3387c826eso3177341cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756976592; x=1757581392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOkHmK1X6utHVg6lksjhhYY3cmPafHwC8mul7BxpLiA=;
        b=a6z6Ax+IOX2er9P5VWgjBZcFA0Ph34ymUYU9loLir2vXdlI5QsG3P3AJepjOR8HW8n
         FUtdSPXlFzYrhc3y1qPech9SSezstBhVzwV6sWRoAJtPzs94NQ7D+EzJd13dSyriydWk
         +htvYRsZ1ve9oAR9vv9epBWFjux5RBlftQ7KjmNvDmJgGiA+JyFXgMT0AbFekfA9kScO
         Z3dT6h/6Rcq7MC+V7bCxKnfo2RrbhmJdCsCIWwoTREJ4gzNDooGYn4R1f/dUF1nDRyrh
         SxDTpaGKNeqgSUrckXBzrAyDuuDwnaTPSA/RUXkj1vMUwkzKEqONd7/FWwpWCC/0rC9p
         PvnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVseiMHUTJutGQgddLm22pmRQF79OHi8FV2pkGl2WxoM4NZIsnP2pmTPvlVFjDvHi2sASKKnk0G4E0EDo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwecwCJpWx8bmc12M1MUk5P4D8/ZQt8WnVZvK78TJKEtV/xk+TT
	Sxx+vyaxq2CvJm4UmLpWSDa/jo7TmHm94ob+Qa2lcYtBpCsIKpxKmin2At6osim3Hy4AgNCE+UE
	g3a4I7Yxc8SzH6kbOdWUmqh2Mgm86t4FZIxq3keFG581m4mNM38uElRBBJqJh1JlEDDfS1ixs9E
	s=
X-Gm-Gg: ASbGncsj34QorcFY7UJWjMI85KKzdcqS1OqjimwKaKqDc1CDClb8Lu3KRPgqBIxltKj
	oFiiMULypKs4mlUxhSqqaWHCUs4Dblfw5n7baCTDh5uGLb7L+hzEEOCD9o9/P5PPlqsUJDc9mQw
	+UFq5iwXjD/sPRdM+kufwXjipiaN6+t4KmhDeISeArFeH+Tqzmy6fFcV1zWgnxesBsi2vlX/IQy
	oIedg/SjBK0vdHAMu7YF4UZue/I+MOE+O4Lb/qnqRwViTa6BzOKbZKL/8bj2YegByuUjwNTuYlD
	yXGHWvkotZ7vr1J2xg0E7H0KDzihTkvYEa/UNVbfoOTgmEZq0v8iyFMbdQe+BQ+jAnosWyzSAKy
	+b6kTrrFDSaCuML+vhxCS1w==
X-Received: by 2002:a05:622a:15c7:b0:4b5:d5d7:ffc7 with SMTP id d75a77b69052e-4b5d5d80f37mr20681361cf.13.1756976592338;
        Thu, 04 Sep 2025 02:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPxfQPnRd4aV7IvxsGAOnP8Ip3eXmSuLZ1CLc+OJVlpcJMCuVjxhIyH9GSvmMLrOySYJM5dw==
X-Received: by 2002:a05:622a:15c7:b0:4b5:d5d7:ffc7 with SMTP id d75a77b69052e-4b5d5d80f37mr20681131cf.13.1756976591919;
        Thu, 04 Sep 2025 02:03:11 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b042c7b3671sm951424866b.42.2025.09.04.02.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 02:03:11 -0700 (PDT)
Message-ID: <fc6a0a18-ea29-4588-83d6-2f162b343177@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 11:03:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: apq8016-sbc: Correct HDMI bridge
 #sound-dai-cells
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904084421.82985-3-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904084421.82985-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b955d1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=y9CducrL600We7hCCaYA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: iN4vVrCzTkI5BV2RnclO-8nciVonYqAl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX2I0N0lul5Epw
 ychKohWZa7AlIrL0vfvnLQthsM91FUhcQzgonItbtXouqn8WWJgOuHsXVHHJz8wREN6uOrXWtSU
 OD77t7KmGFqQQkgB8BpiH2JfXP83rSMgJPkcYjyqthWd7c59fW37cuIIKG5yk6Tv7DL6cTsO6Uu
 WsDCVg/J2Y8xT561w6/P+slbzAuSv0WnNJNFPC9ZFypMFM3yRhqEm4GkzxswopnebBIoimKeGHI
 Bxj8QkHrEC8mexYIHA6ndrvqUjy5BJd8LC6p1i02zhzDHWNI01jXgXceZbvjT4jbQPv1MgXbVF4
 SsDBu+fEnOjG2JR+rZ0An8vCtEgubwEZzLhol6rX4LC65OJkpSRKGYl7rkF3/jvXFqnP7pZvkvR
 yKIuxu9Q
X-Proofpoint-ORIG-GUID: iN4vVrCzTkI5BV2RnclO-8nciVonYqAl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

On 9/4/25 10:44 AM, Krzysztof Kozlowski wrote:
> HDMI bridge has only one sound DAI and bindings already expect that
> (dtbs_check):
> 
>   apq8016-sbc.dtb: bridge@39 (adi,adv7533): #sound-dai-cells: 0 was expected
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


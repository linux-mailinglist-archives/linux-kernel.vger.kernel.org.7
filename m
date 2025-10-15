Return-Path: <linux-kernel+bounces-855243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B996BE0974
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E1EB4FA45D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D859E1FF1B4;
	Wed, 15 Oct 2025 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZO1rvamY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B08C1F1537
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559111; cv=none; b=EpZFBU+N4FbgglbxnotVy6K6WCvPy4qUv1Vd9SJInNLGBTzdjTpWS6x4s3kDpTzqM65DmaKXCMviBhbQqB5F3RDc+Lk7YboOfwSo35ApY4mzERWwyw1DiyxnB/VL2IE54zlTWxFxhlML++W6pvbGN0ovFEB9aB+gyRDEgoMIX/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559111; c=relaxed/simple;
	bh=I0opz+CeGQaJbyM1X7y67HQeujGm+NLJuBgDD2I95as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AW3+OPOEVaormwvvEcAUi95g9X3gh4umbd8i5UnrrkvujzflSyo4NiEFiPWSORkCl3bs282f39FXRIfUNm62WeN04pqkYalogqLHFir92CseJZplNJw4001Vxp9tiacaDfmJdqSvptcAsyMXurG3tK7h0GS1vd4Dr9ypY7Xnt2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZO1rvamY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FJOg82009135
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=exb6yBmuHXSmt/4SXMu432yt
	OetghtWPekpvezd6Vrw=; b=ZO1rvamYwg18f0WPwn6VX26OO1FtIjCRa47xhdNy
	QpVBKZiN5ouQOmQ1soT062lzccYC1gr0SVWFr/OSgqhp6w+Sf58XuVhNnfuU4k8i
	TctnDxpLyEjSg8XTppPiXNTfcXWau+JLI/s8jGCCyZrR3/L2Jf9/9Fk0Oc2egObW
	Pp9GSHou0wR8r+6t/PSty0qCcG1p7J3UaMSnIf8aWenIrVAGe+8N8B0b3SdDt3iF
	ZyaVoMuQ4oaKnv78vgPOzqRE2jpeQWibf9ZRcACWTrO/Drd1EBrPSE8WVg6QlYbv
	Oaj/ngevdYXKeJPE6XHAQPqcjK4zJ2kPsZkbBxOqNEEQsA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0c5qbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:11:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-78eb8a9d229so884376d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760559107; x=1761163907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exb6yBmuHXSmt/4SXMu432ytOetghtWPekpvezd6Vrw=;
        b=QoYTU0QBYuzILjPVkYNWCHh5BLiXNSt62b7Pi99HQVlF8nBeZIpecUTYJxSE+u0T47
         EYylgKglpd8hhWoks2+VvEL4iuTrXqdtu/Zs0ICKZqq5DMe4+GbYrea5JCfgrXnMRLiE
         b38LCmDCDv7idRYKiorGcduBhS0y8UE7JGhMY9LwGKcn9U5zs1qTgk/Fid91hTu240eA
         Ztde4/7cJJVpBpnC2LDfn1SHsRlmQ6aCgETiC8xQ1FAZyOtLpqGxmotcraIYGgKox04+
         l9It83mT90hvg/8/n9fkXWcpGaP35ra7hnSIaSjFYpN1174fmnlNR1RdNRB9FNT6mHMv
         wK9w==
X-Forwarded-Encrypted: i=1; AJvYcCVwQjb30WHiedUa67NPjEQaAAUBOv3+lnmJ83Vy3O/SzQPpDhA48fYjvKLGa3XJN1G3QPO37gE2RmQob1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbBcyPeNa18np/N4b/NeBari5MJoDzz60jqQMQMobc0KX1AFMr
	S7vM0eEQE2HO9M53PRo3hf34eLBXAhZLvjoolOXvbMdUXdx9/Aol4Iy0tUUxi1vTYNX5LrLKpwP
	JVx0yb6PGQuEE8vrS/zCs/wysOIghDesYE53bE2UAFfrUt6OCHntO8J0dSZzdyJtbcpM=
X-Gm-Gg: ASbGncsodGXBfKgYhBR2XZE5umxOlDABjcLECjs1QOkIBr/0z5Ao8H6cSmayAn9Pi4c
	CeQP87dnyoBlQlWbZD0vChKE6HCsU9bGTJBsdivu7XJDI9KIK/kJNc5erzss4eBezIxkZM4qamM
	orh/gKYabrEzhDGhSPjOSemo44KWQcwSGlVr5mnhtcvb31u59dSeFTYSuv3kAqSCJEr+4ECHJDs
	4dtQEdvgGAKMU/23EibhaKRO7C87PEEyHg+eKJ6XpeOXeIu3yNg/HIQ04uBWGYYKF7OUeUgeo+X
	X6T/cgehZfyXAau8NzcccEaM+dR4mEN3o5g21zG5Du962NwTrPQosuoIEoxuKGrlWA6gzTnonc/
	0GfpRXatT3G4ErzWFXR2HnkXooGB9S/i5QwS6CzLxoKGDF+unNKE+jj76bwEJon9DzqxRheOcha
	ABd3ulgtttxCM=
X-Received: by 2002:ac8:5846:0:b0:4c9:281c:c738 with SMTP id d75a77b69052e-4e6ead7e931mr385840901cf.78.1760559106980;
        Wed, 15 Oct 2025 13:11:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG7Al0sGtJhJb6iB0hBzj/J01P/Wka1A+f1F4J1JuQzoBKoBEfqY/tRt4fwhMeum7s1fBH1g==
X-Received: by 2002:ac8:5846:0:b0:4c9:281c:c738 with SMTP id d75a77b69052e-4e6ead7e931mr385840491cf.78.1760559106494;
        Wed, 15 Oct 2025 13:11:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3764e80f275sm42026941fa.42.2025.10.15.13.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 13:11:45 -0700 (PDT)
Date: Wed, 15 Oct 2025 23:11:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dzmitry Sankouski <dsankouski@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm845-starqltechn: Fix i2c-gpio
 node name
Message-ID: <4dbjpsl7m6uli4dfne7egxnyejj7i6ob2bxueld4yoaak7poi6@7wi4kx7mpm4z>
References: <20251015-topic-starltechn_i2c_gpio-v1-0-6d303184ee87@oss.qualcomm.com>
 <20251015-topic-starltechn_i2c_gpio-v1-1-6d303184ee87@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-topic-starltechn_i2c_gpio-v1-1-6d303184ee87@oss.qualcomm.com>
X-Proofpoint-GUID: YeK94-BO-TLHlmO9-7p6zVKVFgQVelc2
X-Proofpoint-ORIG-GUID: YeK94-BO-TLHlmO9-7p6zVKVFgQVelc2
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68f00004 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=7NL5q4feChWjROO7-XYA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX/ATrHfGZ/NZe
 1mgeENbGg/5dbmElEzGMVTkBdY1zwdfmd4xMDz2cR15mjP7rF+fGL+xuRE/dFTdxhXu4g/kL5A7
 VcNAbQC9Q5KPPB1YxHB9wb2jgNzhaGvXOuCo8GKzlatigR3q12HEubIjlM2P0UnSugnKgSVAUoc
 2GqkAgos3n1FsohaTc3oVpe9ffK2eI7XeuO+jI9fKFVTs8k1DbbCohw7wWOsfzLfb6ALqyIuy9h
 5i4GAVLSjpAxGtl0F12Beb4rk7u+6JFIJ4EoCAdMvNt9ghJjhQxSdXdC48lbNMOSDixEJg8KWtq
 lyV+ChIuRWKGaaafTFg+pD4KmMKWOsN5BSn1G1Z85AAGUQHxAeByZ+e9t03bIcOzSy2NX7BUuaq
 gUdg7f0f+/xTj2U5PBRqrNZjWAjelg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

On Wed, Oct 15, 2025 at 06:32:16PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Fix the following DT checker warning:
> 
> $nodename:0: 'i2c21' does not match '^i2c(@.+|-[a-z0-9]+)?$'
> 
> Fixes: 3a4600448bef ("arm64: dts: qcom: sdm845-starqltechn: add display PMIC")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry


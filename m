Return-Path: <linux-kernel+bounces-842487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CB1BBCD48
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 00:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7AF1893283
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 22:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645D12405F8;
	Sun,  5 Oct 2025 22:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cj9zs/cY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF61E47A8
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759702902; cv=none; b=AooOHQI35sTYLPmCytW9qiy4bTWrllG3j7ICtwrtP0DJBTKGoXbVE5Tp4+vll2Uxyfg2/FhFcrPS+Vube22pSdPN0y3R/phoH9ZD5JgTjhbOoeKPF7n4wovzYFilNBhX5M4SYQugmgxn9FGhrAwGpLl0+EkYtgi5FtKR52G1biM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759702902; c=relaxed/simple;
	bh=nf2JZo8S4O5Si3dpHQAuIbO0dLHifWUIEtNkyGSfUzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMRxOs7rIrDNvowRdldb2ofY+Mx3ec48SjB6bDHsjCRcIzPwjebUmyBVvvtJestl+skHv1eHWcRr7vHcYG18rftMGiphrH6HadYRmzS/HxbQHyc9nugI9LMXYQnwzqap75ALLvD9nNHdyXfuqRKAgfxazsYonp3Qch63m4KTWzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cj9zs/cY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595KbNIB008881
	for <linux-kernel@vger.kernel.org>; Sun, 5 Oct 2025 22:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wseIUBNjEAWHGdAYXjs/JQy7
	HUCRZAe0kBxl/0omv5Y=; b=cj9zs/cYLK1gz6TDRlg+MsgJLNn8q83AaJ+PILqT
	Yb+dWa4LSjAZmbHqzY9OGip0i4n4tW+BnhO4baAso8VEu317OIAsr5hjIpdno67g
	MfIM21jJQioxuzk6NKkle3CU9o0CahTLwqHPjKPH4V1u/H/xqWQyJmTfIMWSSApO
	FUiLVMEDgykVUAdDDutMpYubVpAxuJhB9TvQnSWzgxcTkpD4AJCSYpUflie3Rb6E
	tGvyfa4wfuF1ldtQusdP4pfKmbti9iBs/yeuNY7eiSId2WkqRuree+L/L4kXDdF0
	1GJzRgt3XC0mjP7mW13XMTfMPug310DIpYo62OWDvgVRyQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junu2kcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 22:21:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e1f265b8b5so96588101cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 15:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759702899; x=1760307699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wseIUBNjEAWHGdAYXjs/JQy7HUCRZAe0kBxl/0omv5Y=;
        b=Nt4qxFjR5swiuVfH1t2wrMGxY4DunEw2bGTVwJqoZP2qy2E8a5Mh90vBNs0t5ZR5hX
         y76R9T8VnUJcZ04yDsRlJi2Nyqv1SrM5sO5hkU0Y/iRPB7UzTom/WhZvP9Z2DJiIQv70
         eCVOrhXhFgu3NW/vsZWK9Op61gNb6RX6KCrou+IbCLSvlawx8WDdVUnT8NHJMvZ+oA71
         TlZMFY+CvMWjVfiW0OkDiOij3EmuIBoei3JQWCyafg6EukxXjWNOb2OIozprB8jauDtb
         n7gkGFVlWs7mFy+U6TCMRqvDpeyqMNCoF5tU/4HVtsv4kzFC0gCrYHd2hoK8vaOpvGNf
         jhow==
X-Forwarded-Encrypted: i=1; AJvYcCXQuRZbhd1ERS2Tp2RhX3ruo5kVVPdFJa/eWt6af8Ehi3MqQUFDms1TA5DzP2Cqn53XWcC3XJJ30WPYBHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymd3Bu/QWNkezkrJNA1KYM2t2+wO9ZQAD9YbDiISGaeUtENl9X
	xmYMuXeIm8h1pjjHonX5L55Idp0In2wYHBcafqWOKfVLRbImuyCKJdpiUsO/q5tMrNarGW8O1fU
	4eNl9SL3g37AjuwuNxoVKj3xC4PCD7VVbbCCLaCMZq1pfMvgJziCOW/HcpdkJRJxhYp4=
X-Gm-Gg: ASbGncsgitdINaHZRDQHSotjRhcstX9+xIuvJv0IivT3YtOeYOOTHcONcRd2cWP7dX+
	8RgXpjS2rlRwMHTB1mNLRZtKnYV1Z3M+LrQ3lbHAz4HWuFY+5+I930gdkEoGYokHrhUxEwt5CVq
	LV3UKYhLA1SsnSuDsgu1pEcHZfhJZV6vJx7jjTUaTZX7b+EW3hUMfojxu0ClkdUvQn9/AAvclEy
	XlHyB+y1i7VKnzC3HmXwKJ6IAn48EAyME7peDu7zKsvXx8ulHbvPhRWTgdTnaV35STJToh2zqnA
	F7aaH4g6a+AMW26IHgM5hVbSQk4h/xbSjZlxL4vHv76071jhFbldIWm8y4ApJkoGzUPsWam9zJS
	F10okSZx7SN2/EoEDWkNPo2SEFlfe/Bo3qvweFTb/HYhJ9dbawl0Q02wmeg==
X-Received: by 2002:a05:622a:5c99:b0:4d9:f384:769f with SMTP id d75a77b69052e-4e576a453cdmr143092511cf.12.1759702899356;
        Sun, 05 Oct 2025 15:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNXUGPhpIT34KBgwecemNjwePmdy8rRffI0B7rY2C77xXUhRnJ64Q5MJFXBA2W2K75wHMmKQ==
X-Received: by 2002:a05:622a:5c99:b0:4d9:f384:769f with SMTP id d75a77b69052e-4e576a453cdmr143092261cf.12.1759702898894;
        Sun, 05 Oct 2025 15:21:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011404a5sm4359025e87.55.2025.10.05.15.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 15:21:37 -0700 (PDT)
Date: Mon, 6 Oct 2025 01:21:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: dt-bindings: arm: qcom: Add Pixel 3
 and 3 XL
Message-ID: <bq3jeaxksk33ntdk32ojsdyh2d3qkglvgj6segtc3acizlkrhm@fvdsccdbuook>
References: <20251005-pixel-3-v1-0-ab8b85f6133f@ixit.cz>
 <20251005-pixel-3-v1-1-ab8b85f6133f@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005-pixel-3-v1-1-ab8b85f6133f@ixit.cz>
X-Proofpoint-ORIG-GUID: 9ftFxxsy_q4pq46wHvJ-TG4A9mUhPiXL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfX4siWL9iVry7y
 6ruWx+ZHmDo7fu8C6uyWRhxDfGqwbAyM3Ao2EsplI5Mg7SZdRS2OBP2oxPfeAEvXuu1/dyT6KaR
 j3iMaclEse672lFgAr/P7uGta/oy4nGf5aSWeK8B1k+aZecRlRa5DVdU1fGXbKIedfKW6k/g34N
 Avz3cfx2EuxN9HzeHF3hr7s1/T0SdoyYuy5vd04orqvbwx5p05C0jWmv7SgphIptCWEK9podwHy
 EydHUoS499j3wtSm1KzO8VZ4XlvcwzFG0ZBxFTGT5Y/M/yRR5Fmj8vweVDk6TlC/Bg3/1/nMroy
 YQwAXLguci3ZCgKcrnF6ZBlgMvuQlltEeO/Ye7S6pDfpeWwznaJcNHQ2eq2jMn/Kyp8EFLauWPG
 eTmKYUl5fxDaH5qlnfkD1sLGW0Fstg==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e2ef74 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=z_xC24y9C4s5lgGYHN0A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 9ftFxxsy_q4pq46wHvJ-TG4A9mUhPiXL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-05_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023

On Sun, Oct 05, 2025 at 03:16:28PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Document the bindings for the Pixel 3 and 3 XL.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index ae43b35565808..2190c5b409748 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -976,9 +976,8 @@ properties:
>  
>        - items:
>            - enum:
> -              - google,cheza
> -              - google,cheza-rev1
> -              - google,cheza-rev2

Why are you removing those?

> +              - google,blueline
> +              - google,crosshatch
>                - lenovo,yoga-c630
>                - lg,judyln
>                - lg,judyp
> 
> -- 
> 2.51.0
> 
> 

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-839694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ED0BB22C2
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 02:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01AD3B7278
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 00:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E202617993;
	Thu,  2 Oct 2025 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CVEd9Hyi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4D534BA41
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759366320; cv=none; b=tvWqvDVuXVh2hzMdZUj+aO7kpKj5UeFkQXzA7UKkR70bz+HWk8OLyHDoY6S8xRXhPOqxb9YmU9oSOatZfTcIwF1pAf+sUuK0jlJeKIqAuyPZmzICwduTUmRTojrhS9xbMC2xPuc5vjBKn+BkXddNUOqWW8P6VHT4VvcrVXOTQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759366320; c=relaxed/simple;
	bh=xXe71YIonX/mx6fgkbEFp8qhQU4Ld2BTPUxSllwc/As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwlkQf3BW5SNxU++OojHBEF4K8JioEKlwNFIa5UUTghoAy+XFmz5j+ak9OGNyy/4fmMoB+mX7ppdeUf65u0t50+hSt3HcN9kS/wuuYgVOPYO6uDBeTCFxVBSMgAyeQqN79sKOv8tcU5qno86T32YnE2xbaE1LXql0qQHZZRRU98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CVEd9Hyi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IbtgZ023327
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 00:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=93heGJe2ZgckPIR8dkGPHK7H
	vBK4psoY2YpacrDOB7M=; b=CVEd9HyiwuMsIJ86DLi1VBtReg2aL5Q6khNwceFp
	pldsTYldByQ3UG/VrXe/rVxR1PzP2/h8hHipiVoMnzyL5ZX4uxRO2z4lIjhbG4A4
	HqLZb3nJEHaR8owB9ZZ+hly4GQISEmT7tQH0OacvJ2j/febF/GmI6lzf1P6x4Y8F
	CNZvWfGLupQuDPcMDmbXiIr9raRtz7M2qL6ZyRvPpZAB3yL8wz1JR2txUTW0rJLU
	bcH2ue97LDR1n91lFerirAgR31qS/r01H2pUmoZVs91OxXeOw+Q9VF/6TNMycbNg
	nWkKf7O/xLvw7YEFOtAQmYau7jZd0BeCxwa9jOlsDnRHBQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a66aah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:51:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ddc5a484c9so11730481cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 17:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759366313; x=1759971113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93heGJe2ZgckPIR8dkGPHK7HvBK4psoY2YpacrDOB7M=;
        b=FPjzMAvbJvn4xUhJLEUE4yeF9TsEvIh045wCa5ZjvVB0Kaq+5IGUT+GJ4agVH43a63
         8lItWbR54c19FFjWZC1joWQ/qB6xKPGb701BQZe2rHKTk1HAz8WT3e5u74cE6WNKzBPC
         VvuOc+pAwxaQkVDl05jGEz/M1u9B8hLVuyn1Mz63MrsQPpyRyCAP4QzbY1iHTXCYXXSz
         6STDpuTY5BcfvFu9XELdbjgY+iPtw0IALC332ANJ/BQGiOiXDDfyd98Q7hMCHdgDqust
         ag/1sxvmYdNJS/IOu0Ij6ApIRhoiysEZpHHXjyH0vQNayVLoqb9nU3vRAljfWGORVstb
         sH6A==
X-Forwarded-Encrypted: i=1; AJvYcCVA9hJv202adr1SWViHnFMF0Bav0Auk3s43ABJtinWjCbe+pYiwPrG/sHdVPYJP/Md33VXP9AtzOMnKaN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ekw3iG0r/oDOSFDYQ5seQTACi5unv1CQFtv734D+2vg4pYE2
	NkYZZY/4Wb1CppIi4CsBL+zoMLZlsYIcrhMn0t00Wq+qOSucuJsAlH2KMQqno8GBYqOqfC87TIb
	+T5TUWGSZDPfZ8AV8emCxCJ+78KaWgd+iqV/dEptu+6owF0/6JjJXL7UbPBFjpDktB5o=
X-Gm-Gg: ASbGncseEBUjLJfWrVV/LKj/6EQE9OzWmcq7Kcj2Kri7WEvFzaDZr5k/5qMk9Qav1aY
	mAc1HbZkPXKQEPvlBDhSI9KSzwyI0E9yniu2NnmFrccz/DYfrudSokhOrSNy++GvzFnvd1fG2hz
	CeB24UANRydt1NIxO1O0TOLBUn5FZElhbv5RSD6DwWXzB7EB0mPuf1Dh55PWFc3qXuhe18Fg+xz
	NTWldU2w4nXiVjWunAuQxy5d6uAXTrnqLfSziEduw4375om/gsf+8ZETyIap/Sd8pXtHWRaxMM9
	zupF1/pTxPBKgQlQcY/U02V7TSTWMVfx7Su+A6c8WVbgDrl1i5luvzTTlZlTFu5xy4mUFdntfbS
	qyKjLfeQklsbMh8Tvnn/WXliidrBgCb/J3j31f3sbGvLxzGcAdzr/00OXrg==
X-Received: by 2002:a05:622a:54e:b0:4dd:e207:fd0 with SMTP id d75a77b69052e-4e41ed0256bmr72706181cf.74.1759366312934;
        Wed, 01 Oct 2025 17:51:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXI3nWOwvyiG/7c7UPYGB+PIhFFGHfgFBcRu47k8DhIj/7J/AoI8j88xAGAc2I79bW1Uyxcg==
X-Received: by 2002:a05:622a:54e:b0:4dd:e207:fd0 with SMTP id d75a77b69052e-4e41ed0256bmr72706041cf.74.1759366312534;
        Wed, 01 Oct 2025 17:51:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01124a05sm342036e87.16.2025.10.01.17.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 17:51:50 -0700 (PDT)
Date: Thu, 2 Oct 2025 03:51:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/3] pinctrl: qcom: spmi-gpio: add support for
 {LV_VIN2, MV_VIN3}_CLK subtypes
Message-ID: <tkbhfudaa6oxo2ox6l76vixcznfohwmditqj7nsc2zdb3rxqkp@lgubwu7j6v77>
References: <20250924-glymur-pinctrl-driver-v2-0-11bef014a778@oss.qualcomm.com>
 <20250924-glymur-pinctrl-driver-v2-3-11bef014a778@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-glymur-pinctrl-driver-v2-3-11bef014a778@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68ddcca9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=_mxtXHsW1hB_9kt006IA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: OsiC_X8SmhkL86YJplbz4yVW4ey2zSJS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX3GRtF84XX3dX
 pSCzvRkDaaIPwrsIsy94zTbS3cHW7/43VVPf97KTzz9MuVSyPAL6Rai8j7/9QX6scTSzVU+4l+9
 5Oz7jBh18B71KNa7A/P9lIvqhVaYniw6w+kptGrACSukU/8XGdB5roAQuJJBj5yE9joSyYspMi7
 f4khjKh/Ed353osA6xrDk3vdiwxv9xjKIp2FdCtgIHQJ9p/zVWSD5EBonAoCq74B2Y/u42ciuum
 Wvd/RVkJ+HxR4fj5Ylhy1499M1JWsI1PJOdEqjW9wdMAHsmB8P7HJYjhknLkHR+bc+lMfhRPDkw
 gbSfj1Us/H0hsIJpnNnfDXb1jctC8eodAIHxTMPKT1klOucnmS45k6LVglVurofOhpgYS/W+JD9
 b/7ONFv3nYWO0xZfp/LVFTa2ayxbhA==
X-Proofpoint-ORIG-GUID: OsiC_X8SmhkL86YJplbz4yVW4ey2zSJS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

On Wed, Sep 24, 2025 at 10:31:04PM +0530, Kamal Wadhwa wrote:
> From: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>
> 
> Add support for SPMI PMIC GPIO subtypes GPIO_LV_VIN2_CLK and
> GPIO_MV_VIN3_CLK.

Nit: Please describe why, not what. What is the difference from the
existing subtypes?

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> 
> Signed-off-by: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> ---
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

-- 
With best wishes
Dmitry


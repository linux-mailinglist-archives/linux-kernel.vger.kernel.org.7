Return-Path: <linux-kernel+bounces-826071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9994B8D741
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEA63A9C00
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AD9245006;
	Sun, 21 Sep 2025 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JP5+TcYP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD8B239E8A
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758441896; cv=none; b=t+XhR+upOAavKOMTyfJHI+XWeNrSKnMhhaOJlkR38GFK492Uc130giYlZ+DsfVGWsnlzITUY1ITtD3Bgqo4oQ1rFsE/GMOOdmNvWznFbH+A/DNb83zRlkIZlr4p/7ruULJGDtIh50dLH0pyIAc0PJTCv5flmaBsgkQ/L1cRbrqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758441896; c=relaxed/simple;
	bh=WSnEXLeKHrRXxvgOkBIhVPDjW8GLL9YPyvl91reKnRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRLJpFSn4Mv+2R/aRMynOa+uPyenhNda8OdSDdUXcO8NFwhYRI0CWK47gEAlZ+E93SLPjKOM0b05mAqU0qs/zZfCKm0/5JtyFy8J+aihJv7ipcbEsXmetzyh6t52TSjiyt6GkDpH9NSuCTowXukJMMnhg5sxbvt3sXdL0GjOCfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JP5+TcYP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L5GnP4028518
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 08:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XEAbnHbHFmi3/gfqNWQjGriA
	bFrVzrvYQPzuEkN3rt4=; b=JP5+TcYPY6LzluEkFZbKFYhH25r6O2ijmcUFHJqu
	M1XaHtBxXz/f4rf/R3LFiZgy8BYi/ZIwcUORGkEUiJ4JT1nN4H+L/Zfu/g1b5m2Z
	owh6KojNfdA3aHiWVHQH3aNwvVaeExap3LbiqkjN0smy2Q7HGgqYprr8dQeDsHIR
	LH1EEa9+S6q/zZXp2/8+RX9jab6DXM7BEMmg1QaqEIIAPCZR3HQ+Q2sKMQvcA331
	Um0RTMTZtjIg5Kc1izKZYpzPhOkuqyYv5KNAWfh58tPc2ARyEyNenpTyYVj3mGdw
	jHewL9n+uFcCVyIGW5To6sVv9UkZ8jY2KY/9TLEFhp7n0w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyej4bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 08:04:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b60d5eca3aso84727481cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 01:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758441892; x=1759046692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEAbnHbHFmi3/gfqNWQjGriAbFrVzrvYQPzuEkN3rt4=;
        b=efWFnJs09YdX3ojhEptBo4gld7R3zydhGS3qw90OFABYj0SH4YNmaBmX7lAoWBbSgp
         f33cZlclSjSc0wkGqWplb48bYtGp4OR10tUP4qD9qBhDipH84aY1739evPNhew1LQxLN
         37kd5sgS1YKWQhKIKM6rqKA0Gr3NqLuM0NeiWacoql+OvJdIcR3s87+0YmbzG1WcuS8l
         qTW+rmavPpNsipgCh7YYBcxh6iT2Tnwlw3pdSUg1164RpU6Q0uytPjnvZmmbyPtMXBKm
         nf9ahDf6FOaqzRGU4FdChWbUr6MptljY/XkOgjpGgh65STvoIL8NT9IReFDH5FVB+4aq
         D9sg==
X-Forwarded-Encrypted: i=1; AJvYcCXcbtSUeTCooqlHO0nvqcOyjaoqqS2IV1WBy4tuzdnQ9ThFOD2fVXLIvGzqUPMmQtYGjY49kEg69H9r4aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbWGuGaPaMqgHsb+ZyTZSBtp+M6YVfyughUcXDCsqU4dYEnN1W
	f2A8baLp+nL5q6UuhkhtKdQKP40/QlKBwW+MLdNEv7jCCjjchWkYwjmQ8a0XCbNVHKH0REALWcS
	sMkbOsIVVc+wYNE+yZc2KLNsjAkmh59iw4PCBWcnR+aH0BJ5tV4+m6W/ApGJJchZl+lg=
X-Gm-Gg: ASbGncv4F9zEQBR6eiAchfzB52rSV0/lf7s12Do7+mMwqQvkpG5h+3D0uilUoOcCuIR
	/Esycjz/ms/jXPYtk2vG2N7SWP7kQebYIuQsPa/vqeilWtvMlbaMIGnqCH3p/mekf7FQpxMN1NO
	5Y8QUdlaK9TPFPDVMhbSVIvLvkuJwaVQRZGfmlgdVwhUXw1T6fYT4yxFxLT5ev9ixrIS5eZpyQG
	YZ5W55d1RdpN3IZ8vAg++/ChonE7ZDi5ExvDaxNBE7GYaajoXho8MENbyKFrtPtelx5u7v0pNpK
	hrrEifF9UT3QApz4TVlGUZMVoarJTyOInKxt24Sz7MntJ/7DfV1Yhzddzu/6+5xSACVZHmmEIKo
	UxW06bM0Q3440JNmKv9g7AzSiN+4zLs1imgWFi1b/xnjs5pTnfGwm
X-Received: by 2002:a05:622a:4119:b0:4b3:4c51:6436 with SMTP id d75a77b69052e-4c06f07dacfmr109908801cf.35.1758441891704;
        Sun, 21 Sep 2025 01:04:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ2B20lb1PcP9AA7tQ7PqdyejHFWWWwxoSKhwLsPdsUWH2uJIeWVjvdVYTP8xVh+qWatH8wg==
X-Received: by 2002:a05:622a:4119:b0:4b3:4c51:6436 with SMTP id d75a77b69052e-4c06f07dacfmr109908621cf.35.1758441891250;
        Sun, 21 Sep 2025 01:04:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a904b961sm21573731fa.40.2025.09.21.01.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 01:04:49 -0700 (PDT)
Date: Sun, 21 Sep 2025 11:04:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Heidelberg <david@ixit.cz>, Max Shevchenko <wctrl@proton.me>,
        Rudraksha Gupta <guptarud@gmail.com>, Shinjo Park <peremen@gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom: msm8960: rename msmgpio node
 to tlmm
Message-ID: <le3zymkfrocgkzb3pldezhndricja7xpg3pj4xcpmt6ngnvuam@he3a44gnvuoj>
References: <20250921-msm8960-sdcard-dtbindings-v1-1-5a2455a30a06@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921-msm8960-sdcard-dtbindings-v1-1-5a2455a30a06@smankusors.com>
X-Proofpoint-GUID: rPwmjiHH8WyBoxvknwuSFKJ2UY5SIIzy
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68cfb1a5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=wxLWbCv9AAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=mZIXpXDClypwcOwN9UcA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX6kx6Nenlaf4K
 9UeF188ug6CqcwdCQDDkxTGyzo0hZ/fpFa+fbYm/+l1LFelhFcXJ8g2Ge6JQUyreiLX2tnnEBsU
 Ein7T/5qo1PyI1r8oBOtSD3npS6fGYIFncs9SrNeRxUfs8wl9XbTohIJgMmXbhajaFKUm9P/End
 cN0VupJ5hryVk66Qrb2jlrKVxBNrYpM8Hb0Mi2RPZADkU9K/pmPHRdc1+NwG560bQfeGL0IGoug
 EbtLwyg2d6bcKnEcuSftbUx2VeC2T5qJw7Gbem6+ff+hJkIINWHDRG/5YCfjo2qemxnzwodRIgg
 WktZW6Tz71HY93DgvxxRchVBgWmDyq9QIO7uoiOZmh7v5aWSWHE9FDUtEvFLOPiPcpSHysxJIwP
 Tb0UiSnx
X-Proofpoint-ORIG-GUID: rPwmjiHH8WyBoxvknwuSFKJ2UY5SIIzy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

On Sun, Sep 21, 2025 at 03:25:59AM +0000, Antony Kurniawan Soemardi wrote:
> Rename the GPIO controller node from "msmgpio" to "tlmm" to match the
> convention used by other Qualcomm SoCs.
> 
> Suggested-by: Shinjo Park <peremen@gmail.com>
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---
> This patch was originally part of msm8960 cleanup series [1], but as
> Bjorn pointed out, dt-bindings live in a different subsystem and should
> be submitted independently.
> 
> [1] https://lore.kernel.org/all/20250915-msm8960-reorder-v1-5-84cadcd7c6e3@smankusors.com/
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


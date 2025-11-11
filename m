Return-Path: <linux-kernel+bounces-895115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B5EC4CF8D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FCA4500CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E1833B6DE;
	Tue, 11 Nov 2025 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TdJkDDDG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UNwbKGXB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF1F315D44
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855792; cv=none; b=S33ptSF96eXTWJfyvpZ/dUzy5v0f+HaRLNDXwoS6yR9QVMxNUN9H3JcpW0sTOWV0G1aNBUVBtoDRtKZYiVRpVKznaHTT7QA7YBYZiazMspVISfyYCkaTgQHIJwSB+VR1begZFN9TIipf+cbMgiDze2gnutnrfAk3N+UPASz+6nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855792; c=relaxed/simple;
	bh=7ap3Nb2h2Hgjoxh0bjtgij4Jlz6ESlkqT8LpdYSlYQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRbtuyqC3kMrXF1IJPwsTbP8rsiC+I4+A6jH6gEHOU3iCgWGlSx1KFhnWTlgU7et/RLhK3p1JT/y0rNS/rlHhm8X5qm/WR8wDUfTjVL3W4A53xhqaRvlcNO6O7iTtawyjcgJRxs3kT4QROH6KinZgOmFn8XfAoIfupwDuPMgcBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TdJkDDDG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UNwbKGXB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB9X24R1000527
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bMA7zEZG1mT9i3/f72DuynQG
	/e/UEMOqhR1I59QZTdM=; b=TdJkDDDGwjv/RGOnMK9zGkfQKE4qbkHUFU99nrWB
	XZ0JeYDCUCsC0LkXnXJtozxwLAH5Rycm2LFPM+2tSHQR1lgaFweFef+UyKqJAWl7
	drFJoCiDElUwG6GHc9Xur9zGP2XVld4I6yer7Qm77DXXgQyzibcvqsrIai84ipam
	VUJrkOu+O7P+rkV92JngAvRbhUXGhdoPqWOIu/6DFUGr2nyRAC7jokaE9HuOZSZn
	nwTRNlYAmyOP61/eJUjlb5ae+zuAKBxOBr0xF0L67XYweWzo/sA1TYv8VqTsD2EO
	uVc22OFrkR1RQ3wHa4TN3fX0TIMsNzlgik+LitvUnUnzDg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abvhth87g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:09:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed79dd4a47so113154061cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762855788; x=1763460588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bMA7zEZG1mT9i3/f72DuynQG/e/UEMOqhR1I59QZTdM=;
        b=UNwbKGXBKy3qn8fhB4FFwwH8mrhNScI0ocG9jAzWDS5s99sVRj8u2YzhbInUgbOrmu
         RO5EILf9c61Dw4gck+GH1jIEMf/xvlbgPFAojPBdER1y+Pc6HyBeNnJIgV+oyfXtZnN8
         7VO4fE5OEDcH4Rzph+SvX1u93eDBfXWeBo+X+UIhDPkSF+diQ/GVnBJfKL+zNAJ3oZLh
         Ovns7i6lcruSYczG2IrhxtuvZzeo1+wn8t8flePW4mDrwE887IYaaymQ5+wlJVmPdmrH
         lL1a7lEgAlwWSFI+EwzRSo4mP7uOWtY+eF6eiP6atD8C2ax9i6d7VFOTAmASQW0zVbj2
         O6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762855788; x=1763460588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMA7zEZG1mT9i3/f72DuynQG/e/UEMOqhR1I59QZTdM=;
        b=SrECywusPcO1C0ndTQl8LAxxAoViUFOaDJNWXKAkZzXxY/Hlm0idtTN7pMILt77ZXI
         1O61HYkSfqUg8clPt8drwjb6yQZk5gLPnQJya64ufwfVwURr1HnvRxuehMwTfhVY2XIS
         EvmNgM8gBKz4n+NVCpqTdupUH6YHR7mImT7c2R7Nfg/pIlG6iV3/55sWIH0QaE0a8Hgp
         +PeNlgrheB2skbHR+znvTDhExH72XtRg+JwpWH8BVA8WuVkcl3fsWracVJ2bF34fVO10
         SaZt9RV0HrWslXVI4KVoPoGlv2WG54YJtTdfcTfGchk8I8VfL7pSkk6XD1I5UJEJbiE+
         SKUg==
X-Forwarded-Encrypted: i=1; AJvYcCU/W5X1ligEFKwd6n2VQBVZv7pSZAOU2g4/KGK8/WXCeH0h4eHzqzXHz4asiQ7aWjJRAGPwQ67G/eS0tvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPiCfsuQ/nunQKyUlBeqlg+OsI3v00pjMUce2y6IihzMVHby9
	kSKWtS+4np8Q9zmc6rhm4ROcUb9on1Jtn2qhZavUfNbSSlrSt1OO0P8YkehRAJXP2xYEteJszxn
	PjgQvf1QEAj+H983qQXZMiJH8ckMmggMfIsni4Z0nIGp2vswR6Ja7IibVt9ZseYnx49k=
X-Gm-Gg: ASbGncvi+qHlOWcuDrK1ogVPZuxJ/V/5kd5138t+eFrNEhDJnlk5ZessVhbzEapwb9t
	DzG1S+lZjL9b0ZnvNGmXp7b4zSK9dmWTdbQtovzgBjiwk29WCc4PQy9Z66vvMA5n5ilLoNZsKhi
	mol97NG78Os4wGyHV6Piq+jpU2TU1t7qlvMJnGnBaHluKTes/iW61gZ+1/RHgDwLQsbQq+U0ffR
	3xUDAigEz9DMmurCdbhLuzdCZl8kLbOAAWBLZeGvlLQ0oR7Py7tw256zI1dmvBRLThKoDpxJ/iM
	PyygsJnx/3GH21MI7J0AbOcE9p4nvwgkKD0BIIXmkTL+CmHtVzXsAqPZCEtvheHHO76+w5VGzh8
	TA4OOXh7O+uKtMfMYJ1RaYhJjtMXPFVJ0Slm6DX69jbYQmL/mYyScULbayL9uqEbOdqXsqtScha
	QjGlS6Tvenavoc
X-Received: by 2002:ac8:5887:0:b0:4e8:b446:c023 with SMTP id d75a77b69052e-4eda4f8fcc4mr161512451cf.49.1762855788105;
        Tue, 11 Nov 2025 02:09:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAdk5oeg2zuFx9VElgiOts5cm9SgeGDvLPbWKRyigR2FtP38RcPIC2MNQfRTRKNLR+ZTXWkA==
X-Received: by 2002:ac8:5887:0:b0:4e8:b446:c023 with SMTP id d75a77b69052e-4eda4f8fcc4mr161512261cf.49.1762855787664;
        Tue, 11 Nov 2025 02:09:47 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a013bd8sm4864093e87.1.2025.11.11.02.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:09:45 -0800 (PST)
Date: Tue, 11 Nov 2025 12:09:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] soc: qcom: mdt_loader: merge __qcom_mdt_load() and
 qcom_mdt_load_no_init()
Message-ID: <6zfnpcq5jjgv7yiukb2df7nzdznrqyzl52frjtksfjjrkasjjf@skzdei3k7eeq>
References: <20251111-mdt-loader-cleanup-v1-0-71afee094dce@gmail.com>
 <20251111-mdt-loader-cleanup-v1-1-71afee094dce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111-mdt-loader-cleanup-v1-1-71afee094dce@gmail.com>
X-Proofpoint-GUID: BvRjFpJrAHWxX3QZ8yzw2hnimCDnEMuD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA3OSBTYWx0ZWRfX2ZqnerCZfbFv
 lQJx42MiUJ3ZkOALHWE359ttn4y+5nxXLR6SDJcAA04EGnEmEWk18XXmLtD0uzTqSj0g8zwOP4Y
 GsayZgNlaX1OuWy7VeSwPIagxaMbG/eUzEJPPjfkiE3RXB8WUbm81qaO74OyOl2MqdlWqm3KnIX
 5gYPQBqamJdeta132xDxlx2VJEWOj1AuFqGVSJtc+0jD2V8tbai+kmk2Chf2PFOnnNUilvzCIvO
 EDAIP1F0hyZBQAF/4itgE0qhmO1zr2MQofq22wrfWrazow56roDfhQsCZe5k8c2PRUrcrDK26IA
 5ZNFDOYDj7XJ9Bj0Sn6qu3yoeL9Sh+AFdDiIth/8Qdg4qx3ZT8Qfl7+FMlcNugdTcD3JyxIQI15
 D4EMfiglcSgRZYYSISPzSfjAWkQPMA==
X-Proofpoint-ORIG-GUID: BvRjFpJrAHWxX3QZ8yzw2hnimCDnEMuD
X-Authority-Analysis: v=2.4 cv=d4b4CBjE c=1 sm=1 tr=0 ts=69130b6d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=X5wZVq-fp_SQTXckX84A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110079

On Tue, Nov 11, 2025 at 08:40:10AM +0100, Gabor Juhos wrote:
> The qcom_mdt_load_no_init() function is just a simple wrapper around
> of __qcom_mdt_load(). Since commit 0daf35da397b ("soc: qcom: mdt_loader:
> Remove pas id parameter") both functions are using the same type of
> parameters and providing the same functionality.
> 
> Keeping two functions for the same purpose is superfluous, so rename
> the __qcom_mdt_load() function to qcom_mdt_load_no_init() and remove
> the wrapper.
> 
> No functional changes.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/soc/qcom/mdt_loader.c | 46 ++++++++++++++++++-------------------------
>  1 file changed, 19 insertions(+), 27 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


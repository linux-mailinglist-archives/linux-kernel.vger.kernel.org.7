Return-Path: <linux-kernel+bounces-845867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A50BC65E0
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6696C4E68ED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13222C0264;
	Wed,  8 Oct 2025 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PosQepT/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB72264D5
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759949716; cv=none; b=Skfy3zS4XlG0niZbMxOjbRXjKKBrU75No/OqQXQtADKhZxCY9hXwcCuDhjBF+7cgY/J9/JYoY5BMYf6Y84c8s1rKDVbB+3QK/8P9L9TsMX7vm8V7VKGD8oxuBXP7LUJk5XdTquWSB7yl0/izdZttdRXg6DOiIMq6r/Vi3DK9LbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759949716; c=relaxed/simple;
	bh=ZxrlyTdwXDKR/t7OEC5AFlsR5I/rwKK3nNq0HeWo8vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L81nxTwqryXDWePBT4531VyvxE8o/N4/R2q2pzv7GPbgT6+tMmAxLcqrPscyYS5u9qXvFi6rJJe9JjQ5MeMP3MHi3TcrYmfO1YYZUooHAbUVPzhDKunupQdITg2SyGBMHZbPmYWlevrYfDLXJbmV+3F8bbjaIVk9XID77+N8ctg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PosQepT/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5Ks0014334
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 18:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mxyhPRUmhe/CrZF5HttE0O7N
	aGBvDw13y3Fi6fBQnc4=; b=PosQepT/S5rU4yfEhPtpH1p53u69S6YbcJf7bauA
	9Gvp7DrWHjg4DYqj7CXedXg2wv0af9G8bvpzIs+AC9xoSpO4lMNdGYIpIVllFv9R
	jfWHcclwfdYEHmGrrXW+to+r1oxPlbfJ0qbQ25Yvan+0d+EwvxJNkYUryL4F3RMn
	zI5juMVuIiUTfjKPntYzkZXXZ8NQ8mWJPReh2dC0c4O1UiDd0JDDsdUDVRu6z5wL
	yvSJtbi0S95nk1H/HSmP5LqI5MOqFulhMIuPRmU6mKKH2kwLoqaBapi6HMiBg2J1
	CbuntreYl1m8erGOIcK43bvguN+A5AnYcKvshFWSBLX68Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u0a1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:55:13 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-797ab35807eso9713426d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759949712; x=1760554512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxyhPRUmhe/CrZF5HttE0O7NaGBvDw13y3Fi6fBQnc4=;
        b=YirODCo4vpGdPixh1aBXHiE6F/GOM4/hY/+VyV8IlM/NLNOgeWqJM9oFAUxxd+mYl9
         eLx+cmTWVistyOp1rX4KpIHswsOYBKEw2XxVi3QZBdjmeRlIzHZJOyYcSuaDwNkQZSHH
         xoxLRq2iHzcOhOMkJbz7nzFiU+PZ4q2l5U0emT3kgwZ9Ku5QIogCIdhk7953PDX/JfiM
         hfmz3fLIodZk9U6uX7hG5qF37XhvmLysIFGpwbJxruzUROimtrl0qowaoYu9i/FDXAV9
         DGLmx0tDlEjNXbBNM/ch5L/7vchK6g9rqXBX14ezy87crTF0eHSbEGcDacgCC/a1xPDe
         5ifQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8wTLomNHk6Ptp7S31/Buezuqrv8gRCCGxpZP4jQbsmVc6vmiwDfBumpZZx3WOb594kTl9hjFITK0dX94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi5VJbOVRq9r42X5H2zvQmys05ngy92JGVgKZtKOD+UBTAeFX8
	uKUoPdPQGiCQyoOwyQEnsxB1hQiLJKUuxK5hjOOATnF9kDF9Dh3OLfDvTclF12BSBtkFigox5z0
	0//iX6ZuX1EYtocd5RRtUeL7kQ+hStAALZxn3L4bD+8SHJRY7PB4hD8ummIjCLUTuGuw=
X-Gm-Gg: ASbGncsVN9R7fxx5tsyChgruwpeQlJJX0OuVq30rRAmQG1iMCkT2rE+ODOYcOh/Tme2
	u238G1zf2R9BSsKkaiV8dqwgSIagOmYnz+6nvJz4H2XTlMgAePdOGbV322AzdaSRgbprdTGi3Ct
	YlZurUrsZ0lB55xRZ49DhT7zSBvVjz3+vT+/8H87vaBXSOXyZdQrFF/qZKKA6jGXC7keqUdhV8j
	mpZhh5NDJrQmFS2gc1pFNCmS0QJXDAjpCXX5jm28xlxasAs9/qHo6uxaRrg6RzoS13JGarSaOUi
	9iRyN7mPDzvgXdKjZxCH5tT1PTVj3NeGSIJD3GPHBiIJwM90upCPooSRp3+lxmo2l/PuBDaCdH1
	Xp3JfFxMyv6r+3BlcT1ZHG8VgL4bE+yzRyfnmHH0Z9Im1FVFVEoCcYbdZiw==
X-Received: by 2002:a05:622a:554:b0:4df:d1e5:47ac with SMTP id d75a77b69052e-4e6ead07cadmr64588611cf.22.1759949712554;
        Wed, 08 Oct 2025 11:55:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9LU9w3HFmxqx8RGYdyppa1AO62f614MGbbNlcjJhmzBLRZN9Y8nGtrhlv25Odt++2usG2IQ==
X-Received: by 2002:a05:622a:554:b0:4df:d1e5:47ac with SMTP id d75a77b69052e-4e6ead07cadmr64588301cf.22.1759949712079;
        Wed, 08 Oct 2025 11:55:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907ad9e03csm252110e87.83.2025.10.08.11.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 11:55:10 -0700 (PDT)
Date: Wed, 8 Oct 2025 21:55:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: David Heidelberg <david@ixit.cz>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] arm64: dts: qcom: sdm845-oneplus-fajita: Use the
 freshly introduced driver
Message-ID: <pdiqqujrhzvkvv2gx3nhvh2y5jddulcfmhdv3sthlnmn4gsl7p@mj4omp3qxusd>
References: <20251008-s6e3fc2x01-v2-0-21eca1d5c289@ixit.cz>
 <20251008-s6e3fc2x01-v2-3-21eca1d5c289@ixit.cz>
 <visvxwdwh2mcympwre6kx7xesvsysdjw6j33kewwibzfbgrbsi@dkcilnw7gk7c>
 <17b5977b-d0e6-4027-98f9-171b9e18b1bc@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17b5977b-d0e6-4027-98f9-171b9e18b1bc@ixit.cz>
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e6b391 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VQwtuX0fJDwWnf3U-QAA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: jtw2N-siF8TaV3HcyUcu4aN6HqSje8oX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX+wtqRSxWlFAJ
 V4pSHUsJTuPg0GF12NV+WDDPnX/nOEUVoq8O6o6lnmU7g5c32H9jMh9YNTXzS9r0URuO1wTwzeA
 sWvxpv1T81+WZUM9YoB+RInJdVxb2rKxSTxlBo/Zlh+NSsCl7BtigsfPHj5a6Wg749c8t7Y+wpH
 Xok/ekxsX4jOKkg391d9RCPJJIob+9/PmRmuJ+65NKVjCQZkmjuWugZQeLQInQ+CG+yLD6HWDhv
 GBWb4aWx80S4sO7ma+x99J5Zla0ctLIANDwwYlcTptuPza/tWLz0cT8C3usz82712zCPKF+rPvR
 9aTjQmlcNbfzmTgoH1UnnDi3v6/05/iBN0rUnUmyvLgu2oRtvnQzNckIK0G4tal93bom5tXpedA
 YiyugkHIOWfxI/nn7fWWP1cMuEVs0g==
X-Proofpoint-ORIG-GUID: jtw2N-siF8TaV3HcyUcu4aN6HqSje8oX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Wed, Oct 08, 2025 at 06:09:19PM +0200, David Heidelberg wrote:
> On 08/10/2025 17:54, Dmitry Baryshkov wrote:
> > On Wed, Oct 08, 2025 at 04:05:30PM +0200, David Heidelberg via B4 Relay wrote:
> > > From: David Heidelberg <david@ixit.cz>
> > > 
> > > Switch from older effort to support different panels within one driver
> > > (which already dropped support for the HW) to the freshly written one.
> > 
> > Please disconnect the driver and the DT description. DT can be used by
> > other instances (U-Boot, OpenBSD, etc.).
> 
> Just to note, there are no users (anywhere) for this compatible.
> 
> Would be the change of the commit wording enough in this case?
> 
> If not, I would then propose to use for OnePlus 6T just an extension as
> 
> compatible = "samsung,s6e3fc2x01-ams641rw", "samsung,s6e3fc2x01";

I like this approach

-- 
With best wishes
Dmitry


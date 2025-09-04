Return-Path: <linux-kernel+bounces-800595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D4BB439A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C8E1C8144F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE442FC881;
	Thu,  4 Sep 2025 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KuIltYMk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DB42EC08B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984409; cv=none; b=FbC5wfUFGZl02nE+17AeRHgNb156++oxrF92dYRcVAbf19M1KMeC5q5HixZo9nDavGGtpq/0QWQXNZNFB9hWlFOcp8+qAtPa9+o0RmnCGId8ejDyHLABroBIzpxKt6E0OFPXI4PMPuh0iba19XFpv0iL+JZgJvTIOvl5yj8GSpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984409; c=relaxed/simple;
	bh=xabmvkkMds2G1ykVMI0iIic3bnlXV5PZ9lhH9NfLEqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UegJdqNouYgIj/j2fMSPRKO+5kXfkoWDQLFemRsDFKIjBHGdR8TaP0LoN7T71N/tewOYhYZAbE5btHIRp26y7Pw1PzDsy1WfHGZiOcJ8bj5NmovmnIp3joc+nsYrobXnagvBvgFXNtsdObBec/wvIp3UUaE6sao48tKbxFUxvFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KuIltYMk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849XClK031853
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 11:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ULLB+9K4Q3rvhisp74Ypegx1
	/bn4JOB/4G9A7ygv2oM=; b=KuIltYMktCNubo/2o/omv44YQH4j5GcBNFkL8lHQ
	bIxcz3Pvwd4uxYp4Pt2tp8nYHNbwotjTMLz+/8WQaFs7554Al8i+7Pw9L9n5Rbhh
	trDCsnQBPYcGKqjg5/XQ/i780Zq+7Kw+9qITMkLl47Pwft3ETM1BLruUMKiulzeJ
	eq6GiBs/CxlBcmA7lxLgvz4uoxk4cW8nKkGX0rMpc+PqlSQ95++IyTth+rMf1prf
	76VweQwvR8+IVPDXfNgoXjNwsvbFteYWv0NrQxIm0D8Oaii+n+lxs/VGYPuGlWV1
	fUr15ce8WE5+5lNX4xkZr9/2h2b9HIlShUx49mFYeQrPvg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw079wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 11:13:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b32fe42b83so14074601cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 04:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756984406; x=1757589206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULLB+9K4Q3rvhisp74Ypegx1/bn4JOB/4G9A7ygv2oM=;
        b=SV5hGocCrahBJnw2e5nsszxK+ubrdhOw+xIHcOBqtwAqcQPRMFbsM8K1sjpliPGgtK
         Yd6Xlhv5Sbx2+3OmIkeMdOTpa6gxgw1X+PpKqNlmo7g/iutv9FffgVVH9Rw4g36UvjXU
         rPzFwd4ERd4mSiNo5Ij4kPXiQG2JN4Q1tCaY6EnA/d35oFNWDhSbyR/fAO16or5Z/A4w
         0c6lnRmuGwBxWu1N+Z0sJNkOukjfa+Ip3UGhXlO7VFBIPwVnn6QLcoKbsmkTIF09E6Rl
         dSWwuuGO2x0KUsR2bYxaInEdB3OYtuDBSWY9jjHJ6mUi4osXm2YhPJ4qlhdrOwF8ArLt
         tipw==
X-Forwarded-Encrypted: i=1; AJvYcCUIFyK3TfNQyRBcP7l5uiWtjgLjqOCaLWpqUQOzjUuuIIIf5qsOnax7n00LvAXxl+3stLTQmGZy9MkvLRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB9b0PbXyCK3OthuoQnnpcrrxfDZbfDLTlTlJg8sIfLjqdFlmH
	Ut7buf2ulQ8qp86CU+hoG/GLJDChqGJJhJ9yESTYwP+kAQrOvFhTc2B9G+ZjGWydp31HAeN1FOp
	yoqswgUPdfFs1Ms32ybgt9UYhaIwx8Q4MkGJlZhfjUxGZHlKXTzDz2QwpWmuHfO7lgUk=
X-Gm-Gg: ASbGncugVStJLI01z6pB+tKOgOQyg1EXQgKyNK1nzxrGCozY215UNcudTXLXHY+6IsL
	aC5pKommlHYO7h6rfwPc4rr+5LpxGrYBPZPWCszOYPwd/8crssm3zEnf7sQZOXQ5Zc9FWxFT45B
	GLKmukPYswXiw77Bs1mO3hE5iFj3caOmPXnJiT2WwNTJ2M2X5ei3Wf416olXV0m7uOJy+w11St/
	U5EoEhDLv1b40T4Nj1/ycFJ7tfYDnt7pQil8LX+l540GanvBUi2v7L3MChkMHPhHLiw5Ny++GLV
	ScbZ8nBeuJlmvF4gkGWuOhjbmmfP2KrXIkI8w8KdqbgCmqi+MhvyPO5sShgEdDsQkPpcTARflVr
	AOFr8xgaZ3Xo044VFCVJKWUMVuYzF9bs90qg3aY7hHqEJek06PzoR
X-Received: by 2002:a05:622a:3d0:b0:4b0:8e2e:fd9b with SMTP id d75a77b69052e-4b31d841b8bmr206347081cf.28.1756984406486;
        Thu, 04 Sep 2025 04:13:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExtpn8wmXH1fQWP57ni7jX6R0VHwMOxVbasxblzi9W2aBLMBFT18vMVRsZUaHpRFJcGl1jqQ==
X-Received: by 2002:a05:622a:3d0:b0:4b0:8e2e:fd9b with SMTP id d75a77b69052e-4b31d841b8bmr206346731cf.28.1756984406044;
        Thu, 04 Sep 2025 04:13:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad0718fsm1116900e87.112.2025.09.04.04.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 04:13:25 -0700 (PDT)
Date: Thu, 4 Sep 2025 14:13:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Abel Vesa <abel.vesa@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>, Johan Hovold <johan@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] phy: qcom-qmp: qserdes-com: Add some more v8
 register offsets
Message-ID: <6nhnerb5yooodw73ku6yxtp7ud3irwhfwd5zxjwcwbws2q5y4x@7fj7dck2cv3a>
References: <20250904-phy-qcom-edp-add-glymur-support-v1-0-e83c6b9a145b@linaro.org>
 <20250904-phy-qcom-edp-add-glymur-support-v1-2-e83c6b9a145b@linaro.org>
 <bf5e7ea2-9f0f-4d83-a567-028ffbe184bf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf5e7ea2-9f0f-4d83-a567-028ffbe184bf@oss.qualcomm.com>
X-Proofpoint-GUID: 8mv_077qkTqYu8K_5rxqpl1Qg_uOC82S
X-Proofpoint-ORIG-GUID: 8mv_077qkTqYu8K_5rxqpl1Qg_uOC82S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXzqrPhC4GMaGE
 SWWUc8Ef3Ck5Qt6WAljiT8NUrUpSFDIs9QVahgGpO7ijxKfC8F/kZZN72Zo7mlQ4WRdMXfT9Z21
 OeMmB51a6UK96EPKwVzYBMuwroezZ2aVkDBfvbsBh1RQhPOqqnQpFE2ho3E6D869uSUedU+cMtG
 +2NVqmiPBHVpkywoFi0NwAlxrKmYicckeI4CX6AoPu+0C4LZRkHlfn4ZjuK5lyDayyDW0lrLPZu
 y8CrCP+XP35DF09qXaWbPHyyQnLnbvzQaEYOiXYmS0qEZ6fyjehMQtf9VOK/jw5QzkLnUFiqfED
 WUwm+fSVtTHXAt9T/roiUdDBPL/WaY1TULzkyBHhUL6zn3Il3egAC/QkZuGnO/vJGZ/xMvX5GyT
 GicIZFTz
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b97457 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=YY9QM9cTantD599Z194A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On Thu, Sep 04, 2025 at 12:47:43PM +0200, Konrad Dybcio wrote:
> On 9/4/25 8:55 AM, Abel Vesa wrote:
> > Add the missing v8 register offsets needed by the eDP/DP PHY driver.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> 
> + a couple folks that I talked to about this lately
> 
> Please create a separate header for this, Glymur contains multiple
> "v8"/"v8.x" PHYs that are not identical to one another (or vs ones
> present on different SoCs), even if advertising that revision

Is it about v8 vs v8.xx ?

> 
> It may be a partial match, but there are also stark differences
> 
> Konrad

-- 
With best wishes
Dmitry


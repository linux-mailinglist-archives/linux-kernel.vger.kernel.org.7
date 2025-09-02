Return-Path: <linux-kernel+bounces-796093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128C9B3FBD9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1063D7A63D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0741E2F0687;
	Tue,  2 Sep 2025 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SvgMUzYx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BEF2EF640
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807644; cv=none; b=UV4xg0m+jnDjwDyVFVeKTzWhVYhjEBazYotY8tQljchQLeXrz2K3gCxmvRpLazX1C47lFKKWNvNd2DN95B8Yr8WaPxlYo/amwGYuEILgq2+EHagDDuDU4Yi781e2o++RRaNI3kHPiMeg/bn3T1Jd6+2uQloCJtHuy26QkT/Dn5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807644; c=relaxed/simple;
	bh=SH7iW9GAQZcbs1Y11U+SsJVQU2myZgWlogyzSHF5AvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npr9uYvOhsgz+9r3MX1rIV7GrCqSq9gaIeRGDoCUslk3hj2UBeJyKbA6zB0Ic/Gri+MFxnw+yfVdxxBsvdai3tWQ5AqJC/gh/T8ZUxHoRKu32jTDF+xaD/kdLAOphnwmprhIrMMAvJcMNFQf0yy7lNaQf2A8O50NNgaX3QJJ6cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SvgMUzYx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RtOO012437
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 10:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lioLz+MVb+lNAwEehrq912Az
	AcaUt5myxr/iYapOUHk=; b=SvgMUzYxGKdZZyKPhp1OwR6qTyNBlKhCOywOuZjT
	m2PHwjCOpXk0RstPf8TVPfcw+I8DnE5FYwJH85mR8yL3WAGkdRdBAt3KZ0J8ff0X
	tu3gOSYtQgcwXmwFu0SrG62EqNz9UlkzJ5jZecOdMJeNr/ilnazVs2rJV9HRUKNc
	LB8eLtxrT77Vj0vnUb6rT7ipr51cDfdEQE0OCdCwt8NgFkYzIHN04CImk7Q0JhZ3
	c4mmP3OOpAp3kmW39ju/kvvuC1l6KKP7R/yxAWLWmKESkC3jLmJ5uMCnJ1xh0VFu
	JWmXuHIlQ/SNQsA9nXpYpIB4dIj81gu7jnnGgI7Sjr3pEg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2ffa0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:07:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e86499748cso1413497985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756807640; x=1757412440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lioLz+MVb+lNAwEehrq912AzAcaUt5myxr/iYapOUHk=;
        b=BcR6vXv7gK/6LZLuI0gkGg8l177YY4GlaUeaUci0KGIZzd1tpaPt1Gdq4WkFFRdc/S
         tA27z0qFHnoAEvR6lv+uzU5X+2VcPIJc2pqurstJvhYVcB5XM1Ejgfke4YNW5m+e2WJ9
         q2Mhowa6LVtwcfxWUZzK/C/aJUvpazpuw+pUQB/OfnvNRzlrmHEpctnix7LK1CeE+MtT
         jE5kMQ3kbmsLmZ9ipIS9KFUZ+N6ISrYHCZytyJIVaaZrGjKC5WGlBaWIS8jHrkUx6SJX
         ehoB0KP8e7hP0JHmymun/ZsegSer4s3Exr/37iMwx/uQTx0WeUtMNPTS+mVg7cuSMuDW
         BQSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbC0SDZXu5Xyp1kgkcHXKHJyurZQ+rFpo5ZwS3u7rqrzToONnuWBx/57GPXtdc7cFHHFDU5JwMIswIC70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdMK2oUOyKd+lA8mWxRRZCmkGsZLkptJV+Zpz3WOiM48WjcALq
	IdDhmi3io/imQGkL9d4bW2uilJOPCjMBrZQjj0Kq1FUCNmjtT0ARscnqJqJt4+TgtkmwRITQKiJ
	/J/JzTfGkV1XU82EQqdu1w5J957g/pR7gKZ6K3MR00vTz/Hm3Fs1dLTvRG1BlYBne7f0=
X-Gm-Gg: ASbGncuh/xh/tyivd0PvdJ17P2SmL70kVu2OMUuGECnU4NW6dZLG5ZuLT2xXHIXAPjH
	cxBPuzmi8DL8WKGfwcACjuQgE/4LAh0pbEimJLXvmARyEN68LCIQJhqN7onWmlic+eAFf8+twYN
	f/pkjNxnxs3w/RMQ+8JPbvuU/R6yAPnP2fGdwB1J+AnfLzU3U38rQt7934E2nNzmI9v2WRlYUpn
	BbTdoL8IyiJDCWuD2l93umETWOhxfmwxJaBzR8aQmExblZNBbj/d3lkzcPZCj3J7cZ403PD6yAF
	vpTrMhm1k2wpGNKDT4XDy8BqCUDSYPQqkUCAecml+xnBLs1kXbuL7zaKjpj6Sz1/55WIE81V6b4
	5mrAJN7gG4plVOCPJY7dBOA0gk/2BwbG6PgAb26G1l+VVetsAFOZ8
X-Received: by 2002:a05:6214:1d01:b0:70e:782e:b259 with SMTP id 6a1803df08f44-70fa99552edmr115899456d6.26.1756807640299;
        Tue, 02 Sep 2025 03:07:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgdoQnMA6U5z0bGZ7Wuiih/B4hBhoB6kk4Yipx1tsvtcSQs2cJZx7DcWOnC6cpn/6Cs6Hvdw==
X-Received: by 2002:a05:6214:1d01:b0:70e:782e:b259 with SMTP id 6a1803df08f44-70fa99552edmr115898976d6.26.1756807639672;
        Tue, 02 Sep 2025 03:07:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c50317sm3922901fa.2.2025.09.02.03.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 03:07:18 -0700 (PDT)
Date: Tue, 2 Sep 2025 13:07:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>, Mahadevan <quic_mahap@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 8/9] arm64: dts: qcom: sm6350: correct DP
 compatibility strings
Message-ID: <37ax7uhzopemvmz5fgtayzz3hmnxmfcbyjhwgfgkdglynuo5oj@fud24vsqodnj>
References: <20250829-dp_mst_bindings-v7-0-2b268a43917b@oss.qualcomm.com>
 <20250829-dp_mst_bindings-v7-8-2b268a43917b@oss.qualcomm.com>
 <20250901-defiant-illegal-marmot-7ce0db@kuoka>
 <abkkn4f7uca6tzjasltyysxecuuirxxvbjz6l6re5v4z6jlmuh@ugz6jtw6vo4n>
 <ddd0f518-f9e1-49e8-bbaf-b810adcd35b3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd0f518-f9e1-49e8-bbaf-b810adcd35b3@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX2ON05SYe+sdg
 8k1RFcZ14DkTFauGMyW3k63qZ189J1Z8xJI3UNQRX9ePL8u8d4NSGDTTB7kU+kG72Dqc8X5Q9VI
 Ilt7xDN+ouNH+MF0Wphbt2m77EJUqku48hvcJu0yDbGvW5qh3mqQrdafmAv/bRf6P4KDWChJgjB
 ZWrqZab51zluLn8Cu0892OkOULwani5eG9w8MN7o35Unx+T8RKqwPtneTv8knNYQuM3CoHaASoU
 RyzItGTBhbfLL9Z8+GzBPrfMGSDqqXqPAe6G2OyHm3pLUPASESlCQG/I7wS+TSAWNmvh3A8yMSH
 8ICi9/ehLq0e1s3zpMivZt5ntZZZA6SO9UOd/JoW6aCaW/l7gN7GlSmjKruDnxYzuvDbM5Nmc9H
 Zu+xFY9A
X-Proofpoint-ORIG-GUID: i7Od2uM8L2jBZpT8gilB_Y3osDKRz7FT
X-Proofpoint-GUID: i7Od2uM8L2jBZpT8gilB_Y3osDKRz7FT
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b6c1d9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=1RLsJLrTPffC7TqSMS0A:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

On Tue, Sep 02, 2025 at 08:07:22AM +0200, Krzysztof Kozlowski wrote:
> On 02/09/2025 06:04, Dmitry Baryshkov wrote:
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> >>> index 2493b9611dcb675f4c33794ecc0ee9e8823e24d4..8459b27cacc72a4827a2e289e669163ad6250059 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> >>> @@ -2249,7 +2249,7 @@ opp-560000000 {
> >>>  			};
> >>>  
> >>>  			mdss_dp: displayport-controller@ae90000 {
> >>> -				compatible = "qcom,sm6350-dp", "qcom,sm8350-dp";
> >>> +				compatible = "qcom,sm6350-dp", "qcom,sc7180-dp";
> >>
> >> No, that's breaking all the users.
> > 
> > WHy though? Both old and new lines are using fallbacks to bind the
> > driver to the device.
> 
> Kernel has sc7180 fallback, but what if other DTS user does not and that
> other user was relying on sm8350 fallback compatible? That other user
> won't have sm6350 dedicated handling as well.

Oh, a user which has SM8350 support, wants to support SM6350, but
doesn't support SC7180 DP? How hypothetical should be our users?

> 
> That breaking of users I meant.
> 
> With the kernel it should work, assuming SC7180-dp was introduced
> similar time as 8350-dp.

SC7180 DP was introduced several years ahead of SM8350, if my memory
doesn't deceive me.

> 
> Best regards,
> Krzysztof

-- 
With best wishes
Dmitry


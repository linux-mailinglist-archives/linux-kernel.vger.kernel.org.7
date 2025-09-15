Return-Path: <linux-kernel+bounces-816563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD31AB57577
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8359E3ADA01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22662777F2;
	Mon, 15 Sep 2025 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MJGWvMVH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC06D27280E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930593; cv=none; b=pQqK9XURP6mST7NvFGxbCGsyEuWeSA2Zj/zJaPBwQvQW3m6giJ4wKsLJVy2xX3U2Yrk1RLwB9WydxkZV+98rrUluOU2lxJVjGGDpIQwh+ZZJ/25TO30FD2GnU28euoF6AHEKlrHfy8EvoI76gKJU6D7NogbaOcLEqtco/8VzHrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930593; c=relaxed/simple;
	bh=Iw9O6JFABdPImwFcOVaVdVzFNCl9y3X10Z2HGZWgFms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppBy8ChwvWR7S5mrHmPFPKREX4dou5zDLZhBaJOAJIFxahB+w6MWAop39n3oIAi4uCFIyJns20D1FhVXrl/D8qNiDv1ehO5aiiJDZlOt+64508aJ9PfFNGsm/xWKOsoOxM0JaWhQ7EESKsBjkW668mJFaFhn+AccVgTYVf3x60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MJGWvMVH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8Ff0C008243
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iNJb9aBoW8s0FMiS/YZ9p7xI2r8sb0NzpQjCEzw6dyk=; b=MJGWvMVHbgq0zK09
	OJ59VyRCwAkg6z9Y2Z98viKfYf3Aqds+STSfibyZnNaYQWThswgGz+TFMVzyxJHM
	dBvM3QQ50SITB6Vh2CzOsORsyOObN4kDWJYhKtzUPxI8xlXhmcxtIOOa59jKdHuL
	CMi3gNAZLkH72urj5E9BT2aFRZz4CRS7eORsfMCH891HQVQtB8S2kRFbi4lN1vMB
	tOApXXnhh+oDfW5gZNcrHkA05txE8Paqk0dZTkLgKcvNd/bFByZvu/H1TTsXWevI
	D00jWAbr4FAtWPvXUwnKIpAG5ezmvpMB000Q299aevibP7qbxjsxniRhLot0MOhx
	zojXwg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495eqpubbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:03:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b47b4d296eso106980771cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930590; x=1758535390;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNJb9aBoW8s0FMiS/YZ9p7xI2r8sb0NzpQjCEzw6dyk=;
        b=dxZXA6HjfH5qmHbRN3KNWnhFXmNVh9ysKrZ0p0sprgeOocR36pfDVgy/CnPadL9Ae7
         TeQnI5AnF224Ih4GgATAsPaK95y6HSreZJIH8uhUobtayssp/TTWJChQktrc6A27+BQz
         FyobmhtklTTRYiDqBkalbDF+L+k6VtEVQoyLonUZf2vYrRvonajJuqyeG1bTZ68nHrv3
         jIwdW/aqPOsqwn+WXRdtpERaU1dDfjpP6UdlLxTUZaalG6VAv3uUoEHDwIeAx0rxLOVg
         XWo208vSEXGpsgz5KUpeWtPPHp5ZFhYnosTplreXEY/XE94bnn5fBjnb+y5pbXmHCDP5
         lu7w==
X-Forwarded-Encrypted: i=1; AJvYcCW5GeO/k/3kubOd29HoomuMHPCv7jg9A8dVaU3UpSPf0FW2vy92M4NiDrtldZp7DIlBrFYZJ+mrb7GZkgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQhJWEKJppq8PzLVZlJUXYimASzzaD+MDfIZT1IDbhf0GmzKa5
	maujQ4dzZCP8KiyG+GDm+m5/89zUY5wuHYbWhRBmt5eD7HyB6EMeCWUeNCcR9SH3wHXa3SSTMVr
	FeSiCFLkYlIJXmW/pLnl6+Q8V443t4f8D8A8WqM9RqUaxDN0NSzFDzPh0Cq8I0v0tT+E=
X-Gm-Gg: ASbGncuHiYdUDI4Wfn4OvIwo3IztxdRJQt3h7xcctCOAuxIov2SyjPAVZMmNmY+rTGv
	aUxelI06OwndpcoKs6g5PSKiwaYojuNdNKYcs3vW7d1ifbY9ZK8NMPcCboERpAfQem0baltY/IB
	NmxdNCvl6nPTTCD9/PgQZT9qNMbzLnTxa+xfPtbOKQQN2wXOlJdxOIZd33lzW6OqJZSIK0UtO3t
	QXBqc3CMVk84Aw8wAH4o/z19oDAnyvgXCk5jURtFGLdU+C4d4jCzyDvUn0Ty9C361KhqcMsPJ8T
	EDE0fLp+cyA7EJyUkIyMqGwhDRhdwcNKqdhzoesLbiozbnzXA0JFBQNxnERtKWDRtuT8V0qU47J
	8rUMccdetHuZVcg4lsblEVH7vOMlkkWvXCXyIo5jmkgylSg2/6tdt
X-Received: by 2002:a05:622a:120a:b0:4b7:9ae8:6ea6 with SMTP id d75a77b69052e-4b79ae87162mr50917301cf.37.1757930589632;
        Mon, 15 Sep 2025 03:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfpvRgAhMNhUxIeD9tNbprQD/TrxHXCB7JaEsEcvWEvuJOODOSQVkWTR5TtGrU2694pjoctw==
X-Received: by 2002:a05:622a:120a:b0:4b7:9ae8:6ea6 with SMTP id d75a77b69052e-4b79ae87162mr50916841cf.37.1757930589119;
        Mon, 15 Sep 2025 03:03:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571459c1482sm2723638e87.0.2025.09.15.03.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:03:08 -0700 (PDT)
Date: Mon, 15 Sep 2025 13:03:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
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
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
Subject: Re: [PATCH 1/2] dt-bindings: display/msm: dp-controller: Add SM6150
Message-ID: <v3vuphn3n4w6ynpaqeosechjdcelomn53atwfotka7izqvjuid@nnvdwxqlelrp>
References: <20250912-add-dp-controller-support-for-sm6150-v1-0-02b34b7b719d@oss.qualcomm.com>
 <20250912-add-dp-controller-support-for-sm6150-v1-1-02b34b7b719d@oss.qualcomm.com>
 <sx64y6vfov4yag46erckpbl7avwmqlsqt3siebckn76m6jqxjh@f5lueyih6n3q>
 <d3743c52-4e84-4729-9f64-af856419d504@oss.qualcomm.com>
 <droyp5atpjauyttqkwqzk64kkghg6jkkubvfz3zlbrodyzlvoe@fbns762o6vcq>
 <6bb0cbd0-d3b2-4359-a2d0-6b757f66d0e0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bb0cbd0-d3b2-4359-a2d0-6b757f66d0e0@oss.qualcomm.com>
X-Proofpoint-GUID: PinGTtlUz8unVZrC90oOMXJRpX5XBwjM
X-Proofpoint-ORIG-GUID: PinGTtlUz8unVZrC90oOMXJRpX5XBwjM
X-Authority-Analysis: v=2.4 cv=XJIwSRhE c=1 sm=1 tr=0 ts=68c7e45f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=RKHcw_4USbZLBnuPHksA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDE4NiBTYWx0ZWRfX1RvHRlAT9v5T
 gMYlNztV1aT1oZRv62lSn5wpAfw/2r7CZrP2JueWO3S7G/xo+tw0k8u25F9X7QU8N+ZNJedT3Wn
 BGUa7jD05sST83m7fCJxTRMhFezyWCKT+YdRHWaFgpVYUKNt054PF3YegWXc0YOFzNryQvKCJXi
 nwbR+cVL8tHMqiGf+6ylWfaoC0NDjjRmixQNQLulLqt0pbBTXcZxaCnTjEZqIEfIlGGqLoVBS+y
 tssvfZ/iOX2EpJK7PQb4tkUQVz7S5irjJhPxKognUtgD2UHQqJA//osLRt5Ueh+P8tbOvbkFeTa
 C/f/rStvdz/ScRDLkV5nFY/UiJVsk6f+QMhuIHWbKhYbBeyKT1IgekzoT5kkVnFFlIkQF4/eLkF
 Xtu6UmSc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130186

On Mon, Sep 15, 2025 at 02:26:12PM +0800, Xiangxu Yin wrote:
> 
> On 9/12/2025 8:10 PM, Dmitry Baryshkov wrote:
> > On Fri, Sep 12, 2025 at 07:54:31PM +0800, Xiangxu Yin wrote:
> >> On 9/12/2025 7:46 PM, Dmitry Baryshkov wrote:
> >>> On Fri, Sep 12, 2025 at 07:39:16PM +0800, Xiangxu Yin wrote:
> >>>> Add DisplayPort controller for Qualcomm SM6150 SoC.
> >>>> SM6150 shares the same configuration as SM8350, its hardware capabilities
> >>>> differ about HBR3. Explicitly listing it ensures clarity and avoids
> >>>> potential issues if SM8350 support evolves in the future.
> >>> The controller is exactly the same as the one present on SM8150. HBR3 is
> >>> a property of the PHY.
> >>
> >> Ok, will update commit msg.
> > Please red my response again. What does it says to you wrt bindings?
> >
> 
> Yes, SM6150 uses the same DisplayPort controller IP as SM8150. I wasn’t
> previously familiar with how fallback compatibility is defined in the
> bindings. Since SM6150 will be declared as a fallback to sm8350-dp, is it
> fine to drop the driver patch ([2/2])?

Yes

> 
> Here’s the updated commit message for [1/2], does it match your expectation?
> 'SM6150 uses the same controller IP as SM8150. Declare SM6150 as a fallback
> compatible to sm8350-dp for consistency with existing bindings and to ensure
> correct matching and future clarity.'

I'd prefer if we have "qcom,sm6150-dp", "qcom-sm8150-dp",
"qcom-sm8350-dp".

-- 
With best wishes
Dmitry


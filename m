Return-Path: <linux-kernel+bounces-833364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73897BA1C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337577400B4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C642EB863;
	Thu, 25 Sep 2025 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZNA42WuJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D832797B2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758838934; cv=none; b=u7Fr/xPbG2sPSi7JTUQCGrnxOEjm0ngNo6kQffMMS6oc9N38lP2JFCGo1mFhkBsfypLt8LEzCBL9AkvNYECp+c5LJ4hGQD5Zcltre6xw+6jhoCwakmO+24EcUj5wLkwf9tvq90VL/U2MxbP4Z3keQYu5Kgj+WX261UX2q8pjKpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758838934; c=relaxed/simple;
	bh=ONun1yQzvVla6T0V03RRQPf0eFbD8Tp5uZBtGZGC8ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LovvbJdLeEMSwIrF2Rz+9XXLb6YOyUokoN6P8/oRVGHXUEUlhdNDsmDlbsle3+sP02qQFdgS2pZOLZ1O8sRySb97IwQF0RKfi1GJDNAITUnHJ6IDRIYJ3QNC4rl9hqYjxWp7KKsOle0dfsge/2JuKAwYtj/JQzU06r8q4AgH7BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZNA42WuJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPd5N027613
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jRfNzZCnLAcaDWnEKn5/jyR8
	JVxVY0FW7A/2m5ca+aA=; b=ZNA42WuJqPUVqpxupotcXOSumqsGQeqSTS9bIWOT
	CGdDK2bPRKCjKOU28jFPVGSaR0l2q2VAwm4qc5UaMvaj4Raf1iuRJRvHDmvayXsz
	mSyEmWADs103GsYG6UOzNp+qUL4PmHVyDmLYi4fswJJxsXPplAshI0g0azKhoO1/
	/EJqarGPth2iqP5D50/vTFy30MYniSxbs4d3CIV1FXj2uJTfhiZ0Fyp0mD/4bv/S
	SsNkVQWnrx19iDWzDS82A2vKP22k0IQXgflA0Bog1MIFatQPfKQ1aRP5zKJenhEc
	qsl4Q1LMsXztc7W3eE4SKfzxFilm9pZRc/dDuVenWZgSdw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0q0j33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:22:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d7f90350f3so32343341cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758838931; x=1759443731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRfNzZCnLAcaDWnEKn5/jyR8JVxVY0FW7A/2m5ca+aA=;
        b=sOiZVoOgVahkZtwTFFUjnOesKwmAdU8Xqkt4o9FFnt9PcHtCrnTVVrwPB+jXlxIL4u
         1lc3sQmXLB16hYdPJpDKEVCaT1nudrAnPJpwwgbqxY7FfOPnPg8iKFzQoNVvKI5JfPOn
         p5MO+Ap5ULydB7yXcSGgt7QzqxFwGnVCW3EcGifzljdxbOHwZrCTQysZ1qbCwasFcvf6
         dmPt/Jgo8p9wA/XbrWPrIcn3EY6tEIpYNFdxETtZa83333/Bm6tRTwnuoaqb5Nd3F49x
         79Jg/4Z24AQo9VA4w0y2JQp6uFA8R9koj9CZzsmn16A0OqIr1v9xfC1cABAeKF7JABfr
         5FMA==
X-Forwarded-Encrypted: i=1; AJvYcCWCrO4e+tV+kid5PnmM2Y1mNbPbUPeP2/5zt2CybkIvZsANsyHQfQ2payECaFDTmw9T8jpDFWYvYR9UaDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+iuVA3mH97IBQmue97UAsEREbaYa0qyfjWTjYvSjb7T24Zh5
	I2dlI6Iw/Myq5XyU+SoBAYQh4Cp4Eajb7dfMnoPn35mWg2w54x5kRlRMFaQaDKbmJStBNprK12L
	8/dHk4ROlpWgQ9DreuKHFu3e+i5BfHGAfEC2Gzr8/ol6VPq6EtgcUBVCZaol9K/4mdBk=
X-Gm-Gg: ASbGncuSyVZnIUvTT2Wl2+FDuumYXIRbVff5Z2s7xvHWOfYEpCn9ZVMHQIr3f4tZjqR
	/7HBcMvfzHJ08sfjJ1+3J3v3ONZ8OXH+JeFrBtl9Yivnm9yVDI93CgR9OqMfG0EH4WeH0ovBPh0
	iEAFCKylqf9eAJ/OKETQr92I3ov6n2nhlvZkyEWCh/auH8KDwhAOutiHJkaBakKul7hH/0YDoZX
	/h3zY2Vyn8tuJ0dNpGbZyqLzykiRCL+QRY5sHlFGc6NKsCNdyZb/j/w960TQXb05yl4++OMWoL9
	htT40eEFyDrNaxKT3vm3Z1oASU1uP4Zkl+6nElwIkuInvV4MXandQ3zw9BVZVywBNwoDFSyODkd
	yCo1N/kn8FJTQm5LSRItYClu3FHFesuo4wLp6e0kV0JkQ2cx2mbQ5
X-Received: by 2002:a05:622a:4b:b0:4b0:6a6c:c8cf with SMTP id d75a77b69052e-4daca1f78f0mr51621451cf.15.1758838930665;
        Thu, 25 Sep 2025 15:22:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO3r+ySgumuy0R8ZW76Gz42nyn6z1QUTob1YhU0jpfjtecRv5c1wNLaL6B2ApNmXtWNxgQww==
X-Received: by 2002:a05:622a:4b:b0:4b0:6a6c:c8cf with SMTP id d75a77b69052e-4daca1f78f0mr51621141cf.15.1758838930184;
        Thu, 25 Sep 2025 15:22:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316a31df6sm1135993e87.111.2025.09.25.15.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 15:22:09 -0700 (PDT)
Date: Fri, 26 Sep 2025 01:22:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: Fix adjusted mode clock check for 3d
 merge
Message-ID: <g7kqqed625hlz7yq5uwxyimfupxryr2et5jxsrmgw7jk5x5zg7@zdrgqf63n4w5>
References: <20250923-modeclk-fix-v2-1-01fcd0b2465a@oss.qualcomm.com>
 <krinjfouhgak2fvrv4runtv4kbocvfjpwxq6y53no3ajo3ykih@ooucnj5peu7j>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <krinjfouhgak2fvrv4runtv4kbocvfjpwxq6y53no3ajo3ykih@ooucnj5peu7j>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX3+uVQAJCZMn+
 r8PTZe9WJxSbTcVOVd9L0YehjXaveco0xXYuQAJ0hhbddBm60mcW4NV6CHjofUjayIyjpgdwsDc
 XoZnaeY7ew3t0umfp9UPJSq/PgGY3JQLDZoavhUGo5NIJkMt3cmOifDH0ZqGQAd9/C6rM9QjnMM
 wCrVi5xPlAzQUTfNwBMwVhMbZZFfTv8UymD6rqVm7YGE6iPvrDbQ4GhKM2rnaeYogB/jabE/UpB
 nYutnzv0fsFDkxAD1iXbq93P3G0udNk6CXBvuLV8XBM11aW7cUF82TaY1wC2tCg/NfothXgX4bW
 mPF9WaNPaC0jue3A97CdSDIyalmjEf+NGa8igSBBjEMOMmIOcT/WglTOiiYx/VeGNMlZh1a4jZ+
 sl6UIUd2nF2f0rxlCnyIU8lSGB6gnQ==
X-Proofpoint-GUID: ReW6BQmQDAkP2BGifP-hCM487erA8Ate
X-Proofpoint-ORIG-GUID: ReW6BQmQDAkP2BGifP-hCM487erA8Ate
X-Authority-Analysis: v=2.4 cv=JsX8bc4C c=1 sm=1 tr=0 ts=68d5c094 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Nu1Um9oaDxGSo2OYYacA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Thu, Sep 25, 2025 at 09:51:28AM +0300, Abel Vesa wrote:
> On 25-09-23 16:03:50, Jessica Zhang wrote:
> > Since 3D merge allows for larger modes to be supported across 2 layer
> > mixers, filter modes based on adjusted mode clock / 2 when 3d merge is
> > supported.
> > 
> > Reported-by: Abel Vesa <abel.vesa@linaro.org>
> > Fixes: 62b7d6835288 ("drm/msm/dpu: Filter modes based on adjusted mode clock")
> > Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> 
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

Is it also a T-B? ;-)


-- 
With best wishes
Dmitry


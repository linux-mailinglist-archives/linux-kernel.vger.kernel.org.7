Return-Path: <linux-kernel+bounces-871648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5086C0DFB2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91F5D4FD53C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293D82571D7;
	Mon, 27 Oct 2025 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pjh+2Rii"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CDA25B30D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570887; cv=none; b=flULk/XAEt6dWXdjpP88N/pldP7dV+lDn2jKX84jUFZusnz/0Ac0qWiFmzz/AjDICpIASJA0q7u14a4pHJHGz2YgrXw/n5iH2MzhC6p/hDBmch/vyxKQ3z85lqO2SaY5TYXrYXIrXoJIpkIylokswVcB4Yts8zC7DIwNm+7oIQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570887; c=relaxed/simple;
	bh=yurVmvxSOFrWw32vD2Z36RTMlvMH+DXhPVbXI0Zm9yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWNh1cK3LL5xPwLUYsPz+JsXLTCx+77UeG6sJT0J0nvbVU2mLKCvZE6CSnD5rX404z+I8XGhWfLosAj6MWEgpWZgdc+a3TGf67DNLcxwrPLMmw17WfmLD8/70wWi6XVzWbilqqZKD2Lxf2UyyfNF3TJp0P8BIMKN6kmjnpnZcuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pjh+2Rii; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R7Juqh2059256
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nFyzKi5bv7XzhZEu4Cpk+WRY
	5dnAaHHoSnvN/ez9mr0=; b=pjh+2RiiyRIkOe3N+YJqN3TwoEj4CEejkjcAuiqg
	eTNuHP0Os9Sz7E6MkyxZ7yPTKOTbVK6TAJMmFrSCsjvC860dongX6tGYnABRWVzS
	wVYrnEqc9vFYFjjDuuYVIAXx3SVif6ZwmvJZwqvxE86/Q+LwSCYANe3T68ptbJrP
	v9lVlF5LWEBQm6lIWoPKAyuai8LKrkTxNuw7UizS7jBGk/ZKo45otfCbUXpxU3Tx
	gUH9KaOaJxEuNcrJ1+4zX1LQ3jHNlREa7Xz7JO3+5YVL/1GoYjbUcLmhYHDcpiBZ
	Eb1JL06WICkHrog0IZHMk4odthMZx6HQNWiniq32TGyhow==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a248p8yfc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:14:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8916e8d4aso45558221cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761570884; x=1762175684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFyzKi5bv7XzhZEu4Cpk+WRY5dnAaHHoSnvN/ez9mr0=;
        b=ki9oIMS9rOOnDqF6nGa2MWmJbfPH4rxfm5/8cyIWzpnc+xed8Hcfr/hWs5OgqkfFmz
         pLGCn9kZVAu3C2FDpd3Yv4L8kdfL0luvhYjFHSe5+vNyA9fpRVBC9Rt52DtRZ+a8ISb3
         idnTBEA1XkO2NBoVasX0LHV5sCZKCxGmRKjEM2irbY97rIspEETJhlBAqaRybYDcpDLp
         MzX72iokfhkGN0MzI/0vXRwx9NJh0E/L6aglVqxK8Vj9B26xP9S2fXxNZlH3ge1xXGVW
         wqXSp6w6wMA5mM5UePBrsuVlLeWwITAntSGvuHN48fV6pfvpMPUYHtaOruEBl77r2G1C
         rsmg==
X-Forwarded-Encrypted: i=1; AJvYcCXeAOoeWRaFDEjnH5mFALxoCxt8HWU7IP+mbXcklcPSE9c2qrw8wDJg1PvQwR1qnQJmYCJnxgDZW7STUEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9YbNZa3x++E7y8qdNYa2ADVZOnrvxoPKdEqru+IHGNymgrqwe
	PFnwdLfbUrpNyYi96QNlufq//YuRmo+kmSqBCYwRt3fb0cq6o9rTseZJoazwAJh8DGCf5euWKzb
	RNuSzaTZ0sYHGss70A150DTYc2VbC3SHwmgXs9QlpoJ0hOGy+i0AbSPUSNixjCLP2XHk=
X-Gm-Gg: ASbGncvMqWcEpJZf/ee1yd9mwHT5tvR+CuZRkF2WUEhtx9C7upPZpFb6aiGxgE4OwdS
	/pC9aKNnwh2ZAGLvvHuP791CYXSBV+HNv2QAShpiF0NwSfmIST1jEbOuX3DmCcwN9c7ux2RMuVv
	8XdP0vsi0VO+NeWYieZmey7/5kQ+hHITK+TmMbfH9j1e5J6mvl9z36N+Ge3ja4i0c4/nEIUZkH5
	Sn48SiWmQCla2r88KBeHhK2tGDvM7RoicjjqayieuR/Tp2v21EluBnqquWF3HhA1MaCaV7HjLeb
	kNWomOEGSP5KgWLSikDNFqvgnWPUiBHolKucpafji7DMYjK1k13ouhuead+I1rvgCesw9ybZKlI
	zoi5BEg1NypLtBQsev6rs6+5RGP/DyMvNB2Lc/D10+dDmAymaTx45b2Ce57gQTO5oMgsC8nx4X7
	/fiPTYFn6dro1z
X-Received: by 2002:a05:622a:1b28:b0:4ec:ef85:cfbd with SMTP id d75a77b69052e-4ecef85d368mr61632081cf.80.1761570884058;
        Mon, 27 Oct 2025 06:14:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvwWHynaMcFsCoJT3Ymx6akKgKGq+AVYZliRWBvt3fl/sJ+nyNZdGM11CdtSCxGsRp/Z4JPA==
X-Received: by 2002:a05:622a:1b28:b0:4ec:ef85:cfbd with SMTP id d75a77b69052e-4ecef85d368mr61631541cf.80.1761570883540;
        Mon, 27 Oct 2025 06:14:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0a5655sm19154971fa.21.2025.10.27.06.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:14:42 -0700 (PDT)
Date: Mon, 27 Oct 2025 15:14:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yuanjiey <yuanjie.yang@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        robin.clark@oss.qualcomm.com, lumag@kernel.org,
        abhinav.kumar@linux.dev, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 01/12] drm/msm/dsi/phy: Add support for Kaanapali
Message-ID: <einog245dsbqtx3by2cojyzmyctk2fffpwndwoe24puwqq4fta@cu6iiidxqgr4>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-2-yuanjie.yang@oss.qualcomm.com>
 <omlhiywjr46ik6bj2aiutgcf4aifen4vsvtlut7b44ayu4g4vl@zn4u3zkf6cqx>
 <ad906eb5-c08f-4b66-9e37-aaba99889ad4@oss.qualcomm.com>
 <aPryORKIuSwtXpon@yuanjiey.ap.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPryORKIuSwtXpon@yuanjiey.ap.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Zvzg6t7G c=1 sm=1 tr=0 ts=68ff7045 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=ACmnMjwJHZESoQLvWlYA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEyMyBTYWx0ZWRfX1mD4elQqFHHD
 uz3gRnMITb2wOp3leePFBCuaMn95/QA1kPmIeJY0m7U3ogdZhKZupVHitHShGzewjIvrcK/Rffi
 f1GIPXKtOot1CP3VlFMG5DcZ5Fi6uLO+s7xSJN+eXwUBnfDSDMDIaNUN8g/Qk6F/xzbzX/YjCLx
 ksUSD8MwIsVwtOTjUqyoumbhS2Ew0vxYwcvh7asHeR8fDR7sQKZtvc4+rBT1/BRNy1ylXGZ6yc8
 zVoRe8HwXzvfjWxrGRDcUVoMRH4b3zBIxihMnmWTgrhFv/PtWUdw3ms8lj1+ElwgXflgQ8vNEhm
 VB8+nUWbe8LAs0b6YxRgkPuGHYIfCecWZMsDkFHbOunZg5IeLNz6j+R9SQMMpJPT6djGoo6yYya
 P3THgt3ah9+rA92e8lwDb5rBOC2aVg==
X-Proofpoint-ORIG-GUID: 2FymYvs5tW3DjqQIRGSQQu1wEJWXaeYw
X-Proofpoint-GUID: 2FymYvs5tW3DjqQIRGSQQu1wEJWXaeYw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270123

On Fri, Oct 24, 2025 at 11:27:53AM +0800, yuanjiey wrote:
> On Thu, Oct 23, 2025 at 02:02:45PM +0200, Konrad Dybcio wrote:
> > On 10/23/25 1:48 PM, Dmitry Baryshkov wrote:
> > > On Thu, Oct 23, 2025 at 03:53:50PM +0800, yuanjie yang wrote:
> > >> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > >>
> > >> Add DSI PHY support for the Kaanapali platform.
> > >>
> > >> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > >> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > >> ---
> > 
> > [...]
> > 
> > >> +	.io_start = { 0x9ac1000, 0xae97000 },
> > > 
> > > These two addresses are very strange. Would you care to explain? Other
> > > than that there is no difference from SM8750 entry.
> > 
> > They're correct.
> > Although they correspond to DSI_0 and DSI_2..
> > 
> > Yuanjie, none of the DSI patches mention that v2.10.0 is packed with
> > new features. Please provide some more context and how that impacts
> > the hw description.
> 
> Thanks for your reminder.
> 
> Correct here:
> io_start = { 0x9ac1000, 0x9ac4000 }  DSI_Phy0 DSI_phy1
> 
> And v2.10.0 no clearly meaningful changes compared to v2.9.0.
> just some register address change.

Addition of DSI2 is a meaningful change, which needs to be handled both
in the core and in the DSI / DSI PHY drivers.

> 
> Thanks,
> Yuanjie
>  
> > Konrad

-- 
With best wishes
Dmitry


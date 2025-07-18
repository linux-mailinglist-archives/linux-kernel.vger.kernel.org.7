Return-Path: <linux-kernel+bounces-737227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D80B0A97A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFE4A45BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51A22E7181;
	Fri, 18 Jul 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TOjihzHU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610778F24
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859723; cv=none; b=fZahI0jV8AK9Eb8QSLNONttaKA0aGjOPKzL6/s3pEuwdHCnTl9La7gLN7UIvYMI5bKeQ9cD4xQgR6bHtXtdz7RaejVyOVmk/+6ENNk4In9bHj8WpxonQy+lPfVbnYiH1inqo8oMoTs9MIZKEl9/v90lZ4xgJTXhbRXA6vcHgWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859723; c=relaxed/simple;
	bh=tHym/k0wWfQMHYQVdHi5JfPV7kabZ4jWC91jK0udNSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0xWrsLK3h5Bou3apxzHTXc0pwFtwhGukbp+oBFNvf9DKWJKxL6AqaTYBArXNUqqMxowzGWDshtx3VLRr79x0Oz0YdDVJ7hpYVpgg5NcJYVKCT+LRThDeqiMMR/51HoJ78LMYbSwiNF6l6c7MvrNR8SLkXJHQjxDBWW1KNUxZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TOjihzHU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8aD0H021792
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=f6yNaiRLHAcK+6GC8eMfTdPL
	ypI+sKJ1RhRN3e/m+tM=; b=TOjihzHUobpA6dFi1+++Hpb9xgD+bHm3xJHRqLqd
	CV4XWt9vKzLLg51HQ9F+OCmYbxK2s8LfdHOPNyCjtr+1qujPhZivZxfVHGnTjjIl
	OCg6TVvyjhWZvUYXTpjTQy6AnCUtShf8RUcL/+rOxqYWsRRNj6AsyyczA/dT5D2d
	SNEl+EFiynDyIT/mDLsDmGQOhE8CAwmg1hhv5IfU7xzibtcW3chHD4isF52Gqomd
	APa0HuB0GLjFDnwYzvB3859uVjnGpRro63e7kUcI29A+bs7Se991AjQiw6jGc4Uj
	g9fIwhGe8Tt5vJIWUu7P5yCA3kmo+l21eoeKHIlQcDJaDw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu8m8gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:28:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5cd0f8961so424041285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752859720; x=1753464520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6yNaiRLHAcK+6GC8eMfTdPLypI+sKJ1RhRN3e/m+tM=;
        b=F7o7K+GCoz6jIVFB+lg04iaIzDqF0NNHDHd1dkEUXanTBtFSQFtYTkJwXl+LfjEEjS
         O3fHFBAFX0lbRjZ/bDfHwec/A12aeTV3mvTz9zwO4C0JPoAKREaR8Fp7nCSX/EBAKYAK
         PvdPuY96SXZ5pEKtqrpeLXxyrOvhZBypGBJXnFKglFqvUwUW3oW5mZ387EXDIevPoiXA
         DJo/txkFLe6/Q14558CqGrgQ+yq4EFTxyWGv6QweCXQ5flSFfsl9gAj0ngUV0KGpKsGu
         T9I9+BEE/MA7qOPNTgtYg3ZVnqqndHtnPxChsq5e6UQ9yMtNeOwgSeeq8LaKzO/RHhJU
         2ZOg==
X-Forwarded-Encrypted: i=1; AJvYcCWbnULCeCwJqqImwQnph8IqYzz7J2zlXiZFRuulo14ISIwJ3lxc9q05hpZxy2sDH0gMNhtGV5hEHwVKv5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKGDhVNZUuVx4Tb6JdO60DjOLHMI287b/TB9H30s29nc6Q50QO
	D4s/+oPV1AxHfgDsagupjmv8rqEjFdAIDEWd0/ddlxVtZ485vg5VW7dJjMjZkzU3Z4fpROrB1ey
	n6Lyv6omvBJbzv/k1IFnaexR2HxM+U3CKYPC1iuximt7Ur20Ic4SPOM9Tlhqr6s+zRd0=
X-Gm-Gg: ASbGncue3zPzmHPYLx6QoEdCI3AgRIUZdRyCGvCQDBRtnYqCGqfuNeZx3xcQZYyUbyI
	58LowGcspvyjWM4vl0kNmFmUI2VmfVc5kjF2FI0WgI+cGsdD24VhxQcQ4Esyn9pG0Xke55icfl5
	TxM6fMHj8Log6fi+FrKlRFQeA+dTv0i31OBZ6Mow/imNY/xBBIL/dkPO9zE1qaZJ7FpAhlNy0J5
	MX4A1nTMkA/I3gl/Vx/aO1vkyZTq5nOWPD33j+ahUw4Uv1nReG/prSpOWX964oejjOvfymmBK7u
	B2x5nNKmeVu8gRJE+dfmHB1OTXkVR1AxLjTVo6qz5Is+H+278cRQ5oBpEWrpji1n8FGuVnDOO5o
	ONQ0DvZ2Nt6sk1u3CcR3SkTQIH5OBuIrRZlKACDWOTJA1zKGT9q87
X-Received: by 2002:a05:620a:4088:b0:7e1:538d:5c5e with SMTP id af79cd13be357-7e3436253d2mr1626777385a.46.1752859719431;
        Fri, 18 Jul 2025 10:28:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1w3sp9zVGjYWBmgKH917pY8I7F8sCh3F9gp3Q6iMWVLnWjt4QkDQ8fFwWBHnJpBaRVJQW4A==
X-Received: by 2002:a05:620a:4088:b0:7e1:538d:5c5e with SMTP id af79cd13be357-7e3436253d2mr1626770785a.46.1752859718706;
        Fri, 18 Jul 2025 10:28:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31aac76bsm336325e87.68.2025.07.18.10.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 10:28:37 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:28:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/msm: remove extraneous semicolon after a
 statement
Message-ID: <qjvxpdibdt76vvw2capf6mupiuqvjlcevtfl66dkqp634ot2zd@eau52bnkh5ec>
References: <20250718133404.2047673-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718133404.2047673-1-colin.i.king@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzOCBTYWx0ZWRfX6v3R3I1tPqVO
 heWNq5EzRnTpI7tTAymwgJchgkzuCGgcUY9oRmVq6572zjgrKj6YaSM1FX3SYcl3UzyaBCGIG6+
 MNzufpY33SxnS15ycOAwUPSFXE9B6hp1RCBoNuWjVqw+IkMDINWCBk/u6Nq8Pko7/U/7XiFK52s
 ZmZMsq7P8u5Od4cUxf99IIxXK4Ul3EoEQUDvISyADqax/vvRQ09QtAkz6gCtnJekVZaCDpJDOGz
 RFUX+Kr/8nc9nX+7wIjP+OBq1VLfDT/El+0psOYFYhh2DaLb74PBzV6pCLWuq7+Qyy3pqMIo2Sj
 U2H3qNg/YUcFw2LtE7/pPGQFlDJPuchn35BqJCzGtTUO53mk98+AQnCOd7qiDed2NXvUZs82PKD
 +zEurll/fxa6A98nF0V+uAVtGVarGsyLkC3pZ6Px8ZIm70GI3ye0rX8lfA78SNeWeuEBD3s/
X-Proofpoint-ORIG-GUID: 94_C2fpMLSSor0d0R4xsPb3H3xQamgKj
X-Proofpoint-GUID: 94_C2fpMLSSor0d0R4xsPb3H3xQamgKj
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=687a8448 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=xHVDqe4EictJAN7MuBgA:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=733 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180138

On Fri, Jul 18, 2025 at 02:34:04PM +0100, Colin Ian King wrote:
> There is a statement that has an extraneous semicolon; remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/msm/msm_gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


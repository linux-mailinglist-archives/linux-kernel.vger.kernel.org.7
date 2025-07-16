Return-Path: <linux-kernel+bounces-733783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD37B078E7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6DD16E28D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BC02701DC;
	Wed, 16 Jul 2025 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="at6/24Ga"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62424262FC5
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678042; cv=none; b=GRc89hukraM9XULOHe9nxn7FqPjxg1QGtBZMf9/QGfdNYd+P7icxB8OLUIduLcxuB+b71+MKlajbwnnW/X8XKWHA+zBbdgoXAJZpGdYNO3hMgLkASzN7mO5MKw9Z+eRfC903b6qUQAzEvJFZDIpSg5RckbyzC65/r+nxGMsH9gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678042; c=relaxed/simple;
	bh=MHIyHlqoA/Uqj9LXN2PMXeXEUCUsJxys4641D1GX0Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHkDaaXC+HzWJVI1MwnTHP/Q7z8C1mCUJrdsskVo+rQsJ8a3GeXSlvPcdY7rFSDlBgo6dKQwbwKVwIM5WBHJSEPaKWx5gVHe5hpEuKuFjqfpZC6RVX03ADB1O2IdH90hOdWpqCJZ5YAgOSpsBYYGaDazT811PX1dXT5UwGO8hiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=at6/24Ga; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GD1WXZ031464
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jF52cvUSvshXb9p4qQS6TK4m
	/ZISonXy0nEmQgM1hBo=; b=at6/24Ga+F+8Vvdxi5MQ8Z/aKzQ+QzS5eKU482hu
	9yw7KL38x0cl/MFRl1/agbWUDihD2bPPA9Z3VLwiNLilwY71acLUupABwXtBJDEX
	Q/99juCdVfXgVkrAUnnQ0xK9s/rY46PtJ5H3pRN4ACywXoxJsB5yL8Qlubg+xtJ9
	qkY6T2OCkn6b7Ded9apRS8xBXeXIzJjtB1VVMnjzpUpXhL3K5QwQMRexB9FKn2Kc
	YlTxEGxEWUaA3DeYyR42WIQwgaQ4M0DR4VTYG/b8+NpNyHSJP2MPn4bLVkqDb8bV
	pHwiLJAUN6BzzUv3YRl5q2uuLFCspjpjsdcWswkPVvayZw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47x8x7h4u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:00:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e3452c060eso56729885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678039; x=1753282839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jF52cvUSvshXb9p4qQS6TK4m/ZISonXy0nEmQgM1hBo=;
        b=W4uKDMmwgMwo/uMpctFM0NEvnUaHZydr7vmYdqdyBH3BW/U5fUfiR66Tsn6Jt9QWGM
         xW6qqjYo1xyNL9+vB4E2UtrTa4+PdQKh2X6O3G+z4Z0jaApyet6G+dze4h0orXv0NVP6
         fFjNrzBodYJJJi9a38bxg7kAjlKOs03fXSF7XJ8ZieD0/tWtpGR8SqojIX40o7AMImRM
         J+bh4hsHkFRcKbnMePWY24if9451sA1i0Y1aSneuc/R8VShS9x5V5DbVn+lr1sS1FYJC
         3rX9h4hMIj8u6bmbIkZ6hqAfMQ5WysZhc52gwolwdF1ECHPe4ad/0SQ2upuLMnIBzSus
         EYkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6vkSZU0qT0y9ctkdQvgFEWEVlcusKAJQI1D3XSpNcl5bVTo115GDCghJ/0tUi69mFz1ggR++IrvWGLG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyARtBbWhAR2BMGy2OtBidIBv4EBAvGmySo497LAIFb5kz7utMr
	B1W5N35+70q71PKrl3Jf8jafEvvgR4lAZnlA4GCQWfpoESq8M62u7gtNOpmXcofsKfh9qlnsnwM
	t+NWyrp2zOmZhM1+6phNqZ+tHCcAtQtIB45UQT6YO2STukSuqpmDInSOgiCYEf5+u7Sw=
X-Gm-Gg: ASbGncv52tUNGh+IbhLsrXROvyTtL5/g79zPbHgLxvVD7CVBgZ4uIoUpCuM2+NXYDVk
	YpbYCL2wGDAxILWT8oetIrHykc0ZwfCrnv858wuwxeaV6Ch6ZtODfMoxs21I3eRufsrwnNBNg12
	6GpCdwuGPEEShE3rJez5xTpmpJQEDppW9EnO29Is4inMMR/ZbBrPULNdTu08VSmDfFqnSm86HuL
	z0BfnxDWiypSGerh3zAUEPGIVaqL/EG5GWRMAzbb7TuaejgsTcn9AKxVn80/07BJJU9PYV6kYoQ
	pg/Jn2jC/Po7GepbF0GkVyQwX+zjPFxCd3rVFzGc3o0ssW+3xnaAeho9WZXFXaIsITpXj+QWn+D
	S9PHBkdWOikRvxA1fwepJfDgT+kuBh8xzLnSzKpoSczc7eY55Ynx3
X-Received: by 2002:a05:620a:688d:b0:7e3:3019:e16a with SMTP id af79cd13be357-7e34356f603mr435572285a.17.1752678039046;
        Wed, 16 Jul 2025 08:00:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxt4H5FXg39a4tOdmD3AP63qnFyd2IRuTr09Fx8yHgRyZMJ6icisMhrFI2Cre9KzAr64FPuQ==
X-Received: by 2002:a05:620a:688d:b0:7e3:3019:e16a with SMTP id af79cd13be357-7e34356f603mr435563585a.17.1752678038354;
        Wed, 16 Jul 2025 08:00:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fab9134b5sm21435371fa.102.2025.07.16.08.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:00:37 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:00:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ling Xu <quic_lxu5@quicinc.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        quic_kuiw@quicinc.com, ekansh.gupta@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/5] misc: fastrpc: Remove kernel-side domain checks
 from capability ioctl
Message-ID: <aepmtv6mxlzhpncwcwlmgfrb3m2c4xe2edl4y5qsnjpxmvivla@gwufrh37y473>
References: <20250716132836.1008119-1-quic_lxu5@quicinc.com>
 <20250716132836.1008119-4-quic_lxu5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716132836.1008119-4-quic_lxu5@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzNSBTYWx0ZWRfXy80o2QiO9Aro
 DN/X4Z7zl5QljKPNw6PQ5VYv9xI5eRcT0G2ggSyn2/mlBk+v/o9FI0/F9iHBFY170D7nJL5i4+/
 nfSyGoJ/NkXtp+bou1q3qQkbMfaklt1/GzQXRQfb/uYxqYTSnJQ048BTp4e6iTB24pKFKttL1yJ
 60M7LNDQsI+Kc7K9LKGnPx6sRIpTM2uaOopX6fheN8XyphBj3ttGQzZAoUDJJ6KpdTzbKHgl/tC
 AAk9zPQySD7xSb0gtfmsBhuF9XFlupBso+Kv/GWPheQtDxBwWQ6D4QnrzjLAvXxk09K6r0ie3Aa
 I6kGLTGoABrIfDEpGtVsbnPfz2cut22PZFYhGzmOH/HBk9BtFsagDUza5yA/7ivk7OPglBSwzOp
 VxnARuP8dqE4xdiC/zfFP30FFZlHuG5SnPZkFzdbMNRK9nwQYc0rTTH5gw4V00MKICA44lsd
X-Proofpoint-GUID: 8V74txuJoxSdy_OZkIsSGjhkm19rMVw7
X-Proofpoint-ORIG-GUID: 8V74txuJoxSdy_OZkIsSGjhkm19rMVw7
X-Authority-Analysis: v=2.4 cv=N9YpF39B c=1 sm=1 tr=0 ts=6877be98 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=lc4KdpPQecCvDiYUKO0A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=738 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160135

On Wed, Jul 16, 2025 at 06:58:34PM +0530, Ling Xu wrote:
> Domain ID in the uAPI is misleading. Remove checks and log messages
> related to 'domain' field in capability structure. Update UAPI to
> mark the field as unused.
> 
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
>  drivers/misc/fastrpc.c      | 14 +-------------
>  include/uapi/misc/fastrpc.h |  2 +-
>  2 files changed, 2 insertions(+), 14 deletions(-)
> 

-- 
With best wishes
Dmitry


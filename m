Return-Path: <linux-kernel+bounces-746798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8178EB12B51
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 18:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AACD416B18E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60131E8331;
	Sat, 26 Jul 2025 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cgHK9p9G"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC02621348
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753545867; cv=none; b=BqIZB1SMdoP6QoKbOgANtb8GG5rOCxf7ZFk+J+NfF6D2OBIi8MlQvrmzuSDaICw1XdEQ1/QxNexsmKebDd/9En7WGUjTAE5mdIE6PMr5LoNEYv/KTOlT0y/uHrLZh1tRgH3a3WTQcCnbHCXNB0O+udElB6eMcn6WDezhQkcs3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753545867; c=relaxed/simple;
	bh=DdGLPcrbkJZ5fLQTq4/2nuXEKsDIaP+nIoHwxQ4d6S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5UeDBfMZAAYxqZhdkE/TBdGfAjzfG+OmJL4VS0/zJVfXwpjTJYhIAaASJ9Tq2qC06fGhr6GmdZ7ZR07dDJo561yxaARqk7MVm6M8HZDF2qNRyVZIgosG7Gj+T55s0MDuT39HJU0Sp3g92tC0+4AtJv4LQ2LCApw9zbcGeZtp1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cgHK9p9G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56QEWN5g002500
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yfKbo7ad/8TebfDZw7J0Umhb
	3as7DBy4t8znbao/DKI=; b=cgHK9p9GDXKbG/9yE9/rwQJWG4fMX2wYRuFQI3/X
	ekekOReagAr/bivhqou99mSOk/xy5VRX1EDByhvd+9hUugSQ0fp73pDySwzjiR9B
	Jeb6uF9ZUaKox/gDFsNG4hO29iQQeB4ImOwN4RiYsPzr3ZUdk+9vtf2FTl7jca3e
	JV6YQc+Ky+PGddCHjT9jwPj5dLnP40VAC0FaLWfBF4zCG5ZSGenLG5vclp8/ewmu
	6bA+2r/FED840IiNYbj4H3EXAsww4cPZ02wgO35vatkRZuAmD6BGOVxjJ7laS5NG
	6xsLkSigTdjBALgCh3ECv2SawN5EsoVlP4guLdQKstziwA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1a8wgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:04:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e269587d8eso595346385a.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 09:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753545864; x=1754150664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfKbo7ad/8TebfDZw7J0Umhb3as7DBy4t8znbao/DKI=;
        b=lys+92UiDoM9oLx8USaYPGmjQGLrlnuSkeF8dcJTHt+oBHuwT9p5xhCDskfRSWtX/F
         gfTRXd2FETHCipP2FytULcRNM2VgmJat2DllxDJ2lfL1v8E1zGBPbWUkyBBVFtQ0tWFR
         sfHjpntfShQSqYUvzuip+INrOvssgF/Xs9znK5moYB7/CthTQesFapfeBChQNbzLAxGo
         ZwZrmEYhjoCWu+wyvFNeGXbMLLj9Cq0cdqfsk3ka0VNyBDl6c75h1G5tGXMj/hBRyRdO
         y8gytP6bpCa7VwJOmQFnwxhoSPdD6x5AFbeRxB2wYop0rYD4rEJ73D0ob/W1RPMm/UaP
         L0zg==
X-Forwarded-Encrypted: i=1; AJvYcCXozHr0BdcgnPIW6n7zfj+K9kBQGI0gKeS2jbpwv1SNm9Myd21bRPijq28gLMNpWsSr2fvdvq4zWhRkw4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj+CdIom89Cftpy6OMtXgYf0DfQfI1GFFrNNV2lt7wLwdOu2nS
	i8GzEWSulskBOj72zQfSUzPEl0AvTBvF36e7xImUwGZRklRLSbkq4wKH1EZF6ZNNYAe1+uRhKSS
	CBYRsTfUVIlQLdpzzdsWzKAuddbunJTBF31nkUJHXHXS+L+6bE/vfP21XFxuSAEwJqF4=
X-Gm-Gg: ASbGncvEj82K+lPZ1Pr+ICNr7oCU6eQE8zQ8xvNdtCIAD9Arb8o9gxEuBdLvK+ItPe+
	OtmUMKBGBDgfGroFc1BzTw3TqhCMwRCGzGki2Jyt/+63mLHy9C/AqsU8BElyNgO3KUMpCVFJ8eB
	6FRUHc2Egz//maLzkuAZlP2cPy1SyMcwMNcQ518VGy6L/FfYFR7XAuO8846ycWcrjoFNZgqJKju
	aosgS+m2S9iME4ioAjuiMKEVYAcumv3qUiZbpNhbjAeab/mTm4XuvZWy94I53r2yKc5wUo6yqUj
	p/iy5kjeuxbanFpd0n9x4kJgCxGTwxEgj/MRUnyD5PDXLyeoGfQuRFW8gYZINnvi7yv4hI2lG0i
	+XRrhKroP/P6UMKzJr6GvLau5ZBXFzYmtzVq+fSTNpweRm8i8JOqT
X-Received: by 2002:a05:620a:3950:b0:7e3:417a:9609 with SMTP id af79cd13be357-7e63bdf8e9emr775034285a.0.1753545863546;
        Sat, 26 Jul 2025 09:04:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU5L67rpBaZNuPMlG+POX9P03Zj0lIztOTkguqEQNMXfCPAZFoSgTgA0DEfhrJVVgzeWEt2Q==
X-Received: by 2002:a05:620a:3950:b0:7e3:417a:9609 with SMTP id af79cd13be357-7e63bdf8e9emr775026085a.0.1753545862900;
        Sat, 26 Jul 2025 09:04:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6318296csm485676e87.50.2025.07.26.09.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 09:04:22 -0700 (PDT)
Date: Sat, 26 Jul 2025 19:04:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kong.kongxinwei@hisilicon.com, liangjian010@huawei.com,
        chenjianmin@huawei.com, fengsheng5@huawei.com, libaihan@huawei.com,
        shenjian15@huawei.com, shaojijie@huawei.com,
        jani.nikula@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 drm-dp 09/11] drm/hisilicon/hibmc: fix no showing
 problem with loading hibmc manually
Message-ID: <xfwtvau2z53lqeqyexcm24cmncjmae6wvgvtp4nswthklotyym@qm5swowhkyr2>
References: <20250718065125.2892404-1-shiyongbang@huawei.com>
 <20250718065125.2892404-10-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718065125.2892404-10-shiyongbang@huawei.com>
X-Proofpoint-ORIG-GUID: gvv8hkrajyGqr2hndch39Et9lCUWch7A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDE0MSBTYWx0ZWRfX+hVNcNV8WKxI
 egGRzGhsqclUzlLrV61Td8IjwJGIAbLZHCYev/I50rfxik1fLX8cXzkQMbvSOQyy5atIgQ7UDi4
 Fr03X5brBEwyRpU10V6V06XjhD9Uux99iAErV1aEu19XnTkD8QiTRpuGrHBXy80PxFtf28wUVzv
 pfF29RUKe6/J3yCQMl1j0HmGn3exPPA7VucDMuz/bPH3g4ab+Du9o+e56h9lzoX73bdxa2nCc6i
 mb/1QWn2E5KOO11On6ob2DZGV0xmkJvOpw2w8GLo5xETk+JYbHcjf3yD1qojP9tch+3ukAh9b04
 F3ioW6Svj1GFdMRktQeht6SHGz9ml7Le/2R5gPV6gs3H0hhc0dXTIDaIkBIKX3ZFREuzrpw0UuA
 TFw+2cbzi1Zt06Ili5RPOFNZFSq+mEzducKV12KkjRheuUc/TS/73KGcVTzhBHF6VaUvz7uV
X-Proofpoint-GUID: gvv8hkrajyGqr2hndch39Et9lCUWch7A
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=6884fc88 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8 a=grDN2ZGVdwoY-3k3008A:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-26_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=976 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507260141

On Fri, Jul 18, 2025 at 02:51:23PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> When using command rmmod and insmod, there is no showing in second time
> insmoding. Because DP controller won't send HPD signals, if connection
> doesn't change or controller isn't reset. So add reset before unreset
> in hibmc_dp_hw_init().
> 
> Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v2 -> v3:
>   - fix the issue commit ID, suggested by Dmitry Baryshkov.
> ---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


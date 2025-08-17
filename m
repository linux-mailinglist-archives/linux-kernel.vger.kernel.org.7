Return-Path: <linux-kernel+bounces-772481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517A6B2933A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 15:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A6F203BD6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 13:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDFD21FF5D;
	Sun, 17 Aug 2025 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gNUVrEe6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D36DF42
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755436631; cv=none; b=UK5+Nu1Glj8wc/jtchEHpgFhTn6of0g2WnOEW7MzByspMDOdmMfhEcart/vaEssAMQO41qQGF+i84o4Fza/+ibp7vsIZtzwAqDFzaFceuWSUIfUmG3gHjsLW35y8nYJYPd2SfZRh6GWWEpKTZMm0IsMMMx6jtWs8SFjcZxWR4U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755436631; c=relaxed/simple;
	bh=WG7kNQWG8Ot+/Jyh6EDne9PquY+C40/rjs9iJmLgh3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfhXk/riWN9jqf2r4ZXTbJVdOtf3aCIWq74KDOPBHHCvWDJZuPzPToF9vKtz+8HkH45TB2EOrPKT8spodxzGrXtGkYLi2Df2RccmbKinUqTOYDtQ5fghp4pScOTofdR63BDivMG2bIcTu6qI6indmpswb4E9ChjNMvq38LjQzoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gNUVrEe6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57H9oEXm004056
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 13:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GiV7pSStDdWI68Vss3L8zd+L
	tIEJULlsfsxCpf7SurY=; b=gNUVrEe6TVY5VcpYoVtvKvHbWSSi5ubvqvh2MAtX
	tiYWKhFRpNAUCCHi62/QwFcA/m+8IzhC5xA/7MtbmE/PhrXCHlqlOMevfWIT4w8X
	672y7yO6bsg02Jf1CDe2GlqLbn+r1GGctvcS69zEEAJYZ2dl0NbfeTeGtSn7oMGs
	EEPW8wLH4op+SK9CfrguT2R6zvOZp+ZoUfw0qswmb2+T0HLwnXq0Tq/7oyIspt2a
	qWP9BxTuG092+9R/fNrpTTvk+U0mPpnJ6o8mdBY9MElXgUXtODgZFqXhQ/izK0k1
	u3kAPzgeCQATm3O/9geC4gzean46hEkksLJgwBlFZWDGHA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jfpf2apf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 13:17:08 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a9f534976so112170466d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 06:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755436627; x=1756041427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiV7pSStDdWI68Vss3L8zd+LtIEJULlsfsxCpf7SurY=;
        b=mbk4RFuyLr1W7OkVQPfahXfQZaGqw6jRFp715FQj9T0Kngvc9NfP/yUOBpZ7U5gMRt
         VR62wvpJtKGj7AtW7iCalWWOy2wo/f4k6YPJgjNrgKtnksxmnZxRG0Q1C17hU6JLBe1g
         tSyz2GJ8TurhQvnSJ7z1ZR+/Re2M9H9tpO2taYEY8UCyLuZSMpSS/+bIU87/qNhOr9+1
         1bMzLpr81zzi0IZSDYVm7l1oTJjLFOFtPFDGi/3Vy53XDcgp+08+b2/H1bLV/CGHpN54
         6+LD85FtCjE8MFroDQuMetoCCLvPZBF/rGXzHbdTxw+M3ZywzolcQpLTavjJemj6Aj9z
         1GVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEb+RW4X0gi4QHmm6ZVMSbSqRiOKuN+j1McdJ1YnGujt34WkxubnTjwLJI7Rfn21tR7Busshi0guJMvug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj0+TrHJV+DrjPBE+PboQuK518KJjxMu5zxTS9T/0/NrOm2XqJ
	L8aM9A+3sPCWINfcPerjirAyxy0Kh6Y+nHPvKB034U3PGprTu6ROSEW0ixQgAvsbBzEZygF3+a1
	oUtU9mM/S/Lb6jER+5kqlsCJQ9kFLJye1ZersBro/h049ORbsmvm0ynPg4FVBNqnAHK8=
X-Gm-Gg: ASbGnctz5HSCRRJV5jrIEiPNXVARZA5nl4izdK1l4YhgBG9hVERxbOSj79/QoKETuCq
	JAEj6vL0oRAYW/TJinf32FXDzTETgS2xEALOdTV0AguqoTpZy9a9RGeexCiKAwLT94o+DswoLC0
	W647RcHz6oqNC0vsso1Ofz6hnNdD3uFCFSsdeTxES0DZ4T/7G1TmJv3o6Pkqvwob+K41GUIfCru
	zlf5+9ckrdOxaHorFi5cvqHLNJSSkMKuKXSVHskBZevMarRu5ean1yfh3I8XcHiDRcoAF9Uasy+
	S0q/nfwwb5FnXVBWNFecztX7DBtfJGdbM/eNZ0OIFbllw9rcDGp6Mr9CemNIv0821Q50p1e5iii
	dgtX6YseETFWzdv07CF/ik91ipybk65tTReoVLA/mbHuqGqfhqvxh
X-Received: by 2002:a05:6214:29c6:b0:707:69ad:d84a with SMTP id 6a1803df08f44-70ba7c47a68mr96712756d6.42.1755436627282;
        Sun, 17 Aug 2025 06:17:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbl24CvUe8eJqnII5MYk282LE99iXcWaVQo/FwKTWXiUwDfVAkbciAv7+M5Vmv6cpRCKgbnw==
X-Received: by 2002:a05:6214:29c6:b0:707:69ad:d84a with SMTP id 6a1803df08f44-70ba7c47a68mr96712416d6.42.1755436626776;
        Sun, 17 Aug 2025 06:17:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef47351csm1223263e87.163.2025.08.17.06.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 06:17:04 -0700 (PDT)
Date: Sun, 17 Aug 2025 16:17:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kong.kongxinwei@hisilicon.com, liangjian010@huawei.com,
        chenjianmin@huawei.com, fengsheng5@huawei.com, libaihan@huawei.com,
        shenjian15@huawei.com, shaojijie@huawei.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 drm-dp 10/11] drm/hisilicon/hibmc: Adding reset
 colorbar cfg in dp init.
Message-ID: <tvpcofc67wx7tmnzew4pptejsiqtjhxwbzfo7wxgwjefu7khyp@3sy4br7qgtof>
References: <20250813094238.3722345-1-shiyongbang@huawei.com>
 <20250813094238.3722345-11-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813094238.3722345-11-shiyongbang@huawei.com>
X-Proofpoint-ORIG-GUID: 7NlVOW6JdkAQzaK_AIaXC4GJDXlYc5An
X-Proofpoint-GUID: 7NlVOW6JdkAQzaK_AIaXC4GJDXlYc5An
X-Authority-Analysis: v=2.4 cv=X9tSKHTe c=1 sm=1 tr=0 ts=68a1d654 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8 a=9HEaCUo7PYciymiYKZUA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAwNSBTYWx0ZWRfX7aul5vrnGr4m
 seJFhJ8xOHo5uBb8Xf8Xvlyugj5N5cLDVm4r/1bRCrBg6S3j/ar82rbFMOXGai7mDS4RHAL2zIZ
 qdrkEOtPUx7Z66ypq2GRV5cWiR5IXkzxkxxprh2hQYZt8nwO63kwkCvbJySYRxzO7DHvPyhqzCs
 YMLYNbgDBuFJp5y/YTOBVayCedqM8dBNo12Y5ADlvubaXgG0NBoprgoxjALbpjBr8b9wyqRyruK
 BAYZV9JEmBdssOCtrQf94kbsWz6w1mEQ8GSNhjVuaKRlcU4+3z2GvYISgDY9dpFK/mqls2vIkpC
 r42oeEKYbRdGqX83rBXI2p9HFPmD4A6Yeo0Kaw0udntLMFJDjO7T0rGtnYWvKMtyMj0aBkOMsFE
 ksYuxP0Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-17_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160005

On Wed, Aug 13, 2025 at 05:42:37PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> Add colorbar disable operation before reset controller, to make sure
> colorbar status is clear in the DP init, so if rmmod the driver and the
> previous colorbar configuration will not affect the next time insmod the
> driver.
> 
> Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v3 -> v4:
>   - fix the commit subject, suggested by Dmitry Baryshkov.
> v2 -> v3:
>   - fix the issue commit ID, suggested by Dmitry Baryshkov.
>   - split into 2 commits, suggested by Dmitry Baryshkov.
>   - add more comments in commit log, suggested by Dmitry Baryshkov.
> ---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


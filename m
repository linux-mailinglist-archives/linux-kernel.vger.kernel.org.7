Return-Path: <linux-kernel+bounces-811811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDFAB52E28
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE4FE7AD950
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57F430F7EE;
	Thu, 11 Sep 2025 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BKIp3dlw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA7B23BD02
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757585896; cv=none; b=iwrQfEOYNsW8XXOcaQwAO1GcG3kNpvXE/cYaEOiRGEkjg8/pO89l8mXURhEg7LSEdS50Au+uFo25eGHRiLTcqiJ+poIdaNgAUl2J4T1ESDc21v6z+HXjB3ZBhpuwpO2QSlbxt+WghNuIArhpdi/opYsaj9JKuo/aRWJn7tdFoho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757585896; c=relaxed/simple;
	bh=AzOavFfTRJPNpyZQA+1hsA1gegZQix53bZhIK07EzHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dW9n1iRIy9qvtFgF0M0ircZOfRPjUXgJYQOjlV2mnmr+nE1GsywZ61mAKLiIXRg2NX2FvxIDWyvMAF+CE4bHcyWy4MDUeaY8PkOYgPWOVR2s1gCfxdW5qIFKoNzBC8+coayXdw3ke65M9NGz+H0FLlhhtoOdxf9BGkHd1gE6PNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BKIp3dlw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B4kCX1019094
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yQ7eGaeHD2W25fWHu/CUEy8t
	9Pdt7I3zN4P62KgjDEM=; b=BKIp3dlw/AbYH7/fl8yZAJHngdV7TvUlSGJKmXv/
	q8f5IZc/orfHnbwpVQ9WxNe3uRSosOpPXBVi/d2nVgTfjIvZEjESS/edsY5LM6aT
	1+LyQbxQnwqnLdJcnXzRVwcnionrK6L82iFpH7vdB1vLxHgOIRiHi9vpSWKmeYz4
	g4CMW4pfh+dSElcFQfaI4JMOA5JrotRr6BbJvnrWkLFLDXMpAaSVf4zJxd0I53jn
	ySTEfjm8rjtjoljwI7l0v8X2t+Rjd2L5FqLL5gvIvM9EgvxELZL3ltl91p3e7Cml
	Ge9aHw7RcPANLYlh8+eqw6L7kDg6w2SRqko0UHpAYFkOcg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493qphryc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:18:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5ecf597acso11916911cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757585893; x=1758190693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQ7eGaeHD2W25fWHu/CUEy8t9Pdt7I3zN4P62KgjDEM=;
        b=fgpFBdpiPYbz+3Vt72RAb4+hNw4zj6BseQPqNnDOplqXp0sIjQom/FNjDPqxMv1rQR
         HuUt2r8LIRPhbCnRCXffUEj7qhudII+iXU7MajQHJsdjNkYIf5KcjnRDV9saa3IarLdm
         KbP6/U2zm+dsVsPEhEHN63YNF+D4eIcHevvcSxa9IOE+s3wAphAW5erLUuRyGGL6f2kf
         EqhHSzPi1vuc+aGpwOFdhOwo5rzLo8iYmSTQe/tWjrhRKXwl97jsI5rFPLlQkE3hKOKb
         dMZ4lkLnSHr2ze7u4bippVNmZnd4iWJliUSaSw1zTc+xydgzy7OWk0triq4F4aZ9tr9Z
         B+nw==
X-Forwarded-Encrypted: i=1; AJvYcCUP89/EBq52du+AkcyWs/w6RoW9O0fLbKUOAlCYZKxhpBLJHbl4UikUjsSV0sDOKMWpj2iJvwBWYiOWl0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbm2rPby9weVyFkzNcEcDllYQCzHF4QbgQZ1K9BUbkdYSdFN2O
	kRoGzv2mwPagthbjao3DNw++59xxSMbJNZL0LxuHxV5SiXKZ/fbWVofYlHMU7N8ZME47fm/NEvj
	spefC9blS5j5LYxvkY3vwVJ3XaGUwdmszEPXUTYCTTnPrajIEK4Lzl+eFOZSr6DXZBGU=
X-Gm-Gg: ASbGnct+D2zrkPN2oAcB8HQK1YVECA1+PdmpO5fk3oScAN4RAtj5nHeSJvHnqs14Y8f
	DDPG6wOqk1srK4mTuC5fmad7i9LeU2OkabVtQDHRDXgGVvti5D1QzBfHIFuYoOXw5f68Hxz1TD+
	8K8xWQ9awG0HTx233XtugHU8ZNSM/FiaZpJ1XHLvbqH5bencVuE5O9Pq6LND8S0C76gzA5zh8rj
	ZXr01JPiASBxDTI33F+aMFsWLAddAb57UCnQoGH5Pj4FbmB80/j7Z2u2f8deyqequ5S6fgXUSaS
	Hv9sBgMl702ohM/KwuN7TqKgCMhNyefUdDgob6AxyvDX+X+K++9WcLdETtRr4ILrHA4ki/MFDH9
	B0QNRaYa2B/u+FRPPfmkSIBumB83TGNPvvSLyH7vx5A1+thazKciv
X-Received: by 2002:a05:6214:f63:b0:70e:d82:703c with SMTP id 6a1803df08f44-73941de3724mr196743186d6.49.1757585892542;
        Thu, 11 Sep 2025 03:18:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsOmB2XFPgQT9DyUDIQt1+knYeWF2UKGh5Y0A8jWm74XXGJpVfSrAl9dFqT+4Zyq2jcp1Neg==
X-Received: by 2002:a05:6214:f63:b0:70e:d82:703c with SMTP id 6a1803df08f44-73941de3724mr196742746d6.49.1757585891942;
        Thu, 11 Sep 2025 03:18:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460df53sm326693e87.109.2025.09.11.03.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 03:18:11 -0700 (PDT)
Date: Thu, 11 Sep 2025 13:18:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kong.kongxinwei@hisilicon.com, liangjian010@huawei.com,
        chenjianmin@huawei.com, fengsheng5@huawei.com, libaihan@huawei.com,
        shenjian15@huawei.com, shaojijie@huawei.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 drm-dp 02/11] drm/hisilicon/hibmc: fix dp
 probabilistical detect errors after HPD irq
Message-ID: <cdmtfluxqes3bv3t7suctbajp4jmpih6fhegkbf7mxvy4umzrd@rtpupear4el2>
References: <20250813094238.3722345-1-shiyongbang@huawei.com>
 <20250813094238.3722345-3-shiyongbang@huawei.com>
 <aayi7zjrmru2ancexrqmcutams6ohde3nrkhqacixwp45dsk4v@7ig6hqzahdxf>
 <1dd93bb7-4f67-4b9b-8b6a-d7c5c77cf807@huawei.com>
 <ce47v3y77uc4dunlwyvmfe6j7d7mza4zfrbvu5dz67t66jdlop@vqgv47saj37i>
 <8bbfd02f-138d-420c-b456-10d0c913f46e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bbfd02f-138d-420c-b456-10d0c913f46e@huawei.com>
X-Authority-Analysis: v=2.4 cv=aPDwqa9m c=1 sm=1 tr=0 ts=68c2a1e5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=Ij9o4XEmEmbWDCisxXoA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: lmjaHxIu9xnafdUhy-dP86UE78lFD3yn
X-Proofpoint-ORIG-GUID: lmjaHxIu9xnafdUhy-dP86UE78lFD3yn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA0MCBTYWx0ZWRfX0g0XYrhSdkL7
 3KE28LUJAWAxYf2SJdwAv+osdOvV1ZnjRimHybaIRCcrQcYLF7mbr/QkmH34hB4cZwUlzCjKFKq
 +1JmBOtO/IxQM6Dqcmc+/V2f4oQVauaRJoCzmXk8rM4MhFAt8q63IJosD6TxdGn1Ir8/92wTtt0
 t7bigsaV1Qy/MTkLcGNDT8Nfg/bTarP79gaUWPPj7XW/JyIgmOa8btTy1ECQBow95AlSsPoPeNG
 y2oldPiLnFkOy2Iz8QX/WJSI5X5+ek1PvTAq3SJ7TPlu8OLJbflpCJT5ULdNmyfw4Qz6nFBrNA7
 lWiEpKT4dSRUNDiJ5jzCo9R/2svJmha6XHN5ezAC7naQILAMPhZB+gLDaQcdqHU7dedIRrSy9oM
 mjDTdskb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509110040

On Thu, Sep 11, 2025 at 05:32:40PM +0800, Yongbang Shi wrote:
> 
> > On Thu, Aug 14, 2025 at 08:19:41PM +0800, Yongbang Shi wrote:
> > > > On Wed, Aug 13, 2025 at 05:42:29PM +0800, Yongbang Shi wrote:
> > > > > From: Baihan Li <libaihan@huawei.com>
> > > > > 
> > > > > The debouncing when HPD pulled out still remains sometimes, 200ms still can
> > > > > not ensure helper_detect() is correct. So add a flag to hold the sink
> > > > > status, and changed detect_ctx() functions by using flag to check status.
> > > > THis doesn't explain what is wrong with
> > > > drm_connector_helper_detect_from_ddc(). In the end, this function
> > > > doesn't use the HPD pin.
> > > I'm sorry about the misunderstanding.
> > > The issue is that after plugging or unplugging the monitor, the driver takes no action sometimes
> > > even though an interrupt is triggered. The root cause is that drm_connector_helper_detect_from_ddc()
> > > still returns connected status when the monitor is unplugged.
> > > And I will fix the way in the end.
> > Can you perform a normal DP detection: read DPCD and check that there is
> > a DPRX attached and that it's either non-branch device or it has one or
> > more sinks?
> 
> I'm very sorry that I didn't get the last sentence's asking before.
> It's a non-branch device. We just connect a DP monitor.

Somebody might connect a different configuration than the one that you
are using.

-- 
With best wishes
Dmitry


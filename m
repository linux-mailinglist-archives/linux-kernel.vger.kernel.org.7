Return-Path: <linux-kernel+bounces-845380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9CEBC4A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A4F3AA111
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CF92F659B;
	Wed,  8 Oct 2025 11:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U/3wO0pm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ED02F4A0A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924434; cv=none; b=drwjldw3OrybfQCLXDLHUfutWWaruix/u6ZtNAXY+oS96v1m2GBTqGKHpf+Az5Ngo6WTjDuUiNqMsY17OgYt2k8jfQYMVdXa+9ZZcqks+eEbzWJu8gvZdIwZf87tVRHDm5fVPSMDp3UbItSL3Ve7Gvocc3pTw8kq4Gz45YZDh9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924434; c=relaxed/simple;
	bh=8cLt0ix1t/8cGuoBuDLR9JmN7BJAmYGQQ76ce4UTKC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aX/rHVcANMqgBBvfdw1bj6hpaWTbhdyTgOhRwwd885lNvsfD3c++hjX/LZV9oHgkN+jm0RUF77aE5NUn4K26hZcsf+kYWIQWXreZTXS6SBhXGsGJCApf7eBhGvUcUNKJ063fSyxpjhh+zcNj+UoEKXKtsPmrvidVuvzIkC9mNto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U/3wO0pm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890QWQ021165
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 11:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7avWY48JQfGVo18dxq+IcZTm
	C3WfW4UmnkHNbWtjudY=; b=U/3wO0pmLwppCNGR0R/hKlknOd17qddFlblwFn9S
	+QwVNYSaLQzsoRnZgaa4ZoiPW3hdajJJShwb5f+WHrXVj/NB86tCOe1+W63lDKPj
	ME53H521nr1EyoXD0oGY0HYN8OHN0kImK3vvUtfb6X22p71wd1NpcpVBPsGsB2Rv
	FmZrYRDh47nzj35flLLJl5nmIR+KGQ2uiW0p6V4d9VcWvvJqIhTX8bWrQhfOMh9G
	MyYpqEOqxj1Z9VyuOU+lyvLNEzSn8uGtW5LVkFf8kOFTwnbMRu+sgw7/saRzpq0i
	45bVINT8ZM2lo9DDWk+LUkZOJT/E2sk63z1OBAgzK3mwOA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1t87c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:53:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-28c58e009d1so130383475ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759924432; x=1760529232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7avWY48JQfGVo18dxq+IcZTmC3WfW4UmnkHNbWtjudY=;
        b=VJ5A5m9TwW7tSr92rPbqlZEgbwxT3HGdcmsWhX0YE2Y1IZigyAkTzenyagFerOjkKV
         DUYa7g8EmLAxdrjHupT7I7ix0If4Tp4+98R3yxUK4+lBzLqlEqmQxzW3J5l3G62giymw
         t4BYsQdaAGqO4XSeCezDq3CiWXMu/KZxf2/lOZ7ioiMo+NBESN9xJttZe/Qmpz+i7hlJ
         kUMEOeGnVizDbNfLWdJb3F3A0Jt+UcdFrX8E2oug/SF3NG4VVXp3k37GnvJIXcamFmWw
         1tqyIkqTGDYr1SUMj9I/y5Kn601xkUZdK73rInK6yLj9gZt8B4KVm8MMon8skU/RKIbr
         RM1w==
X-Forwarded-Encrypted: i=1; AJvYcCVVlPUEH+GtEudX5HZr+c3g2mGBwdQaScNMHU1mB5ZDD6yH4cQL8gapCxx89Io4SBarYIVkY5qMDsYocVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRALSzqAh/20n638lZhlONC5MdqoRvH4nEXt2Cmf6DLzLgOC8w
	2zMj+xZi4ejog9doRVP8qezJ2UihEpHOWYC6AWrvWhQFIrKlEog5j2fAKzhAF6k8UXKrafv3x4c
	p95PYws3GlXVgmYJ1Mjwow3ZCJk9dvWOAPN7PJXK1+7AbblotUwXGNi/itAf2v4p1Iqc=
X-Gm-Gg: ASbGncu4lPLGXmJjE7ZlaQFRn6IH6Ct9ifo2wM7PijpgT6OjGb1sBcLdnMrn+IBWlzp
	Jsowxcmj8sIZpay/53iFb9PytUduJCacuHYqWC9qeXwPwY82AM/hJzHX6nD9DLJBVkSWRCFqKat
	YivKN3z7ZAECDPEPqdqgcChkOEO2xCAOPgzTNxi9udPa5fk4yaqPWxRB1wSYiaKRgmTlnTJKBAG
	8wri6nEIH5wSfkJj8aZD6UWN+kZWlgFL39QXzzb3ZPfyEKTad/FNEgitABoOpFy0O0c5E9czE5N
	B45HD0j8J2VXioLUmv9huH/0uIWAS+t3nuA6OiC/+/QmInGV40pFzV0PiVRaEgep01Xd+mix
X-Received: by 2002:a17:902:d607:b0:269:8f2e:e38 with SMTP id d9443c01a7336-29027356528mr40731075ad.6.1759924431582;
        Wed, 08 Oct 2025 04:53:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRY9xTDImRzSnKlgoFFobuVyXDP6jP1oDDD+SqAwOBHLbzNiWdEMYhZJqx0MiBZOgzFyc4Lw==
X-Received: by 2002:a17:902:d607:b0:269:8f2e:e38 with SMTP id d9443c01a7336-29027356528mr40730695ad.6.1759924431009;
        Wed, 08 Oct 2025 04:53:51 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d5680sm198422425ad.96.2025.10.08.04.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 04:53:50 -0700 (PDT)
Date: Wed, 8 Oct 2025 17:23:44 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
        alexandru.elisei@arm.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Check cpu_has_spe() before initializing
 PMSCR_EL1 in VHE
Message-ID: <20251008115344.vwt3j24es7u5f6m4@hu-mojha-hyd.qualcomm.com>
References: <20251007182356.2813920-1-mukesh.ojha@oss.qualcomm.com>
 <aOVckTSJET5ORY1n@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOVckTSJET5ORY1n@linux.dev>
X-Proofpoint-GUID: bSejFkj0w_CqXagypSlSqr6fpZPdwW0A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfX1lVudxb14AJ5
 HK8t0XJbFZz7U1yGZvZNPjLed2gDiG2Sugvmjcc9Sl5g0qfxpiEgAv8XUZV/WWe42SR8B0M9UUb
 bo1mrlqAzALxz7yDsLFMs6O6EJmz4Bl812ARGuvKcn67Ao5siNL0d1i9AdpDit7N5l+2OVc2unL
 7qsC9Tb9KAwsf8S3tOCBAizLlS8nWZX8Clm8IG8Uyuc0cBNcXz6ErJSCGO5ZTc6RKqrNSGn7nVp
 gLj8feQwFrSxlkkGFlN2avw0iSNeRH/xWQ4Ck6wzoiOseJAU0D1phgSjoLMrYFcjFYLzA4AbjHw
 Kx2wfD84xne7f6EYl1kkhvcaJRQxf+cJC+LiMF6EE0+zSlgD6NeGZM3NWGnTcM8LFkrRCFD6EQR
 5+gQk5Tb3b1HJiJPyUAG3N04eRQRaA==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e650d0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=61sAA7mvWUCA7UW45uQA:9
 a=CjuIK1q_8ugA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: bSejFkj0w_CqXagypSlSqr6fpZPdwW0A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027

On Tue, Oct 07, 2025 at 11:31:45AM -0700, Oliver Upton wrote:
> Hi Mukesh,
> 
> I find it a bit odd to refer to cpu_has_spe() in the shortlog, which
> doesn't exist prior to this patch.

My bad !!
will fix this

> 
> On Tue, Oct 07, 2025 at 11:53:56PM +0530, Mukesh Ojha wrote:
> > commit efad60e46057 ("KVM: arm64: Initialize PMSCR_EL1 when in VHE")
> > initializes PMSCR_EL1 to 0 which is making the boot up stuck when KVM
> > runs in VHE mode and reverting the change is fixing the issue.
> > 
> > [    2.967447] RPC: Registered tcp NFSv4.1 backchannel transport module.
> > [    2.974061] PCI: CLS 0 bytes, default 64
> > [    2.978171] Unpacking initramfs...
> > [    2.982889] kvm [1]: nv: 568 coarse grained trap handlers
> > [    2.988573] kvm [1]: IPA Size Limit: 40 bits
> > 
> > Lets guard the change with cpu_has_spe() check so that it only affects
> > the cpu which has SPE feature supported.
> 
> This could benefit from being spelled out a bit more. In both cases we
> check for the presence of FEAT_SPE, however I believe the issue you
> observe is EL3 hasn't delegated ownership of the Profiling Buffer to
> Non-secure nor does it reinject an UNDEF in response to the sysreg trap.

You are right, writing to SYS_PMSCR is causing an issue.

is it not the right to check if the profiling buffer is implemented
rather than just checking the version ?

> 
> I agree that the change is correct but the rationale needs to be clear.

Will correct it.

> 
> Thanks,
> Oliver

-- 
-Mukesh Ojha


Return-Path: <linux-kernel+bounces-753217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B4AB18028
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38701176836
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1886A233736;
	Fri,  1 Aug 2025 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JTfPhGUP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08671C7013
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754044265; cv=none; b=GqrdSkBh9/x4tF5g3SLw1Ui8lb80s4k2bDFwNDPxlXpbt5vW/7QEPFNWIL2C4NPsboFMXK/bAq2jX45+jkUfQQnmskvo2fhCmq4rSCYQKkqO19zm+liwbHc1gbp+vpmSx7e9QuHs9fmrYKgMWMVa30XvBuqDKeO4sYIX9O6Ql+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754044265; c=relaxed/simple;
	bh=eCl7dMtFhK3LQlNnK5vPVFvtpM+k3WxFas4em8n7rBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEv+FuvZ8Eed/b/No+AJ4RhXpnngrcbZ9xufqs2SrSyvxpwqbMyiM0vISX9lsx3SyypB2bt1D265SbDlbe0n5xlxDBlQwNaMW5AObwMY9QvoaEz3SHKF97vUqUiAekKNbq9YMYK1lWDdgbud1NREyoLAmaxEgt7I7GatWXaw3ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JTfPhGUP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719CKSM020313
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 10:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L84CyF+woWXvkwBzd7M9RuuiXRAGPXc2Q4DgUeAC+f8=; b=JTfPhGUPPA8j0Ovh
	zlYaGqbYQbcMEk+9sj9CeEoEZ8yVfvu1NvmEonIV4+m1eZtYr2geyQb6zadeS98c
	PfPg44biaWsvMGO4GFtG5lengPCT4tyr5FC18ejZI3u16akjFJ2iLIi6MAVnxJ1Z
	gp+ky7rZSxSSjUpL8jXQGASTZvJS4KNGCRyKyEOnacA6JT0xQraDWb1eywQYlt1m
	RQFCMtq5gt+dlRMsOhNgy01tIjI3iKl2YAuohmo8YKjLhXECwbRyXgtzdOR+hcJ3
	/r+huZ9FlAIBinJTpZ7L96oubmy1Z+rKKYd3VNb2n6hNx6jTcpkTUH2H6fND7fcg
	AeFhEw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1aucgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:30:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4aeb8b6acd1so13311031cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 03:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754044256; x=1754649056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L84CyF+woWXvkwBzd7M9RuuiXRAGPXc2Q4DgUeAC+f8=;
        b=PVFQ6z8fceEYaSnQ1hEyNdMdhVMQKlxAHH5ZgjzG3XMSSn04CEHR742zBNRo91wYpx
         xH/jzJoeg+PKhDd69Z1XM2AQ/0rSdUWdDd/eWPFVEdVMeyMzM7qLbygrH6+FAx89KsRj
         fZy2Q7XZ2ybICqAUTeNoNQYSDcsRpPrLQN/leW/xWU2fCljwF/qBb7RixbbSmHwQ8eq5
         DExptUkLRcUwAXdnIoMKo9O7quK2b6O5pFcQJLswd/wJj8CnQBaYs2+pMpksVwXRGFa3
         U9mJ5y8AJOEiXZDk969qa5lKiTyQcLh+mIm/pwPW8ZesxP+4R8JtNGcW85E3ioEtMl8y
         xTWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLnefQ+nwHuNw6vkCsGQoH2LX611tRZBbkUAwE7qj/ICYHztqBkGWNSgy05fFCcSYAFS+9m0vS+8JG9GE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5EpREjXZRCuSHyI/ONFNFyYder3pfvyQjQn3wr9/WSLc/dQJs
	Y2ITgfUjz1mspD3MeprOmokD3XLy1Xy1JySWudy8oT5DqTIe/YdRzg16HHOui9DyTeO04Jviquv
	CnlEeCNdIuXg8KDouvLJhp1PPaZnn8QUSfBCoqHSUaHXVsTba6F7n/1rXPBv44jtgyco=
X-Gm-Gg: ASbGncvi3e+vS8eQm0toMV9yMaSkE1j6oh0+siRJX+3o6DadR0TQ0bsvgweEEEJNgS1
	nGebBLzqkzy0fd8c2cynSmRTYKfxbhyote9LUGksWRhMxz4CMKJhPmuzTD0QLMwaRAA/jUAfZ1Y
	Yjj+qo1UyNXOlXn6LZAcbJRv6cj/lzRetsdRxXUxd8Z2cVQHNAaZmCafFx5oNtCXpjWw3xietNr
	MksgyXcCTcDGA51MZmjlMGnEhmZ8fAnoOGx4PqY34Rb5g9pkGuLWjUcBADJQGp8qrwfjSLJFzsD
	VpjQhH1DDmM8UqMPxw0clZg4Uem52cnpzVuZIc2Pk+zmjD0POjvW9YVWik1I9u6e1AB8A1VXvHr
	nLaa7w+NBuJ9Zza5dLhTlSA3zwDKtKpkNipVlCj+lQhJZbsmJkYfs
X-Received: by 2002:a05:622a:1921:b0:4ab:5b3a:5f14 with SMTP id d75a77b69052e-4aedb9584d0mr162698741cf.4.1754044255854;
        Fri, 01 Aug 2025 03:30:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJTrlqeDQwfKaCw8yyW7SIaGimL48nbTtFzI8FnF8q1lx/G/dFdELduNg51Bv5DRhilMLjzg==
X-Received: by 2002:a05:622a:1921:b0:4ab:5b3a:5f14 with SMTP id d75a77b69052e-4aedb9584d0mr162698231cf.4.1754044255332;
        Fri, 01 Aug 2025 03:30:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca314bsm532410e87.128.2025.08.01.03.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 03:30:54 -0700 (PDT)
Date: Fri, 1 Aug 2025 13:30:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andy Yan <andyshrk@163.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Simona Vetter <simona.vetter@ffwll.ch>,
        Andy Yan <andy.yan@rock-chips.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm-misc tree
Message-ID: <cn3l445yzdhehsyyxurjn4x5stnyo34beogguupk7wsjqrloh5@d2berut7dn3l>
References: <20250716203115.6e02e50c@canb.auug.org.au>
 <20250801144354.0ac00f39@canb.auug.org.au>
 <7304e450.4ca8.198645108de.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7304e450.4ca8.198645108de.Coremail.andyshrk@163.com>
X-Proofpoint-ORIG-GUID: UCkpW6wE7kZEsV6P_1m7CBXXdY8AsfzH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3NyBTYWx0ZWRfX93qg9NRF+uKq
 QnmG7nUqrcoX4dTcvzfAuuhUBJgQpUQNJFThSRU/RCaOeWpQtjmMH67d8quoPonC3aKNlAQZ4HN
 ESIrQ+2R1AByIGN1R6Ca5/FwyJ2b/n5pv2EEFgHxwtbD7d1m/bfRZYRHCQ75lLaJDBWb8TLxFHx
 kAnLDE8O0urkbsrwNwWNPn0qE+iffupURAOzTOuOc7DVybbfUQkb4phxOUWl60CScCobasZYQ6b
 z5D6sTPDZZgcoAsfBOrei4X+9OJ+eYfpwhgrRnUyDlzdXeELr5tLptzEWj2e679mAhpbgavEQ/y
 xJmI5HNHmGuOym0E2GAwx2NKmaw+CVqxpKvBeSlhoorYVfPK6gQAgyEppDVZ0lk1g1hS8LYMHTf
 jaS+IM4YY9S0X9k29XJMMmq8YchEGeKEi989uQmOepDjBdeuXQp6FqMOnhhfE9RqtJY0tMZc
X-Proofpoint-GUID: UCkpW6wE7kZEsV6P_1m7CBXXdY8AsfzH
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=688c9761 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=rOUgymgbAAAA:8
 a=7bnOuvaNDU_t_1VFS9oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=MP9ZtiD8KjrkvI0BhSjB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010077

On Fri, Aug 01, 2025 at 02:28:09PM +0800, Andy Yan wrote:
> 
> Hello，
> 
> At 2025-08-01 12:43:54, "Stephen Rothwell" <sfr@canb.auug.org.au> wrote:
> >Hi all,
> >
> >On Wed, 16 Jul 2025 20:31:15 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >>
> >> After merging the drm-misc tree, today's linux-next build (htmldocs)
> >> produced this warning:
> >> 
> >> drivers/gpu/drm/drm_bridge.c:1242: warning: Function parameter or struct member 'connector' not described in 'drm_bridge_detect'
> >> 
> >> Introduced by commit
> >> 
> >>   5d156a9c3d5e ("drm/bridge: Pass down connector to drm bridge detect hook")
> >
> >I am still seeing that warning.  That commit is now in Linus' tree.
> 
> 
> The fix is here：
> 
> https://lore.kernel.org/dri-devel/20250716125602.3166573-1-andyshrk@163.com/
> 
> Hope that a Maintainer can review and apply it.

I tried picking it up into the drm-misc-next-fixes branch, but I could
not do it: the offending commit is present in drm-misc-next-2025-07-17,
while drm-misc-next-fixes is based on drm-misc-next-2025-07-10.

-- 
With best wishes
Dmitry


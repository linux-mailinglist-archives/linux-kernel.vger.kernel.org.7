Return-Path: <linux-kernel+bounces-746517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB1EB127A0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CE417F5FD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F7625FA13;
	Fri, 25 Jul 2025 23:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XESajguf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9685198E8C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 23:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753487177; cv=none; b=pao9oDL+kj1ggx5FOmnJriQcGCz7wjUpvdt/4lwA0JaxnO2kcUpEJBOMjutsotWOwtEBGR4DjrUmDhvxXhXxnOV7qj6MK/W6Tr1b4oi62j6zfI+T1mzG0EjhcpMEcT0ax+xKGKSrnpgQcrGdO5F2Rc64HfHFUaiMEJovYCj5plU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753487177; c=relaxed/simple;
	bh=VGfjHwPDHtiX/myFC+6KAMssTJ3atOwtakzlpA1dO6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQREZMg7Iy1NHAh234ltS9+bmujEg26SnwLrt1Dn0Cixyow7GLWlrStiAcY0mrj/IdZlZ/G9cNxBdNhvK524dZZBcUfIk84vzt94adPpNrGQ35F0yVeeGQNg0PBnWFshODFfJKSdbpCVozuZNqYH5wqnKJvzO2MmreqgYjfoun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XESajguf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PID0tB004704
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 23:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SS3LsZZUDvLKSs9n5Nw1CMWX
	GcUNaHHXYFnDw2nJXgU=; b=XESajgufqWZpi46/y4tVeJ3PW+PDX5TOLNJDgvIl
	VEwkVpva2gu2Osh/Pi8o9xX/9JEXPc/5s8IwR9ZdLUtTAejkC/GoteVaZrm/2LBR
	l7ho4qz6drtYCf8i1nazKxjZmQaRPG7NpZMB4N5pf0ZP/cYA+Q/+03XlMnKgdgka
	lldkmaeb/8ArWEx+IFAiFWYljr7c0M9S1Djhqxy28Wtvh5ktSW08q7Q7PUW3pgNN
	mUvO+wi/hnhofRR8hTjdFCQQXxxgQnZGj27YWq4v6yTHug4maU2NpPWxIsVJZwCm
	MChIqBdFjPx+OOVGxDFiXlmqSFVmhmXNMwxQGxKaBBXHeQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2kuuu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 23:46:14 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fac216872cso57954886d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753487173; x=1754091973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SS3LsZZUDvLKSs9n5Nw1CMWXGcUNaHHXYFnDw2nJXgU=;
        b=lhhurhXALVuHCZzFP17/2ZgqCPH/sw0JZPwRcZNOwrNrVUmWsPoQNngW+UAbkWktkL
         kA3Wnh2fhT1caYnFbtlC+FSHSUWLH3qwIZ0vWPvZRK7Z6tQ8NDWSwP5J9kSIoVhIGT5I
         p1STKkPgx+rYo5AS3tK6fmItg4DKsnjNpmMjKdqXFSYp55GXQyby8N5y9sF/5Cj96sn+
         WbzFWQw6hKdm8o2flePfH9KkQ36VLgJoQsh2B6VtsccDLZ4AQJgGHfBbMETq3vEIWEQy
         49MUt1KNhdbwY41LQBZdknWWhKW0qMC4UTWyZQNLDWZhSTG4gqGt/176V5kxQJ0R4Rar
         bs7w==
X-Forwarded-Encrypted: i=1; AJvYcCW/XNa5dk1l8WICZb2Af0I6LwohYaDngvxIJQNHOYHuf1uoNSPjBga11z1MELX8CkNOeAX6zQGXooKOgxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHfPkG/ApXWXc721qvmOELLIrS3pN+EafW8ErwrqXbT9xqSTiK
	EC6nbzo7o29P4oXiWgvyjQgtxkNjnIw7YDKiiHAroy+Z7eDH9WK8Pw7P+2kdDgk7ZLfC7hmq5el
	7a/t1M1xm6eGtl0P5+RtULvdDzZ2VgL+u+k6QAKsFcbMHW7e4mGXAM01+kTXKBOKr4gY=
X-Gm-Gg: ASbGncsds76DKAPUnpOQ3Xlt4M/Kxyg4iTZ3YkvOla0dWxv68TNS20mZcJj8wDj3LwX
	O0mrAnqzVfQLkJzlZCY7Xpjaza3+3aS7VRdX7PC7ZW+0PBFkZbdty+tyG6BZfFP4m5TVoJAA46t
	Cd6ud7j/SFncERSvUdoEoz/HigZhNdaYRgLmPE4lbtP9Cmd2vAv2U7Zo6MCrOBu9DEHxDUWyJDe
	6+Zpj4vyOEOaaMms38UcYxgrsyUwuP54H53hxo+RrKSmtQ1Hbs0/DCUmDBBLnpqettaDHt2xWpZ
	Ue/i9234SGPohw9/p4HbvqFFuDDSOE0W94HuvtcL/9R8sBFKajQbh5CLUHijyVmOZxx2/phJq9d
	Th7SyxFIkHjxLat3TSL4OIQn4kiHuX5ezOGLM/XJlFuYjIivV4QaZ
X-Received: by 2002:a05:6214:2aa4:b0:6fb:4e82:6e8 with SMTP id 6a1803df08f44-707206fc4acmr49971456d6.14.1753487173378;
        Fri, 25 Jul 2025 16:46:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Rfyw4lsowFfqFRh0Tw+94/AYPklbtjVdrBLBTfDDOYsM1V7AqVF33x8eAQDradrWbESlSg==
X-Received: by 2002:a05:6214:2aa4:b0:6fb:4e82:6e8 with SMTP id 6a1803df08f44-707206fc4acmr49971186d6.14.1753487172978;
        Fri, 25 Jul 2025 16:46:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b63363568sm180197e87.94.2025.07.25.16.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 16:46:12 -0700 (PDT)
Date: Sat, 26 Jul 2025 02:46:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, hjc@rock-chips.com, mripard@kernel.org, naoki@radxa.com,
        stephen@radxa.com, cristian.ciocaltea@collabora.com,
        neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com,
        yubing.zhang@rock-chips.com, krzk+dt@kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh@kernel.org,
        sebastian.reichel@collabora.com, Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v5 09/10] arm64: dts: rockchip: Enable DisplayPort for
 rk3588s Cool Pi 4B
Message-ID: <gmc6cx62knfffgiburzzjgkxifzjk4c5nh6gwjdtk3uopvq6y3@azpfwhmrsy2x>
References: <20250716100440.816351-1-andyshrk@163.com>
 <20250716100440.816351-10-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716100440.816351-10-andyshrk@163.com>
X-Proofpoint-GUID: PtOHe1j1gQHsg1sVgr0nuxU31RLYEHwH
X-Proofpoint-ORIG-GUID: PtOHe1j1gQHsg1sVgr0nuxU31RLYEHwH
X-Authority-Analysis: v=2.4 cv=QNtoRhLL c=1 sm=1 tr=0 ts=68841746 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s8YR1HE3AAAA:8 a=EUspDBNiAAAA:8 a=tTaqpbVWKKepMg41KaYA:9
 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDIwNCBTYWx0ZWRfX9dZ2PWZTi68F
 rxbj58G0vXGJH3U6g0HWIDjkbPiMziu6Ri6QlMBNetKJ/u5y73p5l4UMSw8O+fMG8jyQ1gJ6y2H
 D/epL0ZhI67qv9suhuiCGxIL1cspGHPD5PhD2gIoQGSSTApl90oRTGg1m6YmdLYypnBwNbwt92t
 EW8PaBlWR4r8xIxXUd8BgiNVxmI6jaPz8qmsUSXVHJuXDDmIqz4y0klRhZvjYS0yb30F630Hcn9
 CtcB7TOoQ6PXUwvDOjQGayin+pWtn04tk5SOvucflKq8u7gXvbhx4Z9yDGbCk52jH+cSS5VZeH9
 ou3YMyi92OsjxFbA2vATfxzIx52ssfK46VlQajOkKqkgP1V9pmtxkXYVCksss3/sr6Q6mARzh6t
 oHHamh3wdqYt2dBpNgg13mqZqlK8yFB0zlIRc/WO40JOiuTSykp+dWU39cy3i1swmF8ZJ6ge
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_06,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=806 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250204

On Wed, Jul 16, 2025 at 06:04:36PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Enable the Mini DisplayPort on this board.
> Note that ROCKCHIP_VOP2_EP_DP0 is defined as 10 in dt-binding header,
> but it will trigger a dtc warning like "graph node unit address error,
> expected "a"" if we use it directly after endpoint, so we use "a"
> instead here.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Sort in alphabetical order
> 
>  .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry


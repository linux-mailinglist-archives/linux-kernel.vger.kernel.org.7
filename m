Return-Path: <linux-kernel+bounces-768054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48217B25C62
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2AC189ED4D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2220225CC75;
	Thu, 14 Aug 2025 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JFwL5LfJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250C258CE2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154664; cv=none; b=eF1lu24AtBMYJ6o583FPC/YDGEU7xtp7XQosi8B2RgD/vUx4zb9kr2yT0SZ2OQlWMixr4rI+SEyMQfvKHBzaleueIF0qtvzun/1Yc+KSJ3CWkiqWVhoS0EvD0QScF5beh+evk7EDtlUZ2uRLzx9BHL06czYFiczNJPcj9fzxx1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154664; c=relaxed/simple;
	bh=2TlK50ADSnugtMeEFZsEk1xa7yMDhRG+pO5OGKlwYtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUo6xFi4h74NkSO/ZxviKcg35ZEgA3hB1NSpkV7M9qq5G/vXe0P/nTqNglT22bYgbjhFlwoG4vB4vYeBYcjmQUVdyM6VlyOR13uuqJJOASzHe/EI94fo5twqeykIc5rsU6fbbnEfD+GDCaSYUhHjj7KF3dRh0sQN2KW9LxSweBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JFwL5LfJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DLvfim002766
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WH6pheIOBCLhktt4o4IaE6vb
	Qet790mOAdYrq4OwLrA=; b=JFwL5LfJqGhhhv/hky0HR6Ild24Yz2XcjSC/F2Pd
	l/y9dNif1VXOMtJ6jtXx5rUwADOwQ6jsCgYGzoWmVQHYhK+2UCzNA6W5P5tBlEAq
	S03NXM1SShFXLTgr8m3YUKGVlQnUO/tWglYkqgM7Vd/XH8GaZA0AjrlNF7PDUHl2
	GoPb3FmLK5tvFXydN1otaGC4OtOiLUpZ/U6k9ZkVXoXVlQefKx5XnVC92htw8Rr5
	mIYK6XyLNzoV+/SS6UxmZjkBbbkYLuGbV/SPTqU61bwXztnJGN7punGrWrsb8RdC
	dcgvtdDhv1wd92kvz8v7i0rpE3xpo7pS7+jJIwWgitR7+A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxdv6p95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:57:41 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a927f4090so15312066d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755154661; x=1755759461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH6pheIOBCLhktt4o4IaE6vbQet790mOAdYrq4OwLrA=;
        b=L1OGUmQx208Qd7v2zVU8VelhrByO3xFUBW75dxJueuq42vm8diwCgM2DVIh/sOYe8c
         sorTOdrYghrElKedfwHaW5+wjyXzhgcNmCVGCr1uaozKcYddDo2g+BjG+hdapoYKE8Cg
         Pw60+HOsFZgHcHmRqXAkxJsf60QpPNVcD1K4Z6OcjsWWJluDX026VQr0g6xiU/KzZU5h
         83FsX3d8rBKqAEs0KrJTzVB3JPX1s8PiyfY69xbv9UuFSAoict8448rFVcuAhf3HO4nI
         m8trkweqTWD8jmm3TKF5UyEcd1gXboQjEdEI1NJC1Cwo/4Jc4R002nURkpIFdYDkAVXk
         vQ+g==
X-Forwarded-Encrypted: i=1; AJvYcCVH3+RBl1P1ASB0g6CEN9dD2U06EVji9RH14myr8NeTTTI6KzLGVKBcHOYMBcz1w9DtAGgVr98c+Hj7Hrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3LNKL2KUHhPIutnIw02IF67CYjYiaYKCtbKy9LXLUkJTmhvRS
	pKiraSLPxUiX9bHCFV9QJOiZTGga08Z5PBfsCmM8Ej+pfNtrbqX5sOaOaY2zQPHgt8aN8VnFT2w
	zJL4ru9/4US3aZt0AivscHYWrclffJyqB/zke6M86qFzfd2FAvKeW+YdZFSSiEXb6oAk=
X-Gm-Gg: ASbGncuFPyvcgNEUmc6UnnESOt+7ycOQwhhqu5J1am2ZjcsAabs3Plh73/jcdL2y7n8
	z9/Z8cONbCT3hRy6SZBv3rONEPYJt0GB3vRtG2zrxVuCd9QvBgr5z/FpwP9TSfgQS6CxaV4DvgX
	llwiKyZpo4XmxlbCbQmJumFP2OEnqHfdmT4rpLZK6mHuGuOPwEcH+FcVzxVjo41biIXdNz9flwZ
	6JRGgBjWeX5F0Sv6eCL4LZoKY3vT58KZOnvqCKrx7xayxVZvTqDgBpE7nFDE/zsuQrKDQ4HQUKt
	++RO6aoG0NVulzgDv0vr3PMn6cBZTKxtztocfX4o+SWlyJTnF3/sK83H/ZFCp/sAvP9Ia3VmTvh
	2ULmAjfXlJe0zsWITHKqLq6KD9fWneX4qFElVxN/ABUVP0oRbYP50
X-Received: by 2002:ad4:5fc5:0:b0:707:39f7:c607 with SMTP id 6a1803df08f44-70af5b4a03fmr31187026d6.7.1755154661106;
        Wed, 13 Aug 2025 23:57:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBZQ5FEsnMbOmX8KkrKa9+kBE6Os+GRoekHbqN1j+i/35W5BLwx3DVldiMtvDJKOME7rzkJw==
X-Received: by 2002:ad4:5fc5:0:b0:707:39f7:c607 with SMTP id 6a1803df08f44-70af5b4a03fmr31186696d6.7.1755154660637;
        Wed, 13 Aug 2025 23:57:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cc8d64512sm2420634e87.11.2025.08.13.23.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 23:57:39 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:57:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
Cc: marcus@nazgul.ch, kirill@korins.ky, vkoul@kernel.org, kishon@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        mani@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, andersson@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/3] ufs: ufs-qcom: describe x1e80100 quirks
Message-ID: <lj7qsbtk5xlmji6eknfv4ffrqypcsfkq5m7icrz4mvplncflpi@5j2opxwb5lft>
References: <20250814005904.39173-1-harrison.vanderbyl@gmail.com>
 <20250814005904.39173-3-harrison.vanderbyl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814005904.39173-3-harrison.vanderbyl@gmail.com>
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=689d88e5 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=D3Jz6Z15PsX1N0F7-5EA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: F-Q6lhtDq_HX3vx2h5S7cyhobpzrnn7x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX/Rys5e2S0ZCd
 Ps3mbnkrI4WhUXgcRtqCf42spSeCmQZAgaUW7hzxWQblEw/ntKIQtx4kAWkKppNCXPZUrYn7M8d
 Gjk+007xBxUAOSu4d/2r30zx3ccIEi93VCnoj2Hd+nRaYP0WXlzVY4tU5TPcbF3nAtp/eqUg+L4
 kc3wCRtRn4kITC8Lp+XOzho+yUb5leAGJrUvxY7GJ8qbenKdNlqt5qe2c4+MsfGtbj9rh+9TAwh
 Foa3KVmNQ7mQejqivlzVja2sd9w2Ks2QWr3TIpfGTkwokka1Z/2s/XkdEJJmh+o5JqvPvIN7bf9
 oxY09maaJdwovRNfSQ8uxfwkuLyDTNUWYc/AkVSTDu3rhIiZfFVupcg4h7zOUeFfDFWTYX7TiYZ
 0mLDYiGL
X-Proofpoint-GUID: F-Q6lhtDq_HX3vx2h5S7cyhobpzrnn7x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025

On Thu, Aug 14, 2025 at 10:59:03AM +1000, Harrison Vanderbyl wrote:
> Describe describe driver quirks for x1e80100 ufs device
> Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>

Again, missing empty line

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 3 +++
>  drivers/ufs/host/ufs-qcom.c             | 1 +
>  2 files changed, 4 insertions(+)

And this also needs to be split into two patches.


-- 
With best wishes
Dmitry


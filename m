Return-Path: <linux-kernel+bounces-819350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA8DB59F25
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E331899E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C655F24A06A;
	Tue, 16 Sep 2025 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ex4ZCxD3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6706242D94
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758043262; cv=none; b=B51Vn+VyL4RMzMnfYJdI5bgWvtNhswh7AOtedqtj2jgwMCuCGuPwKX/rLSK4t9A8OCV4rfJ0RdOf8jx34wurGJnCAzWXyP1LIGUPnBi0Y+eUGUzGV9hfnRY0PTlGwa62vokQFu/oAKybpH/0b/v53yGWukH08utlENLboLa3+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758043262; c=relaxed/simple;
	bh=woqyiGa8jyEH3DeNyAMHZMtu3yZCowfB9Fz6izEtj7w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mbMwOWzqCE8l47z5SmaW7zi+gEbfzr9Wxiah53Oqd9itsfOw5jJreJi0qsCDuxdjJ9Stdak9LfPsdD98pZ65inhidRwc32jMBUYF+cJwMBrjJCyWVx0zypiXDnfjHJVYRp/roqVqxN0gVRdRhnZymG4jWe+MHykViXjX9mRTXdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ex4ZCxD3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAMqOr020727
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eYDAH/UC6QbLLCFUlW+XxkzrsSdsC66+V/mf+G5BEVw=; b=Ex4ZCxD30wWB7GzL
	FQ/vVgusQwIiEjdQ+JfMBg5zaAu3tkm5FC9lMFqq1DVgRfqKILJna3DjEgUOAufT
	i6ONB75PyNV4KwWj8vEZ0J4ehD1MaP+Z/BrPiwz+TTuZofCBKmKNbc51dSNkSgiq
	Cmx30VJz8i9ODAxr0Y1iuPJh/9Bf5HpnTLafVMb81cyHuhQQ+El8W8TbERx0k4cc
	4YAPJww7vJWYbeR7LM+Sbabkx4v8n27eCeogVzBcK9k/2ToBimUb4saSFoE5Xw6X
	fs2YstGMX6O/0/9JkG3tP7Hyg5Hr1BHiVAadVYyuK373MHaqsNiB5yfOg0lHFoqI
	5fdiug==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496da9e6uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:20:59 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-770c2440225so72084406d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758043259; x=1758648059;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYDAH/UC6QbLLCFUlW+XxkzrsSdsC66+V/mf+G5BEVw=;
        b=UuDuJDijdjzCnyOxET42xslHkCwy369K0GY2PDKk5aFLNORKdlWgvpFQsYqhA4Br+S
         Th6OYVyQvKg3PhwtfJy8t4CrsQCr2GviBh4cbSv+tH65Xai5LFWas+KEkZBLRXowVPpU
         MS7gFcNnHqFTwrLZNyTnpu5vacCnw0/r3KU0iBeS/m41PVU7EXXIPqfYizIzO3Y/1SRl
         i3tC/j4PUKPZMzhSodh+g+CeNte5njdWlQnDRerl2V6BfLiqXYOutmksY9rguTddHH7i
         uDsQyRTCPQUq77GoQd6ZVx0ResIGIANI5TmAi7cVq6HSkTp4TVyI2zY5OUg+e5fgpoV7
         qujg==
X-Forwarded-Encrypted: i=1; AJvYcCUfX5fK5CoVp8B0gPL5C+FtyTZwDijbLjlFQ8tGZpaDdELSP8iglO5kEHv3D94SpBiAWQnNyif78+gNmwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4rLQ7+tH/vcwXyYHbyp3Kske9cgFxXNbRvDDJlgBNfm6cRW4t
	wxin3YSrt2Oc7VuzOAnmd1jIVeXIiXBEGVQ7DuCQUzm9jfYkDwXiPqeqFiwfiFyZRCdT9UY0L+f
	oLquusPw7HsPIL9DyeN8c6PetFfc9FZjzpNFB0hE0gGzP+Y4/nAGspIZbWrobriDRDA4=
X-Gm-Gg: ASbGnctDmnkPepOfHHzXapsFzf2sTXCZdp4jQ0g45QTbPWdmpG76P2iZf7MNGcxcI+I
	BDaErZxfgD62CzUbraYa9/Lji5MFaXJ35SVu/lB/WcdtMNxvzqvMNarc4lpRARAq443RVA9+/lz
	BOiHloW+8JRNg+t5JRnrWwQ+ytZfucMwxSBu/ZjCnS6SM/dmWT2jcTTRijGISBmFgV8vCpNCULD
	JzXjYPOUGdvMQ1Jy6wgqFRbJ9c3aBR/n1P49JCxtVCAyJbYNb5i3D+iQiUl2Vg1PGPEMpLXUsgr
	x4+YYRMSPd5wQUkcMRaZIjVzCBRFe/i8mGxFg0ouG6YyvDYlz+1m/axVHeXfHaVzgE/LIk8HuEg
	vC5YpV/pOvaD8Rl+Tx1hRQjKuSrAsT7yBO646YoJ4TTO2d7ZEsISg
X-Received: by 2002:a05:6214:2621:b0:78d:b474:8e3d with SMTP id 6a1803df08f44-78db47490aamr29805446d6.16.1758043258730;
        Tue, 16 Sep 2025 10:20:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwsDWIhpv5sfJLJ/QUxmfP6fT3Tp5F5w97C0xbz2hC7rFv+42ijmLAhsNS7nYcVWrSQnONyw==
X-Received: by 2002:a05:6214:2621:b0:78d:b474:8e3d with SMTP id 6a1803df08f44-78db47490aamr29804886d6.16.1758043258120;
        Tue, 16 Sep 2025 10:20:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b5fbdsm4458001e87.30.2025.09.16.10.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 10:20:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250821-drm-client-tests-v1-1-49e7212c744a@oss.qualcomm.com>
References: <20250821-drm-client-tests-v1-1-49e7212c744a@oss.qualcomm.com>
Subject: Re: [PATCH] drm/tests: make sure drm_client_modeset tests are
 enabled
Message-Id: <175804325706.600017.10635464864043567835.b4-ty@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 20:20:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=M+5NKzws c=1 sm=1 tr=0 ts=68c99c7b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=sYf7BZEc2M3GbN3TUwQA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: 0RJo3VnJzlKtv1UytRgwcAi4T4lqIS0r
X-Proofpoint-ORIG-GUID: 0RJo3VnJzlKtv1UytRgwcAi4T4lqIS0r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA1NiBTYWx0ZWRfX6X+4NIMFG4n7
 6JmSJASi4qCLsWVEfTqjqBH9W2SnZcsxAeTpbaiSwFjs1KsrilK6RkBVEohyuw+PkTlA8Rc+kVb
 xKrhYYRVdafE5/UICSx+A8h7T0IGyPEWI6vJzMwpxQZz7k/C2XXXbS5SGEjHCybhXzgOkBXkNwf
 vKqCY2RskgKTWm7iYbijfNC2DrMjzuyByT6d7fRGJ5AdYSIsWu29EVHWrW8EPMDaHCoFcR/Q/Ml
 DbK06+pDaOVbkGZJTOEWosMM7YnFhvp6f9xFJrBhXeYFtO5KnXH+UXZD3sf17MZrzEQvZhF6bGU
 UhU6LkIdwVYQ2t3gNl8Vl2TPHux6eN+xFomD9sIxGrI8imhLFwv0SiLNtKv5DJKxyRBrwofvc7E
 52nFTj/i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509150056

On Thu, 21 Aug 2025 14:25:06 +0300, Dmitry Baryshkov wrote:
> Default config for UML (x86_64) doesn't include any driver which
> supports DRM_CLIENT_SELECTION, which makes drm_client_modeset disabled
> (and correspondingly tests for that module are not executed too).
> 
> Enable DRM_VKMS and DRM_FBDEV_EMULATION in order to be able to run DRM
> client modesetting tests.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/1] drm/tests: make sure drm_client_modeset tests are enabled
      commit: 4db6e24f565b60a05c762554c05d37f780fe4406

Best regards,
-- 
With best wishes
Dmitry




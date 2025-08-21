Return-Path: <linux-kernel+bounces-779554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABA9B2F58C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21AF1CC5C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5253074AC;
	Thu, 21 Aug 2025 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nt7DQmg0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799532FDC58
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755773014; cv=none; b=uCXoJuqd2eFJOoS6XgTnhmJ3oize9pbGEJOu2L4S9RfcPXRPRsaBYmfcU+VOrCegc2uiRhs0QrQPsyhScjJQ+t4ODmsEd7sw1D+Nlej9G8FStRWgm37um5y0AKg2IUivQoxxDVbzaWc2fMestM8/Decg6Na0lYxWFkwiTLfZayo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755773014; c=relaxed/simple;
	bh=iNhYyKRVUX7GUwlgBguIkJJH2QLKbApf6qUZneezrgI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ewhj79LRAsa/TG2HYQds8a3h1CyWc8ULjNLtLX4NG/1MogYSlJgs+DOjz1DczGeS4lng9eo10UYhS5zhWl+5H2pn+C0Hb0kGJavRQMa+KjvHNb9vWYZt1loCoO/rMJlqb9RbMwLxxkdpfmTmp0pcwJv/QHUuAJae1I1IMKfGeco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nt7DQmg0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9bFZC030651
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kiZdVlOBBo6Pgbbgd20Jib7efJ//o3XH891vVFgq7LE=; b=Nt7DQmg0d+IiVhI8
	aoKIua0TMwzmKrWurHqKrX74EpdPyDGV5g+3J7WyPbYUawMPbNhKhmUsp51A+tDi
	3N/zBSoQZxOWBFdj7T8tM4295sQQ2pwa+QZiv2IksNzJwB2iqYAWIYIKozz1lOAX
	VkCPARsdNNSjdQ1jwct5OhuHEEoVNePs5HnldZlfVUJj9Pt0NphuTKbgq5RBxilb
	Y0WlT8QWNy7lyt/YNwN8OUTbbPcoz6blZP7XTC6gCxo+gsaFGD+9hsEvo4n0xHb1
	ZuwuE0XwPooTKE693xoIoqLYo5UiupXM51fmEvkauMvQWSsPORTt7c00Nm2k1e6r
	a3Kwdg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a56px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:43:32 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70d7c7e9709so23971746d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755773011; x=1756377811;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiZdVlOBBo6Pgbbgd20Jib7efJ//o3XH891vVFgq7LE=;
        b=clifh/NUX2EIKjxLuBAxX5etvKtFF+k2NJbdnTiUFtf9XkV9MqJM0K9Vxud6slALQu
         u0/ln3MrwrPKO+06D7Z9HwEMWgeMzDYsj3i3UW0Dz7vwuZ0h/8/5ltGz9VLnwtbHonLq
         bgja4Az8lCmVKGQFJQa0pgPwoXBzywFR7mhDDWDP2HvugJnKssorhDiYUmxTowhD3VAS
         E5vRPDAhFPeGFPBLN/lPaGH6YX6519UKlnULaYMpYk3+2uL28jXpGnyYJ3fJQlX1Pjmb
         ymHQYmeaHeE3Ifm1hubU+UfMEl0XpbBWsUoR6SA5R2ob/NboUJxiT6riiAwripPNhcgH
         EhIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2X/X8Kp0iNpeAbkEPJObKyJBSwgj7q3kIgHRjjWu2GTJCs+zpPwYxNscijNIN9adz2qDig3LcxdVKUvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4vXmnX0Ht3r5C4FdYLog3x1MztvTpWJ85Q+yiYTlCadfl5YKE
	E54vEjU3yvNETeAfSHC5177vW6d/6KjUspTLriR0pQEY27RfL5SoFHItcdRmsmMKsp2TTqwFBNy
	vyxoNUNvB83Szsi0BLw+nqgKe9Hu8E2BxKVRZ1pv0irviw/ObSViSb6yg/BtXdg+CeFQ=
X-Gm-Gg: ASbGnct8owOcmiH6Q7rpj4ZmKtuNrrlol17qaX4kzwJucO/giK7uepvclGk4o2Vt6y5
	kYO5z5c8ywHCqhRYFvAiyak2LEGsqivTcnU39pNTbpDWscAaIayFvnj3XRdJ1kwKGkosEpX9zH5
	5Qiacceen2RmDDcjFlSiIuK+C7BJt8oXVB/woKhenkjDhP14ehf14JcW0SDzdg9mDNHiqxchc4b
	HQ3B2gWIJ5wUc6NTcMotMYssLYA38a7kEL9Kusp3o/e2QLxfp5Cvgnlo/hCPPzpxJj8EJlGgUPS
	FdgXm8wWf/uCaJbD7qNO2KQthsh3PDLQYnIK6LBJ2CQAamN+L1c8wX8o/WFI2mwG+HGNdHh4BSq
	Mid6j9Oy9q0Jh0MxjwzPWcMDCjbBCH2leJM+TynUX9Xg5Fwj3Ah0c
X-Received: by 2002:a05:6214:2482:b0:70d:84da:7bf6 with SMTP id 6a1803df08f44-70d88fdee3amr16676416d6.35.1755773011170;
        Thu, 21 Aug 2025 03:43:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEIb/BNkoBwI1UH7zDCawOAkuRUeT6HjaNqCMpBF16tkeSGer7aA/PKLuIo2jJRbIHcb+7KQ==
X-Received: by 2002:a05:6214:2482:b0:70d:84da:7bf6 with SMTP id 6a1803df08f44-70d88fdee3amr16676146d6.35.1755773010672;
        Thu, 21 Aug 2025 03:43:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3f3eb8sm2976726e87.122.2025.08.21.03.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:43:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Suraj Kandpal <suraj.kandpal@intel.com>,
        Arun R Murthy <arun.r.murthy@intel.com>,
        Val Packett <val@packett.cool>
Cc: ankit.k.nautiyal@intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250706204446.8918-1-val@packett.cool>
References: <20250706204446.8918-1-val@packett.cool>
Subject: Re: [PATCH] drm/dp: drm_edp_backlight_set_level: do not always
 send 3-byte commands
Message-Id: <175577300839.1899572.13934617998352604161.b4-ty@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 13:43:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a6f854 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=A1DUZ2MENomNuKwj4w0A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: a2RVk8WRwAzpLdorsI0Fnq6MBNLgx4cI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX+t133cL0VoNK
 3a/tY/A8DFuqB3NvJc+sx6p0NM6Dx5uld+RbestylOdr9I+4z02pbBJnWtEtdbON3bDT05DTRgP
 XCLXZIAp2ja8w5kgOfAWDsHxRzZ+9VpMU2bKJ4RPGZHe+gr2Jee7nDZkgApCMr46VMTF067QIkJ
 as1IbBKrB3UUYb5Df+pEX4Kgf3QaYH6rjSNstn2ylVNL1w9RmNGjG7Nd5FpBsrOjvQwXTieph/z
 p/4+x49jpXXdbZV5ljW2uCgMn2OhTDtg4geEGpx0QcoZ5A/fh6TFChpeZ7n01xhaL2ZvsfR3dNC
 wz6Iws2q9pc5l0oZ2UVZhAyJIZRi0JM3DezPaDthdnS5B01Biwa6M4x9ODrgN8XOooWARephglK
 3wufAi3ZC+3a9ELxrZogCMdwAjd2Og==
X-Proofpoint-GUID: a2RVk8WRwAzpLdorsI0Fnq6MBNLgx4cI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Sun, 06 Jul 2025 17:42:24 -0300, Val Packett wrote:
> At least some panels using the LSB register are not happy with the
> unconditional increase of the command buffer to 3 bytes.
> 
> With the BOE NE14QDM in my Dell Latitude 7455, the recent patches for
> luminance based brightness have introduced a regression: the brightness
> range stopped being contiguous and became nonsensical (it probably was
> interpreting the last 2 bytes of the buffer and not the first 2).
> 
> [...]

Applied to drm-misc-next, thanks!

[1/1] drm/dp: drm_edp_backlight_set_level: do not always send 3-byte commands
      commit: 4aa8961b1b9c7498550b41168a91cf1558133dd3

Best regards,
-- 
With best wishes
Dmitry




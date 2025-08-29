Return-Path: <linux-kernel+bounces-791759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DD4B3BB92
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5825E86B1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C70431987E;
	Fri, 29 Aug 2025 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dHa/sty2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25FE1EF363
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471477; cv=none; b=IWHYjGZaCQ7wud69MF9ATCZyIu6Oo3l4qQl9YqC3Bc5kezrQnyMYVjAQIbwCEDrFa6HTpJrMp1AKT3l9Vvki9pNcBv/Obg/R7k7MQ7oXDtIFXHXWRMrItP3tD2bZfuXM4FDQPwTGjXzCfFnBJSJRdHUr8hjYsghRzKsJfJY6mxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471477; c=relaxed/simple;
	bh=VPZbKNLUQTQeRlvyJ3GOH3k/p3oHJ4R4MOJ3vAoGdcM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mhAfDWW9UsWjGLODrCmRXsy6edfYSRwIVshoVffgo3tqmzVOWaPRKmzzX1viaZftEi/LGNiBqGT9rNB1OUZ+74yfYeH0khhTfQ0PUlGWr9NylXCObFGpTlvKnoZFNkVoX3unWaTxuRh78KNEgX/kHuVWe+2bPny7Heq28kPw/ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dHa/sty2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T85QMm032452
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OM5XRmALpbTNQitrR9ghy0nuO7Xiw48Vs7z2c0FwRTU=; b=dHa/sty2zDtjNNrT
	2+ydEmn71OEmzuuCbyEWn6xNDKNUn4iuWAzgLOO6iyPX23QBeg5FRsE2gq+ayGNe
	6IvLv/6LFYVaLqv6L/e2thkIQBDPTO0nc4x9qZPutMtEUzFwEGA5NYGwxnnrdyey
	xEHYE3eWd1vuJ1Jj5JHsAzUp9f5xsoq09DO2LgsOxOJCpf7qkjeIrA4MBWyz06cy
	/4VzI48MFZzw/ZG3mfQm98o1G45HVfgRyRi/UrkKSRj9h6k+cElWzhMR9Gw4mgky
	fukN5GFRQsm04u0wRIA5/BbVDwCfBvrbMhECYwnNWNsBxuS/BlUl3kA8mb9D1mse
	nZBhIQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5un58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:44:34 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70de6f22487so40264856d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756471474; x=1757076274;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OM5XRmALpbTNQitrR9ghy0nuO7Xiw48Vs7z2c0FwRTU=;
        b=LHEL0BTu5OmdisWgShc7rPTX/Ru8x2NByotvUZramzB83Q8X0ihj88AP026OynlfXo
         fg8/bNMV+hrdDZQe3khq6FofRM7l2xEZnitY6RgmQwJbHXzi86mYTorcEVNnpqfade+/
         Mod88CruSH+ZgsgQx6b3fdiDLuTh3xwXx7oetmSe+sap1jt2/56n055PguTkK3V32ZdR
         GrwCxsmk4vw0LJnt3QVa0QMMjS/8cDeHcfFAfLt25wjkiBCu2BYCd8562MJNS7YvljqA
         buEk0T34lAxOzoU6lJqbIMrhBdzwXZkKnmUvSf66zHp8fiK93byU5kt9U5CaJbdYBjMl
         b7mg==
X-Forwarded-Encrypted: i=1; AJvYcCXAheYMFjEAAhoxZS5bFN8Il128aihtM+zF0kObC4bXNIrpjXQ2uNjDnvX4FpWXkp4VZmsESbOorEoqkTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFRn5UuaiWhJlNWKqSrgbVwIYsmT7RkwbJM9p3NdFVRSYcQjZf
	pelwlpnxqeR4YDJjJ3sdVdW6VKrtEzvf/pZOXNopXJTAKLTZ8fcrhsGugrpzs1vQAx3KPJCaCv1
	0iWIZxDV3t5cqFA7NDaRn/KhsxmRrM9ohScnYiOprTONKoPenysaj4tBCGQ1lISwYE6Y=
X-Gm-Gg: ASbGncsOslV2TrtpKvA9e2ojMtQIECNnO6N+Uye59TP+p8AdbnYMzKlR69aIizW1/78
	pDEaQKLGghE5phynjXobJB1QtACKuB0jTAfiBFnRc+P81GRVKSQxczZTQuEQk23MZ+uBbWRM0Vr
	w9NKglxYWa9lWlY68E0c77a1JYxXi9e9rMWvohlITqeQIvKWsoh7xie9mksMu1xbtlPvH2TrQxW
	XsMlH9Vo1A7FZ7ZN1PpsYNyBktggsxb+DdGuitM2aoe5hlNLsj9bShL/sb4lj9r9r2dQGXP+8Lk
	a8Zd9Up1ggLBtC2MzkNBvjwWyzhauBVIBmNnA4Snfj+kEXFr2gfCZrJIyFHBGdsvHhaSOzXiFV9
	jqQJcLxf4z64+EPTsGjTDHxYDi5gN50IGlVmTWOnlK/ikOQoBqMVD
X-Received: by 2002:a05:6214:2345:b0:70d:f7ce:fe5b with SMTP id 6a1803df08f44-70df7cf02d3mr57827576d6.57.1756471473834;
        Fri, 29 Aug 2025 05:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqiiEbiwWzc97h8HM8qB+w+Kb+eEqt8tEqiEr6/iDIqeknHui3+C0lMnaDZ/UaSsYiDc+Mqw==
X-Received: by 2002:a05:6214:2345:b0:70d:f7ce:fe5b with SMTP id 6a1803df08f44-70df7cf02d3mr57827156d6.57.1756471473250;
        Fri, 29 Aug 2025 05:44:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f67a50435sm593782e87.152.2025.08.29.05.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:44:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250827-adv7511-infoframes-v1-1-f89b9690f89c@oss.qualcomm.com>
References: <20250827-adv7511-infoframes-v1-1-f89b9690f89c@oss.qualcomm.com>
Subject: Re: [PATCH] drm/bridge: adv7511: provide SPD and HDMI infoframes
Message-Id: <175647147213.828962.3232012241776711078.b4-ty@oss.qualcomm.com>
Date: Fri, 29 Aug 2025 15:44:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX1YHM1yadOc2F
 30pyOESEMUIpNf7CXXUFgXmWXIZ25HQlQt8D+lvGV0IPVeCnG4KEGKYmzg/z5zM65odQvhExU20
 GCvE0gxiUdwJeboyMj+A1OjMc8FS4pwMVYTDSFON6J7mQGSsy96FeI3KWfGoAdXNOaxCJ7VXJU9
 in4OE29kycyp2cQFn2BFCW74SiPXYqTXTCWUMEEw4ICKYWRcaBI1WI+Kfe3Arx/rJ7+Ll/EOu2+
 XeDLbVWvgB7cvOQnTjxCFMq1EXktc4RDRlXYDMJF+NLV5DETd0WMx6J+BrK07Rk5Ms7t1s587Gi
 GojYkLj7vpDA68/KHY8xD7qeQhZozo++V2nDbdvKgD2Km1tDuFNs305WWhDYztk+FmHaUakUOcT
 I8pzuqFs
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68b1a0b2 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=CDa_aIuWbD5CBshxjBkA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: bKVgcTE-YN8joaGfWgymVThVQyO4rzZI
X-Proofpoint-ORIG-GUID: bKVgcTE-YN8joaGfWgymVThVQyO4rzZI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Wed, 27 Aug 2025 16:29:04 +0300, Dmitry Baryshkov wrote:
> ADV75xx hardware supports sending SPD InfoFrame over the HDMI link. Also
> it provides support for two generic (Spare) InfoFrames. Use those
> capabilities to be able to send SPD and HDMI Vendor-Specific Infoframes.
> 
> 

Applied to drm-misc-next, thanks!

[1/1] drm/bridge: adv7511: provide SPD and HDMI infoframes
      commit: f4028ef65dc4fe9010bcc017597fe0fea6479097

Best regards,
-- 
With best wishes
Dmitry




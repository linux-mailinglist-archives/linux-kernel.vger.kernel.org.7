Return-Path: <linux-kernel+bounces-728465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4D5B028A7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3977CB4022E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CE8190057;
	Sat, 12 Jul 2025 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P+9h6yKf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6431155A30
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281915; cv=none; b=KwxFiLgO0cnzLkgp9G9DGEQcT6eMEuLjSCUp2fSuwh+2epXcwx9+nJQyQxjTeLGPx/sMHaUQuK9DhsnwFo8b2QGoG7UxOyfB/IOML/1lrig/zykw3ZCOlTrRVqEqmUn6Pl47OuLRUcDpMhHGguRRtayCddxDv9b1moKj/rkgWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281915; c=relaxed/simple;
	bh=yTgqnB2dprf/Nj1ZzdiqTo9frUxLDJhIMuoIkqdGswI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7x2Vs4IpY4OZdztYJZs5tngrhgUqhIKOyVmXR8C+tsXu5/iqVoBO5cXjOv3ffQLfHuIk/xDYwMAQAjdLPZ1c1JPVPI6W9/GukneHNyv0JHxcqTHPzb/N7Hz1Z3/sBh1EZgffKHZPAqrWF4LXcKvJMSFj3HzRogt99YAisKKn0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P+9h6yKf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBLUPh007975
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5mAPtKDSfIXrr3Q2q4T60fVOj5r9JaUUy2rjzWEDKfE=; b=P+9h6yKf/+JnoHlp
	SeY/HCdrAxxKpGLQjBnlR/RLS5NAtE5+kJ2y/7JdFzZpukzlzip6ILmczpwcYLBY
	suQLGyP5qIp9aWYhn25yI3tf4afl9Dg91qim/ubJmCIlXKF4fliiYWcm5OphpL4D
	B6FVkMGPcDTveXG7Z/llJvkZ+u41qKFwWiGrEeYwi0MInTn1IKXfQWRc+f8RVVig
	AufKV72pW7RgZYO2uSnbnjyjA8zLHldwk6lTlv+3cgM59+LQxTzREAL6oQKWYwS/
	Pde7TQrN3p9z9NFMD70ip/9Dl9252QFD696tJfwh+O16D2XtkH6jOIlidjrpdjzj
	uyDXdw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smcga6s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3139c0001b5so2472954a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281912; x=1752886712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mAPtKDSfIXrr3Q2q4T60fVOj5r9JaUUy2rjzWEDKfE=;
        b=KVgLYbLVbhXfcnUp1fwFFg9Gsohi8ziCUUSonQmSJ8yCSebG4dLLPoEStz0lHnDte6
         Qtw9Rnm/6AidKJSCf6otIyuJWqpTzzpPMb6d9FdqSF3nvjpMeXKV8SAlHkiEu4Jr83C7
         3uLsGr6PXOAe/iQIGZCgc/XSK2/rr2zzsHuM1kBbM7FhIkh46y9RG0BYzbR60azQiN+6
         9qT1/MJG1+hL3m7ywodJZhzY+fEnucGp3csx87+DUBXqaIswdWyUVdKxHQyRwGK1+dJu
         xtaNVyqAluUAxNUOrFYkuDvp6++Y5Zp2TZDt0+/StHCVoRLsvRxQWmVX07u7SetxDXGz
         A1BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI24vW6rBFDLonSN329Gkk1362FMmq6Vhr4v+LpdWMDyR4iUWFtQRQNBSlk6xd6jc7odjdd2X10BdbWWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoBKxU2bWi9ldSMj5yz3zsXwnYyiR+vQeuklEoCSzCwqEeLq03
	UALFs/WqvHc3R+3GrPToYMp5t6XtYFGBT2TZ8nHglcvHxUJ+ywyvNMsEDwiY8hIAOVabCF+E3Kp
	UMRI56vucto2PBKXiwbCT0GI9OV0LPt+K0yndUVHygNKjgIthwxPkXPUbzjRFVfFHIHo=
X-Gm-Gg: ASbGncsOH+JBE+dUbX7YRoJKo5PElf3ochK0dDOVPbJabwWwnKzppMWvTj1M5JrKjpn
	OOLC+CVFyNNQ2nUuCmw1gRpdbxbz/p43Xfxt/NIx/eBjQPTBSImTejeg2a696YUr601TMvecG7F
	X9iOV6/YSrhueOxBkpP9xQM3lv6xIcoISs9ZvfiB+wL7Oe86xjdMo008niyrr6pEi/gOQr5agGq
	shj0mWfqUbxQm0bOU2khUsuJQZse0jFlpDjpPb2E+Bi4tsGhHBieE0XScoPEp8EG4G07Rft72qU
	EYhsy/ENDYe6Hrqqf89EfV40m6yHDCDE2fz+AO+MzY7S5rKuyDTM8cfiySr9i6mZKi/k4xMcJBA
	rZKjpcq/MbncqPLOso/cuXakk
X-Received: by 2002:a17:90b:5404:b0:313:5d2f:54f8 with SMTP id 98e67ed59e1d1-31c4cd148b2mr7794401a91.33.1752281911656;
        Fri, 11 Jul 2025 17:58:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq4f4FD1KyBoQ3RY2kpDLTIO0B98CWBMG6U/eFOvveZwt51uaf+y550/LpdWY6uMhEFIxlSw==
X-Received: by 2002:a17:90b:5404:b0:313:5d2f:54f8 with SMTP id 98e67ed59e1d1-31c4cd148b2mr7794374a91.33.1752281911279;
        Fri, 11 Jul 2025 17:58:31 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm5202274a91.1.2025.07.11.17.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:58:30 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:58:08 -0700
Subject: [PATCH 03/19] drm/msm/dp: Return early from atomic_enable() if
 cable is not connected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-hpd-refactor-v1-3-33cbac823f34@oss.qualcomm.com>
References: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
In-Reply-To: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752281905; l=1248;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=yTgqnB2dprf/Nj1ZzdiqTo9frUxLDJhIMuoIkqdGswI=;
 b=yjOQEw8i14tfTRd06tsg94/QUzhqjZkPogQvCBkFcs9cMN7ePscuKKGEamrhgXNfxOaO1Hkxl
 z+N10idpSCiD1fACySqT60gko49fsibuORGnQlrCHdURey5hsdsSXbA
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Authority-Analysis: v=2.4 cv=P7o6hjAu c=1 sm=1 tr=0 ts=6871b338 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ONubTFmf6e6OPp213KoA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: zuAs8tvsA8pj1ij31pHQZmYsp7emmGKs
X-Proofpoint-GUID: zuAs8tvsA8pj1ij31pHQZmYsp7emmGKs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAwNSBTYWx0ZWRfX8oRMLdSN+JSg
 anhcWZ3I0RjZS3I5ODwUInH4z6GPrElTJ8rZkRKVeXlR8IN7aaPuwjOinNldMhAJfo7GQ6h+VF7
 jKwwZSLMDRqjEpb+ncAC0ewhtD5iBBlk+3CK35MEPkuIzz6EhlbH1YsoXCuMIgYucKtYNeMBidu
 PDJ4sc4tX6UWU+D02MFJrpg9uf/y9taMd2iuto4qVqdSPhJqeHD8AWTWe8TCW8sFTFIAjjRIDow
 quDNeFHXZAM3oFST7+s8jPoF7PABeahOEvzH9tShKVBIM/TjeBOR5LeVNWg/idTNsjkhtZxkLrg
 ccJouo7TSkdWZtgVAl5lKk6wQC4TKQ8d9dR7t7f1OBidk1i9qaHq2qhJE/BbqLT/HBQlz+ep80z
 Umqd36YnmH7x6lSDX37YH+GsUhnyomII4hOs7zHUYhwgYoi3wvpNn1pXjkhhS9R0QPw7Uo+R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120005

Replace the ST_MAINLINK_READY check here with a check for if the cable
is not connected.

Since atomic_check() fails if the link isn't ready, we technically don't
need a check against ST_MAINLINK_READY. The hpd_state should also never
really hit ST_DISPLAY_OFF since atomic_enable() shouldn't be called
twice in a row without an atomic_enable() in between.

That being said, it is possible for the cable to be disconnected after
atomic_check() but before atomic_enable(). So let's change this check to
guard against msm_dp::connected instead.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1072b5fc00ae..fe38ea868eda 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1606,7 +1606,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	}
 
 	hpd_state = msm_dp_display->hpd_state;
-	if (hpd_state != ST_DISPLAY_OFF && hpd_state != ST_MAINLINK_READY) {
+	if (!dp->connected) {
 		mutex_unlock(&msm_dp_display->event_mutex);
 		return;
 	}

-- 
2.50.1



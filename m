Return-Path: <linux-kernel+bounces-728466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 588F8B028A6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB071BC393A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1575619CC37;
	Sat, 12 Jul 2025 00:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D1etFXxm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C001714B7
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281916; cv=none; b=Xlw5v+1HKntWSFcNtC6syNTFaQRzpA2ff8ZrcRRZy86DsLbqS6uGxG+qZTyHzBUcZUBYifHzEW+J6QdKmBL2HjEyfId4r9mve3y7lNjVyko7c4xyza7x7hsyqaZjq3oOC+c4J6JXtNed8QlywHoejg+rqav/cdK+IeTpW71raSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281916; c=relaxed/simple;
	bh=vZuH9eQYbTUD9s3DofshWE4scop2zctQHVv1DwNeHk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mBQWrsLxU5xJSUmxor4XuQnwfz5jIHVCMWjVRuLJfiO3Z1zf+Xn8/xkFtA3g12vxVyWbz3Og8nt/U2TX4meXFl5rArgTq3RT/9Ar4Hc8J2PvMS4uJgM+9Ro/MSQUSplg97lgjqtiXwscboiXQ3unRcFONwZA3hS5cK4PwS/Zy1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D1etFXxm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BNYVCo003817
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6E9jQkxkkxYeO4ddlwUOckDDTm7H+p9IlxlOX6Jevp8=; b=D1etFXxmHyKRaxoM
	bJ6v71QP1LS9plKKCo8Q5z1fdSomHSjeU5sXvAH31+/zLKrSb+3BZSlnXkEepOkO
	M0IFP7jSc6e8s47GIf5EU6+ZQvcYOxQkr2qawl9M+dtwNO3zclCcyUXlyM+fh3o5
	2NgpIv/Bc0UHfM7JiV8oaEsv9mLv7Kx+EjwFCYlN3N92D55XTekQp/D/c5+8mOr4
	FIGu1wOaLs5AS65CYX7KWndd4b2F4VUdVuDb3fnAC22CuipCTxsBkqrbarty0ikX
	EYu1q/8dZ6hbw5j7UqtYdE7IPriBYAlbXkktzDh6I/36h7BSbQfDtnImwQXKCWEn
	AdLOWw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbp29w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-313d346dc8dso4112872a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752281913; x=1752886713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6E9jQkxkkxYeO4ddlwUOckDDTm7H+p9IlxlOX6Jevp8=;
        b=MMhFQ1CuaipPTP9nh/F9SZ7y+evNM9rl2MsHah7YgbatMjo0sVRe0etH3SvCHN03Yf
         A5GT5JWnX/APTPPw3LQ0QJg+u5cNkSdlZ6mlNoeXOVVte4td/YEJmS/IYR1sjhiJXjxN
         KIfLIO/I9TxmTSqB3FYCKdZ+3axIrdOZc5pzO1Xc5X+OC0Z9r4TSgOJXm0Drpebcpm0x
         0lqd208d5uLOHebauRa7iM6vJOPUA0lgGbsDklSN0bjNfIgURv5HQFVrYjKIpgl7/XEj
         tBUM+GJ/qamMnfdJYmCV+rhOb/GLZ3W2wTjN5umWV/PvaJ7LYkYPYyj2yAFQHD+08yPB
         eGVw==
X-Forwarded-Encrypted: i=1; AJvYcCVhgY2KuJcSJ+QPJjYH6Kq9keLHbTRVnq5CxXKhIiC+Tvo+wXz5erTk580XTNr/YpU1eMRb6RExJJbHgug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDj9ZyrvIZRGPZfZPoTpBgYUSiap8yBvuZw8Y2dAH+WFDTElKu
	4mLqnbh3ZhpCr1k0+0ooa+ofaTqs0WxmVMgCGHhAsunMpHJd24FxZh0sEM3BQmCkkF0RqwpVQ20
	RqldMpoN8C3iMP5NxhkGVNZgIMM40Io14oWOMke/uuomnscf+X7VLDkskRbAk/g4wz48=
X-Gm-Gg: ASbGncuqFXC564LmURI/tqy3l5ki9CR5ETC+qAqt2XqrxxCqfkaUUjjYi2IJH5mHh5X
	+S0iZwwWyZXUIdixlGrRSvvzQq2KT/hnEBqYKVIrGM+bqcdEw6PimmhWafPwWfKBPtItPo55/cf
	E+GvtX8CVo3nAY5vhBv3DPUXX0S8j4uRw9Yxbfz0rZcy3EvmsJ1J3LOGpC3ql25bt0kure28sY6
	rEj4pScP8FhkAEFdM1zXW7G9Tce725Ys81ddF8KnwGsBnRcyc+W7WMY2xZYvgFLXJA5DViwHoRq
	2+VC6rh/EY9Y0/C5h3MD68L+vFO4KZ/cBB+yIObXWvZxgs2N5h60bczIOEw9NnhLoJPRlkFuAOR
	1uCG+bKyh0K4N3uA/UC2X/6TU
X-Received: by 2002:a17:90b:5708:b0:313:db0b:75db with SMTP id 98e67ed59e1d1-31c4cd552d5mr9130339a91.33.1752281913140;
        Fri, 11 Jul 2025 17:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH+CvOT5H9SfPGFHjjQmB9x97tDpBw/QCMTGSPmn9BMA6KNf6NniFL89xp7m2bTro77IABpA==
X-Received: by 2002:a17:90b:5708:b0:313:db0b:75db with SMTP id 98e67ed59e1d1-31c4cd552d5mr9130308a91.33.1752281912727;
        Fri, 11 Jul 2025 17:58:32 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c23006d72sm5202274a91.1.2025.07.11.17.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 17:58:32 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 17:58:09 -0700
Subject: [PATCH 04/19] drm/msm/dp: replace ST_DISPLAY_OFF with power_on in
 msm_dp_hpd_unplug_handle()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-hpd-refactor-v1-4-33cbac823f34@oss.qualcomm.com>
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
        Yongxing Mou <quic_yongmou@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752281905; l=1171;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=mxuxQD5kCjtX7ioz+ogKfK2PsWX6uqWHqGDi2GAvSJ4=;
 b=i3MbKDvWRQHZ10SLpwW1ak3aD4D143rFZvveeCBQjFISiena0vgzQcKaOGa0JMSty5fsxcubD
 8vWZq4Aby2IBX1FRdivd9xC+VpVmwUM6m7ZVVPPv6VwZhleCEyjAFVB
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDAwNSBTYWx0ZWRfX0LIpUAp3g4jX
 6QthKCfFlXUrwr5Z5wmbXhcbfpnw5/QY3hnLuCd/eHWscLCa9WADJr1O3zS8vimFu5Ax8stEFF3
 zIJ0HL+bEiFBlW19fT/a8tTeQzeONJoLaE2aVQlqvR7i31LzRrp6sWTwMCvX7SPRES+MkNLCMIo
 zA9sdkw1iDpY/mCUgVTvf8Qww6r8QLNyJr8Om2iZMAx7ZKN6tvhW58ARpjfncC8LbJYBgzY5+TT
 24IQTu1xPdbpqdd9q+I66Uct76p+8vHW5vpnz23oVQYoo6sbjhhyYsd7MA9gjIujjZyf1EhPU6I
 Bv7sZhj+8cwFMxnNFnHZUp/G6p9F5LHT3esJ8FcFPAN1BTLw1mqmPO5wAlO9jqTofd8H/w8fNHH
 gptoHiZfkJcH/rYCA0fCQVzRriUr1CWMels1pT2R3thmR5dDZMyB5/9P2xjVXqyA9jAQZ/iu
X-Authority-Analysis: v=2.4 cv=QM1oRhLL c=1 sm=1 tr=0 ts=6871b33a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=e5mUnYsNAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=8oAJioj0-2SxPtK92HsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: AY_y3IO2aHEyiIGaziL1avoJ5u4WWTIQ
X-Proofpoint-GUID: AY_y3IO2aHEyiIGaziL1avoJ5u4WWTIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=826 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507120005

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

msm_dp_hpd_unplug_handle() checks if the display was already disabled and
if so does not transition to ST_DISCONNECT_PENDING state and goes directly
to ST_DISCONNECTED. The same result can be achieved with the !power_on
check.

Replace ST_DISPLAY_OFF with !power_on to achieve the same outcome.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
Note: Taken from https://patchwork.freedesktop.org/series/142010/
---
 drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index fe38ea868eda..f93fbcff2cda 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -694,7 +694,7 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp, u32 data)
 	 */
 	msm_dp_display_notify_disconnect(&dp->msm_dp_display.pdev->dev);
 
-	if (state == ST_DISPLAY_OFF) {
+	if (!dp->msm_dp_display.power_on) {
 		dp->hpd_state = ST_DISCONNECTED;
 	} else {
 		dp->hpd_state = ST_DISCONNECT_PENDING;

-- 
2.50.1



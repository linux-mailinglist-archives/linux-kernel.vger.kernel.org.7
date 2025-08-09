Return-Path: <linux-kernel+bounces-760883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ABFB1F197
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 02:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2C41643D3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 00:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7557F238177;
	Sat,  9 Aug 2025 00:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AeqcSjQ6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA082376F5
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 00:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754699742; cv=none; b=WSimmdeW/rXT/ndPlxPyZXSHhNDOGVpzQopTQ1IrqDEhRfXF6XUdeSh8Re5jWR+F82O9Pk6FsefQbTeNcic3WXimkUH+7WcGJnTfwIyXu1gleR55wwTyd3sVLchmcZKTheVdq1Uu+MWQDYKGw/pwGMRG5AJfa/imdFmY7gAuCQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754699742; c=relaxed/simple;
	bh=4dI75xSUxUaqLwUMy3UReh9bT/U4ccPbg+CHWdIsNCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UrMZI8EADP7mtg1cWSVYq11io96AiO+CZ3fiayXaERSUBmdTwG4FgQ3EYhLhuT7RrNBPoHvlEaJCI0mI1dPlNXWXMHEjrFv1NubriWzW/fwsFS0tD1NfJ48J33mmQrB90vJJirkMdqF58GQs08/ihw7eKCcLF1Dkc1RpY9kEX5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AeqcSjQ6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578NF2UX020431
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 00:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bOPqaygyz1VOMQKkg7WWHDM49dkikPWmvYtJ6Qfvgpg=; b=AeqcSjQ6V54+/n8k
	degUFSHzA1jYAR6Cnb/jnjHLc05nlzwYXU/C0IZpkFj/52KUxn+PR/vdNJo9V0T5
	4KPbzl9qOeLINoGIoubbNSPN2Ib2XHUMVLY071KTYOxH1buG0QLNLv51+4af2S0g
	bL3FOZ1Bv699JQztT5va2Qpq1dLg4yeU0B+j2/v9ue22BpWRWpWapTZQMPEistWr
	mvpFoc7imTfZfba5aNhawYnMUT5SetJj/6ZzHlzv06z/5qzW8gSc97GWL9L3Yo1M
	JhPBJLyoldCPhykn5k2k8JFgzGt4UcEN7G3EtSt2xvjjZ9uCy5BE/xdSIx0UVJj2
	I2QTpA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ddkkt5py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:35:40 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b42a097bbb1so1278813a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 17:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754699739; x=1755304539;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOPqaygyz1VOMQKkg7WWHDM49dkikPWmvYtJ6Qfvgpg=;
        b=nGWaDip4p8bwkSZVxUDrMROheDPbXuy/h+qLB3zKioko6iiTet8VbFmDlNP9Qe0dM8
         sRPFv4y9K9Uv18m2jn/6QsT3ITlfaPttggCwzDg7Qaj/CDkDRmbaAZQWY4r6FF5WJJ4s
         T/S4vsHEckm7ZlQrz9g1dK3StpU+KCJAaDJ1u1JIVmhI2YTuLZAbNwhlN+x/SkAn7+qw
         WiNvFEEpYat2acOFJpxdAiONnW6zBEnTxsnwyeQAG4npjHgJbCbfRiT0cPLulXRBPIfx
         VxtTniitUoKxLOzfVDr52VsQRFnovpvxL6SbJN4XsWz0nNeOzrSu0ExxK53FJTOLSv92
         zR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfsDb8MXBf4Sl3kru9NKpK/EMF4J1oh9XpJkp/O9RIw0kTUDMZuPOnn6DFFGAMnreTCF4g5zF1xgUTjp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuL/glo/W7Hd+7d3X6HRG4F+Ht59USNlbR14uOHCkpMt4hr5U8
	FqJ9IYjJtFJAFOGoX29tOeCA6haz/UsrD3CakwMJXocrXGIcw0fKWYH4jucplAaBSDc4Mg5OS+V
	7+8HscI++NXcbV4zNHg4xx09F6E4JCo1tOkmAhtqja35iQt2bVaAmjTyg7ZQKHmP1UtA=
X-Gm-Gg: ASbGncs3GXeuocOClWgfzRFyThzQoYJXkPsdrqV4GZp0nfyn2TUrDiQzca4HnJoKsf/
	b9oexEjvVD6A+7vrfDznEC15IstwMdfj0fXetw4CG6Eqg/E/zt1EYIpfQHIdU4eM7+ELyMncbJ4
	P7SrMDQAWAlsReOjZK8y08AJE2FELww6U5y05y2l/W6zMJGWf6KkHJWZRo34Dop7/TsYWQo7hyT
	tNfSSXSZ8q31E2xr7wFPmq2ouObczDhTGLXCacvjp1xsJ/3MEQxvmh+Joq6XbttoYGR9k7LIAbr
	bnakYqiQl7pV2DJBk9CfWuoLb9x2DTPVsTE0b+pwDsLXHo4gN55Q7/77EV024rkVEqiFMxnkORk
	RTNR3G0v2Nr+kluWA9gsrce7c
X-Received: by 2002:a17:903:1b4e:b0:242:9bc4:f1c9 with SMTP id d9443c01a7336-242c22a0e73mr68472545ad.56.1754699738798;
        Fri, 08 Aug 2025 17:35:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG90TkpPOHu3ik+v+Qlm6PmhiW122lbzmzkgxapd9Ri+VnBLxN8IwuH859qvbq5t5KTGtZyKQ==
X-Received: by 2002:a17:903:1b4e:b0:242:9bc4:f1c9 with SMTP id d9443c01a7336-242c22a0e73mr68472205ad.56.1754699738343;
        Fri, 08 Aug 2025 17:35:38 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef678dsm219865355ad.39.2025.08.08.17.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 17:35:38 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 08 Aug 2025 17:35:14 -0700
Subject: [PATCH v2 02/12] drm/msm/dp: Fix the ISR_* enum values
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-hpd-refactor-v2-2-7f4e1e741aa3@oss.qualcomm.com>
References: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
In-Reply-To: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754699734; l=951;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=4dI75xSUxUaqLwUMy3UReh9bT/U4ccPbg+CHWdIsNCg=;
 b=9v7t/t5zjvmt0SS7wNe7gTFJ1P3lQd6ZvEw9FvAt79V9e3RldlmDsTJIL0pzQssWYKovivqqU
 IliiZxToWPaBt9Ldj8dLeYd1tzf06Yme4Xmh0XGrjLZQJwBpdZRzhZN
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA2NiBTYWx0ZWRfXwhlJ5MyZ1uvf
 3vdT0FkESmsyrMkZZk1YdXANucs6uW6GZxQNcWBMKP9wyXBacRuYD5qtVYC5jcr76JeCriin9NX
 14Sh90jVytkvGarui6vTeg2umTmhbbPK1Ssu1+lnJBdjLnDv1qXrOMWCwzV2lCOLTqOgN4GH74l
 tMse8LM/Jg9s6XflSDsYPZrd58F5FdZ4pWCFZQuP7jEm+CjLDtKWH6Mwfn9IGhbgXR1e7ykhAba
 G+D0ORGlxbbKxRljGn+2fzk9MYqUTwYsxDQb8a0hmYAjQsQ+cCBvgfoAvfDDWzNcDG6AmJ/Wkwj
 QsyfI2Eb1NlyTjnfN9PSFU57nY7+NsPV/cc4cN7ykkRlwdycOduRAVgKD/SMxe8T/t98WDouSKq
 rSYPyIXU
X-Proofpoint-GUID: xXqtkYfPZPdxi--cBEvOnI-_9IqZ2PfD
X-Proofpoint-ORIG-GUID: xXqtkYfPZPdxi--cBEvOnI-_9IqZ2PfD
X-Authority-Analysis: v=2.4 cv=Xpv6OUF9 c=1 sm=1 tr=0 ts=689697dc cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=rrNbjNIy7db4sKJtjcAA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_08,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508080066

ISR_HPD_IO_GLITCH_COUNT and ISR_HPD_REPLUG_COUNT are not in the correct
order. Swap them so that the ISR_* enum will have the correct values.

Also, correct the spelling for ISR_HPD_REPLUG_COUNT.

Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d87d47cc7ec3..bfcb39ff89e0 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -38,9 +38,9 @@ enum {
 	ISR_DISCONNECTED,
 	ISR_CONNECT_PENDING,
 	ISR_CONNECTED,
-	ISR_HPD_REPLUG_COUNT,
+	ISR_HPD_IO_GLITCH_COUNT,
 	ISR_IRQ_HPD_PULSE_COUNT,
-	ISR_HPD_LO_GLITH_COUNT,
+	ISR_HPD_REPLUG_COUNT,
 };
 
 /* event thread connection state */

-- 
2.50.1



Return-Path: <linux-kernel+bounces-869056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38385C06D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009523B848A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A62B2C11C3;
	Fri, 24 Oct 2025 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FfE/7FXN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038F2580F2
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317837; cv=none; b=MkHj1KQPyfdz/f0uaTwNS5lfjIY2XXF6UZY/JLRy0YbcITlA88U8Kw3cxlupBirZNPSX7Rm92ZQxuApGKpAMALx6z2aEUFTGXyWy/GA4tG8L5gLWZeYe/PCoHBe2yc8t+5nrEAIuk4FIHxki/Jlj8HQSvhd+Z2jTJ9LapCWyeaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317837; c=relaxed/simple;
	bh=1gylyZmwNHyN2C9jDd9SKYKbQ5zm1ooRwXpqxab04r4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pUZkOThwWRsvdqnk8HP1MFaa2X2Zp0ljrw/eX0jW1tzXZYJ5X1r2j1dTLh6ztbskRW9eD9eV1ZrQ0/Fu956Wcn8oYoHI4SHD3kfLM7CDbaMJd7UuquXWD5gCGMn/1rCn99z9OuZ4X3HAwm+MeL6OrT20P2LmUafDPjUoAZO+5c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FfE/7FXN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OBtZHh006164
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=60sB8Wuf9kTa2rtyBom7E3
	5OMwjLtVwCZLKP46MCeGQ=; b=FfE/7FXN/lbKuAWCh0Ln0vnyufCffscLn+hLvp
	imRcO/oQWFF0pLuLN6lZ5+mSzinrRhhVA0HLprolG6iuNQBB77sUPMXqGgDlxqRl
	13TOsqejJqR9Qc2aMWxc+gazN4BVggsrRa/G1i0/DwWsWatpS317LD0S4c4GyGS5
	rPS4qL4ks5/K33jmDimBMON+MGLLtPSEWYZa1I1bFHs8QJCuZh7SMgHv9/gERUhO
	5eYLLP1x0AtsCPPmoMuZmBF9idAyBb5D7YwnFxGwqXGgJD56ZjeXijd5/CwVMOO2
	qKqVYpB9ThiQarTbuzf88XQ1+u/FU+Fb81IuVLO6obhqIVOg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v344cd63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:57:14 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so1887902b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317834; x=1761922634;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60sB8Wuf9kTa2rtyBom7E35OMwjLtVwCZLKP46MCeGQ=;
        b=CW2prOBxGUkR4BvA3C8vo54h7cf//dzXA2DWSQOp7XGuP8xrng3dVW9WG+PfMU3336
         /8Qu+zixL1n/ja01wktn1hzBsXL111PkXWdib9+gWItQBNLOJEOb/QrcjEZphMbTqyCx
         3qM8uVuhPsmr2StuAYyhu3uh/jLBa3E2NJsDQEO6jL2kVcQBDlhYZ3Z5kFzIkdLE73CA
         EtKoNQ6+SXhYFmMm6VHzGj7H81JH36NUDGJA0cj6W2JcqbC66xTyNpmAvJ54aMG1NKtg
         WVptA9usU9pQOJoxCaYYKP0b6MzSKYvQcg0GZPbjxUTUMLZ1q3MLkeb21oLuoMMbEoyn
         /6WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGA6+/pjAY2++p33S76RGsDURWJ9c2eFYJyuOTzdo7h5MgCbCtwzI/U5eCyhfPRWB6DI2LlqpvjXXLnHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1/Jspdi5Pnpj3rrPJbi4A7smCM3EzvGCJqvRB9a1EJuD5GcCD
	5G3bKmHefZYjaVUTIbY/kBvf4Ooq3IN9Wq+PpPAZegMIoiYUFTiQ8pBHY9EA/UvnYLn776jjqcE
	eKZ6radpBkliH1Ag7lgB9cnHM4QqHa8vl9UsqX81JBo9mEvtvkN9ohdETyjAB0MKWYAo=
X-Gm-Gg: ASbGncuDyyAzhcbqCnwUc87Lf0u1LhHux2uYmE3Q0NqfnT8TXf14BQSWMYmmBDJQVC5
	bryfSqdbMD36ka2lvwcnVBfOgM14SBoCRBSCO8Y2iL+J6wqIi89exusjKofIfF8H1dHPAxYstgw
	TXSwvv4B5i1q1+F5Bc7UihPMTx5QqB/jwHRZsB/JlGmEIF5IyTmM2nX8QSuOdGIhF3A/dw7QiAZ
	zwCa/cucYFNxevpTrsTNvkHjh81vd5MTBLEJJvVDOq9ck8BiiKQskvf9Iz/rACmj7Keaju6wd8B
	e0ULl3rBhfgNqO3YPRNny4H9lMTW/O+TtOfX236OmHk2w/a07j6MOBggStU4GQBZt0K6NM3K6Yg
	mO8HpFwlEmdSrUdgyJwCfCr8=
X-Received: by 2002:a05:6a20:6a20:b0:2cd:a43f:78fb with SMTP id adf61e73a8af0-33deb36eb42mr3243591637.48.1761317833807;
        Fri, 24 Oct 2025 07:57:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoCzabHI6k75TFLxJXPCs3EzFvxfhcUQKHHRumUBapOaZLUKiSau/3jarrJCmQTq99vTz3iQ==
X-Received: by 2002:a05:6a20:6a20:b0:2cd:a43f:78fb with SMTP id adf61e73a8af0-33deb36eb42mr3243559637.48.1761317833320;
        Fri, 24 Oct 2025 07:57:13 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e326c9sm5282228a12.34.2025.10.24.07.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:57:13 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 20:26:41 +0530
Subject: [PATCH] MAINTAINERS: Remove Jessica from drm-msm reviewers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-remove-jessica-v1-1-f1bb2dfc2e18@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKiT+2gC/yXMywqDMBCF4VeRWTeQu9ZXKS5mkrFNQW0TKwXx3
 Rvq8jtw/h0K58QF+maHzFsqaZkr1KWB8MD5ziLFatBSOyW1FZmnZWPx5FJSQKGQovEGrbct1NM
 r85i+/+BtOJ35/and9RyBsLAIyzSltW/8iGQ0kXeyQyLqqCUVnL12bO0og9FGS44OhuP4AexUH
 R2sAAAA
X-Change-ID: 20251024-remove-jessica-1abd363a4647
To: Rob Clark <rob.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761317830; l=1017;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=1gylyZmwNHyN2C9jDd9SKYKbQ5zm1ooRwXpqxab04r4=;
 b=pdd+LTwZ020zxaFl6Wy5zG3KXzhkz84usSUTeXn1QGl2mVqqs8x4yLz5fcQNOxh5I2lu0NXM9
 o8xsd1jvA5LD7aQyht28013ZYK0iWWNDL+yyHlDXvN92sR6M/wy2b6X
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: leT9yX7MNlu3YEgph0odSbDtp3EyCvAC
X-Proofpoint-ORIG-GUID: leT9yX7MNlu3YEgph0odSbDtp3EyCvAC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX/YYNrLDYMmz7
 x8PpWhMuH5uPt0NY7AHyqEcJF0jiAgVBoGriHauNqSpRSXs0vWPByu/11JkM2E6qnKFc8tD4c2R
 k8bg67BgiZENfVk4s3M8H55A9kcDWLcCHImjwF9w7SHQ3pbkrm5crPHOJ7rjITbnE/h5vwqdiOR
 dY6wQmhlyMCuJweJlYYVK0H+m1kSAJg5savhTx0H7wb8yfdlAFilfDvpvdSnALZEwkCcikl69q1
 pAU2KW0e1HUO+Jf8/3QeNSAxW+xHkWIdORYkl/jd0BtgdrDBBMgibSzMQmI3sdIAm6/9JDFtuUd
 OUcVETV5ldTKtv33nqeDi0h2PCXvE+REs5c0LOBwGMcMEGlxrQiWAHknfNlMMEijKZYUgExegXg
 XFst+yxrZNLuwt1u5lEg+A2LLxMYvw==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68fb93ca cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=tVI0ZWmoAAAA:8 a=oH-qu8LnP-yuNCiDOAsA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=-BPWgnxRz2uhmvdm1NTO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

Jessica has left Qualcomm and her Qualcomm email address is bouncing.
So remove Jessica from the reviewer list of drm-msm display driver for now.

Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5889df9de210..064aecda38cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7889,7 +7889,6 @@ DRM DRIVER for Qualcomm display hardware
 M:	Rob Clark <robin.clark@oss.qualcomm.com>
 M:	Dmitry Baryshkov <lumag@kernel.org>
 R:	Abhinav Kumar <abhinav.kumar@linux.dev>
-R:	Jessica Zhang <jessica.zhang@oss.qualcomm.com>
 R:	Sean Paul <sean@poorly.run>
 R:	Marijn Suijten <marijn.suijten@somainline.org>
 L:	linux-arm-msm@vger.kernel.org

---
base-commit: 6fab32bb6508abbb8b7b1c5498e44f0c32320ed5
change-id: 20251024-remove-jessica-1abd363a4647

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>



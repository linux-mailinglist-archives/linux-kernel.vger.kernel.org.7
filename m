Return-Path: <linux-kernel+bounces-840882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC119BB5A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 01:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93D3C4E8115
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 23:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F3C2BAF7;
	Thu,  2 Oct 2025 23:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mrWQ47R7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03EA927
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759449472; cv=none; b=I55WgwrXSs8yNS9drCuE7aruGxOfpbtdBlSBEM6ApGQonnqu+bFsIepIWIVELyqtiV9pSG189Dp1ErAXq3pZRHUfr3e4Ndb8dpbmT6h9ymPW9vzZK1raLjLc0skj9Jzd5sKk4WodYOFr9Aikm//sluIj8/Tl+VBQ/zYq5B7KLDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759449472; c=relaxed/simple;
	bh=bgT3hSLAPpI6ylw6xIFQ0tOWQoAvzGbHmZph6BNaMVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Lja9fZ0cmEdpnscxa4NHHE37HLybccC/+Fx8wB1cu61VqU+ASCHkJfGB0fNNn3cCv+QxXAzs0VSHw62UBxTmYn/maa1xu5iekhtm28VrqAA7EmPjcCiCHLs40blQVq5tOkWbt0hS5R6E81JF6a9pUJA4MfI3gcgjviPyDLb7+f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mrWQ47R7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592M1JoW012562
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 23:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PWeX3pwFQajV931yQ8BTkc
	33/7zopEsdK/riLLlmelc=; b=mrWQ47R7piAFE+oAXbyOprIKNRFSpSsulfDU6J
	m02E7BDjNnGccIUWtEOsamyFzuRA5bzM4b7E2WZKxtaqShRz5C8lNJizKSgJq9xP
	HMTxNeBMXXC42akbNZcaQDrsxzwH+g8eKjzFENGfA3YnnnPBkJGITSM3KXRLRO2L
	CyKLSKcWmfoduKOlhPNTS4NiyyN33+r5IfZhXjNzwjFF4Jj1yArImQlRaPudgKMr
	kx7NVmS7ilJvGlncEol4ISklkf5laxDkTQ0Qk6KnLCdteGHSZo+wEmTpCU16UnDU
	5VKlKoeSHiayoRll/x+e0Nn0p7v1geU0kIS4Mfeui26ayocQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80u1gfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 23:57:49 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b54ad69f143so2125538a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 16:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759449468; x=1760054268;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWeX3pwFQajV931yQ8BTkc33/7zopEsdK/riLLlmelc=;
        b=YFcSdi13QKYvsx2qG77TG3JWf87f0HnqZhTrXBSYw1eh/wVzLZpFDJE900qXXs0zgE
         SqA+Qvwg6k/ityMQhXTcBXyFsnrf4P7yBawRK5x4GNHTfA8R91m5KDfYvJQ3I+IVnuSz
         sY0IxaL6EnvrNQpm+YtZRR9ofax4uL3mL6IlnBWHYZHuOjaXVuD1x9JxiaaBkKYXq48W
         EcjIMBn5D6BUR5GJvOD7B7dA9H8qMaPbwER7MJ8rxAklOXNZWfJwn94eSjUy+nSimjKk
         lmVlft/JwEUJYcDYgtTkbSze65zsD6E9TKkDnTyemOvgNo/bsle9kyQdrDLM3oUOkTpe
         UFSg==
X-Gm-Message-State: AOJu0YzXIX6I41F2YWdT0o8PaQiFTbFF3Z7CYJDiLwlsJ9TPoGqhz9vN
	/zuDqCl8WUWP4CvPTHOWaOQ31oPvmE5ZELJD1k5O249DQM207olfJ2a8kPKKkR/oMNHs1JQzD+9
	Qnh0kaOvzfUM+xFLUMZIOVZRLI+LI//ylwGmwVec/Gjav9XsTplo3E0afA9yZWkD99/gS4JSm0m
	Y=
X-Gm-Gg: ASbGncutNv6yI1BBUycx+aze4TSaw8ZR9Y8OzXk96nAmDyqyO9mK4BmoUeq+SdjbFTS
	cnSiVMvXuNz/avMJA+degC9eELD/1F3pKlSZQKDrk72BD5rgfIVXdNhK1fY+WwaJvBp0dbXpy8d
	ITrtDl9J1+a64fx7UZS7ptEkvVXOWq4aQEZU4Mk7kkvFApNGxGrg9JMSkIt251nZ9Mp+iyR7pps
	lsO+5CtxsGkXvoE7JREZhMmP573VQ/9uMke3vzIa31t61kD6mYcyPLiIMvFIHFN1HVHUQYXnNyd
	WTTue/Vt67EBL2Dl0FkJYD6atHoTPHJVQnkjL749JeW6ZJaiep7Lgv4XZEblJLiRK0w3phW2KX7
	mGL+ELcpBQfqUStDstJqpKfZaMDW2SA==
X-Received: by 2002:a17:903:b46:b0:28e:7fce:6685 with SMTP id d9443c01a7336-28e9a656975mr10213385ad.32.1759449467817;
        Thu, 02 Oct 2025 16:57:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt+w1yH8tjJDlpzM77QlJgNO6+lvwpEnpefV0xzKNfgoby5Ecn/s4spLV3aQXIHkcWmUi6rA==
X-Received: by 2002:a17:903:b46:b0:28e:7fce:6685 with SMTP id d9443c01a7336-28e9a656975mr10213155ad.32.1759449467361;
        Thu, 02 Oct 2025 16:57:47 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b845bsm32064985ad.79.2025.10.02.16.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 16:57:47 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Thu, 02 Oct 2025 16:57:35 -0700
Subject: [PATCH] MAINTAINERS: Update Jessica Zhang's email address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-quit-qcom-v1-1-0898a63ffddd@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAG4R32gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwMj3cLSzBLdwuT8XF1TQyPTJDOTRAuzxEQloPqCotS0zAqwWdGxtbU
 AfC2RVFsAAAA=
X-Change-ID: 20251002-quit-qcom-5125b64a86aa
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759449466; l=1286;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=bgT3hSLAPpI6ylw6xIFQ0tOWQoAvzGbHmZph6BNaMVI=;
 b=l8iBum1BMYFVeRyUUElwyPpEZN2AqzHaItOorjlKbFsSKPlE/Wlbl3eMGu6V4Bszw4fBeLeAO
 FXoo6kQLfstDYB06w7tBX7xdwDLo2BfVlqwff9d5pHGZxwUF81ZnY8P
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX4SHDeBmimf7t
 xYXdroWXC+XpbdMbWie2xQ1VjtrGEip0R0cMkM8DACIeRZ6aAZ1iEyhD/5fiY3vXfI4CnhbMcWS
 NYmu2UipgLD+KSVerDpsVGeiwNk+OJd8nK5ImEPqtsyvaqzxhmiazasEuR2slpe9iw4rflxFXr+
 HLbP2+mY3tEYHvopElel8EzJIYhcMu7hhVENBMd0fb7b5OJzDJWIBugAW6TcxS63ff1FNUVBnx1
 47ByFqAtssxrO+jzkB/vLw3rssg8Q5ZjfHmi045pua7CALs+CH7Njqb2oIepLWIWEjTAmWGyu9f
 MPwTqNq30AtlG1YWZRRF4NwUAWfRq0l+u4KlYOvIvwDADFIJr2L4aMeBh2SI7ggMOO6bF5bzyCO
 xAtJ7ryKlcoNRN0PyV/ESl9nFQfNIA==
X-Proofpoint-GUID: 2Gq3mpOOAV6VeLaui53Ff_zW2wY3HOOH
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68df117d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=e5mUnYsNAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=tVI0ZWmoAAAA:8 a=KKAkSRfTAAAA:8
 a=69LWc1rl86c1DZQ69rIA:9 a=QEXdDO2ut3YA:10 a=2MHBSq50hwYA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=Vxmtnl_E_bksehYqCbjh:22 a=-BPWgnxRz2uhmvdm1NTO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 2Gq3mpOOAV6VeLaui53Ff_zW2wY3HOOH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_09,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

My current email will stop working soon. Update my email address to
jesszhan0024@gmail.com

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e7515a412e9..7a712ded8f9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7652,7 +7652,7 @@ DRM DRIVER for Qualcomm display hardware
 M:	Rob Clark <robin.clark@oss.qualcomm.com>
 M:	Dmitry Baryshkov <lumag@kernel.org>
 R:	Abhinav Kumar <abhinav.kumar@linux.dev>
-R:	Jessica Zhang <jessica.zhang@oss.qualcomm.com>
+R:	Jessica Zhang <jesszhan0024@gmail.com>
 R:	Sean Paul <sean@poorly.run>
 R:	Marijn Suijten <marijn.suijten@somainline.org>
 L:	linux-arm-msm@vger.kernel.org
@@ -8325,7 +8325,7 @@ F:	drivers/gpu/drm/clients/drm_log.c
 
 DRM PANEL DRIVERS
 M:	Neil Armstrong <neil.armstrong@linaro.org>
-R:	Jessica Zhang <jessica.zhang@oss.qualcomm.com>
+R:	Jessica Zhang <jesszhan0024@gmail.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git

---
base-commit: b5bad77e1e3c7249e4c0c88f98477e1ee7669b63
change-id: 20251002-quit-qcom-5125b64a86aa

Best regards,
--  
Jessica Zhang <jessica.zhang@oss.qualcomm.com>



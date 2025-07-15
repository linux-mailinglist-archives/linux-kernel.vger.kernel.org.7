Return-Path: <linux-kernel+bounces-732327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 182E1B06522
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569391AA7C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D051E2857CD;
	Tue, 15 Jul 2025 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zgdx9DnY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6A21DF248
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600506; cv=none; b=hQK6Jw7gImqPSqZUxol5eS+tqmQDa7o3uFd7YFjl4YQFwynN2xEIWf7vzjHyRufXSiWmMolaz4bIkLIPGhdlx5w2p8X+u/BNq+lBo/wm2Izj0kKMYQjly+1yY8Rcfqa2458H6o9H1TMQKotXmFGcCEObFVi+m447MVtOZXSs7/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600506; c=relaxed/simple;
	bh=QdqZrsXqEfuVxvLXTf6lvuSiH/gRiLYnrwqhir+p7vM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pO28gAe3btdf4UdcrCLWqv/fwX+XW3Lhd9SoHeAwtErg0IciWYmJdk0lcfSM3tLRo2QnhUgbSMp1+hEd/Kpc26Roh5FPmIYnDyaeasfNuRJVGgL2S+iDJA77BFd0VDQyshj9PKfafxeN0jVd7/x99tdaCK0/ANH8b+Da9BJJv4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zgdx9DnY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDK3f024946
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ga9LEiLYJZQSrksTrc649E
	EuSqapBL05a/sdzXt+JFI=; b=Zgdx9DnYQolsWxN3RaF4WTQGbUGMvVZwdqwtg3
	yJF5YxVONXbzLdUi1XY/eDsLKxU2qhpstoi1FcC3jj2BInJGpbcq+yXsVlopy+Kf
	a8BK6PSAn/pCcLYwkV8WvalxIWEXBzxO8EBijO9C3J3fsUCv3VswAji5OAMAFxk6
	o8cex1ZhIH/PR9WjhGJHxFXGbGuk95yjWfDJNu0SUZxblpNFnb5zZEEbb5E++JLH
	ynbvCpatNR4rcuPAcgnHYAKOdp1B4Qknxd2obMavVAm1HYR2ZVdC3eOOCKNVxxCF
	oRpaUcJ+4hpq50TDRzxgNOoaHDhTckmguXma1HcZMmDH9YEA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w58ykybs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:28:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7dabc82916cso1022076185a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752600502; x=1753205302;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ga9LEiLYJZQSrksTrc649EEuSqapBL05a/sdzXt+JFI=;
        b=ZLicaZNwnen6+11P636cmmwrBzhzskYudS14GpXjQMUQLkfTxDrrnnqFTQ1zD+jmKl
         Xurq4PUlc8sqF/NP7waVWAGtlSddKlz3DrW089PoA4JOx7VRwp1odITJOT/4anLAwR+Z
         1uikIn9LsvXGufayqvJ8YheEOnOS+luz5K0AuvzRUl1M0Apd/jcho22+ji1vAnT0sWEf
         amLonusBg7V5m2Kb61gAY85W01Va/390Od7fgGcS/LwHaZpk5ZCjBkQRxgTsb8preU5u
         hXHxfZuwoQIYYFVYFzcsBDhib9+6zT1xZFmBuVm2cw9zWuZ32Gyi/sor05NK7QvQOU8K
         z9nw==
X-Forwarded-Encrypted: i=1; AJvYcCX0/1aUtgSbINf6MXaxRpQ2eJzj6EcCN00jgXU9tGSKxrpCzG4bN1yC+YzaaA7vZlOtGw144HaRlMInMlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw10fRu0u6AhpPECW150+h6eTyae9KnYMbpRJW7+KCUd2ISdQvI
	2N0zW2T9dkwo3Tjo5bm5sxCwBwIyaPFa8cjqPH3XTbNCFvm+w5xKZPUhG33Eoc1cgP0WONih/BN
	gq8vCds8Zmz/fYX2bUkn+5xy4hkZ7X//yfzLage+xJR9ujKwxd9g02oMLqPG2mnud220=
X-Gm-Gg: ASbGncsRnPEv/I0r/IW2k459pZfVPcZu0F7gkRT96P0mnQD214dtmAcbx3BrlMvsmfh
	zcKb7kOR9MBbcH8woq0qVxU9utINPGmlPROJ4vI3GCBwEj4emSXuFEoLfnaJngce5GnX8cYf+PM
	akHhQuUU/Xa3WkRSbyc9dptEf0R9RbmcAu8sjDtAoqqZox7geMFT9mbjPh9UTEgL0wvablUr2oR
	a1hgULtLoUkEY1xGcrgWLIh01OGO4mEo/UJQ8HXuCf7yGRTEK2iBkUUTmO25azHTl7YYWGT/152
	piszXFkzrCY1t10x0EL6p8+3UeMe3D4u/DkGweJX3k9OqxH7j/8pZceONlMDEKlNkeNZdlCXlUG
	vMJcgTxXejVx7WUTCIlR1pcoNj2RAoAYLLVhfIxfA0EAbpyRgaSKq
X-Received: by 2002:a05:620a:4714:b0:7e3:2bff:78d3 with SMTP id af79cd13be357-7e32bff8888mr1121106185a.48.1752600502245;
        Tue, 15 Jul 2025 10:28:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZEzJG58hA6++K4A4OjwEpcmW9O7bWx0NfNEZFoHJsNZF3DRzQ7RzoezJtTWpqnzcFg4UR8w==
X-Received: by 2002:a05:620a:4714:b0:7e3:2bff:78d3 with SMTP id af79cd13be357-7e32bff8888mr1121102885a.48.1752600501890;
        Tue, 15 Jul 2025 10:28:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b60f14sm2386192e87.155.2025.07.15.10.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 10:28:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 20:28:18 +0300
Subject: [PATCH] drm/msm/dpu: correct dpu_plane_virtual_atomic_check()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-msm-fix-virt-atomic-check-v1-1-9bab02c9f952@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALGPdmgC/x2MWwqAIBAArxL73YIV0eMq0Ydsay2hhkYE4t2TP
 gdmJkHkIBxhrhIEfiSKdwWaugI6tNsZZSsMrWp7NTQ92mjRyIuPhBv17a0Q0sF0ouZuNGS2idU
 Ipb8CF/F/L2vOH3a4SG5rAAAA
X-Change-ID: 20250715-msm-fix-virt-atomic-check-ae38fcfd9e08
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1486;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=QdqZrsXqEfuVxvLXTf6lvuSiH/gRiLYnrwqhir+p7vM=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ0ZZ/2YZ1c2H2Pj1pe32uqxj1Ftbcdjz97cdMz9dZrSOf
 nvDZ8mfTkZjFgZGLgZZMUUWn4KWqTGbksM+7JhaDzOIlQlkCgMXpwBM5Jkc+/8gboGC1u+Rn+Oe
 fs5qDpzVuqJaZLHg9jlN395YqLoL/FjwvWXypUm9wfsNwj5+nigwM/DvepWmz6/elttbBF/iFmw
 /FdPpxjPhZZ2lmnnOtV1Jx8+l+nYlO3Rqr/julXSXSaT4kerSwExm48zSLTPvuAtGLls2zZztYK
 JS9PJzrpd1eWbndHzMOphqzrE3Il9+/pov+1I3T57JnZ7v5+oZmpnufZlnaUG+kjnzI82oo2t+9
 Mwsc2eIk28/1G16qjllgYyh56kbvzdq2b+yvicpwXVLWd3TuJhhWqboT6fypit3J+fraH/NzJ13
 baleq6214gxvli3MNntKWj7vnNqwVOE534K45pRa5w0PAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE2MCBTYWx0ZWRfXzOUiuI6HfzX0
 irN6idoOVjOFyS+yyFE/qbt4FLRz8uHAgPn+mYV2idBVgLCoYXFhFMhXsZ+XWxmHzysAp5UYf8n
 0Fd18Efpa9SgPTiimyw6rAXwClZxlsLWbRbaDVU1Dt71t4WadEU8ic2r8PjkfONWkLJnuvzUxWl
 LOeheUc9yi7WqNQvPObusfhLWGoFEnxFxZ3W6KpUt2OF4US0i8UiHkUpdUYOzVieCrbaEuXpu4e
 AtbbQM6vVeU2FQAw0giK92Mv8a5+diB3qhBkRx6HbDYYnHb0ibrv1RIAqDuILsL2w1SBq6eZRMo
 DCX/qPooO8idhHIEKNoXJlvamwWwjT7gaXFTaLtfBo+i6qfiL9vY80MdsnSLPQuBiIe4cmD10Ct
 2seRCv3Cd4hrDkLuYEGZmrfaCO4rtiDu027RzhL61JcjzAUv4v7raCS+DAuVV6X+Fz78+7NY
X-Proofpoint-GUID: oYvi1AVbIjIIEQRdZoGjDHNLN08_zd19
X-Proofpoint-ORIG-GUID: oYvi1AVbIjIIEQRdZoGjDHNLN08_zd19
X-Authority-Analysis: v=2.4 cv=Or9Pyz/t c=1 sm=1 tr=0 ts=68768fb7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=GxcwXDoS6YlZNtEUzcMA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=770 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150160

Fix c&p error in dpu_plane_virtual_atomic_check(), compare CRTC width
too, in addition to CRTC height.

Fixes: 8c62a31607f6 ("drm/msm/dpu: allow using two SSPP blocks for a single plane")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507150432.U0cALR6W-lkp@intel.com/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 01171c535a27c8983aab6450d6f7a4316ae9c4ee..c722f54e71b03b78f3de82fec4f2d291d95bbba3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -1162,7 +1162,7 @@ static int dpu_plane_virtual_atomic_check(struct drm_plane *plane,
 	if (!old_plane_state || !old_plane_state->fb ||
 	    old_plane_state->src_w != plane_state->src_w ||
 	    old_plane_state->src_h != plane_state->src_h ||
-	    old_plane_state->src_w != plane_state->src_w ||
+	    old_plane_state->crtc_w != plane_state->crtc_w ||
 	    old_plane_state->crtc_h != plane_state->crtc_h ||
 	    msm_framebuffer_format(old_plane_state->fb) !=
 	    msm_framebuffer_format(plane_state->fb))

---
base-commit: 8290d37ad2b087bbcfe65fa5bcaf260e184b250a
change-id: 20250715-msm-fix-virt-atomic-check-ae38fcfd9e08

Best regards,
-- 
With best wishes
Dmitry



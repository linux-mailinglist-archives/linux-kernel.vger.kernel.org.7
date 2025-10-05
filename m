Return-Path: <linux-kernel+bounces-842485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCC2BBCD12
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 00:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1685E3B412D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 22:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615801553AA;
	Sun,  5 Oct 2025 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZysN6W3/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1304A00
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 22:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759702626; cv=none; b=EAb4pNIRv9ma2uxP8/11TPBxraDvauSMIcS1TVQRW6aOM8GaEtAc6LWPwmBA+40KBn1b85vYMYyeITV5pCmOi/2k5LsQwwW2TM2tJkK/l3ovsrk3GRb1bUTCu+eKYKWPqVJoUAG3BCSBO/N/St7gWDXPbx+zz2HnRE9OummuREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759702626; c=relaxed/simple;
	bh=qMqj11SWPNJRQxFr6SvpFmDhPvJ370KIAe+tEdqRJ5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T3m9s0PVoTOWRTojY/dtXdJh7CS8F3OWcVUSJywyByJ4kMeLEQ+f4ivBL/AMsT8JFXedEKDsMNyJAvkBRwr+46kpC2EeUmiVqZMfZwt05iGpULZ8QGBJvOEVNZu9Je2hWY1nHuUmLxu2upFK0x+1LvXuyNgGMf43AVaTnmbuRDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZysN6W3/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595LXSwx017633
	for <linux-kernel@vger.kernel.org>; Sun, 5 Oct 2025 22:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=h7EiYCqL5A0A82Nx/mmgix
	ln4PixqDfUlvDspjDnbAU=; b=ZysN6W3/YEAzWURt89UwYS3MONZHdsX1XO3jTi
	5Jz9EKYpntzoGM2JDqL9uJwjdsraVHqJ1W9DLDhbbplMuEW7tluU8g/z16zzqvpN
	RPLYJ9vojz9+4cHEA/X+xkyYdAv0teWuqOUpsGU86bQ81j5UMYa0bgOHR1OXUo3U
	urpw30kSEDWKWbkwpHMKdQx16WQmEUdKcnHqxWhxa26e9++i58mBziBjADT7EIX3
	6/x9lFVfOlKgbuPa3c3Qa6Akfc/fDNYCPXjxq2A6yw9b4Xm1ciFPn1CnMjqWowaA
	YitbQeG/wIy5FzRwHRcdJn1NDgD2zbGyMC2PjVxLKthQ4rCg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvrhjcjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 22:17:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4de35879e7dso51338221cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 15:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759702623; x=1760307423;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7EiYCqL5A0A82Nx/mmgixln4PixqDfUlvDspjDnbAU=;
        b=jli07Lk7CMqnI0HcENq5VYGSzzP3fRFTW0nHYQlVOMErRuij96GazhGtGyjakEu5Ju
         MAJ/Tk9m7W7s4MebL7rstNiz0EHUgfJ2xd79gsgMHKa8I4FZVtr8PCdU5vgg5CsmyE69
         8vM+5/2jI9l/QC8wEy2SKH5lRkChBVLz4RVX+07kn8jra7XaiNI/mf8ZC/bjaum+wgXl
         T+0HAvp6pKbL6DMrZQMG9LDRaVESF/+eLZ6g/WqA9Exbbo6NOSbjUFGR9G31ixF7o56Y
         60AcdblDMQ4V+byieWDAqk0UyBroughYL9A20XtvTj9t9PhM71U9jI0rwZqDw0hy5wW7
         +IrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3AfbU3PBqZF7gPK39iwn4o3E0QrjySBvCh9XhyeGU3T+bJ/BxWn/vKJy1Ir3ameyBqTgycgmHvhFVmCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrE0n/7/zJkmdEs18DAZGuIgeDaAosIPjGyi0MGYZOZTCMYnLe
	zT8Fj9O4LUL8lpmlMCz6ebVjF4wjA9UbYnAz3aFQTrciSgaZpOmgVufZr+Ah3tIiwVbM4hBiVOx
	CWdeCEey+sEZcpjJEvWxag/GPsdXvnoKyqJDpVDoQGrzXD4WEg0p1u4m2NoeGseEJYng=
X-Gm-Gg: ASbGncsC9byjuFv9CHAmLvy7ESQhhonJ6wENhXXGz+Pmkq2itlEOC2TfkYgG2b1pxnF
	S3tPyyrrCJYs7OBIsIowy+sKRQw2hiAsIAwjoOSUin4RJIDYCS5ROdr9k8LZjHw6UpFn7vVJtVs
	sBayJgvG2/bEmCOhwvOlNJVzLyxDpL7TEsDcZhh22Uy28ISzhpN2TbSwIfIfsEeK/lTV2IE4MH+
	NgcU5lT5EqfQdR3hF8sUx//wZjHdStWaGwPsp2W29wh1vFYGXLIeFcnt6xo2Os5JXg+z/7MCz1j
	zLer8t8zBZzZYV+cpJBFqdGH/BDzStbbhZoUHdNTQRLQ4eoUcF2De6V+Bcz1HLIvH0jdCKSnlQj
	xfJQ63GMtMyM03woNLaB03np8um4K0tnATYIhmcS2F4JS9Rp6NizBeKwppA==
X-Received: by 2002:a05:622a:1808:b0:4e5:6cf8:29b with SMTP id d75a77b69052e-4e576b04021mr144346381cf.58.1759702622899;
        Sun, 05 Oct 2025 15:17:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhFA91HnAuApn9xtHNjvvCjTVTjvyFCJ+nZRb9rxe2DO3l1dO2JQu2jXcNUfEckhnOIS2WHg==
X-Received: by 2002:a05:622a:1808:b0:4e5:6cf8:29b with SMTP id d75a77b69052e-4e576b04021mr144346091cf.58.1759702622358;
        Sun, 05 Oct 2025 15:17:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba2a536esm39621271fa.14.2025.10.05.15.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 15:17:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 06 Oct 2025 01:16:59 +0300
Subject: [PATCH] arm64: dts: qcom: sdm630: fix gpu_speed_bin size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-sdm630-fix-gpu-v1-1-44d69bdea59a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFru4mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwMT3eKUXDNjA920zArd9IJS3TRLcwuzlCQLAxPLRCWgpoKiVKAU2MD
 o2NpaAFfoFZNgAAAA
X-Change-ID: 20251004-sdm630-fix-gpu-f9786db8049a
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Konrad Dybcio <konradybcio@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=qMqj11SWPNJRQxFr6SvpFmDhPvJ370KIAe+tEdqRJ5Q=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo4u5cPRJfGaNsZtd9Qvp+qpPh9EN4Y1WNSjZ9r
 MSIDUPzaZuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaOLuXAAKCRCLPIo+Aiko
 1Rn3CACug0nQjghlIxZ6i4PwxOH97pL34a7gXFV1DRNTsz4Jwb2M6o7xbkU9me/HN5EVAkBuAjM
 3ZCimhhAaVkCDA8zQYQeC8dRCugJkNqWF+yDA9tPHUX7YXW7R/seeNFdyHTg2pR9AaJT8BX0rSp
 4BwnJ/q+YhmzH4tarL/y2rZzdVWOHdfTB3dektpyb/ajW7J6X/5d1bdRqlzXPr8l36qdr3iXyr7
 ryfe5Day6bucqb1rz1sX03mjk79/1JEGUWhSrdOg5PF97KFPeZkakPyIOp6N0ITw6MAMRZkurZD
 KKSFPURrWIEAb95hwdMNxjNMYsPY2QOI19nOomTPWXtdLieX
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNiBTYWx0ZWRfX6eTMJM3vwJnn
 Y+1mj7mN+Fg2tEKy09AyI1/myF+a+I+40+CUgtrz7C1pUXl0NbRoldYY+ibknZtzPT3Kw/5vc4S
 kKsep7ZYdy3FCvBCeua+jUy0Byx+VknekxaHgbEQvXFpNK0WgHL3L1AyU5vDyT+qd5ouYoLqhIv
 c8xgvfT42t/W85mjJh8Z4JYLejQtOUljs4QwZiytSeyw118VUhZTqIPTusUh+8digf+kpLCdKlv
 H8khFft3l85F59mUczDrH18Qft4sSvuHwgcVs6HzA4WQ3p085SzEZL34Y5AvkLEQfSYCZKTSCe6
 md01D33+WQ3H45mH8AW+qgH7zewuFib81acjfWnfX0JiABzrdliTXXVj+ctxYoOH2ZfGdqIwe4v
 EZSyvFK+vqW3G60fl7cnATRXRbStTw==
X-Proofpoint-GUID: vNbQEqQpFIopsYtNbcBpDnjtrCPvmEIe
X-Authority-Analysis: v=2.4 cv=XIQ9iAhE c=1 sm=1 tr=0 ts=68e2ee60 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=0OtPct3eviVbZUrawKUA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: vNbQEqQpFIopsYtNbcBpDnjtrCPvmEIe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-05_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040036

Historically sdm630.dtsi has used 1 byte length for the gpu_speed_bin
cell, although it spans two bytes (offset 5, size 7 bits). It was being
accepted by the kernel because before the commit 7a06ef751077 ("nvmem:
core: fix bit offsets of more than one byte") the kernel didn't have
length check. After this commit nvmem core rejects QFPROM on sdm630 /
sdm660, making GPU and USB unusable on those platforms.

Set the size of the gpu_speed_bin cell to 2 bytes, fixing the parsing
error.

Fixes: b190fb010664 ("arm64: dts: qcom: sdm630: Add sdm630 dts file")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 8b1a45a4e56ed1ae02e5bb6e78ca6255d87add1c..21f7dcf60679026e45202c6ce137ca0463c00d0e 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -598,7 +598,7 @@ qusb2_hstx_trim: hstx-trim@240 {
 			};
 
 			gpu_speed_bin: gpu-speed-bin@41a0 {
-				reg = <0x41a2 0x1>;
+				reg = <0x41a2 0x2>;
 				bits = <5 7>;
 			};
 		};

---
base-commit: bf2602a3cb2381fb1a04bf1c39a290518d2538d1
change-id: 20251004-sdm630-fix-gpu-f9786db8049a

Best regards,
-- 
With best wishes
Dmitry



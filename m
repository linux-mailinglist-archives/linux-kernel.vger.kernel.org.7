Return-Path: <linux-kernel+bounces-829498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B9BB97378
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5BEC17F1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0373019C6;
	Tue, 23 Sep 2025 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SZ3u91zt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2049F1D5141
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758652727; cv=none; b=gDCV/PGGiCBV4Y6SFZHAdvAk5ASiNYQbp0eziK8/fEHo88sJr4J4gY62wumQ3kIgitDu2oB46jqfmjPcv1vLppya2tJi2H1a5Jna7tkdbI4MuzgqZiR03W9EPLQikqTVHqNz1Trno6i8wC8ZWf4DHMXYA05ckp4a4mCT3YEoGsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758652727; c=relaxed/simple;
	bh=Sb5UShRUU4nS9qa42rFaj2iOMPPLKIv2ZgL3lYceuN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GcpDLJnsq+npHVvBYfIu4uzebQYZXe5bu/FsZLKVOzE47r/lUag5+Ea3xbVS/q0dEf7F2LUruZMOll/wphGjVx6JaKgxkob0sfMYoWRR1KaEHxqj8b/+nWKWGMae3xIEhM9pXgpFkKvhVmp850B4XO7orjOSPL8FoUNnILI7Ybg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SZ3u91zt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NCGspF012227
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PpmjLuxmp2spV4egFFC5nK
	8iX/6rY6ZR0GuyNkpgIV4=; b=SZ3u91ztvNpz+R1YNO7mLrhDlqdqTztThSWvnW
	Zwp/hdsMOyENPeQgmPSRjNOu/fVSkE5+kOZJsOxzQbkZL6H9YM3u0ot2y9TqwaBF
	hFKrgtdO+YyPTbIQZoWlAgnst6MeYKElq/dQrxiTtc4TN0VBVw//e63elRDd75fp
	+RXMoJEM/NsKKuElU1FHA6HNo8g8Tur2kpvwPxGg8IRZ5rfEOq4NkFyewXTXxgAl
	jeiXWPucxlvD73S8Jkm7su9hzkflGyUU/bGZDqWC6mx7dBAtVE4WZEoK+x6JM8Pv
	I9yDqOdg50unPdDLZNIG+6nz2ylfnIYMuSdlrCqB5kMisWlQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49buda98sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:38:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b5527f0d39bso5323753a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758652723; x=1759257523;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PpmjLuxmp2spV4egFFC5nK8iX/6rY6ZR0GuyNkpgIV4=;
        b=DgqhFiwMAQY/XbECG+fqzaNNOz5QpZnDtevKPoULY9koRAdr5x2ojt0NnNd4GEmvQ2
         pKgiJcQsndMwm6MBxXNhgEtsOKfGdg86hIaAP7XSxY5V5Vu0sguy13GXIB9q7yp2BVrv
         pJP9dvx6MsU3N7XXbvjX4/tK165YbgvOm4XVK+ScipBmmXuDWp4SDuDppCtBZ268sSGq
         5TjrQl+GpapHcrJUEPw/tcbmt0/Pqy4iC/AblU5XRZGoZ1pkUgieBRHDiwnhiQp+QC9Z
         JA+iNe3iqWwtzIPrH0yNR9pOnraiU3e+ZRALgGsUFgnQ44Z+dBer6JTMnZFGN5tFCSnf
         +V+g==
X-Forwarded-Encrypted: i=1; AJvYcCUCf/uxJvgfoaau7gRkGg0Fjh/Oh0hZm+d2ZVs6u7BY8X35nHoCjJientgiEGQlIRFln6wyR2HDf/aXIe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0HWrOfe6UD1d6ComRh6nYYu7RqbiMELWvCg3GaqF/1WrfzouP
	d06oWSTcJOJJ8oj0GIrnQkGsvZ9sNOVCe73Zbtc3vZKSO6WNhus3k3CQ06VNxM4pqFek5DYakAk
	kujngvLd3gYpeTC7nAUW5Qg/1NlCvh/zx4SdZMTkTuMjBnEJ1uXPfOgxys+WMMrRDFFU=
X-Gm-Gg: ASbGncuRu/KfQBr3N34uv4b/YErYwoKEWjZ24VYDRHXYK/qPnWCdnZsiitnBY8boS31
	NjuRm6OvKfNQt1geBpp1wedJRebrfjFP/u3Fv7Dvmj9xWF0crdrFXsWAyA5I40T/u1d7kgUG36k
	TYNiKHu6rZSDm5OxXJ5CxKKzLD6e3DWABHcelSBF2aXvQ0rfY9PGOAgBRMPwtwrljNUB43EgK4p
	EmeeSZg3EzTcbJWeHuxlggF91BtDP5hwKvkt+IwMLCOThAXNZKlYuBRfTfBHqRWOQpNMxetHeVj
	L+MMpN4pvGLq1BJhUu0RhRmTAPW75kCSHwysYNQ3D9UauexKNh5Su59/G717ekaV
X-Received: by 2002:a05:6a21:33a0:b0:279:e1df:e62e with SMTP id adf61e73a8af0-2cfe89904fcmr5312533637.33.1758652723490;
        Tue, 23 Sep 2025 11:38:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXVKYMbhJ7Op4WfVtc3IOETl6QNgVCQ3ov1ovGOrF2/AQJsnpr3zbM9dR3JuHZMktYi88O6Q==
X-Received: by 2002:a05:6a21:33a0:b0:279:e1df:e62e with SMTP id adf61e73a8af0-2cfe89904fcmr5312505637.33.1758652723091;
        Tue, 23 Sep 2025 11:38:43 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77dbc8e7cc4sm14722384b3a.29.2025.09.23.11.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 11:38:42 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 00:08:30 +0530
Subject: [PATCH] clk: qcom: gcc-sm8750: Add a new frequency for sdcc2 clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-sm8750_gcc_sdcc2_frequency-v1-1-541fd321125f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACXp0mgC/x3MwQqDMAwA0F+RnC10FZnuV0SKSVOXg91sUDbEf
 7d4fJd3gHIWVnhVB2TeReWTCh51BfSe0sxGQjE461rbu8bo0j1b62cir4HI+Zh53TjR3wTGGBA
 n7LCBEnwzR/nd+TCe5wWzky54bAAAAA==
X-Change-ID: 20250923-sm8750_gcc_sdcc2_frequency-debfdbbab8b3
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-GUID: DO7xM-Ns9JS8YPSwBkFj-mItU5uDMrx9
X-Proofpoint-ORIG-GUID: DO7xM-Ns9JS8YPSwBkFj-mItU5uDMrx9
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d2e935 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=CSdScD5nXC4I9MN_FnYA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfXwXY0KLWEUdy0
 O+Mo5sPx02DxC9GQaEKRXB7k2HfaBgnmwGABcjjO9crGi8Dwy4chlAGyna4Cg/PGXCcJvLc8/A0
 cqaPI0U4qpgWHHRp1fwVOdIN6w3z9fCu27DFWlnBsizva97Bi5QdQeaXpx1HeC0NjDRcHWVRunM
 UAfWpdNKq/SNPiIshgibgqUYcYt1xeTiE4rVM/L7/ePlwCMYMiU+Gz0R9XE9iNuGFBKxrZlEYdo
 q5fc50IkY1y5WHrLwRjXDhHXGuNXRSx66eIDLCEk+V6dX6LZn21496EfdDHYecMOjgkZBXafkT5
 DvJbp1zG6YyT/SkzjOg/w+aY2WCM0bnrl9sQPIZIf5WzKCg7NZjJ1T0FInkQOlr+H8IQ9YOQI7Z
 VEmaH1d1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_04,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

The SD card support requires a 37.5MHz clock; add it to the frequency
list for the storage SW driver to be able to request for the frequency.

Fixes: 3267c774f3ff ("clk: qcom: Add support for GCC on SM8750")
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/clk/qcom/gcc-sm8750.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-sm8750.c b/drivers/clk/qcom/gcc-sm8750.c
index 8092dd6b37b56f4fd786e33d4f0e8aabcd6ecdfe..def86b71a3da534f07844f01ecb73b424db3bddc 100644
--- a/drivers/clk/qcom/gcc-sm8750.c
+++ b/drivers/clk/qcom/gcc-sm8750.c
@@ -1012,6 +1012,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s7_clk_src = {
 static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
 	F(400000, P_BI_TCXO, 12, 1, 4),
 	F(25000000, P_GCC_GPLL0_OUT_EVEN, 12, 0, 0),
+	F(37500000, P_GCC_GPLL0_OUT_EVEN, 8, 0, 0),
 	F(50000000, P_GCC_GPLL0_OUT_EVEN, 6, 0, 0),
 	F(100000000, P_GCC_GPLL0_OUT_EVEN, 3, 0, 0),
 	F(202000000, P_GCC_GPLL9_OUT_MAIN, 4, 0, 0),

---
base-commit: ce7f1a983b074f6cf8609068088ca3182c569ee4
change-id: 20250923-sm8750_gcc_sdcc2_frequency-debfdbbab8b3

Best regards,
-- 
Taniya Das <taniya.das@oss.qualcomm.com>



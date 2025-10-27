Return-Path: <linux-kernel+bounces-871524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5C7C0D82B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4FA334B7E6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00377302161;
	Mon, 27 Oct 2025 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E3qlIAqX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C23D3019D2
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568036; cv=none; b=A3YDcWN3cm/4X/UPllxsVT13ID/c0oMLJgVDX1rvji6tiYqyeeYH8tdNRJ9ZNeH7ovtyrdJDh+elIDUQ8fcYC5Xw3YVzxFiOLOSQBzeWNbZUsrxbRgbD3guqbnExr/VvhrrPBsGJAGHJzPXhBtxhvQewA7JkRq81KTIfuEYLBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568036; c=relaxed/simple;
	bh=Ebl4v/VkXfD1I64iutehxYEDpuSCR37dBGPipaquSZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DXOtw/PF86IhbCue+xuk1VrPlZg13pK8rZ3e6hvsX6oco5aZsrhNqz4Ok3v7m8HmqGVNPy4U+Dnb8h+XFkXiJElkwRHbilSFYpI+KwAY57djveIoZKUIeabUeoUNyNE03yOBkmOH87vm29BYaPzTfuUGcPXvL7/NQuySh7ZtgaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E3qlIAqX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R84oRD2232270
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+e0kmPSERHqC5oqgfvQz5PD2Os0wmkHOTZ+f+cd7qww=; b=E3qlIAqX4CdOijlG
	WyHRe72oIGkvQQoY1ubihohQQjwqLzhEi+vbLlQk55xqsVGm+btVPyVnudlWnb6D
	LxMDVSEvWQHqDlqB/pf/jfFpkvMFLF51k/sDbHIfEhTMqvbzq6Oi9DlVw0JAW0LG
	4bs12z/O24p9h0Q9i0NRDeJKcWZu1xKn/jG9P4WFiLmXtQ/tyOWijPyIVeXty6WX
	/ErB1FLk1mVkQNKNmiQsJSv9GBPzYvibMcApRChONBKhtp6WIfmjjo8ycKin6vUT
	+4YTCLPyC/9UT6dDUDp9gZE9J/C9DMGuFMj88vR13l+/JP1TgkXHpJEg/OOjuZDM
	AfQBAA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a24wn8qru-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:27:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e88c912928so137447181cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761568032; x=1762172832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+e0kmPSERHqC5oqgfvQz5PD2Os0wmkHOTZ+f+cd7qww=;
        b=EF+qffQzWFdrEgMBJsDXmgj+5kSEtX5tR3AEMlWt+btXARY8vrRMDgtIjf5yHpUmxo
         FLaN0d7n/cd2DiTPgKfkhWY1seRHO5Y1p0e7IliK8Ka250shS2akkvpA7a+fXL/jZNL/
         EiGLi1sSoTn4yTDn296rBn8YFqKrqJoNe6zpu0pe/tqnImOCNDg4SNYuKw1TyOE3E+jj
         /ZmDNu3ls8JTz1W6fW+EWKCCUTH/QZY02qEGdstXm7HDVG3h0ZM9vtV4aIlTqb9QIUB2
         ydlBeZ1qyw//tuffyOjZDYP1bu2HC7T394U9TkomfQi2YU8BuT5NMyT9h+rRjy9hWp6h
         WDIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXYiilKwf7XursyNds009A585XINpG8YRM7IRCxjYZOZxnvLP1kLM9p3umE8dkT1osJ/CKBRALq0lWhr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKuNihPw9ZM2NxeaxsKqvuorK61Xa7N/Ca/r3WV9rDrM+tKlat
	QKhieizio/frGiZuE023nydIfAWN3vVIrQ+tp+UEu/IHpDs+1oxTxlKJEPNjJHCDy2JP55lbRKf
	UfSs9mqz5K99mPDtcai8/2HNht7qLRQ0xmEGBP05lJZpRvSSR+AesXPJaKtU0NT5kf70=
X-Gm-Gg: ASbGnctWtNfUEfG2kS8tUNVKRpuMP9mgOsqSfCsTcPqPaWyzJrK46tr6n1gxLUwuVPC
	1N55eLqhqyYqfnd+g6MGgd6KZZAolv752n7y7nnkRjRYbKqqRg9KaJ2jQj4nt+SdrU3aRuh7hq/
	VVnbK7gVZj42LSxo8gws5OuMBs/kPlFREzLS/2teto/DGnM1ktD1P/5zXweqN3lGcWtdqip1ltL
	Mw0tjATpasHamEd4sm9ocBNORbFIXPVwdW/lJI8V0j62sWOaMb2oGiVuCqTSHMhzD17JajLVqv4
	zw6l053kT9lWHDJ+ajFu8YfKfOz7j5nYe8JuV2uTQW/f1GKtwDDEFdlVUiCt1I3MN7+DqtTvS0Y
	chleGifWxRkwZZzHD0Sql4gyL4ZVfmK4JDeSaWETfD9Eo/vI5mDZkDo4vlAwhkBGb7ij2TAOfQ+
	OPTV9ZsQrD8Qcd
X-Received: by 2002:a05:622a:284:b0:4e8:b764:3671 with SMTP id d75a77b69052e-4e8b7643b49mr360819511cf.67.1761568032011;
        Mon, 27 Oct 2025 05:27:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMxrM3TrFI1JombnbI4cIGQsFF+5c+IJtmQs1lSjDpkeewUSHV+vo0vRHjtgNtPaw+JhE+lA==
X-Received: by 2002:a05:622a:284:b0:4e8:b764:3671 with SMTP id d75a77b69052e-4e8b7643b49mr360819181cf.67.1761568031555;
        Mon, 27 Oct 2025 05:27:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f83cb5sm2253474e87.102.2025.10.27.05.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:27:08 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 14:27:03 +0200
Subject: [PATCH v5 5/6] media: iris: rename sm8250 platform file to gen1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-iris-sc7280-v5-5-5eeab5670e4b@oss.qualcomm.com>
References: <20251027-iris-sc7280-v5-0-5eeab5670e4b@oss.qualcomm.com>
In-Reply-To: <20251027-iris-sc7280-v5-0-5eeab5670e4b@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Ebl4v/VkXfD1I64iutehxYEDpuSCR37dBGPipaquSZg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo/2UVgfApeHAT4N+V4LHyg7x0l5ESrcN4q1iNv
 VZjO8eLSkKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaP9lFQAKCRCLPIo+Aiko
 1dnBB/4mFowTmni7YzNGNs8otxTB1Zs/ROflmeobxYaKyqK+l2Kg1tP6AELhhyKlWuXjnzh/Pgg
 LNa7ViPYELKbLnCevoxHaxizYIAs6mGzhUT0qHaOgg0pnJ6p73mfvwOCHkF7v1UgikW3+esI22i
 ko+wu0/njrQL2ulTpeMlTaUbg1C4ZcL9kQ6APeH9TnbR/a4qF+KpU/cL+R0cxfWZVNMGfE53xVO
 GusNrdlDRQuaYtB5fdlhAZMgCa2DQUPT4/EZMpbV9jx4cipCc18MOmmpdI7jUkLvgYEWvoJfsD8
 jUhNHCFIG0bF2sQ+qP/Y29DqCmXaXmb66Pq3CvM8FuDCrFkr
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=XIY9iAhE c=1 sm=1 tr=0 ts=68ff6521 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=OYuIXoeRUKmE5Kzn4ZAA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: PEjpqCl6QduGytEtJvRG_OoUmqz6hhbj
X-Proofpoint-ORIG-GUID: PEjpqCl6QduGytEtJvRG_OoUmqz6hhbj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDExNiBTYWx0ZWRfX+1DPj4qtDqq9
 Svj7a+OIj8+jEOskt74QD6cxZcYlnIe+AVaUqI3qDuF9JsmDm7STwUqqHuk+Y75Arnb2lUTgKcG
 VT1FDHa4zFel2k7wGAc5jM8kqkZYjIyOWKHft6ub7Z52x1xoMDDRyIgq6wLZuityCB3kXDJOT52
 hXh73P8rtPkIWJ9fW8YuVZtAbQOTnUsgiSwnLdOg3ZOZxixvyjFtx2Sb/KUwsVh9idEiH2U9yK6
 ZM/7gxWAsnVcCNhlLb8gFnGdXikKtfovOCCI3RfCqRK/THehNcsKtaFFv1OPOSEoFNwbngaqHP9
 voNffNSr2iMUG5eMP8JXHuI9Ca8ncffznoxCjOm3nC4IIaRjCtVcotgq7eAtYZ88Bd5Ft8ve5Ym
 nSyxuPb0ueNidmnRD4Vr5Ewv6bYWqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270116

In preparation to adding more Gen1 platforms, which will share a
significant amount of data, rename the SM8250 platform file to
iris_platform_gen1.c.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/Makefile                               | 2 +-
 .../platform/qcom/iris/{iris_platform_sm8250.c => iris_platform_gen1.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
index 13270cd6d899852dded675b33d37f5919b81ccba..fad3be044e5fe783db697a592b4f09de4d42d0d2 100644
--- a/drivers/media/platform/qcom/iris/Makefile
+++ b/drivers/media/platform/qcom/iris/Makefile
@@ -26,7 +26,7 @@ qcom-iris-objs += iris_buffer.o \
              iris_vpu_common.o \
 
 ifeq ($(CONFIG_VIDEO_QCOM_VENUS),)
-qcom-iris-objs += iris_platform_sm8250.o
+qcom-iris-objs += iris_platform_gen1.o
 endif
 
 obj-$(CONFIG_VIDEO_QCOM_IRIS) += qcom-iris.o
diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
similarity index 100%
rename from drivers/media/platform/qcom/iris/iris_platform_sm8250.c
rename to drivers/media/platform/qcom/iris/iris_platform_gen1.c

-- 
2.47.3



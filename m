Return-Path: <linux-kernel+bounces-744517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A4EB10DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933D1AC1628
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE802E1743;
	Thu, 24 Jul 2025 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UcZAcNcP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC2241CB6
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368110; cv=none; b=QM+6RE/hmEAibXGfnE6siMiGWDCgQETi8v4a4lyb0H8wi1pbEqheN1mhnCUhb/9kFUEAYdzss8IXXvsh2dH3BImmOA3To6zImU+TqvomIIs9U1A3A/GhoQqgMydZ0RH3r0jx0u1NKOgRYFPwexe3eIVPhDTrK/Ko33ID0xlfEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368110; c=relaxed/simple;
	bh=GDxIpn+HjBE/i7KQ8HLxbsTumEXzL1xxNJJZDvJblB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R73ZydEmB866KP0TgMQJv0QWiQnrGjl71YhtNnn7FMP13TrRpJo9Vs5C7+hyQcQntuT82vZWGNftGr1TyD8LpoLp7NmTLXs4BxtVxUHSLDaGHAE4PWYMXsuq5hrEMeFhvUhdafWCUch32o1wj5nh9/UVjQgco/iVJXRQ3fEgYPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UcZAcNcP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9gf3I001684
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=KeXH5ykokOM57Pag681/Khsyjh3uAbBGZxE
	7rDNyeH4=; b=UcZAcNcPXKRwFMv5k5Ci3+bQMnLOFii5/HZRWEAirMqSxw9kc1i
	eGZuzqcpMQ5LwA+br5Yc1clC5rI83p6fb4E7/WSU+Ia4C3Zdh3fB2A24tpbGNrVg
	o74vpy0dFvCNkYM6Dtpptj4WBsy3fVdsxs+DIUUCjOt5sOZ7AgGMBq4WnZcbf+kP
	RJIkoXN7oWKzbVZ8o+fzvl3QxfsFzD79pWg6oT5zoW0Eqwd9FqMGA4wixBeLTNja
	btU1tyknKL4B+qeJcE5iM9rHYmX3wirrnDNsdrXSIjPqle2Olny1m3l2zI45EY5C
	RF1I3BHI8Um2J6P1T5z6GY90xuyLUdzU7Ew==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1ufpc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:41:48 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-886f7f4e6ecso19096241.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753368107; x=1753972907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeXH5ykokOM57Pag681/Khsyjh3uAbBGZxE7rDNyeH4=;
        b=X+fg5kgGUIHBkjr6AvzGse8EH5mQ1X+Pxlxx8nu7+pdyhAHcTjh9jOPZ7AlPWM+XMX
         JyC0DAY2wq9x6bpG67alESdvQgYZvxfmEAy535+FRpjZcwU+wR7ismVBewnM9SGsZg5O
         BehskWlsfbsUJ8YKSzj+KsLaLEfFsK14jJ6hZkSIy8xBjOkAUxthmHp+qs3i6OCokeBx
         ++ZzaZe1hrVhpaD0aRVws4dN9N+9rvHBcfTEZyVy/hm4V/al7zWNueqj4621pZAveE4/
         nePiDLiFMvBvZIKy6wRLaK58Cv8yjy/mCRD8g9BaU2A2I/riZIGfjEGNkLzibXLxpZC8
         EStA==
X-Forwarded-Encrypted: i=1; AJvYcCVIpwsvR5dOe8MY77lzpCW+YZzo4j8iBA3AQpKvw4OW0EcvuIunECAk0nxSq9EAd0Nsr0h93MdbNjV+Rzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWO0o9s1Jn+BXQ2o9CYvqomm1Sw/P2WnFqB6M2NL3hrd6TgalW
	D/fhFD5wyB5bYR0ZuIwEaVkFu/MiIjgCz0ZLs8+B8dbHtBnlerfHJ0XHBZIg1Lqb7U/vXJ7c5hs
	IMez/7BcDEvIz9IXmq12ntwvqY9FwB1uF2FnOgKm4aL42QKvhIOOoZ7UPHeSBzWEdXHk=
X-Gm-Gg: ASbGncvgJG1WFrKF/KzD8HEmo2ohb4qSBGT0U3S1r19/KOKB8nsHMRcm4aKxXvhd9FL
	VIOBZANoYjtN4+4hV3hlAEfwn3D/Wmy97urEJzH8KIp92XtgDWobfDC9cGoTcGYEtMM/E7XdJNM
	7irmhBVKzJqW3eFJ3h+qUVhAZgOh7fFnE3+t4NDusiUgoRokmCYxriYAbgDTv7yzR/Vhjoo9bEN
	Q1LY/vnxVsedwvxEQP9Hcnn3dOAbZxBL69YjVHaZbgz9nksSf+xhohHC3CvZqf+ncTS4YLa02B2
	qj9kfgLV/0mXhdIwmyHQp8J4TWUrZRMeU6aC6OpHffV6K8sjLXqiEw==
X-Received: by 2002:a05:6102:8007:b0:4e5:9867:14fb with SMTP id ada2fe7eead31-4fa1521fa52mr4134451137.24.1753368106739;
        Thu, 24 Jul 2025 07:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6qBAi1QNrC53DVwX1YpypErqxTm8Id63ihlek/m4cP6hTLHXgkkHpe1W6HgIWVH/KotXkgw==
X-Received: by 2002:a05:6102:8007:b0:4e5:9867:14fb with SMTP id ada2fe7eead31-4fa1521fa52mr4134418137.24.1753368106328;
        Thu, 24 Jul 2025 07:41:46 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458704a77fasm24268285e9.0.2025.07.24.07.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:41:45 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH] MAINTAINERS: update status of ARM/QUALCOMM MAILING LIST
Date: Thu, 24 Jul 2025 15:41:40 +0100
Message-ID: <20250724144140.108251-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=6882462c cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=YL6Xjd1eAAAA:8
 a=w5y3jCgQB0Bs7eq_IqwA:9 a=o1xkdb1NAhiiM49bd1HK:22 a=yLS1KB8ZbIgHeRWbGdJx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDExMSBTYWx0ZWRfXwYL9JM0Ummt4
 AGFvScyQAtbckaxNZpfLcLB2iDegwvrbVPl12xgzaN0OdMtGtP5Ao+HsOhMnh7+VsylraMsuKg6
 QcpC3wgXYMigYYW6r9CdqAdilmu3pfX6vbYxXBpslMazTK3XdFoEctZOzNQusnOwL2CchrOhAYa
 N7/B8yjd8QFuRrXNpVHwBFKKRmrRcI9dGfbHF9yt4SECAEcrpnShN8wUSF1XX9BXKx+qJC3+Jzz
 PAPyKEtwEArXmD02VH0oPa9YJkIFhSfafgs0Kpw3VvfrPrz3kMnSxXFmtvlxZQM0sV32NFXN9cR
 EOOpcNw4LgDQz9z4gYvJAn2NKyaSrwZB14aaecaP+RoJ/9ehcujJcMadZoR7hIA/4enHiYpPxas
 tfbWj8pkNZqGXx7lVMrB2DeOajEsjEfMTuJl5RGK2oD5/JrUIJx96LxXAoFZLYVDVoFwm1Xa
X-Proofpoint-ORIG-GUID: jRuPukO4yfhP2N8G69M8IPbygXqWXDUh
X-Proofpoint-GUID: jRuPukO4yfhP2N8G69M8IPbygXqWXDUh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=682 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240111

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

get_maintainer.pl will reports:
ARM/QUALCOMM MAILING LIST status: Unknown

this is clearly not the state of the drivers under this list.
Updated it to reflect the state as Maintained.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a510e4aab9e..6c0ba1827fcd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3076,6 +3076,7 @@ F:	arch/arm64/boot/dts/qcom/sdm845-cheza*
 ARM/QUALCOMM MAILING LIST
 L:	linux-arm-msm@vger.kernel.org
 C:	irc://irc.oftc.net/linux-msm
+S:	Maintained
 F:	Documentation/devicetree/bindings/*/qcom*
 F:	Documentation/devicetree/bindings/soc/qcom/
 F:	arch/arm/boot/dts/qcom/
-- 
2.50.0



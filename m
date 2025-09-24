Return-Path: <linux-kernel+bounces-831391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C7EB9C89D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A8517649D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304D625484D;
	Wed, 24 Sep 2025 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B0HdAZPv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECCF296BB0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756303; cv=none; b=Vy7bhwRTbHEfMtmODssKpeoqqxb8mFm1ri+GdEHP91VB47iUts/qrTg0lNFjIAXZodp3J2oS/s2jqeMysuVEw7u6xksRzGde0FYoS7IncCitpk2FcsmazY7/Rm5FcYViu05ScVfT1z/6GXwK2iTq0V78wcPHaIds1ADKgFANDho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756303; c=relaxed/simple;
	bh=MI+oDiu00bDNElmLAuaGTsvYSs8RidGNhGOUz5lnDpg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Zgs1YXa14Rp4BJ9pXuJheu76wlzOtCkqWgi91ch0MmuO8EZuI/dkhBqQoK5QocePlChzr96i7DS6PM0cTn00ZxX/7JTU0KuFkqSf2dzFsi1xuFDuZ8iPwu5PIr7o1Cw/bbxa5qm+L4tdKP5UDHSqT8tSD144HMDTlwFJ2M1VxSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B0HdAZPv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD413c025283
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8KdGeu5K7BBKtWTMDnBNdL
	ma1q5nCzSjmalU54sb2TE=; b=B0HdAZPvF/Z5kAyXztGCljpaiJ4SBiLgx7wtK6
	J2LQe4auvvjQlrN094ojwY++N0kuNd5C7O1FnfX4NtpUOOqSMuNfMYe/ADQJbkNS
	DMVKfSxrbyYzp9kn6g13RgT2D1F0Rn15tlJVbnY9xg93n8EGzTQE6P2P689+UYio
	Mq82MVnngEjezaHprv0TzsVEtSjxz36dleZWVS8Sm+DSr4PiSuznqe0SlgI8qTZ8
	T/3CgLLGH+fbuBaxj1jotklq6iUYcPywbyb5ml3H1Lxm5DTFlMpGVonto67PpLhW
	p5bs9UsOHcqrlp47M5u3Tar4qyIVcdBxXpNrZmZjdj683EnQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyexbcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:25:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-252afdfafe1so3428555ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756300; x=1759361100;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KdGeu5K7BBKtWTMDnBNdLma1q5nCzSjmalU54sb2TE=;
        b=tXQaHLtYyqREgzeto1A3+fXSttJaLYhTRP0JxoGFRfVd1HMR7pM0gaWoFDjvrrqcx+
         VbmU9L29+yV6lu0EB89rlmxJuc3m59/bS2FS5meyKWLillaH9xiH5/7eM7drPO+2BQgV
         nPa1yaCEWGJFeSmjNrcrbDBvlHlFHoR8mEdPUEYKRXUUN30zfKYWIkLLK3enUwgRNFR+
         fNGXKQBK1NOWo2OqJbgCTsnd85N3kIinBV0st9NZyDrSSEcscN1pTvsEhq0eM90i0aPq
         lbXrHTxoOnjkxX8RJiZzo60JxblI0vNWBSLL6i4jIZor0mR8f8+PE7Iu4Nm2TlCKuBgY
         +Y0w==
X-Forwarded-Encrypted: i=1; AJvYcCWJ1rktGZkm2jOV2JJpGuJh0XcnanZ44S2D+dUdcnDL9lON+4/bVXzqHOJ8VHJe7IzekLa5vBp0GvAXL7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZb7Hilad4n2XaR5oYoNRyYHBeKiFJnjlGc97uDId/6+1GjGV+
	W7xZ1oHNV2Ct/EynYn2/kUHzbb3442F6YNJFylIhWps/nyIIh1WIMxoxXINm4wfO9jroTso+gCJ
	z4x80rheEmmYjXDyXVwBF5H9F6mUbkoUSY3ZALRblmCOegaRPp7KrOMN8G0xdXdD5RQo=
X-Gm-Gg: ASbGncsuKtqWt4oMBdICtgos+wCLLYjKiFw1X+ORkWesU7PPd5m2u3yWwHHIr2F+H39
	PzDjowZUqW9w5gXjWIDfrMTprMJOzcY2AR17mxD6I6tkVvQvfk3ODx6/EaITLzSLdGEEW1kJrJM
	sE/lJXoBq6cnX1VD0ym4JeT4py15qV2c0mwCECh4I1gnSBUHtrgbjwx+NAs10TXy6LziRZassyG
	CR137qg23d4rQ8W6VDS8MkOw6bID+z+gg9a4zHwPDNxDXGHXGckc81Ew/VTYMcmInJXxCvi0Za8
	wesS/AUFL06XhUQm6MTSkrkU/vWOQKoS3yMgmo/EHuoby8hQhfPgD9S7saYLCs6kKZ0sFNiDgqC
	K6uP95S5YbuBAuF8=
X-Received: by 2002:a17:902:f785:b0:274:6d95:99d2 with SMTP id d9443c01a7336-27ed4a2d5d2mr14643025ad.39.1758756300430;
        Wed, 24 Sep 2025 16:25:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECljeDSgjgvr7BJ7mu+OJ5KGFzardlicdMlfpmJ1vC8BfK87jqUZ9dNR3gYgBaoz3oAFyl4Q==
X-Received: by 2002:a17:902:f785:b0:274:6d95:99d2 with SMTP id d9443c01a7336-27ed4a2d5d2mr14642795ad.39.1758756299989;
        Wed, 24 Sep 2025 16:24:59 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821ebsm3981745ad.84.2025.09.24.16.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:24:59 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/2] soc: qcom: llcc: Add LLCC support for the Kaanapali
 platform
Date: Wed, 24 Sep 2025 16:24:53 -0700
Message-Id: <20250924-knp-llcc-v1-0-ae6a016e5138@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMV91GgC/x3MQQrCQAxA0auUrA1MKlLqVcRFMsY2WMeSlFIov
 bujywefv0OomwZcmx1cVwv7lAo6NZBHLoOiPaqhTe0l9dThq8w4TTljz2eWREJKAjWfXZ+2/Ve
 3e7VwKIpzyeNv8OZY1OE4vomylqtzAAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756298; l=758;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=MI+oDiu00bDNElmLAuaGTsvYSs8RidGNhGOUz5lnDpg=;
 b=gMu8aOhdUWBv94p02qg25ig7CGC8YJqSufna5b7KLJXx105wkytIqbMjLMZ9rMqm5Oj9K1gnF
 CwKn6Cgc578A1j15YDsVPkAAeLT7ANCpD4bzncJqVrq5pHAbQl5SmUt
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: kva5TlbkqliXJInivWyNbC4t2SKOh7qe
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d47dcd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=5i2LFDMG1PHuSPdXgAMA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX9Q45NxHczDXH
 WwdreJbH92dKkAiTE3GWAOGxggx+cn02Xuy732hM3C9jssi17loMonD3fQiwNJyCFlg2J+0/Goi
 LKHkuJHwpLRVCT2bGsFcfrfcuC7wlSLOav4Bpy3OdA38K68kIy3rZHbi+nuSecq0A/hoXAuaOXX
 P3JaROg3V9gJYD9W1je2q+7msB8E6rKY3BktpvQX7qtChpwFXQXSbntM43SeipmK2leshZPu/+A
 lC3veg/m2eXWOA0JlzvMh6fCLLbwj0Iu7BFshtci3lgifr9eQfOMtGqlmXVhOiL+HVtBpBKLmyg
 yGch+sacfhOdJ9ULodu7NvJ7Gpxrh2febL9oOGL8dhWNFsPPOui0HYSEMWb8lLf6c2Rg/JmcoMt
 3+IkVmyL
X-Proofpoint-ORIG-GUID: kva5TlbkqliXJInivWyNbC4t2SKOh7qe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

The Kaanapali platform has LLCC(Last Level Cache Controller) as the system
cache controller. Add binding and configuration to support this.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Jingyi Wang (2):
      dt-bindings: cache: qcom,llcc: Document the Kaanapali LLCC
      soc: qcom: llcc-qcom: Add support for Kaanapali

 .../devicetree/bindings/cache/qcom,llcc.yaml       |   2 +
 drivers/soc/qcom/llcc-qcom.c                       | 373 +++++++++++++++++++++
 include/linux/soc/qcom/llcc-qcom.h                 |   7 +
 3 files changed, 382 insertions(+)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-llcc-9a3ab01b1e1b

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>



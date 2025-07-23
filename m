Return-Path: <linux-kernel+bounces-743283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A2CB0FCE4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956D1587644
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E22283C92;
	Wed, 23 Jul 2025 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LpsmPp1k"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA7827EFFD
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309698; cv=none; b=OiQJwfX0oDNlR67T+F2Ygialek2FIQq6W3zmDP0P41Fi/kXfvkzSCK4cmzQxnKt8nxuB+70HuXUCZWs4iIv4mDpXIv+/97O8Hvkn0o8i+ACNdwmfu/emRhqsQyxkGvRdVkI5NEl8Wa3dZky0gLeL2v0s9YeOBC0cxXj/Lcemvt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309698; c=relaxed/simple;
	bh=W1uXbTmsNMhMMyXy2Ux/32rAxYrWnHpU/nitZXsHqjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDYU1OGBUTHaWtZTK4S7yrZfHocMHZHzjrS2dShxqT10apnORA8F6AyuqC4TU302vjA/rDbOco3eu3NNXtBOvhQqAR8PZcI++BZGNv+OLCXroCPX2OgIbkn7NmQ/+NZulODcYz8WGJuDSH4RNPNVLDXoUjM6wFWvrqQyHZEyU08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LpsmPp1k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NHm2s5019487
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UurPSuwLvsQ
	5NrNV5gLdgbM9aMVO09Q2yfwt2uIkKvE=; b=LpsmPp1kLv/hku/pyPACK97F9gL
	0ONHYTHM8jRttthh9yJzgQ+BQmqAgcVVbYQ8ZmLutw/wPmkKYayU/iu69PL8z0lb
	Qbi3h47qNyhpHcIVThh9Gq/1+FsvqtZeX796PYpQYuy/pRZPmrJwMXaZX8/IF03q
	DBsrcJ6pnv3mi3gK1YbVj+IPOyWrBSqoan5FxaaBG+6HheAuuH6CHwYf5fMvVV0L
	tslx5jnMh0nMxM8DI9KZhF+lOu1Sk7jzh0pHklv7tpq5SwxMIUomnsexw7viCC1c
	YWeVtAM45UwDGdOAlXJACB6gpx29cRBmBETidSewc8JW2CPV9bVuMh4XNKQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6ruyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e347b1a6c7so102669985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309695; x=1753914495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UurPSuwLvsQ5NrNV5gLdgbM9aMVO09Q2yfwt2uIkKvE=;
        b=DbKQ3JO9Bu+AZdh16oS3B5hy4qOOuVKHW+uwy4R+Hs5dDzQm4SbQ9e4X3Ei4NeLswm
         CCSyHMrcn8EPrvgRdRqlZ1iBS23NDF9THcrlm/81Ws94Zb5Ei5nXRaljyHEf1lhPut9G
         UAZHQD3rx9WfAK80fnVqc8SZj1zXdbE6nUfPGdzVrOWag53LaKI2pd+53z7kM2VX017p
         crWXDwchnkDCTYhh08wmZY5NN1UtjsQuWTfI8iuAE9VpWaoXTFVhMMtktAWpuOACpjDw
         5a/ngr+NKCpKSdIgDIgtkXCrpg6engrkwso+6zKcOP/91uJHw/zKPOCYZok/f4s4YLTi
         ChtA==
X-Forwarded-Encrypted: i=1; AJvYcCXB+yi91UdIJ6eraWpJ3v3yl0/5Em0k8SPaBkMbdsXSJvKKYR43KOSXqk9N1KuO8tbyesAoHYuYPjpB9QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwElXoFkL7fu51KLFp1/lvbWWWo+zw1+/OrTFRPWKmt4UThXe1Q
	kKdtT+04P/CdHTsjk2sy07HOugK4E7tsMoP8cXwH8V+UTcjlgJz+8cR8+1NMACHJV328AXVqIKu
	OElb7HnvEbRsb9t/xjywYNIDVuiuk68AaL1qenJgXYLEnkKNvuWIkFZ6VshePG5zC6Z4=
X-Gm-Gg: ASbGncsrm48KEjbUNeLS3b6L9lf7gwm71xOISBTYMPnAaRC10Q3g1y1EUETe7r30iyN
	XluA+l7X78MPYgDEqvaJGGwJZGPNQMkcEHjfwNgmB0zBatH40EsuglVRsQBCr2Xwa5P7BMDF8aK
	PBZIOf9E/t0BOdMOyaytFGObacx2FsCTgDCRze+zFV38kRC7Y6al4Q9FzYA2SsXd8ljfBdvDkvI
	pini80p4/GLRRrShc79DqdCtQ77q5xKxbxe6EEw33pxdo2DtV/1YSl97iBEvhUoCN9lIICjK5GC
	fD7pDO6HAVpReJlR2Nv6/MdiydiBuPOvfBgFm6vhX6LljrQHTp7/xw==
X-Received: by 2002:ad4:596c:0:b0:6fa:ce27:5975 with SMTP id 6a1803df08f44-707005abd62mr63190636d6.22.1753309694808;
        Wed, 23 Jul 2025 15:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp6Ef75jlerxYrMg+FmKFlFarFjYWrfMy1DVApQlTuEoJtqEvUFn5ycjc6wY02nR5zJyHjvA==
X-Received: by 2002:ad4:596c:0:b0:6fa:ce27:5975 with SMTP id 6a1803df08f44-707005abd62mr63190396d6.22.1753309694411;
        Wed, 23 Jul 2025 15:28:14 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:28:14 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 22/23] arm64: dts: qcom: sm8750: add sound prefix for wsa2
Date: Wed, 23 Jul 2025 23:27:36 +0100
Message-ID: <20250723222737.35561-23-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=688161ff cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Nfxnn_ge1f9Pje3RmyYA:9 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: ccqeCMmxLcFtTerteiOw7F1L-Z23u_H4
X-Proofpoint-GUID: ccqeCMmxLcFtTerteiOw7F1L-Z23u_H4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MyBTYWx0ZWRfXzURjcp4kqCj/
 g/2oNaoh1ZkXijdpbX41WckvLyukn1YSkVFCM8MOMUJybK5xy3utsptRkKt5A0szxwdE45V1pBz
 t0g5HH97JlAeLY6h65kiefEOQwMR0VW++5l/fGLb6LA7WohILFqiGJ4avlOq6VfZcsDFymCL8+Z
 pxYIAx5k6/SkEi+3GsxWkLBMZy65+nkl4NcKoLp7+eEFmCoFrMwhZIEE/SmnF0ol1udGmsnlafw
 tYHf2GCACq71U0vYpoQyIOScW6jpojKYxbdiVcKawd5WSbN9/qyZZ68iJsHrq+kuJsvTbj31Ja7
 i1msedTFpx1LwHqUDgLhSTPSreCLYLpGTJwq5oGZGo9YBMUQ9dnZqMrEUyLC3dacRNBF34gRwkI
 Sk2dTvTjicFTYb+efmxuMCKac+xjA0PT8GOgyyXVJUISUUWhQFFMBjZtpNjaEvGFH6bqmmAh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=797 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230193

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

WSA and WSA2 are two instances of WSA codec macro, this can lead
dupicate dapm widgets and mixers resulting in failing to probe
soundcard if both of these instances are part of the dai-link.

Correct way to address this is to add sound-name-prefix to WSA2
instances to avoid such confilcting mixers and dapm widgets.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 952f6cfcdccf..c9abffcdd21b 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -2213,6 +2213,7 @@ lpass_wsa2macro: codec@6aa0000 {
 			#clock-cells = <0>;
 			clock-output-names = "wsa2-mclk";
 			#sound-dai-cells = <1>;
+			sound-name-prefix = "WSA2";
 		};
 
 		swr3: soundwire@6ab0000 {
-- 
2.50.0



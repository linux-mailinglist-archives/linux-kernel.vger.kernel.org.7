Return-Path: <linux-kernel+bounces-743285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AD5B0FCE7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5160358782F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0BF287266;
	Wed, 23 Jul 2025 22:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YsDbD06E"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA9C284B26
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309701; cv=none; b=QX3xQ5G6U/wqwY3vXqr6PLoEqOSy1twgr73iaNt/E3lNk3lEsXpuApivQNsvZ1RA3BOsTcomqJ0FuEEWYpCMW+/tYZcV7oGOG9JWCx7RAu9YMZ0W44ihwxD2LDaUt20dX0f+CrAUTNBLpYEbKNp4DScDjg/9tGFmlxaw4+23dVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309701; c=relaxed/simple;
	bh=D3W+0VC4PAlVH4emFw+f9hnESmnnidbvOLACGA+ZUSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1dTS59xfPoJiIDIX33bPjYqY7hFBJNlxxM0xwflgZv0fbXRGtLjci5lYVU/MMLDd9Jz0dXkK5f6TYiwpHziGKxqOxadJiMzzlC7rPwo/Hd03Bwug6CuefoBHxhCjIGODmVokUXGAPWFI5laHWWlzhXX0ivczk4++OcYRnRqj2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YsDbD06E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NH3SoB009376
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=92LZIjDLudm
	4UshzJZBlykikxYDTfxT2SEdJRgplJ+A=; b=YsDbD06ErMWsQRRQBAtkuj0og7O
	74bdVOONVwb9vGTPMj/OFlM4weReTOh8Nlc2D6z/1FolLKOGIMqgvTWLiCQCSJC/
	nEQfZ/Dri/JBqVnrvZ4S7I6sWVt0J8RHBF1XMVitQ6iikPu18b9Dep5sQIpNLjzm
	0HfS61K1BK7s6XHxWA7jZMTy8qYOdpZBFYxLFNgEE3S76NE6LB0KYS23ld1QWoLZ
	bT1Y43GIIg4OCGQ+F398rQE/I9qmm4q6D8OkXoWi+vkvHxlW52X0pe4bD5cLK0Qb
	3jNR+/zl8IjmGxMc62Ztrh04kpnRM3uZAMxYRKwZFbLEDB+9KnbUO/UwmoA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na555n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:28:19 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-704b4b61d10so8400126d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309698; x=1753914498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92LZIjDLudm4UshzJZBlykikxYDTfxT2SEdJRgplJ+A=;
        b=JGRfnfvV9G2623sA1CV27QTc2b6wGGL2VFZiLJtxcOQvDn7j24r4QyVuHKyRcdSEAX
         MEumh9tQfYlwsaC4er/jeQTi2dMIMj55SgGwr4fp/UZy7qagRpf6FAVAe5F2FiE3gdLg
         H7CDijZz54NFp5cKJo4WB/k8tp24CJV7sW0CudfL/tS7SZLlcrEMcBXeNbtRr0Pi9HGH
         u8C5jsFG9A75pceXmAOTxcmHrWN7kvSOrQ4iiXC5bNEI3bt+l6KFiMD4mJR6iSU1/mdV
         3bF2CsBQRbKml8Om6OaMGQkjBTAHUV8+MnO2XrOpTp9kd2GtKnHkZvb/3RZqLSLadEBs
         oXXw==
X-Forwarded-Encrypted: i=1; AJvYcCXjm4hpqGx1jK1vokRrNGv6j6ZMD6W8HRqWTmqvPQwYAeY5txK3SX9bSYlwRh4fqDY1coUDDvj5SXXnddE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlLctN/OoFHB/dcMbcyddfs04sQpSm1rh5eFQELWXQwx4gvEEp
	Gecprtfm4mTxXVLhpA9QdVzXrQqZJGofdme/GQBs0gOKXWS6ebbogcnP1Iurc4YdEUnUonnKAAA
	nBuYxG8y5Yuo8cPIUiI4BGM6AcXIX3NEUjzGGNmE8cWWmnhUuHbnT/9eTY+qarHnbMs8LjnE+Pr
	g=
X-Gm-Gg: ASbGncuog3E6+mQRu7BaXka8y9X6ZODAiV7t36ayp4rw+wj4CsYSWaLElimMaT5qv7d
	Xla15DtAeCdt4iMdDoXIs8IrQLZq3imCqDC44ucD76RtQFrMxkInh6BDfZ0xnlM9c7I+XIsN7OE
	cFDR+XkoXQ1iAH6hFkKK80uchuKWQm5kQ+DiAfh7BaW6RTqAChGBFZtxX1mCUBim4IUx96aQjri
	sJZQly3dqjMOo0Po6L7PXQ62s8SXWgb7RBp2UtiX0MKBcrEyEBMYlZi3QO5nrkAKSxlsoiP8k8y
	o9x99N+QSSWrNQXA1pYHkQOHEvPqpRLKY79Qf1ID5NFHos8d/5Uw3g==
X-Received: by 2002:a05:6214:20c2:b0:702:d822:9381 with SMTP id 6a1803df08f44-70700517288mr83901396d6.19.1753309692903;
        Wed, 23 Jul 2025 15:28:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMJbdQKbGqQxac6lcBgDoO54/jpcGXQ9pHQCWa1LXoj9MoBYavd5YJCtmOj46kdsKsTFElLw==
X-Received: by 2002:a05:6214:20c2:b0:702:d822:9381 with SMTP id 6a1803df08f44-70700517288mr83901146d6.19.1753309692550;
        Wed, 23 Jul 2025 15:28:12 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm248520f8f.44.2025.07.23.15.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:28:12 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: andersson@kernel.org, konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 20/23] arm64: dts: qcom: sm8450: add sound prefix for wsa2
Date: Wed, 23 Jul 2025 23:27:34 +0100
Message-ID: <20250723222737.35561-21-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-GUID: joYTQKtubnTjpkflNBUHkvEd-Z2fZqpA
X-Proofpoint-ORIG-GUID: joYTQKtubnTjpkflNBUHkvEd-Z2fZqpA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MyBTYWx0ZWRfX3zywRPcX71op
 f5UdiZzLpcHHxe6tPkeqeBdBzlPRoaTut6dwKRUbvAWpCsvJ2krsy8hbKzpcydSiHkj+4wa2aWN
 PntdVRAMGMoG+EEoyFjH3bjIYfMhRqLxRXh0P/I3q7GlKD8ek4wItZddqAlzsRm842HXXW+F0g8
 bmO7+eRu/1G41WCYmC4csg0BduF92rX+FSi01NtPs+X16y8fjJV46uLGu1Qx6KwfHYkBlIVEVcF
 VHz5qgScwO922Ph+p/WEaYeo49Uth4oxIHQtkdravKdUykeQKOND5PR9Fsub805pybVuaQkXBEc
 e3W6RCi/tWPXV2cqB1NrviF7LkBWJPc+qzVc+mDhzgvVhNveP5PctH4+muUZDo34O/iakcuwyZL
 1XUqMVVSpOLalcg24hY8U5BcszXHM7JK2ZyVQtR1eb1UoahO7usRiARcyn/+qFpn5lq/LuDi
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=68816203 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Nfxnn_ge1f9Pje3RmyYA:9 a=zZCYzV9kfG8A:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=797
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230193

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

WSA and WSA2 are two instances of WSA codec macro, this can lead
dupicate dapm widgets and mixers resulting in failing to probe
soundcard if both of these instances are part of the dai-link.

Correct way to address this is to add sound-name-prefix to WSA2
instances to avoid such confilcting mixers and dapm widgets.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index fa0822c37854..d8fd01997395 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2827,6 +2827,7 @@ wsa2macro: codec@31e0000 {
 			#clock-cells = <0>;
 			clock-output-names = "wsa2-mclk";
 			#sound-dai-cells = <1>;
+			sound-name-prefix = "WSA2";
 		};
 
 		swr4: soundwire@31f0000 {
-- 
2.50.0



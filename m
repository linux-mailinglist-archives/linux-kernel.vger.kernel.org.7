Return-Path: <linux-kernel+bounces-746595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1D4B128B1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 05:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71D1543B93
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 03:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451351F462C;
	Sat, 26 Jul 2025 03:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BMT5JU7+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3521E8328
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 03:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753500720; cv=none; b=ngZk6F/ShqB3QqbyUSfLvYOAZ70MtSKzGF/ZKFmtDG3a7SAEw5t+/CEyrxuuehSBJCSkGz//w6P40M0PsZ0MIwhyFmzdopxLoiQfHsDg0UcnjLsdT+FBaFzGv4oOQgg2NM9mq0BoJ3lq2vSpoczEIWltXktgSbIzY3gJ/JCycRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753500720; c=relaxed/simple;
	bh=zsNDOxtssyyXKwrA/Xqhu6xlTQfQcZiumpCvpHLeiVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qoZ0GOx+aTnNBi2j3e325RXfupHO8ysaDelhuNpDhWe3veg5De18ygZwTtSKKVwDE6Kxie//uI7Tge4VADJlZA+aJEIhy8ZmcDoNw5hTe9tw8Q1X1vkzWMia4EQj8bjfy+GYTT8NpiStAjQ0DhwpFd49vdBmGF6fH+CMCBCSGVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BMT5JU7+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56Q3Vwuv025191
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 03:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K9lCHtaEWJJtL5rVllaD+CR/7jxFq0pVmlc9VCIqSOw=; b=BMT5JU7+OJ4IgIUi
	pGNHw37UW/K+S49N8BWEYXqhg2GzY1OJNPosJoSftnbPEjDHh9lecNTiKyXac3Ho
	W3FxD0/W8KJPCMAywtpzPWlvLiQJoL2veTbTmaZgQQBdPenF+S7KjjLRoHdBE9Dq
	D2W4vZpY2PgiXdnMRto5YhJfAVMzSw+Cjdm/2kdq4nUMwtZsSOb+C1wcWAGNwX6V
	w9sfN43jRwQ2EsVnt7Mln4OEa+HAi+/pYgoXbPrsF0gKvF7Rj96S2N1JU0WzdW7/
	+3GkeWaVSq/HhwWFYQpkM4dorkKPH+ny/mYOQ38OkwflLhfWuaAwp+DpGxB9uuV5
	zawS3Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mqk06xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 03:31:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74b537e8d05so2635491b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753500705; x=1754105505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9lCHtaEWJJtL5rVllaD+CR/7jxFq0pVmlc9VCIqSOw=;
        b=C7nqg69P5Lu1HOi+D4kw0NndIwt5vjm5rDP3R8MiTH5hE4xXVTV4EDThVzoK+4SV+D
         gX8g/XyaVM3kzrUzQOc6Vg/oWii2Wr2zd9VGxzNMqn6BkMPLt92pgET/0kkDLs2Boszg
         aniYC4ijZARoxvcvOb5zb2xNcGjaqDrDxYvkA2Peg6E5r5rP20RRCfgNGOEA5Jd6JogZ
         bEZdapbI4DcaAPMSC+hbYpIQsBOTf/G1kbbpl0bt1F4IFPR3AcGrAHZqEc/h/AVGNBkr
         JyoX5ovWa0uykzDsrWEYOrntvxczW33OtEYm3UQnaTQFHgywwZcOn4P0jvOKl4eWTY7z
         0/2g==
X-Forwarded-Encrypted: i=1; AJvYcCUSJUEUCjZAnv2hRo0a2cEElbaY26b4wjWNsZbejKExDYk+Y+wVTOBYP9DSsTsNgQwEfa5jL/qsuyHpe9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpCrfFixx0GqnDBZ458GAaKbrGXuHAHNypbHZyC2uvfXsVLZqm
	UeQrpVbtqnhHl7xU3wUSOcwcuk+9iPabP14ai9Im9IoGjqHpVZQmGvshKo9WYIInLoaHbIxf/7K
	TLNCtpxxfX+OYBosUW7xqkfB8v1y9KqXvYUrvhmRJM0VVKwFc9wmPGf51ZQOJdOXztE0=
X-Gm-Gg: ASbGncvJjvrLq1WoNSgpzV5wYAQ06dxRemIVucCoLLGQZ6Bi5B15anxb66DtxLLRPDN
	S2EGec+teeEPH6kt3z57MPXYQOSeb0bfmCzn/Zhyn4x+XQXufM601fPyPNV6hfsIo2NXHeuFrSx
	wjcJ8x6ZoB1yx4ohAhDJ6t/hZO1yIg3hhi8FFqQaBAn+I8hf+JIxDS1/RwebYgnRu7H0/l1AktT
	P+XqJFbWy7elK2dkC1kSemUjKmbqhyeIzCbgkCQdc1+tKslc/RkTOITb8nZ37PuIR8dHA1Fwzge
	17hs7NK4jogQJ+zG8h/K3mlu16mCcWeNKQi9idUSfFvISH2cCvpdRuv9toSuQgPTRhj2LZsseRi
	Tg3s26Y1ng1F6ujmvSsT+Kb4ppc3rWyIfTw==
X-Received: by 2002:a05:6a00:2181:b0:742:a77b:8c3 with SMTP id d2e1a72fcca58-7633626dbe3mr7112511b3a.4.1753500705299;
        Fri, 25 Jul 2025 20:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9CpBOldzsPc7XQYxn6ooEk4Cyi0eUr7vpgo9SewKKFuiWYpZZUrxBuSeqFIqOwowSg6JdsA==
X-Received: by 2002:a05:6a00:2181:b0:742:a77b:8c3 with SMTP id d2e1a72fcca58-7633626dbe3mr7112483b3a.4.1753500704872;
        Fri, 25 Jul 2025 20:31:44 -0700 (PDT)
Received: from yuzha-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640881f5a1sm724917b3a.23.2025.07.25.20.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 20:31:44 -0700 (PDT)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
Date: Sat, 26 Jul 2025 11:31:30 +0800
Subject: [PATCH v6 1/2] arm64: dts: qcom: qcs615: add a PCIe port for WLAN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-615-v6-1-42b8150bcdd6@oss.qualcomm.com>
References: <20250726-615-v6-0-42b8150bcdd6@oss.qualcomm.com>
In-Reply-To: <20250726-615-v6-0-42b8150bcdd6@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Yu Zhang (Yuriy)" <yu.zhang@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753500699; l=943;
 i=yu.zhang@oss.qualcomm.com; s=20250625; h=from:subject:message-id;
 bh=zsNDOxtssyyXKwrA/Xqhu6xlTQfQcZiumpCvpHLeiVE=;
 b=gicAAL41NCEWm9ldVtMZGmp4iQo2zQ32Hf7OM5brjjSE878jH5mKlp/cz/SxraZ/wEwE+Sldc
 UM+bKlJXp2YD3leJw8p0WFGkmPHUACeUEZCT8TD/K7UqeYkKUqUrA8r
X-Developer-Key: i=yu.zhang@oss.qualcomm.com; a=ed25519;
 pk=ZS+pKT1eEx1+Yb0k2iKe8mk1Rk+MUki89iurrz9iucA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDAyNyBTYWx0ZWRfXwUAJTNQ5E8aA
 yaZRxZkplmN+Nh7p99A4a7IpGVUZHbAoi+eokZgz9++FxYxKgMJzojjgsuJR7WAd/bQ0cbHNdJB
 8rfJ/cCFUzvyLUk7Q4KnwcIeUXQMJ/S3SufHGuEYQqW7MPHJlDja5bRmrIi9amewdnOG6Kq4xWD
 SZfhmSRGThE5Am74dF9YQDj2aoTqSWmhRhh/oC094zzrMErJDc5hLGHaBwFfbnkZyVIVMwmwieV
 BhGgdEq355ovVVYwmvhUG+h1nzl2DeAt3nWIMl5v3RlB6nRmjDA3vDghcWkI+SpppoeF9mTo0TD
 GjVnnfFhCz9v97XVpKbAl9lN0K0+GUw/duBgP1HbREgfrEFtVTlVO/3OpTGEzpnbgoa5O/oGDq+
 h1Lf2mRB6ebFcwx5kXmFl4BGbZUg9TERWiKoxTZuNuTDqGtK7t86XcH3l1rLKg65Pxfby8PM
X-Authority-Analysis: v=2.4 cv=fqPcZE4f c=1 sm=1 tr=0 ts=68844c2e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=dI-8CA4c5Xf8_vBnWYsA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: zTqEocikUa3iLHds6J0yc7gItJToblez
X-Proofpoint-ORIG-GUID: zTqEocikUa3iLHds6J0yc7gItJToblez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_07,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=992 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507260027

Add an original PCIe port for WLAN. This port will be referenced and
supplemented by specific WLAN devices.

Signed-off-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
index f4b51cca17de5518aad4332330340a59edfdc7ec..b4fbed517cde18e088096d182fe6b482363e403d 100644
--- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
@@ -1173,6 +1173,15 @@ opp-5000000 {
 					opp-peak-kBps = <500000 1>;
 				};
 			};
+
+			pcie_port0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+				bus-range = <0x01 0xff>;
+			};
 		};
 
 		pcie_phy: phy@1c0e000 {

-- 
2.34.1



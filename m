Return-Path: <linux-kernel+bounces-827343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42106B917E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11AE188802B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E5A3101B5;
	Mon, 22 Sep 2025 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ocyQqhIG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED06230FF3C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548569; cv=none; b=V+xMW1yA/UfkUx8CHQ+aRNbPkgL5Xlv+u854ylyOvXSXdnfOQL/zmXcRGYYGf54wKHBnczjbo6HsFoFf67iDXubOu1cZExRZjVwzKPm+jj0WsT+hy/jG0qrEOUlkpDMQZ6MUiuQvVVT2H+9ZX74TdEiE+h86TdbtCiXOn/GkZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548569; c=relaxed/simple;
	bh=G1BondNwxII71bYVJuYm74JpYy3/CGfYOQJXMu36Xxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cF724jXL6ie54GGG4Ty9hm163e3+QavoBMoqF+o2Pr1gKea0qcHsaRou5ZiFuT+GuZgIQq3Wbp/hOlXXUOIx7lGStyvb1D+emMd3v7YGcbUQireoLAUUnYB11exHmM4VeY6qJRL3ZLaP+7hHGnU3lOdHVf3TUaBwhrgrMUzKMiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ocyQqhIG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M9BB5v029230
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xF282k7wXJ8WorsAqXbmD2TyrPkO+b2YocYCnInlnJU=; b=ocyQqhIG0/1m1nDQ
	Hylchoree55eYm72IHN2c8uwGfh65nZrwX5yMJ4flc2+MTHgXWUr2odlZqg+9uPN
	Q/JVDml5KIcNoxnAWjV8US/WqeXW1JtDruNb+9HBB5PraW/R+5A0/IJOkA3xtxtj
	dQf8yjqYJwhoRdPttHHE/WdoCur9htpr46Pk0a+DtBVqPl3/ZzXx7vfahW0xP9tm
	3W23sTKkLBp4LS+dLpEz3bq0+JROFcYv2kpBy172i4qKRvAWyAjzUXQwUzHLGPnS
	1y5v6P3E4Eo+przOQ5OUh/fYnPk5B65Aqf6RSkWu2xvo1UTUjwnSiTNkhU76qcsY
	irfx+Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kk0rvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:42:46 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so4378077b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548565; x=1759153365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xF282k7wXJ8WorsAqXbmD2TyrPkO+b2YocYCnInlnJU=;
        b=DZot+DGKYzRYXARXJGJPzV47LuGkyqdYGyBXX3Aw/UI1iTA8ZsYehITnvDgxxQrug1
         Ibj2KupAg+XkSC8y+kpJ8Pz0OUYxTwpTFyta4FLha0n/iKxd9NR1VL5ImHkJ56MCP4gv
         vOSZgtjXA1kC+D1u+NVxXwqeF2MaodmNCgYPjY+wv3UGeGTWmGtBUI7u0dTaZkLGmZjE
         j4Y0Wlm5+GvUXG2CImRqoUWwzVBeNDhcFB/RQFLknJPMZ0FUBQy+0GLvKr4dWJZmKQ/a
         u1qA1l7gu5GaAas0rIyeiznn5Y9jWA17DbjDviZQUeoKmEH2upBpIgftBL+zOvte+tE2
         o/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWi/SXmrD4B1GmyH1GgMMqNYLLcMFKW/f3+DBlACwKPLQUkFKvry3TN3cn5VuOiahDGnXdL7AsbXAJWXW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr5mIcCEz6NkGaysCeo1S7ZEatXdY1GT6//14WO8d3ty5OS7hL
	/09Yk/qTJfny+hUvdgYJhyUUNcqeRbiMZPtfmAHGIm6ID2oag6m+EnbXuSMdDXhAfJWzev8Nhn8
	akhg0/o3HXBAC7pt6OoRlyJkTeoz5D/MZVa+wFqtuUhGVASvrSH9L/QAeVppfdJZWF5g=
X-Gm-Gg: ASbGncsjiiQFUtpnvk1ZpTgAvwQzoUO3hYJbvuf7UvAbAeHDwRSxb/n+YQi+MIyIM6g
	hoNwh22fasPxz2+GuNlvuudoEunHbtQ5tF7GFz6ND8N5wUbRGPwGmj5jChG8iimJSHYPlprXrd+
	4OxYLQrjIkg1YAqk9Sb+Zw94yk4MRg6Aats8WZKysv+wAFCqLdgLxXCP5YmnIVJiWqyfP7Dd1k9
	R+X4fp6st43WXA7Ya0vKKU3gZf0/IvvCIaBCNNeZffdNzK2Dxtf0uy1ZSkNVEVTe1w1GXrJLyRZ
	q2ioXJdIPK2/FxfSoDOBNDtOL9rgP02mk3V6NRczuXQuI1wNOrr/wLaZywGB87P9bWoRWb9s8BV
	9
X-Received: by 2002:a17:903:3d8c:b0:24b:25f:5f81 with SMTP id d9443c01a7336-269ba439f8amr124646185ad.17.1758548565375;
        Mon, 22 Sep 2025 06:42:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4mN40qVZSWz0W9D0CtJAtXceZAK1xhkSEtmJIUXhTWTfJcTx6aXvqIGkYbWG9m156mJ0Avg==
X-Received: by 2002:a17:903:3d8c:b0:24b:25f:5f81 with SMTP id d9443c01a7336-269ba439f8amr124645855ad.17.1758548564829;
        Mon, 22 Sep 2025 06:42:44 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c13asm134246755ad.46.2025.09.22.06.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:42:44 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 19:10:23 +0530
Subject: [PATCH v15 13/14] arm64: dts: qcom: monaco-evk: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-arm-psci-system_reset2-vendor-reboots-v15-13-7ce3a08878f1@oss.qualcomm.com>
References: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
In-Reply-To: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758548419; l=989;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=G1BondNwxII71bYVJuYm74JpYy3/CGfYOQJXMu36Xxo=;
 b=LFc5Z6nf29wlIhd1CXRGQpvPgzUhQTtOP/larFAQIWR/CtquNgknXkMHf4pmi6tx/hW8PRMHX
 9bMGBVHYvneCjK/DFOFTeh3uB3CKgW8rGGV9kNEjFI+kuUQADQz7Q0w
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: 8f1qYFge4ZZlB37gKF3sbdcZi2-ksReM
X-Proofpoint-ORIG-GUID: 8f1qYFge4ZZlB37gKF3sbdcZi2-ksReM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX3ULwMLOp0Dfv
 NT20seDYHlsSQuIv7AdyiDN6oMxvNQPSxYyN3qBRSPcnIqh522WSbb0Q1n1W3Qvup1j3bn5BMWf
 imkBt+AcpfyQ9PKZEITsaX3hHVy32HwvIpBPo2iBNQKfwyvvVfZo8skeTz0kJbozWFyXUx4eQcn
 IzS4hFS9SV2L1vBu3A1jdp1YxQH/IiW7T7lLbQoqC8mbuJnPalxhio/EQg/OTY0mcmFzJA0uudr
 AZalPlKSlA0Qbtj5LK997VZ79GkETawsmGCx4ZV0v/N4m54NMb2VIwPX+Ogh4t9Q84sNS3ZSbie
 JMWVwOhq+o4sQ8FjBJkA3Gi8GY8U78LA9KHsB3iA5fwRKZRJko0VKt2bboC55GofxVOmHQkDDdr
 Eg1b/cqf
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d15256 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=JGo1Z14By4IpQyqbhUIA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

Add support for SYSTEM_RESET2 vendor-specific resets in
monaco-evk as reboot-modes.  Describe the resets:
"bootloader" will cause device to reboot and stop in the
bootloader's fastboot mode.  "edl" will cause device to reboot
into "emergency download mode", which permits loading images via
the Firehose protocol.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco-evk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
index 116378d4ce7af4c4b37f5f818fd65c693bfa88db..fddaa8e3fc34fb26796375eda3a6eeb6dfd777ba 100644
--- a/arch/arm64/boot/dts/qcom/monaco-evk.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
@@ -392,6 +392,13 @@ &iris {
 	status = "okay";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x10001 0x2>;
+		mode-edl = <0 0x1>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };

-- 
2.34.1



Return-Path: <linux-kernel+bounces-725339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71BFAFFDBD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECEED5A7462
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94EF29A30A;
	Thu, 10 Jul 2025 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NBeaEdjd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD62292B49
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139018; cv=none; b=FgicPpVkRVlmluK77TaJr639vOgMJXWexkWbDMKuLRo6EvBl71HZu6THXCCLW4ZSTAJ8kDWY0qnaqwdrESgJnRMcQBLystryMNvKFxpiy6Of6+HpBzcEWspwmATGeoMUuqzgAjKgJZ6F3vimlN7HX/apL+nfo+pa8Grn8mu8LbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139018; c=relaxed/simple;
	bh=viCb3VHco50oE5St3/+zoJqA55BoCRGQlTkgrUYg/Ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rbFV2t2bac9X4wk8tAHtcGJkrCSXAbN17q3oKl4BjUok0R3YDFv4v0BXZQgHDRnDF5NOm/8xD00St4yRr9P1U7onf9d5joe3vBFCnAIK3Kvq7Lw5K1hnbsVMbw2d4CfqvuP8O3AK0FxsOmSCjDibVyLttLT3hyEnlgn/oI3bquY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NBeaEdjd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A95YMk016649
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3JHDq4xNymeRQPJylCbaS/K0qseIZK5kd41UanSbGBs=; b=NBeaEdjdL1iocVeu
	/rYDdybPhTfaKd04D1Ltrm02Fx08mFrP8+Y/le3PKMA4E6Yn7JRUshnex1oLmzO4
	V17upqXQFqIWJW0VC2elJMT6XUKi+D6UCEpKt4Cnf5Dma+uw99D57W+ke5kFMZAO
	RZskEFFLo9fkAQzAEv/tQkbxDBDoMomQG3H75Tb8LgpktM7xhfI/Ecb3qclcxFy8
	hWOhYUJLNH2lqiMKsnz8McR/KxxeV0M8+ukKzBtIgWgadj+51FAihBM5uLeIVOzV
	GXb8SVOKU7QRsZW7Q2+WK8Bryx+WBb0Ifr1WrlTIWvq6wS78CokNJ7xx1x1abvlJ
	z2a13Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap4ch9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:16:55 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235dd77d11fso9170405ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 02:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752139014; x=1752743814;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JHDq4xNymeRQPJylCbaS/K0qseIZK5kd41UanSbGBs=;
        b=EESM0k/v2/JvL/WUHYMkmZKmXmgyPfrAbeTe4Fd6tGa7KUkrLGIMh7bVd1/rCoRCCv
         lXAPXTMjXtkvL7rwseAjoR0LlVeGHnrnaLnfw5CIo1dO3vwe6vzLZyLgoYDoyYQHdrmh
         4XW0UTg3J/AMwyHSvBIkkmnty3eLC6xFq9XXL52YME8h0pRxUuzr87DFoBU+0FSz6x0k
         8ZwcPyHna+3RiosDEnTClpki2PAw3RHE4/VVHB280TbejlqAeLbRf5u+upvGQkFHa5SU
         9N5VdyqEqR3aVnmi2IbQLYl4p7ugxqmdYirQ3XH84cNV4sjbw64JHQ+XNkeSuJAoQGuy
         CZmg==
X-Forwarded-Encrypted: i=1; AJvYcCWvOJ/5r5XGvB7G+NzDOuFNS5Q+vlnL4hNjNU6WZ1NriIki969ta232vr//xr0/l7c/d5j1Ej0MSbRtVLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwpVJnn2X95GY8u6Me8Nn05vs7xOby9Mib/P0LJ5Z94+x0uoYp
	++B7c+VZ4TxjUiDaYZrvj7qEioU1spk+PFmDs2tu2eRLbkF8ns/SytXlZF3Oo8cj15k7aCXjXek
	r54hkqBIptu/px0z7MsiqztuibOy1MC4LdkB8n1RdPWuhRf33VrTk3O2euZb1/COqjqc=
X-Gm-Gg: ASbGncuqXxdxpyl24l/BzpbHYfls7eUjXALVqTihSKCK6+T+ZU7P22dFkGJf1qhk7jc
	y1wpsDiC+TvqwAVzH1JpzvZknh+b1/coC9XuN35qoeGudFj9MFCoHkNyYeB4NwlJQAlk1bI5o8a
	C+SHHXFygcaA5l2V2Ev+IpEOUOIRzVtFP2IhnMwR98uWSCaTPy9KcYCPEN346GQsf23Z5cGRjBN
	nqZkNrpk+7htlbYyV7txMZwLP4gFaInvPna4n5Jn9pnFFqxIvSbDSSTfOBIG1x1J3TlsIp8/ahb
	XqaD/DB7kysK8uXCwErfpQqW9yqk82R04L0JpqR0quwAON2f/ZUx5rOSM9M=
X-Received: by 2002:a17:903:19d0:b0:234:f580:a11 with SMTP id d9443c01a7336-23de245ff1fmr43551035ad.19.1752139013956;
        Thu, 10 Jul 2025 02:16:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhuu3BMPy6+m8LotTax4Q3myhPb72nZbkwXLoKvQavuh7mNiBOrFXL2YDf4RnsCd1Y59kqaA==
X-Received: by 2002:a17:903:19d0:b0:234:f580:a11 with SMTP id d9443c01a7336-23de245ff1fmr43550425ad.19.1752139013557;
        Thu, 10 Jul 2025 02:16:53 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341d51sm14837765ad.189.2025.07.10.02.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 02:16:53 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 14:45:44 +0530
Subject: [PATCH v10 02/10] dt-bindings: power: reset: Document reboot-mode
 cookie
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-arm-psci-system_reset2-vendor-reboots-v10-2-b2d3b882be85@oss.qualcomm.com>
References: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
In-Reply-To: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Elliot Berman <elliotb317@gmail.com>
Cc: Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Andre Draszik <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        linux-rockchip@lists.infradead.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752138982; l=1990;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=viCb3VHco50oE5St3/+zoJqA55BoCRGQlTkgrUYg/Ls=;
 b=+tAQXKo/oQadh3EVPYHeqksr67cJmLufTnVdZiv/vcBJ0BqSY+aKThnGkD+4p/OYWNsrrETxS
 MZV5O05idFJChRAtYALBJlBTh7VUYG0QMDDrgODlWIE2AZJ0ZArgeR3
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=686f8507 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=s8YR1HE3AAAA:8
 a=vfvPc3r3pdiY9V1EK2IA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: _2aTjNPOvAROlPIiCH_ALArUddzttrke
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3OCBTYWx0ZWRfXxVezjYJf0M8J
 iA9VnYbGHGEvq7CQD5urZvWzlIP5Hw3iGTFFHE0YueUSS9CvFxW4+8MjbvJE0KFBMgf8mqsZwNB
 vyoHMbZn7QGxQ7j6KavmZagu7051U0Siy/Ct71OuzpUgdq+nsxsr09fm0DfqXuc7YEkal7pgqEL
 sd30Rb5fehLuzEmEjaxN2IJBNnuQ5FcrBA+4HTXOYqfdC1vit+wlt7kBC376ns8XzuKpft3QMZ4
 aYA6OqZoj4Hsj0UGHWiszkILuRCsKDQ//oBnaQw0HRzHCw8ugXsHB8h8SNCu/WiDY+X4CXRX1TK
 OYcYADOyvSKUUVlQ6xJbkbNwkgLEAXWKSIZYf2D5n6lVIHEi5JDPfysT4FTtaYeMpzVmwOKZDjP
 +ho2lZz1Hs/q4eaiEEQdC4B9y+4PZp0vxudN4xX73BH5FT12+juKexPa5sVFspBS0o/K4xzj
X-Proofpoint-GUID: _2aTjNPOvAROlPIiCH_ALArUddzttrke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100078

Update the reboot-mode binding to support an optional cookie
value in mode-<cmd> properties. The cookie is used to supply
additional data for reboot modes that accept two arguments.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 .../devicetree/bindings/power/reset/reboot-mode.yaml         | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
index 3ddac06cec7277789b066d8426ea77d293298fac..a4d2fe1db51e0c1f34ebefddaad82b8cc0b1b34a 100644
--- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
+++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
@@ -10,14 +10,15 @@ maintainers:
   - Andy Yan <andy.yan@rock-chips.com>
 
 description: |
-  This driver get reboot mode arguments and call the write
-  interface to store the magic value in special register
-  or ram. Then the bootloader can read it and take different
-  action according to the argument stored.
+  This driver gets reboot mode arguments and calls the write
+  interface to store the magic and an optional cookie value
+  in special register or ram. Then the bootloader can read it
+  and take different action according to the argument stored.
 
   All mode properties are vendor specific, it is a indication to tell
   the bootloader what to do when the system reboots, and should be named
-  as mode-xxx = <magic> (xxx is mode name, magic should be a non-zero value).
+  as mode-xxx = <magic cookie> (xxx is mode name, magic should be a
+  non-zero value, cookie is optional).
 
   For example, modes common Android platform are:
     - normal: Normal reboot mode, system reboot with command "reboot".
@@ -45,5 +46,6 @@ examples:
       mode-recovery = <1>;
       mode-bootloader = <2>;
       mode-loader = <3>;
+      mode-edl = <1 2>;
     };
 ...

-- 
2.34.1



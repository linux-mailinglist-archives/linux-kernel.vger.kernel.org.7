Return-Path: <linux-kernel+bounces-850777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EEBBD3AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF44189FE1B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E223093BD;
	Mon, 13 Oct 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jU6kE/PJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60743081D1
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366744; cv=none; b=VTazNSqAIpLSkc++WjntxalNTa5jUmT0pVIK/3z7vGPEJaZq017CMbTzUnCRNM3VnvIKb6KDii8PFIyZUIo0A4R7R3kvP4VSoxibCS1AxevsQP3f7G4MofHM9juQEYIuddycqEFotl14vBmqhBuxLqRbdOekMBaj6caHzQOnNZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366744; c=relaxed/simple;
	bh=zl8hIpKvbWN+QijwoLKamyiycgWma/NeSFRF1B0Vdj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ti3xgcshizoE3Nto+22qDaB3C/vsFQbPgbY0EfXoD1qCF7rh30rUHBwKhPDPRJnYBwyo/ZCDaCY6NjmB+r4cf6+YI2JH6qRdnpvODqfIwTt3vo6aMhu9+fGLWqQS13nXd8K9F0rwB+ERTCY5ZPnyW4c9XrMMeirlOhagP90B94s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jU6kE/PJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DAT9nm000399
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gwXP5tcdyruAD6Dm4Pf+yu
	RwyOaRHMeF/cpYgcLJAB4=; b=jU6kE/PJqLN0Kk9LWy8e+lubhfU8gXpOv+kOqT
	NqLEzZ8qoTQ9HloFggYgQa2nDs/WBNu6hKZQczbdx3df+C22sYr3ucGr5JA6+uka
	H2fRxnzL7gFw1idfBBxIywVXc+mpmB0QgsqiaPpr/Tc7v8929CWRWKwgHyyl9p/n
	1gURq+OqVpLlT1kfubhmd5u9lN6+bXpvNO69aMaLFpreZVFNioCYvV8GsWhxFyI2
	dRKcWjaDFMuFLZZm60C/EiaSmqIGrpADUsb+e9xwzBCKi0cnfFHc/Ky1J6vkCuM/
	cTHR3FpCWQUKUi3Yg1sp+iqIbOMg/dLkth8d3rUcWmpoTeAw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qferw123-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:45:41 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-332560b7171so9030369a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760366740; x=1760971540;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwXP5tcdyruAD6Dm4Pf+yuRwyOaRHMeF/cpYgcLJAB4=;
        b=E/2B2gGK6a9luyqkdo50pFWZR+HiU0qL1hvH+BXoCyzNU9lCjCXdofImnTylmaemhe
         uLwIMM7raBQangx+0Yva9x1fbyUzgOAtank2RQz1C0kEAo1hrGd1XTD8LScP4q5txjKi
         ArF9Lahj5HuauOGAARJFT74C7HaNpKIWCCp04yJEAPCiWfKqPnkj/8r+D7R6V+zGe39p
         sx1ipfu85xL4RitOX+bfPKdF2YXpXvAzPhZbUqbMic7v8izkJ497x0/wdwtcEmZ3pbhU
         qNUC36q2ADbi6equrMoFOOVXzEXioaY4kChtt+1YklTuVFZEZwzGnOq//QDDXqdVMOiF
         9SZg==
X-Forwarded-Encrypted: i=1; AJvYcCX3twndj5F/r8RLHlPfRPNkI67/JxS84FDRk4unP51WLeJdUdfGCu6EzjlUf+pYQnIc0nT57G8JGJKWRIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjO7Q5FSyC3ruAl+asmPa/hOP5Hegt9pIMIWimq6zeM0oQ7yRz
	f+iyhpZE2qJMhqT6jqUXq+yyFSct17+MvSaHHtgtr2Eb4M1BoBOuqs6Q/oh9OpKLgZdErEczOAU
	2SAFCVadytnSqFxxtTxhr0tArXcIprfjKyG8rBKi98Vvat5Mhnfa3ZEJg4g2VGIUEzQ==
X-Gm-Gg: ASbGnctUDnaTLvZ7LmMt5sbnUVVrtrSoZVlz22FHlbicPeyA6yD7ndf821jFBNpn4kH
	MrTtize8jRUQ9iT09/IE3HVnchypIPaxgdk23aPCzsOJEjywGCp5mcDkHPNzXW3iMs0lrdncQro
	FYtluwL+Um6og+SsT76AJxmEMt6tfMBDYvJWfnvWi0ucsuNash22uMz2bsEYdMiWkVr/KbBM7PI
	Jr+2T73LfExveCxymE9XItVXRI69LngwD4HmC9yCxaLU7103sc+ztOAdhau32/RMtxxuxk61971
	TnCva1HMzpK8UwT9Uve42NMXldcXipg+b/m/Mr66JWIl6ycqEyKKHISBJBALeXQhTi04qw==
X-Received: by 2002:a17:902:f691:b0:267:cdc1:83e with SMTP id d9443c01a7336-28ec9c975a0mr351888765ad.15.1760366740004;
        Mon, 13 Oct 2025 07:45:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8v2QSCOSIISifuxLmtQAtazVk9mXHFYDyMw8d02GnJ8EiyKRKemYk99nDB8wiR9gbmzodIA==
X-Received: by 2002:a17:902:f691:b0:267:cdc1:83e with SMTP id d9443c01a7336-28ec9c975a0mr351888355ad.15.1760366739517;
        Mon, 13 Oct 2025 07:45:39 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f894c8sm136343575ad.122.2025.10.13.07.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:45:39 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 20:15:23 +0530
Subject: [PATCH] arm64: dts: qcom: lemans: Add resin key code and RTC node
 for PMM8654AU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-add_pon_resin-v1-1-62c1be897906@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIIQ7WgC/x3MTQqAIBBA4avIrBP8SYiuEiGiY81GRSEC8e5Jy
 2/xXoeGlbDBzjpUfKhRThNyYeBvly7kFKZBCWWkkJq7EGzJyVZslLhR0axCbl4bD7MpFSO9/+8
 4x/gAOCOG4F8AAAA=
X-Change-ID: 20251013-add_pon_resin-52f54018c35c
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760366736; l=1667;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=zl8hIpKvbWN+QijwoLKamyiycgWma/NeSFRF1B0Vdj0=;
 b=KQIglZ3lnQwpTI8La2GX4uQ8fNHBOcFowFgSV47lbaNfIiTzT7+ulDLiufNryVjv9z1YcHmkc
 B/kqDYG9h6RB2n8oGCSUZT6WXsOxMGTWFB+xyQZROBtLZXGNjMkn17f
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Authority-Analysis: v=2.4 cv=R64O2NRX c=1 sm=1 tr=0 ts=68ed1095 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=mBVr95QgS-s2Q4V7d0MA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 5cwbuw4EXwm2KtqntysFFJHV9NtC0FAV
X-Proofpoint-ORIG-GUID: 5cwbuw4EXwm2KtqntysFFJHV9NtC0FAV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX/1ng6cCd7Cvl
 Ztrq+boRyHfDQ43eQGazZGTOtl2q6tW0NhByjKwt3nCLHQ+soPljXOEjVWDWfM9pljZVJ6HgksM
 ROSk/3O/dQnt/6kwvw2VkrQCaA8ffd33rjJ8u7YvWSHL5vWH5ShlM8jAtAtrxfRG+zRMdg2h8yI
 fslKlOOUTdGlFDJWhfNsP7JqUSdZ6gGKz6WcAHlIcyqRX6iJzTtbgc0qZ7J1CgBXTnhiYdbY0aE
 N7KUofLjeyszH1n+e2J2LUUkpWRXML6K8jksZFd9f7VcpbSg1UanHxGFVzgQep2nXblPLyn2/8i
 Bpps7CI2UvZGGPH5HLxDzOVt0jlB3eb6vN6uwdXTZagh2ZKXxKt9wy/L+JI/DikkWMqJLcQvTDQ
 BPzKqhVNgYxzmZy3RBgo0AvnaHsFdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

Update the PMM8654AU resin input code to KEY_VOLUMEDOWN and
enable it. Also, add the RTC node for PMM8654AU.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts    | 5 +++++
 arch/arm64/boot/dts/qcom/lemans-pmics.dtsi | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index c7dc9b8f445787a87ba4869bb426f70f14c1dc9f..0df105755c328706475cc1974fc45557d0a7bff5 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -587,6 +587,11 @@ &pcie1_phy {
 	status = "okay";
 };
 
+&pmm8654au_0_pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi b/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
index 1369c3d43f866de9d8cd5cd4985241b99c0a0454..4eda7043b851f363d0bf053587fb1f5edae0c4cd 100644
--- a/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
@@ -142,6 +142,13 @@ pmm8654au_0_gpios: gpio@8800 {
 			#interrupt-cells = <2>;
 		};
 
+		pmm8654au_0_rtc: rtc@6100 {
+			compatible = "qcom,pmk8350-rtc";
+			reg = <0x6100>, <0x6200>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
 		pmm8654au_0_sdam_0: nvram@7100 {
 			compatible = "qcom,spmi-sdam";
 			reg = <0x7100>;

---
base-commit: 52ba76324a9d7c39830c850999210a36ef023cde
change-id: 20251013-add_pon_resin-52f54018c35c

Best regards,
-- 
Rakesh Kota <rakesh.kota@oss.qualcomm.com>



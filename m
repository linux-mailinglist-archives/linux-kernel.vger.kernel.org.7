Return-Path: <linux-kernel+bounces-827338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F68B917AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD662A4DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A564D30F936;
	Mon, 22 Sep 2025 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NwYvpOg+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBB030E821
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548522; cv=none; b=BEbvQ3+ida7AUftJqzzuLOLa+cN9Mrecu22HiltTMp58LVnp8N6SDYT1XTqwrXSayMk+NZSrPkZ6p9TXRp43Q2R+eRrSeFHVm/CvCGtCJSNHigjalqf51qLG2hVBBQ/x6Yl65M36QFRSvVoI9ePdOFc4tkChXigqkvQXkGPPZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548522; c=relaxed/simple;
	bh=BQbA1PfTf4T3catTnFJyQPDRyKoNlBdFRYRrfUNeAx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uA5X3/o8uI6N1HWi8OJYzwYrvT+nDlG0mlhPSM66v98f3H1p6r4USgqKsf2SBgOofSDUJqHqgpmXF3+SPUxsVas5cd6e3s+rBw49jP/pCuqCiYeQ+08MemHnalpmsRi3m/1DakHcdxYXrOmptwGgQAmaeoL6GemYpfhJfJy/zkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NwYvpOg+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M90U4I022397
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rJQkYNJ2ptgfx/Tld3lEk18PrZsK416NnAJeaB5RM4o=; b=NwYvpOg+xZS7eHP0
	xDNER6FmPa5tBlNEMzLiHHu1qY+74UFzQbYQXWlr0JRsVQTkUi0v33MPdgcYFwix
	rz/0WJ2t380Rag2TMTjVmrBUe7pYiy3n63iSjuAoAeEMO9Gdp+gW4Iq9USX8XUk5
	edOKM4JrJn8KVY1Y7ZwwBfGvg8OBlvQolFgGaSq/aknrz0Ouqup571qn+SY6OwfQ
	s0PbBgH/koWZSlemX+W6Dqbg+ojVDk0H+jzSrMBRRHnADxLN7RHhjBTMEPqCFP4A
	1srZ3nofm5yzwt8td9ZGMIqLIMd16VP6bJCBMJB5XgIiJydcm7BiYENtMWBo12qP
	agglDg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv0vwbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:42:00 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4f8e079bc1so3164726a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548519; x=1759153319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJQkYNJ2ptgfx/Tld3lEk18PrZsK416NnAJeaB5RM4o=;
        b=s28UT1I0X1GllcvEfQWrtkmCbS2oB5/tpDAcVg+78HBKnQt0MtHuZQFmgPg0Z4rn6I
         +HY6rHNFLEfoQXrZZSqWgENjZjlIpZJR0VgJRUFKpAQWpenY6ZCMACpcqgsXZlGo69gY
         JDTO1jWtyP2jYUSBEJGhBBKdNrlhhaY30q1+3lOkGlWriJcxDgeYzInZ7IyblEbII2df
         KD+1AzXczrAILiQ7s+OQsLuYtCeXZA1XEGCexTgwLRO45kk74l525D54MDa7s14j4E2r
         oLACnyBRZh9JRXfqk8ztachvlsod2EE3j/8Nr5h8JYDg7KXafpMMbwO/8WQZxTRByQet
         Wa0w==
X-Forwarded-Encrypted: i=1; AJvYcCUx8HzgGZwjG4Ykht6/gYNe68pPp2j6JRFljfOZXdM6l8eu2wE+jDzrQjp1uTM5sh/gDzh6sSFbTOcfGvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLc13NcXnrRL99jIipllPKEnOCBenddJLD4umL+rd6eMDcW0ex
	ABmCFyVWWfTbjThyCjmTJMU4OEHYwxWE3FVO2PSuh75tizj2JrW8oRB54HQnS+o9KMD063vn+Mm
	aw6K6P5yqq+9+QYIk7M50UML0aFvVIRcPnOi8CKfZBLpkMAQqTi8hK6KLX4kwpeXx4/c=
X-Gm-Gg: ASbGnctS2EgvALpAZaeR34iuozJsC3PHbuezW1vpkrQ/hB9YfoUZLPVN1VTvo9asBAy
	C1xRvUtII1Y5Gkb+7f5bjoanJLPB1lmMWL67p1od1tMdEq3RXdGiI/+1IZ2o8fl9zzUWnEdyTe5
	xMZNTonBc7zZLbH7Ts9wmslkY99d021CMA6WibQ8ZhIkIGDsd+TGyLR98e5nbiSFIhYEIy3qqXY
	DJoAmA0/2hfWqurW0FuUqBktRo4A8O/MnYDKrnpgWil/HvDGWfAYQBR4VxLOBeAAS9/LZV9gcgy
	ncMWnP1saY1Pz05lD/N8lIa3x+BrkkmTr6iKBWz9aO1VWL82otaf7kH9Y0qNjHDJAfSoF1h2MzH
	z
X-Received: by 2002:a17:902:e94e:b0:268:5892:6a2e with SMTP id d9443c01a7336-269ba59b78emr169070325ad.56.1758548518389;
        Mon, 22 Sep 2025 06:41:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7GSFmhWYvpYF0EOoGE36KcGoA9Rhnhe/ZjWh/d/dlfb6rO08M9tGC4TLjf/3UCGfieqRxAA==
X-Received: by 2002:a17:902:e94e:b0:268:5892:6a2e with SMTP id d9443c01a7336-269ba59b78emr169069835ad.56.1758548517815;
        Mon, 22 Sep 2025 06:41:57 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c13asm134246755ad.46.2025.09.22.06.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:41:57 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 19:10:19 +0530
Subject: [PATCH v15 09/14] arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-arm-psci-system_reset2-vendor-reboots-v15-9-7ce3a08878f1@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758548419; l=1185;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=fkRav5QA/W0o9Ycg3/xbut6S1Npfgr1jXzERBrOotDE=;
 b=nEF91WM16FRKVprlDcNfVQWq2bR49it9Jbo2EoH3aVuK0XkhCYHknxQNy4bTTsN+sz9xNq820
 k2On/w+tYoKBrQpRIp/RsOf/hNnMynZS+XFJDUOtM528sIVCEEvrJ9u
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: ryMSZwxmDPoxfY4yjrSzMu89tFtas3TN
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d15228 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=w06kbW2hXDg5FjFnD0gA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfXyqc4iKE6tgrz
 I7RhfUV93DH3UKEiqaI/uOBybdlgek8XRom53aGE65LdlF1UtkwJgUp/a/lMfet4Fde8l8QrjHN
 qmdmAdbrKwz6ffFvT8dw5im7XZVZdvZa/ruxT39Sf1ab5RzpIBWerC1wOoq0gm06TW+RaGdRtFA
 8k+XfKz/D8H5W/KzBRKmcs3pPhWn8GXWtJmcU9rSqfHbqllcJ8+aIyq/DUWd96KwfrWOp+aStB4
 yAretl0ROmEgx3G/7ygP/z9DcKHihQ232spXO8LCdzdCkILDpZmefC+I74W3u/PrQV4CAkx4hff
 LSusPdDo1t48GMrTuVnZV3HJDTpkqlj05ucr1Zsq7zpCPqHXMczXwB5sNBhwCUwQnOqCRZkiHtL
 XMdGpduI
X-Proofpoint-ORIG-GUID: ryMSZwxmDPoxfY4yjrSzMu89tFtas3TN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

Add support for SYSTEM_RESET2 vendor-specific resets in
qcs6490-rb3gen2 as reboot-modes.  Describe the resets:
"bootloader" will cause device to reboot and stop in the
bootloader's fastboot mode. "edl" will cause device to reboot
into "emergency download mode", which permits loading images via
the Firehose protocol.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 18cea8812001421456dc85547c3c711e2c42182a..f38fa2e52a635100a7505c615c0e96f1111d0b5a 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -975,6 +975,13 @@ &pon_resin {
 	status = "okay";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x10001 0x2>;
+		mode-edl = <0 0x1>;
+	};
+};
+
 &qup_uart7_cts {
 	/*
 	 * Configure a bias-bus-hold on CTS to lower power

-- 
2.34.1



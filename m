Return-Path: <linux-kernel+bounces-779287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54389B2F1A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E685E59B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC8A2EB5A2;
	Thu, 21 Aug 2025 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iNGM4qrm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579DB2EA73D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764477; cv=none; b=IWGRPboEmDO4XFXzk2NXjlJd/bCpgLuUgKNc0F66ymIWeNMd9R87H+9Nn2Zaj0UbAIfvixDgyUhdRA5M9WjmLsndgh4UTxug608RdX0zSrGNtTnyWP0iiXBkDzu0rBmY6BYf0mJkvE3Lan1HGCY/Dzu91P5hHPlRWV2YRKhJC4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764477; c=relaxed/simple;
	bh=ES0C/eHUJ0vZMSiE7e9k3eopudAsRoEFpDfAJn+GlGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NIDyhgjDGIIi0DghyAxGyqxG2uI+llgiYZcJ7/WxXe+7RQVhg4znCsAjdVJINnIoa5TMpYfVEdAaIPDeYeopTlbqygOssD3qTymv804YdRYWqNiM4p0Ynl0QIgDIdcbW9ApxFGPf0eXXLoDKLmUsCQ27JdIWgViTMtHIbXWB+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iNGM4qrm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L61hqR002352
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jWgEnfKM2T8SN4ZowpfF7xlxhdEVJCQ/+pQl9CKBY4Q=; b=iNGM4qrmsZwkB+zr
	f5CAp2WyI/Ta3V6F/HMKUIRdVMuNekopp0G94rFqhSK+cEUGtmlQui1pJ04+rNZN
	CgkdpIv4CjlAz64A1EooPwSsHrLmZBzuA6KDRpFg8KVYbwqnPV7dJ0ZZZgrNT2dN
	PIT51M+iHe2RpBlCLou6+obH8lVE7Fov0E1zJbyxgPNTSIp/EOSabCreqq3F6yyu
	40nNhhbfZWie/eI2Hyxef/TvHpUj9YVtL7/mf6OuVGVh2gEwYcKFB9PefvuV7f58
	quUF++3+agg9g9RuHoUgqV5zdIYmMtMOpfTjN9gG1OdHiD8yD0FgZDHV80axUhOW
	bDBGjA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52dmkxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:21:15 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e6e71f7c6so919247b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764474; x=1756369274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWgEnfKM2T8SN4ZowpfF7xlxhdEVJCQ/+pQl9CKBY4Q=;
        b=ctxQl7o4jXzJPxHUJ7Wc0Q7+HHnGzh35QqOxXnByeoyd/iWA8gxvBfd1wWlwZNDGGr
         3/L/OlFeyh4KSVL63P/gEkaVi84Oo2vJHA77wZ3MJ19ptXM8QvGai2wiinANyyQE+N8h
         oy8muq0MhX0CWMsi8brW1y+mvTKm6crWJJlKWTM3v2QUnI70iCGv5pTqYetUXZEPNLTf
         8fupyA8Kkm3d6P/PSdIV+zX17jdMHrgNuCyeVH7anwSIYMh3nkRht8gRaiX5XQh/AAeO
         VVPMNhOrgXtPG5iLcn9t1ls0LGaRisdWbPW6fNragxKPcru0LTnQ0YRJwAtJZ5vs7TCM
         oOXA==
X-Forwarded-Encrypted: i=1; AJvYcCXac0MtRrG2s2Z+a5cbnIMxHD+l/bP0BZzl3Tz+Pwv+GsZ4Ij6WWnQF+QUoahX9qa5J66jrwRZdHCsaa/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsfdZ4BFLbQJEh117pgvVJKTvUDuVdLJr++ESB7OTaJUp1X1FX
	uWlG1m8vIpsdf+93gATVMalKxTnEfz0y/a6vIgKXXcMwwPDWfhmrFWfv4lPiIGQTK4IzfbZ+TTr
	hti0+dpZMiXCCjoXg2T7+LRyZLIHdbnJZL9ZN18YiocLXTrJe5ubvdlu+KHxx7B8SIDQ=
X-Gm-Gg: ASbGncupz18q24GnoglJppfetNqK9OGHYfYBOF5tGT5oNz7aMP8ax2Tzcvlx5C2hsYW
	JBc+5Fuz4bqTuC2CnSnYbJ6vP496IwxojL9A/rjtvNTsjugO48mAXImQS5tQjUpPRtccjXkm5iY
	+9NhFsKpBZJTfg5jIO4HPkPU1gjEbo9oOoCBO7Mbbo9TgSEDa+92YuU2oBMv1o5SaG+Bst9KHMU
	BhC8KMVsz1D67u/hyqC+CnbQypfPbYHoIt8jtQlAYZBervzEQxb3y+yTvaf6ym7AA4y9nI5tyDJ
	B+SVyjnh+ef3wiRc2Ycwb5XMju3v13+AEls/voidemNRVoTCSywO503oRqZCBPb1CPs3jPc9xCU
	KWqkkJAYqMYUOBnOTVJ4Mo1OhQJE2fzgp8Q==
X-Received: by 2002:a05:6a00:1304:b0:76b:c882:e0a with SMTP id d2e1a72fcca58-76ea3158eadmr1981944b3a.5.1755764473919;
        Thu, 21 Aug 2025 01:21:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExQWvGUYVR7FpRA23GECMY/ZJWDx/O5PjHPa43nIM1xLoiZabU7zXN/xe8IPCGKxVvnekxXQ==
X-Received: by 2002:a05:6a00:1304:b0:76b:c882:e0a with SMTP id d2e1a72fcca58-76ea3158eadmr1981919b3a.5.1755764473476;
        Thu, 21 Aug 2025 01:21:13 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d52c7f2sm7468238b3a.87.2025.08.21.01.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:21:13 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 16:20:22 +0800
Subject: [PATCH v6 1/3] dt-bindings: arm: qcom: Document HAMOA-IOT-EVK
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-hamoa_initial-v6-1-72e4e01a55d0@oss.qualcomm.com>
References: <20250821-hamoa_initial-v6-0-72e4e01a55d0@oss.qualcomm.com>
In-Reply-To: <20250821-hamoa_initial-v6-0-72e4e01a55d0@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-5bbf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755764464; l=1177;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=ES0C/eHUJ0vZMSiE7e9k3eopudAsRoEFpDfAJn+GlGw=;
 b=rxPgNDKUD77jdVkhCq3vW6y8IP8u/z9/7nuPRT2Kr924Q5kpi+l5w6bzSStWB465X6Ri8p3DF
 185UGswVt4xBN4TmwwyjXwrNl92sVgUj01xWdj43hv0QWkKYcQRtZZh
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX+hi4olBRHHO8
 mcBBepjnGaaWvUIMQoeIeaAzWDKh+l1acnWj+M7aIDNP3w9+Kq76LWTOrlATecv/OUXspoqyzEn
 5spVhBIhairMTOhpzIWLZK41vsZ6XfK7A/NfRRXpDoxpyuoCnVENAJGYETZUn6zFQ+WF/iupoOk
 osTVLrlWQWyKKdesEwazrv24jH0ZVJDlbrmOhN/vnnJxfxDglps+rqX6fzxNdIRW5J5x+syQ3VD
 3JWQxq/3jx8q4V35nrtUVFBD9VxBtQGccvZRMNFLoBCUtGCy0fVB6XZ+TFPSUx6pWd4v3D+jqtb
 oBOWAcDFuGfaB90aqR1B9njX1gw/UnMeCO5ZY3D06svdS/GTcLtL7IfAPAZYEZm2cU4PhC2Lcsf
 12d5GpLHEU1hVp9SfH6sxj4h6qbW2w==
X-Proofpoint-ORIG-GUID: fj16gWzbWG3HKokBzRAjPF89ny5IFNyA
X-Proofpoint-GUID: fj16gWzbWG3HKokBzRAjPF89ny5IFNyA
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a6d6fb cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Bh1HEMNN3wmc11-eFpoA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Document the device tree binding for the HAMOA-IOT-EVK board, which uses
the Qualcomm X1E80100 SoC.

The EVK consists of a carrier board and a modular System-on-Module (SoM).
The SoM integrates the SoC, PMICs, and essential GPIOs, while the EVK
carrier board provides additional peripherals such as UART and USB
interfaces.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 55e5eb75af89..6b6503181ad6 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1069,6 +1069,12 @@ properties:
               - qcom,x1e80100-qcp
           - const: qcom,x1e80100
 
+      - items:
+          - enum:
+              - qcom,hamoa-iot-evk
+          - const: qcom,hamoa-iot-som
+          - const: qcom,x1e80100
+
       - items:
           - enum:
               - asus,zenbook-a14-ux3407qa

-- 
2.34.1



Return-Path: <linux-kernel+bounces-886428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CEEC358F3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22F884E40E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BCB30DEB1;
	Wed,  5 Nov 2025 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VeZNMbj7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tep2Ahbx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399C98BEC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762344453; cv=none; b=f91NDAXLrl59qEg351eCQB30VcANzzaxhSFGgFIqq/TcwTc19zgnCnA9UFf7/m6vJL1YBwyEj2tuaVzcZ0qynM4LtTXA7hHJzMqkqtdWkO1hZMcivDHiEATjgKWJbUQex8BdTQ9iYJp05Ja7RiFnpOq4UFJjCNJp4brkV3vnFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762344453; c=relaxed/simple;
	bh=RTxAiWbCYnmuSlubEQApk4uXdRkkwOzQvA4tE1Dn98c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UeEAfbQnRZI74v0x6cfHo89XZruuEzhT5hSTFL2P+iH1oI9H2vSHsEjnVVZNvD/DcRBWyoY2+9LBl9mVLjPbQW75CGsKCIfPpbxCeoiaUc+ahhGGdU9wjowSSZb9zh2cI6sgnUfps4vil0T58lSxFCimhila10YwQl+99S53jto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VeZNMbj7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tep2Ahbx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A57uPAs159399
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 12:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HbPQWgEoA7Jyobb97U2v8f
	8cNOeEfglRmJGY4yPlDt8=; b=VeZNMbj7TisLPxa4EZ8ZCtT0mT0az1bTwn5YkQ
	92u75t2N+M/3yZPN+2iAZnR6eusD3KTU7TuS4v3PyRQ9EXG7ZPLNAAYoBYKcbx/f
	/GbL7E2za+XbaTtYzMh97uTTdbji/jYyytikSOAvAHH7sakrO+nZ/6tpWOqOVYtR
	Wraqd7TiOFnx496rso5ZPmDr6eHxhBZueQ+13nI6TJt3G5mJkn7RWb8yYh6j7L3v
	ozZwWdeY10eJOcJ3ky42PZG3GPQc/+JHHcYWe/A03HJJufPrNim+sW5UgVheFikO
	QwLTdJIWTcneLIYitYJwaf5I+ZLIzNPw0721X8eqVG54bhAQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a82mt0pbc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:07:31 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7aa148105a2so3238360b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 04:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762344451; x=1762949251; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HbPQWgEoA7Jyobb97U2v8f8cNOeEfglRmJGY4yPlDt8=;
        b=Tep2Ahbx4sFxDoVNmFSYdgm6T6R401Vf7DDel64YL74s4d4jI69GjuMaIHOydbr5MV
         ++OyLrHAxuB2kn3dlcUxwzu1KmTrts1kl1y8rL0/+p4eY+yu4Tp7c9YQZMPqGWLtfr7S
         La/bWp44EluY/mJZD/eHR7hpfJmBegwI+HQunbyVqhBvHz6NA2vDvJb8ZW7REMXnrweZ
         e2tjNYxrQHpO+QcUxtUO43gLj8W+sBJbRa2gRf59TmjPTDPtDfkRJ/Xb56JN9KwSnj1w
         tL1AQFs7AL7NGKF4W38qXNNTGuVuG2T8v0Q9+N3USbgoTbuGrE+r9l/AflfP2tKIXMlj
         OVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762344451; x=1762949251;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbPQWgEoA7Jyobb97U2v8f8cNOeEfglRmJGY4yPlDt8=;
        b=nDb1WQvBDLT7VImvBCxcC+CWfIcsS8ej6pZKWdJFCBoDvowoJRCGJxHil4npNLYEM2
         63gICFv9xIZyVOhIkKaCn/KV1LWCd6BIyU6s4a6uGPz1qzv98q5tK0fjCytDnbSHgXUb
         7wl1oAXSGHUpOnTzw55/y0apC5sd2EClkIsXEcgV/IMBxi779KDSZzk3cgL0NilEvZFY
         Z+zNKwooII8nAgc9SbBIF+frtRliDQnkDFqBnirTPDgYqO+wDCpLM4RvCUHadrX7Z4K5
         y1eXpijZNn+yGlBX8Z8Xum8qr87LIWJebg7v3U6wTVnafTtnYvokraH5g6aUMjWPBovl
         Gbag==
X-Gm-Message-State: AOJu0YyovWVfYNbl8h3r+Ek63sBQ/33H9wzLXz/oAJJjhsHJBJVNHuRs
	22zIF0tlUhh0He+8jTpz9bM5i+w3Zjx0qw2jLSSuRipF6bx97V3KhjGnARkSsbIqg0LoCOOACg2
	X6VDn2CQ/4uQz8rkeR4Ahz3x7b0Y/EPdywCE8DQRGuEDJn9cXoGRrENrgZfr8P3YoPlI=
X-Gm-Gg: ASbGnctya11pxUHsWBfORPfybvncKUgKivmOXjKSNGuvbh6+n55EEtqu+iRDNsM0OvS
	Rw39Z2jr4soknl6S9N9RbFo4/vkn0Y0odpdnRd9GM1r2bJcIMueRHaffQv1XwrEZ4Ecju39eZbF
	czNEWZMcURecndB/lZdTQ7TQXDdLuSuBp2PgME4BtU8TFdrHStjS9elHEzzNhjZOdxBhAu4vmZf
	A1Z4XQq8fY3zogVAK6tRtVBXyJFYzlpJ9nfv9qYLSlrpf5XFgFUwI73ZZvK5avhuutygDZ+6Os7
	aWqTtyOSzErneJClTNOD2Q1pwwBIzPEP1F3jKO8Do3LEGEgTrAnWXshKyUnRoevMsGEygLCn7pl
	3fSEWJlI0YrZE7Xah8vrQY7nk00pZ0zBIhR51V09O2ud5GR+RXCnvwI+PPgfxLrNGuYxw4+5ig9
	E2GBE3th5NtQDu+WM=
X-Received: by 2002:a05:6a00:94d3:b0:7a3:455e:3fa5 with SMTP id d2e1a72fcca58-7ae1a1c9b6emr3985983b3a.0.1762344450776;
        Wed, 05 Nov 2025 04:07:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMQdr5x/9iI3vYuG4ZuMO+2YZfH0pT2forauVm0krErs9MLeNMB2uTuaN9s9CvxLIbWw5OtQ==
X-Received: by 2002:a05:6a00:94d3:b0:7a3:455e:3fa5 with SMTP id d2e1a72fcca58-7ae1a1c9b6emr3985946b3a.0.1762344450231;
        Wed, 05 Nov 2025 04:07:30 -0800 (PST)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd623c55csm6004624b3a.52.2025.11.05.04.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 04:07:29 -0800 (PST)
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 20:06:14 +0800
Subject: [PATCH v3] arm64: defconfig: Enable SX150x GPIO expander driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-enable-sx150x-gpio-expander-v3-1-2ec8dfde2c9e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALY9C2kC/4XNsQ6CMBDG8VcxnT1zPYKAk+9hHEq5ShOg2AqpG
 t7dyuSgcbnkf8Pve4rA3nIQh81TeJ5tsG5IkW03QrdquDDYJrUgpFxKzIEHVXcMIcocI1xG64D
 jqIaGPRhd1ZXOpSkoE0kYPRsbV/10Tt3acHP+vo7N8v1dXSxlCb1rpk55+/hhzxIQNCmkghANN
 0cXwu46qU67vt+lI94TM32whP9ZAgm851oRGVRovrDLsrwAeIL61CgBAAA=
X-Change-ID: 20251105-enable-sx150x-gpio-expander-fc9b9c51f723
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        xiangxu.yin@oss.qualcomm.com,
        Fange Zhang <fange.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762344447; l=1680;
 i=fange.zhang@oss.qualcomm.com; s=20250714; h=from:subject:message-id;
 bh=RTxAiWbCYnmuSlubEQApk4uXdRkkwOzQvA4tE1Dn98c=;
 b=cxiXE6aeYEExQLJRyDIIjw0EEeCcBklbcR47OxJoF5oNhq+h8wmgZTYDSpmSjTFI+9T4QMQxU
 VeTdvXs0ZLfDu0Ehqr9CRX/IxWDyLSQ3fLdP85aYhSqYvMb/BOCe0R9
X-Developer-Key: i=fange.zhang@oss.qualcomm.com; a=ed25519;
 pk=tn190A7bjF3/EyH7AYy/eNzPoS9lwXGznYamlMv6TE0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA5MSBTYWx0ZWRfX8mNRmjcWwKhJ
 xZ5ruoBKOmUOn5uFrRaVH452VEdnnNblGQRbH1aW/exHAastNhzoOFWmTMaDWna0RzUcYBU9hJb
 eDsRrHtxhM71KQebSCUHrQqdHDyMBgx6MgelUtcfTN8RfmfPeaXuRkBw+pJgl7yFxwP1/LUPfjE
 /bHJziYz3dK6WdhfD9/WJL0OnBCSMFJG+ESRUUfsRTgHsTZeoXZ8nY74dnp91p3bN6v7QnrR9u8
 9MuZ2/kU35Cj08x4cbUGs6PYL9kak+5jciwXl8jy99AZEJ2rSJC4qUJmlXPtTFd/7ZYpUBOrAWd
 OTdxnxPDu0Wk2lANv6VjxvPEUmJafDhj3G2K03te7/XCN80GVq2usU0e+lpSLNAiBemhMLzdeu/
 FtEdjODecsD7TCNwvSqXJxx31we3vQ==
X-Proofpoint-GUID: _5U3akLaggE65Myoc7qk2-0phfc-FMI6
X-Authority-Analysis: v=2.4 cv=LLtrgZW9 c=1 sm=1 tr=0 ts=690b3e03 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=i1AFPchbKC_G9XLO_8YA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: _5U3akLaggE65Myoc7qk2-0phfc-FMI6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050091

The ANX7625 bridge on the Qualcomm QCS615 Ride reference board is connected
to a Semtech SX150x GPIO expander. Enable the SX150x driver to make the
display on boards built following this design functional.

Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
---
The SX150X GPIO expander is used on the Qualcomm QCS615 Ride to support the ANX7625 bridge.
Enable the driver as a kernel module

Please note that this driver has been updated from bool to tristate:
https://lore.kernel.org/all/20250818-modularize-sx150x-gpio-expander-v1-1-c2a027200fed@oss.qualcomm.com/
---
Changes in v3:
- Update commit message only 
- Link to v2: https://lore.kernel.org/all/20250820-modularize-sx150x-gpio-expander-v2-1-e6eba22f0a0f@oss.qualcomm.com

Changes in v2:
- Drop patch 1/2, which have already been merged upstream
- Link to v1: https://lore.kernel.org/r/20250818-modularize-sx150x-gpio-expander-v1-0-c2a027200fed@oss.qualcomm.com
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 30001ddf57e7f5cc0aff880527dd683627bae255..337a8f6a9343566ff818c18fd54eb2aeda0873c8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -618,6 +618,7 @@ CONFIG_PINCTRL_DA9062=m
 CONFIG_PINCTRL_MAX77620=y
 CONFIG_PINCTRL_RK805=m
 CONFIG_PINCTRL_SINGLE=y
+CONFIG_PINCTRL_SX150X=m
 CONFIG_PINCTRL_OWL=y
 CONFIG_PINCTRL_S700=y
 CONFIG_PINCTRL_S900=y

---
base-commit: 17490bd0527f59d841168457b245581f314b5fa0
change-id: 20251105-enable-sx150x-gpio-expander-fc9b9c51f723

Best regards,
-- 
Fange Zhang <fange.zhang@oss.qualcomm.com>



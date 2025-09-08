Return-Path: <linux-kernel+bounces-806387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E54B495E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8AE1883F0A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A880D310779;
	Mon,  8 Sep 2025 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cF9r0N20"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6538A2E2DCD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349944; cv=none; b=jXx8a+tEtU1YUG4fhGNZYkScPVpp/iq47AI2j9KrWzj7Wq3Vdng8mcpaP6f0yGL1Q/mGmQz4brTyfqyHem967mxH5mBz0GymZBdcgWcNdC4fdb85sjnA6Dlknta7sYkP8u8il7CEeOQ8ZIXfXLLMSDEDNiZ3MWMMY+g36j7+6aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349944; c=relaxed/simple;
	bh=6PqMLWKDJtKfVT+GHF4Y1k5/ea+AFwqdR62kduV2yF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V1j7sriuc4a7QzSazY6WY0MsstKbgvDruss7bluMn2WsesyDFXaFkGcO2OSNbXSGRtfHgcWUzduqK9nOfx4EopqjlVjMa0udarNwDI2uqWNBj3M0hDvXUhEIuDyyvQdl6NQIwqu4bMPv/vM8gW1+ISyYfpS72HFHL42F9Vk6olI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cF9r0N20; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588FtICS023525
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 16:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=34Aw1JEvLQX8Jf7s5ppgnDzivC2hh4Fc7ZC
	M6ufDdzA=; b=cF9r0N20D8+R7qV0LuaJPtmTWTyirlUMuLt4CWP0DDtbTECV4Ni
	6a8S4DqTNuh2niaw4gb7riMZlFcZdMy0HRj5iJakGDXT+fucFYKswdgyBgpRX6fC
	m+/WX/N4clA10mffWpvAoPdzN7fHCDILpp1U0jk9Uu0cApIc50B2tHkjGMfG8jAj
	HLNytukr8EM3VcjqDNkE+kYMIs1AVXJSnIKmaFxO021wnx0X5XYEYfCV5V59nNlV
	ByE/75TvK8Hj3mRR8qOmdhBIUco5AbiueOOsjmOp3rCpt2Epmf96i7z9LkTYNHwL
	ca+zz+VdADBY3tabIxfjIBHYPSH0cHShaEA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8dbbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:45:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24ce3e62946so66502205ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757349941; x=1757954741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34Aw1JEvLQX8Jf7s5ppgnDzivC2hh4Fc7ZCM6ufDdzA=;
        b=WoBct9Wz5iI0ygRtZa314attdJ3oZuPjZQHLDeIfiGF6t15EXvSa5FOQfvbW3gumTm
         EU+vBKi0wCjcCmM7ke8uZuwKodTgnqKVrDQ8aFWRFBE26HCnFeuwBDJj1/bpwhOlYQI6
         HuZjiqbq4E4mJP4PdxSU1Q3TVTPCL6mnaYszyHGTmss8X3CgHLnU38grcWnlqRx5CII+
         UyxJzxiO+7gmgKKeTKw0tg3K/TD1mFDEA1mXyz1z2qZgQGxscdWDaqFK7zcvZHNs4BOO
         WI6rKC5aRipgGt75lXBYtZUyci3n5Y8PuYSUZPl0LU9/I+3dwlVHFfBLLYdk5q09BwMF
         3T/g==
X-Forwarded-Encrypted: i=1; AJvYcCW7WIWgLhXnfZyGL7q/B0LH2EYLrHwVzkx6EfYHVKE4JKC0BjgDrseoEm99uq6TvuF7sj5ryGESxuP5b+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9mQhk2RzVJuQ1WIdAeQR9Y6qih9cUGKdau+Y206XFu/R8lpGj
	567fRh7G+nH8DX7HPZBhom09TDsafbr3QxNGl88ORNl+1tFfd7EEYaCh2Xfxp/H/JO2Bf4z1HRc
	Q0bUIFsTYWO7G0mZUTPp+r9eNfG7BFg14hjNlDqtbkpl2/nvr0kT2GJBH6+Vv/ylITEo=
X-Gm-Gg: ASbGncvDZpjxMfDuLDygpPFKERjYwTYf7MlKwAgc3u9a1O9bugUDlSaPw/rz8T4CY+p
	tV+KQ19eS5EojyfO8jKfZiWy0AK8aMCTVS2/GyiLG4AASRd3X75zrwu+QJdw0YM1uIIBq7PJGlk
	l3ua7LptkXjmB42Si5gtWP1pJZtRPZp9jR0m0D9hP970jWW+2nJg9kt1ned8aPuTlNTmOceS42R
	JYui37ZhofVSYMYvH8rnaUio90egzDqDnm0zFz4KgZv+FcwiKaVEqKubGFQOqoHJK1qsAw7JjE9
	TxbHdR5uW1gBbs+CZztQUGmzlZmwo1JkFF9dsrokyabathMX1RZ+Yf0NXe5nobU6yI05UzhBxA=
	=
X-Received: by 2002:a17:902:db03:b0:248:fbec:7ca0 with SMTP id d9443c01a7336-251753ddc6bmr114524845ad.52.1757349940875;
        Mon, 08 Sep 2025 09:45:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4KvQs9Tv5MscTkp53nskEqyMUOykepAr5xV7PIPByLyoDaC48YY8vt2347cxTMkjP8lyWfQ==
X-Received: by 2002:a17:902:db03:b0:248:fbec:7ca0 with SMTP id d9443c01a7336-251753ddc6bmr114524405ad.52.1757349940303;
        Mon, 08 Sep 2025 09:45:40 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24df9e881casm91508045ad.62.2025.09.08.09.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 09:45:39 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Praveen Talari <quic_ptalari@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, alexey.klimov@linaro.org
Cc: psodagud@quicinc.com, djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_mnaresh@quicinc.com, quic_shazhuss@quicinc.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v1] serial: qcom-geni: Fix pinctrl deadlock on runtime resume
Date: Mon,  8 Sep 2025 22:15:32 +0530
Message-Id: <20250908164532.2365969-1-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX5H6gbFBh9D0S
 jmz6vzg89rhUwYU5cjQAwwIfhNW7asJszz+M7RIt6fytRY2+YAXqSAN9dRbt/f8jA1dU3Kzv5N6
 d4zzhQCIffxYu2Gz1Ky7qRY3NKHggkGOFJ2atiuHQ5Oxx97kBzDnkyrxPhoMFSguvJAK3LcLuoL
 JVuqPOp3mc5Jcr8cB8XhY56uQzRAzq9aOAPG2CKeFpcJGLh0/l8mm8Bw4tZSRgKjWYVzhQ/SAyd
 dgAnTtj8xqwSWQ+SFPrGuUqOMbaLPN8v3GHDzxDPET02tcWfSFdjnHcWZlkrcN8MRTYyd6zy6AD
 3gW1kZ/bq0xvsOSqyUts92Fa7oUJWvke4u3uet4pk+UfWSCj1dyfWFumo54DitSmfo4PfRqoS4H
 ylruz6Mm
X-Proofpoint-ORIG-GUID: HbhEdzYTfMzXbxLugHJCTLyjlHqDoFH-
X-Proofpoint-GUID: HbhEdzYTfMzXbxLugHJCTLyjlHqDoFH-
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68bf0836 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=wCWT4eE_qC1rGXKMDvQA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

A deadlock is observed in the qcom_geni_serial driver during runtime
resume. This occurs when the pinctrl subsystem reconfigures device pins
via msm_pinmux_set_mux() while the serial device's interrupt is an
active wakeup source. msm_pinmux_set_mux() calls disable_irq() or
__synchronize_irq(), conflicting with the active wakeup state and
causing the IRQ thread to enter an uninterruptible (D-state) sleep,
leading to system instability.

The critical call trace leading to the deadlock is:

    Call trace:
    __switch_to+0xe0/0x120
    __schedule+0x39c/0x978
    schedule+0x5c/0xf8
    __synchronize_irq+0x88/0xb4
    disable_irq+0x3c/0x4c
    msm_pinmux_set_mux+0x508/0x644
    pinmux_enable_setting+0x190/0x2dc
    pinctrl_commit_state+0x13c/0x208
    pinctrl_pm_select_default_state+0x4c/0xa4
    geni_se_resources_on+0xe8/0x154
    qcom_geni_serial_runtime_resume+0x4c/0x88
    pm_generic_runtime_resume+0x2c/0x44
    __genpd_runtime_resume+0x30/0x80
    genpd_runtime_resume+0x114/0x29c
    __rpm_callback+0x48/0x1d8
    rpm_callback+0x6c/0x78
    rpm_resume+0x530/0x750
    __pm_runtime_resume+0x50/0x94
    handle_threaded_wake_irq+0x30/0x94
    irq_thread_fn+0x2c/xa8
    irq_thread+0x160/x248
    kthread+0x110/x114
    ret_from_fork+0x10/x20

To resolve this, explicitly manage the wakeup IRQ state within the
runtime suspend/resume callbacks. In the runtime resume callback, call
disable_irq_wake() before enabling resources. This preemptively
removes the "wakeup" capability from the IRQ, allowing subsequent
interrupt management calls to proceed without conflict. An error path
re-enables the wakeup IRQ if resource enablement fails.

Conversely, in runtime suspend, call enable_irq_wake() after resources
are disabled. This ensures the interrupt is configured as a wakeup
source only once the device has fully entered its low-power state. An
error path handles disabling the wakeup IRQ if the suspend operation
fails.

Fixes: 1afa70632c39 ("serial: qcom-geni: Enable PM runtime for serial driver")
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 0fdda3a1e70b..4f5ea28dfe8f 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1926,8 +1926,17 @@ static int __maybe_unused qcom_geni_serial_runtime_suspend(struct device *dev)
 	struct uart_port *uport = &port->uport;
 	int ret = 0;
 
-	if (port->dev_data->power_state)
+	if (port->dev_data->power_state) {
 		ret = port->dev_data->power_state(uport, false);
+		if (ret) {
+			if (device_can_wakeup(dev))
+				disable_irq_wake(port->wakeup_irq);
+			return ret;
+		}
+	}
+
+	if (device_can_wakeup(dev))
+		enable_irq_wake(port->wakeup_irq);
 
 	return ret;
 }
@@ -1938,8 +1947,17 @@ static int __maybe_unused qcom_geni_serial_runtime_resume(struct device *dev)
 	struct uart_port *uport = &port->uport;
 	int ret = 0;
 
-	if (port->dev_data->power_state)
+	if (device_can_wakeup(dev))
+		disable_irq_wake(port->wakeup_irq);
+
+	if (port->dev_data->power_state) {
 		ret = port->dev_data->power_state(uport, true);
+		if (ret) {
+			if (device_can_wakeup(dev))
+				enable_irq_wake(port->wakeup_irq);
+			return ret;
+		}
+	}
 
 	return ret;
 }

base-commit: 3e8e5822146bc396d2a7e5fbb7be13271665522a
-- 
2.34.1



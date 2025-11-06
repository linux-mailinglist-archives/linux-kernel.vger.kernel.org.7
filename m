Return-Path: <linux-kernel+bounces-888277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F72C3A602
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD4E94E4D27
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEC22E8B98;
	Thu,  6 Nov 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="POjsuEUr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F2ewHI/K"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA132DF3E7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426204; cv=none; b=q0LnpWSIixZkrCL6kqlJxceeTxaHEgOh5S/dHqFN3aIW5DiYjRZOXJO98Wv7HinIdnVh7A8UVrPflwq6PYHuc8ZhFFf+4KIVLrolYylhMwKo64GEScslanf02l0fZIZ3zMH89x0zhHOghSRcDAyZaQ/qw/iER/2B2iC6x9Ybd14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426204; c=relaxed/simple;
	bh=zBCKExl8HjB48xNUrTGGNh6timupCDTQI00rzd31IVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hz/8VuaIOsRHyaVAB8IKfrSYIuI2vbEJoeCcbuEm5TSL1OMKNAEIPLmbV2WRFmra2JzBHVIqPW+JDvc2KhkZ/CM7i/ejTJ6A8qrDEnGkfGRu1UbrqJ6p7ucMm882TCc9h7BYkZYjtMK01DRIib2mkzuyNp196thJhcW+/a3jYOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=POjsuEUr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F2ewHI/K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A68jlpc3383559
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 10:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eYIclMc1S8tQ3EHXNewhAU
	NCGGawrS1pWeLI+oTbF4o=; b=POjsuEUr1+AkwxREVeNEvoC4wHtovyLcLXbUgw
	Rk/HY3m7X3DI7MSvVQ+O+GsMGTdMcMaZ5YEQLTqtpQs2RtYB0mgNrJoBtpxbJKNS
	HJ9iaO0OF6xuoa++lB7fY/F6ZknI/3LQUAaPYk2IZ3zp5SfZlR4+gflE/YoAlOuE
	ECvKJNJF9N56xwcpfZ2VKDiApt4ZbgPZE6+Asauo3w/pgGLYH48f1V9ARC4NblEb
	qm+DEOgak9YpLLoHhaQUYRKtGuTgSScl5kZin8oyyHUWWj7+GwK64uxUpNfqEG+4
	AZo818aQPfPV7LAfOQhdiTNJ1gX7dg+sCP8FIOovrXWCm1rA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8reurb6r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:50:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-272b7bdf41fso5758025ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 02:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762426200; x=1763031000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eYIclMc1S8tQ3EHXNewhAUNCGGawrS1pWeLI+oTbF4o=;
        b=F2ewHI/KWHsTBUfqB1LV7osAbvLrBT/px2fMcA5vFp/+X/jfyVJxIvWaVu30xsi4wo
         Pi9AkL6dGdh5TuNBL6L971SIJ7Fs4rxkYEHyMY6mcIIHzrhnIPbBMYeJqK/WCJCU7Psv
         1fHDljfxcD+m6LlFBdvnJui627gVbkC/+X1TASHbB/665kc32uPmtCg1Z4NWNi4OwKyO
         d4WhneJ3eUWLpHzY9SITs3Bcd/QhRUGpeDkwhi20mfoCM1ghSrEwSGmmUuH9qpx5p5Or
         A8GgSnxQGfp4wNAZUa5n9mE+ayV/auzamWb/LS3sd+8p9wuoK2daV7xUG7MrnTlg17zt
         j+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762426200; x=1763031000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYIclMc1S8tQ3EHXNewhAUNCGGawrS1pWeLI+oTbF4o=;
        b=k4wTCCo2PzT4Z8nBMTooV4ksEP56I8eyMelGsqtX/+s3/KN0z/2C1cwOPhSKrequ1Q
         TMsNqaxP8H+Rv4Imd32F21B93E83oj1vwtbfZfAV4PLYVdWiuE9yOIznVXAA5CszQyZS
         zfNSR9OSIhWjsd7UOGT9A8Tk9Bv3QcMvaDq0AASKyZuVLlrCnxqw19wGDHacoudyvfKO
         blFPVTX8y8ljIjAEVzHn4vvHOiLg2MPYTu6Y0/liyGuvDS2sPh9u4bboTuOnQBQsDu4h
         JArQi/F6u9TVHIpbiPBGenciZUg7F64aJx0Ln60c4Xl1oZ8+zQpoDxjq0GUl8Gd33jiE
         3xng==
X-Forwarded-Encrypted: i=1; AJvYcCVlnn9FBK45QPywk7bgsmUobkZdTQ42mqZq54AH9u/ssNCvN/WV/AtD+UL8iUlTPPC+M7DoOG2xaU+7q+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGQxXvnmj36W+zTFaDT8J0oYaCf3gunBZ31TgEYz6ESKijuDOh
	v8Sz4q+UJHgEYX0+6kqIRfdIJ1xy5WfkvsODvdc3GV+VI12bTc7OjZMtKTor5xY+DpMRf/lSYmD
	Y3ymhE6dRWIza8uASex/dBDU91k+ssXZwVpIpJHr7ccZXnqKQaKESuJu7Mns6/bjDrVA=
X-Gm-Gg: ASbGncutzXix16VyLkZTaZ0ZH24PD4KbQ+PxvuE34eIDEfXiu3QEHVb41LsFSuUq+fU
	pkWyqCStwjYORD+EO9djkY5hhqyZy/fVnujdTRArDX1qgH4Cnt8DhK2OWdNRWjcpPXPLdhSuQT3
	TVi3Yp8R8aFIgp+3r3hSLIxcqOvh/EV6uOKZQbmzlJAJ/fb6NVr1Ggsi3rIzHipQ0qDOb3Zq+SD
	xVWZY2hF1ZHWBD2zPd7tjZ5a2ke0VLJQgOniz/9XUp7oRNR9dYMkRz0CoEu4L7VhE4AN3GfavTR
	azRkyFxoi7Hi51xpTBiwGbyGq6tIB/d0sWfIDOFeg0ndgMbpxoCiKiJutxl3yUiG2bk1cWRe/sC
	0IQC5FAEh65KtvLwfpaedVJObq5hlUA==
X-Received: by 2002:a17:903:2986:b0:295:3d5d:fe3b with SMTP id d9443c01a7336-2962ad95d44mr92650675ad.28.1762426199934;
        Thu, 06 Nov 2025 02:49:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKbtc7O+Ae/vhgwno4UxymyqOjep2QdMp+I6x5qOroY50xVCKvQHkpgkjOhA37e0xwIzT3bQ==
X-Received: by 2002:a17:903:2986:b0:295:3d5d:fe3b with SMTP id d9443c01a7336-2962ad95d44mr92650365ad.28.1762426199366;
        Thu, 06 Nov 2025 02:49:59 -0800 (PST)
Received: from hu-kshaikkh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccf0e7sm24274215ad.101.2025.11.06.02.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 02:49:58 -0800 (PST)
From: Khaja Hussain Shaik Khaji <khaja.khaji@oss.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: kprobes@vger.kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        catalin.marinas@arm.com, masami.hiramatsu@linaro.org,
        khaja.khaji@oss.qualcomm.com
Subject: [PATCH] arm64: insn: Route BTI to simulate_nop to avoid XOL/SS at function entry
Date: Thu,  6 Nov 2025 16:19:55 +0530
Message-Id: <20251106104955.2089268-1-khaja.khaji@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA4NCBTYWx0ZWRfX3qdhCdBsds4o
 pv4W25kW6rYt/l/9Ozd7OvUdRnKi+opMcM0xgmJCq5+H53jeOmrs6R5BlrgKGAGAhpn6534jwHp
 a/BAIFXLvfcadFrCn1NdAlxeDpyz5Fs4pjudRqnBYVQ7+3mWQqQjoYmmwMC2iwIY9IU6p48WBTu
 UWcS0jZthP8IUKE5F5uUgsLBGUXEWwIsGwncM0/xgsiAMBYaxbkc/2CtlBT+9m62PEIPG9tPffX
 Fxh43PKifosgn8UyV0ucoJ86b+odrOVn3AL6eZCsB98Im3v12m5xm6uSJS7hHrpwdEhjFFjHefQ
 +GDIne++WKTtVmQzYKhSDdMErKmaM8s6lMt6gwZw7vF3ukUwJ5SUrZN8h0y37ivuihmL8LVAdoF
 K+Hsv/qUAUsTB/+rNylDHb2tlOXQAg==
X-Proofpoint-ORIG-GUID: QXKexGqWd8DZzENrK-NQBOqC6wPmSQ0a
X-Authority-Analysis: v=2.4 cv=RrDI7SmK c=1 sm=1 tr=0 ts=690c7d58 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=XwLyKEN_6mDbY-G0MD0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: QXKexGqWd8DZzENrK-NQBOqC6wPmSQ0a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060084

On arm64 with branch protection, functions typically begin with a BTI
(Branch Target Identification) landing pad. Today the decoder treats BTI
as requiring out-of-line single-step (XOL), allocating a slot and placing
an SS-BRK. Under SMP this leaves a small window before DAIF is masked
where an asynchronous exception or nested probe can interleave and clear
current_kprobe, resulting in an SS-BRK panic.

Handle BTI like NOP in the decoder and simulate it (advance PC by one
instruction). This avoids XOL/SS-BRK at these sites and removes the
single-step window, while preserving correctness for kprobes since BTI’s
branch-target enforcement has no program-visible effect in this EL1
exception context.

In practice BTI is most commonly observed at function entry, so the main
effect of this change is to eliminate entry-site single-stepping. Other
instructions and non-entry sites are unaffected.

Signed-off-by: Khaja Hussain Shaik Khaji <khaja.khaji@oss.qualcomm.com>
---
 arch/arm64/include/asm/insn.h            | 5 -----
 arch/arm64/kernel/probes/decode-insn.c   | 9 ++++++---
 arch/arm64/kernel/probes/simulate-insn.c | 1 +
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 18c7811774d3..7e80cc1f0c3d 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -452,11 +452,6 @@ static __always_inline bool aarch64_insn_is_steppable_hint(u32 insn)
 	case AARCH64_INSN_HINT_PACIASP:
 	case AARCH64_INSN_HINT_PACIBZ:
 	case AARCH64_INSN_HINT_PACIBSP:
-	case AARCH64_INSN_HINT_BTI:
-	case AARCH64_INSN_HINT_BTIC:
-	case AARCH64_INSN_HINT_BTIJ:
-	case AARCH64_INSN_HINT_BTIJC:
-	case AARCH64_INSN_HINT_NOP:
 		return true;
 	default:
 		return false;
diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
index 6438bf62e753..7ce2cf5e21d3 100644
--- a/arch/arm64/kernel/probes/decode-insn.c
+++ b/arch/arm64/kernel/probes/decode-insn.c
@@ -79,10 +79,13 @@ enum probe_insn __kprobes
 arm_probe_decode_insn(u32 insn, struct arch_probe_insn *api)
 {
 	/*
-	 * While 'nop' instruction can execute in the out-of-line slot,
-	 * simulating them in breakpoint handling offers better performance.
+	 * NOP and BTI (Branch Target Identification) have no program‑visible side
+	 * effects for kprobes purposes. Simulate them to avoid XOL/SS‑BRK and the
+	 * small single‑step window. BTI’s branch‑target enforcement semantics are
+	 * irrelevant in this EL1 kprobe context, so advancing PC by one insn is
+	 * sufficient here.
 	 */
-	if (aarch64_insn_is_nop(insn)) {
+	if (aarch64_insn_is_nop(insn) || aarch64_insn_is_bti(insn)) {
 		api->handler = simulate_nop;
 		return INSN_GOOD_NO_SLOT;
 	}
diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
index 4c6d2d712fbd..b83312cb70ba 100644
--- a/arch/arm64/kernel/probes/simulate-insn.c
+++ b/arch/arm64/kernel/probes/simulate-insn.c
@@ -200,5 +200,6 @@ simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs)
 void __kprobes
 simulate_nop(u32 opcode, long addr, struct pt_regs *regs)
 {
+	/* Also used as BTI simulator: both just advance PC by one insn. */
 	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
 }
-- 
2.34.1



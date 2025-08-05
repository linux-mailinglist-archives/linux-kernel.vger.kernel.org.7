Return-Path: <linux-kernel+bounces-756420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9B0B1B3C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6CC18258F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1982527145D;
	Tue,  5 Aug 2025 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Ms9gZ2p3"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC0196C7C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398175; cv=none; b=EKFjWcKuZ+siRi3/T/Tzra34n69G26gGhTMF+hLHOwu+EaC3xGN/rzsTB5iKNMHXmzAHc+C6N1HFfvivmRCkCC9g3aokpnuWd3JR03f3O9y2nZJRfVAL1fJFb7BymJJyWYL2QtaMJheKz+/XEgjpKiMfW9vW3Ge0YTGfUv2BvTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398175; c=relaxed/simple;
	bh=HwUcJy+F9vM/CfVCFCzbXiHzo2VCqIsoAw6sTaZL2l4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VHt9mg0cmfSlkqYrqpFWBA0YV3XAi1euUa9s41p0EipSU391ZjfXI8Um4f+04eH9UvZUiTKM+AimyyCta4BmVMLpD6R9G4RHXxoBlQmsyQTtkhHVGobZfrvLjjlm3RXznUAF5mljYzj/Yv33vsEGK5LgQs6u2CSie62D1WJPy7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Ms9gZ2p3; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5759VOBT021585;
	Tue, 5 Aug 2025 12:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pps0720; bh=pZj/AjXPx/GvfpR3sI+Gk/mkA0nXNzhqfbU98BKmt4g=; b=Ms9g
	Z2p3suXHrh1F3Op9DsZcYC629nwQ893OaMTGZm0BV7HCHaJGoVB4p91h/fPAgCJ0
	6KQhM6Gb3ArEUg7q5ectbltCTnH0YJb67k8hLFoBQEld5Sxhf5CTb5u25zmYpfEx
	IeS8aadwGWKygtnUnzpiDtCtwL3/D4pX0YKGWFRn3iI/8sWm5FCOADIXfLHfwjkj
	Ggt+OyRSQQNntvammle0eSQ0x3VLsYG4Wih4Dqt8O35s80Sgz8U1DkYuaSEbpDck
	aYHVe/BgzP9qAHEAdWdCRdKvjychxwTZlf5AnZ9b0VfHl8BvdXr6eh49BeFjXNq0
	n+XM/t87oJwipFl/gw==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48b7tpnh9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 12:48:22 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id A64AC805E14;
	Tue,  5 Aug 2025 12:48:21 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 1A5A9800EEE;
	Tue,  5 Aug 2025 12:48:18 +0000 (UTC)
Date: Tue, 5 Aug 2025 07:48:17 -0500
From: Dimitri Sivanich <sivanich@hpe.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jiri Wiesner <jwiesner@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>, Kyle Meyer <kyle.meyer@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2] x86/tsc: Disable clocksource watchdog for TSC on recent UV
Message-ID: <aJH9ke0k0HnL8g6h@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Authority-Analysis: v=2.4 cv=WcQMa1hX c=1 sm=1 tr=0 ts=6891fd96 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=MvuuwTCpAAAA:8 a=yP0fn3opPpjc5lNOb08A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: LP3JbOLF7LJwzoJ_2ll7il1QkrGeN9ny
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5MyBTYWx0ZWRfX1w4VQ/K9sql7
 59UNiMas3HMmZ5G2lVXJ+ttOVr5QpzJlEvjuqjfD4yfoiAvSgZPXFt/4ahHzFhyG3ZvZqbrBoqn
 C7mBx7AeLzN/t4AuF9mM+M9s5ZEcPrunn2qZ1gm5J7jCO2etZxR5W8KlTmLSRnCwHibp7zzQLhB
 VUAHdcwgMSdrcP5YPN7z1sxgG/ZCyK8JVVj9AaJ6ts6RgbiD8ltsr17JWGxfbe/EWmOVn+hcyU9
 VJ0hoMTjSURYJvIIui1692rBR+8KFH3YArfZ6nIGORa7ZbRjByltkAgBsk0VkuGhjhU9qWrJ87c
 H6MxZN185Mavw8gCK/6YlMfipQwLKSXR6VAiwYcO35o8w5X72tX+Wp+Ro/+5qqVZXAtgS4chxqF
 WeLSi9+fNx8Amkio8ugAVGP6ZVjaSYrrYq3+mMmIx+mfTLAm4wUub0g93EyyZTS8G/07YPM3
X-Proofpoint-ORIG-GUID: LP3JbOLF7LJwzoJ_2ll7il1QkrGeN9ny
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050093

Disable clocksource watchdog checking on recent and future UV platforms
to avoid false positives.

Commits 'b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC on
qualified platforms")' and '233756a640be ("Extend watchdog check exemption
to 4-Sockets platform")' were introduced to avoid an issue where the TSC
is falsely declared unstable by exempting qualified platforms of up to
4-sockets from TSC clocksource watchdog checking.  Extend that exemption
to include recent and future UV platforms.

Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
---

Version 2:  Fixes a build error that occurs when UV is not configured.

 arch/x86/include/asm/uv/uv_hub.h | 8 ++++++++
 arch/x86/kernel/tsc.c            | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index ea877fd83114..0ac079e820b0 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -26,6 +26,7 @@
 #include <asm/irq_vectors.h>
 #include <asm/io_apic.h>
 
+#ifdef CONFIG_X86_UV
 
 /*
  * Addressing Terminology
@@ -785,5 +786,12 @@ static inline int uv_get_min_hub_revision_id(void)
 	return uv_hub_info->hub_revision;
 }
 
+#else /* !X86_UV */
+
+static inline int is_uvx_hub(void) { return 0; }
+static inline int is_uvy_hub(void) { return 0; }
+static inline int is_uv_hub(void) { return 0; }
+
+#endif /* X86_UV */
 #endif /* CONFIG_X86_64 */
 #endif /* _ASM_X86_UV_UV_HUB_H */
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 87e749106dda..23727d7214e6 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -31,7 +31,7 @@
 #include <asm/i8259.h>
 #include <asm/msr.h>
 #include <asm/topology.h>
-#include <asm/uv/uv.h>
+#include <asm/uv/uv_hub.h>
 #include <asm/sev.h>
 
 unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
@@ -1261,7 +1261,7 @@ static void __init check_system_tsc_reliable(void)
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
 	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
-	    topology_max_packages() <= 4)
+	    (topology_max_packages() <= 4 || is_uvy_hub()))
 		tsc_disable_clocksource_watchdog();
 }
 
-- 
2.43.0


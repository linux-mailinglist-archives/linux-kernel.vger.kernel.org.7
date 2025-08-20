Return-Path: <linux-kernel+bounces-778453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFD1B2E5E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34EC15E4070
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D3C277CB4;
	Wed, 20 Aug 2025 19:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="OSYnwBjK"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC46F19258E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719724; cv=none; b=EkqIMEfscfoZ1XB7W5CH3Qr+by9LBcdatYWlQXvgz3cXhHJRSa0iNg36JbAK7p4WiLY1f7RWkJbWOvY7CJZLawGepyfBXXuLtbZi+h6V3+yS7Hr7AgL4MseZOp+7WR2s4pYY7nwa0xjftM3DIgYWIW3SeypXC83iZxu8Z85ZUNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719724; c=relaxed/simple;
	bh=9CQDlGqQ1DeJCXfUip7WzPyujBvcKpQy7usX8ZZkk9I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ct2M08O9lNp5lEB3M5fW9c+Rku96/AKcsNho+Jg/gyPsEiqf+i0asH0p6Pyncwq1Ns8h4S7Egerpq8OpMLnUzGprzaGpY28kuHHQpX61wbz0BzYX6OaZ7oqUnYgf0m3zaoChfbDcE4oKv6u7vkTvdZvOPN90cUBPjWKcKSMM5r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=OSYnwBjK; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KHIIEi023652;
	Wed, 20 Aug 2025 19:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pps0720; bh=GyF4IwNNpoGh8pEPZkEQDFJ/EFxR2l4JrgBJLxoZfJk=; b=OSYn
	wBjKrIWUljTMT4uO7o9lG9kRsCzYkqvmz0PAS+Ovm9xFUHq+N84VAYJgLZLUmRDq
	VjAQPDlPELZnQRNyqCSCOTuQCbnzJYjtUlJfHiGjNesIxkLoUVZg3B2z6ts6AjHF
	s7digyYpid4BNrvYaysLL4YhwtrjQ3hsgbzQg1TcdSpG3exrtHf6udpUlBU5tZYm
	33gIz4aRjPtyHiC9+R+HYKY09DBBLcHpabMDLyaGM9ssxmsNAQc0Us+SogIK/XD/
	S70nQIKqADVodTKVVSqnx8LuxOtzgBf5UL1yo9tTYpqtcVjtkVz0wVb6Cay4GFS2
	rm+xYdd2KGYmbcGpLA==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48n8m8yubc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 19:54:22 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id F0706805E05;
	Wed, 20 Aug 2025 19:54:20 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id AABEE800450;
	Wed, 20 Aug 2025 19:54:18 +0000 (UTC)
Date: Wed, 20 Aug 2025 14:54:16 -0500
From: Dimitri Sivanich <sivanich@hpe.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jiri Wiesner <jwiesner@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>, Kyle Meyer <kyle.meyer@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3] x86/tsc: Disable clocksource watchdog for TSC on recent UV
Message-ID: <aKYn6I8kpxMFnVOP@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Authority-Analysis: v=2.4 cv=To6/RDXh c=1 sm=1 tr=0 ts=68a627ee cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=MvuuwTCpAAAA:8 a=yP0fn3opPpjc5lNOb08A:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDE3MyBTYWx0ZWRfX0+k7eBl00/jT
 KQzWWLw7YZNVuAc1f+DXXC4nssEfMhMVxspKW4cukwieqgawNt5IBUqg5Pu9wq0eIT7Md2+oW9I
 6r3llxMl6CVALIaOndEe6TR0INg+Iv4vriYTiawpN5JuUFDjhqVMTg2QO3Ind5uS1hpwG63ufEo
 OQOafY1M1lpsgQYJnpJA0fxaLMFC1xBvSDpLLqZmAGoGzDz2J4c4sgGsYrhGTEYwFwGX811j71z
 Zma5HUpIoidZMBKxc5K+lZLKf9GT7HFEO9M9ed7/+Syq3r17XF+7EcQ1tlcHGUUuU8N2PA6P9Dl
 bWWHUJZBpzrn/hR9Z3nmG5QTDAMivIzWNo85pwUo3TrUR0WZKlix7rrbf5Iue50tdXJG1cxSeq+
 EiuXZGBZe+ihQzRT4tSn4sQeWLEqUEv6vgtgr5KFxamgcR91vyM1cJ7nALIr73Up+CrKj1Vj
X-Proofpoint-GUID: l4FpiNbqEvPDP-nyN6Xd4laHPFnY_2ys
X-Proofpoint-ORIG-GUID: l4FpiNbqEvPDP-nyN6Xd4laHPFnY_2ys
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508200173

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

Version 3:  Fixes a build error in the X86 32-bit build.

Version 2:  Fixes a build error that occurs when UV is not configured.

 arch/x86/include/asm/uv/uv.h     | 3 +++
 arch/x86/include/asm/uv/uv_hub.h | 2 ++
 arch/x86/kernel/tsc.c            | 3 ++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
index 648eb23fe7f0..f1aebdf85e68 100644
--- a/arch/x86/include/asm/uv/uv.h
+++ b/arch/x86/include/asm/uv/uv.h
@@ -38,6 +38,9 @@ static inline int is_uv_system(void)	{ return 0; }
 static inline int is_uv_hubbed(int uv)	{ return 0; }
 static inline void uv_cpu_init(void)	{ }
 static inline void uv_system_init(void)	{ }
+static inline int is_uvx_hub(void) { return 0; }
+static inline int is_uvy_hub(void) { return 0; }
+static inline int is_uv_hub(void) { return 0; }
 
 #endif	/* X86_UV */
 
diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index ea877fd83114..6e085ce8fc02 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -246,6 +246,7 @@ static inline int is_uv5_hub(void) { return is_uv(UV5); }
  * then test if is UV4.
  */
 
+#ifdef CONFIG_X86_UV
 /* UVX class: UV2,3,4 */
 static inline int is_uvx_hub(void) { return is_uv(UVX); }
 
@@ -254,6 +255,7 @@ static inline int is_uvy_hub(void) { return is_uv(UVY); }
 
 /* Any UV Hubbed System */
 static inline int is_uv_hub(void) { return is_uv(UV_ANY); }
+#endif
 
 union uvh_apicid {
     unsigned long       v;
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 87e749106dda..a9f97d423ab0 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -32,6 +32,7 @@
 #include <asm/msr.h>
 #include <asm/topology.h>
 #include <asm/uv/uv.h>
+#include <asm/uv/uv_hub.h>
 #include <asm/sev.h>
 
 unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
@@ -1261,7 +1262,7 @@ static void __init check_system_tsc_reliable(void)
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
 	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
-	    topology_max_packages() <= 4)
+	    (topology_max_packages() <= 4 || is_uvy_hub()))
 		tsc_disable_clocksource_watchdog();
 }
 
-- 
2.43.0



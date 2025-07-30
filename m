Return-Path: <linux-kernel+bounces-751360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DCAB16849
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 151787A6E10
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7B72222D4;
	Wed, 30 Jul 2025 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="kPivNK/P"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF701F4180
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753910967; cv=none; b=LTXIHNVNAWFoLeGgOo+THNe96H22+twQOR5KB1MsXt94w58ATBMWMr7FIydmcaJJw9p+5eXF75xRl3zC5Hc3ZJSQW9Mjo4R6V57C0BNXJH3Y8Sf5S0h4nLM5cZIfQyPFzvMCQr+psRC3M/uW5U5DHfPiH/1uKF/sGkiQxi4dFUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753910967; c=relaxed/simple;
	bh=oUoEBpNFL4g2dgVzwOlpw8NqryAmZ+d2zEgOI9yyh0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NiWW/J5hZVuf7DjZy9cIO11KN6CWPmJJ/E2YoZM7W9yfHjyW7Y2xnHAipf4wYIvw9MEhCoD93iGRVbzFiVub4GAVtn/z86D0R7DDbwzQky6wnJHeHnYHFaM5JIzfXMYwss1A9gUkSHXm4ZehzN6BDJLEGfWqyMDImEiAi3/hhuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=kPivNK/P; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ULAMei020184;
	Wed, 30 Jul 2025 21:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pps0720; bh=CB0o50x7kRnWRrJI371i2zQsY/4iz0OhHF/qI+kUAgg=; b=kPiv
	NK/PqTTQy/G3ofp+O6g52tCI542gJ5Sdew+sMGdY2OrafxplxSYDbkhVSlvDSAB2
	ESGi32AqW22AmWHNl97+Vry7gKOvytL/NnHqZSJlxkEq75MdG0CpOHDj6xhYZhPK
	ed/iVQyzaJlrV26C9/FETv/RMdJLD5SC1xuYqHPVhgpaWSIbVnbkZQ8UbuelYw2x
	MIRyjRdMLj/gANUew3ptAbo3RsZzTQndJE7aJvzmd+CRiScA8uSoTBgA8p0a6rPZ
	JO6rwIny1AGvWvBR+JfbxatjqJwjYZsIISKdBWrGKH2FQNP5tOMZ3fUctRmEmnno
	jkTTcBXmydT03Tk97g==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 487jttd3fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 21:11:30 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 483FC802BBB;
	Wed, 30 Jul 2025 21:11:01 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 2612080EA21;
	Wed, 30 Jul 2025 21:10:59 +0000 (UTC)
Date: Wed, 30 Jul 2025 16:10:57 -0500
From: Dimitri Sivanich <sivanich@hpe.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
        Steve Wahl <steve.wahl@hpe.com>, Justin Ernst <justin.ernst@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>, Russ Anderson <russ.anderson@hpe.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/tsc: Disable clocksource watchdog for TSC on recent UV
Message-ID: <aIqKYdvlKlBlSoQK@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: o7VC_XGvrQ7R-Ysl9D1V-vQXpS3tlxyi
X-Proofpoint-GUID: o7VC_XGvrQ7R-Ysl9D1V-vQXpS3tlxyi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDE1NiBTYWx0ZWRfX3FqoLyM7ElAl
 mSsg6Y3iqIF3xqfcnooy0PsMzugw3jlrxGvtC4qGQ4v+Sl1Fz6XGgb6OASBPfAjNqHjcBsE/GPr
 /uN4EeNmPp80yyRMx33J5S2Dra3ZPMStyDP15HFbwaOMD+fVQBpQyl5Wy8fQYP/Wau+TJCytr/W
 /Q4vC2FIZS6ejJ4KUhwRrbu+l28Zc7Pi3VJtKo6aLplIW/3kPsFVXcW4trP8EUwybMqNXbVItQ6
 TOqg12D7Y3iXWIOChWwyhKRZRqEDfad2nX+aU5qu4QR8UvS7KliTyOvkr7AZRaRsMYvsEkpkCdS
 amSHQA+iw5Qmz2oTX9/r9d8M6ZXe4qpe4qEzGqxTGAjtDED19qw+VE8AF5nvWa/cZsYM+lZFG8x
 1Zp7R8LMUB5gHp8WO6IgNJv1hLDNuJEBw6nkEOkVtHMe/SVOYssUyWKn0aHr2yn3SxqXrRN+
X-Authority-Analysis: v=2.4 cv=XP8wSRhE c=1 sm=1 tr=0 ts=688a8a82 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=MvuuwTCpAAAA:8 a=1E1KpLJVskXI76rVvsIA:9
 a=CjuIK1q_8ugA:10
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_06,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300156

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
 arch/x86/kernel/tsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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



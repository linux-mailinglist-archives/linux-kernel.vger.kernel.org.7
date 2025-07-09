Return-Path: <linux-kernel+bounces-724390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A04AFF202
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1503A488355
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF3122FF2D;
	Wed,  9 Jul 2025 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="WZ8hQKBL"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA5111A8
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752090507; cv=none; b=kby3UjlSd/emH1nClRZrfg9GZ6XhSJ3kTfGty8cR8d5W1PkYpE28BOdkCpX2vkd/k5SEjomDe7P8v4u0SzNC8rN2RiDCNSXUeZmmDNvu1lIYgfKOK5vd2hli9uSQ6e1iMDvcserhAoOniYIkYEvvXtwwSt+g3bCSspP36Xen/MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752090507; c=relaxed/simple;
	bh=L1GQiuR2VgSJ0cIPa/HPeGYOhb+bmW69VyhfRRUGCHk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=SODoqe8g+SfHojkG9bMJuUKOi/dQUX5OrON1tqrN5kghFGY5sBTqQUtipodC9Qg2ue6wVBm1zSVBhJN9xMXzrNDEwGGnVkoNCeaR0lYRXyz4WVnV4/e+SqDCvEZW5POfbKXkWDCeqSfGyTzCWylCgsUhzCEvYBjMPtUelZGRoHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=WZ8hQKBL; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569J6piS018657;
	Wed, 9 Jul 2025 19:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=7zeISt18+wOjXofLsZWwPsCIUbPBA0hM4C9kz
	1hF9Eg=; b=WZ8hQKBLXnu7jW736bO/Wm4RiwMaq2smbzIsHkL/VbNyUsINg4Twh
	wsmgb8DgLGolUfQIlSSk4GO2P/lnQZ7oRX4c07pkRfYTvNoksLJ+IFxYKLwU/9PP
	hOKalGLoNUs98oxLMCvKd8gzQke+MRx+AE+Ty6MsNWh1q8OHxSXghbs3AE0NWN1I
	UgzUbb7dyQ80zgV5CwyVHK0wV1NRSU7qOaGo1eOnu1i3asMFiJbdZNki9sOi150a
	QEKCfBVpvvEevzhUuKOV90GjlNuKXIPzn2nkhMGQ9W45NNGMUsHkYaSFi6rDV/5g
	Bxa1Zkwu31PS7urD3mPAmh3ZGmmVnneTQ==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 47sr18bysm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 19:27:47 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 25BF6805E65;
	Wed,  9 Jul 2025 19:27:46 +0000 (UTC)
Received: from stormcage.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 69F0380047D;
	Wed,  9 Jul 2025 19:27:45 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
	id C61D369FD42; Wed,  9 Jul 2025 14:27:44 -0500 (CDT)
From: Kyle Meyer <kyle.meyer@hpe.com>
To: steve.wahl@hpe.com, justin.ernst@hpe.com, kyle.meyer@hpe.com,
        dimitri.sivanich@hpe.com, russ.anderson@hpe.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/platform/uv: Fix UBSAN array-index-out-of-bounds
Date: Wed,  9 Jul 2025 14:26:41 -0500
Message-Id: <20250709192641.128872-1-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZsntK87G c=1 sm=1 tr=0 ts=686ec2b3 cx=c_pps a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8 a=cQ8G-YWvgT2x9suPT2EA:9 a=phs4urI-Bf8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE3NCBTYWx0ZWRfX5Q0fsuDlJaVX Fwn5H4z2L5RJ7gf39Ra/ZdUwwXZl4PsALGP0O02g+3qy1+HEfpLsGf7akI7DDpzCl5kVeRiUDYZ XYA711kIOkdM4FmpJqXnDcUoBllfS+wZc8OqFk4fQFrmZu0AtIzbRUXWo9pCyoNh8k4y5V5uCiP
 mr/aOkLpgHyTupQ4jvBZdsRTb9Qz1i1FhYbJMAPJ6+vL39x2Zv644t4Y9QjIgBWqziimuN2S5ch AT1FYKs3Sny9TOENZCOGXuqto3e8WKVfFscHyXPuhBDOPkRQsFwdWQc3tiaOoGHVClE5LaZvXvP Lolv+CoYX5rcNHHFxNDAv+vPux3apdMOc5vz9UgU6O2G66xcr96F8IqDXUiM6P0O/x1TSokCbru
 93KuV/wQ0eLUNA/Z305hanHzrjBuYZZT8OCZ9mALqNYVcUPLdSl1konzJP0GBnbCQ+Q5K7To
X-Proofpoint-ORIG-GUID: 9UtmGSc1HAQGZ4Pq4qg97rNcZwJmlBLt
X-Proofpoint-GUID: 9UtmGSc1HAQGZ4Pq4qg97rNcZwJmlBLt
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090174

When UBSAN is enabled, multiple array-index-out-of-bounds messages are
written to the ring buffer:

[    0.000000] [     T0] UBSAN: array-index-out-of-bounds in arch/x86/kernel/apic/x2apic_uv_x.c:276:23
[    0.000000] [     T0] index 1 is out of range for type '<unknown> [1]'
...
[    0.000000] [     T0] UBSAN: array-index-out-of-bounds in arch/x86/kernel/apic/x2apic_uv_x.c:277:32
[    0.000000] [     T0] index 1 is out of range for type '<unknown> [1]'
...
[    0.000000] [     T0] UBSAN: array-index-out-of-bounds in arch/x86/kernel/apic/x2apic_uv_x.c:282:16
[    0.000000] [     T0] index 1 is out of range for type '<unknown> [1]'
...
[    0.515850] [     T1] UBSAN: array-index-out-of-bounds in arch/x86/kernel/apic/x2apic_uv_x.c:1344:23
[    0.519851] [     T1] index 1 is out of range for type '<unknown> [1]'
...
[    0.603850] [     T1] UBSAN: array-index-out-of-bounds in arch/x86/kernel/apic/x2apic_uv_x.c:1345:32
[    0.607850] [     T1] index 1 is out of range for type '<unknown> [1]'
...
[    0.691850] [     T1] UBSAN: array-index-out-of-bounds in arch/x86/kernel/apic/x2apic_uv_x.c:1353:20
[    0.695850] [     T1] index 1 is out of range for type '<unknown> [1]'

One-element arrays have been deprecated [1]. Switch entry
in struct uv_systab to a flexible array member to fix UBSAN
array-index-out-of-bounds messages.

[1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---

sizeof(struct uv_systab) is passed to early_memremap() and ioremap(). The
flexible array member is not referenced until the entire UV system table is
remapped, so this changes to sizeof(struct uv_systab) would have no impact
anyway.

 arch/x86/include/asm/uv/bios.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index 6989b824fd32..d0b62e255290 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -122,7 +122,7 @@ struct uv_systab {
 	struct {
 		u32 type:8;	/* type of entry */
 		u32 offset:24;	/* byte offset from struct start to entry */
-	} entry[1];		/* additional entries follow */
+	} entry[];		/* additional entries follow */
 };
 extern struct uv_systab *uv_systab;
 
-- 
2.50.0



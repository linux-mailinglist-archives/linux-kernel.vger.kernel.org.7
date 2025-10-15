Return-Path: <linux-kernel+bounces-853822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EECBDCACC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 999C34E7698
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1482FF16B;
	Wed, 15 Oct 2025 06:18:09 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4571623ABA8
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509088; cv=none; b=DVQiPvc/f1tg6oTTRTA1m/KuYxWHSZalMuhYsVog8gkuPJSMmljcF+ZG3XjFKqItNZsynelc0Kim1zvFT6to2yKtMnL3sw/c6ng9EdIhzgOBBNo254hv9yg6V4r0/D7wThI9L6hXEu6uiibxjmamxClNpsYiR5Srtotauzq7/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509088; c=relaxed/simple;
	bh=00vkzuLktB6wmqLHFAXh0IaPTK1wbG12G/QsgWkAQr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPeZzydR6B2GMwYxHmBRKEHKbBBvJ2iv0fqGt4lE9D9MgpN3ZVGGd3hbDpCw9Sr0DicTwaGh1GowcZlbcr6EwC01LggrY7v4K+Z9Y17hZr4p+Vzq/xH8PcMxtd2qd9uRfSkjD9GLV+KW4Z2MQn8/qnlvDqm0a9eulN1krmrRyMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: esmtpgz13t1760509078t710fc538
X-QQ-Originating-IP: fKuI2SoLTPBzi9ZxhQ0J1CaSp3/phsZPssuIEn3Y994=
Received: from GPU-Server-A6000.. ( [202.201.1.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Oct 2025 14:17:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13976680870695852025
EX-QQ-RecipientCnt: 14
From: Yuan Tan <tanyuan@tinylab.org>
To: arnd@arndb.de,
	masahiroy@kernel.org,
	nathan@kernel.org,
	palmer@dabbelt.com,
	linux-kbuild@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i@maskray.me,
	tanyuan@tinylab.org,
	falcon@tinylab.org,
	ronbogo@outlook.com,
	z1652074432@gmail.com,
	lx24@stu.ynu.edu.cn
Subject: [PATCH v2 2/8] scripts/syscalltbl.sh: add optional --used-syscalls argument for syscall trimming
Date: Wed, 15 Oct 2025 14:17:49 +0800
Message-ID: <B120EFEBD27B9B67+6751ec7c12d04aafe1de79502b984ed65013f6cf.1760463245.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760463245.git.tanyuan@tinylab.org>
References: <cover.1760463245.git.tanyuan@tinylab.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OdpilHhB3Diujx6EYo5q9GAN9mQcXgCX/4RNI2R8qvLGIdAMNIl4enbk
	AsHLUmw1w6RnvGHCchSkfkO/OA7KY/Mo0wuW7bIJ3DBTbPKjyE4DhGwpBNuu08792jXdkHr
	qoyPEEDtFOzO+9T9fJei3xJk97Yj7/3XWD5P/QlOSg6qcOFWqbmttwmffAnSx8isIcgdKxZ
	64bfzpjO7Ju8t7Ing8YzOThSdmVSiy6J/Au/IMHiJdHWtgBIkTLxHvNC9llG9ZTGBu6D2he
	OT/C4ZWMG1UQlQAfZa6Wq1y81SOyMBkvHVMpUGVV7PrxP2OYuOAhi+lra+xKJfQUEx9ZIF5
	2W8/NQBZnxcyqfcvhSzmxzFkm1rrbQ6eWVi/jtyJhl8FVsv7hqTHZ6Wr4p4S4jHG4PIvvyl
	fl8DZCjFOuuLIKmKHZThDOxhFP1ofqSifYvvRk1dwl+0jG836Xx+TA9g7QfPQECqMLCpFmK
	n+8cpj4ldP+Lp24aAENDqf088+7AK7vK2j19diR1g+wF1t1RInLhdYGrVc57DwcnuZUAbWB
	9NnpP1/bK5SoEdBTTVpPKY7RSOwyhEnXJR1sqM5p4IkYlGgxa7vpUMEeuyM/tQJzbQWo2u3
	u+j4v4u1gHFggadj2LaWYHL5fUXB5t7Qbw71O9gmxqgtll2gLpGnhiDln81i/lVL8GO62fA
	q/K3xo5Ny+eVOE2Bev5+AxgDq6LkvCFrr2GsJJqDcWpcO15Km2p6yBgbDrxuUbNUfYiHrlG
	67oEpjBOp8BOlVPPZlCnsZwCeiWhBoJwFJB8X/mVyJq34Vx59+uYFb26wGgyH3hVb1MUm3J
	0tiCHato75MlnSiIqEx0Wcxeb4e6CuoUCxx9zoBh7kAfJYp3bixGhVw3S0yYubzcebdxwyT
	wdvVPQ92Bh5wTslbaoVuEz6sanCuQn8x5ZPGvfu7zGZOstNcp4oceEwlQCG1rToO4juEL0o
	wiDrBoLf6ue1xZFLMU0n6w1fLtF1CMtjr4JTYvatLYZNS/qGKIywSOmX2MRFvN3gD+cQ=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

From: Yuhang Zheng <z1652074432@gmail.com>

Add support for an optional `--used-syscalls` argument to
scripts/syscalltbl.sh. When provided, the argument takes a comma-separated
list of syscall names that should remain enabled in the generated syscall
table. Any syscall not present in the list will be replaced with a
`__SYSCALL(nr, sys_ni_syscall)` entry.

This enables selective system call table generation when
CONFIG_TRIM_UNUSED_SYSCALLS is set.

Signed-off-by: Yuhang Zheng <z1652074432@gmail.com>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 scripts/syscalltbl.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
index 6a903b87a7c2..27d8dfce5748 100755
--- a/scripts/syscalltbl.sh
+++ b/scripts/syscalltbl.sh
@@ -22,12 +22,14 @@ usage() {
 	echo >&2 "  OUTFILE   output header file"
 	echo >&2
 	echo >&2 "options:"
-	echo >&2 "  --abis ABIS        ABI(s) to handle (By default, all lines are handled)"
+	echo >&2 "  --abis ABIS                ABI(s) to handle (By default, all lines are handled)"
+	echo >&2 "  --used-syscalls SYSCALLS   Keep only the specified syscall; trim others"
 	exit 1
 }
 
 # default unless specified by options
 abis=
+used_syscalls=
 
 while [ $# -gt 0 ]
 do
@@ -35,6 +37,14 @@ do
 	--abis)
 		abis=$(echo "($2)" | tr ',' '|')
 		shift 2;;
+    --used-syscalls=*)
+        used_syscalls_raw=${1#--used-syscalls=}
+        if [ -z "$used_syscalls_raw" ]; then
+            used_syscalls='^$'
+        else
+            used_syscalls=$(echo "$used_syscalls_raw" | tr ',' '|')
+        fi
+        shift;;
 	-*)
 		echo "$1: unknown option" >&2
 		usage;;
@@ -52,6 +62,7 @@ outfile="$2"
 
 nxt=0
 
+
 grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
 
 	while read nr abi name native compat noreturn; do
@@ -66,6 +77,12 @@ grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
 			nxt=$((nxt + 1))
 		done
 
+		if [ -n "$used_syscalls" ] && ! echo "$name" | grep -qwE "$used_syscalls"; then
+			echo "__SYSCALL($nr, sys_ni_syscall)"
+			nxt=$((nr + 1))
+			continue
+		fi
+
 		if [ "$compat" = "-" ]; then
 			unset compat
 		fi
-- 
2.43.0



Return-Path: <linux-kernel+bounces-882169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C8BC29CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB6D3AEB8C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 01:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E652749D7;
	Mon,  3 Nov 2025 01:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y3FUNARC"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971DB3A1B5;
	Mon,  3 Nov 2025 01:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134412; cv=none; b=HkS9Jl+8kIZvA1xA6zEAGmUI1pUTIf1mYKP2+p6twOF2hp/YUE2eM/1Cd8pwZygBRWAgyPuieozlQg31kROfzC3GNhQDrswhbpn9dFZ52JUxQwAJ5kXhA0ts6kVpm56hnFo5xzgZM+ALEvOcvJPg/qr+ETrOutU4iTqNrCpnyfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134412; c=relaxed/simple;
	bh=tz/3X5TX5Scv+lrlmT6dDipvwCHULnwEEad+kU5oR4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E8niRLnjzjfHRsQhwKYc2+gSBTIecDslEqrrzE3eK/JPG/f3uC/TzsyVpVwmSTHGuUDqCMp6QGDSFRYNipyhIRBtigyboYTMZddUl+MF1ic27s5o+CF5PORmF2vPDAMaBpXvGb741pGQLkewIaVRMsLsapCpfPtF/UsIglix/Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y3FUNARC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0WzumnM/hhduantBwY/kZRPJeZB7TIntXpGq+DNWcfs=; b=y3FUNARCE8EbRsUDEQDx8ZwINf
	FrCYQeEdVKLsuu3Eea3no9qdg/k3loiiM5eAruaeI8339VLkBqd/tWUyeF5a7+R9ShRQ1W6S5g6sx
	M21lmDj0km8MNhGb0I7CfzJoKJs0D1b9yLSejAhNqhXvEDc39MshTVV+xoIEYoxrmj9Bl+u2qbHQE
	PJlYcetVeWA6BF8f+epjyJ65dFpTMJehIOdYvEZ+V1+6O8GpDjOK9u/oz29kr5j6IhhQcY36xUr3W
	EuuSkENwZER0l+auT2QnSVHPSjbIJKsOttY6rb8sHt+eexS2NkZzYde/GVPbI4gNE8dDQOcBTx9gU
	1bEZ3O6w==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFjec-000000091d4-1SQs;
	Mon, 03 Nov 2025 01:46:42 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH v3] kernel-chktaint: add reporting for tainted modules
Date: Sun,  2 Nov 2025 17:46:41 -0800
Message-ID: <20251103014641.669126-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check all loaded modules and report any that have their 'taint'
flags set.  The tainted module output format is:
 * <module_name> (<taint_flags>)

Example output:

Kernel is "tainted" for the following reasons:
 * externally-built ('out-of-tree') module was loaded  (#12)
 * unsigned module was loaded (#13)
Raw taint value as int/string: 12288/'G           OE      '

Tainted modules:
 * dump_test (OE)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Thorsten Leemhuis <linux@leemhuis.info>
---
v2: change tainted modules output a bit (Thorsten);
v3: add Acked-by from Thorsten (forgot it on v2);
    more changes as suggested by Thorsten;

Cc: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 tools/debugging/kernel-chktaint |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- linux-next-20251031.orig/tools/debugging/kernel-chktaint
+++ linux-next-20251031/tools/debugging/kernel-chktaint
@@ -211,9 +211,25 @@ else
 	addout "J"
 	echo " * fwctl's mutating debug interface was used (#19)"
 fi
+echo "Raw taint value as int/string: $taint/'$out'"
+
+# report on any tainted loadable modules
+[ "$1" = "" ] && [ -r /sys/module/ ] && \
+	cnt=`grep [A-Z] /sys/module/*/taint | wc -l` || cnt=0
 
+if [ $cnt -ne 0 ]; then
+	echo
+	echo "Tainted modules:"
+	for dir in `ls /sys/module` ; do
+		if [ -r /sys/module/$dir/taint ]; then
+			modtnt=`cat /sys/module/$dir/taint`
+			[ "$modtnt" = "" ] || echo " * $dir ($modtnt)"
+		fi
+	done
+fi
+
+echo
 echo "For a more detailed explanation of the various taint flags see"
 echo " Documentation/admin-guide/tainted-kernels.rst in the Linux kernel sources"
 echo " or https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html"
-echo "Raw taint value as int/string: $taint/'$out'"
 #EOF#


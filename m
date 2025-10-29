Return-Path: <linux-kernel+bounces-875115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A952C183DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C8754E1E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0B22F5A34;
	Wed, 29 Oct 2025 04:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="36q0vNqL"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA15253F39;
	Wed, 29 Oct 2025 04:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761712747; cv=none; b=k5e2OOLJnWG579p7KJjOKtgnJklSZ5RVma+DCGDS65v8kel7n90BhxA2LtZY07vnYiRiqGFIC4VMFLMoqGGP0g2O/UuqsVZJ9ZAOcftoD5KPJD5hbRUSMqooK7LYthugtwbxgMpqv0uvcOCy7N7PavupViBHmDHogkbdynOGBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761712747; c=relaxed/simple;
	bh=PBvzyWHfeXt2N6SNmervaBvYJeqX/VZPaEXWGSW6pyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J8UOk3IW5kcqMvliswYdtR9BfVZUDD2uK8fJyF7zFvCd0D5C6IAWoK8x+4dXwWFd51nj22xKd+ALI18AlDEYeSy5rKgNZmNLTygLVmDhhLtLjsc/9AgsvBt1QNB+OaMeyG8ENNKY6tx/GkNhBjgfqyUOyUUZJdXGlDSm3TFeQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=36q0vNqL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=mYBY9h7lVZV5o0amfP/qdHqKx+0pZ/0AV4G3M2wHNdg=; b=36q0vNqLM5WFclDLAoQR8dIE4P
	9PPpcFUDW6U9oLmvuHt7V7GDrwzwW4DO16Fnjo00t3z8bhg8Ep5nJegwWdG1kCAiYmcItABF8hHc3
	pROcSXbn0JRzYy+jOloVgjGWO2ni+IRuq3sfpgthZoAA9Z3+c1Gm7XmN0NmXk9UnJ5dLoweeZX0oN
	qYpxpk6FTPBpGG29Cp3VCpeiWCnCqc67l/88Emb+BMagB5El7YBtLv62Zs1vwWO4ddaWC/qinQWsI
	rz6DY9Rxd+MWx7CuDGW0W5kELCCsfgikLEq3ozQTS+Y2WuSh8OApruow/At8ozx1BziEwtUvCOKfn
	uMPu0pMQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDxxf-0000000HCFl-09N0;
	Wed, 29 Oct 2025 04:39:03 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2] kernel-chktaint: add reporting for tainted modules
Date: Tue, 28 Oct 2025 21:39:01 -0700
Message-ID: <20251029043901.10755-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check all loaded modules and report any that have their 'taint'
flags set along with a count of all tainted modules.
The tainted module output format is:
 * <module_name> (<taint_flags>)

Example output:

Kernel is "tainted" for the following reasons:
 * externally-built ('out-of-tree') module was loaded  (#12)
 * unsigned module was loaded (#13)
Raw taint value as int/string: 12288/'G           OE      '

Modules tainted: 1
 * dump_test (OE)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: change tainted modules output a bit (Thorsten)

Cc: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 tools/debugging/kernel-chktaint |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- linux-next-20251027.orig/tools/debugging/kernel-chktaint
+++ linux-next-20251027/tools/debugging/kernel-chktaint
@@ -211,9 +211,24 @@ else
 	addout "J"
 	echo " * fwctl's mutating debug interface was used (#19)"
 fi
+echo "Raw taint value as int/string: $taint/'$out'"
+
+# report on any tainted loadable modules
+[ -r /sys/module/ ] && cnt=`grep [A-Z] /sys/module/*/taint | wc -l` || cnt=0
 
+if [ $cnt -ne 0 ]; then
+	echo
+	echo "Modules tainted: $cnt"
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


Return-Path: <linux-kernel+bounces-873155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 05571C13424
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5D853521F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EC92C11F7;
	Tue, 28 Oct 2025 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HGjZHUUW"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C4A226541;
	Tue, 28 Oct 2025 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761635537; cv=none; b=YqLga0O0nEQDRVkn3h0fFrvl/vAHBeeLTR/LQrrJwQqgAD3tEOCgs2xwSCrsZ9JlVV3xJsGXOFNemectXgsuHULtKdsqnz4REEy8QWu/0oKkAaxD/w13fvupr+M9DyjmWOFmcijBivGkK+dDNGphSFfbNHLI7CzLjCsdEJgwXL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761635537; c=relaxed/simple;
	bh=7LNTkhSqDMzMzDMNTb35h/pjqCE/s3amSqowEO4itJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KQsehV13S4Ri1kQVzTZshcjK9of+pxjw3GD4hsqtEAlcsa6e+T5zk86QNizYLufiLByWM2CMRVfAMIlqMspxiXX+7j1cRxmIACKQ8OT00jrrkq+QLJOty5JhfMoZGN04j1TyiXeoKq9zDExhcdnQQcg1wyos0J0vBWWHxTGucMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HGjZHUUW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=BksfCO/2CNKUYmi+/GnY08s7Q/H1E9YhdIPtX8Cc4bE=; b=HGjZHUUWLwpAEO/pPM5wOkvwO+
	1xruBynjIUjFNJOZPWF65jtjH4J/6J/m4nBWZlS0UduKWc66mIpfLY8585RFwI5J9lZmAcQcs8t9L
	rjcHsA774fUinLLjiLlNlhHUmuO11y+2R4eYMzwQCl07qLlfi3qSHeX2MjbkAbabQJWEHsnltuVkc
	fKiLRpt183Odcmh7XGBF86T05g75xKoOeKWBfDy4q2lhKcv+2uwLlvpBajHwCigHpf+VOFLmh3EIW
	XLzyA/yWBBNO89MqvKJOBBZ4+o33UwFlActh4Gf3nGNU/U+E381wplCG0DPKFxs6351xZu+a3rVi0
	orJelFsA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDdsK-0000000FORw-2ReW;
	Tue, 28 Oct 2025 07:12:12 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH] kernel-chktaint: add reporting for tainted modules
Date: Tue, 28 Oct 2025 00:12:11 -0700
Message-ID: <20251028071211.18065-1-rdunlap@infradead.org>
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
<module_name>: taint=<flags>

Example output:

Kernel is "tainted" for the following reasons:
 * externally-built ('out-of-tree') module was loaded  (#12)
 * unsigned module was loaded (#13)
Raw taint value as int/string: 12288/'G           OE      '

Modules tainted: count=1
dump_test: taint=OE


Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
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
+	echo "Modules tainted: count=$cnt"
+	for dir in `ls /sys/module` ; do
+		if [ -r /sys/module/$dir/taint ]; then
+			modtnt=`cat /sys/module/$dir/taint`
+			[ "$modtnt" = "" ] || echo "$dir: taint=$modtnt"
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


Return-Path: <linux-kernel+bounces-826117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0857B8D933
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 12:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E243D4E04EB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB6C258CF9;
	Sun, 21 Sep 2025 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="cl4Lross"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB78C257AC1
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758449049; cv=none; b=TbaBSdpAwofR36pmvBWmpf80O7SVXrxoSqA8tWCgW1RAUmPKpHtMOv2IFB0lIG02b1Zo8WFR/de1jzxx7g0JT88ojuJetrl69REBgHAxzEzsUJsqTlcuIzrln3GHSnGIjF2zQWw2Wfksa0Sxn79YzPxnJ2xL5gu8q09BVW6gAuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758449049; c=relaxed/simple;
	bh=8ENYQ0o+xwxmfzcJmSdK9HK0GEHKFkMTnX42LuyyhC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mS3AOTPHHi4RQdB6kAoz+yBg9HuUnWSs10h62n/6T7yn/Nqhzsb8I7JmPyW3oLVSCmBZ6pf1mYV/Kn2+SKG/BpoOPXJDGcm1h9txsATPOTy/oBxB7n0U+HB7SG5WWaypanXHuKTa4TNdo4ygELqJvf+OudMRCC+DYeMReusW/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=cl4Lross; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cV1zm2cVpz9sqs;
	Sun, 21 Sep 2025 12:04:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1758449044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCcJxFHseGNd/SfpPAXRUT1H6idJTFJQAWIdHEI6XMc=;
	b=cl4LrossqnXgcJ2sfzsUfuLZt1Fk4n3W5AKoRqNePIoh8NnA0h4TLyWHzjlz0U+tOaa3cn
	1phofB2KPSXC7RVr40r0FS5BSgDgaeiAY1irYOgPlg6OQzILf/Ri/6yRU7CV10E742HFNg
	PAr6UCgGIm5sv3gDGw2pFmU5XA9CQ+H2je+AxQbw6TvHG0KAlCl14xRWT1wUfLqv/RhAg2
	9zCplNsbvwSoJQR42NynZOnYNg3sNj3ao6YL2okFz6MJ7+hBwHRJ+2PJ2N1aWZOZQwfjss
	w7ba/dz+bFniBczcFZhoN/3Kl57RXl4XwJBgTIfcT+slD6RS3p4hi7nhaQdHHA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 2/2] scripts/faddr2line:fix "Argument list too long" error
Date: Sun, 21 Sep 2025 12:03:58 +0200
Message-ID: <20250921100358.19986-3-kernel@pankajraghav.com>
In-Reply-To: <20250921100358.19986-1-kernel@pankajraghav.com>
References: <20250921100358.19986-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cV1zm2cVpz9sqs

From: Pankaj Raghav <p.raghav@samsung.com>

The run_readelf() function reads the entire output of readelf into a
single shell variable. For large object files with extensive debug
information, the size of this variable can exceed the system's
command-line argument length limit.

When this variable is subsequently passed to sed via `echo "${out}"`, it
triggers an "Argument list too long" error, causing the script to fail.

Fix this by redirecting the output of readelf to a temporary file
instead of a variable. The sed commands are then modified to read from
this file, avoiding the argument length limitation entirely.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 scripts/faddr2line | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 966e98197dbf..c8e341f8830e 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -107,14 +107,19 @@ find_dir_prefix() {
 
 run_readelf() {
 	local objfile=$1
-	local out=$(${READELF} --file-header --section-headers --symbols --wide $objfile)
+	local tmpfile
+	tmpfile=$(mktemp)
+
+	${READELF} --file-header --section-headers --symbols --wide "$objfile" > "$tmpfile"
 
 	# This assumes that readelf first prints the file header, then the section headers, then the symbols.
 	# Note: It seems that GNU readelf does not prefix section headers with the "There are X section headers"
 	# line when multiple options are given, so let's also match with the "Section Headers:" line.
-	ELF_FILEHEADER=$(echo "${out}" | sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/q;p')
-	ELF_SECHEADERS=$(echo "${out}" | sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/,$p' | sed -n '/Symbol table .* contains [0-9]* entries:/q;p')
-	ELF_SYMS=$(echo "${out}" | sed -n '/Symbol table .* contains [0-9]* entries:/,$p')
+	ELF_FILEHEADER=$(sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/q;p' "$tmpfile")
+	ELF_SECHEADERS=$(sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/,$p' "$tmpfile" | sed -n '/Symbol table .* contains [0-9]* entries:/q;p')
+	ELF_SYMS=$(sed -n '/Symbol table .* contains [0-9]* entries:/,$p' "$tmpfile")
+
+	rm -f -- "$tmpfile"
 }
 
 check_vmlinux() {
-- 
2.50.1



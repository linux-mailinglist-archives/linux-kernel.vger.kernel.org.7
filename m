Return-Path: <linux-kernel+bounces-736851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDD5B0A410
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FBD16CEAF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865FB293B49;
	Fri, 18 Jul 2025 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="W9YAU6A8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="sOtO0r+u"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCA51E49F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752841265; cv=none; b=uJGowtN3N3RdeEa88JKfwQJtmRQfZaG0Pmx6i8//xsE2aejzWAEpYq8iRURlaZ7YtK0q9SpcXSdl4dyL/Iv8tDJCtOO3j3Wf9XBAu9OkytX9oS8GLpuxmtdPPCY1/pmzEnlnuYrruxS26NtfjYJiMVPPWc3mhDgMn7HgOKiBjh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752841265; c=relaxed/simple;
	bh=NjNm3TER+Ep0hojeNwnaSZOnbft51UbOYjapZf9MmpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0zWI24mySoMuAIXdweXd8zyfDc1SmcJwF+UM0pzkJ8E7Wr6Wv1tHgm2x+wCHAP0ELmvMFSjaeePyBloBt2e6obdABxtZxNw1DsbS37b39Y/fGDUbtKB+piyNrZi2rdAmM+BoC6Qk/rVEoEKeu4bgxJJf7uuQJqyFjmJXelllgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=W9YAU6A8; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=sOtO0r+u reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1752841262; x=1784377262;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LYqR1Vj+GNJnkS5SrzZmG8KF0PvTxGtYG00OqtCLfIQ=;
  b=W9YAU6A8P7JgccszNMiqO8nwx8o4aH7ngPy4QyJG1vS2ODsp27/IqoHK
   TxeQbUQUu4kJ7Hc8cZ0u3jdZIoTI27NZScePXelTgREqqnI8609fAaWcJ
   +50XsXg1S25449azlQHSjLbdTYQ81Rtyg5h9U36bjY8HWbVdCbQPjB/p0
   A3UzAwC5CAWkmk8d8lvjNx/PxnjevY+Zjvd5dQKxDmEyF1UKCo1msXXYA
   a8X8/QF8POYLTKIR2Hm28rCGzv6vRAuSMgdrwnuHRzMeRFZIlUc92VQTx
   a2+/he3MKGSm7X8P5cCnyFpcvrfxHpGPPCFuuwDeRHlHR2dyG7BPMkEWG
   A==;
X-CSE-ConnectionGUID: i+ecBaeCQBaf6F2avEtk4A==
X-CSE-MsgGUID: LtbreMkqTjKgvDnU0cjXJw==
X-IronPort-AV: E=Sophos;i="6.16,321,1744063200"; 
   d="scan'208";a="45293410"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 18 Jul 2025 14:20:58 +0200
X-CheckPoint: {687A3C2A-11-B2B90094-F6B7211E}
X-MAIL-CPID: EB40F6150FFE4CB7370BF32ABD4348BF_4
X-Control-Analysis: str=0001.0A00210E.687A3BB9.0077,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7E4B1611B1;
	Fri, 18 Jul 2025 14:20:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1752841254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LYqR1Vj+GNJnkS5SrzZmG8KF0PvTxGtYG00OqtCLfIQ=;
	b=sOtO0r+uzZWjNWCPCWMYzcZkojEwVsOCD7M0gO/0LjqTzEtdkjea3eaRTNnAQN+XpO8ek/
	qbKUqbcqyBtCfiARhDukH/aYEzgwBpovTR39fXXayBBwK4RMuIY4USMdwxSk/+wJUPnwig
	299vsTgASDDykun+uffJyO0VPpu/4ZNoKDMfmvTWIPLK/YWl3milfmtNHxp6OZDEH4mDKm
	QeQI/HNZw9+dkEHvyBLdGocsU/T8beMlrI9LVBzQwMklPUEml58slEz01w49Meptfl/Yd9
	ZB6+rn6xtM8xNz+P2d6CEK8+C3ofsqKR0xdnmplceWymI1spDU8VmYyNg2WpFw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] scripts/faddr2line: Use C locale for readelf
Date: Fri, 18 Jul 2025 14:20:51 +0200
Message-ID: <20250718122052.3787471-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

If readelf support localized output the following sed calls will fail
due to mismatched texts. Use C locale to get untranslated output.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 scripts/faddr2line | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 1fa6beef9f978..fbeb67903b792 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -107,7 +107,7 @@ find_dir_prefix() {
 
 run_readelf() {
 	local objfile=$1
-	local out=$(${READELF} --file-header --section-headers --symbols --wide $objfile)
+	local out=$(LANG=C ${READELF} --file-header --section-headers --symbols --wide $objfile)
 
 	# This assumes that readelf first prints the file header, then the section headers, then the symbols.
 	# Note: It seems that GNU readelf does not prefix section headers with the "There are X section headers"
-- 
2.43.0



Return-Path: <linux-kernel+bounces-866092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 281DFBFEDC0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97547351E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2F81A9F86;
	Thu, 23 Oct 2025 01:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqXHC4QN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69017157A5A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761183571; cv=none; b=pM4YLvH9pMqxnfi8VTGWVDjq014aHbTcUMGvqczvwJAoVY7qeHtHGfb8k8VInpkspfrnS96TQcQNSuJcXrdJT6gkrAuD2EcH/CAGYsspi83gEITKoNMp7uC3SLWR+60dzB2qIsxvr/0wnuYbpEwCsBKeytjMdLHraPUM49VkyH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761183571; c=relaxed/simple;
	bh=ID7WeQ/xofXhRycLlwnv+7sD4mbG/F6jCBiTliDjQFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qLVmMavyMvczc0RIuS41WwXtwrB3lVaHlNQoccQnpZ/sg6ND5ovBnxQnpikVMFBI/FGQaD65sgNNpRJsGhQDmLEPyZxjbMmcMirOmKlq8kzrtXhEwESDC3M2T/ltJjh3AgECL8hHJd+iGX/lMBSvxWTHrxDBSfjPbJdKWA7Vgr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqXHC4QN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBBF2C4CEE7;
	Thu, 23 Oct 2025 01:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761183570;
	bh=ID7WeQ/xofXhRycLlwnv+7sD4mbG/F6jCBiTliDjQFA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=qqXHC4QNRy0J8+G2q+XeeAT1VEHbA9dP1TDJQ6Y4ppDjwtzXKqRagoRV6iL5gNcQS
	 7wvOP+u7v4oYB+ugfpIo286s/lPzo1fdj1CFKI5edojWbzMwKyPQiWHCSGErgStbBL
	 bCu44iMI52rQPr6mriyMnxojvlqU8nEg/LbVhZA3QRzP29MCBgzOIpRMUJlqNOWFxx
	 cqTfASVuVDs330+MqFNWZc+6WNoAngQrIBxAwbwLJjX8PbLYVWit0B2ZAJdG7oz/wA
	 ke0kp2QuslzIj3r7ZOT6wWku9nSfFH8lhy6qL/FLFWhpNwYU46CVlxJtYh+AQanTrn
	 EYwpbLIOOucjQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC764CCD1BF;
	Thu, 23 Oct 2025 01:39:30 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Thu, 23 Oct 2025 09:39:17 +0800
Subject: [PATCH RESEND] checkpatch: Suppress warnings when Reported-by: is
 followed by Link:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-checkpatch-v1-1-ff73ed1027d6@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAESH+WgC/22OsQ7CIBiEX8X8sxigWoqTg10ddDQdgP4IMbYN1
 EbT9N2lHdXx7vLd3QgRg8cI+9UIAQcffdskwdYrME41NyS+Tho45TsqmSTGobl3qjeOUC5yUQj
 UViMkoAto/Wspu8K5vJSnI1TJdz72bXgvGwNb0n91AyOM1EUhpchkxq06PJv0pkfjNqZ9zAszx
 ij9xbSyFHO21TL/xqppmj5dtCzF5wAAAA==
X-Change-ID: 20250919-checkpatch-0276787ebfbe
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
 Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, niecheng1@uniontech.com, 
 zhanjun@uniontech.com, Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761183569; l=1707;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=vUU7NAqZP6AaVlvTisDIDk7HTxW7vXFFPAdlCDO/Azs=;
 b=WAagc3efadbxJTTEx4RaJF6M2dT0W0eMonzV5c9Ki6HtxvaM9/iNIfCSt1+l2lR3nFNdpP+ic
 NggAiWzaeiVCz/OgjPlmPcy0xnb0cblK0liQW+4s2s8WUHRlu+mdkze
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

> The tag should be followed by a Closes: tag pointing to the report,
> unless the report is not available on the web. The Link: tag can be
> used instead of Closes: if the patch fixes a part of the issue(s)
> being reported.

Accroding to Documentation/process/submitting-patches.rst , Link: is
also acceptable to followed a Reported-by:

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 92669904eecc..01c4e70b19a0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3205,10 +3205,10 @@ sub process {
 			if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {
 				if (!defined $lines[$linenr]) {
 					WARN("BAD_REPORTED_BY_LINK",
-					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . "\n");
-				} elsif ($rawlines[$linenr] !~ /^closes:\s*/i) {
+					     "Reported-by: should be immediately followed by Closes: or Link: with a URL to the report\n" . $herecurr . "\n");
+				} elsif ($rawlines[$linenr] !~ /^(closes|link):\s*/i) {
 					WARN("BAD_REPORTED_BY_LINK",
-					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
+					     "Reported-by: should be immediately followed by Closes: or Link: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
 				}
 			}
 		}

---
base-commit: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
change-id: 20250919-checkpatch-0276787ebfbe

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>




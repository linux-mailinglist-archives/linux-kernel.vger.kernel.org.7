Return-Path: <linux-kernel+bounces-824240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B800B887B5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F889587A03
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF922EC0A5;
	Fri, 19 Sep 2025 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSqfka2F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F21191F6A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272015; cv=none; b=anC+c5oz3qwRhk8sAsSHFw4J3Xgojr2OL85Szg/rgBxuxVi7lro5RdCRdZqW2yESxhx2+zPik+yJVSNWJm1NXgN1exyfCIyJCj38In5n6cgqEe+dghhx/59e/niTptGfIwbwJroFr4cyeEmhGV/NnRHUBSfl21QY3zrSXDA+6Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272015; c=relaxed/simple;
	bh=XfI+sGbTQXXVwK2LBxhz4Z0zlLXtyhsjoaXYurOGQzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qiPGPOzk5VWTtfM27PNcX0hy+LiJKYLD2aAVsA3dsy0DvYmo/ZuDDMAG8HYWWID3kfv1T8OLTQgXi2mbzsyoUQqzGZqPto/okz8T6lSt79yWsT9ljD5y1Nt0BEdYaVm9JnLSiQb/7YJdvH4PnEi5h+eeHeaHoxu+4ppjyWLKrI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSqfka2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30070C4CEF0;
	Fri, 19 Sep 2025 08:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758272015;
	bh=XfI+sGbTQXXVwK2LBxhz4Z0zlLXtyhsjoaXYurOGQzg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=MSqfka2FFNzAnjBDm+lB5wS09SwXHDws5uog21zLQXZjCTdxH6CrQdp1hFYDDsK2I
	 K6jcEd9ZYLq9lFYvGxQF9ZyR5sYfts6t8daKmAzvxCz+sVPix/PirgL2zXCSSW+BKd
	 E8Byz3dxT2KVWSwt9ssK3CM+z/TB0G/JPCrIct1kpfKQ6uNPuCrHTCje93b6XwDvYk
	 dHZyo1dTvJ4mNJXeIMB3YodVL9bm/PXrkso4C8/C6N3Sp+fU0x2smgIHxOI5ZMl8nu
	 IWVXaiFFVZxWj7MLHWkfTy50BfkU8RNhM9oKsMGhwSBmydiyoCRgGiq3vrmMPlrjOS
	 yuFjt8HM7IcNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB16CAC59A;
	Fri, 19 Sep 2025 08:53:35 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Fri, 19 Sep 2025 16:53:33 +0800
Subject: [PATCH] checkpatch: Suppress warnings when Reported-by: is
 followed by Link:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-checkpatch-v1-1-d889973932fa@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAAwazWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0NL3eSM1OTsgsSS5AxdAyNzM3ML89SktKRUJaCGgqLUtMwKsGHRsbW
 1AG4CVdhcAAAA
X-Change-ID: 20250919-checkpatch-0276787ebfbe
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
 Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, niecheng1@uniontech.com, 
 zhanjun@uniontech.com, Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758272014; l=1763;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=Iyk6yjBAdRxSTomegUDUJm0OiNce0KlYMkESMKoKGyk=;
 b=0hOu1V1/1ECrRUw2hyfnfh4IfkHPYcD+eTUzyG1iEzyK3LZ1oMmLtHteADCJYzSdoYKZxL+5D
 +OaR3TwnuivAu7rLi4UGKGxW5p+CaPRpF/POVW46nJpy1jpDrFyyc+w
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
index e722dd6fa8ef3d7062988e2b3ec8f5872bdfefeb..f09e3d0536d71d60184f15018202cc36a5f3832e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3200,10 +3200,10 @@ sub process {
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
base-commit: 097a6c336d0080725c626fda118ecfec448acd0f
change-id: 20250919-checkpatch-0276787ebfbe

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>




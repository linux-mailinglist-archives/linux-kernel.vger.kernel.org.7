Return-Path: <linux-kernel+bounces-800691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 033F1B43A96
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3487AF558
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1743E2FF156;
	Thu,  4 Sep 2025 11:44:20 +0000 (UTC)
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF9F2D7DDE;
	Thu,  4 Sep 2025 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986259; cv=pass; b=exCKj/R/uvi8VabLWGrH53rJSdNExh1FhIhQfUM3n3iKlndY4WD9bc4f+lF2Masvi6K0zglpCiKkfdQyfBKGub2aZlsNqF1BjB9sQvrIwivyBPbhqGUyCdvoeveKmDbiO/9QZfLvv1PG/RcsEmWs7qNtqFBwVXMpqGiDXIZNbD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986259; c=relaxed/simple;
	bh=lUZcPcdlTGGC6/ME1bzkDa1FnX6wyUh4jg5N6/vaCb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UZeDzcH0LmM6ZZZruyJ4fcdF4Eds58gQvYMQog1euYJ0AP0H01EzbNyBrVSk3+bYuv0Qp07P+Da5oBQ+mYq86hAtNthhbZXOi9Ht92EAt1BSoz/Ya6xqsZcllhwf0Zdd30ENB0c+szoDeQA+PvqkkJdOKOOaKqMgu5HgsuY8rJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=www.redadmin.org; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=www.redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 584Bi288054121
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 4 Sep 2025 20:44:03 +0900 (JST)
	(envelope-from redadmin@www.redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 0F6EA10AC3741;
	Thu,  4 Sep 2025 20:44:02 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fmcSEQ6wl1Xk; Thu,  4 Sep 2025 20:43:57 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 00C2610A42C03; Thu,  4 Sep 2025 20:43:56 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1756986237;
	cv=none; b=KqtIrNgT0KwNIn62r/jUWdjstT8MfrB8s5nt1At/4FJONXbSNA3jKqgr4iUUW1SFLhqmqSLR2kK+OCsM23Rr1dM7AcRvpRQoMR+/M/N8neiv8zXIwAJ81R4TctCaVPZxCSj7X2BLnXkcNABoUeR91ClYuwGK+E0PO34V09N7Xbk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1756986237; c=relaxed/relaxed;
	bh=vHbujjZ+EInbimvfDmNEuvFJ9WrP/PwQ6VBllN00vPg=;
	h=DKIM-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding; b=OTg9xU8STyV35RaKrYfPFyZADf5gMCDzho6LRNhTP38KksHAk8NP+SNApFb4zps0m2fWWskr1kVYcTd49w03wH00eaYIdsVuRNBiBN0GEIitEMcrBOwjxY6anchtqRfFmo+566wriljcXEQk23WPdBlgo7+9lrSAfhWevMtCx1M=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 00C2610A42C03
From: Akiyoshi Kurita <akito5623@gmail.com>
To: akiyks@gmail.com, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kurita <akito5623@gmail.com>
Subject: [PATCH] docs: ja_JP: Update SubmittingPatches based on commit 8401aa1f5997
Date: Thu,  4 Sep 2025 20:43:51 +0900
Message-ID: <20250904114354.2168571-1-akito5623@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: kurita <akito5623@gmail.com>

The Japanese translation of SubmittingPatches is outdated.

This patch adds the full description for the 'Fixes:' tag,
aligning the translation with the original English change
introduced in commit 8401aa1f5997 ("Documentation/SubmittingPatches:
describe the Fixes: tag").
---
 .../translations/ja_JP/SubmittingPatches      | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documentation/translations/ja_JP/SubmittingPatches
index 5334db471744..96f1d80dfcbd 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -132,6 +132,26 @@ http://savannah.nongnu.org/projects/quilt
        platform_set_drvdata(), but left the variable "dev" unused,
        delete it.
 
+特定のコミットのバグを修正するパッチの場合（例：``git bisect``で問題を発見した場合）、
+少なくともSHA-1 IDの最初の12文字と1行の要約を含む「Fixes:」タグを使用してください。 タグを複数行に分割しないでください。
+解析スクリプトを簡素化するため、タグは「75 文字で折り返す」ルールから除外されます。
+
+例:
+
+        Fixes: 54a4f0239f2e (「KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed」)
+
+以下の``git config``設定を使用すると、``git log``や``git show``コマンドで上記形式を
+出力する際にプレティフォーマットを追加できます::
+
+        [core]
+                abbrev = 12
+        [pretty]
+                fixes = Fixes: %h (\「%s\」)
+
+呼び出し例:
+
+        $ git log -1 --pretty=fixes 54a4f0239f2e
+        Fixes: 54a4f0239f2e (「KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed」)..
 
 3) パッチの分割
 
@@ -465,6 +485,10 @@ Suggested-by: タグは、パッチのアイデアがその人からの提案に
 クレジットしていけば、望むらくはその人たちが将来別の機会に再度力を貸す気に
 なってくれるかもしれません。
 
+パッチが特定のコミットのバグを修正するものである場合、
+（例えば、``git bisect`` を使用して問題を発見した場合など）、
+SHA-1 ID の最初の 12 文字以上と 1 行の要約を含む「Fixes:」タグを使用してください。
+
 15) 標準的なパッチのフォーマット
 
 標準的なパッチのサブジェクトは以下のとおりです。
-- 
2.47.3



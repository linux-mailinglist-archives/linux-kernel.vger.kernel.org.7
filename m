Return-Path: <linux-kernel+bounces-801106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC5CB43FF0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1827E7A5E1E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863AE305076;
	Thu,  4 Sep 2025 15:04:20 +0000 (UTC)
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92E41EEA55;
	Thu,  4 Sep 2025 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998259; cv=pass; b=XvMVcNr1WQoVRNagZUnvzT3e9OkLIUrtKaNO2ZMzHbcGlEGd7I3MT6w0RnuEKZpY6A1LzvDIX0Kc7bngszk1B8umOYDFmte51rie+DlPe3sUWQbGx0kretTcwVRxeuUW+MJQZo9xdY15ANiooDZ0PozQTp24C85/KxLTkVCbQEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998259; c=relaxed/simple;
	bh=fXjmXApdta2Kyv2P/xEHgPcIfDQGwAADTQ3edjb3xgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pb+GLegOar2DrGPxCAgfsmjHtZLUjkIidpxOMoVYRm9JDwle7Lps/WTPnexIZveZr4X0I+pCgS1BrwP0CLvr8KLjhPoiqE2GaoyVX3GzmOTiOVlOO7GIUYfmIzoVFj/y0WLYBAeG89HljK3U8lbq61Kwi4a94oUW5pl4vpLToS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=www.redadmin.org; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=www.redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 584F45f8086959
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 5 Sep 2025 00:04:06 +0900 (JST)
	(envelope-from redadmin@www.redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 563D2120D0338;
	Fri,  5 Sep 2025 00:04:05 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iv5458NzC5Z1; Fri,  5 Sep 2025 00:04:00 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 7D46710090E9F; Fri,  5 Sep 2025 00:04:00 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1756998240;
	cv=none; b=RTyLz8CivWK2S7At8SKcjqaFlo+2lHKZxwJ878aijAJmPPn+WHVt3bfwHHC5LbxNy0CLn+3idT/gSwlx5WL65o5buHkq15pvNihKEZOfIIBs2aGHqqTjftiNuqfvy5Nu7zte7X8grCkLw4tb/XIZqRVfc9PwFAzMhhcxhiWNkgA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1756998240; c=relaxed/relaxed;
	bh=xDIBSCqwlIP7Owq3BiZIYJwkol5FMer8Li/1yJKa0Dg=;
	h=DKIM-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding; b=hTzofiUOhjAIiKemRARw4cVGlD1QOm9JJHaj9T6s3EATaJPaQqCMz55VHUkWXKVj2TmmFs5VBGzdIeMPK8z90cs3roqiDa4o3rumWtpRo5mKsKvB/7AL6hs5HQsMCNaZs6F/WOZY3SQSaMUvuMcO5jUl3wNEGaFP1PNGrGzglVk=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 7D46710090E9F
From: Akiyoshi Kurita <akito5623@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akiyoshi Kurita <akito5623@gmail.com>
Subject: [PATCH] docs: ja_JP: add guidance for the Fixes: tag in SubmittingPatches
Date: Fri,  5 Sep 2025 00:03:55 +0900
Message-ID: <20250904150357.2191615-1-akito5623@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Japanese translation of SubmittingPatches was missing the section
describing the use of the 'Fixes:' tag. This patch adds the missing
description, aligning the translation with commit 8401aa1f5997
("Documentation/SubmittingPatches: describe the Fixes: tag") in the
English version.

Signed-off-by: Akiyoshi Kurita <akito5623@gmail.com>
---
 .../translations/ja_JP/SubmittingPatches      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documentation/translations/ja_JP/SubmittingPatches
index 5334db471744..28ad83171252 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -132,6 +132,27 @@ http://savannah.nongnu.org/projects/quilt
        platform_set_drvdata(), but left the variable "dev" unused,
        delete it.
 
+特定のコミットのバグを修正するパッチの場合（例：``git bisect``で問題を発見した場合）、
+少なくとも SHA-1 ID の最初の 12 文字と 1 行の要約を記載した「Fixes:」タグを使用してください。
+タグを複数行に分割しないでください。解析スクリプトを簡素化するため、タグは
+「75 文字で折り返す」ルールから除外されます。
+
+例:
+
+        Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
+
+以下の ``git config`` 設定を使用すると、``git log`` や ``git show`` コマンドで
+上記形式を出力する際にプリティフォーマットを追加できます::
+
+        [core]
+                abbrev = 12
+        [pretty]
+                fixes = Fixes: %h (\"%s\")
+
+呼び出し例::
+
+        $ git log -1 --pretty=fixes 54a4f0239f2e
+        Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
 
 3) パッチの分割
 
-- 
2.47.3



Return-Path: <linux-kernel+bounces-798526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F6FB41F33
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1688C163F21
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028142FD7BD;
	Wed,  3 Sep 2025 12:38:00 +0000 (UTC)
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0DA2FE05D;
	Wed,  3 Sep 2025 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903077; cv=pass; b=L/qGw1ZPjhqlMtPFSfcowmNpsTAGHqG2FtUd0ubs5UX/jqUQojtNgeKMPnsjWPOjq/atTymhwjflk7ly5w2hQYBgFq9gMGd4cYISElWGZn8BQF7U5ieA3JxPTp0fsaVPVO4nIYJQxuELxh+ropBGI4Vi2a7Pyk4Yq+V6Qa5DXiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903077; c=relaxed/simple;
	bh=H/otOwUy0OHUNvf1VSleLffLfqgSJL6wUY6ydR/+z6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=taWIH0/8z2uliCSG4Ael7ELqsNMf7jqO+y29t+Jg6bGlPZNRdcnY/opN4kPj3pM0oiiyfN5syQ6bI57B+ip7wTkEIw/Rbhb9CtTb5iayNoypvZUE5FkYvdlNv+WvRrk+l7qHkC1QIPbeStVF84/ja7L7GF1T5P0njgGxQcT3Y0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=www.redadmin.org; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=www.redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 583Bal6x076440
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Sep 2025 20:36:48 +0900 (JST)
	(envelope-from redadmin@www.redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 4D9F2101CD3C4;
	Wed,  3 Sep 2025 20:36:47 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BLVdbuqqFbXg; Wed,  3 Sep 2025 20:36:43 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 8CBC1101F9E41; Wed,  3 Sep 2025 20:36:43 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1756899403;
	cv=none; b=EXR5yaEaJ1xiEFi9mEr96F5Z6lwaDvUT58mh393sJGjCG3WP1Kle/R0irv37dpkRFimK11nsqtOt70WjjZ31NBM67mtdXYTci8NQQvtNB7qohwAMdxemgo+IqUplunmRDS2ddrNth8I3Xz0hY9kyZZEZhKOUxvg3rsdpTnaJm5I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1756899403; c=relaxed/relaxed;
	bh=wRRiNP2Y6syL5RS/IEk/uM4Bpul5jZD1euUB9Y8mJLk=;
	h=DKIM-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding; b=JsJmaSwYmOe4yGJJsDSrTfeRXYkanx+puPGNcKD5YNq/px28U944IoPfUstmEXB8lmaRYDIw7Hpg+RW7CNgdIXytBVl0cDGke0I5AgWxFYrOgtMVAgyeHiqXwm2tpPiJKPWOtU/OUSfE9cx+7R6h2/IV9dge9ll7NxCI6EP/7ws=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 8CBC1101F9E41
From: kurita <akito5623@gmail.com>
To: linux-doc@vger.kernel.org
Cc: akiyks@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        kurita <akito5623@gmail.com>
Subject: [PATCH] docs: ja_JP: Update SubmittingPatches for 'Fixes:' tag
Date: Wed,  3 Sep 2025 20:35:04 +0900
Message-ID: <20250903113552.2010371-1-akito5623@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Japanese translation of SubmittingPatches is based on an old
kernel version (2.6.39) and is missing several new sections.

This patch adds the missing description for the 'Fixes:' tag to
bring the document more in line with the current English original
(Documentation/process/submitting-patches.rst).

Signed-off-by:Akiyoshi kurita <akito5623@gmail.com>
---
 Documentation/translations/ja_JP/SubmittingPatches | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documentation/translations/ja_JP/SubmittingPatches
index 5334db471744..053468a20841 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -465,6 +465,10 @@ Suggested-by: タグは、パッチのアイデアがその人からの提案に
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



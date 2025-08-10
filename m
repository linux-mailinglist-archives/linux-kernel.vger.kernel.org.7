Return-Path: <linux-kernel+bounces-761320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AE6B1F86D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094A83BDD14
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 05:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDEA1E25EF;
	Sun, 10 Aug 2025 05:10:47 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F601DED53
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754802647; cv=none; b=aSUqdvmaczOvef8t+apH9WOh4qh7shfGDY53xYNSUgPaw39rOelcdV5DYpCaSYvjg8zEk733HdINx92h3ICFU+OLghPU62NzZsz7uzu+W7JnhCD0U8if6nPodZpAdv/wyXtQpcBHrzonEEIewEJmVQnyfiTNTkncZWSHggax8eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754802647; c=relaxed/simple;
	bh=9FSnWZN21YBaLFde2pnRBLG+oERfvF97uAXbcUTYclc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FNgCAzYk2ryFeWOu0I4SlronxsYgDzsnfNdWQd9c2HccIrAaswG5vEtBH685t/wfZc+dn/rp95QRXaHJfrwjj5FM4xZu7EOYspt/JrkXRzi+2B1V40lYWKg8bZOtc+D5GcXPBaVXZsMbAg5Knzb2ocak3zFJyy+Vdd733JHlFzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id ED52E1A020F;
	Sun, 10 Aug 2025 04:31:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 1447D20026;
	Sun, 10 Aug 2025 04:31:10 +0000 (UTC)
Message-ID: <3529faaf84a5a9a96c5c0ec4183ae0ba6e97673c.camel@perches.com>
Subject: [PATCH] checkpatch: Allow http links of any length in commit logs
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, "Dr. David Alan Gilbert"
 <linux@treblig.org>
Date: Sat, 09 Aug 2025 21:31:10 -0700
In-Reply-To: <20250625133258.78133-1-linux@treblig.org>
References: <20250625133258.78133-1-linux@treblig.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: fp5fkhrmegpkf1weaonz3fx3di3c6nfh
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 1447D20026
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/X5t25Ga1iS4apkFpLbuQip8RajIgvE3Q=
X-HE-Tag: 1754800270-74814
X-HE-Meta: U2FsdGVkX1/szqzOwoD0gQJmrivfztLfifPFk3qG99c6V9b7JDLAOA0g0ga6PjzsUpX8XWQMgftQQMeJQDaw76PTyi/W2L2PScm7ocvE1btyLj+DRzmSnPwCpMPc8IDPS67FtQXdle1WxHECIkXEArIrUZp2aZ9BARxL0wpanRdK8UwpWAGBTmuJrnU/y6e5sqPVJVORLk6OtmHo9c5Mv3KpXpA381ZK+8tPY5Ihz36MJn37rqYZbZZ564wvTt9ZQUsSrrxn6ZQDK/zfsl0Myv4EzQka47DLB2rwGFRq2J03d3pWwfGoNYXHS7dMsLun7rC07OWdnMkAdGpLeSDReMG87F9uH/sEawajwx+mA+1dzYlE/3irEvjZV3ECftZW

Dave Gilbert noticed that checkpatch warns about URL links
over 75 chars in length in commit logs.

Fix that.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa8ef3..319cc5f858858 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3294,7 +3294,7 @@ sub process {
 					# file delta changes
 		      $line =3D~ /^\s*(?:[\w\.\-\+]*\/)++[\w\.\-\+]+:/ ||
 					# filename then :
-		      $line =3D~ /^\s*(?:Fixes:|$link_tags_search|$signature_tags)/i ||
+		      $line =3D~ /^\s*(?:Fixes:|https?:|$link_tags_search|$signature_tag=
s)/i ||
 					# A Fixes:, link or signature tag line
 		      $commit_log_possible_stack_dump)) {
 			WARN("COMMIT_LOG_LONG_LINE",



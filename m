Return-Path: <linux-kernel+bounces-778660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F9AB2E896
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DB55E5ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123C82DD608;
	Wed, 20 Aug 2025 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkRyZ4g1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D182BE64E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755732030; cv=none; b=EFQDIK3dKa530OlwJ7e9R8hJbfuQY688cmLUP1nSawyktSrz0ZRl2pK6XLj7Pf5YTHSKCN7v8kLuSg+pF/0AB0tJ26A4+7I9aKtcoKVIFnXWu0s6HWqck5BqDlOgbF0UJ8Dn4wM4SmkBl2tn9kO6/YEzakDwbuJO9PWygJY0hVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755732030; c=relaxed/simple;
	bh=981PijKZtDiMAhozy68AvAHr5RNkUu9IEPcjTFnfrNc=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=sFC6XH1wL+MbUpaIW/TvPtzMVvSofyXeidx3kunqAzFgF60BsL4rd0MceQxgi1G5+k1sUdPuziAPDGt2cLkdSdVxherK+C5vOWUNAxWaYGAd2htPIsK5DDJQTd4Oeg9MHLzAS1hurZEw2atfYkZED3rxZnGvsC7OBA5bRwSS2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkRyZ4g1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8FBC4CEE7;
	Wed, 20 Aug 2025 23:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755732030;
	bh=981PijKZtDiMAhozy68AvAHr5RNkUu9IEPcjTFnfrNc=;
	h=Date:From:To:Cc:Subject:From;
	b=JkRyZ4g1rqWaRXhxzEI9BXB2LvfF5pdtIeUEAm+L8zxxHluO/vXP16dcZW6llnT9P
	 VMUTgl8H/CmvYUJlj4iUMEftGYYh9V2Agk7v+alO9S3l4MwvlSubmmFKqIyXWLPZLj
	 lNBKQFqVsiF9EzMQ8ImAGkWaNe4EcjR6RoUjmv/I3FBBIORos4LBvCNcyL2Kr1JMF5
	 CADe/N4SvBFfNCiEaNKZivSf/hXt6cvVcBqKvq+oYTvi7nP19IiwEAfnydAWKy7XaY
	 Wd1LRGEvb/Jzm02hcIYdxjjULfIMG1fFHeXaK46MlXbQ/PB4Xf5A/9Plk2udVXCfCv
	 VMjqzUZOjm1Dw==
Date: Thu, 21 Aug 2025 08:20:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ben Hutchings <benh@debian.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] bootconfig: Fixes for v6.17-rc2
Message-Id: <20250821082026.9fbbfeaf2952437514b29dc8@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Bootconfig fixes for v6.17-rc2:

- bootconfig: Fix negative seeks on 32-bit with LFS enabled
  On 32bit architecture, -BOOTCONFIG_FOOTER_SIZE (size_t, 32bit)
  becomes a positive value when it is passed to lseek() because it
  is casted to off_t (64bit). Thus, add type casts.


Please pull the latest bootconfig-fixes-v6.17-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
bootconfig-fixes-v6.17-rc2

Tag SHA1: abef3dc0b6727f3ce96b51349ca15ff5d3e5d7d6
Head SHA1: 729dc340a4ed1267774fc8518284e976e2210bdc


Ben Hutchings (1):
      bootconfig: Fix negative seeks on 32-bit with LFS enabled

----
 tools/bootconfig/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---------------------------
commit 729dc340a4ed1267774fc8518284e976e2210bdc
Author: Ben Hutchings <benh@debian.org>
Date:   Sun Aug 17 16:21:46 2025 +0200

    bootconfig: Fix negative seeks on 32-bit with LFS enabled
    
    Commit 26dda5769509 "tools/bootconfig: Cleanup bootconfig footer size
    calculations" replaced some expressions of type int with the
    BOOTCONFIG_FOOTER_SIZE macro, which expands to an expression of type
    size_t, which is unsigned.
    
    On 32-bit architectures with LFS enabled (i.e. off_t is 64-bit), the
    seek offset of -BOOTCONFIG_FOOTER_SIZE now turns into a positive
    value.
    
    Fix this by casting the size to off_t before negating it.
    
    Just in case someone changes BOOTCONFIG_MAGIC_LEN to have type size_t
    later, do the same thing to the seek offset of -BOOTCONFIG_MAGIC_LEN.
    
    Link: https://lore.kernel.org/all/aKHlevxeg6Y7UQrz@decadent.org.uk/
    
    Fixes: 26dda5769509 ("tools/bootconfig: Cleanup bootconfig footer size calculations")
    Signed-off-by: Ben Hutchings <benh@debian.org>
    Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 57c669d2aa90..55d59ed507d5 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -193,7 +193,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	if (stat.st_size < BOOTCONFIG_FOOTER_SIZE)
 		return 0;
 
-	if (lseek(fd, -BOOTCONFIG_MAGIC_LEN, SEEK_END) < 0)
+	if (lseek(fd, -(off_t)BOOTCONFIG_MAGIC_LEN, SEEK_END) < 0)
 		return pr_errno("Failed to lseek for magic", -errno);
 
 	if (read(fd, magic, BOOTCONFIG_MAGIC_LEN) < 0)
@@ -203,7 +203,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	if (memcmp(magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN) != 0)
 		return 0;
 
-	if (lseek(fd, -BOOTCONFIG_FOOTER_SIZE, SEEK_END) < 0)
+	if (lseek(fd, -(off_t)BOOTCONFIG_FOOTER_SIZE, SEEK_END) < 0)
 		return pr_errno("Failed to lseek for size", -errno);
 
 	if (read(fd, &size, sizeof(uint32_t)) < 0)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


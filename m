Return-Path: <linux-kernel+bounces-860847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD5FBF129C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C373AC612
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBADC3043C4;
	Mon, 20 Oct 2025 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8bY6jYk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9902FD7B2
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963055; cv=none; b=ThnxDB9RSRp9s7vW0oSIvsZo7Wgo2PabfmBEYFF3LOxTp6O72QWynH5uCPZuvhwefRnI3YbOZOBD9esQEdHmLIj9AsIJvik9wTYMMDcGXZlRbkCk0jhfIXfSc/qNfV/xLRqSmYWCKICnJpG9pnP+pbcVU9sK3/d9TKcw1702Zqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963055; c=relaxed/simple;
	bh=mH3CUjCa3UA19vahxRrEhK4NqI3c1fZ/mFBri1gMdw0=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=qrD/eAF5bgfKxoH+6hpt32PZ88xZA1Ir1p9FMyDVCCds8CxY2bpNY7HDG1yG9c7227zaB1lLBR+d87Hgdckw5ejjyhfRdGOU16SmQT/GripOxQWnTUNO3K7KFZE8VkaHsWPs6it4cgy7irN6eXhT52h02ZnKnxOy0G0PLSvF3No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8bY6jYk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760963052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=VgBH8h68WmMdAHIwW/F7a62GMtY3b1uSIqK/HOd6rCg=;
	b=F8bY6jYkVO+teZJ24DgFTHgXtuXaQXM8HTlbO86x+/V4I9PjYT0We01WoY0znn0UH+GXHO
	2eZC9cF49NJf9mRcji7/hMkxC0FJKh27EdUy4TKpPbONc8f35WLfFGGalpD6IYNuwSQAml
	h3eVSt3gTv1MmEVC6Rq1caMBPn/2tX0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-8CyppFzIOUOCL38uVPBmoA-1; Mon,
 20 Oct 2025 08:24:08 -0400
X-MC-Unique: 8CyppFzIOUOCL38uVPBmoA-1
X-Mimecast-MFC-AGG-ID: 8CyppFzIOUOCL38uVPBmoA_1760963047
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D0981800245;
	Mon, 20 Oct 2025 12:24:07 +0000 (UTC)
Received: from [10.44.32.107] (unknown [10.44.32.107])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FCC03000229;
	Mon, 20 Oct 2025 12:24:04 +0000 (UTC)
Date: Mon, 20 Oct 2025 14:23:58 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
cc: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
    Josh Poimboeuf <jpoimboe@kernel.org>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] objtool: fix failure when being compiled on x32 system
Message-ID: <1ac32fff-2e67-5155-f570-69aad5bf5412@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811712-800153720-1760386865=:3464022"
Content-ID: <1930340f-cc1b-83f3-e76c-2269b800a8e8@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811712-800153720-1760386865=:3464022
Content-Type: text/plain; CHARSET=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Content-ID: <d074a068-ef97-7960-32d3-7a53cc90c0e5@redhat.com>

Fix compilation failure when compiling the kernel with the x32 toolchain.

In file included from check.c:16:
check.c: In function ¡check_abs_references¢:
/usr/src/git/linux-2.6/tools/objtool/include/objtool/warn.h:47:17: error: format ¡%lx¢ expects argument of type ¡long unsigned int¢, but argument 7 has type ¡u64¢ {aka ¡long
long unsigned int¢} [-Werror=format=]
   47 |                 "%s%s%s: objtool" extra ": " format "\n",               \
      |                 ^~~~~~~~~~~~~~~~~
/usr/src/git/linux-2.6/tools/objtool/include/objtool/warn.h:54:9: note: in expansion of macro ¡___WARN¢
   54 |         ___WARN(severity, "", format, ##__VA_ARGS__)
      |         ^~~~~~~
/usr/src/git/linux-2.6/tools/objtool/include/objtool/warn.h:74:27: note: in expansion of macro ¡__WARN¢
   74 | #define WARN(format, ...) __WARN(WARN_STR, format, ##__VA_ARGS__)
      |                           ^~~~~~
check.c:4713:33: note: in expansion of macro ¡WARN¢
 4713 |                                 WARN("section %s has absolute relocation at offset 0x%lx",
      |                                 ^~~~

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 0d6e4563fc03 ("objtool: Add action to check for absence of absolute relocations")

---
 tools/objtool/check.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/tools/objtool/check.c
===================================================================
--- linux-2.6.orig/tools/objtool/check.c	2025-10-13 21:42:48.000000000 +0200
+++ linux-2.6/tools/objtool/check.c	2025-10-13 21:48:33.000000000 +0200
@@ -4710,8 +4710,8 @@ static int check_abs_references(struct o
 
 		for_each_reloc(sec->rsec, reloc) {
 			if (arch_absolute_reloc(file->elf, reloc)) {
-				WARN("section %s has absolute relocation at offset 0x%lx",
-				     sec->name, reloc_offset(reloc));
+				WARN("section %s has absolute relocation at offset 0x%llx",
+				     sec->name, (unsigned long long)reloc_offset(reloc));
 				ret++;
 			}
 		}
---1463811712-800153720-1760386865=:3464022--



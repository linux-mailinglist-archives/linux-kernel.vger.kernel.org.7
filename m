Return-Path: <linux-kernel+bounces-793546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8F4B3D4FF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 21:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399003BD766
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 19:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82EF224AFA;
	Sun, 31 Aug 2025 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T4R8Q8dG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0EB1F37D4
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756668868; cv=none; b=CxNqT0DrS3yd+lGs5IiAXveUi+gEHpt6/TvpKCY+NC8Upo6FNyRutgfhtxcCBmw8qncG557/kEC0a0nr0rAtiCQYe4igy4Z7VYo7sWbxsAcDQm8A4e6qoAxU7Rbd+iO8onkGAuErxQyxl3k8OksgYsaWaEcmcw+rU+HE3EJZIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756668868; c=relaxed/simple;
	bh=sJmdTCCbtiT1DW26qBy6SEwGQBpDJbkjKYDcCD3ZiuE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=neXui8mGPPeiRCIV3O4hFcVnfep4+uGYugaql/LAr+nCYFrrB1II4EJCEBtyvMktJwfLU3r/W8mM/pZWXLCtA2cghOyVV9JQwp/fnsn4SwIOxUfow679yQJ0iGQIStbnwtVGNIDZ/p5gS2MmuEd6njl3dOzQl2CbFjNWBUJqFBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T4R8Q8dG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1BBC4CEED;
	Sun, 31 Aug 2025 19:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756668867;
	bh=sJmdTCCbtiT1DW26qBy6SEwGQBpDJbkjKYDcCD3ZiuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T4R8Q8dGwblsf+2ThAPyIuYBcyGkPZLoISXWArHmyzYuGcW0kJj8JM/BgXYGtmRCX
	 TWlenIN1eDcQEwvUfb8sWbjiLHbwDWMk+0eDNpwnHXKyUjlmJYop94iCA1FceDj5g6
	 1ZUWwK8S+WiFwCf5XlxG6OREwRfpv7XaeXeedwps=
Date: Sun, 31 Aug 2025 12:34:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/memfd: remove redundant casts
Message-Id: <20250831123426.3ce56a2448b520aba75f8edc@linux-foundation.org>
In-Reply-To: <efbbe6093b64a5b19f974871d5262d6e75dff2c0.1756639225.git.joeypabalinas@gmail.com>
References: <efbbe6093b64a5b19f974871d5262d6e75dff2c0.1756639225.git.joeypabalinas@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Aug 2025 01:47:48 -1000 Joey Pabalinas <joeypabalinas@gmail.com> wrote:

> MFD_ALL_FLAGS is already an unsigned int. Remove redundant casts to
> unsigned int.

lgtm.

It's rather annoying that the MFD_ALL_FLAGS definition is so far away
from the other MFD_* definitions.  What do peope think of this little
cleanup?

From: Andrew Morton <akpm@linux-foundation.org>
Subject: memfd: move MFD_ALL_FLAGS definition to memfd.h
Date: Sun Aug 31 12:29:57 PM PDT 2025

It's not part of the UAPI, but putting it here is better from a
maintainability POV.

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/uapi/linux/memfd.h |    2 ++
 mm/memfd.c                 |    2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/mm/memfd.c~memfd-move-mfd_all_flags-definition-to-memfdh
+++ a/mm/memfd.c
@@ -313,8 +313,6 @@ long memfd_fcntl(struct file *file, unsi
 #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
 #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
 
-#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEXEC_SEAL | MFD_EXEC)
-
 static int check_sysctl_memfd_noexec(unsigned int *flags)
 {
 #ifdef CONFIG_SYSCTL
--- a/include/uapi/linux/memfd.h~memfd-move-mfd_all_flags-definition-to-memfdh
+++ a/include/uapi/linux/memfd.h
@@ -12,6 +12,8 @@
 #define MFD_NOEXEC_SEAL		0x0008U
 /* executable */
 #define MFD_EXEC		0x0010U
+#define MFD_ALL_FLAGS		(MFD_CLOEXEC | MFD_ALLOW_SEALING | \
+				 MFD_HUGETLB | MFD_NOEXEC_SEAL | MFD_EXEC)
 
 /*
  * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
_



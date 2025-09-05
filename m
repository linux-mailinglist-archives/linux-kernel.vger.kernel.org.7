Return-Path: <linux-kernel+bounces-802508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16B7B452F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8BF1765A4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AA6288C16;
	Fri,  5 Sep 2025 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH2fU4i+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A727288C12
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063764; cv=none; b=P1dD5PQYpG2uAwdKVgw1h7mQuQpNmdBDslm+jQ5/gJSKcfjmAAzqdoklidUpuI5YvITfm9v47xKxG18BsYujAjRUjwXfE+lG7caXtrtwqabB0luuyLcYJnauXPFrJHX8g/jg784BGf8BgJV37uSPuISYNWM/hFRXlx30nRjDz54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063764; c=relaxed/simple;
	bh=1IU8iNPFjdRTUgrA68VBqcClGn/H7DOAUdL3G8nHiEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NcR/172kGcvOQ3PASZCNcaDmLrO4+QCHfcV5zNQWq5U0zFevmeDrw3/7J/Sl9I4dpYnfbK5hUjuAsR6RHnj+odi2/tVZnhtjC8Ka2JNUcQealS4DjbfvyQp43JNRMlqoe/qOCu3nqqW6pAxuEKvjajbKSwyoAgxPDM9ByS5UsBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RH2fU4i+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B41C4CEF1;
	Fri,  5 Sep 2025 09:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757063764;
	bh=1IU8iNPFjdRTUgrA68VBqcClGn/H7DOAUdL3G8nHiEs=;
	h=From:To:Cc:Subject:Date:From;
	b=RH2fU4i+rv4uBB1kpIVm1bYvJqfpTgq1mvrYU17shyK6Sf2Z/EyJSai2etoAfntXT
	 hYhnnQrCjBFh4uy4CmvjyrKy/gYiLSVchS5LsY+OQDGcpxuDanY37txyCDlJPr3/Ha
	 yBZidrkmtw24376FgGbffA0fdBEAco4DoiiG5nM0ikvCx6LbXMq3aIq0ct4Qje6B8B
	 7qHS7n7pEPt7oe7ZY3RVmmSpAYl2TvRVNv5d2hqXk4xLmSWXRYZZWQABTa2GQuFJtq
	 dZAhk0mvbwItXTPYVSr3VdGyPVZLcdcms6GWDIH8cGJSRhbWJtF5SV3Iy9FFu/Xlx6
	 jKqtgtZVFW4Xg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] MAINTAINERS: add tree entry to numa memblocks and emulation block
Date: Fri,  5 Sep 2025 12:15:57 +0300
Message-ID: <20250905091557.3529937-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6dcfbd11efef..fbdbf7c012a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16127,6 +16127,7 @@ M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Mike Rapoport <rppt@kernel.org>
 L:	linux-mm@kvack.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git
 F:	include/linux/numa_memblks.h
 F:	mm/numa.c
 F:	mm/numa_emulation.c
-- 
2.50.1



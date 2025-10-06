Return-Path: <linux-kernel+bounces-843087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C13C3BBE622
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A148348B55
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B001A9F80;
	Mon,  6 Oct 2025 14:45:50 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E1E34BA3B
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761950; cv=none; b=WkN+Hhw2wLACb2gocyfaGaJX7AvV9fv7gPL3NyxMRDz6HfOqwD7sY7oCaALir+ED+rHOxwmJkmL9OXSOlZhLN+a2dLOzaZqxmiJ3A4GTagrvvgQ4/BQpPOsLQxNjKAzhTUYIRssNJYN3MEptd/jw1mP5EsfFydIHJiPeDHvrTzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761950; c=relaxed/simple;
	bh=1cWLkjQBIyzBO9VwDTj/MknGMn1ZpDGxL/Euov0VlYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwI8BAWxhIH4K42ONb0+Zndy1KnFDOB9KhEgGq4xmm2PSZ115o432ZyuGLG8Q4KT0QIWPW5YkZmJd7DYlKBXg4lnoj2WXKbLcSf2f50+Ryrub8mi0HjQaYUdiA874FVc5U4hY3JM+8lrJAsWq8NlOnvGoP6IsIBYoebWvEndaBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e6c8bc46eso32649795e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759761947; x=1760366747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbi97d0rrEhXFPx9xb8HNtK7TcQbHRpYHFxMYmusqFU=;
        b=nXnZWhY+AoJbZ1L6iU3LMBGbd2pbyM9S6iHJLjD09EHIqLGO1hxhsfEl7r1pq11A6C
         AuY/qtwJXcRgtQz3S7UeTHqY9liRi1mOZd3wFFQHmhYBjBXT1bjV2pVazJny+U3UZIfN
         l9fcMQ3AaAuUXhg/NNdj8bOBevkLs0t6QaKGL6wggHvHffHG///Zrfxa0YfhnbGk7uvM
         eCug3f49gde87jbcCZH3GBD6ZZUEJc+uDeXTnN76nx6CK7nlKt4YthnXgO6igFj8Bs8Q
         +qajpgpt3DvcjJrNRonCCsJer8a26raApkd1CLxCzIsRKdFujNkA27M01g4gVJscKn30
         Q+nA==
X-Forwarded-Encrypted: i=1; AJvYcCWXVUzLOVUxt+jAOyAzsHdP02P6mm1Mf6M8NkhjHq68QPQHGoSEnDjz7d5fw6FK6dkd59sFaT/5NkEmpHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaoSQlAu3pL4hUflUixrPSgYnKkIqWoi62r8qVhgIYnGo20mZm
	dfDSg+drUtWK7qGp3rC0x+L8pqswcanb1e4iNi/RQD74QDPgiAES9W7g
X-Gm-Gg: ASbGncu9mTG4D4YXcEMjmSu693KmxtYqEo0pwcoo+BaozCZd8/MM2gnZtJir3MIWBVY
	K+7om8Gf/X5vP4zcZ6v6B5/ofgK6RYEkkwh1vSSnmwjJfcpvpKky2UmyJizqcGGkaY4+cRonJtI
	DmWq61r32xy5g3IM4gbDrukj10BoISi1ooabIP/wFBDR4cMtPEk/DVcQ7pLJPcz1w705IwkWVUB
	yysWutJsCT8ko88h7pDCbVnWFrvpUlx1eSSF4SnKQuezMrRZLLoIDkPaRQ3NpJJ+VUy3Myf4/Qq
	u1NXV18AgpoLD2jqQlLeUA5dtpuzvpEWwDchwfXQJBhSTXyPuUBv2WHX33txmnULInEaUtDPFUT
	PHpxp20GSyo4d4wB99tt2e5ATY3GKRmzqDP/T3iCpOtCVfABbWA==
X-Google-Smtp-Source: AGHT+IGSXg4krW88X25pKMdWNSxrnvZTh6Q/uva3k1hELeEzxn4ObqIjdy8xV6ZqzGYl24DrHHt6Xw==
X-Received: by 2002:a05:6000:2407:b0:3e4:5717:368e with SMTP id ffacd0b85a97d-4256712a5d1mr8126669f8f.2.1759761946831;
        Mon, 06 Oct 2025 07:45:46 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::301b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab8b0sm21242624f8f.18.2025.10.06.07.45.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Oct 2025 07:45:46 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	ioworker0@gmail.com,
	richard.weiyang@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-new v2 0/3] mm/khugepaged: refactor and merge PTE scanning logic
Date: Mon,  6 Oct 2025 22:43:35 +0800
Message-ID: <20251006144338.96519-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series cleans up the almost-duplicated PTE scanning logic in the
collapse path.

The first one is a preparatory step that refactors both loops to use
a single if-else-if-else-if chain for checking disjoint PTEs.

The second one replaces VM_BUG_ON_FOLIO() with a more graceful
VM_WARN_ON_FOLIO() for handling non-anonymous folios.

The last one then extracts the common logic into a shared helper.

Thanks,
Lance

---
v1 -> v2:
- #01 Update the changelog (per Dev)
- #01 Collect Reviewed-by from Wei, Dev and Zi - thanks!
- #03 Make more of the scanning logic common between scan_pmd() and
      _isolate() (per Dev)
- https://lore.kernel.org/linux-mm/20251002073255.14867-1-lance.yang@linux.dev

Lance Yang (3):
  mm/khugepaged: optimize PTE scanning with if-else-if-else-if chain
  mm/khugepaged: use VM_WARN_ON_FOLIO instead of VM_BUG_ON_FOLIO for
    non-anon folios
  mm/khugepaged: merge PTE scanning logic into a new helper

 mm/khugepaged.c | 243 ++++++++++++++++++++++++++----------------------
 1 file changed, 131 insertions(+), 112 deletions(-)

-- 
2.49.0



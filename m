Return-Path: <linux-kernel+bounces-846333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D85DCBC799E
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61A554F545B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F51298CBC;
	Thu,  9 Oct 2025 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Qs1pKDhn"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22531F151C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759993304; cv=none; b=EPxSWJ7r0GSyZl1RO3SYRr5ee8MnsSvUjvoEvheIe5ZSsNgKAzQY7el4cSDE/2GzRFVCf7eQl9OG9A57dWVq4+OiE8oGn7tFFQNLysd6v369kT7aPkFnVxNpRaY9c3asc2GP/AGrVwVug3z2YLoij2mm96d+QPYtOWMAQhP0HmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759993304; c=relaxed/simple;
	bh=jk75uSsCgu+7PqTtsJkB9YmYaImJKM5oLdV93J4+WW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+8h/pNV7jrunLiyuLFOqbxIacfhRnqFK7ue3IzJlS2Rx9V9WYOOER+oB1pNCt/16WrbzILH+eURtenf6GiAkuv5ag7kL6/Eq8ft0h+Vrt41cjXsfZgGRRZ6O0ukZbaZ9qgKEpItB7ncquI86H+JwdWhLo7SLaU2ZUw6GoC+BA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Qs1pKDhn; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=pI
	OoMBHNJqhZ5/ofJCwBqb0XpdSUUA4WlCEvJNRfdzA=; b=Qs1pKDhnSwbOU7TR/a
	CObdNqoykid8FPCZuyLMJZnprncQxkN/Yw2poc0B/EBhtW37WAWbtJhwJypwcKzc
	e7nch8ng5uTnHGOKR0JplYpoqeySfDFBt6pD/RMZzTJ1mG5oFHatIwxsr+o/HUw2
	GVsIuDJkkhdqHeQ+enp7OQ9a0=
Received: from XLL-9950X.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAnV+CjXedocoQYBg--.7355S2;
	Thu, 09 Oct 2025 15:00:52 +0800 (CST)
From: Longlong Xia <xialonglong2025@163.com>
To: linmiaohe@huawei.com,
	nao.horiguchi@gmail.com
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	xu.xin16@zte.com.cn,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Longlong Xia <xialonglong@kylinos.cn>
Subject: [PATCH RFC 0/1] mm/ksm: Add recovery mechanism for memory failures
Date: Thu,  9 Oct 2025 15:00:44 +0800
Message-ID: <20251009070045.2011920-1-xialonglong2025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAnV+CjXedocoQYBg--.7355S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr4DGw1kKr4kKF47uw1UGFg_yoWrJw17pF
	W3Kan3KrW8Ka1fW3WSqw1xC3Wagas5Gr47Kwn7u3y0kr1Ygryvyr4kCr48JF47Gr48Jay5
	J3ykXr9rCa15taUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jRyIUUUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbBcwXh+GjnU5rzZAAAs+

From: Longlong Xia <xialonglong@kylinos.cn>

When a hardware memory error occurs on a KSM page, the current
behavior is to kill all processes mapping that page. This can
be overly aggressive when KSM has multiple duplicate pages in
a chain where other duplicates are still healthy.

This patch introduces a recovery mechanism that attempts to migrate
mappings from the failing page to another healthy duplicate within
the same chain before resorting to killing processes.

The recovery process works as follows:
1. When a memory failure is detected on a KSM page, identify if the
failing node is part of a chain (has duplicates) (maybe add dup_haed
item to save head_node to struct stable_node?, saving searching
the whole stable tree, or other way to find head_node)
2. Search for another healthy duplicate page within the same chain
3. For each process mapping the failing page:
- Update the PTE to point to the healthy duplicate page ( maybe reuse
replace_page?, or split repalce_page into smaller function and use the
common part)
- Migrate the rmap_item to the new stable node
4. If all migrations succeed, remove the failing node from the chain
5. Only kill processes if recovery is impossible or fails

The original idea came from Naoya Horiguchi.
https://lore.kernel.org/all/20230331054243.GB1435482@hori.linux.bs1.fc.nec.co.jp/

I test it with /sys/kernel/debug/hwpoison/corrupt-pfn in qemu-x86_64.
here is my test steps and result:

1. alloc 1024 page with same content and enable KSM to merge
after merge (same phy_addr only print once)
 a. virtual addr = 0x7e4c68a00000  phy_addr =0x10e802000
 b. virtual addr = 0x7e4c68b2c000  phy_addr =0x10e902000
 c. virtual addr = 0x7e4c68c26000  phy_addr =0x10ea02000
 d. virtual addr = 0x7e4c68d20000  phy_addr =0x10eb02000

2. echo 0x10e802 > /sys/kernel/debug/hwpoison/corrupt-pfn
 a. virtual addr = 0x7e4c68a00000  phy_addr =0x10eb02000
 b. virtual addr = 0x7e4c68b2c000  phy_addr =0x10e902000
 c. virtual addr = 0x7e4c68c26000  phy_addr =0x10ea02000
 d. virtual addr = 0x7e4c68d20000  phy_addr =0x10eb02000 (share with a)

3.echo 0x10eb02 > /sys/kernel/debug/hwpoison/corrupt-pfn
 a. virtual addr = 0x7e4c68a00000  phy_addr =0x10ea02000
 b. virtual addr = 0x7e4c68b2c000  phy_addr =0x10e902000
 c. virtual addr = 0x7e4c68c26000  phy_addr =0x10ea02000 (share with a)
 d. virtual addr = 0x7e4c68c58000  phy_addr =0x10ea02000 (share with a)

4.echo 0x10ea02 > /sys/kernel/debug/hwpoison/corrupt-pfn
 a. virtual addr = 0x7e4c68a00000  phy_addr =0x10e902000
 b. virtual addr = 0x7e4c68a32000  phy_addr =0x10e902000(share with a)
 c. virtual addr = 0x7e4c68a64000  phy_addr =0x10e902000(share with a)
 d. virtual addr = 0x7e4c68a96000  phy_addr =0x10e902000(share with a)

5.echo 0x10e902 > /sys/kernel/debug/hwpoison/corrupt-pfn
MCE: Killing ksm_test:531 due to hardware memory corruption fault at 7e4c68a00000

kernel-log:
Injecting memory failure at pfn 0x10e802
Memory failure: 0x10e802: recovery action for dirty LRU page: Recovered
Injecting memory failure at pfn 0x10eb02
Memory failure: 0x10eb02: recovery action for dirty LRU page: Recovered
Injecting memory failure at pfn 0x10ea02
Memory failure: 0x10ea02: recovery action for dirty LRU page: Recovered
Injecting memory failure at pfn 0x10e902
Memory failure: 0x10e902: recovery action for dirty LRU page: Recovered
MCE: Killing ksm_test:531 due to hardware memory corruption fault at 7e4c68a00000

Thanks for review and comments!

Longlong Xia (1):
  mm/ksm: Add recovery mechanism for memory failures

 mm/ksm.c | 183 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

-- 
2.43.0



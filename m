Return-Path: <linux-kernel+bounces-855987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6343FBE2BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 213594FF21F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8390B32861F;
	Thu, 16 Oct 2025 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cgQc73VU"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E971C32862D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610006; cv=none; b=KU2RBie30bkgoEf1jhI1HB5gUor5NwQS8wLJ31uMzA4sZf9kmNjm8CPiRyVBc9WdiXNECvGFvCyjv4QS74NFKFBOW0wxtNQWspO/wR0/fiNJZuxwXYkUHzT9a6zKa/NUS33mdtrxyjzUVDic+zVvj48KzYnbly2UcRiLFXfaq18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610006; c=relaxed/simple;
	bh=FXHaXrAk3KcG+vRN5kCVZPc1QKIkGtcDxF+Y4zU7c8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WCNP+n3tdBWODUUE/2rWcOsE9zI04WoM9TV4Hd4Op7F7lh/Rfrxo3CwvIjBSv/gtKW/oXyAt/5UFZVEo8IsmBNrXoGraDKoi4og8biVrHFby1XKvI8ubSH7qvhvFckjUjz2DIL4mLbfOkyceOzi0brOydk2lyKr85whYxdIOIE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cgQc73VU; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=27
	0gr2GlhcdRXsppPlOLN/loQsGJhOZfzMqO8Lv0EOQ=; b=cgQc73VUFSh/vB3tLT
	vptjlO8XFmpvYW1MA9MCmxyf4Jhmq4fSOb/I2GfmI4f1Fo0r8qRDtzWNbEHbwmqu
	IXZjRR4mQZshyEgyLwqvJGf5GBVhmffT2oZRX+yDtAbB30vFycv+sd174NnLGkJB
	3GtoWahdt7/cK4YY9eEuziUok=
Received: from XLL-9950X.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wC3v6GsxvBoxGKIAg--.5453S2;
	Thu, 16 Oct 2025 18:19:25 +0800 (CST)
From: Longlong Xia <xialonglong2025@163.com>
To: linmiaohe@huawei.com,
	david@redhat.com,
	lance.yang@linux.dev
Cc: markus.elfring@web.de,
	nao.horiguchi@gmail.com,
	akpm@linux-foundation.org,
	wangkefeng.wang@huawei.com,
	qiuxu.zhuo@intel.com,
	xu.xin16@zte.com.cn,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Longlong Xia <xialonglong2025@163.com>
Subject: [PATCH v2 0/1]  mm/ksm: recover from memory failure on KSM page by migrating to healthy duplicate
Date: Thu, 16 Oct 2025 18:18:12 +0800
Message-ID: <20251016101813.484565-1-xialonglong2025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3v6GsxvBoxGKIAg--.5453S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gr18Xr1kCw1UuF1xXryrZwb_yoWxuryUpF
	9rGFs5K3ykXFyxu3WIqws7u343X34kCw4UG3s29w10kr4Yg34jyw1ktw48Way7Xr4Fya1x
	J3yvqr17Ka1jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U1KZZUUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbBcx-o+Gjww-s9qAAAsJ

When a hardware memory error occurs on a KSM page, the current
behavior is to kill all processes mapping that page. This can
be overly aggressive when KSM has multiple duplicate pages in
a chain where other duplicates are still healthy.

This patch introduces a recovery mechanism that attempts to
migrate mappings from the failing KSM page to a newly
allocated KSM page or another healthy duplicate already
present in the same chain, before falling back to the
process-killing procedure.

The recovery process works as follows:
1. Identify if the failing KSM page belongs to a stable node chain.
2. Locate a healthy duplicate KSM page within the same chain.
3. For each process mapping the failing page:
   a. Attempt to allocate a new KSM page copy from healthy duplicate
      KSM page. If successful, migrate the mapping to this new KSM page.
   b. If allocation fails, migrate the mapping to the existing healthy
      duplicate KSM page.
4. If all migrations succeed, remove the failing KSM page from the chain.
5. Only if recovery fails (e.g., no healthy duplicate found or migration
   error) does the kernel fall back to killing the affected processes.

The original idea came from Naoya Horiguchi.
https://lore.kernel.org/all/20230331054243.GB1435482@hori.linux.bs1.fc.nec.co.jp/

I test it with einj in physical machine x86_64 CPU Intel(R) Xeon(R) Gold 6430.

test shell script
modprobe einj 2>/dev/null
echo 0x10 > /sys/kernel/debug/apei/einj/error_type
echo $ADDRESS > /sys/kernel/debug/apei/einj/param1
echo 0xfffffffffffff000 > /sys/kernel/debug/apei/einj/param2
echo 1 > /sys/kernel/debug/apei/einj/error_inject

FIRST WAY: allocate a new KSM page copy from healthy duplicate
1. alloc 1024 page with same content and enable KSM to merge
after merge (same phy_addr only print once)
virtual addr = 0x71582be00000  phy_addr =0x124802000
virtual addr = 0x71582bf2c000  phy_addr =0x124902000
virtual addr = 0x71582c026000  phy_addr =0x125402000
virtual addr = 0x71582c120000  phy_addr =0x125502000


2. echo 0x124802000 > /sys/kernel/debug/apei/einj/param1
virtual addr = 0x71582be00000  phy_addr =0x1363b1000 (new allocated)
virtual addr = 0x71582bf2c000  phy_addr =0x124902000
virtual addr = 0x71582c026000  phy_addr =0x125402000
virtual addr = 0x71582c120000  phy_addr =0x125502000


3. echo 0x124902000 > /sys/kernel/debug/apei/einj/param1
virtual addr = 0x71582be00000  phy_addr =0x1363b1000
virtual addr = 0x71582bf2c000  phy_addr =0x13099a000 (new allocated)
virtual addr = 0x71582c026000  phy_addr =0x125402000
virtual addr = 0x71582c120000  phy_addr =0x125502000

kernel-log:
mce: [Hardware Error]: Machine check events logged
ksm: recovery successful, no need to kill processes
Memory failure: 0x124802: recovery action for dirty LRU page: Recovered
Memory failure: 0x124802: recovery action for already poisoned page: Failed
ksm: recovery successful, no need to kill processes
Memory failure: 0x124902: recovery action for dirty LRU page: Recovered
Memory failure: 0x124902: recovery action for already poisoned page: Failed


SECOND WAY: Migrate the mapping to the existing healthy duplicate KSM page
1. alloc 1024 page with same content and enable KSM to merge
after merge (same phy_addr only print once)
virtual addr = 0x79a172000000  phy_addr =0x141802000
virtual addr = 0x79a17212c000  phy_addr =0x141902000
virtual addr = 0x79a172226000  phy_addr =0x13cc02000
virtual addr = 0x79a172320000  phy_addr =0x13cd02000

2 echo 0x141802000 > /sys/kernel/debug/apei/einj/param1
a.virtual addr = 0x79a172000000  phy_addr =0x13cd02000
b.virtual addr = 0x79a17212c000  phy_addr =0x141902000
c.virtual addr = 0x79a172226000  phy_addr =0x13cc02000
d.virtual addr = 0x79a172320000  phy_addr =0x13cd02000 (share with a) 

3.echo 0x141902000 > /sys/kernel/debug/apei/einj/param1
a.virtual addr = 0x79a172000000  phy_addr =0x13cd02000
b.virtual addr = 0x79a172032000  phy_addr =0x13cd02000 (share with a) 
c.virtual addr = 0x79a172226000  phy_addr =0x13cc02000
d.virtual addr = 0x79a172320000  phy_addr =0x13cd02000 (share with a) 

4. echo 0x13cd02000 > /sys/kernel/debug/apei/einj/param1
a.virtual addr = 0x79a172000000  phy_addr =0x13cc02000
b.virtual addr = 0x79a172032000  phy_addr =0x13cc02000 (share with a)
c.virtual addr = 0x79a172226000  phy_addr =0x13cc02000 (share with a)
d.virtual addr = 0x79a172320000  phy_addr =0x13cc02000 (share with a)

5. echo 0x13cc02000 > /sys/kernel/debug/apei/einj/param1
Bus error (core dumped)

kernel-log:
mce: [Hardware Error]: Machine check events logged
ksm: recovery successful, no need to kill processes
Memory failure: 0x141802: recovery action for dirty LRU page: Recovered
Memory failure: 0x141802: recovery action for already poisoned page: Failed
ksm: recovery successful, no need to kill processes
Memory failure: 0x141902: recovery action for dirty LRU page: Recovered
Memory failure: 0x141902: recovery action for already poisoned page: Failed
ksm: recovery successful, no need to kill processes
Memory failure: 0x13cd02: recovery action for dirty LRU page: Recovered
Memory failure: 0x13cd02: recovery action for already poisoned page: Failed
Memory failure: 0x13cc02: recovery action for dirty LRU page: Recovered
Memory failure: 0x13cc02: recovery action for already poisoned page: Failed
MCE: Killing ksm_addr:5221 due to hardware memory corruption fault at 79a172000000

ZERO PAGE TEST:
when I test in physical machine x86_64 CPU Intel(R) Xeon(R) Gold 6430
[shell]# ./einj.sh 0x193f908000
./einj.sh: line 25: echo: write error: Address already in use

when I test in qemu-x86_64.
Injecting memory failure at pfn 0x3a9d0c
Memory failure: 0x3a9d0c: unhandlable page.
Memory failure: 0x3a9d0c: recovery action for get hwpoison page: Ignored

It seems return early before enter this patch's functions.

Thanks for review and comments!

Changes in v2:

- Implemented a two-tier recovery strategy: preferring newly allocated
  pages over existing duplicates to avoid concentrating mappings on a 
  single page suggested by David Hildenbrand
- Remove handling of the zeropage in replace_failing_page(), as it is 
  non-recoverable suggested by Lance Yang 
- Correct the locking order by acquiring the mmap_lock before the page 
  lock during page replacement, suggested by Miaohe Lin
- Add protection using the ksm_thread_mutex around the entire recovery 
  operation to prevent race conditions with concurrent KSM scanning
- Separated the logic into smaller, more focused functions for better
  maintainability
- Update patch title

Longlong Xia (1):
  mm/ksm: recover from memory failure on KSM page by migrating to
    healthy duplicate

 mm/ksm.c | 246 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 246 insertions(+)

-- 
2.43.0



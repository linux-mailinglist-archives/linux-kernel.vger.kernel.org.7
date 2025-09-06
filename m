Return-Path: <linux-kernel+bounces-804368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7501EB473E8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3587D188AAA6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E942417FB;
	Sat,  6 Sep 2025 16:15:04 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC2C241CB7;
	Sat,  6 Sep 2025 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757175303; cv=none; b=hzMXybNwEGS4IWbpkijHuK1aQDVXtFbe5qLLCxg+WZUyKh9L6Zh0lLcX9UIfui6ZEqBEB96LV/VWBMAopnEUZLpscGaeKHpoRdEMfQOzKZKoZhiOTiFHoR15RVaFJP+lnMqEWpEz2aeIQk+wi95NM0eYIW5XHPyTvU0G+1NxqSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757175303; c=relaxed/simple;
	bh=TYB/E2tIkzgU/+Rq74o3mefWv478pIKXjHznT5IMLJc=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=GS3IeLj/xuiYWCdWNrx3/C9m/YRjzRa7mPl+RBKpIe01B6Dmqpblo28/jRG2pNYy+F8QOCRz/gXFq4eua6WXe56GdIrqupircMBHYd/bhYtgsswTSfU6GrJihwsF/Sqe1yEGkFoYlyx2nOUVhlPGP0UM5Ow/nb1QlaSekun/tjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cJywg6Y88z5PM32;
	Sun, 07 Sep 2025 00:14:59 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 586GEtTv035356;
	Sun, 7 Sep 2025 00:14:55 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 7 Sep 2025 00:14:57 +0800 (CST)
Date: Sun, 7 Sep 2025 00:14:57 +0800 (CST)
X-Zmail-TransId: 2afa68bc5e01e95-41e9f
X-Mailer: Zmail v1.0
Message-ID: <20250907001457696qAqUGGkV1VfEO6OkVMovW@zte.com.cn>
In-Reply-To: <20250907001101305vrTGnXaRNvtmsGkp-Ljk_@zte.com.cn>
References: 20250907001101305vrTGnXaRNvtmsGkp-Ljk_@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <akpm@linux-foundation.org>, <wang.yaxin@zte.com.cn>, <corbet@lwn.net>
Cc: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIdjIgbGludXgtbmV4dCA1LzVdIGRvY3M6IHVwZGF0ZSBkZWxheXRvcCBkb2N1bWVudGF0aW9uIGZvciBuZXcgaW50ZXJhY3RpdmUgZmVhdHVyZXM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 586GEtTv035356
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Sun, 07 Sep 2025 00:14:59 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68BC5E03.000/4cJywg6Y88z5PM32

From: Fan Yu <fan.yu9@zte.com.cn>

This commit updates the delaytop documentation to reflect the newly
added features:
1) Added comprehensive description of interactive keyboard controls
2) Documented all available sort fields
3) Added examples for advanced usage scenarios
4) Included PSI availability note

Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
---
 Documentation/accounting/delay-accounting.rst | 91 ++++++++++++-------
 1 file changed, 58 insertions(+), 33 deletions(-)

diff --git a/Documentation/accounting/delay-accounting.rst b/Documentation/accounting/delay-accounting.rst
index 8ccc5af5ea1e..7cca536d2c4c 100644
--- a/Documentation/accounting/delay-accounting.rst
+++ b/Documentation/accounting/delay-accounting.rst
@@ -134,47 +134,72 @@ The above command can be used with -v to get more debug information.

 After the system starts, use `delaytop` to get the system-wide delay information,
 which includes system-wide PSI information and Top-N high-latency tasks.
+Note: PSI support requires `CONFIG_PSI=y` and `psi=1` for full functionality.

-`delaytop` supports sorting by CPU latency in descending order by default,
-displays the top 20 high-latency tasks by default, and refreshes the latency
-data every 2 seconds by default.
+`delaytop` is an interactive tool for monitoring system pressure and task delays.
+It supports multiple sorting options, display modes, and real-time keyboard controls.

-Get PSI information and Top-N tasks delay, since system boot::
+Basic usage with default settings (sorts by CPU delay, shows top 20 tasks, refreshes every 2 seconds)::

 	bash# ./delaytop
-	System Pressure Information: (avg10/avg60/avg300/total)
-	CPU some:       0.0%/   0.0%/   0.0%/     345(ms)
+	System Pressure Information: (avg10/avg60vg300/total)
+	CPU some:       0.0%/   0.0%/   0.0%/  106137(ms)
 	CPU full:       0.0%/   0.0%/   0.0%/       0(ms)
 	Memory full:    0.0%/   0.0%/   0.0%/       0(ms)
 	Memory some:    0.0%/   0.0%/   0.0%/       0(ms)
-	IO full:        0.0%/   0.0%/   0.0%/      65(ms)
-	IO some:        0.0%/   0.0%/   0.0%/      79(ms)
+	IO full:        0.0%/   0.0%/   0.0%/    2240(ms)
+	IO some:        0.0%/   0.0%/   0.0%/    2783(ms)
 	IRQ full:       0.0%/   0.0%/   0.0%/       0(ms)
-	Top 20 processes (sorted by CPU delay):
-	  PID   TGID  COMMAND          CPU(ms)  IO(ms) SWAP(ms) RCL(ms) THR(ms) CMP(ms)  WP(ms) IRQ(ms)
-	----------------------------------------------------------------------------------------------
-	  161    161  zombie_memcg_re   1.40    0.00    0.00    0.00    0.00    0.00    0.00    0.00
-	  130    130  blkcg_punt_bio    1.37    0.00    0.00    0.00    0.00    0.00    0.00    0.00
-	  444    444  scsi_tmf_0        0.73    0.00    0.00    0.00    0.00    0.00    0.00    0.00
-	 1280   1280  rsyslogd          0.53    0.04    0.00    0.00    0.00    0.00    0.00    0.00
-	   12     12  ksoftirqd/0       0.47    0.00    0.00    0.00    0.00    0.00    0.00    0.00
-	 1277   1277  nbd-server        0.44    0.00    0.00    0.00    0.00    0.00    0.00    0.00
-	  308    308  kworker/2:2-sys   0.41    0.00    0.00    0.00    0.00    0.00    0.00    0.00
-	   55     55  netns             0.36    0.00    0.00    0.00    0.00    0.00    0.00    0.00
-	 1187   1187  acpid             0.31    0.03    0.00    0.00    0.00    0.00    0.00    0.00
-	 6184   6184  kworker/1:2-sys   0.24    0.00    0.00    0.00    0.00    0.00    0.00    0.00
-	  186    186  kaluad            0.24    0.00    0.00    0.00    0.00    0.00    0.00    0.00
-	   18     18  ksoftirqd/1       0.24    0.00    0.00    0.00    0.00    0.00    0.00    0.00
-	  185    185  kmpath_rdacd      0.23    0.00    0.00    0.00    0.00    0.00    0.00    0.00
-	  190    190  kstrp             0.23    0.00    0.00    0.00    0.00    0.00    0.00    0.00
-	 2759   2759  agetty            0.20    0.03    0.00    0.00    0.00    0.00    0.00    0.00
-	 1190   1190  kworker/0:3-sys   0.19    0.00    0.00    0.00    0.00    0.00    0.00    0.00
-	 1272   1272  sshd              0.15    0.04    0.00    0.00    0.00    0.00    0.00    0.00
-	 1156   1156  license           0.15    0.11    0.00    0.00    0.00    0.00    0.00    0.00
-	  134    134  md                0.13    0.00    0.00    0.00    0.00    0.00    0.00    0.00
-	 6142   6142  kworker/3:2-xfs   0.13    0.00    0.00    0.00    0.00    0.00    0.00    0.00
-
-Dynamic interactive interface of delaytop::
+	[o]sort [M]memverbose [q]quit
+	Top 20 processes (sorted by cpu delay):
+		PID      TGID  COMMAND           CPU(ms)   IO(ms)  IRQ(ms)  MEM(ms)
+	------------------------------------------------------------------------
+		110       110  kworker/15:0H-s   27.91     0.00     0.00     0.00
+		57        57  cpuhp/7            3.18     0.00     0.00     0.00
+		99        99  cpuhp/14           2.97     0.00     0.00     0.00
+		51        51  cpuhp/6            0.90     0.00     0.00     0.00
+		44        44  kworker/4:0H-sy    0.80     0.00     0.00     0.00
+		60        60  ksoftirqd/7        0.74     0.00     0.00     0.00
+		76        76  idle_inject/10     0.31     0.00     0.00     0.00
+		100       100  idle_inject/14     0.30     0.00     0.00     0.00
+		1309      1309  systemsettings     0.29     0.00     0.00     0.00
+		45        45  cpuhp/5            0.22     0.00     0.00     0.00
+		63        63  cpuhp/8            0.20     0.00     0.00     0.00
+		87        87  cpuhp/12           0.18     0.00     0.00     0.00
+		93        93  cpuhp/13           0.17     0.00     0.00     0.00
+		1265      1265  acpid              0.17     0.00     0.00     0.00
+		1552      1552  sshd               0.17     0.00     0.00     0.00
+		2584      2584  sddm-helper        0.16     0.00     0.00     0.00
+		1284      1284  rtkit-daemon       0.15     0.00     0.00     0.00
+		1326      1326  nde-netfilter      0.14     0.00     0.00     0.00
+		27        27  cpuhp/2            0.13     0.00     0.00     0.00
+		631       631  kworker/11:2-rc    0.11     0.00     0.00     0.00
+
+Interactive keyboard controls during runtime::
+
+	o - Select sort field (CPU, IO, IRQ, Memory, etc.)
+	M - Toggle display mode (Default/Memory Verbose)
+	q - Quit
+
+Available sort fields(use -s/--sort or interactive command)::
+
+	cpu(c)       - CPU delay
+	blkio(i)     - I/O delay 
+	irq(q)       - IRQ delay
+	mem(m)       - Total memory delay
+	swapin(s)    - Swapin delay (memory verbose mode only)
+	freepages(r) - Freepages reclaim delay (memory verbose mode only)
+	thrashing(t) - Thrashing delay (memory verbose mode only)
+	compact(p)   - Compaction delay (memory verbose mode only)
+	wpcopy(w)    - Write page copy delay (memory verbose mode only)
+
+Advanced usage examples::
+
+	# ./delaytop -s blkio
+	Sorted by IO delay
+
+	# ./delaytop -s mem -M
+	Sorted by memory delay in memory verbose mode

 	# ./delaytop -p pid
 	Print delayacct stats
-- 
2.25.1


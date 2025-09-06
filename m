Return-Path: <linux-kernel+bounces-804362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A96B473C1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 18:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD971665DF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97FB2405E7;
	Sat,  6 Sep 2025 16:11:30 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA83D1C5F10;
	Sat,  6 Sep 2025 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757175090; cv=none; b=Y9+pjstGB7lA12h+WaGGmxmdSs/3bL1DfFnfGmf08vHuGvjxBsGNEtOWshOmF6mHJy19kGmhHRMuhn3y0F37yri331lGiu8ccD0J8PsqFKhD/jE97NtH+yS2tTSYLJ+oU1SVeQaX493ugkzq9lvG+DO2pIo3j+rkUBCxewFeXKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757175090; c=relaxed/simple;
	bh=Hoe93HOntX7QH7qqyJ291jeFOmpzeJk0DKOBWCOd1XE=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=Ui3EShTOgs9JSniA3V9WjhcsRK/kJRK//yWmBnfRMJ4I/Ep/UHxBjMC/8Ex5H7lI6xfM4DsUXOusmMoAI+5+1YplMCHE1r46vy8onHXbMnAaVYGxkESueiAaAWd2pYkviq8enPdXhMARQugx1bO7ypkhTqZS3Ki3E+2dWeGoPzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cJyrH3rc7z59trL;
	Sun, 07 Sep 2025 00:11:11 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 586GAwUY034174;
	Sun, 7 Sep 2025 00:10:58 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 7 Sep 2025 00:11:01 +0800 (CST)
Date: Sun, 7 Sep 2025 00:11:01 +0800 (CST)
X-Zmail-TransId: 2af968bc5d153d2-433da
X-Mailer: Zmail v1.0
Message-ID: <20250907001101305vrTGnXaRNvtmsGkp-Ljk_@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <akpm@linux-foundation.org>, <wang.yaxin@zte.com.cn>, <corbet@lwn.net>
Cc: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <fan.yu9@zte.com.cn>, <wang.yaxin@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIdjIgbGludXgtbmV4dCAwLzVdIHRvb2xzL2RlbGF5dG9wOiBpbXBsZW1lbnQgcmVhbC10aW1lIGtleWJvYXJkIGludGVyYWN0aW9uIHN1cHBvcnQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 586GAwUY034174
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Sun, 07 Sep 2025 00:11:11 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68BC5D1F.000/4cJyrH3rc7z59trL

From: Fan Yu <fan.yu9@zte.com.cn>

Current Limitations
===================
The current delaytop implementation has two main limitations:
1) Static sorting only by CPU delay
Forcing users to restart with different parameters to analyze
other resource bottlenecks.
2) Memory delay information is always expanded
Causing information overload when only high-level memory pressure
monitoring is needed.

Improvements
============
1) Implemented dynamic sorting capability
- Interactive key 'o' triggers sort mode.
- Supports sorting by CPU/IO/Memory/IRQ delays.
- Memory subcategories available in verbose mode.
 * c - CPU delay (default)
 * i - IO delay
 * m - Total memory delay
 * q - IRQ delay
 * s/r/t/p/w - Memory subcategories (in verbose mode)
2) Added memory display modes
- Compact view (default): shows aggregated memory delays.
- Verbose view ('M' key): breaks down into memory sub-delays.
 * SWAP - swapin delays
 * RCL - freepages reclaim delays
 * THR - thrashing delays
 * CMP - compaction delays
 * WP - write-protect copy delays

Practical benefits
==================
1) Dynamic Sorting for Real-Time Bottleneck Detection
System administrators can now dynamically change sorting to identify
different types of resource bottlenecks without restarting.

2) Enhanced Usability with On-Screen Keybindings
More intuitive interactive usage with on-screen keybindings help.
Reduced screen clutter when only memory overview is needed.

Use Case
========
# ./delaytop
System Pressure Information: (avg10/avg60vg300/total)
CPU some:       0.0%/   0.0%/   0.0%/  106817(ms)
CPU full:       0.0%/   0.0%/   0.0%/       0(ms)
Memory full:    0.0%/   0.0%/   0.0%/       0(ms)
Memory some:    0.0%/   0.0%/   0.0%/       0(ms)
IO full:        0.0%/   0.0%/   0.0%/    2245(ms)
IO some:        0.0%/   0.0%/   0.0%/    2791(ms)
IRQ full:       0.0%/   0.0%/   0.0%/       0(ms)
[o]sort [M]memverbose [q]quit
Top 20 processes (sorted by cpu delay):
     PID      TGID  COMMAND           CPU(ms)   IO(ms)  IRQ(ms)  MEM(ms)
------------------------------------------------------------------------
     110       110  kworker/15:0H-s   27.91     0.00     0.00     0.00
      57        57  cpuhp/7            3.18     0.00     0.00     0.00
      99        99  cpuhp/14           2.97     0.00     0.00     0.00
      51        51  cpuhp/6            0.90     0.00     0.00     0.00
      44        44  kworker/4:0H-sy    0.80     0.00     0.00     0.00
      76        76  idle_inject/10     0.31     0.00     0.00     0.00
     100       100  idle_inject/14     0.30     0.00     0.00     0.00
    1309      1309  systemsettings     0.29     0.00     0.00     0.00
      60        60  ksoftirqd/7        0.28     0.00     0.00     0.00
      45        45  cpuhp/5            0.22     0.00     0.00     0.00
      63        63  cpuhp/8            0.20     0.00     0.00     0.00
      87        87  cpuhp/12           0.18     0.00     0.00     0.00
      93        93  cpuhp/13           0.17     0.00     0.00     0.00
    1265      1265  acpid              0.17     0.00     0.00     0.00
    1552      1552  sshd               0.17     0.00     0.00     0.00
    2584      2584  sddm-helper        0.16     0.00     0.00     0.00
    1284      1284  rtkit-daemon       0.15     0.00     0.00     0.00
    1326      1326  nde-netfilter      0.14     0.00     0.00     0.00
      27        27  cpuhp/2            0.13     0.00     0.00     0.00
     631       631  kworker/11:2-rc    0.11     0.00     0.00     0.00

# ./delaytop -M
System Pressure Information: (avg10/avg60vg300/total)
CPU some:       0.0%/   0.0%/   0.0%/  106827(ms)
CPU full:       0.0%/   0.0%/   0.0%/       0(ms)
Memory full:    0.0%/   0.0%/   0.0%/       0(ms)
Memory some:    0.0%/   0.0%/   0.0%/       0(ms)
IO full:        0.0%/   0.0%/   0.0%/    2245(ms)
IO some:        0.0%/   0.0%/   0.0%/    2791(ms)
IRQ full:       0.0%/   0.0%/   0.0%/       0(ms)
[o]sort [M]memverbose [q]quit
Top 20 processes (sorted by mem delay):
     PID      TGID  COMMAND           MEM(ms) SWAP(ms)  RCL(ms)  THR(ms)  CMP(ms)   WP(ms)
------------------------------------------------------------------------------------------
  121732    121732  delaytop           0.01     0.00     0.00     0.00     0.00     0.01
   95876     95876  top                0.00     0.00     0.00     0.00     0.00     0.00
  121641    121641  systemd-userwor    0.00     0.00     0.00     0.00     0.00     0.00
  121693    121693  systemd-userwor    0.00     0.00     0.00     0.00     0.00     0.00
  121661    121661  systemd-userwor    0.00     0.00     0.00     0.00     0.00     0.00
       1         1  systemd            0.00     0.00     0.00     0.00     0.00     0.00
       2         2  kthreadd           0.00     0.00     0.00     0.00     0.00     0.00
       3         3  pool_workqueue_    0.00     0.00     0.00     0.00     0.00     0.00
       4         4  kworker/R-rcu_g    0.00     0.00     0.00     0.00     0.00     0.00
       5         5  kworker/R-rcu_p    0.00     0.00     0.00     0.00     0.00     0.00
       6         6  kworker/R-slub_    0.00     0.00     0.00     0.00     0.00     0.00
       7         7  kworker/R-netns    0.00     0.00     0.00     0.00     0.00     0.00
       9         9  kworker/0:0H-sy    0.00     0.00     0.00     0.00     0.00     0.00
      11        11  kworker/u32:0-n    0.00     0.00     0.00     0.00     0.00     0.00
      12        12  kworker/R-mm_pe    0.00     0.00     0.00     0.00     0.00     0.00
      13        13  rcu_tasks_kthre    0.00     0.00     0.00     0.00     0.00     0.00
      14        14  rcu_tasks_rude_    0.00     0.00     0.00     0.00     0.00     0.00
      15        15  rcu_tasks_trace    0.00     0.00     0.00     0.00     0.00     0.00
      16        16  ksoftirqd/0        0.00     0.00     0.00     0.00     0.00     0.00
      17        17  rcu_preempt        0.00     0.00     0.00     0.00     0.00     0.00

When psi is not enabled:
# ./delaytop
System Pressure Information: (avg10/avg60vg300/total)
  PSI not found: check if psi=1 enabled in cmdline

v2->v1:
Some fixes according to:
https://lore.kernel.org/all/202509021454480003xS5M8WmAIQT2F_IiSd3p@zte.com.cn/
https://lore.kernel.org/all/202509021138097501cXkw4xiXiYSWRs8thevi@zte.com.cn/
1. Refactored delay sorting and view display logic for better extensibility
2. Optimized memory delay verbose view (exclude CPU/IRQ/IO delays) 
3. Added user notice for PSI configuration when not enabled
4. Updated documentation covering all new interactive features

Fan Yu (5):
  tools/delaytop: add flexible sorting by delay field
  tools/delaytop: add memory verbose mode support
  tools/delaytop: add interactive mode with keyboard controls
  tools/delaytop: Improve error handling for missing PSI support
  docs: update delaytop documentation for new interactive features

 Documentation/accounting/delay-accounting.rst |  91 ++-
 tools/accounting/delaytop.c                   | 571 +++++++++++++-----
 2 files changed, 485 insertions(+), 177 deletions(-)

-- 
2.25.1


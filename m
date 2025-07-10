Return-Path: <linux-kernel+bounces-724927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C40DDAFF8A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18743BF5B1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0849928643B;
	Thu, 10 Jul 2025 05:52:01 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B052036FF;
	Thu, 10 Jul 2025 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752126720; cv=none; b=gmtFBi1eg7ZWL5Rqb/eWvLCnKhYpAEuCFYkHAVdCdMvHtWwo19N1x1fozg8o3RaCk/hlr6GtyRFezcvD4cCa+4OeUg6EQuU+eyUf/Ie1R9guM9XTqevedsirWMA9WBmBR+vb5QhfM+G9B4z6yDBVQz8mRC2LnQD93TD/dxrPlII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752126720; c=relaxed/simple;
	bh=vERoAnTtuv55lMm9AjGiShvQq0udC6vkMtjkt2WaJ+w=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=NPEH/sDodaQTAbtT+kEQOVM0Zbe+nnvTz7AA5B4FGFZeVZT2BMF43mV3mD3aUp/wFXf2prTk+w/H2aQMk58w7+fDshZgrQ8hdei284BD71Hci9MjQtxI6iWHVv3EOH7nktzFQWUUWdo36Be4WVanVEEx+OwCVe/kK4kT07tYKXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bd3rL3f6Cz5F2lt;
	Thu, 10 Jul 2025 13:51:46 +0800 (CST)
Received: from njy2app02.zte.com.cn ([10.40.13.116])
	by mse-fl2.zte.com.cn with SMTP id 56A5pen3017791;
	Thu, 10 Jul 2025 13:51:40 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njy2app01[null])
	by mapi (Zmail) with MAPI id mid204;
	Thu, 10 Jul 2025 13:51:41 +0800 (CST)
Date: Thu, 10 Jul 2025 13:51:41 +0800 (CST)
X-Zmail-TransId: 2af9686f54ed565-26977
X-Mailer: Zmail v1.0
Message-ID: <2025071013514177028RdjISjqeIOnTCRvGAwy@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <bsingharora@gmail.com>, <akpm@linux-foundation.org>, <david@redhat.com>,
        <yang.yang29@zte.com.cn>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <wang.yong12@zte.com.cn>,
        <wang.yaxin@zte.com.cn>, <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <qiu.yutan@zte.com.cn>,
        <zhang.yunkai@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4IG5leHRdIGRvY3M6IHVwZGF0ZSBkb2NzIGFmdGVyIGludHJvZHVjaW5nIGRlbGF5dG9w?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 56A5pen3017791
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 686F54F2.000/4bd3rL3f6Cz5F2lt

From: Wang Yaxin <wang.yaxin@zte.com.cn>

The "getdelays" can only display the latency of a single task
by specifying a PID, we introduce the "delaytop" with the
following capabilities:

1. system view: monitors latency metrics (CPU, I/O, memory, IRQ, etc.)
   for all system processes

2. supports field-based sorting (e.g., default sort by CPU latency in
   descending order)

3. dynamic interactive interface: focus on specific processes with
   --pid; limit displayed entries with --processes 20; control monitoring
   duration with --iterations;

Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
---
 Documentation/accounting/delay-accounting.rst | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/accounting/delay-accounting.rst b/Documentation/accounting/delay-accounting.rst
index 210c194d4a7b..664950328fb7 100644
--- a/Documentation/accounting/delay-accounting.rst
+++ b/Documentation/accounting/delay-accounting.rst
@@ -131,3 +131,50 @@ Get IO accounting for pid 1, it works only with -p::
 	linuxrc: read=65536, write=0, cancelled_write=0

 The above command can be used with -v to get more debug information.
+
+After the system starts, use `delaytop` to get the Top-N high-latency tasks.
+this tool supports sorting by CPU latency in descending order by default,
+displays the top 20 high-latency tasks by default, and refreshes the latency
+data every 2 seconds by default.
+
+Get Top-N tasks delay, since system boot::
+
+	bash# ./delaytop
+	Top 20 processes (sorted by CPU delay):
+
+	  PID   TGID  COMMAND            CPU(ms)  IO(ms)        SWAP(ms) RCL(ms) THR(ms)  CMP(ms)  WP(ms)  IRQ(ms)
+	---------------------------------------------------------------------------------------------
+	   32     32  kworker/2:0H-sy   23.65     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	  497    497  kworker/R-scsi_    1.20     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	  495    495  kworker/R-scsi_    1.13     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	  494    494  scsi_eh_0          1.12     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	  485    485  kworker/R-ata_s    0.90     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	  574    574  kworker/R-kdmfl    0.36     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	   34     34  idle_inject/3      0.33     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	 1123   1123  nde-netfilter      0.28     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	   60     60  ksoftirqd/7        0.25     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	  114    114  kworker/0:2-cgr    0.25     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	  496    496  scsi_eh_1          0.24     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	   51     51  cpuhp/6            0.24     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	 1667   1667  atd                0.24     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	   45     45  cpuhp/5            0.23     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	 1102   1102  nde-backupservi    0.22     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	 1098   1098  systemsettings     0.21     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	 1100   1100  audit-monitor      0.20     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	   53     53  migration/6        0.20     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	 1482   1482  sshd               0.19     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+	   39     39  cpuhp/4            0.19     0.00     0.00     0.00    0.00     0.00     0.00     0.00
+
+Dynamic interactive interface of delaytop::
+
+	# ./delaytop -p pid
+	Print delayacct stats
+
+	# ./delaytop -P num
+	Display the top N tasks
+
+	# ./delaytop -n num
+	Set delaytop refresh frequency (num times)
+
+	# ./delaytop -d secs
+	Specify refresh interval as secs
-- 
2.25.1


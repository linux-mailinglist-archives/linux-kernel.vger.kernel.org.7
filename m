Return-Path: <linux-kernel+bounces-832730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29410BA02CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668061B22671
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9980D306497;
	Thu, 25 Sep 2025 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S7ZbOpnZ"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80A31B10B;
	Thu, 25 Sep 2025 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812744; cv=none; b=BL1se/h7SSiUK5F7A2Qu0o6wa1+TE8v0h/AcaypBcjWpywwZsb5nD0uef666DHD03VUhuZ1aLPm3NChYq0ImnVnwMkZZOH2OP9eb+rPE+m5oiDMl0NM+WcSLmUaw6JO8d7kpncHCXB546w501jJk0rLYKG16iv59Z/J8M7QS1VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812744; c=relaxed/simple;
	bh=6X+2xPvvoMuMNMDivSf9y9c6nTZvfXkeZsioLX0X17Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtNFsbysIbsZZQ3c00ySeeAxJwdqQWS3fXk6LZ+AegY9osogxYiUxn/qXTHZH9uW6+G28nDbQaZAUyzC5PNs1HlRgbe/135ngXfR/Kso46DzFclc2/ALLCWI1ojZom/W/OOJLwkZd9Qo4hFGmG5T1o3I0aOghUCMPyJSXEd3JWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=S7ZbOpnZ; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758812741; x=1790348741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6X+2xPvvoMuMNMDivSf9y9c6nTZvfXkeZsioLX0X17Q=;
  b=S7ZbOpnZFI3CFC4tESbEMQUtWHbhllttw04LZwPt/jd9P6PFB5gE8i+x
   8pzJ+TwgqmKYu8HhVdH2hd9R2SpScFqxX7IEA+QdVWtnjFi6k6H9OUTxC
   KI/TCXg4JK7KkV65h9+bxj37FkPCTkx5RxqJFA2Cwvu282vi5dJduxncp
   +AArrJAus2swoXvuD9O81cH1uc4KSEmEa2OaxYEPI5YnwU1Mie89B2I/0
   M8VRjc8upEFluBN71zIxrt6ckI23eQWrelHvojxvMp9aP4RnR1vzrgvkb
   BtFQ9iilYI9p5zy5Gl3kRlfYc9jIHjS7GAkZKvaUyLjwF/veDpFWDJyWL
   g==;
X-CSE-ConnectionGUID: iwci3smtSpWGsmYD/IlJRg==
X-CSE-MsgGUID: 9tJROEHUTpq5rZUkVdBDAA==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130349405"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 23:05:41 +0800
IronPort-SDR: 68d55a45_s15REnVaqAEwtjij1o1kY/3/qjBzarTujb25Ch73hhkVNgl
 TkIe49QM2eeiyIzwAsP4NUqYoGUL9jQPTOmDsQw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2025 08:05:42 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Sep 2025 08:05:38 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-btrace@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH blktrace v2 16/22] blkparse: use blk_io_trace2 internally
Date: Thu, 25 Sep 2025 17:04:21 +0200
Message-ID: <20250925150427.67394-17-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
References: <20250925150427.67394-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use 'struct blk_io_trace2' as internal representation for a captured
blktrace.

This implies the conversion of 'struct blk_io_trace' into 'struct
blk_io_trace2' when reading the trace from the binary file.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 blkparse.c     | 131 +++++++++++++++++++++++++++----------------------
 blkparse_fmt.c |  16 +++---
 blktrace.h     |  23 ++++++++-
 3 files changed, 103 insertions(+), 67 deletions(-)

diff --git a/blkparse.c b/blkparse.c
index 6396611..7100009 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -243,7 +243,7 @@ static struct option l_opts[] = {
  * for sorting the displayed output
  */
 struct trace {
-	struct blk_io_trace *bit;
+	struct blk_io_trace2 *bit;
 	struct rb_node rb_node;
 	struct trace *next;
 	unsigned long read_sequence;
@@ -257,7 +257,7 @@ static struct trace *trace_list;
 /*
  * allocation cache
  */
-static struct blk_io_trace *bit_alloc_list;
+static struct blk_io_trace2 *bit_alloc_list;
 static struct trace *t_alloc_list;
 
 /*
@@ -332,7 +332,7 @@ static int have_drv_data = 0;
 #define CPU_IDX(cpu)	((cpu) / CPUS_PER_LONG)
 #define CPU_BIT(cpu)	((cpu) & (CPUS_PER_LONG - 1))
 
-static void io_warn_unless(struct blk_io_trace *t, int condition,
+static void io_warn_unless(struct blk_io_trace2 *t, int condition,
 			   const char *fmt, ...)
 {
 	va_list ap;
@@ -613,7 +613,7 @@ static struct process_pid_map *add_ppm_hash(pid_t pid, const char *name)
 	return ppm;
 }
 
-static void handle_notify(struct blk_io_trace *bit)
+static void handle_notify(struct blk_io_trace2 *bit)
 {
 	void	*payload = (caddr_t) bit + sizeof(*bit);
 	__u32	two32[2];
@@ -802,25 +802,25 @@ static inline struct trace *t_alloc(void)
 	return malloc(sizeof(*t));
 }
 
-static inline void bit_free(struct blk_io_trace *bit)
+static inline void bit_free(struct blk_io_trace2 *bit)
 {
 	if (bit_alloc_cache < 1024 && !bit->pdu_len) {
 		/*
 		 * abuse a 64-bit field for a next pointer for the free item
 		 */
 		bit->time = (__u64) (unsigned long) bit_alloc_list;
-		bit_alloc_list = (struct blk_io_trace *) bit;
+		bit_alloc_list = (struct blk_io_trace2 *) bit;
 		bit_alloc_cache++;
 	} else
 		free(bit);
 }
 
-static inline struct blk_io_trace *bit_alloc(void)
+static inline struct blk_io_trace2 *bit_alloc(void)
 {
-	struct blk_io_trace *bit = bit_alloc_list;
+	struct blk_io_trace2 *bit = bit_alloc_list;
 
 	if (bit) {
-		bit_alloc_list = (struct blk_io_trace *) (unsigned long) \
+		bit_alloc_list = (struct blk_io_trace2 *) (unsigned long) \
 				 bit->time;
 		bit_alloc_cache--;
 		return bit;
@@ -1041,7 +1041,7 @@ static struct io_track *find_track(struct per_dev_info *pdi, pid_t pid,
 }
 
 static void log_track_frontmerge(struct per_dev_info *pdi,
-				 struct blk_io_trace *t)
+				 struct blk_io_trace2 *t)
 {
 	struct io_track *iot;
 
@@ -1062,7 +1062,7 @@ static void log_track_frontmerge(struct per_dev_info *pdi,
 	track_rb_insert(pdi, iot);
 }
 
-static void log_track_getrq(struct per_dev_info *pdi, struct blk_io_trace *t)
+static void log_track_getrq(struct per_dev_info *pdi, struct blk_io_trace2 *t)
 {
 	struct io_track *iot;
 	struct io_track_req *req;
@@ -1081,7 +1081,7 @@ static void log_track_getrq(struct per_dev_info *pdi, struct blk_io_trace *t)
  * for md/dm setups, the interesting cycle is Q -> C. So track queueing
  * time here, as dispatch time
  */
-static void log_track_queue(struct per_dev_info *pdi, struct blk_io_trace *t)
+static void log_track_queue(struct per_dev_info *pdi, struct blk_io_trace2 *t)
 {
 	struct io_track *iot;
 	struct io_track_req *req;
@@ -1096,7 +1096,7 @@ static void log_track_queue(struct per_dev_info *pdi, struct blk_io_trace *t)
 	req->dispatch_time = t->time;
 }
 
-static void log_track_split(struct per_dev_info *pdi, struct blk_io_trace *t)
+static void log_track_split(struct per_dev_info *pdi, struct blk_io_trace2 *t)
 {
 	struct io_track *iot, *split;
 
@@ -1118,7 +1118,7 @@ static void log_track_split(struct per_dev_info *pdi, struct blk_io_trace *t)
  * return time between rq allocation and insertion
  */
 static unsigned long long log_track_insert(struct per_dev_info *pdi,
-					   struct blk_io_trace *t)
+					   struct blk_io_trace2 *t)
 {
 	unsigned long long elapsed;
 	struct io_track *iot;
@@ -1153,7 +1153,7 @@ static unsigned long long log_track_insert(struct per_dev_info *pdi,
  * return time between queue and issue
  */
 static unsigned long long log_track_issue(struct per_dev_info *pdi,
-					  struct blk_io_trace *t)
+					  struct blk_io_trace2 *t)
 {
 	unsigned long long elapsed = -1ULL;
 	struct io_track *iot;
@@ -1191,7 +1191,7 @@ static unsigned long long log_track_issue(struct per_dev_info *pdi,
 	return elapsed;
 }
 
-static void fixup_complete(struct per_dev_info *pdi, struct blk_io_trace *t)
+static void fixup_complete(struct per_dev_info *pdi, struct blk_io_trace2 *t)
 {
 	struct io_track *iot;
 	__u64 start_sector;
@@ -1214,7 +1214,7 @@ static void fixup_complete(struct per_dev_info *pdi, struct blk_io_trace *t)
  * return time between dispatch and complete
  */
 static unsigned long long log_track_complete(struct per_dev_info *pdi,
-					     struct blk_io_trace *t)
+					     struct blk_io_trace2 *t)
 {
 	unsigned long long elapsed = -1ULL;
 	struct io_track *iot, *next;
@@ -1288,7 +1288,7 @@ static char *get_dev_name(struct per_dev_info *pdi, char *buffer, int size)
 	return buffer;
 }
 
-static void check_time(struct per_dev_info *pdi, struct blk_io_trace *bit)
+static void check_time(struct per_dev_info *pdi, struct blk_io_trace2 *bit)
 {
 	unsigned long long this = bit->time;
 	unsigned long long last = pdi->last_reported_time;
@@ -1297,7 +1297,7 @@ static void check_time(struct per_dev_info *pdi, struct blk_io_trace *bit)
 	pdi->last_reported_time = this;
 }
 
-static inline void __account_m(struct io_stats *ios, struct blk_io_trace *t,
+static inline void __account_m(struct io_stats *ios, struct blk_io_trace2 *t,
 			       int rw)
 {
 	if (rw) {
@@ -1311,7 +1311,7 @@ static inline void __account_m(struct io_stats *ios, struct blk_io_trace *t,
 	}
 }
 
-static inline void account_m(struct blk_io_trace *t, struct per_cpu_info *pci,
+static inline void account_m(struct blk_io_trace2 *t, struct per_cpu_info *pci,
 			     int rw)
 {
 	__account_m(&pci->io_stats, t, rw);
@@ -1324,7 +1324,7 @@ static inline void account_m(struct blk_io_trace *t, struct per_cpu_info *pci,
 }
 
 static inline void __account_pc_queue(struct io_stats *ios,
-				      struct blk_io_trace *t, int rw)
+				      struct blk_io_trace2 *t, int rw)
 {
 	if (rw) {
 		ios->qwrites_pc++;
@@ -1337,7 +1337,7 @@ static inline void __account_pc_queue(struct io_stats *ios,
 	}
 }
 
-static inline void account_pc_queue(struct blk_io_trace *t,
+static inline void account_pc_queue(struct blk_io_trace2 *t,
 				    struct per_cpu_info *pci, int rw)
 {
 	__account_pc_queue(&pci->io_stats, t, rw);
@@ -1363,7 +1363,7 @@ static inline void __account_pc_issue(struct io_stats *ios, int rw,
 	}
 }
 
-static inline void account_pc_issue(struct blk_io_trace *t,
+static inline void account_pc_issue(struct blk_io_trace2 *t,
 				    struct per_cpu_info *pci, int rw)
 {
 	__account_pc_issue(&pci->io_stats, rw, t->bytes);
@@ -1376,7 +1376,7 @@ static inline void account_pc_issue(struct blk_io_trace *t,
 }
 
 static inline void __account_pc_requeue(struct io_stats *ios,
-					struct blk_io_trace *t, int rw)
+					struct blk_io_trace2 *t, int rw)
 {
 	if (rw) {
 		ios->wrqueue_pc++;
@@ -1389,7 +1389,7 @@ static inline void __account_pc_requeue(struct io_stats *ios,
 	}
 }
 
-static inline void account_pc_requeue(struct blk_io_trace *t,
+static inline void account_pc_requeue(struct blk_io_trace2 *t,
 				      struct per_cpu_info *pci, int rw)
 {
 	__account_pc_requeue(&pci->io_stats, t, rw);
@@ -1409,7 +1409,7 @@ static inline void __account_pc_c(struct io_stats *ios, int rw)
 		ios->creads_pc++;
 }
 
-static inline void account_pc_c(struct blk_io_trace *t,
+static inline void account_pc_c(struct blk_io_trace2 *t,
 				struct per_cpu_info *pci, int rw)
 {
 	__account_pc_c(&pci->io_stats, rw);
@@ -1421,7 +1421,7 @@ static inline void account_pc_c(struct blk_io_trace *t,
 	}
 }
 
-static inline void __account_queue(struct io_stats *ios, struct blk_io_trace *t,
+static inline void __account_queue(struct io_stats *ios, struct blk_io_trace2 *t,
 				   int rw)
 {
 	if (rw) {
@@ -1435,7 +1435,7 @@ static inline void __account_queue(struct io_stats *ios, struct blk_io_trace *t,
 	}
 }
 
-static inline void account_queue(struct blk_io_trace *t,
+static inline void account_queue(struct blk_io_trace2 *t,
 				 struct per_cpu_info *pci, int rw)
 {
 	__account_queue(&pci->io_stats, t, rw);
@@ -1460,7 +1460,7 @@ static inline void __account_c(struct io_stats *ios, int rw, int bytes)
 	}
 }
 
-static inline void account_c(struct blk_io_trace *t, struct per_cpu_info *pci,
+static inline void account_c(struct blk_io_trace2 *t, struct per_cpu_info *pci,
 			     int rw, int bytes)
 {
 	__account_c(&pci->io_stats, rw, bytes);
@@ -1486,7 +1486,7 @@ static inline void __account_issue(struct io_stats *ios, int rw,
 	}
 }
 
-static inline void account_issue(struct blk_io_trace *t,
+static inline void account_issue(struct blk_io_trace2 *t,
 				 struct per_cpu_info *pci, int rw)
 {
 	__account_issue(&pci->io_stats, rw, t->bytes);
@@ -1506,7 +1506,7 @@ static inline void __account_unplug(struct io_stats *ios, int timer)
 		ios->io_unplugs++;
 }
 
-static inline void account_unplug(struct blk_io_trace *t,
+static inline void account_unplug(struct blk_io_trace2 *t,
 				  struct per_cpu_info *pci, int timer)
 {
 	__account_unplug(&pci->io_stats, timer);
@@ -1519,7 +1519,7 @@ static inline void account_unplug(struct blk_io_trace *t,
 }
 
 static inline void __account_requeue(struct io_stats *ios,
-				     struct blk_io_trace *t, int rw)
+				     struct blk_io_trace2 *t, int rw)
 {
 	if (rw) {
 		ios->wrqueue++;
@@ -1532,7 +1532,7 @@ static inline void __account_requeue(struct io_stats *ios,
 	}
 }
 
-static inline void account_requeue(struct blk_io_trace *t,
+static inline void account_requeue(struct blk_io_trace2 *t,
 				   struct per_cpu_info *pci, int rw)
 {
 	__account_requeue(&pci->io_stats, t, rw);
@@ -1545,31 +1545,31 @@ static inline void account_requeue(struct blk_io_trace *t,
 }
 
 static void log_complete(struct per_dev_info *pdi, struct per_cpu_info *pci,
-			 struct blk_io_trace *t, char *act)
+			 struct blk_io_trace2 *t, char *act)
 {
 	process_fmt(act, pci, t, log_track_complete(pdi, t), 0, NULL);
 }
 
 static void log_insert(struct per_dev_info *pdi, struct per_cpu_info *pci,
-		       struct blk_io_trace *t, char *act)
+		       struct blk_io_trace2 *t, char *act)
 {
 	process_fmt(act, pci, t, log_track_insert(pdi, t), 0, NULL);
 }
 
-static void log_queue(struct per_cpu_info *pci, struct blk_io_trace *t,
+static void log_queue(struct per_cpu_info *pci, struct blk_io_trace2 *t,
 		      char *act)
 {
 	process_fmt(act, pci, t, -1, 0, NULL);
 }
 
 static void log_issue(struct per_dev_info *pdi, struct per_cpu_info *pci,
-		      struct blk_io_trace *t, char *act)
+		      struct blk_io_trace2 *t, char *act)
 {
 	process_fmt(act, pci, t, log_track_issue(pdi, t), 0, NULL);
 }
 
 static void log_merge(struct per_dev_info *pdi, struct per_cpu_info *pci,
-		      struct blk_io_trace *t, char *act)
+		      struct blk_io_trace2 *t, char *act)
 {
 	if (act[0] == 'F')
 		log_track_frontmerge(pdi, t);
@@ -1577,38 +1577,38 @@ static void log_merge(struct per_dev_info *pdi, struct per_cpu_info *pci,
 	process_fmt(act, pci, t, -1ULL, 0, NULL);
 }
 
-static void log_action(struct per_cpu_info *pci, struct blk_io_trace *t,
+static void log_action(struct per_cpu_info *pci, struct blk_io_trace2 *t,
 			char *act)
 {
 	process_fmt(act, pci, t, -1ULL, 0, NULL);
 }
 
-static void log_generic(struct per_cpu_info *pci, struct blk_io_trace *t,
+static void log_generic(struct per_cpu_info *pci, struct blk_io_trace2 *t,
 			char *act)
 {
 	process_fmt(act, pci, t, -1ULL, 0, NULL);
 }
 
-static void log_unplug(struct per_cpu_info *pci, struct blk_io_trace *t,
+static void log_unplug(struct per_cpu_info *pci, struct blk_io_trace2 *t,
 		      char *act)
 {
 	process_fmt(act, pci, t, -1ULL, 0, NULL);
 }
 
-static void log_split(struct per_cpu_info *pci, struct blk_io_trace *t,
+static void log_split(struct per_cpu_info *pci, struct blk_io_trace2 *t,
 		      char *act)
 {
 	process_fmt(act, pci, t, -1ULL, 0, NULL);
 }
 
-static void log_pc(struct per_cpu_info *pci, struct blk_io_trace *t, char *act)
+static void log_pc(struct per_cpu_info *pci, struct blk_io_trace2 *t, char *act)
 {
 	unsigned char *buf = (unsigned char *) t + sizeof(*t);
 
 	process_fmt(act, pci, t, -1ULL, t->pdu_len, buf);
 }
 
-static void dump_trace_pc(struct blk_io_trace *t, struct per_dev_info *pdi,
+static void dump_trace_pc(struct blk_io_trace2 *t, struct per_dev_info *pdi,
 			  struct per_cpu_info *pci)
 {
 	int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
@@ -1657,7 +1657,7 @@ static void dump_trace_pc(struct blk_io_trace *t, struct per_dev_info *pdi,
 	}
 }
 
-static void dump_trace_fs(struct blk_io_trace *t, struct per_dev_info *pdi,
+static void dump_trace_fs(struct blk_io_trace2 *t, struct per_dev_info *pdi,
 			  struct per_cpu_info *pci)
 {
 	int w = (t->action & BLK_TC_ACT(BLK_TC_WRITE)) != 0;
@@ -1737,12 +1737,12 @@ static void dump_trace_fs(struct blk_io_trace *t, struct per_dev_info *pdi,
 			/* dump to binary file only */
 			break;
 		default:
-			fprintf(stderr, "Bad fs action %x\n", t->action);
+			fprintf(stderr, "Bad fs action %llx\n", t->action);
 			break;
 	}
 }
 
-static void dump_trace(struct blk_io_trace *t, struct per_cpu_info *pci,
+static void dump_trace(struct blk_io_trace2 *t, struct per_cpu_info *pci,
 		       struct per_dev_info *pdi)
 {
 	if (text_output) {
@@ -2162,7 +2162,7 @@ static void find_genesis(void)
 	}
 }
 
-static inline int check_stopwatch(struct blk_io_trace *bit)
+static inline int check_stopwatch(struct blk_io_trace2 *bit)
 {
 	if (bit->time < stopwatch_end &&
 	    bit->time >= stopwatch_start)
@@ -2185,7 +2185,7 @@ static int sort_entries(unsigned long long *youngest)
 
 	*youngest = 0;
 	while ((t = trace_list) != NULL) {
-		struct blk_io_trace *bit = t->bit;
+		struct blk_io_trace2 *bit = t->bit;
 
 		trace_list = t->next;
 
@@ -2264,7 +2264,7 @@ static int check_cpu_map(struct per_dev_info *pdi)
 
 static int check_sequence(struct per_dev_info *pdi, struct trace *t, int force)
 {
-	struct blk_io_trace *bit = t->bit;
+	struct blk_io_trace2 *bit = t->bit;
 	unsigned long expected_sequence;
 	struct per_cpu_info *pci;
 	struct trace *__t;
@@ -2315,7 +2315,7 @@ static void show_entries_rb(int force)
 {
 	struct per_dev_info *pdi = NULL;
 	struct per_cpu_info *pci = NULL;
-	struct blk_io_trace *bit;
+	struct blk_io_trace2 *bit;
 	struct rb_node *n;
 	struct trace *t;
 
@@ -2428,12 +2428,22 @@ static inline __u32 get_magic(__u32 magic)
 	return __bswap_32(magic);
 }
 
-static int read_one_bit(int fd, struct blk_io_trace *bit, int block,
+static int read_one_bit(int fd, struct blk_io_trace2 **bit2, int block,
 			int *fdblock)
 {
+	struct blk_io_trace2 *new = *bit2;
+	struct blk_io_trace *bit;
 	int ret;
 	int pdu_len;
-	void *p = (void *) ((u8 *)bit + sizeof(__u32));
+	void *p;
+
+	bit = malloc(sizeof(*bit));
+	if (!bit)
+		return -1;
+
+	bit->magic = new->magic;
+
+	p = (void *) ((u8 *)bit + sizeof(__u32));
 
 	ret = read_data(fd, p, sizeof(*bit) - sizeof(__u32), block, fdblock);
 	if (ret)
@@ -2449,9 +2459,14 @@ static int read_one_bit(int fd, struct blk_io_trace *bit, int block,
 			return ret;
 		}
 		bit = ptr;
+
+		new = realloc(*bit2, sizeof(struct blk_io_trace2) + pdu_len);
 	}
 
 	bit_trace_to_cpu(bit);
+	bit_to_bit2(bit, new);
+	free(bit);
+	*bit2 = new;
 
 	return 0;
 }
@@ -2491,11 +2506,11 @@ static int read_events(int fd, int always_block, int *fdblock)
 		}
 		version = magic & 0xff;
 		if (version == SUPPORTED_VERSION) {
-			struct blk_io_trace *bit;
+			struct blk_io_trace2 *bit;
 			bit = bit_alloc();
 			bit->magic = magic;
 
-			ret = read_one_bit(fd, bit, 1, fdblock);
+			ret = read_one_bit(fd, &bit, 1, fdblock);
 			if (ret)
 				break;
 
@@ -2620,7 +2635,7 @@ static int ms_prime(struct ms_stream *msp)
 	struct trace *t;
 	struct per_dev_info *pdi = msp->pdi;
 	struct per_cpu_info *pci = get_cpu_info(pdi, msp->cpu);
-	struct blk_io_trace *bit = NULL;
+	struct blk_io_trace2 *bit = NULL;
 	int ret, ndone = 0;
 
 	for (i = 0; !is_done() && pci->fd >= 0 && i < rb_batch; i++) {
@@ -2645,7 +2660,7 @@ static int ms_prime(struct ms_stream *msp)
 			bit = bit_alloc();
 			bit->magic = magic;
 
-			ret = read_one_bit(pci->fd, bit, 1, &pci->fdblock);
+			ret = read_one_bit(pci->fd, &bit, 1, &pci->fdblock);
 			if (ret)
 				goto err;
 
@@ -2767,7 +2782,7 @@ static int handle(struct ms_stream *msp)
 	struct trace *t;
 	struct per_dev_info *pdi;
 	struct per_cpu_info *pci;
-	struct blk_io_trace *bit;
+	struct blk_io_trace2 *bit;
 
 	t = ms_peek(msp);
 
diff --git a/blkparse_fmt.c b/blkparse_fmt.c
index 02c5a3c..f93addb 100644
--- a/blkparse_fmt.c
+++ b/blkparse_fmt.c
@@ -51,7 +51,7 @@ int add_format_spec(char *option)
 	return 0;
 }
 
-static inline void fill_rwbs(char *rwbs, struct blk_io_trace *t)
+static inline void fill_rwbs(char *rwbs, struct blk_io_trace2 *t)
 {
 	bool w = !!(t->action & BLK_TC_ACT(BLK_TC_WRITE));
 	bool a = !!(t->action & BLK_TC_ACT(BLK_TC_AHEAD));
@@ -146,16 +146,16 @@ static char *dump_pdu(unsigned char *pdu_buf, int pdu_len)
 	return p;
 }
 
-#define pdu_start(t)	(((void *) (t) + sizeof(struct blk_io_trace)))
+#define pdu_start(t)	(((void *) (t) + sizeof(struct blk_io_trace2)))
 
-static unsigned int get_pdu_int(struct blk_io_trace *t)
+static unsigned int get_pdu_int(struct blk_io_trace2 *t)
 {
 	__u64 *val = pdu_start(t);
 
 	return be64_to_cpu(*val);
 }
 
-static void get_pdu_remap(struct blk_io_trace *t, struct blk_io_trace_remap *r)
+static void get_pdu_remap(struct blk_io_trace2 *t, struct blk_io_trace_remap *r)
 {
 	struct blk_io_trace_remap *__r = pdu_start(t);
 	__u64 sector_from = __r->sector_from;
@@ -166,7 +166,7 @@ static void get_pdu_remap(struct blk_io_trace *t, struct blk_io_trace_remap *r)
 }
 
 static void print_field(char *act, struct per_cpu_info *pci,
-			struct blk_io_trace *t, unsigned long long elapsed,
+			struct blk_io_trace2 *t, unsigned long long elapsed,
 			int pdu_len, unsigned char *pdu_buf, char field,
 			int minus, int has_w, int width)
 {
@@ -275,7 +275,7 @@ static void print_field(char *act, struct per_cpu_info *pci,
 }
 
 static char *parse_field(char *act, struct per_cpu_info *pci,
-			 struct blk_io_trace *t, unsigned long long elapsed,
+			 struct blk_io_trace2 *t, unsigned long long elapsed,
 			 int pdu_len, unsigned char *pdu_buf,
 			 char *primary_format)
 {
@@ -302,7 +302,7 @@ static char *parse_field(char *act, struct per_cpu_info *pci,
 }
 
 static void process_default(char *act, struct per_cpu_info *pci,
-			    struct blk_io_trace *t, unsigned long long elapsed,
+			    struct blk_io_trace2 *t, unsigned long long elapsed,
 			    int pdu_len, unsigned char *pdu_buf)
 {
 	struct blk_io_trace_remap r = { .device_from = 0, };
@@ -436,7 +436,7 @@ static void process_default(char *act, struct per_cpu_info *pci,
 
 }
 
-void process_fmt(char *act, struct per_cpu_info *pci, struct blk_io_trace *t,
+void process_fmt(char *act, struct per_cpu_info *pci, struct blk_io_trace2 *t,
 		 unsigned long long elapsed, int pdu_len,
 		 unsigned char *pdu_buf)
 {
diff --git a/blktrace.h b/blktrace.h
index 08ac28b..196b3c9 100644
--- a/blktrace.h
+++ b/blktrace.h
@@ -6,6 +6,7 @@
 #include <byteswap.h>
 #include <endian.h>
 #include <sys/types.h>
+#include <string.h>
 
 #include "blktrace_api.h"
 #include "rbtree.h"
@@ -108,6 +109,26 @@ static inline int verify_trace(__u32 magic)
 	return 0;
 }
 
+static inline void bit_to_bit2(struct blk_io_trace *old,
+			       struct blk_io_trace2 *new)
+{
+	new->magic	= old->magic;
+	new->sequence	= old->sequence;
+	new->time	= old->time;
+	new->sector	= old->sector;
+	new->bytes	= old->bytes;
+	new->action	= 0 | old->action;
+	new->pid	= old->pid;
+	new->device	= old->device;
+	new->cpu	= old->cpu;
+	new->error	= old->error;
+	new->pdu_len	= old->pdu_len;
+
+	if (new->pdu_len)
+		memcpy(((u8 *) new + sizeof(*new)), ((u8 *)old + sizeof(*old)),
+		       old->pdu_len);
+}
+
 static inline void bit_trace_to_cpu(struct blk_io_trace *t)
 {
 	if (data_is_native)
@@ -147,7 +168,7 @@ static inline int check_data_endianness(u32 magic)
 
 extern void set_all_format_specs(char *);
 extern int add_format_spec(char *);
-extern void process_fmt(char *, struct per_cpu_info *, struct blk_io_trace *,
+extern void process_fmt(char *, struct per_cpu_info *, struct blk_io_trace2 *,
 			unsigned long long, int, unsigned char *);
 extern unsigned long long valid_act_opt(unsigned long long);
 extern int find_mask_map(char *);
-- 
2.51.0



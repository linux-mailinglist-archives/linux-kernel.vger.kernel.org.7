Return-Path: <linux-kernel+bounces-893227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9108DC46D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE7F3A9519
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98CC30CD8E;
	Mon, 10 Nov 2025 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wc0Yj48l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73705194A73
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780885; cv=none; b=nyfJ5hqL5dQMyfF6ADQJxQmq9616Yc7SZgeLkG2OMgcWB+esq7pIf3fHNqb5khrOpPHO6rR44EySb+rtcoZPDcSU69C11OYSuA1fvMnp0kqwOPSGnf18vt037H5fEQzv4hVP1d/i3gzh9uhol1PDWdun3bkFyGetdUnCNOs50s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780885; c=relaxed/simple;
	bh=2GTFgdAnWbtD+/iR7jVUqOVzTpPf3eQFAjyo/q/nmXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tl3FKEfWUSawem/N6p2pfG9GKYLL1GddVIsMLgM52+D3wNQ9DGS5MQWHabW4oHNw8aibN2vtP8pvuW68h57qo3R6XQEPJ40x7zIACdh/pibq6uT8YBc5o5+VIo+a7c9g2zQtYQYLPyn/sGkMxWUzABM80J1bIZAaPrglrUWtEL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wc0Yj48l; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762780883; x=1794316883;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2GTFgdAnWbtD+/iR7jVUqOVzTpPf3eQFAjyo/q/nmXQ=;
  b=Wc0Yj48lmF6+7hs/yrg+uYIQHsku5qiIY65kzURMV8JWj1gL9cLqndG9
   RI0QHsDHITw/6ucBnrHdzqkCsQPg5njd/y2xIqsBfMI7o2J5mSY4w/Yw6
   0g45ZYGXRNGOLLtFc/VxR83yfQ/5u9CF2OaDBYZp1PwM7crKB6+VWiaAN
   rjs0BM8iuV4lhCtJX78mSQC9Sm44Os3XM2w676iS+KYJd3IaEn/iUqan5
   AiesxOL2cMr6x8w+0KHjc3OjJ5aTNwPPlZxZM4Jkm4iinOt+um2KF9Q8o
   IDvowSojxJXpO/cgxEendJH7kacbQkFRGTvrSyS/Ypsv5PAVOqg+BFggF
   w==;
X-CSE-ConnectionGUID: +tyFu4kEQyacE9udZTrmVg==
X-CSE-MsgGUID: csmcySN8SGuCFZPqYDMZmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="90299322"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="90299322"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:21:23 -0800
X-CSE-ConnectionGUID: kNh9jGU4QceGW7ij1Vgv1w==
X-CSE-MsgGUID: Y4fxovNxTbyii95xJhQ0kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="187926937"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 10 Nov 2025 05:21:21 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4B52795; Mon, 10 Nov 2025 14:21:20 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/1] lib/vsprintf: Check pointer before dereferencing in time_and_date()
Date: Mon, 10 Nov 2025 14:21:18 +0100
Message-ID: <20251110132118.4113976-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pointer may be invalid when gets to the printf(). In particular
the time_and_date() dereferencing it in some cases without checking.

Move the check from rtc_str() to time_and_date() to cover all cases.

Fixes: 7daac5b2fdf8 ("lib/vsprintf: Print time64_t in human readable format")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index e49f350ee549..3f99834fd788 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1928,9 +1928,6 @@ char *rtc_str(char *buf, char *end, const struct rtc_time *tm,
 	bool found = true;
 	int count = 2;
 
-	if (check_pointer(&buf, end, tm, spec))
-		return buf;
-
 	switch (fmt[count]) {
 	case 'd':
 		have_t = false;
@@ -1996,6 +1993,9 @@ static noinline_for_stack
 char *time_and_date(char *buf, char *end, void *ptr, struct printf_spec spec,
 		    const char *fmt)
 {
+	if (check_pointer(&buf, end, ptr, spec))
+		return buf;
+
 	switch (fmt[1]) {
 	case 'R':
 		return rtc_str(buf, end, (const struct rtc_time *)ptr, spec, fmt);
-- 
2.50.1



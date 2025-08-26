Return-Path: <linux-kernel+bounces-786602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3ADB35F01
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B16685786
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCFA33439F;
	Tue, 26 Aug 2025 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cE6e+/nl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D4E321457
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210747; cv=none; b=gsK4JONgTaU4VwEs9r4PphuSlWLDgdgdCVG1NoeHqRQ20Q5uU//YocQZ783gd4iYH7gnhjUeodGzstN9yJ2MbZ7ROaukktt9r9I/ZHMnEsNqcQmjWnsFq+AKv/rGO6XdrQzyR4vWvUYm7QAIjAoHOeva1J1YW8Kt3zRwvi4YaxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210747; c=relaxed/simple;
	bh=iSWqkZTtB6eEPQcdTdV/Qd/XnBlny5HUFok2Z1oxgdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eXQ3GGGYbGCBMHsdcZDIXqAJl91dHXfNACvnAyU+/+/9NmiAA28fRfUJiwvzOezR7rwGcGE4yVUe+SfpAhwdQ4ZD/8UQ3LB4e+O91PCKJ6w2CZlBYPsSQOXxV8c3I1KvVvJ+S+KiAv1k+HpipMUZA/SuDgc/vSTvV8o5nW9D5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cE6e+/nl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756210745; x=1787746745;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iSWqkZTtB6eEPQcdTdV/Qd/XnBlny5HUFok2Z1oxgdQ=;
  b=cE6e+/nlqF0phEbu8eRZ76tZJ4BZMBZPqTERFJfkIj+25f1eHFQU+fLQ
   Rvg3dLxVlMCPJ4F12k5iiH+2jR6VYGsj/WzlE/ibGbOUwqW8ql/5ykWnI
   6MgaE+XIzP+nWnq3Rv4EW1qupMnxvude3XUVpGGSSVJ8zNOk9oHvr3e5q
   IRFyPDbxtqI08/UMeLSIBYdT9U74mqWZwfWDDh9ySFGHzIFR9vJ1EBoat
   TygfOOZK1FOFuPR0XZ9AtDWNtnRIQtWEzFMk55prSTqF5XyGitKYKzC+b
   isKd1GpPUV1P67Y5wwsvLrucgC4PYo5+neqJfNC492Av5lITdYDRnJkIp
   Q==;
X-CSE-ConnectionGUID: bDxml4EqQWmcYK1ScS+idQ==
X-CSE-MsgGUID: +/lFwTrmRs6l6FNhDCiO9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62087775"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62087775"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 05:19:05 -0700
X-CSE-ConnectionGUID: hw19vAroSYqnXs0LusRgOg==
X-CSE-MsgGUID: kfU/Xs5KQOCNO9ew1mr8ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="174866502"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO stinkbox) ([10.245.245.254])
  by orviesa005.jf.intel.com with SMTP; 26 Aug 2025 05:19:00 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 26 Aug 2025 15:18:59 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Dibin Moolakadan Subrahmanian <dibin.moolakadan.subrahmanian@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	David Laight <david.laight.linux@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Matt Wagantall <mattw@codeaurora.org>,
	Dejin Zheng <zhengdejin5@gmail.com>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH v2 1/3] iopoll: Generalize read_poll_timeout() into poll_timeout_us()
Date: Tue, 26 Aug 2025 15:18:57 +0300
Message-ID: <20250826121859.15497-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

While read_poll_timeout() & co. were originally introduced just
for simple I/O usage scenarios they have since been generalized to
be useful in more cases.

However the interface is very cumbersome to use in the general case.
Attempt to make it more flexible by combining the 'op', 'var' and
'args' parameter into just a single 'op' that the caller can fully
specify.

For example i915 has one case where one might currently
have to write something like:
	ret = read_poll_timeout(drm_dp_dpcd_read_byte, err,
				err || (status & mask),
				0 * 1000, 200 * 1000, false,
				aux, DP_FEC_STATUS, &status);
which is practically illegible, but with the adjusted macro
we do:
	ret = poll_timeout_us(err = drm_dp_dpcd_read_byte(aux, DP_FEC_STATUS, &status),
			      err || (status & mask),
			      0 * 1000, 200 * 1000, false);
which much easier to understand.

One could even combine the 'op' and 'cond'  parameters into
one, but that might make the caller a bit too unwieldly with
assignments and checks being done on the same statement.

This makes poll_timeout_us() closer to the i915 __wait_for()
macro, with the main difference being that __wait_for() uses
expenential backoff as opposed to the fixed polling interval
used by poll_timeout_us(). Eventually we might be able to switch
(at least most of) i915 to use poll_timeout_us().

v2: Fix typos (Jani)
    Fix delay_us docs for poll_timeout_us_atomic() (Jani)

Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Dibin Moolakadan Subrahmanian <dibin.moolakadan.subrahmanian@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: David Laight <david.laight.linux@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Matt Wagantall <mattw@codeaurora.org>
Cc: Dejin Zheng <zhengdejin5@gmail.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 include/linux/iopoll.h | 110 +++++++++++++++++++++++++++++------------
 1 file changed, 78 insertions(+), 32 deletions(-)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 91324c331a4b..440aca5b4b59 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -14,41 +14,38 @@
 #include <linux/io.h>
 
 /**
- * read_poll_timeout - Periodically poll an address until a condition is
- *			met or a timeout occurs
- * @op: accessor function (takes @args as its arguments)
- * @val: Variable to read the value into
- * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Please
- *            read usleep_range() function description for details and
+ * poll_timeout_us - Periodically poll and perform an operation until
+ *                   a condition is met or a timeout occurs
+ *
+ * @op: Operation
+ * @cond: Break condition
+ * @sleep_us: Maximum time to sleep between operations in us (0 tight-loops).
+ *            Please read usleep_range() function description for details and
  *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
- * @sleep_before_read: if it is true, sleep @sleep_us before read.
- * @args: arguments for @op poll
+ * @sleep_before_op: if it is true, sleep @sleep_us before operation.
  *
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
  *
- * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
- * case, the last read value at @args is stored in @val. Must not
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. Must not
  * be called from atomic context if sleep_us or timeout_us are used.
  */
-#define read_poll_timeout(op, val, cond, sleep_us, timeout_us, \
-				sleep_before_read, args...) \
+#define poll_timeout_us(op, cond, sleep_us, timeout_us, sleep_before_op) \
 ({ \
 	u64 __timeout_us = (timeout_us); \
 	unsigned long __sleep_us = (sleep_us); \
 	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
 	might_sleep_if((__sleep_us) != 0); \
-	if (sleep_before_read && __sleep_us) \
+	if ((sleep_before_op) && __sleep_us) \
 		usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
 	for (;;) { \
-		(val) = op(args); \
+		op; \
 		if (cond) \
 			break; \
 		if (__timeout_us && \
 		    ktime_compare(ktime_get(), __timeout) > 0) { \
-			(val) = op(args); \
+			op; \
 			break; \
 		} \
 		if (__sleep_us) \
@@ -59,17 +56,16 @@
 })
 
 /**
- * read_poll_timeout_atomic - Periodically poll an address until a condition is
- * 				met or a timeout occurs
- * @op: accessor function (takes @args as its arguments)
- * @val: Variable to read the value into
- * @cond: Break condition (usually involving @val)
- * @delay_us: Time to udelay between reads in us (0 tight-loops). Please
- *            read udelay() function description for details and
+ * poll_timeout_us_atomic - Periodically poll and perform an operation until
+ *                          a condition is met or a timeout occurs
+ *
+ * @op: Operation
+ * @cond: Break condition
+ * @delay_us: Time to udelay between operations in us (0 tight-loops).
+ *            Please read udelay() function description for details and
  *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
- * @delay_before_read: if it is true, delay @delay_us before read.
- * @args: arguments for @op poll
+ * @delay_before_op: if it is true, delay @delay_us before operation.
  *
  * This macro does not rely on timekeeping.  Hence it is safe to call even when
  * timekeeping is suspended, at the expense of an underestimation of wall clock
@@ -78,27 +74,26 @@
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
  *
- * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
- * case, the last read value at @args is stored in @val.
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout.
  */
-#define read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, \
-					delay_before_read, args...) \
+#define poll_timeout_us_atomic(op, cond, delay_us, timeout_us, \
+			       delay_before_op) \
 ({ \
 	u64 __timeout_us = (timeout_us); \
 	s64 __left_ns = __timeout_us * NSEC_PER_USEC; \
 	unsigned long __delay_us = (delay_us); \
 	u64 __delay_ns = __delay_us * NSEC_PER_USEC; \
-	if (delay_before_read && __delay_us) { \
+	if ((delay_before_op) && __delay_us) { \
 		udelay(__delay_us); \
 		if (__timeout_us) \
 			__left_ns -= __delay_ns; \
 	} \
 	for (;;) { \
-		(val) = op(args); \
+		op; \
 		if (cond) \
 			break; \
 		if (__timeout_us && __left_ns < 0) { \
-			(val) = op(args); \
+			op; \
 			break; \
 		} \
 		if (__delay_us) { \
@@ -113,6 +108,57 @@
 	(cond) ? 0 : -ETIMEDOUT; \
 })
 
+/**
+ * read_poll_timeout - Periodically poll an address until a condition is
+ *                     met or a timeout occurs
+ * @op: accessor function (takes @args as its arguments)
+ * @val: Variable to read the value into
+ * @cond: Break condition (usually involving @val)
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Please
+ *            read usleep_range() function description for details and
+ *            limitations.
+ * @timeout_us: Timeout in us, 0 means never timeout
+ * @sleep_before_read: if it is true, sleep @sleep_us before read.
+ * @args: arguments for @op poll
+ *
+ * When available, you'll probably want to use one of the specialized
+ * macros defined below rather than this macro directly.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @args is stored in @val. Must not
+ * be called from atomic context if sleep_us or timeout_us are used.
+ */
+#define read_poll_timeout(op, val, cond, sleep_us, timeout_us, \
+			  sleep_before_read, args...) \
+	poll_timeout_us((val) = op(args), cond, sleep_us, timeout_us, sleep_before_read)
+
+/**
+ * read_poll_timeout_atomic - Periodically poll an address until a condition is
+ *                            met or a timeout occurs
+ * @op: accessor function (takes @args as its arguments)
+ * @val: Variable to read the value into
+ * @cond: Break condition (usually involving @val)
+ * @delay_us: Time to udelay between reads in us (0 tight-loops). Please
+ *            read udelay() function description for details and
+ *            limitations.
+ * @timeout_us: Timeout in us, 0 means never timeout
+ * @delay_before_read: if it is true, delay @delay_us before read.
+ * @args: arguments for @op poll
+ *
+ * This macro does not rely on timekeeping.  Hence it is safe to call even when
+ * timekeeping is suspended, at the expense of an underestimation of wall clock
+ * time, which is rather minimal with a non-zero delay_us.
+ *
+ * When available, you'll probably want to use one of the specialized
+ * macros defined below rather than this macro directly.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @args is stored in @val.
+ */
+#define read_poll_timeout_atomic(op, val, cond, sleep_us, timeout_us, \
+				 sleep_before_read, args...) \
+	poll_timeout_us_atomic((val) = op(args), cond, sleep_us, timeout_us, sleep_before_read)
+
 /**
  * readx_poll_timeout - Periodically poll an address until a condition is met or a timeout occurs
  * @op: accessor function (takes @addr as its only argument)
-- 
2.49.1



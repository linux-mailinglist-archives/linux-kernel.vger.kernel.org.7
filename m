Return-Path: <linux-kernel+bounces-784754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE76B340A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F99F5E14A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0EA271475;
	Mon, 25 Aug 2025 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oQ4oyah1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xSp/HVXY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD35EEBD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128426; cv=none; b=diixWwm7jyebeuR4Zgtyjfbbw6Ni8loQ0HsLRZOr3b5C72fJH8c6aaVdVhHpUSGxl+WPVGAsdX/FEKgwilVABcxx70QdRzI6Gq1vciCkYn6y61GWaAMepSCJAaCjkQiVuqfgMgGQxA5sozRZTMRsQ4ULawQjGB9NkOM9K7WfmUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128426; c=relaxed/simple;
	bh=f3ZxtFOEjIm2Swpt5CikUJ8HD352UYslWAJiMY7MzPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h8NccUEvI4pVjlcFztwkRRtytkd/dkQl4MnVZEJfMXFsNSNvXh+FVEEbUipQhsjFL1G99TL+RdcooKeFNJ6YjeHdbQwjlNBgJac7NCBncoUcTEnaHCBDKOdpRffSPDOV+mgKVdBxur3MAV3cnB6C40CkZ8xYy31Z3JmJFLGGNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oQ4oyah1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xSp/HVXY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756128422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uREvxONA7PVpWJ+0rAV4KUBrUUY/uuTfiPY2Ynpy2aM=;
	b=oQ4oyah1SDXB1vUUFrfvD2+2jxy9sb/k6RrGbevxvsf05gg6Rid48RlvHZnOZlAQdL3Nta
	SN2Vg1zpvdC84wiN2vuufHna0dd8laomgg6Pl5e+Cg89F9joMZaMGbV4jB0bD83+Yf8gyd
	QSQ9K5l2iCRR+h4Nl/qalBTjQDHC2OKOwu3vLB7e9E/Qw43fr37XvIHmW9azvci0rVhpDC
	7FrUk9Uk8JR3xd+f7BMXlfg73PXbTW+enAIiW4iMyH5fp2J39BWi/SqDJGTfWu+EF9je4F
	EGikMjveKxcd0zXgN+CIowhWPM2UiAmD2v3n2DLqMy+7WOVuZd+hXS3b/SMePg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756128422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uREvxONA7PVpWJ+0rAV4KUBrUUY/uuTfiPY2Ynpy2aM=;
	b=xSp/HVXYnqF17b9BaxAK8ZrYQPVaIA2sAXVfVHS4f2DOjUNbc4A/OzHrzBLxSPliGrwWP6
	JyV35GwwnHjw4ZAw==
Date: Mon, 25 Aug 2025 15:26:35 +0200
Subject: [PATCH] vdso/vsyscall: Avoid slow division loop in auxiliary clock
 update
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250825-vdso-auxclock-division-v1-1-a1d32a16a313@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAIpkrGgC/yXMMQqAMAxA0atIZgM1aCleRRykiRoUKy2KIN7do
 uMf3r8hSVRJ0BY3RDk1adhyVGUBfh62SVA5N5Chxjhq8OQUcDguvwa/IOtPkBzVllxVs2XIeI8
 y6vWNu/55XizwNpVoAAAA
X-Change-ID: 20250825-vdso-auxclock-division-282462814d6d
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756128419; l=4927;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=f3ZxtFOEjIm2Swpt5CikUJ8HD352UYslWAJiMY7MzPg=;
 b=lRqSw1Bpl6UCUl/60yr0gZ66PX9woYd7ZcUDBqWs9cnyi99Z0vMs3l/KT5GGFtOWQf0PBkOMB
 pbTfbjkICKmBid7T/U23DUy8KehnXvHDtSRGCHXXGqAa0kO+3hov78V
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The call to __iter_div_u64_rem() in vdso_time_update_aux() is a
wrapper around subtraction. It can not be used to divide large numbers,
as that introduces long, computationally expensive delays.
A regular u64 division is also not possible in the timekeeper update path
as it can be too slow.

Instead of splitting the ktime_t offset into into second and subsecond
components during the timekeeper update fast-path, do it together with the
adjustment of tk->offs_aux in the slow-path. Equivalent to the handling of
offs_boot and monotonic_to_boot.

Reuse the storage of monotonic_to_boot for the new field, as it is not used
by auxiliary timekeepers.

Reported-by: Miroslav Lichvar <mlichvar@redhat.com>
Closes: https://lore.kernel.org/lkml/aKwsNNWsHJg8IKzj@localhost/
Fixes: 380b84e168e5 ("vdso/vsyscall: Update auxiliary clock data in the datapage")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/timekeeper_internal.h |  9 ++++++++-
 kernel/time/timekeeping.c           | 10 ++++++++--
 kernel/time/vsyscall.c              |  4 ++--
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index c27aac67cb3f15f0892c667a990d4a6e16a06d76..b8ae89ea28abfca96f424b6a2250de7ebfe6364e 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -76,6 +76,7 @@ struct tk_read_base {
  * @cs_was_changed_seq:		The sequence number of clocksource change events
  * @clock_valid:		Indicator for valid clock
  * @monotonic_to_boot:		CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
+ * @monotonic_to_aux:		CLOCK_MONOTONIC to CLOCK_AUX offset
  * @cycle_interval:		Number of clock cycles in one NTP interval
  * @xtime_interval:		Number of clock shifted nano seconds in one NTP
  *				interval.
@@ -117,6 +118,9 @@ struct tk_read_base {
  * @offs_aux is used by the auxiliary timekeepers which do not utilize any
  * of the regular timekeeper offset fields.
  *
+ * @monotonic_to_aux is a timespec64 representation of @offs_aux to
+ * accelerate the VDSO update for CLOCK_AUX.
+ *
  * The cacheline ordering of the structure is optimized for in kernel usage of
  * the ktime_get() and ktime_get_ts64() family of time accessors. Struct
  * timekeeper is prepended in the core timekeeping code with a sequence count,
@@ -159,7 +163,10 @@ struct timekeeper {
 	u8			cs_was_changed_seq;
 	u8			clock_valid;
 
-	struct timespec64	monotonic_to_boot;
+	union {
+		struct timespec64	monotonic_to_boot;
+		struct timespec64	monotonic_to_aux;
+	};
 
 	u64			cycle_interval;
 	u64			xtime_interval;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 059fa8b79be60dee30a788b3e7c43a72dbb465cd..b6974fce800cd8b8a9d66b3663f3c91fb338a751 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -83,6 +83,12 @@ static inline bool tk_is_aux(const struct timekeeper *tk)
 }
 #endif
 
+static inline void tk_update_aux_offs(struct timekeeper *tk, ktime_t offs)
+{
+	tk->offs_aux = offs;
+	tk->monotonic_to_aux = ktime_to_timespec64(offs);
+}
+
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;
 
@@ -1506,7 +1512,7 @@ static int __timekeeping_inject_offset(struct tk_data *tkd, const struct timespe
 			timekeeping_restore_shadow(tkd);
 			return -EINVAL;
 		}
-		tks->offs_aux = offs;
+		tk_update_aux_offs(tks, offs);
 	}
 
 	timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
@@ -2937,7 +2943,7 @@ static int aux_clock_set(const clockid_t id, const struct timespec64 *tnew)
 	 * xtime ("realtime") is not applicable for auxiliary clocks and
 	 * kept in sync with "monotonic".
 	 */
-	aux_tks->offs_aux = ktime_sub(timespec64_to_ktime(*tnew), tnow);
+	tk_update_aux_offs(aux_tks, ktime_sub(timespec64_to_ktime(*tnew), tnow));
 
 	timekeeping_update_from_shadow(aux_tkd, TK_UPDATE_ALL);
 	return 0;
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 8ba8b0d8a3873123da1ed0b1c6dbe7ef172d49f2..aa59919b8f2c23e9a502f676a8359b4d533f270c 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -159,10 +159,10 @@ void vdso_time_update_aux(struct timekeeper *tk)
 	if (clock_mode != VDSO_CLOCKMODE_NONE) {
 		fill_clock_configuration(vc, &tk->tkr_mono);
 
-		vdso_ts->sec	= tk->xtime_sec;
+		vdso_ts->sec = tk->xtime_sec + tk->monotonic_to_aux.tv_sec;
 
 		nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
-		nsec += tk->offs_aux;
+		nsec += tk->monotonic_to_aux.tv_nsec;
 		vdso_ts->sec += __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
 		nsec = nsec << tk->tkr_mono.shift;
 		vdso_ts->nsec = nsec;

---
base-commit: bc540480decdc367219d0fe4f8c265177c4d5a55
change-id: 20250825-vdso-auxclock-division-282462814d6d

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>



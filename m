Return-Path: <linux-kernel+bounces-833111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F92BA13EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6E9189445E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B226831E0F0;
	Thu, 25 Sep 2025 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bR9336bA"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66F931D736
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829388; cv=none; b=axxi9xTCeJ3VAesT5QXDRo2nZHOCi26TCvZmcZ+pqqxW2pNE5CHuoDIYVvszVm+KyaQu5n++iUwR0uOWVBMGWdqZ9+LJ1epwKKQImJi27Ub72mo5mMV3GO1h5EJHu0kYD70DljdZ0Q+HR7FkJ9OiNWQ4odlIQvAbzy4ZgSVN0pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829388; c=relaxed/simple;
	bh=aqke3u94Itb/y8/UpGPZggyKNHm45sW8Wf66NxAK2pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDoNCrvxW5n2XNgJ8aqemJ08sj5t+RUn1KK0NPYZ6ikFc5Hrprwb5qfoQZm0R6zZf2d4goEJqxyCz6sye0UMtBByWnkaqd0M9gFfufnza1Ss5/hGZcpRt7Pw7whji/PNz5YWSPZp7qrTeYsoNZPpwm0EeV9SsN3c6wjrJtBHRAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bR9336bA; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b54a588ad96so1118336a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758829386; x=1759434186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWAGtuR2vigjQdHOJceV6JEOlfkNOj+EPjPoNQdElwA=;
        b=bR9336bAKCPE8Ay3kbSfeu4esDItlc+K/hJD94Ugr25s4E4B4GXTbmLPwl9s9VoTai
         T8CzPDCLYZ2BcV1SewtfbEI2PydUuax/3RNRqyu8p24+TY1syNJFKWTEhWO+Te0U1ihW
         Y9iw/tM9XPKOu09gLPH4Ap/xNnVk2NMwyXZLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758829386; x=1759434186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWAGtuR2vigjQdHOJceV6JEOlfkNOj+EPjPoNQdElwA=;
        b=ezGatMyH4Q8n3wOU1mCy8k10V2etmMWBJajW4hmxRQMy4JGbC3QT4SGyCqtkwP6WXO
         lkSFjsF3xFKQQlJYVfEfulhBDlZX6M0W8gcEWkSOS2E1A+r6f+CF3uPXiGzUhunqEVae
         dsNCylOGIb2saEHMrZpFY9GXj63pL5XvThodJHIJ7aoVq/X85D0dtkEA+2qFOa6pIpfK
         rZn/63HU4gXhmTiPk2iVFYYqF6wZ04xziK4Zm764tfrGPlVcEzCqBnl5ChlQQar0RI3i
         +YuN72L61F2mYrUEhIp4z/BHFg430QfB3yYBm+3yacqh//D/WzqSwkvVQWonebzhz7Fb
         3k+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyUWskScCiC83leLtr/5s/rPG1MpKOXv6ODusAwwezI99gQizdw374M5YrXsdjZaNJtqkqho508ijPKws=@vger.kernel.org
X-Gm-Message-State: AOJu0YysEGbB5htFSXSy2YuVL14WmCIjSScyUx2OPHG3dvdZ0AlxTK26
	JEp1fajMn8WTg4SVZAbB2+1QQR6DQkfwIWYwdqWUBaqkBS9COAPOA44BJMsdjOzAGA==
X-Gm-Gg: ASbGncu8t3n0HVt9tvT5elM7DOC6q4H8+0Hu/NFQx36REpbsNAQFKlhBTDXXCwE8U+k
	dq7W7MaXbX1tvEMglYFKTbESTATeF5sVCQSQl84/rEeZWkRDoDGeUHkmnZMS8Uxdb0nQISjTor+
	Vt+TTx4uwMXeNSh/SVWLFiYrZIGeQtZ3DWsIUvVzIH4rhWCixDMHKUUK9ojnpcJCYZ83gET04zR
	l3iZ5T6FLgQRF3tCCQcKjt05JHooIFqTPkpl2i+nblvJ1bYn7gZoBnRMPkZr004A4SjNBc6Umjy
	RYIYP12NC2xApyz6Y7cqkOuv8DfImpKZh+GC2utU0IiTy+00LPdRsgARpef2EKTe521RbTjg6Tk
	wML3dRFFKmRcW6yIncxb6JI287LXUDUwJxwNw+oLuRcmNiLdR7xpNVJDGaEyA
X-Google-Smtp-Source: AGHT+IHfjpfp/VRkdK67yyW3VaoH0E/qiN5dZXNgMp/xlt/pOK8NBi550p+CiAmlww1AHXXOmpnlcA==
X-Received: by 2002:a17:903:983:b0:267:cdc1:83e with SMTP id d9443c01a7336-27ed722c39amr43206585ad.15.1758829386007;
        Thu, 25 Sep 2025 12:43:06 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:ef44:9df6:231a:cd29])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-27ed6885a8csm32389735ad.95.2025.09.25.12.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 12:43:05 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	kunit-dev@googlegroups.com,
	linux-pm@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 3/3] PM: runtime: Update kerneldoc return codes
Date: Thu, 25 Sep 2025 12:42:16 -0700
Message-ID: <20250925124216.v2.3.I65666ec0d246c22ed4da78a395121b4581460ca6@changeid>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250925124216.v2.1.I443d97ccd1c67f32670eb93784ad735b11816743@changeid>
References: <20250925124216.v2.1.I443d97ccd1c67f32670eb93784ad735b11816743@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

APIs based on __pm_runtime_idle() (pm_runtime_idle(), pm_request_idle())
do not return 1 when already suspended. They return -EAGAIN. This is
already covered in the docs, so the entry for "1" is redundant and
conflicting.

(pm_runtime_put() and pm_runtime_put_sync() were previously incorrect,
but that's fixed in "PM: runtime: pm_runtime_put{,_sync}() returns 1
when already suspended", to ensure consistency with APIs like
pm_runtime_put_autosuspend().)

RPM_GET_PUT APIs based on __pm_runtime_suspend() do return 1 when
already suspended, but the language is a little unclear -- it's not
really an "error", so it seems better to list as a clarification before
the 0/success case. Additionally, they only actually return 1 when the
refcount makes it to 0; if the usage counter is still non-zero, we
return 0.

pm_runtime_put(), etc., also don't appear at first like they can ever
see "-EAGAIN: Runtime PM usage_count non-zero", because in non-racy
conditions, pm_runtime_put() would drop its reference count, see it's
non-zero, and return early (in __pm_runtime_idle()). However, it's
possible to race with another actor that increments the usage_count
afterward, since rpm_idle() is protected by a separate lock; in such a
case, we may see -EAGAIN.

Because this case is only seen in the presence of concurrent actors, it
makes sense to clarify that this is when "usage_count **became**
non-zero", by way of some racing actor.

Lastly, pm_runtime_put_sync_suspend() duplicated some -EAGAIN language.
Fix that.

Fixes: 271ff96d6066 ("PM: runtime: Document return values of suspend-related API functions")
Link: https://lore.kernel.org/linux-pm/aJ5pkEJuixTaybV4@google.com/
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Tweak language around "success"
 * "Usage counter", not "Usage counts" or "usage_count"

 include/linux/pm_runtime.h | 56 +++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index d88d6b6ccf5b..d1ff76e0e2d0 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -350,13 +350,12 @@ static inline int pm_runtime_force_resume(struct device *dev) { return -ENXIO; }
  * * 0: Success.
  * * -EINVAL: Runtime PM error.
  * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage_count non-zero, Runtime PM status change ongoing
- *            or device not in %RPM_ACTIVE state.
+ * * -EAGAIN: Runtime PM usage counter non-zero, Runtime PM status change
+ *            ongoing or device not in %RPM_ACTIVE state.
  * * -EBUSY: Runtime PM child_count non-zero.
  * * -EPERM: Device PM QoS resume latency 0.
  * * -EINPROGRESS: Suspend already in progress.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  * Other values and conditions for the above values are possible as returned by
  * Runtime PM idle and suspend callbacks.
  */
@@ -370,14 +369,15 @@ static inline int pm_runtime_idle(struct device *dev)
  * @dev: Target device.
  *
  * Return:
+ * * 1: Success; device was already suspended.
  * * 0: Success.
  * * -EINVAL: Runtime PM error.
  * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EAGAIN: Runtime PM usage counter non-zero or Runtime PM status change
+ *            ongoing.
  * * -EBUSY: Runtime PM child_count non-zero.
  * * -EPERM: Device PM QoS resume latency 0.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  * Other values and conditions for the above values are possible as returned by
  * Runtime PM suspend callbacks.
  */
@@ -396,14 +396,15 @@ static inline int pm_runtime_suspend(struct device *dev)
  * engaging its "idle check" callback.
  *
  * Return:
+ * * 1: Success; device was already suspended.
  * * 0: Success.
  * * -EINVAL: Runtime PM error.
  * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EAGAIN: Runtime PM usage counter non-zero or Runtime PM status change
+ *            ongoing.
  * * -EBUSY: Runtime PM child_count non-zero.
  * * -EPERM: Device PM QoS resume latency 0.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  * Other values and conditions for the above values are possible as returned by
  * Runtime PM suspend callbacks.
  */
@@ -433,13 +434,12 @@ static inline int pm_runtime_resume(struct device *dev)
  * * 0: Success.
  * * -EINVAL: Runtime PM error.
  * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage_count non-zero, Runtime PM status change ongoing
- *            or device not in %RPM_ACTIVE state.
+ * * -EAGAIN: Runtime PM usage counter non-zero, Runtime PM status change
+ *            ongoing or device not in %RPM_ACTIVE state.
  * * -EBUSY: Runtime PM child_count non-zero.
  * * -EPERM: Device PM QoS resume latency 0.
  * * -EINPROGRESS: Suspend already in progress.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  */
 static inline int pm_request_idle(struct device *dev)
 {
@@ -464,15 +464,16 @@ static inline int pm_request_resume(struct device *dev)
  * equivalent pm_runtime_autosuspend() for @dev asynchronously.
  *
  * Return:
+ * * 1: Success; device was already suspended.
  * * 0: Success.
  * * -EINVAL: Runtime PM error.
  * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EAGAIN: Runtime PM usage counter non-zero or Runtime PM status change
+ *            ongoing.
  * * -EBUSY: Runtime PM child_count non-zero.
  * * -EPERM: Device PM QoS resume latency 0.
  * * -EINPROGRESS: Suspend already in progress.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  */
 static inline int pm_request_autosuspend(struct device *dev)
 {
@@ -540,15 +541,16 @@ static inline int pm_runtime_resume_and_get(struct device *dev)
  * equal to 0, queue up a work item for @dev like in pm_request_idle().
  *
  * Return:
+ * * 1: Success. Usage counter dropped to zero, but device was already suspended.
  * * 0: Success.
  * * -EINVAL: Runtime PM error.
  * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
+ *            change ongoing.
  * * -EBUSY: Runtime PM child_count non-zero.
  * * -EPERM: Device PM QoS resume latency 0.
  * * -EINPROGRESS: Suspend already in progress.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  */
 static inline int pm_runtime_put(struct device *dev)
 {
@@ -565,15 +567,16 @@ DEFINE_FREE(pm_runtime_put, struct device *, if (_T) pm_runtime_put(_T))
  * equal to 0, queue up a work item for @dev like in pm_request_autosuspend().
  *
  * Return:
+ * * 1: Success. Usage counter dropped to zero, but device was already suspended.
  * * 0: Success.
  * * -EINVAL: Runtime PM error.
  * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
+ *            change ongoing.
  * * -EBUSY: Runtime PM child_count non-zero.
  * * -EPERM: Device PM QoS resume latency 0.
  * * -EINPROGRESS: Suspend already in progress.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  */
 static inline int __pm_runtime_put_autosuspend(struct device *dev)
 {
@@ -590,15 +593,16 @@ static inline int __pm_runtime_put_autosuspend(struct device *dev)
  * in pm_request_autosuspend().
  *
  * Return:
+ * * 1: Success. Usage counter dropped to zero, but device was already suspended.
  * * 0: Success.
  * * -EINVAL: Runtime PM error.
  * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
+ *            change ongoing.
  * * -EBUSY: Runtime PM child_count non-zero.
  * * -EPERM: Device PM QoS resume latency 0.
  * * -EINPROGRESS: Suspend already in progress.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  */
 static inline int pm_runtime_put_autosuspend(struct device *dev)
 {
@@ -619,14 +623,15 @@ static inline int pm_runtime_put_autosuspend(struct device *dev)
  * if it returns an error code.
  *
  * Return:
+ * * 1: Success. Usage counter dropped to zero, but device was already suspended.
  * * 0: Success.
  * * -EINVAL: Runtime PM error.
  * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
+ *            change ongoing.
  * * -EBUSY: Runtime PM child_count non-zero.
  * * -EPERM: Device PM QoS resume latency 0.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  * Other values and conditions for the above values are possible as returned by
  * Runtime PM suspend callbacks.
  */
@@ -646,15 +651,15 @@ static inline int pm_runtime_put_sync(struct device *dev)
  * if it returns an error code.
  *
  * Return:
+ * * 1: Success. Usage counter dropped to zero, but device was already suspended.
  * * 0: Success.
  * * -EINVAL: Runtime PM error.
  * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
- * * -EAGAIN: usage_count non-zero or Runtime PM status change ongoing.
+ * * -EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
+ *            change ongoing.
  * * -EBUSY: Runtime PM child_count non-zero.
  * * -EPERM: Device PM QoS resume latency 0.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  * Other values and conditions for the above values are possible as returned by
  * Runtime PM suspend callbacks.
  */
@@ -677,15 +682,16 @@ static inline int pm_runtime_put_sync_suspend(struct device *dev)
  * if it returns an error code.
  *
  * Return:
+ * * 1: Success. Usage counter dropped to zero, but device was already suspended.
  * * 0: Success.
  * * -EINVAL: Runtime PM error.
  * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
+ *            change ongoing.
  * * -EBUSY: Runtime PM child_count non-zero.
  * * -EPERM: Device PM QoS resume latency 0.
  * * -EINPROGRESS: Suspend already in progress.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  * Other values and conditions for the above values are possible as returned by
  * Runtime PM suspend callbacks.
  */
-- 
2.51.0.536.g15c5d4f767-goog



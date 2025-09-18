Return-Path: <linux-kernel+bounces-818144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A10B58D72
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6EE1BC66B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C4626F46F;
	Tue, 16 Sep 2025 04:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsGY6hpS"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2302EB5C0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998163; cv=none; b=rFZlWl01TdsVlFpupRFtRjGEb0F7ljDlPD94NjDeS6YNkY5A4iLXi8KZ/LM8FO3FDeag0oRHrrnhvcwbbCmrOjhZfDvW7eVjFbPboBS9l3T8AfCnhhlEz2MhRAlq3oyiIOtTPiadB0dXaCtU5Saa4RMGJQUB+GPtUoFfBRJo/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998163; c=relaxed/simple;
	bh=URVaUhKMvCuYEZ8psO6dkhmdgwpR5FJ6tmwMgMKVfqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I9MFrFDop+jf++pzthkRlA1VEgG6376JUbcM/tJVLhlzhZFCJDIcDf3JJsSxllVKYT2h9fLPht9IqwYo5dhGlQPW1kICQYkhe8I1R9rNCfEyqBqtd49+r0EQZXVsLRJ1y1G9Ih6cgPdbYhKa6zN9DPiHwPcPg8AXLMfD4qAV9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsGY6hpS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-266914a33e5so14506665ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998160; x=1758602960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKFiV5+5iXRxF8ed4BpSpPqD3Dy/BIf3yej7QaTDllk=;
        b=BsGY6hpSYfjuzifoJRtLEh+RcYVKPOj/4OL+ufcIYnWtFBm/6QKRUYkJx+jCgDAYD9
         YbHuWQTT5bLKUtqT+ubu+NEUfJBxR9OEocsjh9hJTzGzPujujp2fEClDsxRly5Wh+GMu
         vAlet4HSbTFgfIXuLduTgjZkp3SvB2dtCggWXba0sMJuWRzKqA7VTN20NSPo4MynPFP0
         WuO6w0KUp+uNup9bgaj8lXwq5oTYBUHITPqcgH636iYC3TyW0hUwfAo9PqEIVLbRYNGT
         AxXCAE3GeOSG9xKNzkv5hGF9Lp6ZvA0RqWhnuBVOe8wtQPQVKOlMmfBy/dzJJndpdxDQ
         ZzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998160; x=1758602960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKFiV5+5iXRxF8ed4BpSpPqD3Dy/BIf3yej7QaTDllk=;
        b=R851lJ1y4vKefzG/81La+q/pcd9JqGJoTdEtd210wPg5xcU7U7fcwFgTuOR6+OhjXw
         hUFULq0x8XO7KUL0nwQ16Gg8Ah33uuz3rH7RIj6VDuuyEvKMswaEdf1GgoVQkGU5J+ZL
         eWekcD+l1btdPewoQf9KWWMC9EE0Pg4WfSc8ROap4IBerY9TnjCia1sIyyFWJkO2M4rE
         F/0MmTFjpqntoAA/0aUIJHO3EwWB+br4jKbPTvWwLeN32kXydCvgaE1a9owhTbpoIJm0
         O4FRfPVwEjCET8MCY0mj3jp57kgfq0l9ziWTUk2Ct9eEDFCSife0yc3yl6YyPWPy8BUM
         ZwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmEeTl00enoAgArXrgWar/8XuW5fmHpSxkWMzRNY6KHYAXhEDX2nOJp+cxwsfvHSiM8kZvVRjDxVY40qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX6C2qNfpOCQMb/n2aaqyp06TDU26sUhp82FI89Ti/4kbkvcaZ
	OwJIRnZOlVmTQLA53lbd+DOfjZPq7qwe2epLBeJTeXkBOrvYFX+C8dyz
X-Gm-Gg: ASbGncsiBAOmeRYT8iLofWfXE0TgKn/Up5fL4RBEY8iSm8965v9b5Sn3ZMs0U/Dk94R
	gf+d5glU7vgnFzgn1nfmVVPby0TSfkTl8RHOV89WQO2jUmPK2B7T4lG+3Msy/GQV0R5mkDnSVqg
	i5YsfmH+x5vFmgMLq2l5VHDAHkpP7nEH0CNXisXCIkpiVp6E+XpfDqNDSaB7oQxS+JrKUGaqxw3
	qO5W8KuAlUfNlhkJLthe5nGGIAZCl5GBbj1gISdanGzTrwasZMXgqRK77h2uJ4+tmF+ubJaONSr
	2fHLZnVrdvM2LxvSkB/EXpcknz8EXL6cphcM5l/bfWi/R0t0A4fsEZpmgZlNtKGYlI8iQLcsWfW
	rJR992FuBtfoelyOwr7A8OoBG1t95Gp77HNB2CZkdv47gMoPhnw==
X-Google-Smtp-Source: AGHT+IFnY0JR12RUAnqJgicB9FLxjxZB94pUdOOycWzScDVS8Oor/+yCs+nfn4PrPMaqh+5e4UELMQ==
X-Received: by 2002:a17:902:c408:b0:267:d82a:127c with SMTP id d9443c01a7336-267d82a15fcmr9300035ad.42.1757998160302;
        Mon, 15 Sep 2025 21:49:20 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:19 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 10/14] wifi: mac80211: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:31 +0800
Message-Id: <20250916044735.2316171-11-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 net/mac80211/cfg.c            | 2 --
 net/mac80211/debugfs.c        | 2 --
 net/mac80211/debugfs_netdev.c | 2 --
 net/mac80211/debugfs_sta.c    | 2 --
 net/mac80211/sta_info.c       | 2 --
 5 files changed, 10 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 2ed07fa121ab..4fe50d4c461d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4825,7 +4825,6 @@ static int ieee80211_get_txq_stats(struct wiphy *wiphy,
 	int ret = 0;
 
 	spin_lock_bh(&local->fq.lock);
-	rcu_read_lock();
 
 	if (wdev) {
 		sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
@@ -4851,7 +4850,6 @@ static int ieee80211_get_txq_stats(struct wiphy *wiphy,
 	}
 
 out:
-	rcu_read_unlock();
 	spin_unlock_bh(&local->fq.lock);
 
 	return ret;
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index e8b78ec682da..82099f4cedbe 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -82,7 +82,6 @@ static ssize_t aqm_read(struct file *file,
 	int len = 0;
 
 	spin_lock_bh(&local->fq.lock);
-	rcu_read_lock();
 
 	len = scnprintf(buf, sizeof(buf),
 			"access name value\n"
@@ -105,7 +104,6 @@ static ssize_t aqm_read(struct file *file,
 			fq->limit,
 			fq->quantum);
 
-	rcu_read_unlock();
 	spin_unlock_bh(&local->fq.lock);
 
 	return simple_read_from_buffer(user_buf, count, ppos,
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 1dac78271045..30a5a978a678 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -625,7 +625,6 @@ static ssize_t ieee80211_if_fmt_aqm(
 	txqi = to_txq_info(sdata->vif.txq);
 
 	spin_lock_bh(&local->fq.lock);
-	rcu_read_lock();
 
 	len = scnprintf(buf,
 			buflen,
@@ -642,7 +641,6 @@ static ssize_t ieee80211_if_fmt_aqm(
 			txqi->tin.tx_bytes,
 			txqi->tin.tx_packets);
 
-	rcu_read_unlock();
 	spin_unlock_bh(&local->fq.lock);
 
 	return len;
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 49061bd4151b..ef75255d47d5 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -148,7 +148,6 @@ static ssize_t sta_aqm_read(struct file *file, char __user *userbuf,
 		return -ENOMEM;
 
 	spin_lock_bh(&local->fq.lock);
-	rcu_read_lock();
 
 	p += scnprintf(p,
 		       bufsz + buf - p,
@@ -178,7 +177,6 @@ static ssize_t sta_aqm_read(struct file *file, char __user *userbuf,
 			       test_bit(IEEE80211_TXQ_DIRTY, &txqi->flags) ? " DIRTY" : "");
 	}
 
-	rcu_read_unlock();
 	spin_unlock_bh(&local->fq.lock);
 
 	rv = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 8c550aab9bdc..663318a75d7f 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2637,13 +2637,11 @@ static void sta_set_tidstats(struct sta_info *sta,
 
 	if (link_id < 0 && tid < IEEE80211_NUM_TIDS) {
 		spin_lock_bh(&local->fq.lock);
-		rcu_read_lock();
 
 		tidstats->filled |= BIT(NL80211_TID_STATS_TXQ_STATS);
 		ieee80211_fill_txq_stats(&tidstats->txq_stats,
 					 to_txq_info(sta->sta.txq[tid]));
 
-		rcu_read_unlock();
 		spin_unlock_bh(&local->fq.lock);
 	}
 }
-- 
2.34.1



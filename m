Return-Path: <linux-kernel+bounces-889243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6DAC3D0E4
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD493BA00C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9742DAFA1;
	Thu,  6 Nov 2025 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="e0plIv+y"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7A29AAFA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762453234; cv=none; b=uIsQ8oDM0ijBBKAEXRB4Y14dxa7cdWrLjd+UV5JRVTJYGDQZMBtsl8ocmGkqjPLGBnPF47/hlYYHySFXeNWAwJGcyV3/hUk2K6axNJhMhG3qo1ZCoO6lQs1IShz3OG8lUDHEuP1dHNeZJ3TfS/T9RZP61mbBW34eXzfG3Hr269k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762453234; c=relaxed/simple;
	bh=375jKvwYcq0QUXukIrQ1f+N3NOj9DqIX4Aj/+YlX5mk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tYf72TzYSYJ/8do4RrZnCENG/eie+tLHN2fz8/bIdtyqX6iX2+m+jARuRNbPn7gVqW1ry7Qmt7SoVZ3t0Tz4GYe9ZU2W22qRwUjjtOpkGzCI4Raw3r4Z3u09ykMQ1ns0IJ45RQ5IcjUyLk+IUvuuWj8px9id3tE2WHufuz/dqco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=e0plIv+y; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a59ec9bef4so1589938b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1762453231; x=1763058031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ASB8FKtZK1f63TZGwMkE6Mcut8cdvc7Tlq+5U4LNTk=;
        b=e0plIv+ywDol0GQRnZeP6WMULY+1FxqOwFU8hTwb4f5U0YIR0qzYdG6sDWUhRmXwpl
         fl6wW2Fm+dLS5dU7YiokNPy87x59rCJzUjZ+3ErRkJV4vTPvQUJFCeX+45tegHPH6OJ2
         X+hArojOp06aBdWJhNI/QDbOLj9dnKU3M2el4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762453231; x=1763058031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ASB8FKtZK1f63TZGwMkE6Mcut8cdvc7Tlq+5U4LNTk=;
        b=TB4q7+tI0sKcnOQrYZJx89QpSzceAFiW9OEuxEAleNv04WdcZlRTU+UpQ6WeR+M+fa
         QukBDhO8wZlbNUI4isIsvQ+Un6G6cHeEvR+6bybVz8fUDAov00jIjDwP5r5zLrR+HUTN
         jkVtJ/CK/6x7xrnVRTCS9y5RK/OG1GP4pdAEpmRfOVgRJKLvKuO7+VOkEDFqJVQ1bHL0
         u589/hHTlpSbiJvEBIiAoYH9KixZtQl7U2I55pRSKI2y2EFsNKiZvF03RH4ICBPlMnFX
         GkU6ViZbtO9DB8zVu48teSSXpC6fgVj3aJUL9D2H6Ig8JHVRdtyVyIgJm+OBKuVPUG0I
         ohyg==
X-Forwarded-Encrypted: i=1; AJvYcCUwWv6vRmu1aGBQO2sPrPypHJPAQjm/tT6CX1YRs+6e7qDKOae9gVEJE0qVlxvrj75GnEEh8Xj+KRE48Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7WY2CozcY9r52c8KfOYaQLAY6pWlE7VktWXvKaZD7oPGLlPc+
	ceRwFsxBLi4wYtoFyq4Hy/4vCAmQzjpXasBDn8NuOGXRBgRalv0Zh5Q3ZkrVqdoV3Jo=
X-Gm-Gg: ASbGnctu06sXQM8isRyZ3MR2kFLAI2/4+b8I/ZcNlrvts0GdjXLaGyV1eJ2+4XyMhc3
	uKj3J1ejRKDFi1NaFhkgZM/Lk+FWI6Ftz8nqwRoCNkESuR8dFtNw0KZHgsgw/fLtzPuf3C6WO/o
	4Nkab8Anjc6BGAQgWm1MY6VsrUvmGjVy7gEcJmSDM+0WhGLSQHBbxbZg3IcjL53KusdOwA0wElr
	adltev55jpCvXDwyMlvTRMp7rD/qz/qY9sG4Ds3NWTcoVnFOJ8cmEdRz9fxZbY75CtCq17wSZ38
	yT51L7nPigljcMIQUX+3jtXRjkLvX07WF4fwIByZRj6/HFsQax8psgi3JLqSvcsTfE8rDHHSfK1
	tPmG708E8VBQksGrG7ea1qnKjME2sDjvGzheSu9lzgj1Utp9v7rEa4Ny9YBaimCJF2lYr3VHJed
	FLVcMaY7YT86P0xzUmJZ+waKnLv4GSyBsDtu2qnOjUVp6XToMM9hSIO7Zmrw==
X-Google-Smtp-Source: AGHT+IGjsvWizViuKvqU/9ixMSrMVwXUSyqJ0gQDi1Sv/r9iYmMJdX5r5ZgGWH4p4H/sroNO9dU7pw==
X-Received: by 2002:a17:902:e88b:b0:290:9a74:a8ad with SMTP id d9443c01a7336-297c047f196mr4517675ad.53.1762453230814;
        Thu, 06 Nov 2025 10:20:30 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([110.226.176.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccec88sm35062555ad.107.2025.11.06.10.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:20:30 -0800 (PST)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	pav@iki.fi,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [PATCH v2 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user
Date: Thu,  6 Nov 2025 23:50:16 +0530
Message-Id: <20251106182016.26508-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105142251.101852-1-ssranevjti@gmail.com>
References: <20251105142251.101852-1-ssranevjti@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

After commit ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in
hci_chan_del"), l2cap_conn_del() uses conn->lock to protect access to
conn->users and conn->hchan. However, l2cap_register_user() and
l2cap_unregister_user() still use hci_dev_lock(), creating a race
condition where these functions can access conn->users and conn->hchan
concurrently with l2cap_conn_del().

This can lead to use-after-free and list corruption bugs, as reported
by syzbot.

Fix this by changing l2cap_register_user() and l2cap_unregister_user()
to use conn->lock instead of hci_dev_lock(), ensuring consistent locking
for the l2cap_conn structure.

Reported-by: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
Fixes: ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_del")

Changes in v2:
 - Replaced hci_dev_lock()/unlock() with mutex_lock()/unlock(&conn->lock)
   in both l2cap_register_user() and l2cap_unregister_user().
 - Updated comments to match current locking rules.
 - Removed unnecessary hci_dev_hold()/hci_dev_put() usage.

Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 net/bluetooth/l2cap_core.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d08320380ad6..29e78801c507 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1685,17 +1685,15 @@ static void l2cap_info_timeout(struct work_struct *work)
 
 int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user)
 {
-	struct hci_dev *hdev = conn->hcon->hdev;
 	int ret;
 
 	/* We need to check whether l2cap_conn is registered. If it is not, we
-	 * must not register the l2cap_user. l2cap_conn_del() is unregisters
-	 * l2cap_conn objects, but doesn't provide its own locking. Instead, it
-	 * relies on the parent hci_conn object to be locked. This itself relies
-	 * on the hci_dev object to be locked. So we must lock the hci device
-	 * here, too. */
+	 * must not register the l2cap_user. l2cap_conn_del() unregisters
+	 * l2cap_conn objects under conn->lock, and we use the same lock here
+	 * to protect access to conn->users and conn->hchan.
+	 */
 
-	hci_dev_lock(hdev);
+	mutex_lock(&conn->lock);
 
 	if (!list_empty(&user->list)) {
 		ret = -EINVAL;
@@ -1716,16 +1714,14 @@ int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user)
 	ret = 0;
 
 out_unlock:
-	hci_dev_unlock(hdev);
+	mutex_unlock(&conn->lock);
 	return ret;
 }
 EXPORT_SYMBOL(l2cap_register_user);
 
 void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_user *user)
 {
-	struct hci_dev *hdev = conn->hcon->hdev;
-
-	hci_dev_lock(hdev);
+	mutex_lock(&conn->lock);
 
 	if (list_empty(&user->list))
 		goto out_unlock;
@@ -1734,7 +1730,7 @@ void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_user *user)
 	user->remove(conn, user);
 
 out_unlock:
-	hci_dev_unlock(hdev);
+	mutex_unlock(&conn->lock);
 }
 EXPORT_SYMBOL(l2cap_unregister_user);
 
-- 
2.34.1



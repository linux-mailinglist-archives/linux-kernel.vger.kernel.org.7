Return-Path: <linux-kernel+bounces-831730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11489B9D6CC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276261B23C37
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA002E7F02;
	Thu, 25 Sep 2025 05:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvRoG9vS"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE5A2E6CB6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758777076; cv=none; b=rsMClFEGgZWOqlqxthCs8MM62YrmBzxTOXhrpRJ8i7FIQexRZ1ode1TV8/qAsBNg3BmAjpavzT0Cy6aA2MqtDC3SbMkyzWwiPucROeS6IDutHvRrdJK0TIzkGoUhnXvAHdfcGYhSJco/uvwMMWkXSNfK/puliu21u6gwg6ar+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758777076; c=relaxed/simple;
	bh=c4FMzRewIIokmtK1pzb0jNUAZ4tb4g9x531AbMNIMmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCNHJ4llrx3qrkQIU9sozbpzhkJjyq5xACkA1G+DNM/IpG0abDrDLbmyf+lkCvdyJ8tUi27gpG2ZzxQhe543NkTaPKq1T0JEJu0UDKDW97WYN5kXJ1OUOfthPsHh2nzxGJXG8J9x/8OsVJWSc5Ed3KiePyJjp5uhBdrsD4fDrog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvRoG9vS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-271067d66fbso5926765ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758777074; x=1759381874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=33wRSADo0EqeMuRwMq4UeTMskNZ+kzlt8hrZMx5KCMA=;
        b=cvRoG9vSsLjsv1V3NrP/9rqoUKOx1oC7Mf5PepYmU37KOg97nRZJ83o/eXCVsVK4NB
         Fgvtozp4siOWW9IWgy6bDhx1pUhMj7sghSjtWDIpcapnareycvC0/60LehNMFCAAb3Nf
         BgIAw3x1rSt8vPQASSc9YNvfA5FQwbhnYDeaQ5+/0tB7O4EQ+4J+DSKPzWardBvqYxcl
         /2Isoq/gEFlL8lqJ2RfQr/6oK6r6y14bjZtMVxwwdz1UiEBr8Ortk7A1TXlx2WCcRcxA
         MOAs+AqKb4sOimkOz5iDqaO96n8WofU7BzCn0OR81Wm2XyTlJH/NRvtUF6B7/Ag7C8qm
         R/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758777074; x=1759381874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33wRSADo0EqeMuRwMq4UeTMskNZ+kzlt8hrZMx5KCMA=;
        b=tuhc02QS07N0io+CglSYS1pZSPZK2yvK6Ax6mxXuQIIoJJ2our0BhyQPgEJ0QHmNXT
         bMiMlp0yRPWBjosq3+pmRfXGrUN5f+ZjWUMH+/X52XtoRVw/tURCt+jEZHzURidJRssc
         aO/ewgntnJvcoHl6bNF/+Vk/eVt8SNbSrJMk2nRO4+lou2I9m9TrKOjQBYw708/d1ApY
         yvARUiEewC+u9V1ajDiHRug9E+CTIGaxuLcZRm4eynBd17birVuPCkyWWfpjn43x1AjU
         9egayseUChY2lMPZ8IIshp46UT9qTUJt7joJUiG1y97mlrmDCQdPP6G3BbBFEIt8kcrD
         Z1rA==
X-Forwarded-Encrypted: i=1; AJvYcCVWmoMfD74hhEX4Wk+nvG6ZeNPKOknkTtEaAmml2gZC0pthSq6vxYhbSc1srDxp6A07gE4lrMni2afQMLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxckZUv+7U28CTtevPbqTFpbk9p8W8X9AyGZg46StP20n/MbEzj
	4PiIPnZSkLRIbUVm4GSdt8glIQ1w4c7IMu43X24LRimX4RYWOIgLtpSa
X-Gm-Gg: ASbGnctn5qfkn4iDgHo59RfUqMkexbA2RifTMq1//gwdataUNP7M2HOAsjsRL9wxKbg
	iVe/RSheXYtuMqvM7F8twdAyXnIAc1HBQr/dWEYEPLtveU47yDSAIRDnVxrAXriYTxEBuzA+rOj
	K2FutR22qaKOSjMRG1RZxvyqsBagNVQZNVT32EVLK57T2P15pUCPi3VTpwOnmUZg02XYPBfrMxx
	tVR/zviFP3lqNnoQYpO8954ETLHIXOTjIH5G4IZRC3j+0OpA2agGDfKiDDJfaC+lrxIFeIwAqhA
	SzgHZ8P4bq0GsfUXwWn20KNglWtoc814SHlKamfbM5Hu6K1HxfwQuYQrrpqA/HuWvuX6YGNbEQD
	/hxBlqDx7aRn/8w==
X-Google-Smtp-Source: AGHT+IE12SqFhdSDrT0EvYFuxMNRzaowH2gL0IZazbv1RzBMsx+ZdUDsi8mFp5LXQkIQ5duLkIfVEQ==
X-Received: by 2002:a17:902:c402:b0:25c:d4b6:f119 with SMTP id d9443c01a7336-27ed49df307mr26839895ad.12.1758777073528;
        Wed, 24 Sep 2025 22:11:13 -0700 (PDT)
Received: from gmail.com ([223.166.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d6523sm10904825ad.11.2025.09.24.22.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 22:11:13 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Andreas Koensgen <ajk@comnets.uni-bremen.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-hams@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com
Subject: [PATCH net-next v2] 6pack: drop redundant locking and refcounting
Date: Thu, 25 Sep 2025 13:10:59 +0800
Message-ID: <20250925051059.26876-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TTY layer already serializes line discipline operations with
tty->ldisc_sem, so the extra disc_data_lock and refcnt in 6pack
are unnecessary.

Removing them simplifies the code and also resolves a lockdep warning
reported by syzbot. The warning did not indicate a real deadlock, since
the write-side lock was only taken in process context with hardirqs
disabled.

Reported-by: syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68c858b0.050a0220.3c6139.0d1c.GAE@google.com/
Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v2: add Closes tag
 - https://lore.kernel.org/netdev/20250923060706.10232-1-dqfext@gmail.com/

 drivers/net/hamradio/6pack.c | 57 ++++--------------------------------
 1 file changed, 5 insertions(+), 52 deletions(-)

diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index c5e5423e1863..885992951e8a 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -115,8 +115,6 @@ struct sixpack {
 
 	struct timer_list	tx_t;
 	struct timer_list	resync_t;
-	refcount_t		refcnt;
-	struct completion	dead;
 	spinlock_t		lock;
 };
 
@@ -353,42 +351,13 @@ static void sp_bump(struct sixpack *sp, char cmd)
 
 /* ----------------------------------------------------------------------- */
 
-/*
- * We have a potential race on dereferencing tty->disc_data, because the tty
- * layer provides no locking at all - thus one cpu could be running
- * sixpack_receive_buf while another calls sixpack_close, which zeroes
- * tty->disc_data and frees the memory that sixpack_receive_buf is using.  The
- * best way to fix this is to use a rwlock in the tty struct, but for now we
- * use a single global rwlock for all ttys in ppp line discipline.
- */
-static DEFINE_RWLOCK(disc_data_lock);
-                                                                                
-static struct sixpack *sp_get(struct tty_struct *tty)
-{
-	struct sixpack *sp;
-
-	read_lock(&disc_data_lock);
-	sp = tty->disc_data;
-	if (sp)
-		refcount_inc(&sp->refcnt);
-	read_unlock(&disc_data_lock);
-
-	return sp;
-}
-
-static void sp_put(struct sixpack *sp)
-{
-	if (refcount_dec_and_test(&sp->refcnt))
-		complete(&sp->dead);
-}
-
 /*
  * Called by the TTY driver when there's room for more data.  If we have
  * more packets to send, we send them here.
  */
 static void sixpack_write_wakeup(struct tty_struct *tty)
 {
-	struct sixpack *sp = sp_get(tty);
+	struct sixpack *sp = tty->disc_data;
 	int actual;
 
 	if (!sp)
@@ -400,7 +369,7 @@ static void sixpack_write_wakeup(struct tty_struct *tty)
 		clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 		sp->tx_enable = 0;
 		netif_wake_queue(sp->dev);
-		goto out;
+		return;
 	}
 
 	if (sp->tx_enable) {
@@ -408,9 +377,6 @@ static void sixpack_write_wakeup(struct tty_struct *tty)
 		sp->xleft -= actual;
 		sp->xhead += actual;
 	}
-
-out:
-	sp_put(sp);
 }
 
 /* ----------------------------------------------------------------------- */
@@ -430,7 +396,7 @@ static void sixpack_receive_buf(struct tty_struct *tty, const u8 *cp,
 	if (!count)
 		return;
 
-	sp = sp_get(tty);
+	sp = tty->disc_data;
 	if (!sp)
 		return;
 
@@ -446,7 +412,6 @@ static void sixpack_receive_buf(struct tty_struct *tty, const u8 *cp,
 	}
 	sixpack_decode(sp, cp, count1);
 
-	sp_put(sp);
 	tty_unthrottle(tty);
 }
 
@@ -561,8 +526,6 @@ static int sixpack_open(struct tty_struct *tty)
 
 	spin_lock_init(&sp->lock);
 	spin_lock_init(&sp->rxlock);
-	refcount_set(&sp->refcnt, 1);
-	init_completion(&sp->dead);
 
 	/* !!! length of the buffers. MTU is IP MTU, not PACLEN!  */
 
@@ -638,19 +601,11 @@ static void sixpack_close(struct tty_struct *tty)
 {
 	struct sixpack *sp;
 
-	write_lock_irq(&disc_data_lock);
 	sp = tty->disc_data;
-	tty->disc_data = NULL;
-	write_unlock_irq(&disc_data_lock);
 	if (!sp)
 		return;
 
-	/*
-	 * We have now ensured that nobody can start using ap from now on, but
-	 * we have to wait for all existing users to finish.
-	 */
-	if (!refcount_dec_and_test(&sp->refcnt))
-		wait_for_completion(&sp->dead);
+	tty->disc_data = NULL;
 
 	/* We must stop the queue to avoid potentially scribbling
 	 * on the free buffers. The sp->dead completion is not sufficient
@@ -673,7 +628,7 @@ static void sixpack_close(struct tty_struct *tty)
 static int sixpack_ioctl(struct tty_struct *tty, unsigned int cmd,
 		unsigned long arg)
 {
-	struct sixpack *sp = sp_get(tty);
+	struct sixpack *sp = tty->disc_data;
 	struct net_device *dev;
 	unsigned int tmp, err;
 
@@ -725,8 +680,6 @@ static int sixpack_ioctl(struct tty_struct *tty, unsigned int cmd,
 		err = tty_mode_ioctl(tty, cmd, arg);
 	}
 
-	sp_put(sp);
-
 	return err;
 }
 
-- 
2.43.0



Return-Path: <linux-kernel+bounces-895711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7DCC4EC13
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 160B04EEA98
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B46735F8DF;
	Tue, 11 Nov 2025 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6q/OQyR"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE03590C5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874031; cv=none; b=uN+uwn57fv+Lry0f6nxgggktB/mbpi2+76r9zNEySX4b0ghvzgIuARL3MZcRrY6u5uLKlCzTrfk+/IoM56LULWdIrZKcGe0luOZRI36C2ouMhSt/GWFZeF8ZmwnFhm4oFUJ9tq/Of/e1CN+6CwTKf5JxZUQlmI1ZgtJ9fYIteO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874031; c=relaxed/simple;
	bh=haGuT6duQiD/g2QeFQRAKJR7i+myTnoI1eybJrl1N1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWCU3/bqZBt4qfrzrUoFygAgsfKQLst0JMuFUXC3ieREgfszJXclq4Bdh6aADZ1kVk6JdQ8bbpcBcsFivcfdIocElxfpmKO1s+LuPMDfypsvsHX8g3wNXi280CNbmlLEwsMfQl0H7Os0yMo7jU1PIp2Wc6Jt5Sa4x1B9LjJa/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6q/OQyR; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ba599137cf8so732807a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762874029; x=1763478829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41cP7HhdYBF0wKzXmJRqSWi2C2B06MZQG6yQgaUNwsI=;
        b=Y6q/OQyRfZzf+r31cWNZ4Nf70+KoA/zk8KPWIA7Jb+Bt3n2yyOZFRq/nO+oHAAp15Q
         OayRtgobiL+lruU23vYi1C6T+bchopphBw23dKP7i0m/keDCKrCLnopxGdZuw84DhmCZ
         VhkL71t9uQiJwaESQvCN6lRC8f6OVsU5wSPLHEWt7H320juF+xpUa/NHsz1od5ETn9qf
         rhEt2iIROFLNzxb2H7ZYEAn/myNroKZK/SAQg5jCglw0RbwHO4qs/38KcQDcI0tM9EV5
         oRAzABxsIqhnVQ3esu1p5+gi/T1T7Mafy9T+kVhEhd7A/YapqkDS+5ZUoR8ixEtRSuDO
         M4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762874029; x=1763478829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=41cP7HhdYBF0wKzXmJRqSWi2C2B06MZQG6yQgaUNwsI=;
        b=o/I1AJ3QSAMKbdFu89Ks/KbQ++N+jza6deoN8CyihzcsonGUyG9jyhaOGVIc6Wt33Y
         hAZ8ZNLfUEXrW2GUOEWa0P79DyUS+h2KiSSRhRcSYcY4UTkkBXP6eBqMOBAjxIjOR060
         UXiK67TxOBUoAcjF0ycDzTXlKom8gX4OP3iaz+RxdUxTFYhBCf2CFm3ZScwSVeVGHym4
         9Dy+Z/yrnL7qZe1cFX0u/OYJ+ZFBpzAgxFRllpngFF7gT7s28WPYLO7hLkUIlYegHEGv
         6hiWCwnjH1IHGOLy3uNLQPhPpwYWx1i6pG1qWgH5ua3vRl8nLSLvfVzn1e0QAQxajD0E
         e7Qw==
X-Forwarded-Encrypted: i=1; AJvYcCV7BkgiYKT6oaEuO30by+QElnKdV/+4gHzJ70Cv7WX1P23Fkf1FgiLYMtO9KZQrN3sDqAe2P3go4Htfqx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu/4etjwEDaBJeyKU7sy9nXAml+qdUR+hsHlR9WyBQXy1Bg3fH
	NsWt3N3Snp0wSwbuFxVcFulqxq0yc7UxgBWsD7Iua2GMwGHHNwY4HBFR
X-Gm-Gg: ASbGncuXvm6WqmAr7Hb0JGSWVMUnQKvxO+VxGY36qeYj51nw672o71tNNT5OWKWqt82
	9hEvxn1y19FHQCrtOMebR1B/oFsXzCG1iC67krXcpTj9Skyk7FfMBIF9cxWqA2tOxMk2i38GB8W
	EaR9nba/UDO8g9uVYTHZzn7mRlkcvqKrLL5JvSoa16RcxBNsup73zHBllS66dHTYgmNhTrjAELg
	1TRnhf6+0+SQmFivS9hKNrJNqP6RgiN6feDQePUmrpGHIB893iHCvJX5HrVoByp8ogiucmiMqaq
	HJmBev8OofeqKfG8ukNBJe44AnkeiWuhI5wcdBny/D8VWlWavJqplonx5tmYbJeGqLCExE0E6Ei
	9HK3ch6OjKFP3hHsqQky6JdCYHro/b3NibUT/AQc3opQCoQRfXlTAhXRBLD5GvXzYbiJ2z5/ewo
	+AO6sTqG1x9TuoL9Jb2dyVqqma+zcGNNfPQ0lmoU3Qi+xiRQ==
X-Google-Smtp-Source: AGHT+IFTK5kIozJ8wfyxlroJjlHKYrJMVtPSJw+tmo3xM6ic8/B2Xj64K9YTLD2mUTD5Z6Wt9lW4/A==
X-Received: by 2002:a17:902:ef4f:b0:295:134:9ae5 with SMTP id d9443c01a7336-2984083ab27mr46536345ad.24.1762874028798;
        Tue, 11 Nov 2025 07:13:48 -0800 (PST)
Received: from clint-ThinkPad-L14-Gen-2.. ([110.226.177.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dcd050asm43325ad.81.2025.11.11.07.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:13:48 -0800 (PST)
From: Clint George <clintbgeorge@gmail.com>
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de,
	clintbgeorge@gmail.com,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2 0/3] hangcheck-timer: coding style improvements
Date: Tue, 11 Nov 2025 20:43:37 +0530
Message-ID: <20251111151340.9162-1-clintbgeorge@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025110649-elves-steadying-a4d0@gregkh>
References: <2025110649-elves-steadying-a4d0@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves coding style in hangcheck-timer:

Clint George (3):
  hangcheck-timer: replace printk(KERN_CRIT) with pr_crit
  hangcheck-timer: Replace %Ld with %lld
  hangcheck-timer: fix coding style spacing

No functional changes were made to hangcheck logic.

Signed-off-by: Clint George <clintbgeorge@gmail.com>

---

Testing:
- Verified timer firing and margin detection using "hangtest" module that
i created (I will paste the code below for reference) and checked dmesg
logs for expected output: "Hangcheck: hangcheck value past margin!".
- Used Static Analysis tools
- Ensured module builds and inserts cleanly after changes.

Let me know any more tests need to be done on this module.

[] hangtest.c (testing module i created to test hangcheck-timer module):

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Clint George");
MODULE_DESCRIPTION("Hang test for testing hangcheck-timer");

static int hang_duration = 20;
module_param(hang_duration, int, 0644);

static int __init hangtest_init(void) {
    unsigned long timeout;

    printk(KERN_INFO "hangtest: Disabling interrupts for %d seconds...\n", hang_duration);

    local_irq_disable();
    preempt_disable();

    timeout = jiffies + (hang_duration * HZ);
    while (time_before(jiffies, timeout)) {
        cpu_relax();
        barrier();
    }

    preempt_enable();
    local_irq_enable();

    printk(KERN_INFO "hangtest: Interrupts re-enabled\n");
//    return 0;
    return -EINVAL; // Return error so module doesn't stay loaded
}

static void __exit hangtest_exit(void) {
    printk(KERN_INFO "hangtest: Exit\n");
}

module_init(hangtest_init);
module_exit(hangtest_exit);

 drivers/char/hangcheck-timer.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

-- 
2.43.0



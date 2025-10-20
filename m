Return-Path: <linux-kernel+bounces-861487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC1BBF2DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6C994E943C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658582C0F7F;
	Mon, 20 Oct 2025 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfowxnnA"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5895F19049B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983566; cv=none; b=cM3qo5HMnBIx7inWzrgnMoVVInDQhjkSAap4ksGqWpm8xh9d3vEiDb5ana3YwcgFcgW80pGS9YSVwwm4Lm5YOj6uahM8NxUyeixbNnxiuoYHdVnt0AYE+pJvHXf+9qDIsRoED5heCS+JAGCFUHozruOGa5xradVvvhEEX1PH67c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983566; c=relaxed/simple;
	bh=7KTD0uaFcyyq2og31+9WBkzgxxC3y7RTURPIR1fnqTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/u/EOEKBNjJN6DWoJ5UCp0sx1KjvJ2551P4FkkUmXOxkBT9N2AjJAxLTrgTa+SHyoAR2Gw6nGO7J5S57s2jcvyA4ZXfzs1i3zibNACvewbHbD215h1zsj1y8j/AglaCpD+kPLYn68EN+lSKcK4TzHxSGf8UC3bnHFvEYMV9qeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfowxnnA; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-330b4739538so4376401a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760983565; x=1761588365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScPigvONXCfVvbrizpOVQT4h67dphCjzneWDHaO1018=;
        b=UfowxnnAN+dJTIK7VQHC3fNAY7OoPwnB6VbGE+CghC5t62xpaaFeCyRqoC9GvD8Z4x
         QaOpthILzLuAzQrA5EH28it3NMi+gR7Xqv6nP7ucrYfbIGMh8cf/+LhPWjM9Kgr4z7ZQ
         SolVwXONM39ZkXnKU6Gm7a7pFArsmT10a+AMsY4KYRYlhOzDsO+hEpG5HIEBVFZUgeZk
         qbgLxKUQ9cNestJlTLeslQM8mRdEfdRoAlaX9EcupNiMGmNVnr8ODe9rTp21wxQOjkw5
         5F5FD2WuQq2/AVjXk4xSu2p31tYOWUEjbgz/basC1OW8AnoZ+xOcdtlImLwtwMfuDSOb
         0Ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983565; x=1761588365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScPigvONXCfVvbrizpOVQT4h67dphCjzneWDHaO1018=;
        b=Kk1ubZfV7DMhnuAa8n/z7bZSiNIEFJJiEsRt2X5Z6cLjA6OOv1PXGKasx0Rwm0sOfb
         VroUc2F9Pgugu9eS060Ewiyw59N58qzHbaKnmWBteLs9l5JYFBo0JdgjWD9io8/wvzmW
         5DrIDM5jyeZCyGR/bfwm/uprQzkf/iRxaPuP4xZZRfEo/vKxNLPA/BZtcz4BDgxGuVfI
         ZBAfVJfJm2epPbW8uQKSt9a3eCO51mBFIa0rx7zZKumXWGQvA36CisY2jIwVEndh1wvz
         jHDfQUNeRozQfMwfAYNBsKp3q/1IsYvFi596DUBNt3eiojhCUG9tQxe7RZwbHoxYVhtU
         1BAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0cjZAUxPn0Tpon3Jt/m4NggQvBEjsbkcroDTSr8tFNQMsW0qJUOcIbNjxQoQRRatmnzrJnF8xnkrSKac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpcK3E5mISsxYbUTnEzR13lWGNJbYQzbkpHEPrwPVXwVl/NmXB
	bJLMS+7i5u9ZYEskSKWRqgyp6sTEmtse97QTSDUmy3udhX02JHwJ+48r
X-Gm-Gg: ASbGnctsnDhLQ3hRLhtbCWNZhcc88pvQ2i594iiVSao2e36D0SxYUHOUJ01MKc4/Z7L
	RpOCqwjgEMOP+ElMQTAlxbSQuTA9WmrTbdIo1kTF8BErfeZououn4kyikDUtmZb4d9mdrbqF+rd
	8vtt9b4JGIeVwwPq625AwgsYu1W9Xpr3QQKBEkZyML0JA83MZPi0U9LATi4Z1SgSFqme2TXTUJX
	Ue5qerEmfrrOcWc2jwOj492iCBJxAie8L59m1M8KFkn6LO9MjtPsQopdr5NNyJS2PPtuLpZiioJ
	luDoyrtzG8WdFzj979fpBBUbR1qbl7GQGofFLNcCgh2rSHu4SuN/V2vwJ8nBOThr7zNEY5QWNw8
	GI6GMdt4HwfHZqR7yFg1LfdcgXIm8O99ZNbJp7TzIRZu35+RDhR/n9GHybm/nJ/Y1McpafPam
X-Google-Smtp-Source: AGHT+IGjGOh6awkg0N9FtQOWt/ipEbBqpahFD36PjVlo+wHCIz1HFIb1Ur9JR7ZLvNFYBniOl20qkg==
X-Received: by 2002:a17:90b:54cc:b0:33b:dbdc:65f2 with SMTP id 98e67ed59e1d1-33bdbdc660bmr16924225a91.22.1760983564445;
        Mon, 20 Oct 2025 11:06:04 -0700 (PDT)
Received: from fedora ([45.112.145.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de14becsm8681623a91.10.2025.10.20.11.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 11:06:03 -0700 (PDT)
From: Noorain Eqbal <nooraineqbal@gmail.com>
To: andrii.nakryiko@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	david.hunter@linuxfoundation.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	nooraineqbal@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	song@kernel.org,
	syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com,
	yonghong.song@linux.dev
Subject: [PATCH v2] bpf: sync pending IRQ work before freeing ring buffer
Date: Mon, 20 Oct 2025 23:33:01 +0530
Message-ID: <20251020180301.103366-1-nooraineqbal@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAEf4BzbtzHsa8DASzOg-Xqp8_-vG5ekC7JXhwuyZqPhrckU1hA@mail.gmail.com>
References: <CAEf4BzbtzHsa8DASzOg-Xqp8_-vG5ekC7JXhwuyZqPhrckU1hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a race where irq_work can be queued in bpf_ringbuf_commit()
but the ring buffer is freed before the work executes.
In the syzbot reproducer, a BPF program attached to sched_switch
triggers bpf_ringbuf_commit(), queuing an irq_work. If the ring buffer
is freed before this work executes, the irq_work thread may accesses
freed memory.
Calling `irq_work_sync(&rb->work)` ensures that all pending irq_work
complete before freeing the buffer

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Reported-by: syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2617fc732430968b45d2
Tested-by: syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com
Signed-off-by: Noorain Eqbal <nooraineqbal@gmail.com>
---
v2: Updated the commit message for clarity.
---
 kernel/bpf/ringbuf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 719d73299397..d706c4b7f532 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -216,6 +216,8 @@ static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
 
 static void bpf_ringbuf_free(struct bpf_ringbuf *rb)
 {
+	irq_work_sync(&rb->work);
+
 	/* copy pages pointer and nr_pages to local variable, as we are going
 	 * to unmap rb itself with vunmap() below
 	 */
-- 
2.51.0



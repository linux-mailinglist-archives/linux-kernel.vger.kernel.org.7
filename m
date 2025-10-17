Return-Path: <linux-kernel+bounces-858755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBE9BEBC56
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 834DF35741C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E51284883;
	Fri, 17 Oct 2025 20:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCw5MnP5"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C6269AEE
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734600; cv=none; b=EdTzL59YUNqb4EBp29mpjt3dZUP2IGcIqdO+ns+XFZK72f8XnPvUhQT4bdOaAe7qWc3U4BhKYv/Jrqtvwi1k7UQNzdE2/S6ZZJNQrl1MXuCPgO5VkEkvxSwqAFS/fFWhXZCZwXiXVoCmrtjLLQUoce/n3pDP8sYLWOxFuOT36Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734600; c=relaxed/simple;
	bh=hx9vos+yPCtCwcseu2S4GUlo2p10q9/9QdBX2Ueo58Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2CwddmIENlZsfGiGuOKNJF9eHNTQO+fGkUgIvjDLpQrJBplCGe1tI+PuXk7tSVEnh9DDgPDHLkrEcqQODwUl4Zlhf+bON4odlVuvoWVe4rNHb/yDQrUTKyvCvfDXRr0Tt68HMZx91NYeD32cifvgmoUhqQ8kQO1dQK7401CP/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCw5MnP5; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78af743c232so2097408b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760734598; x=1761339398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4OzoMP/a2gZ0PHbkSwepdzTTcQMHPqQGezL9DtSyXc=;
        b=lCw5MnP5qbYNutwft3BMlDFEgLvarBWxSuiRaFE+cbR3msFQSXzTUIFeWhxC/hvm7N
         BQusOaOXbcXQfMrUZiV3FVE4G/CjT66RNUk4bLNJMIczvBxLxP+sseVQHUkh4pteb+2x
         y1yYqXe84hdtYXASpU3Mw0g3MGtRbP1j6w9S/FZn7Q/8YplVZTdh9KmKKn0OztcAG9ta
         NzBbOtEtX7FN42j4ziWFiz2qirslr7uszElJ39kSdbq3llCv8sboQTKoTd2nlfvbfjpG
         Cp4LUu8OvN7IGwm2yk7HoMt0W1w7DaNc8iP5FiI4No8uuu5TaBb6ypM2ExtGdZTB7zVL
         Cf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734598; x=1761339398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4OzoMP/a2gZ0PHbkSwepdzTTcQMHPqQGezL9DtSyXc=;
        b=pUAKGRuPcK79peOcuYTIoCzm/KNB1+L0nsK30cQ+3Zfh4gYOd7LwTmKmAksqfVyHWj
         6JVAxhaM4EPsM9dcsgAfh6DQUMJ+nKiRNwa1h3AUE+36dK5Pximoe9K4FWzQARcS04gZ
         SbjgCkClMYHvgYwyzZzLW8Fx2dum7Fl6BYYR832LNH1PdCEfhhHcOwl02dz8c8iJYSNd
         BcZ4LPDkqgkVeB4pjRBcPUb4wcTW8758pyOBrV4CUl9HCbwvdna5FOslXq+KXadpeG5y
         8xoIs5Rffr43ObtZvL+8T61XKNqzVkPd/RmiBdytUblOHHlvs4HR/2nJlR82KXuSK2L+
         H7/g==
X-Gm-Message-State: AOJu0YyvswKzl1YJjKSoBc1Yp9ojzNOGWz0ark9STtcZChd4jgHEedQz
	kd1IMX6ulq0VzMvZFsJGQRuFIEKhnR/sKStkHaSckyqyN1yhwVqvdXgO
X-Gm-Gg: ASbGncuZfWJ6HQH6sHtAKKl8mLKkjjRITD7rP7JqLPBA7JvwbsdXhoLJf4lpDMwjAlt
	MEGmgv7ZFjwRUM3+q6v+E2gKnoS3Yc//O5Df4cdbN2mdaMncOoC3V4/qBxj6Ql1f/CYXQjgkR6Q
	DCCLeko+xyJxEnxrXKNoHAmiaMzGdRM3xBlakmoVUg05PQdoIQf62yGhuK8BIGSNmub28S9lw+u
	uX/bqWRe4YyXakh+xSUPHvNCbVraSkAGkbSqL3Qm2NivPalexu5e0/2DfwIgioVeWAfSjojZTp/
	X8aTlO9GtbjDPtY5qRsPt9WkgVjtiCFpifkGIJlsaSAGDNfVuktnbPdGb7ygsBTgRRsuRXDDg2e
	bHVk2JX5Oae9iY5fzdJdsbWleWKvPmPJpkcT8yy/Hw8jpJ4TLn820f3mJVCs+l1iRRZ67g74P
X-Google-Smtp-Source: AGHT+IG8ZoSRWGJfoKodDJK6JoR3abT/iIStA1JMD0SOr9u0PR0yWs2cczMAZj1IFEg8cPVTVNh4xA==
X-Received: by 2002:a05:6a20:72a0:b0:2d5:264c:e494 with SMTP id adf61e73a8af0-334a863acacmr7071062637.56.1760734598365;
        Fri, 17 Oct 2025 13:56:38 -0700 (PDT)
Received: from fedora ([45.112.145.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b73727sm656973a12.40.2025.10.17.13.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:56:37 -0700 (PDT)
From: neqbal <nooraineqbal@gmail.com>
To: syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	neqbal <nooraineqbal@gmail.com>
Subject: [PATCH] bpf: sync pending IRQ work before freeing ring buffer
Date: Sat, 18 Oct 2025 02:25:46 +0530
Message-ID: <20251017205546.262475-1-nooraineqbal@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <68e7d0d8.050a0220.91a22.0008.GAE@google.com>
References: <68e7d0d8.050a0220.91a22.0008.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

Fix a possible vmalloc out-of-bounds access caused by pending IRQ work

Reported-by: syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com
Signed-off-by: neqbal <nooraineqbal@gmail.com>
---
 kernel/bpf/ringbuf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 719d73299397..a6597417412f 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -216,6 +216,12 @@ static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)
 
 static void bpf_ringbuf_free(struct bpf_ringbuf *rb)
 {
+	/* Ensure all pending IRQ work completes before freeing.
+	 * In PREEMPT_RT, IRQ work runs in thread context and can
+	 * race with ring buffer destruction.
+	 */
+	irq_work_sync(&rb->work);
+
 	/* copy pages pointer and nr_pages to local variable, as we are going
 	 * to unmap rb itself with vunmap() below
 	 */
-- 
2.51.0



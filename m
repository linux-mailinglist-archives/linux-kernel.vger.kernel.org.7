Return-Path: <linux-kernel+bounces-828996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8614CB9601F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4161F446675
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272BB327783;
	Tue, 23 Sep 2025 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXf1NiRq"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A5F2D8371
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633993; cv=none; b=JTKfM6lOK9STceyFraKXuOvdjATz+ovUAm9OO1Dk8+GSfF6Tb+UOZ17cuH4SSRzv750iD3ragXOruyjEyLuMBJ5SIO60266gjMun/RQf1xsUmJhJCbrNK+cjNmRiIyYK2bjJPNMXb5C7eLA4KXh/EdX8u56Szn4g6c384p1cAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633993; c=relaxed/simple;
	bh=8V7qNMYmqmW763GV+RmYh7nchonJ2A54SiLgvLE3h+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IAKzAZdmXidM+pXwVfRXcc8hMX7rQYUO6noG+nGZxO7D/GJHm0wgAmX/kYbtphFQm2wEnvookHnm4zFGiSd21hoCv2rlayoTexjfsmNk/QOmJlTKOgDu1diHB9xRfmgbSrZyEpfVPxmbbfOfeJ+L6so5f+lkmmYdFdH3Y476/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXf1NiRq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f59f0cee7so655558b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758633991; x=1759238791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tRIuI240VxoL1i6yBF368B0vqwfoxg8/jQr7RxkgoA0=;
        b=dXf1NiRqZm5ceWONxDSm25EuPbw2KJHbsQnPCRsI2vUf0VbunbmZrdYUOQzUJ2OO9c
         70jyDEc37O2UD5kizszvIjTj6Fxa6iJNHPX6UVtYWA/YT+uFMtulS804QxyE8CHrNuX6
         BjlLitVVMlm8WwXyWy3Dv+JFrzs1qxns/PZ1xkOVgKow6KM4EF7eBESj4sI2r4N9VKh/
         NyJugNi+8wfZE0tDsY5bBpBwmo5tIorC1yKK0VgEyi56ky00SS2WaFNsWYLxEo9zWcGV
         NEAZhyWGq5tjQnEmaR7m05j0bwqrODd/8EsEu6BAdoIipXTHjJqWlWc5yP9a5loVGh/C
         ZVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758633991; x=1759238791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRIuI240VxoL1i6yBF368B0vqwfoxg8/jQr7RxkgoA0=;
        b=SH2FipKt1WE90NvnD+EKWG+Jd2QtqvnDF8CdI7N7zdWE6XwyZbwfkqZhQVtfu/MU1M
         gIdlVbw/eEyR6lCRo45/b8cEply3m0d2r4stCgIhlPqcJZMyjUNrv/KN0QNbrTijBCN0
         a1UdEpNtNlLa/z5Tjvk5Ip5XHv8n0mvRQPe+vvX+HVy+Hv4wEY0iWHCzuPzSQ1DUB0ZY
         4/4JPLvas3bYHIBM9/vOHfujfrWnPzFyCrjZ/v7+NV83b0y6S5B3tXHDsNtw6smkIXpi
         TV5do2cZjqaaPriBCRtm7LN6qUFkvW7qxUcxFutp13A1aa0PFRSy2fH19XdlqX3mzrAT
         TJXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbhPDuDvr8DeTdagZRVuMY8toZvHCLcmIq6TZ7mTu1HxyTTZEujoscEEZ/WzD7vOHo3Uj/M6EIWHJFUTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcUZ0szJjJxp9QHQgqxFOfraejUUG3S8EKjkPUS7xeY2MutgpJ
	wOG8utULAA3RZbbyN9V9q1SeFD2aVQwz7BetwBWtJps0zrwR1UH3jwUg
X-Gm-Gg: ASbGncuNfLsWK3k3r2FNhm4Ts0JHqxW2h/RdVCjRkfdLSM8h8TX2OE/5WOOAhpw8MJz
	Jt0plMloAJ9vX//817dRbFYuUU2XVkXkKmAub5fjXJYboaeL7XlXR6Qqswee2AdNesakL7pjMWs
	ft7MDufGmwmyKS1+oOTjR9OJEWLTI3MoIfaWXkDGWBV14vf2Syd5PlrpwueFD06+T2KDgBgPt0H
	5S+ERWXNvv2d3QqZlQaDuQUQqqiKv4EGTNfqNN85YnGiutO/mx9kM4X4+GKyc00Hz5A9h2wm6ct
	skvwGWPcug+LPf1fytLpteuLfXvhxL4ygWFB1Z8F/K8hlUra6wg/Yzxt/v2f+Hd1x68LExxoHHv
	S00TYayyjLZF6n+/i49CjDmCoP+efCHi4kjtA1NM=
X-Google-Smtp-Source: AGHT+IH+ADeNw+LNNzz6vR2v2zPzN/YX3R6hydhAz88R8isrPRyZE7v+WE0D/79/D3puHieDDLiHmw==
X-Received: by 2002:a05:6a20:12ca:b0:263:1c48:912f with SMTP id adf61e73a8af0-2cfd9cc9766mr3844189637.12.1758633991225;
        Tue, 23 Sep 2025 06:26:31 -0700 (PDT)
Received: from cortexauth ([2402:e280:2313:10b:d917:bfec:531b:9193])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551f3ee095sm11417841a12.34.2025.09.23.06.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:26:30 -0700 (PDT)
From: Deepak Sharma <deepak.sharma.472935@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pwn9uin@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepak Sharma <deepak.sharma.472935@gmail.com>,
	syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Subject: [PATCH] Fix the cleanup on alloc_mpc failure in atm_mpoa_mpoad_attach
Date: Tue, 23 Sep 2025 18:54:27 +0530
Message-ID: <20250923132427.74242-1-deepak.sharma.472935@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a warning at `add_timer`, which is called from the
`atm_mpoa_mpoad_attach` function

The reason for this warning is that in the allocation failure by `alloc_mpc`,
there is lack of proper cleanup. And in the event that ATMMPC_CTRL ioctl is
called on to again, it will lead to the attempt of starting an already 
started timer from the previous ioctl call

Do a `timer_delete` before returning from the `alloc_mpc` failure

Reported-by: syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=07b635b9c111c566af8b
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
---
 net/atm/mpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index f6b447bba329..cd3295c3c480 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -814,7 +814,10 @@ static int atm_mpoa_mpoad_attach(struct atm_vcc *vcc, int arg)
 		dprintk("allocating new mpc for itf %d\n", arg);
 		mpc = alloc_mpc();
 		if (mpc == NULL)
+		{
+			timer_delete(&mpc_timer);
 			return -ENOMEM;
+		}
 		mpc->dev_num = arg;
 		mpc->dev = find_lec_by_itfnum(arg);
 					/* NULL if there was no lec */
-- 
2.51.0



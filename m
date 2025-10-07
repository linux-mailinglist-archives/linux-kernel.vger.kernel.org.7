Return-Path: <linux-kernel+bounces-844300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32174BC17D6
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA5F19A2FCA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366462E0B60;
	Tue,  7 Oct 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Eab+htxr"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3EF242D9F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843476; cv=none; b=CPoku1PM/cfDB/1P5Vv4f5UmC61p/3+vAIa+y5M1J9dHD9ady97kBzisM8WGdF2sdLZAZKcYS+uJwQrEIRkfLpeQsOjNvd8LN984kEbgakKW/AUFGvl4obINxvH2E7PtyQRlLKKBWQN1sZ42hPNLaF1dspmfkt5993Q2vVnWPL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843476; c=relaxed/simple;
	bh=bghomkZ/Mo0/sVWF2FY7OF/9Z+YYexGj4hCWn+ZCfag=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=UWDeUwfCJfreWScLx1HW2D56izNzV/M9iocEPW3aiJx0YpyyiIaCn2oKZGWT6jyR17n7vuRUFmeb3O5KKDVFDN68nGZUShWKSG+P0+c2P38h68F/NPXBTL1AgJ/TufQ1uAjqseNu+QRyiTqhor7d2hXIzpUer+4oXCaTEIzMPM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Eab+htxr; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-911afafcc20so249298639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759843473; x=1760448273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WweNkwNQjd8/1NMfLt34sTeCfWxi9H3dopa5H7gJ+Y=;
        b=Eab+htxrZZcD49PvCXlUSDYx9pLRRzSg6ctYn3uN4ZbRo04ptYBZ83cSQEcpshXD7e
         9xb4/fN7yxNeXN6LVtCdg6E4U0l+/xJY+ih8Y4EHQ9YCdPFl+/SnK9KrTrH/eOTp/SKM
         siWoE+P46eOTct0DPsDpz2XlSUqLMu9MArH/wH19xn+owuQYIRlE2UimMT3WIn1uC+4f
         nDJKBSxdWPsoCBGmRQTv2kK9YGQn3pauh5PuzLMd0rOJQ5EneVKVV0QowfkHAIlifB7o
         jh+h5qxp0TTuZDjbdhB0s2Ajz6HA2mDAP6UsrVHoG/4eo1q4j/ysgyzTa0IpLuHWnetf
         Yv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759843473; x=1760448273;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WweNkwNQjd8/1NMfLt34sTeCfWxi9H3dopa5H7gJ+Y=;
        b=mrJblgJzlJPCMcfMTY6aD3yTx/67yScxv/v1AdhO9VfIi28CnWL6Lk5Ni+Ep+wngWY
         pHVZ5qwAWJVzwfbAM8NRtlqiobnktLDt1oEpS8SnI57rVf4/96Vb8x+W/f6tzchIN9YL
         gab0YzCyeCrr4EC5o/dXIw/zPW0F0/pbw778PzPYlwcp8eTzG0fr9TJSyWDDfbV1RxBx
         BkVdhn7XG+cmrV9Ra1nIYLrCg8/OS4MYzHEetrqfANYJOs4qvKKFjrq3taAq5a47IK2e
         jdz+c1aqJdp7EJa3V5/p16Ozd2ySk9kZJgOZTkWpu2lbr5A+dtkO5tydjn+oUaCKFRvj
         fvGw==
X-Forwarded-Encrypted: i=1; AJvYcCVfz+jRKuazCTlaBj9U9MubzsZ+8oUCztMt+Lb25+sxPjBa7GSFD7aLVDYEjgu+yXygUHuLBvo3DYYSkm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv8ee/n5HPAPRux/TUi0vEs9cADBu8fOnFwjhxKPJahK+agCcX
	ZZSyuDKHxFDij3F8f9McYDdrCpLSr8cdKfdWTtnFywZmxJBrlrzIlyUXXbd8BrgdjYg=
X-Gm-Gg: ASbGnct4IRBI4nYd3i6cXyUTlsw0O3oVf5KWljGdVPrd2clZ23t2M5FnNf5yXYz24gL
	z2aEmDpdA9Fs3hey70TmAbBvVU19MwSQwQvM41jjaFkkNAecjoFf43h2+bOX4iCLEhRM656iJfK
	G+R/zm5AzwEzeW5rn0YjuQZLNcYW4GGBIkEz3ZY7rUALrtEy2kleQZicBcU/7aYAzNYRuQUj1QM
	ZBE/wtUp2tB/wzHK/p7ZTLhtgaS8Q27rjk6KM8T7wIfwUr5xNGpWQftoMO8lSTSvJHaIZ3qhqZH
	gtKFiPdDxPHJL+jV2FmPwnP0hrUS3jTj6cnQID7acvrvjluuhUBaNn+4bNLN6t/cK41QyKvr4lp
	vTgea6POC+stg6CJZ0OijyNeGgaVg5/DJpim7bP26c11/83F2nFWZRoo=
X-Google-Smtp-Source: AGHT+IHcWl2NGaXs3tOeNLLuo2dAOE0d8f54gCIAKh8ZkAGoBlURwFGuC+CeUxZJtomkNZLSqS0sfw==
X-Received: by 2002:a05:6e02:1a8a:b0:42d:7e2c:78b8 with SMTP id e9e14a558f8ab-42e7aced6e7mr209520135ab.2.1759843473392;
        Tue, 07 Oct 2025 06:24:33 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ea3132fsm6092368173.26.2025.10.07.06.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 06:24:32 -0700 (PDT)
Message-ID: <747c4bf7-49bb-478d-a8f1-c7092ceaaa81@kernel.dk>
Date: Tue, 7 Oct 2025 07:24:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] [io-uring?] KASAN: slab-use-after-free Read in
 io_waitid_wait
To: syzbot <syzbot+b9e83021d9c642a33d8c@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68e50af2.a00a0220.298cc0.0479.GAE@google.com>
Content-Language: en-US
In-Reply-To: <68e50af2.a00a0220.298cc0.0479.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git master

diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index 26c118f3918d..f25110fb1b12 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -230,13 +230,14 @@ static int io_waitid_wait(struct wait_queue_entry *wait, unsigned mode,
 	if (!pid_child_should_wake(wo, p))
 		return 0;
 
+	list_del_init(&wait->entry);
+
 	/* cancel is in progress */
 	if (atomic_fetch_inc(&iw->refs) & IO_WAITID_REF_MASK)
 		return 1;
 
 	req->io_task_work.func = io_waitid_cb;
 	io_req_task_work_add(req);
-	list_del_init(&wait->entry);
 	return 1;
 }
 

-- 
Jens Axboe


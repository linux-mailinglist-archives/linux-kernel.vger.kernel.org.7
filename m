Return-Path: <linux-kernel+bounces-844294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8740ABC178E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB11D4E1B6B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF532E0B5C;
	Tue,  7 Oct 2025 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UtIk1H+p"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D67025486D
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843212; cv=none; b=FwHNZhagcORoGV5mKdCGfLNiu/JlnHmFmb3rAnewUHYNNPOQ6rvlhlaELKybRd7F6o9Vh3sT2Z2oMv+MGbrjPMIurTAjD7A/6QGOKvRKTmJKkRGymK6UFidh7RHJWzRZxKtVR1NXXE0Ij3ys6WMgkFIz8R1PGEbXR6Ppm7lUOvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843212; c=relaxed/simple;
	bh=giqCpi0LH1kxCJpdQzyBEXWToPuMe+YtyXITit3AxbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nia2WgCVdL6N2AVM3NFtNlp/P5PR6t4qe5E/RIW6HjaHSQ4By4DM6lWFDiVxbY2IAq+asE6VQN0tOdZmFepAgsJ5PrJ5Dy92CJ3I+eAfTsHIU0Ys4bWcKDGMw1wAMxyfgWwbaB4gwk+iZsVcPYYl/e05ORoprR2ZRpyAUGxHE3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UtIk1H+p; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-42d8a0f09f6so25421945ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759843209; x=1760448009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gFkYQqELpZ/I5DDYLLleq52CpzNajwjStFZiAMR6DNo=;
        b=UtIk1H+pZiERYJW1o3TSw0V0VmA2OmaJNMk62hQAkPaDJobOLDpAnWVDRDCTzkurBR
         Lb2TXJU7az8mZXJS87I3pP442yv5K8RUYso01xvAOnNpo3zISzSwavb5K8mY8chl9bXB
         +D6XgevkZZYgbO0PSnrAV53Ac82K+iWbZgsFNe4oeBF8i3vVBMCuOYOL914rDYBaVvxW
         DIGDOTVxtWk4/grtNHJdJyTIV3XDbcPTza85KwnkuXy82c2bLNrlm9DNxmm0h+jKSTjU
         ZY+kWu3AyGgB8lQ8yE5HAI9LbM8CgepJjJpYEJEea+oXjboSilov8V2s948GxLO/FuKZ
         hFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759843209; x=1760448009;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFkYQqELpZ/I5DDYLLleq52CpzNajwjStFZiAMR6DNo=;
        b=nX0T0E+YHSws4Uvq24wcvu3QpAElkoPhzbU7+gaXu+/Ws7pPJisOzYb9jQXGycaRhB
         RPFec3cCQWrXYUJsFMe2R9RC0d6+7/tNm7dzMYDTsym4yxI1Mp7HPwi55su1VfL+O+oN
         KYKvEf7RSGBYi9k/URUmDqsbSkLtiGGg2zEzA0Hn/zzmXRiilCx/G2VqRdpsAk3u8Ou/
         ki7Hkpp0LYA1N3U51JIQrRAJeu4V1pIVLqCsfu99EyKMskr037hAmTJc8Z+q82C7bOEh
         w+HsSJoYNHPywgqV6JVj2AsIc1Cb8wx7QSFRpLnww9OZTHcnruxEURpXMkt6HUamTuua
         3BBA==
X-Forwarded-Encrypted: i=1; AJvYcCWHJvoZw/tnxTMk/n7o/zRdrSbZzB9jzwbAO6HO9LitoxCKBRRr369nlzsi4iXGt32Ynb1uIH+q6t1GeM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrrVu5Hi5DKUtLLk/Q3KddH1p4Kg4s1GeoahQiHKR4OZDDOJE4
	drkUSEHw6EHb3iZxF4a7Ua36/poJsQ4lN4Ve1wYtf8JPqxiK9VlQc3tIZ9/vPigVgtQ=
X-Gm-Gg: ASbGncsRfwaK8qqn80AYA8OjWImYKZoIli3QFVTuLY8wIOwMT6sIi4E7SK7cUyTF4oQ
	brtVpAWOfw64JFv3ugv/0EOUrlLasj4rsg11tv5JqWETCYoP6zKIB41bz4vAkbFZBXXB6tKOiWG
	9/KABdCZzWG2WXezQR6X1a2nRVA95dVkgrYUXtHf75PLeAkuoMKzwOt1LxXfdydX2poqIBF6pPF
	bvR5oLJZ9E0rKPiUHEAsYUUZ5HJbfCMxw8T51+uMG7lUNXRbD/7FvmjE52X7/vfr68Zbd5m5lAY
	fCi+rptdK3WAnl/4Ionj3AzNkayVGz5rQ6oKJYq1s2LMvHne4+jLNcMtoMkYQbjgQNYe80itucu
	KPnAQiggobvh0aTxA+UfPcTCLEfDHqePj5FhY5jt32gd7I9uGWLMD6FU=
X-Google-Smtp-Source: AGHT+IECpoJl5ZknvT8EatO5MCAHJVtZrLUEEc1VV9KUIEqsn3vWrqz+GBQUzNa/CwNmBAZBLoaGKQ==
X-Received: by 2002:a05:6e02:1fe9:b0:425:7466:624d with SMTP id e9e14a558f8ab-42e7ada91abmr224158295ab.26.1759843209434;
        Tue, 07 Oct 2025 06:20:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b294ddfsm63257435ab.33.2025.10.07.06.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 06:20:08 -0700 (PDT)
Message-ID: <7c0346f9-e90c-4c15-a2d6-b2d40005361c@kernel.dk>
Date: Tue, 7 Oct 2025 07:20:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KASAN: slab-use-after-free Read in
 io_waitid_wait
To: syzbot <syzbot+b9e83021d9c642a33d8c@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68e50af2.a00a0220.298cc0.0479.GAE@google.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <68e50af2.a00a0220.298cc0.0479.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git

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


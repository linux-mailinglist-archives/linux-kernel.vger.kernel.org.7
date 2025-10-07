Return-Path: <linux-kernel+bounces-844293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2371BC178B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FD674F58BA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA782E0938;
	Tue,  7 Oct 2025 13:20:13 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0032DC76A
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843212; cv=none; b=DuwgDNFACaA2LAzcHLGzurYbwvstC6C3F51+zc2SVkfSJd4nwTCqO9WCxsfgWYygNwXCaGpOOGfOztEM9yaat7cdcYnXd5oEbVLHMavkgGNZzwS5zuvIKbQGWYIs39AayAmZpDLH4gI/Ylld8PpxUyaFSTks2WEK2OiPuX0ukYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843212; c=relaxed/simple;
	bh=HCIgy9FzRlDPKwgdolMgt+NcJMv5yID3856qGOPZ9ag=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=MaVvHKsToNTjKZGT9kor3r+W3lGg8z5Uu9a0OayYVclqCytVRZpgTAyGA9zRX0YP0sdPiHGy/XkXY8AryWRwP6QT/5/qrnDY6gm9fyuAWMptZFu9rg1T0YQ37emcTLtAmjP0ywblBgyf3/n0qspuC6mZJdYLe36T9GwvcNVw1C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-930db3a16c1so1485869139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759843210; x=1760448010;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOfGvihmVurLYIYTy01Sm4ZrKHqm1xB9ugNFGyMdrTM=;
        b=jxZN1QzsuJBGhvSl8bkfe9gKt5mh7SJYv/QEi2DI/S+LvOgPPHHQXsnjVBDQdit4/e
         /zngH/6AbMD+FKZBKL+M6Q4xNSyPuXF+eRx17y4F0GOWmAlsan48JQi3ES1kjj6yALUj
         yl9L7F94Qd97HW89xx2aG7i9PKIOlOotFcylbOOZz+ipZWPw5FF6cAQOOtU8wNdH0kEc
         D6k2ZaJRe6tP60GjnMj5uNnFo7EK/orOxw08cIqiQE+U2HRI/6rPW0l5mHPoToF131Wj
         RpfsutrPRTULtywoK+Ck8Sy2UETfDHPoxPiTub0Vrx0MEgXeMkSKz0QUZg1Ah4UXl6hl
         g4gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMqS9fTl7xbpYVn3U1LsDsNvNsLu+h5viv8MxZvharaa0CiYBtQHhFWb7Dolb+AlYeXiJybGdU0cP0o0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzik2XMwFQPFCIokBXZjg9YKiynrDZQKBIpiBMVu7Tsg8Q/R1ub
	fFZke1wa4e6c2D2JWn7b0rP/Y8vjiSDuhVntt/+rxtqHevxHLQNnH6m65P11PHJD4qS3wnttBAJ
	BcbLswVakkO1EUnLTh9aScItFWrdIxVBgoGVQCuoGCFflt0LBPk2Tr3DPQak=
X-Google-Smtp-Source: AGHT+IHVR1JzLJS2esFeRv/iYFpIROg6XXXiqM63kA4an+8QZbGWpq2qhVwZppeC8RTUXsyvhwYrPL0Z/wT0M3z8muPrcIwAd83X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4190:b0:918:f2e8:ba6c with SMTP id
 ca18e2360f4ac-93b96aa991emr2345226139f.18.1759843210374; Tue, 07 Oct 2025
 06:20:10 -0700 (PDT)
Date: Tue, 07 Oct 2025 06:20:10 -0700
In-Reply-To: <7c0346f9-e90c-4c15-a2d6-b2d40005361c@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e5138a.a00a0220.298cc0.047a.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] KASAN: slab-use-after-free Read in io_waitid_wait
From: syzbot <syzbot+b9e83021d9c642a33d8c@syzkaller.appspotmail.com>
To: axboe@kernel.dk
Cc: axboe@kernel.dk, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git

want either no args or 2 args (repo, branch), got 5

>
> diff --git a/io_uring/waitid.c b/io_uring/waitid.c
> index 26c118f3918d..f25110fb1b12 100644
> --- a/io_uring/waitid.c
> +++ b/io_uring/waitid.c
> @@ -230,13 +230,14 @@ static int io_waitid_wait(struct wait_queue_entry *wait, unsigned mode,
>  	if (!pid_child_should_wake(wo, p))
>  		return 0;
>  
> +	list_del_init(&wait->entry);
> +
>  	/* cancel is in progress */
>  	if (atomic_fetch_inc(&iw->refs) & IO_WAITID_REF_MASK)
>  		return 1;
>  
>  	req->io_task_work.func = io_waitid_cb;
>  	io_req_task_work_add(req);
> -	list_del_init(&wait->entry);
>  	return 1;
>  }
>  
>
> -- 
> Jens Axboe


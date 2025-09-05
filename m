Return-Path: <linux-kernel+bounces-801875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EA5B44B03
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33FB16D7A7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ED8154BF5;
	Fri,  5 Sep 2025 00:46:28 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795EA17736
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 00:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757033187; cv=none; b=ScDa2IqxRRp3wwkfLaf8HgEim/niZe28oZSnhvhaSxuwB2XKEU8A0j2zkwGtIqeykZmbiBHTHvZoyTjAJLUmOsnGCFBbQfF/2wn2vXTz/Nn7PF+BK+kPWRcbt4kxPH1KEg6cCSwDz5S93Vx9F7lU+kq7MIRlrkj2I1NhURafNQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757033187; c=relaxed/simple;
	bh=t/tsGB2PgjtWlGJYuG6tYUu0+jsyFlyipZHrS5X8xKM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sRtt50N6sPYAKg9jnsLYyzx/efqq/AHa6VgynAm1hPQQCwkGYKwJd433WXThrHjuRhPL2yrlLlDrvIErM6lXf7uvzJW0XnBoahR2Kf8h5qVcKuhUc8Odl1OG3UX93abZCZIbJHKox+wCqvHpZUm4NlK/m5VqviaosYI0agUJ8QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-887280cfa52so187953839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 17:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757033185; x=1757637985;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JHIJZxE6Uqw+PxN1tHk3k85HfF4x7LH7g4WAgpoRrg=;
        b=EJko3iLsHR7mZlTuBJwsJRjeH7FBzWGZJrVFBVK7ZCWL+EyY2ONCeUE7McQYaVtKc8
         tMJNLvmEd0tNnaBvHjH++8v0ya6Q5BN26Yy9wgqZnBwZPd/U85UWOdoGE/CCVS9zhHUB
         TnqKqvC/bClpKUgc9BaD+I4E+s394gVl7Xb/EueLufrXXnFQOK1P0fTaZwroHYlI2bud
         HltkTB5zVNFjlmIWJtj+wq02+3JCqT0MGIz3pDVwtxZJzB0yPjMwt3wONzmnq/1QRzYQ
         9N4jhcfTs15Tp4aYpyEKcentw2AmtTw9vsjQkat9s/BvBwAxGC8ep4JsOzqZaryPAy+i
         a2WA==
X-Gm-Message-State: AOJu0YyhZmcvE2CaCghVmXI7lv2fnVDCpCCgyW0nsCUjvZRVKUjBA2Oe
	MZCFVHibyQ0dPJgtIM0tf/HdoylbDEBPfbKbYyNAsU+FG8OKqi+rwlTxTqMr0Q3K4GfnWO1lk1H
	U/fOZhQmwmUDK6yfGdprYwihjfFrBhEF9L0fLLU0UUvTXUEzwh1mLfgG9Xes=
X-Google-Smtp-Source: AGHT+IGfIuZ4NNGYb2m+x5M5UpMMUtxR+dvkV50tbTNT/+izlpzYvhZFNx3Q71Mc05GJ+8k9ul7E/XE563wQdxTRamcb3ArfI6/I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4903:b0:3f6:5621:fbde with SMTP id
 e9e14a558f8ab-3f65621fe5fmr210580265ab.6.1757033185666; Thu, 04 Sep 2025
 17:46:25 -0700 (PDT)
Date: Thu, 04 Sep 2025 17:46:25 -0700
In-Reply-To: <68b9d0eb.050a0220.192772.000c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ba32e1.050a0220.192772.00d9.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [netfs?] kernel BUG in netfs_perform_write
From: syzbot <syzbot+b73c7d94a151e2ee1e9b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [netfs?] kernel BUG in netfs_perform_write
Author: lizhi.xu@windriver.com

#syz test

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index f27ea5099a68..09394ac2c180 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -347,7 +347,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		folio_put(folio);
 		ret = filemap_write_and_wait_range(mapping, fpos, fpos + flen - 1);
 		if (ret < 0)
-			goto error_folio_unlock;
+			goto out;
 		continue;
 
 	copied:


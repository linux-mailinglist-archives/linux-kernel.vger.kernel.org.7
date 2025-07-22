Return-Path: <linux-kernel+bounces-740857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81999B0DA10
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82FB7B071F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F5C2D8DDF;
	Tue, 22 Jul 2025 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kp4c0eC7"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E939B667
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188462; cv=none; b=gghSl2gSr+7QbJrvqYHgBeg8GsCoxx9Jt9uFm7LgHCidOUZrSayMGDGGqal9bxxagwAS1Jk1tYXUEQCafN91f78Jl5Xp4O2AO73xdfsiYZSqljOWmLfW5pU9brSeao+kLuvisqp//rF+ukW1PrFR8/SEnayq13+gGYJ8/o2D+LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188462; c=relaxed/simple;
	bh=BCqqG/JYZREWmqb2TIum+4lHkIqrIqUHj4U48MsJL7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D9AZsMusmvmsiwJT0LGvD0Jj4tzM4JHSxq59aP18rd0F8D0D8NMSPld378CBm6RH4kL8Ge4qHtsBozWvOBSM2/JjCP7bMICBAkK2w4AOGHB7aPXB9S+49xQ4PLKLvVxMT/67MV3zcfhiYgBSou318/281+iTCyLHeGWTpJNSWkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kp4c0eC7; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3df210930f7so26136725ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753188460; x=1753793260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kzA1ZF1lKTa3rq2PsLi0IX0tfwYm6sKML0iO/BSEj7c=;
        b=kp4c0eC7S6H+Ux7Hmq7fgAR0xR45e1VLdFd3BtqPYHAaxsubPZbM7zV7MCrBUgxvt5
         64AqdmOwnVbyl/Aaao0MWQbWZJZHQVu90f7pvWGxJNMPfPp7k0c8KALaTeqPWB7xYW7K
         BtGP+zasZy9NXUIe1x/tUHuDikEOOggsDv9H7Yk/VTboqN1sL7b62dpRQhKnmH2KK+mz
         UrDG/ojJipUlPUPDGU4kq40xVYa/gsUT++tj44vrlezBwautD01bJl+LLFAlsjxLfs9W
         mLylfmmrrveJyfftiTzVc+9PrGj9/v/kOP/rYXpBF5m6K00oXLcKjKNcUvA92/ZhwfrH
         R7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753188460; x=1753793260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzA1ZF1lKTa3rq2PsLi0IX0tfwYm6sKML0iO/BSEj7c=;
        b=IabLfeSTNcGlsfrKaojwMNveEFpA/O2lBo+LLkFqUF/v5EImFC6Yal8Mb2uBpeSkrj
         bUnb07t9h/YRytPBaMdncSZs1FEbcTvdIbTK/oBTYBiFdg7BSJAofPi6WIr8nXnvJHk8
         waAxnKRhtVqIR9xyOsqrqPY1AAHhqjn3mxgVkY9E9Jq3k5a+0W06xQlWIB4i0PTqMmuZ
         sEiaTJEaTbF/ReD8d50+rIxK0ZgFCQUXINSRaIFigz4JCq3ySDxrRF56PtLrxd/YFnJx
         ooJ9c66qTh7rCHfLSiPxn0l6PUhhQrXucgsJgAQmBn/+m7Zpfj8Ete/4xkvojkf/V/as
         MT+w==
X-Forwarded-Encrypted: i=1; AJvYcCXh5/VamHmN6VanJQ2Swb1acTrIGM5D6C4LgDZrJ1vkpNUUdaN1fhHfHl21tvz/TmoEW3X0sJo/Up6VFMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrz2of3J5qvSOT+oPjrKZPK1ehUebMlba05qSMT1Z1QYnmOEm1
	/erbSJq7WUne9KDkND5rrI8K6Poa2RXR0GfwmeRw47eQbuP9KnmkXIw/mHJNlMJuQf4=
X-Gm-Gg: ASbGncuvjSku4l0oKisvmNVsg4CK1iQ12fiU1Oe9EZ6gXbHIGFoAX6qz9IfFG11Hqud
	qyw4gVzQldLs8CkABpsdQZ85agwKC3wiFUGImt/JX+amXbdrv47vZ91b+I1IkGR0HRw5prbpfFA
	6PZy6TXLbI8bGq5Myd5pVbq8Q7ksD2X+qjAs7YKC+e8tSiCmv9SU6m3HyzWVc24hdtySEY4e+W4
	7y9ZzcxwIzd9Gi1eget4Gqv6D4BkTNItvTHf9vCA9zU1EBYTLVDvhEII88D+263bGfcZlQ/RJ0t
	Z+BoF85kVLOqNOfwKCFBVvVzI2i9aycodP0xzYEEpmWSy8NTTg8N3F69cBA8n7KBjNm+6FjhaTP
	3Cr0q+HeChxvowgCEnd4=
X-Google-Smtp-Source: AGHT+IGDETyK8V2byKtut5obhRIYa3guF+9RXcxMNbbRL1RH+67Jyl+q2Kn1hTA1U7321+G/NVX+Qg==
X-Received: by 2002:a05:6e02:1fcb:b0:3dc:7b3d:6a45 with SMTP id e9e14a558f8ab-3e2be594312mr53708305ab.0.1753188460499;
        Tue, 22 Jul 2025 05:47:40 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e29826d45esm31215735ab.36.2025.07.22.05.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 05:47:40 -0700 (PDT)
Message-ID: <cf0447d1-3590-4540-932d-4be299edc432@kernel.dk>
Date: Tue, 22 Jul 2025 06:47:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KASAN: slab-use-after-free Read in
 io_poll_remove_entries
To: syzbot <syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <687bd5fe.a70a0220.693ce.0091.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <687bd5fe.a70a0220.693ce.0091.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index c83fd14dd7ad..58b034e45283 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -782,24 +782,33 @@ void comedi_device_cancel_all(struct comedi_device *dev)
 	}
 }
 
-static int is_device_busy(struct comedi_device *dev)
+static int start_detach(struct comedi_device *dev)
 {
 	struct comedi_subdevice *s;
-	int i;
+	int i, is_busy = 0;
 
 	lockdep_assert_held(&dev->mutex);
+	lockdep_assert_held(&dev->attach_lock);
 	if (!dev->attached)
 		return 0;
 
 	for (i = 0; i < dev->n_subdevices; i++) {
 		s = &dev->subdevices[i];
-		if (s->busy)
-			return 1;
-		if (s->async && comedi_buf_is_mmapped(s))
-			return 1;
+		if (s->busy) {
+			is_busy = 1;
+			break;
+		}
+		if (!s->async)
+			continue;
+		if (comedi_buf_is_mmapped(s) ||
+		    wq_has_sleeper(&s->async->wait_head)) {
+			is_busy = 1;
+			break;
+		}
 	}
-
-	return 0;
+	if (!is_busy)
+		dev->detaching = 1;
+	return is_busy;
 }
 
 /*
@@ -825,8 +834,13 @@ static int do_devconfig_ioctl(struct comedi_device *dev,
 		return -EPERM;
 
 	if (!arg) {
-		if (is_device_busy(dev))
+		/* prevent new polls */
+		down_write(&dev->attach_lock);
+		if (start_detach(dev)) {
+			up_write(&dev->attach_lock);
 			return -EBUSY;
+		}
+		up_write(&dev->attach_lock);
 		if (dev->attached) {
 			struct module *driver_module = dev->driver->module;
 
@@ -2479,7 +2493,7 @@ static __poll_t comedi_poll(struct file *file, poll_table *wait)
 
 	down_read(&dev->attach_lock);
 
-	if (!dev->attached) {
+	if (!dev->attached || dev->detaching) {
 		dev_dbg(dev->class_dev, "no driver attached\n");
 		goto done;
 	}
diff --git a/include/linux/comedi/comedidev.h b/include/linux/comedi/comedidev.h
index 4cb0400ad616..b2bec668785f 100644
--- a/include/linux/comedi/comedidev.h
+++ b/include/linux/comedi/comedidev.h
@@ -545,6 +545,7 @@ struct comedi_device {
 	const char *board_name;
 	const void *board_ptr;
 	unsigned int attached:1;
+	unsigned int detaching:1;
 	unsigned int ioenabled:1;
 	spinlock_t spinlock;	/* generic spin-lock for low-level driver */
 	struct mutex mutex;	/* generic mutex for COMEDI core */

-- 
Jens Axboe


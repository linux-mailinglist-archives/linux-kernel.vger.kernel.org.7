Return-Path: <linux-kernel+bounces-740860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C00F2B0DA19
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE047A8FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DC22E92C7;
	Tue, 22 Jul 2025 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FcsZ6JRK"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E6D2E9739
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188551; cv=none; b=AoetVo80kY6U/8v2ZkXcXUACvnMTCgP+MpGCbDmudVuIlodLXTA/BHGOnLwfuaOCGNiE2WKbpieniQUXOM9FkrimGZw8ANW2d00odYFHEOCyhy9+EBfn+wXG/+ti8JLh7DSWU9CBGj0twfixoSEQXWNwRCEk6931jd1mqItWyUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188551; c=relaxed/simple;
	bh=i3rWBszKUWg+A94N2i24sQMmptEaiIp2e8SaM2JQN70=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=igluS8cU0nKitappIpcBaLdGSQak8Hu1DGmHJ8Lx+r69yHEKc/yGZElAOXRwl7ohzqh4soCtM0PCps08awDyvk15V1+E+ORPBmWhre4X4cugl4sS3lzqSbsuMRsFgYBYY669p2nhaO4OrZ0TUVkwVL4QRguij+g0lmS7z4oenDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FcsZ6JRK; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3de252f75d7so50905375ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753188548; x=1753793348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRS4/BKEFx6fdTxK19mPyu5jRkrdV3afdxrn96aE5qQ=;
        b=FcsZ6JRK2Jtt9EayFy3B3JtgShNTP2RsvDOl61Akf898v1ILXnJKEVcgqg/4Ime9OK
         E58DloKTEe2XgPpp7xqJAttzizz6rNwhtnPUeJQk/j5vigTsXTff5Fr9ulSBrG356mNc
         T7rXl9gq6uwGO77n6s6vEUg562vbSSWEl5bic858Eh8jOodMWzee/V48rZP9wbMZXZK6
         8Vi3AYyX84r0GvKmhGmHPGSF8svumQYc/gF+teXn6uh2121Tsb+Jt3tndLojVjb/wk69
         uAkkudTkwB/SAh7PI2byxBJVeO+0lYLNyBKGE/6lQTpqswygKzymUM7Ed799CtG9jI1M
         x/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753188548; x=1753793348;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TRS4/BKEFx6fdTxK19mPyu5jRkrdV3afdxrn96aE5qQ=;
        b=UkxuWl1vBzbPDs8GKf/DFSPhpFAMb38O5D0dbPMB8czrYKL0JtxZhBvviXZmZbIRiR
         htYd2I/8eSyIw6s8KANy/3UDeXnh3wcRqmc81S2Cwja76jH4wAj6Y+OaZWXuEekZLjN/
         j932gQUMNyq/u///ZqFLHtVUVund+x6fLISLzOfXNKqkchCAjrnuOf2J4kz58IdZ65Il
         CXrfYNGGH34azytn46iPP4nImKTAIfQdH4UYlMNhJs/2JMDK9YWnNDTBDQpe19SI29+j
         PAkN1SrMlr897uMNtR8Y0OWAJl4KdbTrL20ce+x4hycTGQ5BpMsA61IWjIN4aYhP2ni7
         0bfA==
X-Gm-Message-State: AOJu0YysWxfyMK+Ng2bMitlrdl5Xchco9Ww9CW8EQ6KLjxeS3PIwHful
	ncq6GaLpgtws1Vp2c5XDharPkVHBLzUwhiTWvftricUnIL2FTk2uydY2R3QV9WTzPzzpNrIqEvl
	1vfPO
X-Gm-Gg: ASbGncsGpphfxdufijiM+OG8dztiWbZ5nJ0CYaOalSlsN+Pq4qFnoa/DrTzqV9Tf+v4
	Pwm3UrL/c5omhrZbtliCNtqXWf4MwfF0U389ZBr0mRLZcRpIIg7uALZ2L06PYyLXme7fwp+2S7f
	0n8LgshT7IvrTs0NWHktr65/IaM4K+JXCCQ9LcVPTWwEf5WKYiSmhT0OXzzRz2YvUkilugJGDh+
	idbbw4iMVuEEw3dyCKgow0CgFkyFx5El/UjVoM2W4t7B8IEb6pD2WHDF8azax7EsDUZKT1Gob0a
	jgxukyrLa3oaTuJa5ufpGZkm9AJvZUgPpFbsVfBOnIMPDYoWiw0Dx8fjaQmobgztMLVNBcm54am
	L0CLWbqs97ikP1qbMlbo=
X-Google-Smtp-Source: AGHT+IHKbOKYZv5g6z1aIFf9QBFXe4JEf7ltQwHtzGOV+4FldkYmNkNIZFAWeiheLn20vivBduY+6g==
X-Received: by 2002:a05:6e02:2149:b0:3e2:9d91:b3dd with SMTP id e9e14a558f8ab-3e29d91b4e5mr187741375ab.4.1753188548441;
        Tue, 22 Jul 2025 05:49:08 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e2c590147fsm983895ab.0.2025.07.22.05.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 05:49:07 -0700 (PDT)
Message-ID: <de833d76-0176-4514-b102-dc83bf93491f@kernel.dk>
Date: Tue, 22 Jul 2025 06:49:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] comedi: include poll wait state in busy assessment
To: Ian Abbott <abbotti@mev.co.uk>, hsweeten@visionengravers.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

syzbot reports a use-after-free in comedi in the below link, which is
due to comedi gladly removing the allocated async area even though poll
requests are still active on the wait_queue_head inside of it. This can
cause a use-after-free when the poll entries are later triggered or
removed, as the memory for the wait_queue_head has been freed. The
notion of being busy in comedi seems mostly centered around sync
syscalls, where the comedi subdevice stores the file in 'busy' as a
marker. This is obviously broken for things like poll which can be
persistent across syscalls.

Rename is_device_busy() to start_detach(), and move it under the
dev->attach_lock. The latter serializes it with poll attempts. If
start_detach() is successful, then it will have marked the device with
->detaching == 1 and this will prevent further poll attempts.

Similarly, have start_detach() check for active polls on the device, and
return busy for that case.

Cc: stable@vger.kernel.org
Fixes: 8ffdff6a8cfb ("staging: comedi: move out of staging directory")
Link: https://lore.kernel.org/all/687bd5fe.a70a0220.693ce.0091.GAE@google.com/
Reported-by: syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com
Tested-by: syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

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



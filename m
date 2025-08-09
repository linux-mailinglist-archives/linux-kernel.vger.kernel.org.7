Return-Path: <linux-kernel+bounces-761128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB35B1F4BD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 15:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A08626DB0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 13:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45A9262FFF;
	Sat,  9 Aug 2025 13:31:41 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E7C80C1C
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754746301; cv=none; b=cmpHgP2JnOh76pb+6xxIGuPMEYVoby3JkBdF9KCRIBp+YJI2SLRpnu/xXqV9UMl7QzivP8M5KN8O6VZpFo2Jac/htWuOwk1movqdqKKhvR0okYMQF24v/WC2sh5WtpfiOdIuDkkW8AIA1NxXYkFohKI8ilAtaPm4KJ+0ll/TMTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754746301; c=relaxed/simple;
	bh=b0wjEc4LdQVuBOGdPEIYDN8T0MeG+MkW/VIBNokctRA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZaBaBAMLJuOgWcLeJgA03BAN1SQz3Nb9m8Inaw+BnrR4VXMM7LLB87C9A2tTyQO6KTN+A3rUiy2KmhX0M3YIkRvL9/XitHRHnxjppnFa8gnwtcs5ZZLdQGvSghUsubPJ9ZetWP0gdI/olT3r+jcCKTpnPBAJwLofId72D3viQZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e5455df923so300975ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 06:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754746299; x=1755351099;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhzPiXYBCjeP/mjGyO1mhxL4n+0wpF2LMJzb8lNpniE=;
        b=IQxgejgTNYGlqeo/7Ecfi3Z/wQsBknufavSi+4Jr61GmdcuSGBcB1eLkgpGYUL/gcJ
         rFW6GaV/8X7QHvyW7ZYjT+dFAeHrreff8t6onbA0UIKjRW44ktSTaryq681cnyP7Midp
         gCWGVmyacQlbsU071dIZivtAamxqcDML1VhUkZw2jhTGhnfKC3iSxpRFXv/+cLA6sHxF
         76GDhq44A4HFV0ftW1Y7Rn91offYuKPlQz1iMf3F2X2Nx+v2q3A6jqnDjbvBiq2vH7S9
         7+d3hhkh9sadANzDCRfMgnM5hCqW5Tp1yH5ApzupD7RLZr7APRoh7fH6+OQYIQSTDuy8
         Fkjg==
X-Gm-Message-State: AOJu0Yx02EalEqdshb4KFlPFW0n8Clr2mvVPW+bx56MUjqLmGBle+HBD
	ZJXXfUCCOtu2yYu/yUYLv+nudXHGbdlFWxdb6tpEoSCylzI5sFkXNGcBCirOB0PVt7KTO068kWj
	N1io73NTYbqp0nq9hu4pld5TA1sb+tnJ9iqWEsE9Tt7Y7cOj6FzH+xeWTLME=
X-Google-Smtp-Source: AGHT+IHg/Fo3AoOlOfgTCEFwZXe1MkLp/CBGxA1xh+ZdPiSEQqHlowiYh1MODivbnxCCGi6gBy3HfyB7p+K9jEwEN6tA7FK9n9t/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2304:b0:3e5:41a2:d71f with SMTP id
 e9e14a558f8ab-3e541a2d98emr18076155ab.14.1754746298842; Sat, 09 Aug 2025
 06:31:38 -0700 (PDT)
Date: Sat, 09 Aug 2025 06:31:38 -0700
In-Reply-To: <68894443.a00a0220.26d0e1.0014.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68974dba.050a0220.51d73.007c.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [fuse?] WARNING: refcount bug in process_one_work
From: syzbot <syzbot+a638ae70fa7b6a1353b4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [fuse?] WARNING: refcount bug in process_one_work
Author: penguin-kernel@i-love.sakura.ne.jp

#syz test

diff --git a/drivers/md/md.c b/drivers/md/md.c
index ac85ec73a409..2362397b0808 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -646,6 +646,15 @@ static void __mddev_put(struct mddev *mddev)
 	 * Call queue_work inside the spinlock so that flush_workqueue() after
 	 * mddev_find will succeed in waiting for the work to be done.
 	 */
+	{
+		const int ref = refcount_read(&mddev->kobj.kref.refcount);
+
+		pr_warn("%s %s (%px) %d\n", __func__, mddev->kobj.name, &mddev->kobj, ref);
+		if (!ref)
+			BUG();
+		else
+			dump_stack();
+	}
 	queue_work(md_misc_wq, &mddev->del_work);
 }
 
diff --git a/lib/kobject.c b/lib/kobject.c
index abe5f5b856ce..028909882389 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -641,6 +641,13 @@ struct kobject *kobject_get(struct kobject *kobj)
 				"kobject: '%s' (%p): is not initialized, yet kobject_get() is being called.\n",
 			     kobject_name(kobj), kobj);
 		kref_get(&kobj->kref);
+		if (kobj->name && kobj->name[0] == 'm' && kobj->name[1] == 'd' &&
+		    kobj->name[2] >= '0' && kobj->name[2] <= '9') {
+			const int ref = refcount_read(&kobj->kref.refcount);
+
+			pr_warn("%s %s (%px) %d->%d\n", __func__, kobj->name, kobj, ref - 1, ref);
+			dump_stack();
+		}
 	}
 	return kobj;
 }
@@ -652,6 +659,13 @@ struct kobject * __must_check kobject_get_unless_zero(struct kobject *kobj)
 		return NULL;
 	if (!kref_get_unless_zero(&kobj->kref))
 		kobj = NULL;
+	if (kobj && kobj->name && kobj->name[0] == 'm' && kobj->name[1] == 'd' &&
+	    kobj->name[2] >= '0' && kobj->name[2] <= '9') {
+		const int ref = refcount_read(&kobj->kref.refcount);
+
+		pr_warn("%s %s (%px) %d->%d\n", __func__, kobj->name, kobj, ref - 1, ref);
+		dump_stack();
+	}
 	return kobj;
 }
 EXPORT_SYMBOL(kobject_get_unless_zero);
@@ -734,6 +748,13 @@ void kobject_put(struct kobject *kobj)
 			WARN(1, KERN_WARNING
 				"kobject: '%s' (%p): is not initialized, yet kobject_put() is being called.\n",
 			     kobject_name(kobj), kobj);
+		if (kobj->name && kobj->name[0] == 'm' && kobj->name[1] == 'd' &&
+		    kobj->name[2] >= '0' && kobj->name[2] <= '9') {
+			const int ref = refcount_read(&kobj->kref.refcount);
+
+			pr_warn("%s %s (%px) %d->%d\n", __func__, kobj->name, kobj, ref, ref - 1);
+			dump_stack();
+		}
 		kref_put(&kobj->kref, kobject_release);
 	}
 }



Return-Path: <linux-kernel+bounces-726247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE13B00A05
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FF3640DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B33F2F0E22;
	Thu, 10 Jul 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I5MKr1+6"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18551280325
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169138; cv=none; b=OYo7wZ+JXWp+oYPZVuPAHOGV5JOOIZbZ0oaJh8kdGmC9L1/V//H4gthnw/GVbhF/c+cXzUpEtrBfN52ZwG3l6VYJUvERl7Sul2Tmp22pDlSXvnOTUaFPXeRUQiuNMdG/hb3ocREJSWRpoXF1SCOH5wRoCeIOdPbKeV+dYwf2I0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169138; c=relaxed/simple;
	bh=up7NF+qg2LjW7zSeDc2sVY7H3Evwc2L65+Rz3KIir3E=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=kSbfgUIHuCy0/evDP/qPmwnlD21wYNCjoEIJsO08ws/Uz9Fhe2TgeCoyB73HPQiD8VE9DoWUM1TZ9+7/hiioDhqcbnerri7Vm2zkafgzJIMtua28Kkh5zbHERvYHvdNdvShjU7BsA5rB6semerGa1a/e4E0TLi7JDGFUtZkWlUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I5MKr1+6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so1126917f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752169133; x=1752773933; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8olT3jIxXo9GDZvffvU2cJpwCqE12Xm18w/fSCB43I=;
        b=I5MKr1+6QoKSNZu8snwvssA/2lhGKY1JC3lLrkG0+dXr4mjKvEkyXPJKmeu9WPA5zh
         EmZsTMnulEZs1T+Dx9jF4z2SE0bVCSVMmkk9GO+d6SyYq0TbaqEf/tWliYZ7gWnB9D58
         pFd+nXK7V96as1MWJGS9/53O56W9tDrLDlX+8XS/eJZ9akBXm0wguYCUjRHaMLsjZAco
         +siL5oqHxJ1YN1zxqW3H3QjOv4snDxHjVWV3+C8NNw77WTQvh469Mss6vNcqhDCILGb5
         t79czZUmqHUiMkOckAGcGcIaQifDWGRy3ZvxKxiFJsb/rvqvscEz5ZPulepwmZ3gLGAU
         ZHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752169133; x=1752773933;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X8olT3jIxXo9GDZvffvU2cJpwCqE12Xm18w/fSCB43I=;
        b=w8NqGg6+Sq8b/qGBznIWIbHcAkk1TTTHVJ2r319TS5hEZllj3TwzxSeHTDnHimhC4l
         6dZSVedDlVYGjW4cEswVHqk0eCDByvKDgb4SalA1TvTqkyi8G39xmD1uWuHQSR666u8X
         uvvMJYwaZ1BMZnZyP09nTdKLba1vFx0TCtpxWYBsxZeybHKy9g6xBg+HWdlEPVCAmw6/
         KCtq5d2AlidsmG6Xo/YfByy0TtdyrQIwKHzF6DHLOmaQ0gYIdYyyK4vypClZ1z8XsmT1
         l5VXVIc8ALchSos8bb2aFYBERI5jhvSEbIqzkv5RkOSqs6h2HyKIE5f2WwpaxibqkAaH
         y6jQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0nZ1tXwpuWY67a8wYOCyEF9Kf6GzRo4Vc8LdjPVYts3wlx2aShvq4eQG5/L7tOOULwaL9r0aaILs1lGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlulcaQzpvwIOd8x0Brg44KmdPiSNbhDWR8DVmPDDdJkkhr+58
	r3wLmg5kcHXZbVArx1hOLvyIZca4ZObMF4b38tzZp7mxJ9TE0Vor6rhuKFbqNn+oflQ=
X-Gm-Gg: ASbGncugEaD3c/7WNFUF2T93cYZug0e5NUc7RbgjPMdTzoMubzPO5FA9MqYiwhtHinI
	0ESAj+FFzBNYXclTykWRmBLCUsQSnqteTlFrqyCK1nFZZddf0hNtk4w3GA5mb23g5w9/e5TC3QE
	ASvOpVwV6MUsvNmS+DfJoFFYFO/A7ETo18diy/3mphLWyz4jeWCFomop43SeOfmePDVpmObrKbr
	AKTigGuS1q4hjrHtcpTDIm3nhkcTndikVXmkzWXAsqWGGlqrDskm7PRjD4asiaO6rqDJi6pgnrg
	Bwk0rh6h+iWUOQLsP3VYPa8U0DiKkzb3LOhV/Qriy/6jHu+qBIxtE+Fm+yREPbNJqQp+30qPbB3
	wowrqOaa3XhXN0DxJ50QiSv5FHbZVV7AhLAZh282k
X-Google-Smtp-Source: AGHT+IHtjvE5FAA4thxmURUcNTJoyyPTzbj77/L86O60CO4xhxxXBpYFNOuPAHW1QyImtf+mR3ISzA==
X-Received: by 2002:adf:b601:0:b0:3a5:1240:6802 with SMTP id ffacd0b85a97d-3b5f18fbaf2mr308438f8f.57.1752169133101;
        Thu, 10 Jul 2025 10:38:53 -0700 (PDT)
Received: from ?IPV6:2001:a61:1310:c801:2bae:e301:b9d4:9d20? ([2001:a61:1310:c801:2bae:e301:b9d4:9d20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e2710bsm2387780f8f.99.2025.07.10.10.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 10:38:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------NMHI7eV2XxDr6VI3emVtvQ6a"
Message-ID: <4687a61d-e4e7-4a1f-bbf6-59d3decd6fcc@suse.com>
Date: Thu, 10 Jul 2025 19:38:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [usb?] WARNING in usbnet_status_start
To: syzbot <syzbot+3f89ec3d1d0842e95d50@syzkaller.appspotmail.com>,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <686d5a9f.050a0220.1ffab7.0017.GAE@google.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <686d5a9f.050a0220.1ffab7.0017.GAE@google.com>

This is a multi-part message in MIME format.
--------------NMHI7eV2XxDr6VI3emVtvQ6a
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08.07.25 19:51, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d1b07cc0868f arm64: dts: s32g: Add USB device tree informa..
> git tree:https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output:https://syzkaller.appspot.com/x/log.txt?x=1554d582580000
> kernel config:https://syzkaller.appspot.com/x/.config?x=28729dff5d03ad1
> dashboard link:https://syzkaller.appspot.com/bug?extid=3f89ec3d1d0842e95d50
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:https://syzkaller.appspot.com/x/repro.syz?x=11680a8c580000
> C reproducer:https://syzkaller.appspot.com/x/repro.c?x=14c9abd4580000
> 
> Downloadable assets:
> disk image:https://storage.googleapis.com/syzbot-assets/3eab0cb43ae2/disk-d1b07cc0.raw.xz
> vmlinux:https://storage.googleapis.com/syzbot-assets/934d59614ed5/vmlinux-d1b07cc0.xz
> kernel image:https://storage.googleapis.com/syzbot-assets/4b24078bc227/bzImage-d1b07cc0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by:syzbot+3f89ec3d1d0842e95d50@syzkaller.appspotmail.com
> 
> sierra_net 4-1:0.11 wwan0: register 'sierra_net' at usb-dummy_hcd.3-1, Sierra Wireless USB-to-WWAN Modem, 00:00:00:00:01:0b
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 37 at drivers/net/usb/usbnet.c:266 usbnet_status_start+0x189/0x1e0 drivers/net/usb/usbnet.c:266
> Modules linked in:
> CPU: 1 UID: 0 PID: 37 Comm: kworker/1:1 Not tainted 6.16.0-rc4-syzkaller-00311-gd1b07cc0868f #0 PREEMPT(voluntary)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:usbnet_status_start+0x189/0x1e0 drivers/net/usb/usbnet.c:266
> Code: 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 4e 48 8b bb 70 03 00 00 89 ee e8 25 95 0c 00 41 89 c5 e9 36 ff ff ff e8 a8 3f ec fc 90 <0f> 0b 90 45 31 ed e9 39 ff ff ff 4c 89 ff e8 d4 41 49 fd e9 e9 fe
> RSP: 0018:ffffc90000277098 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff888100f80d00 RCX: ffffffff84930727
> RDX: ffff888105693a00 RSI: ffffffff84919188 RDI: ffff888100f80d00
> RBP: 0000000000000cc0 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff888100f81070
> R13: ffffffff89be8f70 R14: ffff88811da1f028 R15: ffff88811da1f024
> FS:  0000000000000000(0000) GS:ffff888269262000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffd6ab63358 CR3: 0000000116716000 CR4: 00000000003506f0
> Call Trace:
>   <TASK>
>   sierra_net_probe drivers/net/usb/sierra_net.c:929 [inline]
>   sierra_net_probe+0x70/0xb0 drivers/net/usb/sierra_net.c:921
>   usb_probe_interface+0x303/0x9c0 drivers/usb/core/driver.c:396
>   call_driver_probe drivers/base/dd.c:579 [inline]
>   really_probe+0x23e/0xa90 drivers/base/dd.c:657
>   __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
>   driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
>   __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
>   bus_for_each_drv+0x156/0x1e0 drivers/base/bus.c:462
>   __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1029
>   bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
>   device_add+0x1148/0x1a70 drivers/base/core.c:3692
>   usb_set_configuration+0x1187/0x1e20 drivers/usb/core/message.c:2210
>   usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:250
>   usb_probe_device+0xef/0x3e0 drivers/usb/core/driver.c:291
>   call_driver_probe drivers/base/dd.c:579 [inline]
>   really_probe+0x23e/0xa90 drivers/base/dd.c:657
>   __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
>   driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
>   __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
>   bus_for_each_drv+0x156/0x1e0 drivers/base/bus.c:462
>   __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1029
>   bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
>   device_add+0x1148/0x1a70 drivers/base/core.c:3692
>   usb_new_device+0xd07/0x1a20 drivers/usb/core/hub.c:2694
>   hub_port_connect drivers/usb/core/hub.c:5566 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
>   port_event drivers/usb/core/hub.c:5866 [inline]
>   hub_event+0x2f85/0x5030 drivers/usb/core/hub.c:5948
>   process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
>   process_scheduled_works kernel/workqueue.c:3321 [inline]
>   worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
>   kthread+0x3c2/0x780 kernel/kthread.c:464
>   ret_from_fork+0x5b3/0x6c0 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> Seehttps://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached atsyzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git d1b07cc0868f


--------------NMHI7eV2XxDr6VI3emVtvQ6a
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-usb-net-sierra-check-for-no-status-endpoint.patch"
Content-Disposition: attachment;
 filename="0001-usb-net-sierra-check-for-no-status-endpoint.patch"
Content-Transfer-Encoding: base64

RnJvbSBhYWQxNzY1ZmM2ZDRkODAzNmZjNWE5OTc4ZjE5MzE0N2IxODAwNGRkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29t
PgpEYXRlOiBUaHUsIDEwIEp1bCAyMDI1IDE5OjMwOjM1ICswMjAwClN1YmplY3Q6IFtQQVRD
SF0gdXNiOiBuZXQ6IHNpZXJyYTogY2hlY2sgZm9yIG5vIHN0YXR1cyBlbmRwb2ludAoKVGhl
IGRyaXZlciBjaGVja3MgZm9yIGhhdmluZyB0aHJlZSBlbmRwb2ludHMgYW5kCmhhdmluZyBi
dWxrIGluIGFuZCBvdXQgZW5kcG9pbnRzLCBidXQgbm90IHRoYXQKdGhlIHRoaXJkIGVuZHBv
aW50IGlzIGludGVycnVwdCBpbnB1dC4KUmVjdGlmeSB0aGUgb21pc3Npb24uCgpTaWduZWQt
b2ZmLWJ5OiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgotLS0KIGRyaXZlcnMv
bmV0L3VzYi9zaWVycmFfbmV0LmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC91c2Ivc2llcnJhX25ldC5jIGIv
ZHJpdmVycy9uZXQvdXNiL3NpZXJyYV9uZXQuYwppbmRleCBjMzBjYTQxNWQxZDMuLjM2Yzcz
ZGI0NGY3NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvdXNiL3NpZXJyYV9uZXQuYworKysg
Yi9kcml2ZXJzL25ldC91c2Ivc2llcnJhX25ldC5jCkBAIC02ODksNiArNjg5LDEwIEBAIHN0
YXRpYyBpbnQgc2llcnJhX25ldF9iaW5kKHN0cnVjdCB1c2JuZXQgKmRldiwgc3RydWN0IHVz
Yl9pbnRlcmZhY2UgKmludGYpCiAJCQlzdGF0dXMpOwogCQlyZXR1cm4gLUVOT0RFVjsKIAl9
CisJaWYgKCFkZXYtPnN0YXR1cykgeworCQlkZXZfZXJyKCZkZXYtPnVkZXYtPmRldiwgIk5v
IHN0YXR1cyBlbmRwb2ludCBmb3VuZCIpOworCQlyZXR1cm4gLUVOT0RFVjsKKwl9CiAJLyog
SW5pdGlhbGl6ZSBzaWVycmEgcHJpdmF0ZSBkYXRhICovCiAJcHJpdiA9IGt6YWxsb2Moc2l6
ZW9mICpwcml2LCBHRlBfS0VSTkVMKTsKIAlpZiAoIXByaXYpCi0tIAoyLjUwLjAKCg==

--------------NMHI7eV2XxDr6VI3emVtvQ6a--


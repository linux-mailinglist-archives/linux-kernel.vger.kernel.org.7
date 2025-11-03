Return-Path: <linux-kernel+bounces-883269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DB3C2CE59
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46DAC189E3E2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F193831691F;
	Mon,  3 Nov 2025 15:39:39 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114001F3B85
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184379; cv=none; b=ry4Yj0nOdqt02gTYq+ekqhFlVHNTcQ6spc8/OoBdto4ck/nb6xm6bqdpyeEh7Uukxjw4M5A3+O1zQTrwyHGaDugKnb7esS1OQ41UuEDkv3VNEQJQ3NuYnJpolhvVh3dX9rJ3KMaMpR+WyyXYxy6D7klPZ3o7VGhilaySagUk9qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184379; c=relaxed/simple;
	bh=MZIUTDUlLfJirMX9evaXHDyNYsjcHZ9WEC/P7k9Odow=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s8J9NjGWFFN94u8WhP7zEp9st7m/vxLumCrvFVyDKQnCzHnfwQR36Z5wIOeM4PMKRGMnf7PrV6tfat3CuSemVsWEdN4a1RXJ/cg1Zx/uaAGr/CXjqZGSAL5CklRM+rsqKXD0tbtCzIBFr1uZ/8e6UOrIHpiaN7JjD7u8WoBUTQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4333052501cso8533905ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762184377; x=1762789177;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZIUTDUlLfJirMX9evaXHDyNYsjcHZ9WEC/P7k9Odow=;
        b=DHKKogqO8LWosACMIaNAVdRjL+Ukbt9VykRCws7VGuofA47lYJTJZKVaKNbqbv6naC
         bl7GWkqieffFyj79Q9NA9HYPr8Y57udUxp9wjFStUsj3OzEavZdXku0Vupg3o9nRi5Sa
         A5g9IbVBhsRQO9eatGCQCNgYOJE7jnl5nT4qHdb8WoZz+qMHlUSaJlK91rwr5FFZNs2B
         RqBSUL3QCmW0Y6pIwJy/uxKHkoZRL53cGKIgO5neO2gwCGLqmbFy6TOh5RNZG+MHu9es
         hLVqiDXbrcv0aGpI2OLRD+v+TrsvbyW4Eaxfh78mkd4hoo7NiM04gAcT5znnfkQ3/bk+
         imGw==
X-Gm-Message-State: AOJu0YyxdFH+3GWk+UA5mZ9MIL7uGOpfWZiCHGwSZAp4yNvh0YF2It/S
	72uHHl/O9JMEzpSimx49AIeymwIm3fRyvxlYuiVPZra6UEr9qK2sB8aBsDF+MUwn/75EYLPRrvI
	cUTxUPvLRhG9y13ylzXAOxjUyZ92M6VN9/0tPz7BLJTD9tTZmzt9tWI5GC/k=
X-Google-Smtp-Source: AGHT+IFdXfPoWZ9GITDdj5VrY2k7uds2/JFE72UcPCE4pvYHHVFSwd6rkE10oRoIJMIj7K+QFE7v4o4gk9fHKzi+6+59957AuqXT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3707:b0:432:f3b:a809 with SMTP id
 e9e14a558f8ab-4330d222070mr180738655ab.26.1762184376925; Mon, 03 Nov 2025
 07:39:36 -0800 (PST)
Date: Mon, 03 Nov 2025 07:39:36 -0800
In-Reply-To: <68dadf0e.050a0220.1696c6.001d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6908ccb8.a70a0220.88fb8.0000.GAE@google.com>
Subject: Forwarded: WARNING in f2fs_delete_entry (2)
From: syzbot <syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in f2fs_delete_entry (2)
Author: zlatistiv@gmail.com

#syz test


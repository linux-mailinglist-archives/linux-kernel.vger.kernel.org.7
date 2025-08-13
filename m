Return-Path: <linux-kernel+bounces-767034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB37B24E34
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37E82A47CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBB127F171;
	Wed, 13 Aug 2025 15:43:37 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F0A27AC57
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099817; cv=none; b=qw61PwqNr1unSyQolTzxwQ1YkBGBP9A/58pgelNPx0fyKV8CVZEHLGDcDttefkhnYp09GGJe94c78gG93imoln+fBswVMrytxhAPp2Do7lnrdRB1oEDa9fmEQBjnf9PkZ/woFkudSK0AyBANElX1TeN8G3RSVfiWLVVtNJl98hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099817; c=relaxed/simple;
	bh=EZqnd4QbylAM7e7aG7dM5lKczJ/kfENBtLDkC/RXE2o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eL09JnnE6/DBManCEEQnI5sHnGoAKTbiqPInwILuR2Lr6Z19sLldP1q+9+P7bZuFFYqkqadh1KUtkPl/rmrDscWrpSX61qttAWn7Vly88zAS0btZaPyX2lRv+xSolu8JyAW/KDj+KXADO7jpqUYj4oAwyJN20YiwbvhvjcyGVNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88177d99950so646879739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099814; x=1755704614;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5elhorgIFMNLHmDqTJfQO7TzeV1TdRqPz9zCjpje9U=;
        b=sFwzKWszHckjFWhLS+65NzZZATwe4z7cRhwkdBmgImvDFvAXKJU7vb1sjSYdwqjCC9
         noBFcd+8e3kSESuMWETJsy1PyY49gN9W7XHq27iQJw6rKfD+iNg60sEddxzV5GnHedPN
         jNpABfP3WKl82x1CFdFQFBtH9yysY8GDVLEyzy8kBwbvnuwjGn78k8WLcQuo+hL9+S88
         dq0rbgTrWS9u4/p/CXwN7z3iIERfC74IHpG1lm45iSox37qB+GRZiS0iuIWIJYQZUyeI
         pKTXma6ZdLH0opEBQLJ3sCcQUo2P6dwXZmzasteF1vAxmZLmdsqw1iKzHv9mGnnnL967
         wxQw==
X-Gm-Message-State: AOJu0YxGnn4Aesb0XTQjR8gsF4Q4NVspf2TT68JENkok7yq2sz0dzhHq
	/RruPpP8Vz8mLzjO5ELTDUDW86fFIgcgB9o4N++lZ97Ri6cgtHBqDPQQkoTcXHMo46gujwF2X7I
	3NHQfYufkbMrabp69oAnNQtUrlvb7ODDWAfhk+X2fXLY+qwJan9oxD4Xwxps=
X-Google-Smtp-Source: AGHT+IGo5BB5FUqKPzCWaEgFfeaghkL5ATyJwTRacm+/s0J3m83F1O3T2M7b8fq8Og65OXgYqpprRG68XdAnh0mf4OnNxPQWulLh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13c6:b0:87c:30c6:a7cf with SMTP id
 ca18e2360f4ac-8842950b465mr613753239f.0.1755099814067; Wed, 13 Aug 2025
 08:43:34 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:43:34 -0700
In-Reply-To: <689a3d92.050a0220.7f033.00ff.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689cb2a6.050a0220.51d73.00bd.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [kvm?] [net?] [virt?] WARNING in virtio_transport_send_pkt_info
From: syzbot <syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [kvm?] [net?] [virt?] WARNING in virtio_transport_send_pkt_info
Author: mst@redhat.com


#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


diff --git a/net/core/datagram.c b/net/core/datagram.c
index 94cc4705e91d..ab890448f3a2 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -642,6 +642,7 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 			return -EFAULT;
 
 		length -= copied;
+		iov_iter_advance(from, copied);
 
 		skb->data_len += copied;
 		skb->len += copied;



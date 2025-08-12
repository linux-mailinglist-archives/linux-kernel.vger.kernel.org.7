Return-Path: <linux-kernel+bounces-764336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BC2B221AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC9A5802F0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA072E62CB;
	Tue, 12 Aug 2025 08:39:16 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F60E2E62B5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987956; cv=none; b=A2FrLqafye4dCIhgjUqG7kES297pM0iamktPPj5Qja5P4pqcT+cX8w75T3H/xVPWldmkyUfDccybHdU9XMEjzgwS4ea1q9uYB7F5WJCKEeaMp5XmMQgcepJ3NSlPfu3vG6/DE8Q+yPMVnSv6Svxlrvo3HNor3W6HJvGOWdFhMUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987956; c=relaxed/simple;
	bh=t1P8O1ZE6m0J9fUQzC0rTyT5UMdRYeQNWCxsVEPCcy4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Sgmr8PQgxxBQhXLu7vQ1vHZR9YmhyNc6E/Jt+bYHt5iTPcJCeGKlCycZ1+9Md+KwEnpOYXSefpzZU16RNTUSoeQY6xsg6zsIA27+2IWPx4kwOquJ//cOUxMMjirXTbrwsCX5/yBOgrvlyvrjMDVGiHtJdjgla/GStfWTcYwishk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-884030b4235so506818839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987953; x=1755592753;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4IBL66k/8KHurOIDyb2X7HCwsLAWc5cSdmDfE598q/c=;
        b=FNW6hFtHobY5maewnXnZtY15P5WUWkTP5FzZ19zN6fdv8lF7QzPDPpMDN4u0S1B+AS
         gQxoywUm2INs+PxJt5Kjtb53/ffKss2sWWFyckHyaCLF0SiY+cxQHPxLTUXh/wrFcnn5
         PR54su/fGU7x8wFBdei450xbQekgh/lYxqokBu2xQohmHrOV5ShmaRs+idTDgiWrbVzN
         HJYUYTaQPg4k9PZa6nbD7wVk+8Q8x4YRJjAQ2xVM9uUcNh99JUyr3VAlGNyjMBzYK4VD
         +NKf1/FPUx9jSNp5ljYlilyGgiD/4rKPP/fUuKiYA77SgJN+6oHVT39fRT47ROVVOgt+
         tvMw==
X-Gm-Message-State: AOJu0YzShHFH6Tern2/IM9npm9GuwHntc7K7FRauhb/wm7d3pYHY/UmA
	Hz5TJyTGU14FkxQxwPwzdYQEjJ3fMYvfw04nuFD7h+MszvvAlXDOgXusvxKg0akAW4bMcl7GMqq
	kR24irQETkOX1GCVLGT9vUU1VkaxqLItoyg1KB7HQWs9A6Up04DomeoxkERM=
X-Google-Smtp-Source: AGHT+IEX7+88Id4mxk31XEjvX9Uds6pbIL1ZEJk6+3aCKZvI08fvO7pFgvecCz19haPqeZS1JrRm62bZFoa0nAw9OyURCryV2EXm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d0f:b0:873:f23:ff5 with SMTP id
 ca18e2360f4ac-8841bf1c9f8mr535824939f.12.1754987953668; Tue, 12 Aug 2025
 01:39:13 -0700 (PDT)
Date: Tue, 12 Aug 2025 01:39:13 -0700
In-Reply-To: <689a3d92.050a0220.7f033.00ff.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689afdb1.050a0220.7f033.0114.GAE@google.com>
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

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f9193f952f49..a8c90676d715 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1149,10 +1149,15 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 {
 	unsigned int n, gup_flags = 0;
 
+	pr_err("DEBUG: __iov_iter_get_pages_alloc: initial maxsize=%zu, i->count=%zu\n",
+	       maxsize, i->count);
+
 	if (maxsize > i->count)
 		maxsize = i->count;
-	if (!maxsize)
+	if (!maxsize) {
+		pr_err("DEBUG: __iov_iter_get_pages_alloc: returning 0 - no maxsize\n");
 		return 0;
+	}
 	if (maxsize > MAX_RW_COUNT)
 		maxsize = MAX_RW_COUNT;
 
@@ -1166,15 +1171,31 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 			gup_flags |= FOLL_NOFAULT;
 
 		addr = first_iovec_segment(i, &maxsize);
+		pr_err("DEBUG: first_iovec_segment returned addr=%lx, maxsize_after=%zu\n",
+		       addr, maxsize);
+
 		*start = addr % PAGE_SIZE;
 		addr &= PAGE_MASK;
 		n = want_pages_array(pages, maxsize, *start, maxpages);
+
+		pr_err("DEBUG: want_pages_array returned n=%u, addr=%lx, start=%zu\n",
+		       n, addr, *start);
+
 		if (!n)
 			return -ENOMEM;
+
 		res = get_user_pages_fast(addr, n, gup_flags, *pages);
+
+		pr_err("DEBUG: get_user_pages_fast returned res=%d (requested n=%u)\n",
+		       res, n);
+
 		if (unlikely(res <= 0))
 			return res;
+
 		maxsize = min_t(size_t, maxsize, res * PAGE_SIZE - *start);
+
+		pr_err("DEBUG: final maxsize=%zu, advancing iterator\n", maxsize);
+
 		iov_iter_advance(i, maxsize);
 		return maxsize;
 	}
@@ -1213,11 +1234,21 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 		size_t maxsize, unsigned maxpages, size_t *start)
 {
+	ssize_t result;
+
+	pr_err("DEBUG: iov_iter_get_pages2: maxsize=%zu, maxpages=%u, iter_count=%zu, iter_type=%u\n",
+	       maxsize, maxpages, iov_iter_count(i), i->iter_type);
+
 	if (!maxpages)
 		return 0;
 	BUG_ON(!pages);
 
-	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start);
+	result = __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start);
+
+	pr_err("DEBUG: iov_iter_get_pages2: returning result=%zd, start=%zu, iter_count_after=%zu\n",
+	       result, start ? *start : 0, iov_iter_count(i));
+
+	return result;
 }
 EXPORT_SYMBOL(iov_iter_get_pages2);
 
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 94cc4705e91d..135dc37bd746 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -623,6 +623,21 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 {
 	int frag = skb_shinfo(skb)->nr_frags;
 
+	pr_err("DEBUG: zerocopy_fill_skb_from_iter: initial length=%zu, iov_iter_count=%zu, iter_type=%u\n",
+	       length, iov_iter_count(from), from->iter_type);
+
+	if (from->iter_type == ITER_IOVEC) {
+		pr_err("DEBUG: IOVEC iterator: nr_segs=%lu, iov_offset=%zu\n",
+		       from->nr_segs, from->iov_offset);
+		if (from->__iov && from->nr_segs > 0) {
+			pr_err("DEBUG: Current iovec[0]: base=%px, len=%zu\n",
+			       from->__iov[0].iov_base, from->__iov[0].iov_len);
+			if (from->nr_segs > 1)
+				pr_err("DEBUG: Next iovec[1]: base=%px, len=%zu\n",
+				       from->__iov[1].iov_base, from->__iov[1].iov_len);
+		}
+	}
+
 	if (!skb_frags_readable(skb))
 		return -EFAULT;
 
@@ -633,16 +648,32 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 		size_t start;
 		ssize_t copied;
 
+		pr_err("DEBUG: zerocopy loop: length=%zu, iov_iter_count=%zu, frag=%d\n",
+		       length, iov_iter_count(from), frag);
+
 		if (frag == MAX_SKB_FRAGS)
 			return -EMSGSIZE;
 
 		copied = iov_iter_get_pages2(from, pages, length,
-					    MAX_SKB_FRAGS - frag, &start);
+					     MAX_SKB_FRAGS - frag, &start);
+
+		pr_err("DEBUG: iov_iter_get_pages2 returned copied=%zd, start=%zu\n",
+		       copied, start);
+		pr_err("DEBUG: iterator state after get_pages2: iov_iter_count=%zu\n",
+		       iov_iter_count(from));
+
 		if (copied < 0)
 			return -EFAULT;
 
+		if (copied == 0 && iov_iter_count(from) > 0)
+			pr_err("BUG: iov_iter_get_pages2 returned 0 but iterator claims %zu bytes remaining (requested %zu bytes)\n",
+			       iov_iter_count(from), length);
+
 		length -= copied;
 
+		pr_err("DEBUG: after processing: length=%zu, iov_iter_count=%zu, copied=%zd\n",
+		       length, iov_iter_count(from), copied);
+
 		skb->data_len += copied;
 		skb->len += copied;
 		skb->truesize += PAGE_ALIGN(copied + start);
@@ -686,6 +717,12 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 		if (refs)
 			page_ref_sub(last_head, refs);
 	}
+
+	pr_err("DEBUG: zerocopy_fill_skb_from_iter: loop exit - length=%zu, iov_iter_count=%zu\n",
+	       length, iov_iter_count(from));
+	pr_err("DEBUG: zerocopy_fill_skb_from_iter: final skb->len=%u, skb->data_len=%u\n",
+	       skb->len, skb->data_len);
+
 	return 0;
 }
 
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index fe92e5fa95b4..25300125b789 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -288,7 +288,14 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 	if (info->msg && payload_len > 0) {
 		int err;
 
+		pr_err("DEBUG: virtio_transport_alloc_skb: calling fill_skb with payload_len=%zu, zcopy=%d\n",
+		       payload_len, zcopy);
+
 		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy);
+
+		pr_err("DEBUG: virtio_transport_fill_skb returned err=%d, skb->len=%u\n",
+		       err, skb->len);
+
 		if (err)
 			goto out;
 



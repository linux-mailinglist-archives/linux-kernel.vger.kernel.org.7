Return-Path: <linux-kernel+bounces-767168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA2EB24FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06465A4AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01836288C32;
	Wed, 13 Aug 2025 16:31:28 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEC2281368
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102687; cv=none; b=Lg7/N9UaVITbFUEA9rYm4RRcZHXime1PmxU+KVB4hnhjgXxzpHN1TecULQ273c1HB6NV1h3CWuUBfgr5iD/6nbalOD0AUobpAAsM9C/6UeFNi1K9C0vBk/kYoLoStzZw6rQCRVstPpXSVhsL8+8pPGINmgotBg7bauFHgj0PmSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102687; c=relaxed/simple;
	bh=WfHSUQEY3ZJrnUPJmAiL0Ymo8VhyVozArfR/PvCIpA0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ErjPbBnQFHQN2AQqGf2ZvbJmVXK8nJnK2zXTx/Yneun3lA/Wfr011012lzUjRdOCHcd9HLeaOb3NLT/ZXJ5TxRFnfOSOO5p+C3+eZc5iXTy6NUbYrt/Ywe19keyJeVbLkVTPCMB4o4UlNQjintvoIWT0e93eNfvtZqIUXQFpBLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88432e64477so1554339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755102685; x=1755707485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3v2PBlw8KMNjlaA5Jr0Slsgw7HOK1MZVmucbZxBQSY=;
        b=A1Sedy2z27hJYxBJ9TMxXACbBQCx8pz7mUDV0J8mipPd5z2jRlc5pDnY96Pfkuyxef
         vCH+RJLG3CHUgpwBOJs1dCGK2oMlx02RYa9v6e88h5ifamk+agGX5vjJBTcHBp+r+QP7
         jf8GXwn14taJJXbQQHHOLu5CssJX5ZmLkdtCZXUHho+HSaxiWPp1zhlnyQLdZSIEpvGA
         4qNnehfslzWKN+wFlMhI2PNAku1kaFDGyriKk4m+WSZm2jZN2AMvGCaAn5dB9OIU5fsB
         LnboK9q64q8yOrJIdPV8wFyCdJ7eRPg68tqeN8YkWHtPy4rLWTZpfM+OchgqdTs3NJac
         Bc9A==
X-Gm-Message-State: AOJu0YxQM31unUZ0JNmNVObQrqd6u/+DRcoPJqsj1SuJmu/oCvE80nQT
	7RZQi16xq7TJruFwf5aqSSvawnsuVGi/RpvtZWpTwldHAA2pa8tsGXXrxso0F5JLQsRRKgUa4nA
	6Xz3pb+C2OIbNUKE4hlcPfdEA9PYTTZbN5cUwjvaH5N8GF+33HkAdNsH9H04=
X-Google-Smtp-Source: AGHT+IEUYCz+//JqQ3XHe16BxK77aWOwwCT1SRTItHt+P9jmDk1uZza+1vSdXNDJW+lGCbqgnO9ACgn43tTEEI09LbnQdXQoDx8s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cc4:b0:884:1d69:f1a9 with SMTP id
 ca18e2360f4ac-8842963a7abmr720433739f.4.1755102685260; Wed, 13 Aug 2025
 09:31:25 -0700 (PDT)
Date: Wed, 13 Aug 2025 09:31:25 -0700
In-Reply-To: <689a3d92.050a0220.7f033.00ff.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689cbddd.050a0220.7f033.0153.GAE@google.com>
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
index 94cc4705e91d..3b5695ad3714 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -686,6 +686,11 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 		if (refs)
 			page_ref_sub(last_head, refs);
 	}
+
+	/* Fail if we couldn't get all requested data, like linear copy does */
+	if (length > 0)
+		return -EFAULT;
+
 	return 0;
 }
 



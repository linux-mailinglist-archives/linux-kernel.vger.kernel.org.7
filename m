Return-Path: <linux-kernel+bounces-764486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D13B223A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0749D7B2F89
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2002EA177;
	Tue, 12 Aug 2025 09:48:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E345C2EA162
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992088; cv=none; b=W9TXEf7gEahKrjbFBRJkLaUYhCR7MylhaWlxr1eZzPcDmmQF31xEDKPb2uIS2371QG61meO9QiIxevfZFp/33uzqv6FthPd9oYxP6gY4UT8ra7AywbtAP0Tx2b/NLm0UjhAmC1KNrrCbne+CAKPi4vXD+QBTNWfOU5/0/JDvDL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992088; c=relaxed/simple;
	bh=tgMF8HuU+iL/6Y55dy6ba5v8RvxSKr6oTJYUTWCzqHs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kIz5OBWoIEyR7ABhy4MRM855flKGMRvdFoUGEW0z0rGdvD3qkvJvJiAQ8v+63dBNKbXsj+pWpwls49O/dBn0Q+fKHleFfQBoRO72mr/momOUBHDyTsrKOY7FZSWOU2kDT4g7Eu3t/ukh8XVNi3rgbwP/RA0qU6rZGrRatv61CLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8819fa2d87fso485915539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992086; x=1755596886;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23s4cMMxaWk/6h2mIsslFjC/yj0rjYz/dHBx5jBiKdk=;
        b=otDtS7aooMlTPy5Peb2QFrbwzy9VgN9fWm2hZDMpP77gEgnKo0pMJXGSDuAAVG74v9
         FEGQgMgbQrl2s7gTMiayUpkq0OyCcxGl24IPX4IaEcNQv6sTSLPCLZMZF7zqzPIN4TQc
         E5jy00hZNRkpERpznzKksfbBPqbj1dkBvmFziMoMbtdnJXs8lvggc/f8FeJ0Da1X8jim
         rBcycNy4djKyswjfbZJHke0au46IxzcVK/459D2NJksa8udnao813ndKXdFhC4+vyW/E
         pL5t4KxqauFojFe3QMeUu8IKFE0pSn1Fss9B/zkaytUeQdpQispn8hLqgF41cGRffhje
         9reQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKCpurvQ49+gk6MKkNKWpok6Hs0HR72SEqjzE0MNj70ujlX4Us1OAJmtK3oDBtXG+nN/+O/BDfe8ITMIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVPUUzWtuvQd4Fft874F2L8h3vjAP37wGTjRB43hGvTAKka0Oq
	0TxVHy20YnuEZqBWJcvPhIJ4RnKyySyB5trxbMjIgFYLgKQPEMn+B7moQ4sKSMx1SH6+gule1+M
	XcQ/K2xCpsJcbLU4bFXyCSRxifocYBqYTagBRWBFy3bVJ4s1ec6MkdYSZkKc=
X-Google-Smtp-Source: AGHT+IG3SLQLj7KxZZEj1GNTliTbrGRu9ikWa+/cuwM6xZfm+k+wklil9CcAWSa+9Q7XgA8ywVi7c7dtP5+lK+hEKORoB3z1DYwc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1546:b0:881:8979:93f4 with SMTP id
 ca18e2360f4ac-883f127fca5mr3181687939f.14.1754992085862; Tue, 12 Aug 2025
 02:48:05 -0700 (PDT)
Date: Tue, 12 Aug 2025 02:48:05 -0700
In-Reply-To: <20250812052537-mutt-send-email-mst@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689b0dd5.050a0220.7f033.0119.GAE@google.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] WARNING in virtio_transport_send_pkt_info
From: syzbot <syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com
Tested-by: syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com

Tested on:

commit:         8ca76151 vsock/virtio: Rename virtio_vsock_skb_rx_put()
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15d54af0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84141250092a114f
dashboard link: https://syzkaller.appspot.com/bug?extid=b4d960daf7a3c7c2b7b1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-588846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E70DBA7BE4F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 15:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98B2189952F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 13:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450EF1F1908;
	Fri,  4 Apr 2025 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGrKodK4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1361F1EE7B1
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743774660; cv=none; b=jGkURJ1p/FOGR22fibQd87dk5ouPaMHCo/AhezZCJeKkh9W6WmpWng45ernW8quKbE3RjKWgyujQ06LvwOCzvEiHXVNjtigPzqyD+TqVvu0jZqWDKNmzCLfWH8gJUAYs+GmQjeeCfvLDE+GtcEyIJsgRqejbclSOHbzD7YVwvuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743774660; c=relaxed/simple;
	bh=g4HKRVR5iNuUKt6XxJzLJNqwyq84woqy+JBuYDM4a+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCRFNlctvvqmG7wZP0AfLUbxlOLFjYq6q24fVP5fO8JcLMOc5hpqehx+i2mugxxLrnxiK+wf0z0rI34SEW1e+s2/DSjQayOMyth5WY4TwVvqwJ5tYyibiwqF+mCk7d/lvpfPW0odMk1otdjGJpBnBZXXPmRZFDHsWfVOnaz0A10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGrKodK4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743774657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v10Rq+qm+0lVG+/ZpXOjHbbBOxXi0wHFQ9TLKO+kuNU=;
	b=iGrKodK4dLuYIPPrsdcwxzV5V+t7lkLKDKWXDlq5CndIpSWAV+o7q1rT1n2V2ObWkXidpa
	bXlj1JPr6Mzl4kmKb3ONNWuzCjfnKMIj4CvtyfAtlEXPwn6iGDr8LjJNZX/xAs1ygGE2UV
	twqCkZSylUaFykyRfZJB10FMq1OtLu4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-tjhwzyzOMsmGNMNs1LaaYg-1; Fri,
 04 Apr 2025 09:50:56 -0400
X-MC-Unique: tjhwzyzOMsmGNMNs1LaaYg-1
X-Mimecast-MFC-AGG-ID: tjhwzyzOMsmGNMNs1LaaYg_1743774655
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4891D19560BC;
	Fri,  4 Apr 2025 13:50:55 +0000 (UTC)
Received: from fedora (unknown [10.72.120.26])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 157C419560AD;
	Fri,  4 Apr 2025 13:50:50 +0000 (UTC)
Date: Fri, 4 Apr 2025 21:50:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: syzbot <syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] possible deadlock in
 blk_mq_freeze_queue_nomemsave
Message-ID: <Z-_jtFYt0t0-6A7z@fedora>
References: <67ea99e0.050a0220.3c3d88.0042.GAE@google.com>
 <67ee4810.050a0220.9040b.016e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ee4810.050a0220.9040b.016e.GAE@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Apr 03, 2025 at 01:34:24AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    a1b5bd45d4ee Merge tag 'usb-6.15-rc1' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1711cfb0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=adffebefc9feb9d6
> dashboard link: https://syzkaller.appspot.com/bug?extid=9dd7dbb1a4b915dee638
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ee494c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13df5998580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-a1b5bd45.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/588b4d489b63/vmlinux-a1b5bd45.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/51ead797f7ae/bzImage-a1b5bd45.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com

...

> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test: https://github.com/ming1/linux.git syzbot-test


Thanks,
Ming



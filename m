Return-Path: <linux-kernel+bounces-720330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DF2AFBA5F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC6F1AA6613
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169402641D8;
	Mon,  7 Jul 2025 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="I4Hq4Rht"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AD11B4F09
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911770; cv=none; b=LFGu7y1MRmFGhIF6ODSpfW9uJzmYGnC2BA++JOqAURCRJxRCOkkJLtv7/0qn8+5Ghc9UJ9eB7uJAlE2aKJqh6f++2ud2pCMqBbZSxY8hOevn/dKLD1cjy8YIRRbrV3CdDb57Q+0SH7jE+p0b4JgbIRFK2DE7S1oN/2a/awjCwNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911770; c=relaxed/simple;
	bh=iI4TQiK5VbfL867pNGYed/ZYRYzgsTePoMjAGqHMscE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZczj5UPDVqk39e2JXhRavM5hqZHniO4oed4GIfCp3TquH1YRs3ZRBAQybx+QxC+Gyi2cv1AoJvxFrt+mUBuUALBlgsierF2QcIROQt6Tm5v8ilKfFD4K9xnalvkM/09N5Bz4oyTBBMU9CJ8MvReUYTYqJGhmt3ZdJB1L0bmcPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=I4Hq4Rht; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a5903bceffso51804741cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 11:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1751911767; x=1752516567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gExEEsqThCnmMqopEOTA98hdy6W5nAjnndkUOEja3dM=;
        b=I4Hq4RhtRb9Mm2+AnDiZDG1/lizsrn2YY2lehwQIKhb0cO+/pAZXWl7e9KAQOdbWJj
         ylJXzZAgphOlfUIAQfrSvWcVUueK7f1QdsTi+yd/VqNeVABbuvYT7Ojho32Xlk9QOctE
         WJ9gIFNRfHX/zmFd61RIC+cIfXb9Gb3L/zznaURX4k7iJ6/LXPGzNPAOYY6Ws9xIc0ah
         AC/52yP42RMQHV7WoyNHXn0I/lVj4Asdh0F3lVEngytqd2NaYluoyG84ASDeL2nUOkAj
         Jqm/LzqwTHaT0O08ylKaOXHmHsKJMnTKE9llprLCCvAU9KKDO9MlVSHaw0S7X3IZA+tO
         l9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751911767; x=1752516567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gExEEsqThCnmMqopEOTA98hdy6W5nAjnndkUOEja3dM=;
        b=aiDcFXRyRwRnTlcx3pJlBzoAI6fwbppeGF+6+4/s1ZosU5Yym7OJHrXypPmiMPkBpd
         QEGwFuIH9Kjp7grTIFzGe2IyJOukOWEfpySfiBr+IQoi246Dp7DrUM8m4aVyCGpQQYQU
         hYzfk1AHj1m65cLKmfT13NIr3hOS9gMcexzRUHX0dkfiYra3rWB/cKqJ5wVwfIcycmUD
         EBYR3A44ci+7XYCOsu8D+8nqGc/WdsMeFgS49QnlFAvdPKERBq4tATC/D/ztpfUidBJR
         s7douKdN4jlAwg0E2L8G8biUNUw0DMxexmQOeDxHcb4Ik/Nc3jCJEAl59+mzy91MaZ6Y
         dNjw==
X-Forwarded-Encrypted: i=1; AJvYcCXUcRuw3LkNbVinlLtDEf3LtR922e3wHjutabGHKGEc6FmVPJ2ddUaIU3ffBMnauQbSYwsFS1hBUd1MIMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ZLcBIHZdFvP/6eC5kzJwh5DzZo3q3WTW1iTDetevfusXa2XG
	JtbyAWNL05+BKxsJKMxAyBJ2bMxgr4EPfNcQrzz8xeOXBtAUUt8ShGUK00/OKJBqVw==
X-Gm-Gg: ASbGnctxFZSS3xSw1G0aJdhqVui7RDsEzmzvzG5mY+fPB8Jyepp6DXo/zPPGmvi0KnX
	f7kBqSKEPgg7CLgLVG0KFjMX/2Fe0W/4560qoTKOkEFHZntbR+BklZWJw/P1JDrrC2oQGnKcrPG
	UNPz7EnCtbLp6oifsko+DWMkogaLBCJVA/LIhm8/a0a2dvYArI0kGOsjRWiYFp8tr4BJ6Jul+UO
	JiGqPL86cxE40BO8A3hq1WyObrp4H2wT4lfwas+6y5S86aDVoQCftUdOtC+gLj/ABpmiUvAyJhh
	gvgG4nfT9fq8KyBZqasWqjoh2cErkm6faF5YS7o61MaNGcGGRvUzlmqxQUZZyzZLXE5tl7RmLR1
	sEZHr7TAwgcMDApM4TkGNzgTAkgfpmgNs5vzSaRfRDdjNfquTh0SnxUp5CoPnE9ejYA==
X-Google-Smtp-Source: AGHT+IFwoMAxOpRHrs+Ru3Bzln1fX22gQqhHYTr09YwzUWBcwSf3uHHHbnLqF9/7UfEmw9cDht6uWg==
X-Received: by 2002:a05:622a:5144:b0:4a9:9428:6f01 with SMTP id d75a77b69052e-4a9cc74f61amr4194111cf.51.1751911766771;
        Mon, 07 Jul 2025 11:09:26 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-52.harvard-secure.wrls.harvard.edu. [65.112.8.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e4d2asm67362201cf.14.2025.07.07.11.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:09:26 -0700 (PDT)
Date: Mon, 7 Jul 2025 14:09:24 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+8258d5439c49d4c35f43@syzkaller.appspotmail.com>
Cc: Manas <manas18244@iiitd.ac.in>, Arnaud Lecomte <contact@arnaud-lcm.com>,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in
 mon_copy_to_buff
Message-ID: <5de04492-01d3-4b2c-b3f4-8c2237dfed6a@rowland.harvard.edu>
References: <686bb229.a00a0220.c7b3.0081.GAE@google.com>
 <686be237.a70a0220.29fe6c.0b0c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686be237.a70a0220.29fe6c.0b0c.GAE@google.com>

On Mon, Jul 07, 2025 at 08:05:27AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    d7b8f8e20813 Linux 6.16-rc5
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17e89582580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f51185bd4f40ad44
> dashboard link: https://syzkaller.appspot.com/bug?extid=8258d5439c49d4c35f43
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b3cbd4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b19f70580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f933e0e4a6c5/disk-d7b8f8e2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a82be954c91b/vmlinux-d7b8f8e2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/66dbc3de1264/bzImage-d7b8f8e2.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8258d5439c49d4c35f43@syzkaller.appspotmail.com
> 
> microsoft 0003:045E:07DA.0001: unknown main item tag 0x0
> microsoft 0003:045E:07DA.0001: ignoring exceeding usage max
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in mon_copy_to_buff+0xc2/0x170 drivers/usb/mon/mon_bin.c:252
> Read of size 3904 at addr ffff8880216bc6e1 by task kworker/0:2/1204

Test my guess that the report length and ID are both 0, which would
cause the length to be decremented erroneously.

Alan Stern

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ d7b8f8e20813

 drivers/hid/usbhid/hid-core.c |    1 +
 1 file changed, 1 insertion(+)

Index: usb-devel/drivers/hid/usbhid/hid-core.c
===================================================================
--- usb-devel.orig/drivers/hid/usbhid/hid-core.c
+++ usb-devel/drivers/hid/usbhid/hid-core.c
@@ -918,6 +918,7 @@ static int usbhid_set_raw_report(struct
 	else
 		buf[0] = reportnum;
 
+	dev_info(&intf->dev, "count %u reportnum %u buf[0] %u\n", count, reportnum, buf[0]);
 	if (buf[0] == 0x0) {
 		/* Don't send the Report ID */
 		buf++;


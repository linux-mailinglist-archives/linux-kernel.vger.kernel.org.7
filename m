Return-Path: <linux-kernel+bounces-729192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B59B03303
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 23:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1C23B64D3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 21:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6CA1EE03B;
	Sun, 13 Jul 2025 21:20:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BFF19D884
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752441604; cv=none; b=k9vfjeTNKMyj/62koeGUlSdLloV0OHp/6DfksIz0f4r4/90kc0lIujPjo5tFDc34pCqiI5gc9wYHiTYNdzJdDNU3+giRFJN9z0qOQ0esgyYvXHg2/7NXF7B1fF0089spAK8vkiiCbGASCA+Y8zlgkAq8IwJ1oB8fd8xsyq0UgJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752441604; c=relaxed/simple;
	bh=92prjVnmDX/HU5+tA/8d6ByNO0JCsQ7eWlfApWJCqCE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r2TzWYJhG7Q8heUMAr+5NfTp1J8aQfEKLx2i/7/Q4NiZ/DeJs/NsSRS8f4hpWkqLQkN3wMXq2CrEeAIU0UM3QAEME0Z8izjaaCwPgTWdFlG/+EpWlI8NF9AygkvPSvaEdVDGFLnr0jBtbtdg8/UTm6ijLusje6nodjpvHoLILoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddc5137992so37715035ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 14:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752441602; x=1753046402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1od9CAsDdqFqIvD6IJbr93GnQICF3/AYSGBhOqQUl0=;
        b=tZcSIdtJdQTIV95JGXp2oZYlsBgh2n4CxkctTuqpkoQt2n+anzFcsAlzOov7ms8hDH
         skg4vT6t+R0W7NGeo5l/VITqsXdcmR4lZeuuqpE0vK84I6JMH7MIjzaaB3a9NRKmTsV9
         4WsMDiyP9czV3aNSQjqwGKRPywkg4S0IWj0kDABvrJd1vuXxjXCHdJZB1SeAELoMu/0/
         5FYYV9DkierWsnRbhGfjVCbwoC3n5OuLCrQcdPhid0pG2jMwticqd6iiWozPxOwGKvhC
         bUVTNSGKPjSLAj9IJ4oNpu7TaMQKMXGc4aT2tNUIgrUh1srC/6vOgk7PiX9umQAMH55m
         NTsw==
X-Forwarded-Encrypted: i=1; AJvYcCU+ntjKmGyyObO1M18LvcH0IaD77UTDzgEjNOVuwcOWc5gK2EJT1u90MjSvHw1nukkfqUH6FBjWcxcV6kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwI6MMRkyNdPgdKVTTnNBxL081pL4wAQInsRHODyrM0/WZDa10
	sArdz4L1pvvSbgcEjN52MidOZMyYSR056P/pbnHltxu2jFIZe21UkvV4JOYvvtmSLeVbkZv0wEk
	bB0VS4EI9rEQnYmb85eOoxjoC7+/DqPJSmbsr7S8jnaV5N5u0g5gKFs5Zz2M=
X-Google-Smtp-Source: AGHT+IHj+TnAt8QJ+CiZShWzfqHJREdvhH+VHjOiL2iCMjtU15CPDrH1wh+oQ36d5yLgLZ/iQo9LVQD3kw+pTqgRzCHbDUHEXjlh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2193:b0:3df:3154:2e90 with SMTP id
 e9e14a558f8ab-3e25429f52dmr105499625ab.19.1752441602051; Sun, 13 Jul 2025
 14:20:02 -0700 (PDT)
Date: Sun, 13 Jul 2025 14:20:02 -0700
In-Reply-To: <e8fe21fa-9a2f-4def-b659-063d55a40f3d@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68742302.a70a0220.3b380f.003d.GAE@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbhid_raw_request
From: syzbot <syzbot+fbe9fff1374eefadffb9@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/hid on commit c2ca42f190b6: failed to run ["git" "fetch" "--force" "--tags" "d2f5fa5d883c5402c78965af80c005a5cbdbc6c0"]: exit status 128
fatal: remote error: access denied or repository not exported: /pub/scm/linux/kernel/git/hid



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/hid c2ca42f190b6
kernel config:  https://syzkaller.appspot.com/x/.config?x=76c2fb9aa0954fb8
dashboard link: https://syzkaller.appspot.com/bug?extid=fbe9fff1374eefadffb9
compiler:       

Note: no patches were applied.


Return-Path: <linux-kernel+bounces-804579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1F0B47A0E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489341B21439
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 09:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCF721D58B;
	Sun,  7 Sep 2025 09:32:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7641B0420
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757237527; cv=none; b=NqDoHynBoQjvz4gktxhIEhAduhf5LEjsIfgaOCeIkJ5kP9lVeuDVwJHLhB9Crqe7X9ROGE1kNFfd62AE8a8F+qaLjSMLscaw65exjK8Fwz4D2RXY994E2DwnUMzm1PeSJbC+eB8tN45mYTxNlF0I7/N4n2YM9bJH/h0rYoTzfA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757237527; c=relaxed/simple;
	bh=qnfO8KepTLXXWOuRIxdt/5xi5vf7RixdfGu7OCpWm5I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KB96YRpdsx59lTKKsErv5yVrvcA2p0SadVnW0RQP9LsknX4blj6WmxYI7ojkMcVyBj9OSxQHkG2y+KrFe16hPvgTSimN098inbhFAAotX8q4kwkEqVdq/nGYTBJdrnlYz0BwjLguQEBJm1Do42j0WQz6o17yI5PyiuNCmzuEEAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-886b489984cso821237439f.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 02:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757237525; x=1757842325;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q9t+ysctxTtbyq1Ab2N7qrEwllkJTwP3UQdHwHjnH+I=;
        b=rKT5Fcv0NyQqumNHgjZQbJhaa439YO0j9rYpYM4YwWg/0Xv4/5ANo6CZ3aN0oTxJDy
         HGNWnrW1ySwl2F7T1Cwor6m9gFI52OrvvassTJENBfMZgK8zpiu6XsZ87WyQbC6C+K55
         7EYkCJ7+4wtKJC9pHXzlrbC3aSL3/yYyxd+DLQOJySz6WEtYDShMQpaeryW9zjZGRBSz
         KIOl16rM3qQj8KAoRH6oX9aaaKTclPaGOkDj7HIPlhRn/Iutg+GNXAQ7f5syw1p+JsNX
         xWNlMSAFQ3+9y6+E0wnUOCIdSzLpwThQqqcipztajV4UVlaVrA7ZVHJjXlpcvx9xW4tc
         CIAg==
X-Forwarded-Encrypted: i=1; AJvYcCXMyLkCCIeSJeBDg6FAn6fSLlzqnhoPxK5xY90unYlKHB2gAIm3DKbZyGG7bGhd6eUqoFOAuHc/rylaxVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcayO0VSOdMTR8eK5IeI4FLBC3LGnAxjmQRSwbYj8mmXXo4I1T
	iiq03rfkARav3bw8DurIqhhOeCQKSaP/viB7xwIMpmzz3sw/a9Uw9fjcSVPep3MspFa7oMEYKt+
	kX/mWQvfchSkH9YAj8xUaUVGYm2hg0RAZ/6Ff9okoTJwUb64pw/5JsjskvNY=
X-Google-Smtp-Source: AGHT+IFIs6ItTPNB5mZLuQUCyBEpYrNRI8mq6k95OXxsS++Gfd+/8n1TTVY1i/bwyQTCkKaSJWq1Wc9jkM+og9WZU90mvb4DVVRN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6189:b0:887:65d8:2bb1 with SMTP id
 ca18e2360f4ac-887776d35d6mr638344739f.19.1757237525205; Sun, 07 Sep 2025
 02:32:05 -0700 (PDT)
Date: Sun, 07 Sep 2025 02:32:05 -0700
In-Reply-To: <20250907081937.6583-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bd5115.050a0220.192772.01d2.GAE@google.com>
Subject: Re: [syzbot] [block?] general protection fault in bio_iov_iter_get_pages
From: syzbot <syzbot+b253ade8e1751d90a7a9@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b253ade8e1751d90a7a9@syzkaller.appspotmail.com
Tested-by: syzbot+b253ade8e1751d90a7a9@syzkaller.appspotmail.com

Tested on:

commit:         be5d4872 Add linux-next specific files for 20250905
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17e2b312580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a726684450a7d788
dashboard link: https://syzkaller.appspot.com/bug?extid=b253ade8e1751d90a7a9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14be8562580000

Note: testing is done by a robot and is best-effort only.


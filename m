Return-Path: <linux-kernel+bounces-756450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2350B1B42D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A341F7B0727
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56A02749C8;
	Tue,  5 Aug 2025 13:10:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4F4273D6C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399406; cv=none; b=nHD111IOJUokKBTuEhd7yn9+JUxVjXa5EbnntycSVGyNxIN5PVxqVFaPtuQ3nGpWnKbDCS2t/5H2EIjVvOnY/sbe//OaQWuO0gU4naFZqPEAbSwXAiPx06DiD3RfzvH/Lya1R+Oz2rzdCQtgPOMMThawzViGZbPRA3RWEJU/K+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399406; c=relaxed/simple;
	bh=9YWpYPvVuEhAa8l0RhynQKbgmpONs4dDFhykbP7zSEI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OqxFMYPTxdUTDue/SI9x4kdnuPjc1UUbkPf60RAokRWzdqY698fIuQC0xnjgtL+x3pW0RC8d1zZICfXnA8Kq1ZErMMs+iZyu7vpmv/1rnlI7jPGcRfHyMHpvvuk0KeJN5Kec0t3i+S+fIkBHe21sHhvRSBySdRrXdNMwo91+ke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88177d99827so245185639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399404; x=1755004204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/u1raVmfsGzizOARhEi93ynB6XPUBYegU2vD8ceKqEQ=;
        b=OGdEWCUPIdcxCvI+ZXH1rILVP+yUo4KkQHs3fn01xDzrC7hIeSy6clKwwbq0XN/wQS
         Swkx1eFOQ8F9AfxRLr8tbUbphOrqELVAJ/W+cbEX5mdByw+/mJAJegdIHHe5Fg5yX6i/
         d3ZNCfhjth8Yfl8Pzsq2ZEXFCkozCOgqbrHPnC8TSLnU2nnEk5EnC7mqs9S6vKz07bCz
         F6HMAdJXvAe2gIZr11oWjT+BUaRP9JrA1A6xv6rUbx0oxI4C4JeO/UVX1iDgpGaeMfug
         U9JQQTE2e5CU15/Re5NrcIkw/G11CuzCypS/0ir0XAq2a9QJonSx2zATS7Noq/Axtgdv
         QZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj5UBYOCAGsw5joBFcgUvdqDVTDN+rlMMJ3s7zKDSStNTE292PG4mHg0k8zQDxWIg8nNfhsMdauT+xbr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDal6/Ag8U+Lo2zy9/mT+Yacsr3JLcrkYI+RXnHmu3DHFZoD/z
	Ar85bQ28wXw+XGJvLzSqpyWuAJmHSXrs5rR0xVILXaLTYINyr7mZw1A5ZRvgCNtAVR6Mfi4UQoy
	r8l000nvpO7819mnNVicXy9furH+Qw7kYdQYBHqAZ0DyxBCIEVR1G1pHGhSQ=
X-Google-Smtp-Source: AGHT+IHYI5YJSkaoaN8QBlJToEh4ZCCY9QLRv560/aS/hYDa1iiJPwUbyy9c8Z3Ys9rzoQyR5fPboAJHevQronEdKiM1KXoIf/08
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:83d5:0:b0:87c:78b2:6ddb with SMTP id
 ca18e2360f4ac-881683b28aamr2177206939f.9.1754399403991; Tue, 05 Aug 2025
 06:10:03 -0700 (PDT)
Date: Tue, 05 Aug 2025 06:10:03 -0700
In-Reply-To: <419ADDD0-A731-45E5-9B51-DCB2B0CA1717@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689202ab.050a0220.7f033.0022.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in pipe_release (6)
From: syzbot <syzbot+23e4a7772eb9a9715b85@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mmpgouride@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+23e4a7772eb9a9715b85@syzkaller.appspotmail.com
Tested-by: syzbot+23e4a7772eb9a9715b85@syzkaller.appspotmail.com

Tested on:

commit:         5f63c1c6 bcachefs: Fix readahead involved deadlock
git tree:       https://github.com/alanskind/bcachefs
console output: https://syzkaller.appspot.com/x/log.txt?x=1560b6a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e6834878e5ced02
dashboard link: https://syzkaller.appspot.com/bug?extid=23e4a7772eb9a9715b85
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


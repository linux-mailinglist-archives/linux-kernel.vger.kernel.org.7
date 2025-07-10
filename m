Return-Path: <linux-kernel+bounces-726174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED5BB0090A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C15188DC50
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905CC2EFDA1;
	Thu, 10 Jul 2025 16:40:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A471F2EF9D7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165606; cv=none; b=fkwMYfriJMElqZtBunlal+lvmyp1hbjNhNAby97Xwz2wWhHQ7tk9wbJNgrsm5r1yAqg8PuED3B5Wa25lmzhKNJbvmRBkfsqZa8X78mF34tRBZnVSIJrQTw+dSQ/gNBFjx5Va7z0hCufnH3T9wvDSqG+fooHFuRurG7W9CG3uJy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165606; c=relaxed/simple;
	bh=rXk8Ku8maymFXZQ1YWOlmFsrr2E35x3kFiN4vQXpIJ0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ei+0fH1We7W0Diforqc3h4uuW+3/DsPgVD7vocnUbj0VxDIeZs/1X5j29rnIdm90Az8EXpcpEytCd/B2k6bTp2w/CYjc6mO5et8FMqLq7mjUb+Y3UofpvFr4M7OtCotnud3jOo6ki/vf4oiFFdtncK8zBmtOSpC0AHvHaBfWqxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3df393bf5f2so11575855ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752165604; x=1752770404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FB7nCBC6Stvg7o8QO2/yWpTOea8ms+uU+NpYCaO5Xqs=;
        b=xB0Pxl1a/NC1ipYV+T/QKsfAzUMzeFqs9zNM4WjA6iEwzFLnUyr/hAv+Dm0gJkdNsr
         tT1bF2lJ6fCKth2jHuKNaXNPTZMlJ7YGv8lhvX7n6TIJ3l6zrfX3recRYigjiQnc+Bqo
         /0qEjvxsZXISLz9kt5TI5Ir1VNZMutEMLciyHg3ZzYiN5L4clt7FxvutXsnPIYDYdI+U
         9N0d+QuRgSNZu4EBpDf3pXr8jllMQ2JmrpPd228lDn4xFeX9lWmTTlvjeEHROo4nV0QW
         N1MRUbp0BI0mIzWnnp/aG2B4jd3/Ag5JvHvU3OP1TCUwkMvZlOFhrZ5JE2O5bEYiXDlM
         BhCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6SgTmzu9E2psGDL4nci9h8ZB1brZdHqLSfOeeP/giH+s2+xW35OjYGjUlBafVix3F+e4/9ciV71WKPoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfVU49WMRRrfT/4VyyRqJz9T2pBho5Q25apUZop84iSPvZhBaC
	StkiqjcoK0I54WiJWPgp3XRGs8FcSdRSC3nLF92ZDZR5VtpeA4zN6gV9mYjU+HDdBkCO0cZTgct
	EHkuqcBn6zBQv+yXW61uqyZVmJ3DPztiohfbJGTvKmJXPgDZA3DYb5Y2VUng=
X-Google-Smtp-Source: AGHT+IHtEJYalFaGQmYX15vQQch53DYo1fzoJ/ko2WfRelsuQZ02DqKU9rKYm2SO1tI4ttlniyWpNJsgxDRgNOJ4FRZHeRddCBzA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144f:b0:3df:4c0a:a3 with SMTP id
 e9e14a558f8ab-3e253363d95mr464635ab.20.1752165603797; Thu, 10 Jul 2025
 09:40:03 -0700 (PDT)
Date: Thu, 10 Jul 2025 09:40:03 -0700
In-Reply-To: <686ea916.050a0220.385921.0013.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686fece3.a00a0220.26a83e.0018.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_btree_node_iter_init (2)
From: syzbot <syzbot+3ba6dd3d414ec2296f3c@syzkaller.appspotmail.com>
To: anna.luese@v-bien.de, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c366b1672d74cb008974f6e36e34dc191621f3bb
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Apr 26 13:31:23 2025 +0000

    bcachefs: btree_node_data_missing is now autofix

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=128dda8c580000
start commit:   733923397fd9 Merge tag 'pwm/for-6.16-rc6-fixes' of git://g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=118dda8c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=168dda8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd2783a0a99d4ed0
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba6dd3d414ec2296f3c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12101bd4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12609a8c580000

Reported-by: syzbot+3ba6dd3d414ec2296f3c@syzkaller.appspotmail.com
Fixes: c366b1672d74 ("bcachefs: btree_node_data_missing is now autofix")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


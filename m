Return-Path: <linux-kernel+bounces-833519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B8ABA235C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9576D4A6DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E29225A2C6;
	Fri, 26 Sep 2025 02:27:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4851388
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758853625; cv=none; b=c0+f8ITE0Zh+b+hinkVBOp1GQ2QLkURw/wSqnBgIELaw1wS6oePQUns3lQQKBpOFXKVRvFoArsRSJkx5TF8H/s18ViBugn3dZMbv0tJbjwUuGhgUX9qaT5EAN7r8uEAqqpgKj04T2A4QiDubGcfMXJ41ukbb0PT03l+H9xib9zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758853625; c=relaxed/simple;
	bh=+z5FTdbZkixzSTb7PoLbDTngvIhEMwZ0bTKCv/jhYoI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tGkRLYsKBGf+kSbPNUM2sxlNMpD4WVWVQBBKBC/30kdZZrSlcPGrz1W+C0hQvWDU2nY3IvuSv5kSBNTNnSggU2mZr1osRKGc3ZfMtI8wPKItqJ2ZVaHawlMBRJHgMqnfQWh9oT65nZucvTcPX0BiRr4+3vfKznb3E8rtI85L//w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-893658a9aceso186692539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758853622; x=1759458422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6leJDjbFxM/iN2DdV4Ut45nhqJkejwgNXmyItYOtLao=;
        b=pA20RexTWi6Hw2iNUPsmJJ5k2BJjy3LUyjpzLirEDndRsgxFmmy+XaoRiSy0eOk1TN
         fVOfbNRQOZil7HHEw6c1WgJPZX3jAV26bneWQOuv14MeScat6d+/y0zE9ln0krdlMWHC
         HqAz01vZ3y1mBnQ+tEBplmkkA2o0FpT4DLuZzocoqj5muu4O7n3WydkK9X67w86eOaET
         roKa22PvplYnyEtxNKVNf2XYvUV/iB6yT3NEo4dWj0AcjzHxSRj/bwETR8f9PD/zYTkg
         zYI624y5fWve4UsIUBVM9wqNoDDXSXLe1agu7zDKWSg9PHCiwEO3UQ8Wjgc60papPCyS
         n/fA==
X-Forwarded-Encrypted: i=1; AJvYcCWdu08o4LG86Uy9rJ+e27mK7rGF6Rg8H2+Nm6ggNSRDSAI7ab+DZt/S3MJLS+ZISc5wpt639pH217DWTRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCFbfHCJcfj6Tn2X2EM1dBXB4rqZsYIrypk+93kgot4yFtAfz7
	QqE+3CeLFGIy4xH/cVllpgkn94lJIkRIct/1sPAdwCZNyswWEw/R4vok/q/F7Xx0q2QDIUYRJRs
	Ia8zrtE/rpz6QLNLxbaBNdT4NcYVuChzgXgOcIj2o6iCtWcn5rHuzP2kJ34Y=
X-Google-Smtp-Source: AGHT+IEWYAYLxYUXUBWoGv8bl+IZSAmU/RgCC5NxTf+VwcrUVPF5/Jy9wr2Aj+M+YQyk6I3eMJG97s5EFS5yjN5ZJplnEso3oxMd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c6:b0:424:7f06:4f46 with SMTP id
 e9e14a558f8ab-425955c529bmr90948605ab.4.1758853622686; Thu, 25 Sep 2025
 19:27:02 -0700 (PDT)
Date: Thu, 25 Sep 2025 19:27:02 -0700
In-Reply-To: <20250926003239.8582-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d5f9f6.a00a0220.303701.0022.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in hugetlb_vma_assert_locked
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, kartikey406@gmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com

Tested on:

commit:         8e2755d7 Add linux-next specific files for 20250925
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14871142580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ba7bd7be9b0a083
dashboard link: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15319d34580000

Note: testing is done by a robot and is best-effort only.


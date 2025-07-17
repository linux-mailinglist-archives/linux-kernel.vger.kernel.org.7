Return-Path: <linux-kernel+bounces-734631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBDEB08428
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9C8A43034
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F591DF248;
	Thu, 17 Jul 2025 04:53:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4D4C9D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752727987; cv=none; b=MzWNsdUkBwMm72jlaQICTuKpcdCjCUbWALkl8zanqTgVU+gD4Fbtq43K1bZvv/DyzbN50o8xD0CqfdTMtLrHb/ufgDMT5kpounZB0O77kzk0LuwCGiinFyP5O08pQs3Xr4QVxqR6Qy0NqOpg91lrrDHrYFkV7U/mSIzh7tLceSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752727987; c=relaxed/simple;
	bh=xtKhstNTmrnDJHOuAOSMxreheu5E9ccxXtSYK71498Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=arBVqYZ5ZwXnDGtZ56+VKxXdeWRttfPPK40XKhVzF66UegxUxTqZTIQrUusjlLMzwnI3LiM9vfeHGI5OvyjF8hjRf2lHIa1wrRofKG7Khy0LZGaK4hh9qKeTHA4EW+lMkfvi+tJfHRHXvPBTbIb6AI6OjkdJUIlO1BM7zDOuMmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8760733a107so60947639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 21:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752727985; x=1753332785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrqN04cr3JZpYiwcfwUTCGQ32JhGfUVbthJmSj0Uc4I=;
        b=aFOzKZ3359NGB+3tW4VYnt2tIbbf/N5UXV9XFqCMyN7SBiYJ4NA3n1yZjVgz4QGtzK
         sPW/HeXqESabMjVno/xudeIU7E0q8GT/5Lx2UVK3w4nVmCR6pQqvedse/LcKEgZ3TQER
         XHEaamAvL3DctR4qaexKwC2ewz+iBdhA1/rhu44IOKWxlo6jiPyBeheJiFv312noXsHt
         DIa2Ipv/OIdOewfTM8piomnPw5PjWuqpWsSZxkhRSmQdH3G0CB2rWrZQy4ia8Y0FGJSN
         q2DRFfGp/o5pd3v8qbyniNZBkWVBIO2eLGaXrafquV/CjBaxzCKTH9fE9P0A78GszVMY
         eDsg==
X-Forwarded-Encrypted: i=1; AJvYcCXpRcoBv/vtJjYrVLAn3J1TOjtsii9DcDTMmwwxzePHcaSUwlghgGl7HklFjowyFSFLOT29lNe1lg2EIck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzCAFFmAAhTt6ZE8AJScThWHAMq8z2rfrGSGekzho8rw0S5DgI
	c9A9pc93sWWk9EBQcdkUrtHZFOmQe3Ni+fPCrrlEC4WKvjalqwS1KocKqfPtgSILU7k/Hlqo82+
	4OWefrc0hLwWxHi2P8ayFOYoUi1TdNv+bZdSWUZBNjO9h8K0kcq5R4PkRWec=
X-Google-Smtp-Source: AGHT+IH6oto1YCb6O0AqjElSdn0VcaI6xwe+bC69ogavivD9k0PMMDFUONsxrBqXTAu+BDDu1+IAPgv3NxYqlvZWyw8sfb6wJIw3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:482:b0:86c:f0d9:553 with SMTP id
 ca18e2360f4ac-879c08a60f1mr642151739f.5.1752727984729; Wed, 16 Jul 2025
 21:53:04 -0700 (PDT)
Date: Wed, 16 Jul 2025 21:53:04 -0700
In-Reply-To: <20250717023444.2281-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687881b0.a70a0220.693ce.0038.GAE@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in lock_next_vma
From: syzbot <syzbot+159a3ef1894076a6a6e9@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, surenb@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+159a3ef1894076a6a6e9@syzkaller.appspotmail.com
Tested-by: syzbot+159a3ef1894076a6a6e9@syzkaller.appspotmail.com

Tested on:

commit:         760b462b mm: add zblock allocator
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-new
console output: https://syzkaller.appspot.com/x/log.txt?x=106c2d8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c39d2ebefebaec5f
dashboard link: https://syzkaller.appspot.com/bug?extid=159a3ef1894076a6a6e9
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


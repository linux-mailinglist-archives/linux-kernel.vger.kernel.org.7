Return-Path: <linux-kernel+bounces-760946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CFAB1F23B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F6A67B6BC8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFED927587D;
	Sat,  9 Aug 2025 05:11:09 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B331DC9A3
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716269; cv=none; b=ZK4wjthCKEDuhAC2carE4bGNJQOtLyGb52mRor3HZptNmFgrrsI4yyAHQJRwueKtm/LW4dwd5niWagGYZYVtRBaFLxuswA01t08NfT9OlfjiJiI7mosNfu/4WJCfAcgqKLVLHRHqVNazbtnVUOl8iEssqWl+fKiSXz3H63JVF3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716269; c=relaxed/simple;
	bh=X5Vh8Ylv//lLohBYJyonvHQi2a8M3wBswraa5cn5SoI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ebK86dpy4Cw0aUF8eS2tzNvnZzL9ylXoJfDy9ttnn8UhUKA0zcxRrH2sETOjwT6Hf7it+eeZzMqAlDAestGkcRX1p7BsC9f42Nhi7mhUP0fgv3ntCxVF+OlM4I9fmhMvtZWCa8DiLxypFBdPKSm1mtyrjBf9GA+oqPoWulQVhvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-869e9667f58so688514939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 22:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754716266; x=1755321066;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=065q4+NkRvU3OgoD81IEzZCGcJ8XgGkKvX+PyfwlzmE=;
        b=V5x8mkKnaL9mz1+km1V4OM1Qhlfjp+vKPaoCwbdwsOSfWMvOxfGDa8GvqIe+Gk9IMA
         4/ylkDFO/LpQnVPqqB5abnWnHzEcnDltWV+Sk2P96rOiZQTsUzV/jNXz+Ix6Ijwi/XPy
         JYYCW6yo8bFUEpKweiGQsywWu3hUx1zZL+M8Cd1T6f02Ausz8qQqA73IxuBD+D0mLSv3
         PitPPEr6xBKCLpJsPi2nfzduzL/NQ4kI7bHnlirYI1Jl8Yus8JR3ErZOnoVxpQ48iBTJ
         8NUTuodva3ZXq5/mfeolCDzhstJ2MiS2FwUrs/AMkjGILgF0lYoyYUUigz5fw9d/igED
         wlHg==
X-Forwarded-Encrypted: i=1; AJvYcCVri2VfEwD2nUkfmFoe0n+dECuuHz0/OoUNCJqjp0udNM1mwYudD7gbWplayaS/8T8JYHc8QHOFGrk3aUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXAXTuE2ws/J87Yl5uiCjQGMOwZekAurAoDfF1UnQqeecZ7Ax0
	sNxzUUaqpdj1FoxiCQM4gJ7aPITzPSFGc5LiYT4AzRVRWKqmNPkNCIElfoMklmZUoxuHsX4TNat
	loGSwSjUXEe0gBZrtv60CteSA4GA058ZSYLhCPL8uuKzZZ3a7zblVBonllY8=
X-Google-Smtp-Source: AGHT+IF2R+N8nJZdoJjgPgvVrMKK84neUZiQ/xFiFPOgnheVMfNAfl5uIZrHQ5pbtz/fej9SQ9VxSUSQ58uselnx0KRUAAsXUBNi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6cc8:b0:881:8960:6fae with SMTP id
 ca18e2360f4ac-883f11d4c84mr1037762539f.4.1754716266488; Fri, 08 Aug 2025
 22:11:06 -0700 (PDT)
Date: Fri, 08 Aug 2025 22:11:06 -0700
In-Reply-To: <20250809043659.4068-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6896d86a.050a0220.7f033.00a4.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in __sk_destruct (3)
From: syzbot <syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com
Tested-by: syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com

Tested on:

commit:         37816488 Merge tag 'net-6.17-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1303e1a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ae1da3a7f4a6ba4
dashboard link: https://syzkaller.appspot.com/bug?extid=d199b52665b6c3069b94
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142de1a2580000

Note: testing is done by a robot and is best-effort only.


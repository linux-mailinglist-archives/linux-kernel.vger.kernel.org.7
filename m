Return-Path: <linux-kernel+bounces-898385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7063C552CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7B334EA1E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 00:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D7F13AA2D;
	Thu, 13 Nov 2025 00:45:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553D1DE3DF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994705; cv=none; b=pKhPxYpqnplL/wJTCxMVwKfu5H8ZZETYU+cSaq+8ciwPSJKGoO69UjOnenLhspoO06HBdh2qRfj2vANOCvkH3DWKlpCjWWPeiDdtU/DipNxK5xHlCQFO1uVTBbUnL2RhDsft3iXyaE6tQLQeDTB0y9zRxoLeX63pn3q6mv+xaCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994705; c=relaxed/simple;
	bh=akpD68FRXSgJ3UWTHxS/xTnoHxMdY2EKCElVcN8Lbrg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=azvxUpzRxa5npGpEcJTMY7b76CwhcbBoopvCx5vzwxsPNF1OAuXVQfoypKU4+Xz83K7MX0ED9O5XNmBP8xWSIKLVEdohzRcRqZ8VM1mNSEzx+INdfIA74jI5ULvg6pEwcznPAB+vynmFp5HINUm/SVglXN7Z84VX7mg6rFhnD2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43300f41682so4215265ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762994703; x=1763599503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItT12y+7wRZewvqvz8JD8QRcThWHmeWOgUeD7MW9ZBE=;
        b=UfJqOXiWPBJW1URNJaO+kt/3vD+iLcXhUy3bSr+jRZbOOoaO4fwaEseDVhRKfXudDE
         JrevBSPTTVt1mJJ17vvC1HF0qkrxdu8gCIUX9IQUw8UQvBzgBm8U9j4qq2DHAaJR4ey7
         1j5z8EGaCb4ADBIIRJtYJ9BamAIJB+XudQm10yo7shbi6yBwL+kNpVccsAcwRolooLTc
         XduYA9ZsmYCRa3EfgvkydjuLzapdVNlv9Xe1ncuP+gSmLAnZepRTWKzhAHJloCO7ABAC
         h84KyOTUwQFeORrOweHtc00B1g3QMd0qt4gqPp3ToPOz7jQUPJSwWGZ4H/+yjewBgJC0
         d1cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfidaK/GQcktK5y/mNkuNbQWWs83DGdbKi0zA4RT23lg8N6LV7dKKQdZtrLAt+vH9+diVkrN9uO1ishRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YznCFTIR4udMw4BC+zqHPzWJgCnyoQ2+M78Fg4F2CrMkFvAjwJ8
	dFlo5srUITQWHVS0Kwb/wSFtxFHAX5HrZRYOaXe3kBfcu17VPD2jR32U26f+zPj/6ncdrFiVhQb
	zSrkJUnHU9xGFh9yUhS07n5TqysC4+XO3wWKRMF04Q9V59lBoLVNdqAz6Wtk=
X-Google-Smtp-Source: AGHT+IGN8F2oZ/myun0ZFiJtclNF/dwsR+aCXcHsOpDqPUh5c+bO9sOqP7+avnEYzEIhUZd1GBkc7xXp0tpc8n7mkAJgoufSiItk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2148:b0:433:7abd:96d0 with SMTP id
 e9e14a558f8ab-43473cff5fbmr71591685ab.3.1762994703007; Wed, 12 Nov 2025
 16:45:03 -0800 (PST)
Date: Wed, 12 Nov 2025 16:45:02 -0800
In-Reply-To: <67da6f4b.050a0220.3657bb.013b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69152a0e.a70a0220.3124cb.000f.GAE@google.com>
Subject: Re: [syzbot] [usb?] [media?] WARNING in media_create_pad_link (2)
From: syzbot <syzbot+701fc9cc0cb44e2b0fe9@syzkaller.appspotmail.com>
To: cascardo@igalia.com, gshahrouzi@gmail.com, hansg@kernel.org, 
	hdegoede@redhat.com, hverkuil+cisco@kernel.org, 
	kernelmentees@lists.linuxfoundation.org, laurent.pinchart@ideasonboard.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-usb@vger.kernel.org, mchehab@kernel.org, ribalda@chromium.org, 
	sakari.ailus@linux.intel.com, skhan@linuxfoundation.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 0e2ee70291e64a30fe36960c85294726d34a103e
Author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date:   Wed Aug 20 16:08:16 2025 +0000

    media: uvcvideo: Mark invalid entities with id UVC_INVALID_ENTITY_ID

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f0f0b4580000
start commit:   07e27ad16399 Linux 6.17-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=701fc9cc0cb44e2b0fe9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e38142580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12da427c580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: media: uvcvideo: Mark invalid entities with id UVC_INVALID_ENTITY_ID

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


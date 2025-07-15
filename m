Return-Path: <linux-kernel+bounces-730933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E94E9B04C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263651A65F02
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E138279787;
	Tue, 15 Jul 2025 00:00:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5D279347
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752537606; cv=none; b=kFN+axX99z91wEfyionn8GusFEeDYjpt2KO9eq8hfza7kqMu8ijJanNRPjqGzWAn3tbnEBqBUh2Tc7Eb+FfzW3gJrCtt9RRCFHnBbLcFjlc3EQtMUQtTsLJwFAxErIvxxaclpVPolZA7ZzyrqvjCmg12FT+sAbf4SjMFtBJ+iAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752537606; c=relaxed/simple;
	bh=ez6QPF7zZsOFfsJ8n+1HyNnpGGsP2rHkUY01pkIl63o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Lu66Hv8Lo3mtsL05qqxqRMBYatZ/2BxUPwiEb9WH1ILnBPG9c8rTQ5zrgRHbh4oZt5AgocTUl0xly5fah6Dbye0gBDiWXcGfI3lMSgznOO1q+6+xx66KWFsjmQdjxrjxVpxuIkAsZGm7bJHuPqjbmMsnPv1lWQdKUB5VN5ddGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8730ca8143eso549582939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752537604; x=1753142404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugecHUs6ZUqF8Vti1XuTWNyS/mAPzmrzTFopoL7/38A=;
        b=cLZ8xPspAlrCgf7wGgNVoKiTaftt9un/jZ9+xOx4bwFp3QUlkOaw/rSMJ3yRVFkh+A
         8G5/8zlMNW7rIjoh2TWP93SAUN/GPn/rEMgRYaZkMqFD+EUh+jZpZ8oCdOdxqREWOOlt
         /Mlj/9sM1XeEvWwK1DLyq6ZTcdm0DXgKT61GGzA8Hp1NN82PnaQ+Rp0voCOCSRVMBDxn
         tUN/z0ADE/jyseKz6N13jLYkxLVNzja9XwDqDtRGt4zg+ugvWgdR4nbkcIcepc5/QgdM
         YgRzoKEtWWGr1BNxNO5b1DfD7OMy6QCMa7B55kNh39nltvnVGL8tokJUYepXQjN5uaWk
         25Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXrA+NTQhHfRiMm7LWUvTYd5yYlCeJ5FHeBcOWyAgf7q1eMQ2FzzzkhMYM+kdsDDtnGmjEl/RFzxWCeFvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmQQU9J9IUkxEwOnizb6mimIcu8z0bol6t/4dOOxtlsDyfVNNy
	YfAMV81AumlS89MgEiXmlfcK6difvvvnRUzHusWC9wT70ibu78rlwhNECxKbDnDVtQzmejEu8de
	eUw+7W8lkfG5s2V1csDbd3n/YF9bXWT+qajPMnfBUiRMWWR/KelyIqSL3a64=
X-Google-Smtp-Source: AGHT+IHDw6UZRV+roLHMz9hyzZ+jp9boU/Gtd1+ISYFZjLUJDrwFmH6vMvUpUOitf5uZHLqD4I1D5n/woykmWqmJ+gitKgKY4U7T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1065:b0:3de:e74:be13 with SMTP id
 e9e14a558f8ab-3e277b37e58mr14777985ab.0.1752537603874; Mon, 14 Jul 2025
 17:00:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 17:00:03 -0700
In-Reply-To: <65df1f7e-9512-4527-bbe4-0cf10877f4ba@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68759a03.a70a0220.18f9d4.0013.GAE@google.com>
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
From: syzbot <syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, inwardvessel@gmail.com, 
	linux-kernel@vger.kernel.org, mkoutny@suse.com, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/cgroup/cgroup.c
patch: **** unexpected end of file in patch



Tested on:

commit:         347e9f50 Linux 6.16-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=84eae426cbd8669c
dashboard link: https://syzkaller.appspot.com/bug?extid=8d052e8b99e40bc625ed
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1541718c580000



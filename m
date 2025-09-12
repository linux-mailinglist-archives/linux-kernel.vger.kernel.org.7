Return-Path: <linux-kernel+bounces-813452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D23B545A3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844CBAA442A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71422258EF9;
	Fri, 12 Sep 2025 08:36:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ECC19E97A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666167; cv=none; b=Y13+v+wK2JUBTCUahFMmUPE2PSH6tDlYuFD8PHh6hXGeYTyzR5qxmDTpxNHs+OszCAQZRwstiEdh5A8xP8oEqfpAaLzk7/Z6oBqQnhKciqiGYEnnWogPO3UYi4o6Xz3eZqnq7qannHhk1uOlA/hVIsoJgnOr17bLu5qv17xxrME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666167; c=relaxed/simple;
	bh=hf1myjBL27ixgUL0+xsZtytvAp0tQARBjVpHHf2BLI0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=odoFfDZjE9P0EHvQygZDxtLRhjNj/nqX9NKDLdXYmggY8jcQQ7bUYues1Se+MhMlGMn5ZREmnRKKh5xFzFKEPFcPxlnyF9zLo/o/jph2WtyGRlDbl7Jrc7Lq08IzrCeGWpMVN97Hw6Q0nvD+5t9EjYSztX2k3sGfthnwDPXY0oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-404746a9c67so20974595ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757666165; x=1758270965;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFpwX3P23yXZ5u16UsWzVG4Vnx911dGgY+qOSp2Rt9U=;
        b=SOzG78uGnsaXuFm1Ca/QhMYoYSdqOvAJHWGNOMa5ecNJAp/oniUQduQOK1jbk4/rS6
         WNAUecIddhM9JATeh0O0Jcw32IMhJF/1Vo08Q3kTsJtjP7mq/gsO2HuSL5A1QPgCOAEd
         kSA0Xae5Wj5rSM2QICTm/fF621E08c3DMtdzZAeQS4bnOmZHOUf8TCSQwO9FUkwfSvWe
         aXuHoIt9dZZaa9DZAflgHFnVYMCKqJ0QH0qPdRSbxZ4F/vG7/5yNd9hbH4bagvKRxJg5
         fUnpcQqbkwEqtch/mmbQNwKToBUNixCame3kT+AIPkyj5V1An5xNUw8fRWwd1CQp1Oh3
         m5ng==
X-Forwarded-Encrypted: i=1; AJvYcCV3jvOyGCjnwKEOgrGs0TrGfci6Itfw6BrjOTsVy1buPYvxMDp4Q8U9uysM0QQc/Flga00HAj00KebGvOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMO8ym4kcAzhvF6L+abNcFz7YN62Npw00UV3IOC/s4FAQl4JE
	oaGU0wuwFmSED5tv7FobJx69yDdYv/ZChb5nrozkiUXFeKN6pgdRKyHpyX0UF45XmbzZi/70DYw
	oMl2STXjMks4KzIevRYQRkVyOlVXBMsDJdOPsqLZ2tI2Z7oBUY2esPZP1Xs8=
X-Google-Smtp-Source: AGHT+IGnFwRxifRkzpg4hX+roMSv3nwjRJEcGnKs4SBdKscOSduXYwxul8efGVSMicRlvDgh3WB4yE/jqNv++OxUMPARcZTWwQlL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cf:b0:412:fa25:dd54 with SMTP id
 e9e14a558f8ab-4209e36cf49mr38832055ab.14.1757666164819; Fri, 12 Sep 2025
 01:36:04 -0700 (PDT)
Date: Fri, 12 Sep 2025 01:36:04 -0700
In-Reply-To: <20250912083359.6809-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c3db74.050a0220.3c6139.049d.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/infiniband/core/device.c
checking file mm/slub.c
Hunk #1 FAILED at 3957.
1 out of 1 hunk FAILED



Tested on:

commit:         590b221e Add linux-next specific files for 20250912
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ed48faa2cb8510d
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17bfe934580000



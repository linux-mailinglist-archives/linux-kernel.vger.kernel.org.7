Return-Path: <linux-kernel+bounces-876511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29659C1BF81
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88CA050779F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B04432274F;
	Wed, 29 Oct 2025 15:25:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710842E62D0
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751507; cv=none; b=eANCr+QWdK4+hTmzk1SonrS/PX0RGLte+7Zov0ZA3dyD8eHsqwIKcM7W/j6qj5m6oZnvUKwkb10wNJA+dtWY82/eL09NtqwdWERub4mt/Rtaj7afgQDRAlsvv98idROPZlOWv6tpHskxlUp1ZhD4I/kYrtX74rjeS0Y8WGRCG4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751507; c=relaxed/simple;
	bh=BIDuNTs6VNp0C0pR8Nld8l+uQ0MUrN+DfSXrFa7EJqQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g3X1wM9EIw7pZ67+7tVlIeHZv5Fye5eca9vnVgCCYZBjOKwFnX97qUrKmRyE/cK77w799DdkCZUT96WipGaBr22M6Viss9ogah+WzvkqbNZv9SAuj0B4f94rWAj3Gonc9DwoYZIhykil9FHMcG+0JFzBaC+OTqenwEwa/3oCwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9447edc234fso1481754039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761751504; x=1762356304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GdNNXA7hIFtc/08XHpURTKdoG73Z1EVE+jQyA87oc+4=;
        b=GpvegpbzNBNjOMXM3z3kHoXa4XftOJl+SZS0hHTx0KDK945H5Tmf/MTtnxQCu+Ngpu
         l85nBW3YeP5IDcmmE+yMeMCplq3V28vzqvh/vkNfg0JXvVinJWKiHvvgNqbZmLN15dr0
         ItHHnj1PdhVMeinfhTnXkWKPAmMRIHT+nXREIYtt7sGDVUj8On1BTPqZxaBY4C7UMEOX
         gjDlRKFIlM2L8ojps0ruRhvbk/ai5wMKrGVbq9dYryOgBQFdnEasvVGzhk4NvCzST0sl
         6MHsCFhpajehvW/jrliaKnOOzlDUcAOhIKVVHhjvqA32SlSPn7G62iFsyipnuVx0QXZ/
         vjdA==
X-Forwarded-Encrypted: i=1; AJvYcCXvEk6fQ9YFcdAgASWBD9WSGjmWjrDvnZU1uN5uxAy9c+/Q+/IuU86y+UFCGxwnKIAwJvpoD0plMenrClQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDFHGF+vwYI1tiOtOirw6Efzqwp0zQVPKbJk/KaHvJ4Asc4cdi
	+qeocxPFhAMnmtSsh+m40odAEluWHAEqcyWt76LoPrvI3tFAiyoJ7z5JLDvU3ABRnFQeNoQQ8xD
	mCan7uWjUYjL5SjfFB4+iJJrYOBUJ4TC6IQYhF1IGY4wubZ1O8ez+lk4C900=
X-Google-Smtp-Source: AGHT+IGcrRj1a40t7VFps9sFOUdsN/J6Oj7GLnM5ElM3Lo6FzZFl+xPGuLrG4m7/dEOKVlmj8SbJH85A8UcZ8PxkvskKzoJRRKe7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2487:b0:430:c90d:10ae with SMTP id
 e9e14a558f8ab-432f9092a47mr45041775ab.32.1761751504435; Wed, 29 Oct 2025
 08:25:04 -0700 (PDT)
Date: Wed, 29 Oct 2025 08:25:04 -0700
In-Reply-To: <20251029062739.WT_1W%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690231d0.050a0220.3344a1.0424.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in __ocfs2_flush_truncate_log
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com
Tested-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com

Tested on:

commit:         4408a3d6 Linux 6.12.56
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=117e3e7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fefde68860cfc8b6
dashboard link: https://syzkaller.appspot.com/bug?extid=4d55dad3a9e8e9f7d2b5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=156bf614580000

Note: testing is done by a robot and is best-effort only.


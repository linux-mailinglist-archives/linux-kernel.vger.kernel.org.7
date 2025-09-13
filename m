Return-Path: <linux-kernel+bounces-815046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7381AB55E8D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 07:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B8B584D72
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 05:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFBC2E2DDA;
	Sat, 13 Sep 2025 05:21:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F38C1DD0D4
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 05:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757740865; cv=none; b=PQayjyjDNVWj9XjJI3YCR/1sg7eCpUAAPfeLCq1BxIMpipFITchNl4+GVhgSdl9V5y5KuODK/i39jcQuCdCalszhLoqYQ+RTXYm3eteTynaaKrX4d3ikQF9wtcSa1allNGsR2sM7Hx3Hc1IsPhI3JnSsaEGNW+RAH4enqhRFgI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757740865; c=relaxed/simple;
	bh=Z7ZSR9EyxMMQqeWQt+m1uG+wIRg69Q3hluxN2EVzIjw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mGfG6Z3zmfiZikHXux9nuiRgovqhaILXgdFhP91hotSzMgrGcjN70Rl7PtPZVQbUu+UhiERQGQoc6XK0EfBc+0DJqjW2yHK7F3hGTAHlGnruOwyymM3gsyeF+rRP3Xb0ow7tiUgmPYFcYtkiKSR6aZMs/FCZ0D+5L0Uoez6OkXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42218094a8eso12272295ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 22:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757740862; x=1758345662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhVvbU0rgso/JFyAD4UWmIENdtWehkKLrhixk+g849k=;
        b=KxWe9OJcGiY0h85Rxy3EDg4rSaMAmAR+lQTo/3diomiOm0NIpsh5mOgr1mlwEPQi8d
         KnZIVDjiWU0iHqK2E7F4qocn6SFoIO9hA8i+ehn/Gs2pqCeg4/4mejjvqcUIXbGegsGr
         jpIQ+IAoSNhFbuZuYF+TRL64VSy1i7ZQAapcnVihpWNQrDabJoDH+B9QbQOc4VZZO3s7
         TmiEULtiiBJk0BJpf20K5TBxAJtCRfR0qXdgTriFktmHYJMpggySyEvIsc9YF/1l9ASr
         SqciRLsQkSSmbzAFvBUU/yd+BSvUXSuIYBEo87omfOvso9WC+oh31KtmxAJzzXbKrImc
         +wqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWur5g9SyHNGYcaieeOiMXfuw999Hy/bCj3xuvSsgavQQVM9m+rS50eJ6X6yg32p3rNjuXfLdG+3y3XL8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYOgWl8DHLoUusIj27mqzo+W/VIP7yzk6/A3Mq0FiIbWOfOGPP
	IvWlBkX5p/8CHFbLjTCXdVHIZGBMh4vQH86Y4v74Pw07wtzl04wJseogKZYeN/ZXJE70MTbopW8
	FSqtOOV6Pzt0fomHKfnhHDtA1pTrKSD6qB0KkBkcwsI5RkN8LzP2nXREiNRk=
X-Google-Smtp-Source: AGHT+IHmalwVNUIYg5Jty9WvO/kA4KZwg3TMwEbqN14D3a0FhfM1W07E/tEu+WGpMSGNALq6IpV2HBruPX7uYGr0i+2BrWe0eH1i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1688:b0:412:5782:c7d2 with SMTP id
 e9e14a558f8ab-420a3025fedmr64844095ab.16.1757740862647; Fri, 12 Sep 2025
 22:21:02 -0700 (PDT)
Date: Fri, 12 Sep 2025 22:21:02 -0700
In-Reply-To: <41049daa-ffa1-42d8-9935-c56e02344afb@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c4ff3e.050a0220.3c6139.04c1.GAE@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-out-of-bounds Read in change_page_attr_set_clr
From: syzbot <syzbot+e34177f6091df113ef20@syzkaller.appspotmail.com>
To: chandna.linuxkernel@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file arch/x86/mm/pat/set_memory.c
patch: **** unexpected end of file in patch



Tested on:

commit:         590b221e Add linux-next specific files for 20250912
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=75c8190df02c3a12
dashboard link: https://syzkaller.appspot.com/bug?extid=e34177f6091df113ef20
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=119f7362580000



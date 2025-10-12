Return-Path: <linux-kernel+bounces-849473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3B2BD032D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 16:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDC63B497D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 14:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805A127BF85;
	Sun, 12 Oct 2025 14:12:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24EE27B34B
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760278328; cv=none; b=DRrm49ivyIFNx2CAq8AkGY0EKJsL1vIoyB41EBV+SbkOfNjSBXe8oXSrc9Y8nvao8teT3NCqd0EPvliaWoYxtjc6AtmnmIQd974Y+DNsJZLHoFtWU2q8Imk8fzh+s9j8E9YzjF0YzN58x8YYXZStzcnXHC6VlnQdypM8z5l/96M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760278328; c=relaxed/simple;
	bh=nX4O3uUcK6ZipMLDSJkzeCTn9A9UVfoPzYGFK2WE+9U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LhvCJhUciwXfw5CMMaUwdRaEeX8/6g+bZicU8dlMj7yS6WHSts+N5YD6CKe+GZWC/b7mOAwPCFKY1By4XvQX6+qePEQelhMKu+PM5htsbgG36KSywgDXI9IgBkcI9WVhblXmdjRKR8HS5zryWdDNwfAWgQVbktVkwF4aTkV+inw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-429278a11f7so101053955ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 07:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760278324; x=1760883124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prMwi4/uP8EjOJSzZzzk1SRjOCYQsn3DcDxJQoB9hfU=;
        b=tOSgQl4x+/FJeXxg2/fcQo5q9VknfsI8yj/2KW0ZxT+vVrTF3/ZktOn3srlUUubZhS
         HIFK3EBP0VsKYXNzdzsQgJ/QRn7ufS50Thzo99HgmW3rbBioRZ6OSO+32repPTLEUxyb
         cs/xG0sj8yqjxTACFXKKWFfFM8cmFCmaBMA/j01J5CL1tmyLogeGzHlVAe6rfuiwZ1Ef
         KFVbC+plApZXhUOzneHkBbLsRETP2F+C/u51NpJUAH3QieiyXuGtfEMRYiXtqxuqlBQm
         uXUPYRmlSabMgcKkmi/SXPvEoQ3IdRcKvjFO1vUD+rFjbIXXpAXr/DFIBlvMqTqpcHWg
         6m1g==
X-Forwarded-Encrypted: i=1; AJvYcCUjCozQiFaZYtQ6I6hhTRGDUPZLYejdTSVyv5tqcA0vuHUeocaFclWp67KMHrmRt6IBqIA6Kdjs8z90wRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyaXJWHYgQ9o6TM6MsJ2v3Vkx283+ToS67qeQskYlyS5nzFS/G
	kA6A3uFKUa2Cb5WxbUeHCv7RA5Eiky1Y74BWa3P4jbz/leQmb+SONJjjq5E4hlbUgO+XBSYlMhi
	FlejLBNZAATKDtrphUaHuYZaLFZhZPOXdjcGSz3cjkRl7MZh7Kr5mND1OKmA=
X-Google-Smtp-Source: AGHT+IGzbG5MpmQoIBWocJW2Lx04LONWJicVapUWVT5wTbqeqteULZY78fAcCAmAmZsonu1WoNoEUJi5OqgXLpPRlJ4BRr67lOnQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0d:b0:424:6c8e:617f with SMTP id
 e9e14a558f8ab-42f87368781mr153050785ab.8.1760278323890; Sun, 12 Oct 2025
 07:12:03 -0700 (PDT)
Date: Sun, 12 Oct 2025 07:12:03 -0700
In-Reply-To: <20251012135929.59982-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ebb733.050a0220.91a22.01d8.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Write in __bpf_get_stackid
From: syzbot <syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com>
To: contact@arnaud-lcm.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/bpf/stackmap.c
patch: **** unexpected end of file in patch



Tested on:

commit:         67029a49 Merge tag 'trace-v6.18-3' of git://git.kernel..
git tree:       bpf
kernel config:  https://syzkaller.appspot.com/x/.config?x=412ee2f8b704a5e6
dashboard link: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=102629e2580000



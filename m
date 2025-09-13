Return-Path: <linux-kernel+bounces-815338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DF6B562FE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B019D3A7290
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8899D261588;
	Sat, 13 Sep 2025 21:00:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BEF25FA34
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757797206; cv=none; b=TzQkVgAs/TlrOhS2txk7rFzwOQItOGvw2hORNlpquUDjPbPPIGYuUcQt6tx1l3nZsr0rsvDfft5dZKjsFtowQsanhriBro4XE8qiGmZT8ZccUV+5ruKaqY200OL0xiJ7oebbRD9Kz82RQ+fIpwaeqPUNBMscX/xWipJo+xWEXWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757797206; c=relaxed/simple;
	bh=jifTCwBkORPS/enD9edm0+xaKvK/f7GQnsAcoH0+wjo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C7f0O5sR+IqUS516mbJWUHmyODPOqSEUavMvRyjI6NueCEOHOs0xHdD2Zt7sIFWPBASVQ4lqIv8vdkrbk9tboev53Qoy6536b8MowgEDBi+hheIFV+UTJtwz0u+Dfgd+Ypb69iidlH1egstcWvs2Rb5UHpkWkhnYQ1OiOEK9XAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4155725a305so41374725ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757797203; x=1758402003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VlBg8o+Tai9mo33uD6sxgovpORvE3FqxfBAMg41+DxM=;
        b=GQ73xKdjWSETEc1UQyJr4ulAMJJH6Nim2wj+NV43NAr4BsveYB0bJwPqdBvQ0z23+k
         NQ75ew/wdXQ/fQvh4EnCnjasO3k8QYpAvi44fCbWAqrqWxRz7JIhRURdDhoianYMqWEO
         E/tNf9Nz8eHC5Q1SQwsjWvZFtqx2IaKaWHuzmpziDTBb2aPIpuVBibT3fEo7uK++jd1c
         icuQ8UOH/OmfvJ2FGXOO4NleD7ynKx2gRbh3C47GWqYzfRkn7e1gi7mbfs1WaqzTezAS
         VVu+h5/r32H9ErX2g3CcxPmIsjtr7VIIc+R2BFeTHejyhvWeTz538c9WdstO72upp1Ki
         SuHw==
X-Forwarded-Encrypted: i=1; AJvYcCV84TyW9g+khzcWNv8Qh8iU7FYb1lsZh5C93wb/bsNeqJiJ5O796nBKXjGXVs+95fs+a5igF37etFSZGIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJAslc459FqwVnLPTDyk+HKK8YmfPcgdfGtVW9sJnre+bp8HQG
	eTexCc/+dCH+L17BfjC0xXVNPtbP0CMF9nXc3oLAYgaN9/eSPbwH/rkUNxwB4S6a5JXulW9lw8O
	IlCCZ3xd4yWwVGUbS+fInUerCmXhCBPWT+PfrVUrLJamzwFiuixxabeHrTCI=
X-Google-Smtp-Source: AGHT+IGjqSXRvcm8tA2VR35RajdgBptmM4ZiCqmNTer/mB7V1E5mHLi0i39/ssN/n6I+RUU+2iTVtc5yORsCqZkTNCEljrvOO3fC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fee:b0:3f3:4562:ca92 with SMTP id
 e9e14a558f8ab-4209e64b9c7mr97046145ab.10.1757797202826; Sat, 13 Sep 2025
 14:00:02 -0700 (PDT)
Date: Sat, 13 Sep 2025 14:00:02 -0700
In-Reply-To: <CAL4kbRN-HXg0tLqMr6zkXNgoTeVavtx29w6TG5OZu4uaVd68eQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c5db52.050a0220.3c6139.04d7.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check (2)
From: syzbot <syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com>
To: kriish.sharma2006@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/bpf/verifier.c
patch: **** unexpected end of file in patch



Tested on:

commit:         5cd64d4f Merge tag 'ceph-for-6.17-rc6' of https://gith..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14060b62580000



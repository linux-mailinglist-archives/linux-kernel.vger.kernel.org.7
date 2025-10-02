Return-Path: <linux-kernel+bounces-840682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DFFBB4F67
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB00E3AD0AB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 19:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5F8277035;
	Thu,  2 Oct 2025 19:09:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758932343C0
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759432148; cv=none; b=vEN5lDCL3zIn4A4ZZfubCWxdhQNJuitHKIR8RAVzx8+sQAKKd1/xwzvzfynnW5ytRHhSF0RBYRT+0p5Yrg6qzQJPj193IneQ9GyqTitGOWKyOXTp0iJ+flz92Mgvj8bWbc4e5XtJRO2HZHPi8TDyypE5eQZuXoX82Fz5GLOltyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759432148; c=relaxed/simple;
	bh=mqYXv/Pm5e/+kCmXUVcHua85Ux4m3J8pL3ryhfuDtTw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aCEEj3d8JcI8VdqhPHW5nUbeRU9hBrYHATogdzA9WutZ9EO8Imb1a259DZWF6O+HsSWaHVGVNeL3UGOx9+VWGamrQ5P97yw5S2C9nmQjWADjLJHncRW9nMMAGNtID1K4mLRI16KoK9xMN1tR3ntJveRsO/s4qYEvsxltPGQ8Hpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42d85031919so19322275ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 12:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759432144; x=1760036944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv108VANLlPT1BaDVn6iMwG6M8LmHtYm3+Fi//cthvI=;
        b=ScYM5UGQdhRsoMTqIpSL9SuxZRJMOsSjI/C90mEhEDyhy1YBFz+sk84dToQ0VNF6/8
         P6DyknilnDCV/E6wvwCzmKBk8UXiDRJmb3Hnw+I3squKsNO+y2LpEIZRrFomdqm1wWnp
         kKbLYq7MR4v5MaBvzJG7qmCQ/zNK4sh859dD/ODIhYiIyK21r2KKHJjjE7t2ym9u/bA8
         Y+uhSh++sbKF6Vk53v3d0boX8cHJ1tuKd5Sd7m/PZGKG7IVM54cG9QNUH+dZs8HmN+nI
         jV+OflULKaecPa+KiRPY+9Lyrwuqs1iwh60odyqDH8YKRREAtluZmnOEBh3WwDB9plaE
         oS4g==
X-Forwarded-Encrypted: i=1; AJvYcCWUTpWY59hWS8cVTUDQ44G9D8BAVORRY96BYrKeHcnbpX9GoCiYxYIbIhj3XAr8U2SeLM9lOxAp/pwj/Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrDXzuGwVSLKsMvYVStEBousJqeBs5Y6QVACdJpN93ot6WHeLN
	L79vrv/FU2V3ojt/ogQpnsrEMJFkqMB7tYj7kPV5Yc7zcZLcREW96q6nyN75Tv+gUblbklvCnqk
	3M5di4TmRgdV9pfjFwU7NisZQeL+pol8O33cmPwClgcUTbJAz/INKT2kmaoU=
X-Google-Smtp-Source: AGHT+IEqUxiuRjUPjQxHv0+dxV+ujr33TW67ndKmMql+Cj2y7JXY4Lyw5bYlnDZJZpR+yp8/0DgomTfdR+IT595zFdQ1SdUEbr04
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8d:0:b0:42d:84b3:ac43 with SMTP id
 e9e14a558f8ab-42e7ad049fbmr6988885ab.2.1759432144562; Thu, 02 Oct 2025
 12:09:04 -0700 (PDT)
Date: Thu, 02 Oct 2025 12:09:04 -0700
In-Reply-To: <D66CC340-262F-4CBD-A64A-FC3D809716B7@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68decdd0.050a0220.1696c6.0033.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
From: syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, jane.chu@oracle.com, 
	kernel@pankajraghav.com, linmiaohe@huawei.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mcgrof@kernel.org, nao.horiguchi@gmail.com, 
	syzkaller-bugs@googlegroups.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         3cb04835 mm/memory-failure: improve large block size f..
git tree:       https://github.com/x-y-z/linux-dev.git fix_split_page_min_order_and_opt_memory_failure_v2-for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1428cee2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=714d45b6135c308e
dashboard link: https://syzkaller.appspot.com/bug?extid=e6367ea2fdab6ed46056
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Note: no patches were applied.


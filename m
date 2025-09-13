Return-Path: <linux-kernel+bounces-815370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBE2B56359
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4213A74F4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE2D285CB6;
	Sat, 13 Sep 2025 21:47:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B063A25F798
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757800027; cv=none; b=BkAR13vKoFxs2eCnWtppAOkJjDCx9w0MIgDJwifg/p3uPzDsvsVyHbqmsi57KRVZJw5W4aqIcf31Eil1clJ9WXDE3xlMhpeUU0PJBsGJ4PZtGgx/APXLtG3JIS/YxQ9APBJ7QPRRNqAoGEWqbz8TPp0e7OLlCJY7uGV0Ns767xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757800027; c=relaxed/simple;
	bh=taWYK9tUaLyNsBGFCIIYsAPds9jUyLKBfESIiPEB7GI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WW2QZc5s4SImD9jKayfeq3VBrRklouyaP3P6b7ykx8Inail7IgNBeqpSDdBdZYyErB6p5Yy5Qszy3TNqS3/f852M6f/sUSj3qctS0a4InZD60NkK+O5x4z9RxXRHWjMCKyYKIVPrbWeP9BdwMVjh/NN//hjksX1j/KEnsspZCdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-889b6f1d015so274783639f.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757800025; x=1758404825;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAu/D92jDcDTRnJpyiVZ4SJbpy8Pk4g+knKbNK+y1Mw=;
        b=DRajzli/lHjQzya3NJmh2Yj5iZvvHV46FCyMha0MG1Cy2a1BvMG+A0oaxSKkXwcMUd
         YSJ+NvJ+MBtVPlbGKETYzwxBwRQPnmAulyll5NuVCIE2zXXYNHz5qBC/ay43AZH7QW/S
         8i9yHR0yCdCY52XFoT0wEhYbIsmt+9kfxxcsrYUE5BGvxK17vd+JgH1YVcqMZDakqA5q
         EWGEgW4cIuMv7j+c/Bgm47OI2Q8xCF16l+qTLr7i8WGPnkjMmRI1mVz/he7VLIvtssgT
         XCwPZWSEbCrYGqoLN7i3B0EV3kUFE62aO0Ry4QcEUPdLQqBzlLkvU8H5aXOABI3Q+LZF
         gwLw==
X-Forwarded-Encrypted: i=1; AJvYcCXzJ8gfd0LKcBRAFrU7O3e8jphlXdFaXSup0rGsAJodWNnCq/QW7K5s4VwUkymZhQ1AAfVdiFNEnbEd6xc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0E+5kjXKxCBf3Zzzg42lcdUVTBOXceLwQk1dZsEvuOQWz6NTU
	UVqLwZQAwFWBvVLV5q7Z8+0hcFaZ4lTBhZuOF5XQhxhr7siubltqkztkiFOW9RpdIPm6eTBYv5U
	xviqYmj7KxYWj2ClfPa0GwVcwwucie+H/ei+XafFnnpGh1I3YHnenRoO93QI=
X-Google-Smtp-Source: AGHT+IEcR9suLo8+rDH/4nRNW2AkJHe+AxN0DmyOWEvtJNrjkzR7bn4jq5YAm3qMqSBAKNH1bj5m980fTrSjQmF/x/iEOqFcWSv8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168d:b0:3fd:96f6:375c with SMTP id
 e9e14a558f8ab-420a52b8780mr91383405ab.28.1757800024802; Sat, 13 Sep 2025
 14:47:04 -0700 (PDT)
Date: Sat, 13 Sep 2025 14:47:04 -0700
In-Reply-To: <CAL4kbRM+2Lch=Gi_3yo_xAuAbz_2-2byynUk8ODpUFzhSo33Nw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c5e658.050a0220.3c6139.04da.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check (2)
From: syzbot <syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com>
To: kriish.sharma2006@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
Tested-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com

Tested on:

commit:         5cd64d4f Merge tag 'ceph-for-6.17-rc6' of https://gith..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11229b62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13b60b62580000

Note: testing is done by a robot and is best-effort only.


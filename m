Return-Path: <linux-kernel+bounces-838405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D94DBAF1B1
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 06:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE027A927F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 04:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEB928724E;
	Wed,  1 Oct 2025 04:51:09 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342AF1D88A6
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 04:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759294268; cv=none; b=h+ZZEPnj2DFz3xdzlc2A99VR3wKHZ5qhvc7/qK7QR7W1oAsT0vj2QVLr2MgJdNZ80Xso+YiabyXSs6E56mRK5zGWMhcDqnQeNACtyIrk7mB8Op26Cxsxizb8F05NmXC5frGOBp6juFCN0818n3Fxz1YlEJey9KKlb6h/+vfPr0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759294268; c=relaxed/simple;
	bh=O7q9AfBR3K2xu57IGg/LdeAF1qY6d1V+X4gtqNtgmn4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hn9Wkt6omMG9YE5hhLtLZZD/LqZj66ox1DTQR1kMB34cWPfty2YoC7hxuKFH6vhwO8uo+5A2dFZZUVGhmvVaBo5a5e9B/syymTQFHOUjVcfKjEq0V9dXUCsb7oUvM2X7JfUWzTCWduLNrla6ACAtHtvXxcEdGMlv1CjzQ4vr470=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-91b3cc5aa6aso860001239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759294266; x=1759899066;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAhA4miFvnKiMwYobzKIYJ1viibUSiXEfKDDH1S55ek=;
        b=UTMl02XyxwJ0BZ86AN43ry9rC5gkrL4n2QUeBefo7xWxODZLi/2aZGaJdvau2nC/kk
         zMKjP2FyHTes2N8VQfPGGSy8EUhi66xdLb1zLVMH7/LHn2f0b9dBH5Lt9wuN93dlS6vh
         YtNIVf2RxgsJHOHwFEctFwkOJTAH1BpEQVPNczJPHckqQiICACZmlOq88SHT8BctZk+g
         /oqKg0pEjhNF6SxYhuXcOtncOlQ0H78kxF9r11Bi7JfBtpJzBmSCgoBPj6FBp4VLh9oc
         6Glalgu8MO10Oa+/Pg36VlxdOXswIJXttR1rnKH3jV3xDCee0Ij8AnD+GiqOjlV+QCcY
         MQvw==
X-Forwarded-Encrypted: i=1; AJvYcCUo5xg13+XQTjlcvqna3XCzNh49CbCyYoqomUFFvilAlr2yx+Vvccq0FjjCkzqxa7z29rmu/KwATfnZsf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUCausyDVTVT9bbZTU1Mg0o9RyHAkODGlo1TfY9Zq1E8iQel8t
	hWSkISdBaDjBj7LbaX7xQZtDeCND5v+cIcZk2c8aa9L5mmw/77ZRwrsDe1N5k9OVnpkWlY72f5G
	GXzWfl4nhrv0K1s0zaqV48jdnKDG4E884PsiekQ5KB9B2pP2nMxFgt8C4K3s=
X-Google-Smtp-Source: AGHT+IFpxkpfvuq6u6Pm400EcvKPujEmJQ/w8z4AShfju1LNpMJ5s6lt4f2ylZv7zDcHLjEUmHnp7/zBrytIBZr6t8Ia+WLR/RVh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4a0d:b0:935:a475:d539 with SMTP id
 ca18e2360f4ac-937adb657a7mr362933939f.15.1759294266280; Tue, 30 Sep 2025
 21:51:06 -0700 (PDT)
Date: Tue, 30 Sep 2025 21:51:06 -0700
In-Reply-To: <7F95F86F-F002-4CD1-A5B2-4A261A9D1317@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dcb33a.a00a0220.102ee.0053.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
From: syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, kernel@pankajraghav.com, 
	linmiaohe@huawei.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mcgrof@kernel.org, nao.horiguchi@gmail.com, syzkaller-bugs@googlegroups.com, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         d8795075 mm/huge_memory: do not change split_huge_page..
git tree:       https://github.com/x-y-z/linux-dev.git fix_split_page_min_order-for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17ce96e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=714d45b6135c308e
dashboard link: https://syzkaller.appspot.com/bug?extid=e6367ea2fdab6ed46056
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Note: no patches were applied.


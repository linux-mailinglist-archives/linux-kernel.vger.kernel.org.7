Return-Path: <linux-kernel+bounces-838333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C105ABAEFB9
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B12FB7A7854
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8022E256C76;
	Wed,  1 Oct 2025 02:06:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDF625487C
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759284365; cv=none; b=MhH58m7f8Xu4k44a9dIFtNtQIvu+OTz+4/xAjw47D3c7r7SnWWT7Y891Exk2SObDbizzcyxIAe0/jX0Fy7tYO9q3tQ+mkSAQZ0afT8cUM+ZYOZ9e+i2BdpIVjx9H6pFE+ibjLAAjeIVraf2p1oST16XcTtK4Su8JYtohWLwBvWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759284365; c=relaxed/simple;
	bh=7arD8TjWkllindHUqHVIO0cwFY/HqJGz+TjX45K+E1U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tRip+vlnpKi9cKNCC2Ss5KF2ihCQ9Rv+ghHetaXJIZp+oD/o/+Pppdfn8oHh2hGaRAc9uHaaKhMgiRd6O5F8opnNbSh3qBRc+aV7zFTn+lP9KTvGCWS+xIOTb1XIddMYVKoWNKX77hAn0vlt1yIVBGoo5NqvbM3GsU1KFMMOqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4257e203f14so201639445ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759284362; x=1759889162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avuY/grDPjcSaG9OY3LwxI6lhVsDwF40vTYHq7elNVI=;
        b=AE9kscyf0cg4SbnGjpIBGUc7eYgXjoa0Wcl4Jv7CDLGOaitmpxY0X2+v98oVfuu1lk
         pTP5FD7lhw285fcCSQt5s3YiXHhsBoc5OIDeim9rG33nWqiXRATspPZNHXNuhYjTOhuH
         P8FY98Jpr2Egwe7kRyh2KHEVvOXUk8E/mZVrWutyiwZL1O8aObZBupkXJEVUkO9UAz/a
         Xzxqh+CsYioYmaYQ3DLpoqBgHVMdQLMlawoPon886E4kKjKZWiyT/FjPhLf4+XZoZhvO
         B7IWeY5oNAz2z+3WdhP5Uwgi4o+uJyS9O3yfwO9XQinMCsRCbzRI7cdIegUyLJ5cxQ0g
         TziQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYBcZhVF76ErfAufIlTXxHUiYSnb93h+jGPyZs6o0Agjc4BKJiQkRvtb9jrezle0nAyTtCh40XfgY+IdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+BEIqmtpRvD7XeALRieEw4p7Wgzposw+qflDdUAPogM9a4fz+
	SwBARCoe9gU3bBnPdPiEFj2LS1O2X3dn0TUk4Du/pavM2L8fYlzdEKqYIj5kLAM6dP5G+L3f6hG
	3/D1oj+6VkcYyForuzq1hTUPRxUQYfkEZpwkNA8YyzuChgAKj0iSviCtoA3M=
X-Google-Smtp-Source: AGHT+IE5CKKqHJWcmhrOUhOsjhSFX206AedHyCqQ4RFy75BmFKeNe+/UiRWxprils0Bq2ju02JqzlLFPv/dNsI++JwyCd3CwCaJz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180b:b0:427:d82b:1f36 with SMTP id
 e9e14a558f8ab-42d81661fcemr31220135ab.32.1759284362677; Tue, 30 Sep 2025
 19:06:02 -0700 (PDT)
Date: Tue, 30 Sep 2025 19:06:02 -0700
In-Reply-To: <C7CD4DE5-1C8C-460D-BB9B-1A11C8E038C6@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dc8c8a.a00a0220.102ee.0052.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
From: syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, kernel@pankajraghav.com, 
	linmiaohe@huawei.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mcgrof@kernel.org, nao.horiguchi@gmail.com, syzkaller-bugs@googlegroups.com, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git@github.com:x-y-z/linux-dev.git/fix_split_page_min_order-for-kernelci: failed to run ["git" "fetch" "--force" "c604b0b58bbe3045b4698c8a85066936c1abd842" "fix_split_page_min_order-for-kernelci"]: exit status 128
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.



Tested on:

commit:         [unknown 
git tree:       git@github.com:x-y-z/linux-dev.git fix_split_page_min_order-for-kernelci
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2ae34a0711ff2f1
dashboard link: https://syzkaller.appspot.com/bug?extid=e6367ea2fdab6ed46056
compiler:       
userspace arch: arm64

Note: no patches were applied.


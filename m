Return-Path: <linux-kernel+bounces-867522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ECBC02D51
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FEAA189EC78
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1577334B407;
	Thu, 23 Oct 2025 18:00:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D859366
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242406; cv=none; b=TTkQDYfKSY4X022Gq0knfSmmWcbK6eUYHbfg7jdJ1HWZivkj76EJHs1kICXPRERszfTU4AZA2yRdp307nOh0RmLMg9S9K4bb+cqYXjY+fBujzYOTNga48zVPG5LqNQV4TJ6X+07VBPI36R9wqQbxPJVfO5zHqK24Gu+lfuljGVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242406; c=relaxed/simple;
	bh=SIAHDuQwqCHG7mRY0wQ2hZmP8CW3oltIBGgtY+LIPBs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QppL2tdC1b7S6AtFNlbqPp27R+JwH/7TZp/x0eogSDNSkEZ8WJQ/lY2E7k0uLRnPeue+9j11jewF8w1JOV6IyoPxvPpNuAT0y5bZLTrT/rMKYXh2CXV4GQkXUbRW/TJkotR5KyetnjlkdgRBNUUKq/eZNxZ1LhHQqa1ebsVN5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430ce62d138so15782725ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242404; x=1761847204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plugQhhT7OxU6L7kM+arcDDkjGn9Md5YNuNmnuapfPI=;
        b=XqJgBopGzZ1WaY6ZFg0yjunXmi4HS5S7wtMnNFMg0Kkk02Rw74qW0vTjyNNgUTh/+C
         LxNk+NCCYVkTQwtPwjSEQu9greZDIpDMOeqS37cr5m3Bu1olpVPqBdfzd/CYnsBadftj
         uUWY6s02ev070rVovgAeF3DeB38sDkpEzYMbIe0SfukN2+5/GFGkgEQIY2G51e+7EVso
         En8iXLU+/lP1L9t8QGmxkgL9Lpnt5XEC5eYN9spwGeIVE8zURFbhiuQihjMeDbGgAGiR
         lVsEby94FwAGPs3ghf7CY8aP6I8f3mjDZS+XiFT3pm321IsQxld+v9X2gqahQONIvQFh
         DImg==
X-Gm-Message-State: AOJu0YyPhyVfuoW6vMc0AfHlXvkHFMg/qY5I8Sy3efv4cG6e3BaipkxS
	GrpxYqttO1RlpkKacyxILJOmHTEVdyMSUxb9emcWT9QCmX/RndU4Qc4S9Fs4tGwB1nl374lyBJF
	486OpEUBdIfvR7nDccSnSg0y7TdInvwxoB+g8/Js3SmZsllEIwXzONn/osaY=
X-Google-Smtp-Source: AGHT+IEazP5lIqQKZujgKsv1Avm14LfddmEZdvSGP9ZEz2eQhv1es6smIBLq1/FMsPJ3wpHOgEUxV7a7Ag70qUIsr6ZPMGtJzDRO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188a:b0:42f:9b0c:cd84 with SMTP id
 e9e14a558f8ab-430c52048e1mr356890655ab.3.1761242404088; Thu, 23 Oct 2025
 11:00:04 -0700 (PDT)
Date: Thu, 23 Oct 2025 11:00:04 -0700
In-Reply-To: <CAMz+-CNTx59R=xw9UQVDUSoE16pqPx3y-EzJT8z0HiF-=qAC_A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fa6d24.a70a0220.3bf6c6.007f.GAE@google.com>
Subject: Re: [syzbot] [sctp?] KMSAN: uninit-value in sctp_inq_pop (3)
From: syzbot <syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	vnranganath.20@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/sctp/input.c
patch: **** unexpected end of file in patch



Tested on:

commit:         ab431bc3 Merge tag 'net-6.18-rc3' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
dashboard link: https://syzkaller.appspot.com/bug?extid=d101e12bccd4095460e7
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12cec3e2580000



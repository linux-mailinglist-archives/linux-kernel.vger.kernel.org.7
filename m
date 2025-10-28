Return-Path: <linux-kernel+bounces-873536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E92C1425E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE83D5E1E00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBC13054C4;
	Tue, 28 Oct 2025 10:41:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C402D73A5
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648068; cv=none; b=P6C8eM1tPN9gRbecWcflPel6n+Msa+FEFz9UZs08nKpe4pKTsYnVkq+3Zhn5cVtsxNr/bvKEkBplCAq8zSNdWk19/3oc7i1H2LrT8ag0rGubygdRjvPUzeCncJov8ciaDIgx9VDkJXHCxARqjvVtIKp6hwzm9mVcb6Y/TbDn1P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648068; c=relaxed/simple;
	bh=PYrtqaXfvrH6DZ6MaeYwgy3Mn+btTcgSVLXwmzgG1MY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QzuKk4EmzrIESTTBGuGYSZPQb7oZnTuZwBi6QhVRk5+gjDVcxkD9uLy/YnJf6VqwJkfJuAU4d/HQPeJCiMCk6y2D+4Ap7aU6IK9kyEIYXojpRAVo5S8K0AgkdQZQ0QtlcSdU5/j/DSkOJGNRIPfOIEXLU+GqyQNyLX73IZHgMNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-9435917adb9so357288939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648065; x=1762252865;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wM1nehezB3MiZMQ6a5dbsJUZHZ98DJNBzALGP8tfn5o=;
        b=Bj+kSanNMnkqOisMvSeNr4NOT8/43vcX9UFlQMRaMcSlMCTjNDjVFT2iiS3WqfiH3a
         llyFeFy6yk/ZoF3qCBZ5J9TplWXXwk7uzFa30JGBa2fCDkw3jcPYlfEOrggw97t5PLzv
         VJfugXty6ossWOX5FYizXPGy81JuG67KIS/9Kw+DDGzjBD7KwW0FYxpYzF7h2/IQsoLu
         YMndrip8HUucCljX/8CVmPFQBI2RkFn6bQ4aIjmmii3s7srKhyT5234XeRyGwUPgFRAv
         dHkTz00IKPedzQ8s8cIJhWhyAGMcnwSzi37uZueieaQNkmzlpLAj+MpkMV8pcxvpGnZT
         gogw==
X-Forwarded-Encrypted: i=1; AJvYcCWfxfuUq6StTUS99idIQ7p47e8bKYqp9Tyk2on1t6b3PUiLVwo5J36DM9P2iBcJF03yOZx4XFeH/Mxlmhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPQkilOe3/9vCqo1rglUJ8I4FTV2AcTom5nkjvQdKOxWNdK77z
	VDFvSLFb3L1W6Qa/zkRxCKe7M61MQq5fRJeMG0QVgGN/C1WoqJixufmHLtc39ooBzxV/50n3Apq
	9pRIfQOeQzOlIf+utIh7OnhNQBx1zQ8JSVfdruk/T4jYAJjxE4YergPAvKOo=
X-Google-Smtp-Source: AGHT+IF38v4Hi9778qSJ32yqzKwkvxCbOUB0dJgCU+RiDaSAzKN5vHncZ/rmybdFxrwmMNjBX1q1b8I0IwCsgAB4+6+xZyI+bzsG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f04:b0:42e:d74:7252 with SMTP id
 e9e14a558f8ab-4320f7aec2dmr44661835ab.31.1761648065277; Tue, 28 Oct 2025
 03:41:05 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:41:05 -0700
In-Reply-To: <20251028104003.Vih0s%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009dc1.050a0220.3344a1.03b2.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dx_dir_lookup_rec
From: syzbot <syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-5.10.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-5.10.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=30b53487d00b4f7f0922
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=134067e2580000



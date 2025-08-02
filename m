Return-Path: <linux-kernel+bounces-754136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D52B18E85
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 14:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1A9166E5E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 12:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB3823506F;
	Sat,  2 Aug 2025 12:45:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88552AD2D
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754138705; cv=none; b=r7Fb9JQoGKVSDJ5e/b5KHqYoheoUjXH9au2DkBx8ygbS6Kk4eIp5fY1oJc/MRuazVUvhNYdXR42shWEWkaIqkh331MyLLXwY05BghgZycOU/QnY+foopFcq2BLkl5HoiFN2HPc0C6rxnY/vUVbUOcTQICNa3VPoNOt4BXJ7K70k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754138705; c=relaxed/simple;
	bh=SSKf9ochg926NaIMYKJMOwzfAGMd7ify7NSmjSkltkA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d/bR8dM5xD7+7A0ohyPZLkV3EH+lNcy7BT80T9gr5iftDhuWjj668fJi9UMh0hHtISyh4VlbiavEgt2TJBJ1tMuBa5RUnFY+5zNynz5v4+JeOVCPGyeWid/4yTjnjjRYXzA4frBPrVXjxv+ob8nzdE/uSzb1PypMxXH1K6RRuGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e3fa175c41so21122075ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 05:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754138703; x=1754743503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCIuUKfq3/TvilyUDQ2PmU6A94OzSpf+0Pg2fhquRks=;
        b=gMIZAWiPECYJRh2EX8h1NWB+mzWoO8OVjkNiLGxR3I3iyH0BaxyqkXSoLQ9SPmRHz+
         3byQ84kcCUCUmmJVe0s63L2hHvkgWCTKs+wI+IeLMEBLOU+znC9BvkA8k6Y63rNNaXH8
         co7Vkaw+vNRfZi+UNrW0U+6AvFoCeRd/cE81+r/8UzVy34Qfg9rpFS/437h7SIgapuYc
         2Q7/x6rSqVKYd0ACLZQuT7aapoqCKkd+DM1cMbbespRUpJBkAQfUgv8k1OuVZUdBXE4O
         24eQNmTiNaedFp+/aK3GsRa+lYGnhz2K4CIOmBGqaelCFOBU81RbJGSjWUMdRRPHt+q0
         iRMQ==
X-Gm-Message-State: AOJu0Yyy77/atf1l/hhKPN/CWbKsZr9HDSt3vraHPtIdkQOueR0hphJd
	h3tPoC4cblqSRiyCOoglUchC+4/asbatZUJUYb37hR3+qeZ1mvzJAWP8GpFQpre0UQS+Atzuusw
	gIylBiXkDMbgH5B6s2uSYABiYT4TPGEOyfYfW1n0KxDjGrlStBw6AW41fhnw=
X-Google-Smtp-Source: AGHT+IHsw267ypnmeNT95owbpnqpw5cufeghSYI2dKjotqSbJ55IeK52x1Qwv7AzvZgt15Yx6JVFNFQDA8GJ+aemr+l4oe1aaT5D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2194:b0:3d9:65b6:d4db with SMTP id
 e9e14a558f8ab-3e416191d1dmr57130395ab.12.1754138702937; Sat, 02 Aug 2025
 05:45:02 -0700 (PDT)
Date: Sat, 02 Aug 2025 05:45:02 -0700
In-Reply-To: <CALkFLLKa454W2SGq3aGY+WxOHkx7bAkVAZO7vpXU0v7h6dQtOg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688e084e.050a0220.f0410.013d.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in __del_gendisk
From: syzbot <syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	ujwal.kundur@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file block/genhd.c
patch: **** unexpected end of file in patch



Tested on:

commit:         a6923c06 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=921f306d77438390
dashboard link: https://syzkaller.appspot.com/bug?extid=2e9e529ac0b319316453
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=109c0aa2580000



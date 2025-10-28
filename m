Return-Path: <linux-kernel+bounces-873163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28549C13499
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A78189926C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFE3221F17;
	Tue, 28 Oct 2025 07:27:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D715F1EA65
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636424; cv=none; b=UTKzGJRb5twgFoXnrxxgB51ZKspbf15jCxiW9zIHTnNgqA6izHbGw2Y6W/ap1NTlvLLV31pqnVU23fs3F1S5AAPvSkNjrhelk9+y135iRlI9wya37zHwDqrILOtxhpMDJpl9kAmsrf+z5bnDQYjhQCXlRdkIfJPK4MpefnejKMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636424; c=relaxed/simple;
	bh=0vYIXc9VqSwzsNjenXbN0TZIuPpNCS28ifXpvtYyOGE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RkcjN440tHmNBeJVFjPc1lEIwsfNwAHO2IwNSNqy3qln+D3I9LUOLrbqbGVJO0aZFUiYF80nH5Hl7DXeWRxGVDT1zzC8s5yhzo2xBJmvh465E5kBkEMh6tWn2aHAJNgYKGoN7y0ho9nFnWHxyTe2H2T8ju2uXiswe6E7L6l6WwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-431d999ebe8so179717245ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761636422; x=1762241222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xnoOb/6gAl/fjy6E3Y6qCDAkwIA162zpzUFco2f5I0=;
        b=o1n/ORofEYHpm0AUSBV1HXeh5f4Q0IkwTpecIIEuLMWFA5Q/QgnU6EK0hlg7SvBjt6
         1ZoyTZQj9fXVhbXkn5xAGbvo7ty8lxxV6T8yAtFrZP1rYgS4PRo8A7aDu85OyFIjSzPA
         lv5xu2m10jy4bNEFB0VPC7J4cdscoB0118SxDSbC80R/HDMgNBj+qB5PhkJmL6ulkJxo
         85KfjQi4bvdcRuG4fbK7QD4simhoE5Kz0LyEabMw2N56LxGaHtHLdTl1jgEQvYSMGgMs
         vYeH3YmdETGrc3R57ZwLypGnzFI5RUVweU3zpwrLxfwz0jb/D96szJA7SNpQKIZjj8LZ
         L1mA==
X-Forwarded-Encrypted: i=1; AJvYcCX5OfUTUorNnXYC+dMX53yjfzHcEaGiJofccQahs53i+JJ2fi6xHVYc7hAAlr6KPJ3hiZ1OCZjHTpFYbAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFvKaOvz8cEOvaj86d6fOQ4byMeJdqB+bQYdy7lUXDZMpm38Xa
	2KIJ3M9FymDr//6U+Tsh1vQC2XP4BTpEjbE+SJL+rDcOU2QVOLhpX0SMgLf+TCQkVl7Xmvmr/Rd
	dorpfCFEDAvcK/7yj5p0Od/An6O1JUFhSRMESuQ74wfXY4JKuT5alNk3wQf0=
X-Google-Smtp-Source: AGHT+IFdMiWzHawotJ08hvAjcIloi7MSRj63t2bqcXQra/nDM8ut5R0SoWUrfdHQHk6e+o0TLHNleB1DTQgM41O+FI4+AaHvzUVD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc6:b0:42f:9dd5:3ebb with SMTP id
 e9e14a558f8ab-4320f8434afmr37147765ab.24.1761636422149; Tue, 28 Oct 2025
 00:27:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 00:27:02 -0700
In-Reply-To: <20251028070215.sc5KX%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69007046.050a0220.32483.012d.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_claim_suballoc_bits
From: syzbot <syzbot+5054473a31f78f735416@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5054473a31f78f735416@syzkaller.appspotmail.com
Tested-by: syzbot+5054473a31f78f735416@syzkaller.appspotmail.com

Tested on:

commit:         fd575722 Merge tag 'sched_ext-for-6.18-rc3-fixes' of g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=111c77e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0fd60646ed018d
dashboard link: https://syzkaller.appspot.com/bug?extid=5054473a31f78f735416
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ac3614580000

Note: testing is done by a robot and is best-effort only.


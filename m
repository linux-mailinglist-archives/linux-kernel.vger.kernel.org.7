Return-Path: <linux-kernel+bounces-733913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9D4B07A93
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626C43B2C31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806BC2F5308;
	Wed, 16 Jul 2025 16:03:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E11273D72
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681786; cv=none; b=haY9xb9nzL2ETCTSqmzhz8mZXXklB8eCSgGZW0UFF066J7pMybV6jolWroQrFa5hBcsdB7Z+NEPB3DfJcQ3UjIHT0I4pIfVQ4SfXh1LJlxFVavHRRpe0jEEoNqMhxw0OlWxKZT34MTreVhkYCV8N5/E1RaLzBJ3Dm7HqrGCYM4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681786; c=relaxed/simple;
	bh=bqxdCCFCCrUXtUxtQnEDsH3+M0HCFkVEGUR5sVHfv9s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UdfwXtMkQwA7aC7Ioixz8fUAruQhEKSpqUFJ9p+WymMgdlYkOnu6Qx3gx3zmWuzvatJLLTmHgHlAyKU8qTwW4zkuENobVBZ0V57Li0Ct6aNVNgrBFpNkaHYR/HUM5MpqnnZW3XIBtrWmKbtnLP6AZnuIKXig5f8SJr4PLAx/HvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86cfccca327so682339f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752681784; x=1753286584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wT63LkXL2c6/5tpyDkEqXffNBUYGB5pqpze4OwQMktY=;
        b=gB9Cx7HoS1wL2iVf0VLrUsm+qYIYb9NJWodeHPWMXizx6VsELexm71G4rnVbmCt9rr
         5wIbKikzUwKThV7zXRCyxgGTct6lES0Tr4JX05RisWZDTkc7E4AVUau2QVBm7VP3rcMV
         oRKTziY8ojO88+M9BbQzlAIzMtd2Ch3/LcbNXmOwD+eXHkNpsf58JW4n7Tdbm4zULjio
         Zwko2pCVYuWODxrEzDBV0duiNjE/1uJNoz0DIZRxVV/iVsbE8g0+C5NIvQJfWPn2DqAg
         W5NH5JTZ64y292GJrMxDoedqPBGcRT1J7HqmR4Rx65x8KeSx7/JugeKjRDpgFVz1cSUy
         /eFw==
X-Forwarded-Encrypted: i=1; AJvYcCUsfoIdLpqwisFxl5JjaXLLITBGpaYPEv9nJmHIQAOs9epBM8jMDsE7dyoXhWnh9EJrsQEAQnpd3pr8WHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9UsbBBm3n39mFaZonA/BAb9cph4y5wtOTJrUSZGd62+Z2+Qg8
	1U/5TlAlvQfb4fOddx/AE/FQ0cIzDOhAj0Nae/NW88IrPmSzgout2jvlmz2avL9kb4oWkVWoeF2
	V2/KAwYWV7r60OpJ4eLERWAvvMa7tQ2D6s7ru58JbSOz+ZqfvR6Mvy7PgG1w=
X-Google-Smtp-Source: AGHT+IHIbQON33vLWsMc15dMXHfcky/HD7dN7QTrQsyslSrLGsonYxe6t5WHvwIbLnaRTLkouGp2cBJJSXqicxEYOysAAwEAYQJW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c85:b0:879:bf3a:4fb5 with SMTP id
 ca18e2360f4ac-879c093a7bdmr468060339f.12.1752681783800; Wed, 16 Jul 2025
 09:03:03 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:03:03 -0700
In-Reply-To: <0591ddb7-d279-4b13-bf2f-ffb913e82720@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6877cd37.a00a0220.105e77.0002.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] UBSAN: shift-out-of-bounds in gfs2_dir_read (2)
From: syzbot <syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com>
To: agruenba@redhat.com, anprice@redhat.com, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com
Tested-by: syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com

Tested on:

commit:         557c024c gfs2: Validate i_depth for exhash directories
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1125458c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b29b1a0d7330d4a8
dashboard link: https://syzkaller.appspot.com/bug?extid=4708579bb230a0582a57
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


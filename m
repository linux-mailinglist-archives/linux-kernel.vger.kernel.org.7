Return-Path: <linux-kernel+bounces-897172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6833C5237B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04453B2193
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0409314A9B;
	Wed, 12 Nov 2025 12:03:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF30E29BD95
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948984; cv=none; b=Udn8hh/Au9dkN1j0RxJoYPHPpy2ZX6Xi6/OOVvRdWw5Em8twUA/Fx32sOtx1U+NITtdViUvSjrUJa7Ygjzi8jEOczIU2F1wQyaJS1Zl0zSWtBw2i1Ta9sDomMo3XQAUZhK8kX/7zPIrj+YzRC4tHIw4TA2tuIBSwQnZv6K7z0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948984; c=relaxed/simple;
	bh=5x+qCRKhUMuMUvqPsT6Z+I1Ei8XJVygq4FgkZUFPZOU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X1b6mMnVQ+q0ayeupp0EemcGFLMRR6rJ6FS6EBcuO0/3jpQYDgV/wY3KK09lByIaM2aYf7+WqmZgkv9Fg4lulbqlqu8XSqDRqYAy50G9N1p8kJBagQ2ZmpIDHT8OPBuRYu6DaJJTqs7d+Yf0zu32GyIIUHd7yCBRe5vtnkACwUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-432f8352633so16924905ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762948982; x=1763553782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=180wEFBJig+I/RsmC3t/es4PE30AJCzYiiRm3nDERps=;
        b=BiOvFXf0GQhnUfODI/G+9xCIQqJDvQngwPQSoRQC07shWH7X41vcWaVx2BDhjMErUQ
         BbGfZplP14SEmEkdlSFw+ErgMq5UKCx83dIn5DdMocBbqzYO0pGSZhU1NeXS4rB7z1EJ
         Rfs3U0hoVyvUgk//H8EdHFkZi+pg+thBFd/ygxqOjVhz9f3yHlZf1O82Duh/tV8xf3Ii
         jS6XcObMb08rOIsfvJz+nwDsMfCfxnjeb35G8URK5GbUtzZwOabaCA9AWEwcLzZ29slr
         bDNaDfHXkJjYWG1hanojSDKlgUe7ozwWFrldD9xNvoAjLKF1dzexyCk0QjgYcbRYjqCa
         gqjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+ROgHfujm/O/e3fk8n4WYkj8H0I07AO2R3mQcMlYPzokoni4YJAxLFs0NbP+id5OSEd0PNVpKtUDYEXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX9x7F1fJkxxmKrdu0JCUF/xJu5YvGhMXjOoixh4lxrkCtlYFN
	NqSLgc6pFKOuQVPt8K5azCmO8bfjHKxi9fC2HbjjLwkvQbwTz1msiVbUa78ou+25qo9AIIC2WRg
	rYxW4xRf9C7m/wbzmbjIjs/C0mrQTJq3hGvo+HY2mv7MEjnb7WGdC0MMIdXw=
X-Google-Smtp-Source: AGHT+IESn+iAMkX6JRfhX7qaQojzwcvxRWKxeFPfpvL0w3WY5ztpigCtMj3SkDphDxM6k43aisGuZPQ41Yl3ZgCMIN9tf53WhRZ0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2384:b0:433:7900:f1c5 with SMTP id
 e9e14a558f8ab-43473cf7741mr36488375ab.7.1762948982162; Wed, 12 Nov 2025
 04:03:02 -0800 (PST)
Date: Wed, 12 Nov 2025 04:03:02 -0800
In-Reply-To: <20251112112714.9203-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69147776.a70a0220.3124cb.0000.GAE@google.com>
Subject: Re: [syzbot] [hams?] WARNING: ODEBUG bug in handle_softirqs
From: syzbot <syzbot+60db000b8468baeddbb1@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+60db000b8468baeddbb1@syzkaller.appspotmail.com
Tested-by: syzbot+60db000b8468baeddbb1@syzkaller.appspotmail.com

Tested on:

commit:         b179ce31 Add linux-next specific files for 20251112
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=165a17cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94a763b28bedecbc
dashboard link: https://syzkaller.appspot.com/bug?extid=60db000b8468baeddbb1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=103e8692580000

Note: testing is done by a robot and is best-effort only.


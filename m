Return-Path: <linux-kernel+bounces-747241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D63B1315A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6613B0432
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F3D1B3923;
	Sun, 27 Jul 2025 18:52:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5F13E02D
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753642325; cv=none; b=ozTWtALRfkUuKW7dE1dd9iF4zj0gI6p88AQvsVjzVXoOybf6D7bEWLFa39yffnwf4f+hnHmT29AEj5rc1PJcJYbcA1qO60NJ9r2zepYCfOrAIItvu5URltwSNCekoxHEj5mcHXt4rS753+ohsfsUMYO7x2qtdIUpx6pAoK/nX+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753642325; c=relaxed/simple;
	bh=wPyWClpHEu0OkKIvF3c8ykkyc6ltSV+aokH2fEs9wP8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rYP3hXRBbUz5848iHEw4sv0Gu3W+kV3JtOR28D5wZTz/cnOmjHde3RjAUK+G9x3IJbg5cL18oZRf5Kb1MWj9KHBUjvxVFoYz/2HNyqVWPgYnlU/DYcX0oPJIMYSoBEca//IVLQDfe10UIfYO3klQaamZmJ8KSDU9y1GWf/EDiZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c73351935so347485139f.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 11:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753642323; x=1754247123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQIF7n64tjh9Q5g0TH3duRoUX54nPd3qDr+PnCdDjvg=;
        b=Sx2/ANyTmamRSnnAJd9zVgnHvCdr/rJV1Z/Zz1lHFGm2eRphBGBY4tcqT9d+G6gTUO
         OKu1yCiVRZqOnaPF7frwTaqbRtdCOgGVbLyMYR8tAoE6Ig84Qm5idfA+ElvtUAyD1sPT
         gaDvKXS0ezerf8qtCYoDGqVTDvnCvCUzx3jAp9pDX7TbWiYfAFtBd981oSvdniJNUaJO
         7qpj6XtfoEspirXP12ph+uRiQXJyDkKffdjQSS3XISNwMn5iWFTS8Yg5t3tCwQmqGMtR
         w+WTX2b9uZnbvy5/6QEBweffaKEV4jSGHe2NL7jfDJkQdnaIEoiuiOcshqEI+QFRxmHo
         G5Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVr65vXNyEIgQQOeAcdLB1F6TsDJqLuBoS3c5LVmDJQGeSvbrBwsAEkq6fs6gYIErxQTGAJ4RyJ6P0+73c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvg5xQjaVLlhUOy2x5h8Lt9apO8SdgQwSrJxcYSIkOulFlA2cI
	iXRuGX9IjBSkI5gKBmo7PosEY77W7fts3lsmk835f8WjBuFiVXA24D6M8XPZpzItoiEtewxyrzN
	HHC4HCCnKsLQEzcwTzstiIqCcmlUDrrMaUddfQkiDGKXPsBV0VoH73IZRC2A=
X-Google-Smtp-Source: AGHT+IHVRTEjBDlMupAstPpa2zGsYrw+8yW4/QJTLbpGwPZM/e6XyhgeaDLq3N1SFma0Xjxf1AF4wxEFSezw8sTXRADWn6amR1Ws
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2490:b0:3e2:9f5c:520f with SMTP id
 e9e14a558f8ab-3e3c45fb852mr156493585ab.3.1753642322888; Sun, 27 Jul 2025
 11:52:02 -0700 (PDT)
Date: Sun, 27 Jul 2025 11:52:02 -0700
In-Reply-To: <20250727181702.32633-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68867552.a00a0220.b12ec.0068.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KASAN: out-of-bounds Read in hfsplus_bnode_move
From: syzbot <syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com>
To: contact@arnaud-lcm.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
Tested-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com

Tested on:

commit:         b711733e Merge tag 'timers-urgent-2025-07-27' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165a98a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77f37fce3464f63d
dashboard link: https://syzkaller.appspot.com/bug?extid=6df204b70bf3261691c5
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=119298a2580000

Note: testing is done by a robot and is best-effort only.


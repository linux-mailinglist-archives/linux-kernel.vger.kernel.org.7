Return-Path: <linux-kernel+bounces-842845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6746BBBDC4D
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 357734EC42A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E35626463A;
	Mon,  6 Oct 2025 10:47:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B34258CD9
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747625; cv=none; b=IH2idGVH2UaFo7ycZx9oAevBoCvOHuMfzaUpkjSJYK1XVjvK3vMudLKiAKG7DiUEVLuudQP9SsjfQmK+eAq2cabyNe3vpOOkmmpXUh9r+xTJ8XrvtJ5wosXq2AHQMJsrVCbjBiTKP3ij//IpiA97mLkYas7VEVS4UJ4t+ydbY2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747625; c=relaxed/simple;
	bh=MRguVoH9xVXZ8xCke5EDKsRyE5O3HLuD7jYGE6bFqkM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jjHnh9KV9CHX5WEXcBZDwXlU7v0VxolBEVioXsim8I1oe8kHsOPHLGLyxGGHr57fv0aXbK01RfaVOwfn+oTSBFycxV87UB02EA/E1Qh0c29JHTJ+R7mhRESysqdW9nEbhVDT2pmZFZvrFxCPAPuGkIU5wFFW9VvCoFfNNzHbMqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42f7b2cb176so91565ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759747622; x=1760352422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YnhgHNmaKn33yO8Yk7hjkUq3ciy72gfjIkejk7N2DN8=;
        b=FAziN8g1HmOS2SmhLgv6Pc+LQtdoDlM3WgIX1huavg/mTrePAsTghIN/v3w4afyAOJ
         YwN5ldea+c2jF1jatusb20krX/UbgatE1K63+StArzBu0n54U4iVCMTtOb45j5YJrEXP
         gcaFMRiTknDeKbwqDx9wwtz4PpJO0IumAoFYZt6Dh7V4FaI8IGmxcd3BhfeQ2g6ZmECj
         ZuQsTGFouQYY7kJxBiLRty8VcrtRyxecjLPj0iRKwiq9Y9/AxIsK7+UVdwbpHOnjEd4m
         mYPczhNE3LPoBEZiJRbUTMSFimEkgXAnWSGrZE5WqHlQGbRz+vEUuC8/1oBsEPRdezLC
         GS3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaQ1Pt3hHP1ws/R9Fg65YRQ5sJN0IvhItcz3S0zf9axWSzrceGnphuXHHmoSGvA2Ih2B54RujSUXjMKk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpFdAWlPcJf1xdvfeXf0M5fGj7jWQd6ieY+/cdzvE1/DVrstwq
	clrsLHI6tPLevf4fUlpX8qCrsO5rQBd8821FKuXv5TBmxFIgg9d6liZAWR66TdO4H4PR59AZIZT
	uCYxn4hhmBigEBfJectnfu+Jt6AIfuqVubuGybC2cI84+7L6WElOu/s7liT4=
X-Google-Smtp-Source: AGHT+IGlVMdpwvaBxkFYUgpvxCjgSFNJRiWa2s5eXLMCmT8Fnhtpp5bUCBQ+kY6C6sIk8Q9NZmshceROFLnHuDn3g/kQzY29Du8S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174e:b0:424:fd76:2a2d with SMTP id
 e9e14a558f8ab-42e7ad8a126mr175026145ab.29.1759747622580; Mon, 06 Oct 2025
 03:47:02 -0700 (PDT)
Date: Mon, 06 Oct 2025 03:47:02 -0700
In-Reply-To: <68e2ff91.050a0220.2c17c1.003a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e39e26.a00a0220.2a5ca.000a.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer (3)
From: syzbot <syzbot+3a1878433bc1cb97b42a@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit acdbd67bf939577d6f9e3cf796a005c31cec52d8
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Jun 28 15:27:46 2024 +0000

    fs/ntfs3: Optimize large writes into sparse file

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=147995cd980000
start commit:   6093a688a07d Merge tag 'char-misc-6.18-rc1' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=167995cd980000
console output: https://syzkaller.appspot.com/x/log.txt?x=127995cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e654219ed2546322
dashboard link: https://syzkaller.appspot.com/bug?extid=3a1878433bc1cb97b42a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104b692f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17962458580000

Reported-by: syzbot+3a1878433bc1cb97b42a@syzkaller.appspotmail.com
Fixes: acdbd67bf939 ("fs/ntfs3: Optimize large writes into sparse file")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


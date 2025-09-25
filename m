Return-Path: <linux-kernel+bounces-833010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C1BBA0FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F193BDF9C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA299313286;
	Thu, 25 Sep 2025 18:11:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71FF2F532B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758823864; cv=none; b=pxT0HXfqtkUQW8lpUAG1zHxaJTFf1Lne9TPBmQpOcwMbWFdwv8vBDIuPlvx8c+zTu3uHC5/LCR/daEXa8MnJfpYIuUDdazcapCsAeIwE148x0/xv4iMKVo+Tz+NgvQje9RFzw6ah3VRxcZElwA7AictORZxlYc3xeYcsftHrFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758823864; c=relaxed/simple;
	bh=1KluphwMLCuewgVUSw3CRvK8MbveYqDcj6Fy65KQC7M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W/H4Lg8Fmfm0zHw6rhTXni55UWeYAHqhE0SEQxxpLn2Y5UNo24k5CNkFhmNghIMOWG+QG77T99oHKrNA5J99fny/xwdnqiAdENI6/PaMbLONlDrWpqtuFM5gzBQipw5+XS9PfUwverJJfhK6Ajqi9WCO2CS4HVNfx0orUk76Erk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-425745467d1so17898105ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758823862; x=1759428662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0imfd9vZPOuVKqBVa4eNQjiYQlE6ICEpheLW0pgY4ac=;
        b=PGG8n8VSm3v0xB/ZAi3bXq6zntraor3orH3Kse40Myd+p/U2Ie4cIgZYbk5LpVebcX
         CJ0xwHaJCS8S+d/CcuoF7NYKHBM01HNhc5i5yO59p4iMleU+qubFX1DY2615Up6HLqd9
         tY1d3NvCZOeOZMwue52Pc9gfVBqb2XUCFMkzKVXqbD3hgmYcw978QOw39Q6eG722/M45
         9qPVjFst5FQ9or7ex7C3oCgUoRkD8WGO8f/yNwzTyOKkXKwqFQjpiStANbEmsR++dIEx
         yf9j2NLNVQtiIt/EYnix9anV8lh/Eo4oLOfzSzxpDvk7Odw9y7e3S7ijuL04lmkuJUhi
         V0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVM4x09uPhJH+A8KWmgJqQcpqktCzOUDQVDwTZxqG/gERooxyRWivF6kgIBiQZWIX0Mhk/qDH1YI9oW5QU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzezW7Acp9/CoK125EyYrdWpPMlNm/dG31lzAcbL8O3Kh5uEJBY
	oAcE23Pw+pldz4ZlRnbj60Enlqc1IwAP2Zbk4V+2vRL1ONeU1dDT4zVdKea86XG0FGjDwqO5576
	VyQhI4F/1R65NCqBeGxZ4/My8oJfVuOOG+sXG3RIgdom+llo7+xWu9ZRvmbc=
X-Google-Smtp-Source: AGHT+IFfo4CCN1VExDGe7ySETsOckDKT7bpTKkgpjs+7DJpkO9BSPMOA+TjShxL153gE03y8I6ihreghe4wXBrwyHq+NirOd5CQx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8e:0:b0:425:73c6:9041 with SMTP id
 e9e14a558f8ab-4259563e023mr64234675ab.17.1758823861958; Thu, 25 Sep 2025
 11:11:01 -0700 (PDT)
Date: Thu, 25 Sep 2025 11:11:01 -0700
In-Reply-To: <68d46aed.050a0220.57ae1.0002.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d585b5.050a0220.25d7ab.0056.GAE@google.com>
Subject: Re: [syzbot] [exfat?] general protection fault in exfat_utf16_to_nls
From: syzbot <syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, ekffu200098@gmail.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pedrodemargomes@gmail.com, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit acab02ffcd6b1e796570ffa9658c90c8f09caae3
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Thu Sep 11 08:54:31 2025 +0000

    exfat: support modifying mount options via remount

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1617ace2580000
start commit:   b5a4da2c459f Add linux-next specific files for 20250924
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1517ace2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1117ace2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc64d939cce41d2
dashboard link: https://syzkaller.appspot.com/bug?extid=3e9cb93e3c5f90d28e19
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e7d4e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14596142580000

Reported-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
Fixes: acab02ffcd6b ("exfat: support modifying mount options via remount")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


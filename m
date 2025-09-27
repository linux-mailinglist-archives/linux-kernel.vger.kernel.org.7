Return-Path: <linux-kernel+bounces-835033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CF5BA6179
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 18:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF8838513E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 16:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F541DF246;
	Sat, 27 Sep 2025 16:17:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC1C1A9FBD
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758989827; cv=none; b=ICYnoO8SSwEQ+1Hk0BHD47TGn2mXJsyhzzLCQA392rqoyI7yojWYXwxILJ3GEVpk9dolrx97kTRo0vLogWANvHH3sJXfmtWBe35nWJg2q3QuCZ+XGyZMKmPAptYF2Je19goRk6vogIDJOekOpdt6DpE8Y+4Q6NDRsYTMoGQCl/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758989827; c=relaxed/simple;
	bh=ZhYGnuimVDp77CEJ8QFQB6JlVaem8JOVFAVKlDZBrlY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=G4iC+4CCHTmwgQuXY7Tf/iQXQk+wkdUodjRNIsjAK9ksDWlLiPgIdsF5NaoD6kAlgxAME4/NPwqZfdcMJoO0ht1rWkdI5TwhI0Kyc6WDDMdjYdwxDloCmkbGmESS4BOV1QPyUmdFKzudzTsne8bDjoSuSro+agw7Sf9dnKMjZ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-429aa22e058so1877685ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758989825; x=1759594625;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVQbaBUvQVjCtCUhJOoM57In+JvEnbQIGbVccfuSBas=;
        b=RyyRPgx0N/16LusA09pMJ+w+jf2DmfDyZL6e5IAAfk4gRcQ0Z+bn9pdyR7o4+q1v8Z
         wzFyhz29INE8Qe7P5VG3xb11mgtWciStzjn8oS26B8PQAblDu1m32KLNv4w76pQKlJX1
         JgyocFvhkemox5TKQUNKra8/XXAEwSusd2oBbf2A578xeeZNoSRgwjU6RqnHuRAV+p+H
         fH//mc/PCvk/35iyrT7OKe1QYrYf2u8BoFIyDivFolKxgHLoTuHAWgd5F50RpAP+7oOw
         GjF9J3p46Gz7sxYuKildIUaqQvWsF2tD85pAg3MLMs0JkbBn800qgyXl8q/B7DUCM8NF
         SpNw==
X-Forwarded-Encrypted: i=1; AJvYcCWgIS/+l6AAgKSPWtCOGwxFyQEkWiUwnti90tADGaAc1wZzH/icvd4ejzOhTDe18KOKVdRN7L1IAaHrPOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvqg9iOBsNygAZsKosWdUrV/9B26EEIpcfrvDdRdsIGboDstF4
	UqIIFfKYPt1eGLU/V6bcDMgttc+6SLXH6p03nmGhIq/nBEWwt0SrUmeXW2ewILxkWYqMKo4dELP
	pKEfeP0ZnB+2sYXXdsvnXHbCrHrIh1KoYF1YZrSuZ33qwOgwpvNrDcwsh3kE=
X-Google-Smtp-Source: AGHT+IHMe77fsGECZSWn321pp7bP25Iz28ilihBiPhmg9TpKpPpuJCFKrJtFq01EcuSZm0IbZEA8PKOCB68sKUeAN7hqXsbpVle3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e93:b0:425:2e8d:12c4 with SMTP id
 e9e14a558f8ab-425955fcf5amr164780725ab.3.1758989825195; Sat, 27 Sep 2025
 09:17:05 -0700 (PDT)
Date: Sat, 27 Sep 2025 09:17:05 -0700
In-Reply-To: <20250927155052.880528-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d80e01.a70a0220.10c4b.0015.GAE@google.com>
Subject: Re: [syzbot] [sound?] [usb?] general protection fault in snd_usbmidi_do_output
From: syzbot <syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com>
To: aha310510@gmail.com, clemens@ladisch.de, hdanton@sina.com, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com
Tested-by: syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com

Tested on:

commit:         fec734e8 Merge tag 'riscv-for-linus-v6.17-rc8' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16295f12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=927198eca77e75d9
dashboard link: https://syzkaller.appspot.com/bug?extid=f02665daa2abeef4a947
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169eb142580000

Note: testing is done by a robot and is best-effort only.


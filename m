Return-Path: <linux-kernel+bounces-784772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE113B340D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DEC916ACCE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C943275AED;
	Mon, 25 Aug 2025 13:35:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B7B271454
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128907; cv=none; b=iQ+IpcvPkbV+IkZwGLE3+InjRIKSA5H3YytvJKFFQTVyWpaQU4rsMXDxd6q4G/XmIMPMrYtNWfm6yYabe5np20reQH9CGQsnyWmDEEpzY4ItcHtHNVOFfeKed7bd82Ga+KFTKac7FyjxEmOiYW5FKWAsESMFcHLEapj9o+3/ygY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128907; c=relaxed/simple;
	bh=4Kt4kdwPtBse1kv9a+IlNR8st8E6nObMPNcAoNmfyzk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jcoa61mjvo50hR4JI+IhkIa4lI7Q1uLR0oIL+PN6RWjy9Wv+u6fC6Hqsy+w1hYjGDyURQJttOTVpIpn+SNvD3NA0Li3ubdnoQMzSshgjJN6URlaJK8mGnsktTjUMj+FUdneNCn7Rb2N6HpPbOB0eO78xqQmudAzofjr2SOj9c6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88432e1d004so407084839f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756128904; x=1756733704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/mF7/I+mbjkMUrwOAH/qJDD4HULQyE9LsbQXYjHD3lE=;
        b=sedyPrxf7EAeDRu80QL7ECRXT9FTlPuQ412sPdTG56N/S0rvJu38ze0CaKMXlrEyqj
         EQcuFpaGpmmz+5ScZPRjGP1yKcKRsPvKTXOQa3OI3NI8+qGRdsrSHIsTP0UZhKJp1dKE
         jAOky5JcdDbkPSI34tfsYseruE5VYO7nfXGPPGIHV6bkg9c9gC438u+n1R+drsPBov6S
         0AThP1aqW3vmtEXK5joNymV+fG4r/JvwCJ5jcCqvZKTyOLFUDDrxesMDfACELpfKvClu
         SaJi5h2QLv8YDg4sH8U/V97PguRg8b1iS73hetQoIxBzGBjhP0cG7hCaZn8SP/tMOsuN
         Dsag==
X-Gm-Message-State: AOJu0Ywk4HLT/A3NUNSeoe0vG8J6QO9Yw2Agnkhz+O+cVhUolGVYlQF0
	TGMK6Lljn9OPS8m/9PjjoZ4dlnXXkd+47pYv9R8eeIM3x9y0a76eXhB0GG3Hq7CdsqpMlCqSFox
	CfMwFqABOKTm0nj8QRiQ1cmeSR5k1IZbYA1q0XoQM6T/++Att5aqULDrYXDk=
X-Google-Smtp-Source: AGHT+IFGBRDWoonZfU2zbbsX2C70ihEZhEeui9W+wqoJppT5NOkoKNXF+cFIxVQnK6tvdK9BagEEIe46BnNFomE/2iQqcOWRLUkZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2582:b0:3ed:256a:d680 with SMTP id
 e9e14a558f8ab-3ed256ad943mr36241475ab.13.1756128904609; Mon, 25 Aug 2025
 06:35:04 -0700 (PDT)
Date: Mon, 25 Aug 2025 06:35:04 -0700
In-Reply-To: <a1e524f6-bf34-4ac1-b98d-26198c65253f@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac6688.050a0220.37038e.0091.GAE@google.com>
Subject: Re: [syzbot] [net?] unregister_netdevice: waiting for DEV to become
 free (8)
From: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Tested-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com

Tested on:

commit:         1b237f19 Linux 6.17-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144dec42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10cefa34580000

Note: testing is done by a robot and is best-effort only.


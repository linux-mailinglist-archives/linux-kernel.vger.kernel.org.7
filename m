Return-Path: <linux-kernel+bounces-774744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FDCB2B6AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC553B6F69
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A35286D4E;
	Tue, 19 Aug 2025 02:06:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC01F1E98F3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755569166; cv=none; b=do1ybyukiVQnKL6Sv2BBZkgFLfMZM7i5kFl4uYerB5K/Ylp8SfmcPvutqmng9PyGjEl5UKJ1kdRG1g22qy1aUCuEW7l6h+zXm09+cSAUB0DR5n7p2H4qXw+ijAhd65nqXj52LHPM1UDH1JPP33J1meilN3T0qnOMmXpAZcXpicM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755569166; c=relaxed/simple;
	bh=lh8jOzNpHCI/nH1BvzANTbsWlc6+7mgRM2GYOA97cSA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d7uuSkwtDHTH8WHS9reXxeT9XHO3g5gNnPAT2Et5qj+5KwIdKpGx2ch93nObHXfs8BkdLuTDpEZIxhP4hK+07P1Ms5JSS29TUHhB9mSSaJAajK0q7VUtNCVVn6fWfslut/QfByFmJC77rNgxzY3sHiVXe2fo7HW1p74sUv9ufCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88432d8ddb1so559826639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755569164; x=1756173964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hySzSrwJgHRDd/NJGNmhoyuoY2oYZl87dUt+SZaU3Vw=;
        b=DoY+poA+MaMRqUFLaM9q4BczowIXGEGDmP4ZFcYIp7cbr6u0+blTfFnh4QnlDYUBZP
         tOhFMC4HjoZMSp9idBid6UO/QpqHYCQLSMtk5kNIEKhin0njCj+W7X9oPKmX6DHmni/C
         rRB+8mk3ZfI46ArxiCYaO0cQ9dfTGPiURuIeEuMACsfmXee3DqEwUq3AaVFCdjgjNauz
         3y8si2niXvS1UIvWZS6fmh8lGuNQrOiCWeIWRmb/iXiUpZoXnvgt54ACM/7f46h4EoOD
         +Ks8+EDSKBbc+79g96ug10sGoNbUlZcp/PT7lQ1TSTkgF+ahyEOelmbRTJEdBkVqbhfI
         ElOw==
X-Forwarded-Encrypted: i=1; AJvYcCVxAMY4Jdhx0s3FM0AE8Qg+8NPjETwV/MXugS94+6tbQAqcWyBdhCnTUHqQzn49+6zaAMf/GHs5LUEW/Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy89eBXhUQ7wRIScdhBlVzsNZl2OAUjrpYrlByb4v0ubuxBt55F
	2sIXRE4VP+4gufd4JZ9DXfjXR93QBsjpmswWYzzc0DroQJddiFsjVsLWACEvTdDAvx1tVcJxAuA
	0tJmHp8Ip2IOchk7IHY3b4lCpNCyLFYzEtLDRRXF4fW/Cn2EMDR3fMFlFP1s=
X-Google-Smtp-Source: AGHT+IFPWh8hcC83DbPI8nICzmLysNTfx2q+c/0s8wrbCup6BnbcNXZPJvKrIZJUb8a8Xcrui31+7W5+TV2ecOdqs7Cjr/Yx04cl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fc3:b0:884:476b:352b with SMTP id
 ca18e2360f4ac-88467f641a9mr183004739f.9.1755569163936; Mon, 18 Aug 2025
 19:06:03 -0700 (PDT)
Date: Mon, 18 Aug 2025 19:06:03 -0700
In-Reply-To: <20250818222718.5061-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a3dc0b.050a0220.e29e5.00b8.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_umount (3)
From: syzbot <syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com>
To: edumazet@google.com, hdanton@sina.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com
Tested-by: syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com

Tested on:

commit:         cda250b0 change_mnt_propagation(): calculate propagati..
git tree:       vfs-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=13eb7ba2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e92a122a0cf6f2a
dashboard link: https://syzkaller.appspot.com/bug?extid=1ec0f904ba50d06110b1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


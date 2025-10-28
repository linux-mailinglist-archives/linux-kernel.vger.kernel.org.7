Return-Path: <linux-kernel+bounces-873579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB62AC14327
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FBA5E6111
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1072C3101BA;
	Tue, 28 Oct 2025 10:45:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FE82EB10
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648305; cv=none; b=ZezbjGmej8GQWPwNQGdFCawWNGpn/tIRhRwDQgvSyt3Cf39hSt5EC519hiDzpH1kb2BLO9URh9btY2hU7dIp/mO7dABES2WhIWSfJDlFwUalLruL8DdEi+SF2pAccxyhnPxawnErEumhZrL1PbMwB3lSGaar8N5luockhnqfPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648305; c=relaxed/simple;
	bh=DjpudwBrf9XUFeGqCV9e770HSoXqTUzjzUFcs2i4FBU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=joYtcrU6UQC3dz210gQraZFXD4trNBaURDV9Cf0+p+MoXwhuNC0mKek+2rPiFFJ23TdBeMC27cPI8I3weglz/FrGWFryMjdL4/EI1PKiDyhnouvu3ocS0xcZu6JEZlKndD/w22qFSICXBlw9gpYN/ueakrC9a2vMprKtcC7iuDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430c3232caeso72094615ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648303; x=1762253103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2P2OSC+q2k/A/RjPV9jA8vAV/p1ficxxgdkVh4GiaM=;
        b=MYK/PQDj7TPpLR4uA4eDXCFblglfMwAFiUSTQfbl4SLaE1yk/pQSGwZh0/SYSTcYbL
         WR6Gjv9CjFSq89B+CA1iOiiRGckQrpQXmZWFx/rF0UEBxDvEQ2wNH7geSU+EwnrO/KjI
         yl4oPULBA5balwvDeRR0EjMRs8vGb881mytDEDRK+YFKyxrXfj2xe/+sNFk3smBsnHO5
         ysxN9A8dBfzgQiTKKN5lFOwX1WAy42d+eqsi7YFpFqSXcql3TGHVawK7UZjU51Fcrw1X
         8AsQfrBrELDyuzl4m5lLAoAPDF0c8OGRgZfVANskZPG2lV3BpfEK0ye99PWt9XR8KkqC
         EEmg==
X-Forwarded-Encrypted: i=1; AJvYcCWP0RsdQqiLZKGDJPY5QqU3BPjKFOU1pJfqQ3S8i77LvmYZUO8Ej6j4iKPRgz/arhKx21z0zNW9lUIWEAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBSngFcxr6975gHMjCCEz4gyEUI1xZxxn0TXXm49NI5sPGYE3h
	/Y0ZiQ/hpfXJwc28F2/m2zztMRjk8DgibcaoNObHimUjcSbdF6neQAjeC+/DmQxD/zHw/nMgOSf
	1jPymjhnq2wmiaNc8Ib2pQpDNhsdvWejDm9C6kiurBBk74zPbc0bbcPgs5Mw=
X-Google-Smtp-Source: AGHT+IGXlP1f1ZpggpOu+KWcQQFRXOSE+faj7l3OJCYCy06RsDrV6hwbQpwHi6jzXmm6NNX3RPYfEoBZ2C40T/0glRZ06A01mBB+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e1:b0:425:8744:de7d with SMTP id
 e9e14a558f8ab-4320f7b9017mr40257145ab.30.1761648303317; Tue, 28 Oct 2025
 03:45:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:45:03 -0700
In-Reply-To: <20251028104156.3QE-I%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009eaf.050a0220.17b81f.0015.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dx_dir_lookup_rec
From: syzbot <syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.12.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.12.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.12.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=30b53487d00b4f7f0922
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a2dd42580000



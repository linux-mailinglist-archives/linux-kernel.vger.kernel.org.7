Return-Path: <linux-kernel+bounces-876094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 896EBC1B025
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD19627863
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B66D2BF3DB;
	Wed, 29 Oct 2025 13:06:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBE137A3D8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743167; cv=none; b=vD/1d7o1oqPLVfw4T3UXeVJZJed99tXlVvpmzKo8LPSlpwX315qi310PMpkfiY4D+ih60A3BiiEB11PTNcWdx20dYTLsX8lY+i8l08ZAJ8zxN39CEnreeOc9AhWLRf4nMmR8YmEMaoIpKKKg2kC4hgQlSQ8O5ONlxHjBSLs0+5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743167; c=relaxed/simple;
	bh=fkZyIGq3aoMcmMVK87/VRSbxF2YnCdlXguX/ymjWkO0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qCucB2O4U5R88AqkFmq9Yq3y9uLbhcarUAN3xAaNha7pg1BRqoMnNL4KnSmR3Z2qP+T/g4iNaH7fgDE73QSODVHxsaJPSgGMc1HGeDvpchWZz+93XykIFyYlX8HoR1vS7ldV1ioszV1v61F9eUkKUJIh4KYNTTIrtVwrEz/ykwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-937e5f9ea74so876184839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761743163; x=1762347963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SazA9KSs0/c5OmCcEhSDG2G1zI2JidX8jbAiPiUKXC0=;
        b=iYtM1Ld/m4zTOh0ncK/5JPxa5jbuZGN4VBc6Fgva8wQ/kBQG0wYqx3BHFFCnihs+Rb
         0c+DYmFzWXAo7rzmXdWbynlVbxx8ZVBEVrFz1hyoiYsJ0AMXeIOxb5BknzEJq1W/mlro
         gHkTA5K0V3U72wSyygySK2x+60vn4boNWFD3CnmMqgDbHENFIHsr01ssIxB8/Qay0PmM
         eB9jJE0x0jp15Z1bXQg0qzlYHtX0l8tV45yN6jSeFtySLJztMo17WkrlV0bpGixOwZV9
         QD7yBeBveq8D1+v2S7dr7RirB86n52RmeWXKm/taMXqMhoqalObqgEsqQnqCVQqyzvvz
         lrbA==
X-Forwarded-Encrypted: i=1; AJvYcCVSCsqbyUulakKu1M6tdRQVEkcyYz+XVJJ7QCnT6pOny9PZY1YOUdKmOJczkSAkrONtxqLFbyQ8UXVYVK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVpXcO2j0jvUTDMeYpTl888I/g6J1qV2eQe1jUf5nWCZUrz8EL
	NpMe8hUmzSSgh+Zq33vmmhfhfi1GD0EUi3DDJB7X/qJlMWpDOufakOuunTQB96BmQMVmQ7dwIBc
	n2yMz+yJAxtJvFyyv38BifT/qJg5B5G4Y+MlPEfO97hy9eMxBYJHfAfb1Ioo=
X-Google-Smtp-Source: AGHT+IGBW0mr05dPygKmiWa5NAKNrSxLDT9D84lhtCBLsmopYmYWh+0sHjIrXURcoLqr/a78gkTu1n2mrX713s8tHSHQuABf+rE8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4503:b0:430:a5e3:fd70 with SMTP id
 e9e14a558f8ab-432f8fbe9damr29562895ab.9.1761743163247; Wed, 29 Oct 2025
 06:06:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 06:06:03 -0700
In-Reply-To: <20251029062548.p-W3Z%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6902113b.050a0220.3344a1.041f.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_set_new_buffer_uptodate (2)
From: syzbot <syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com
Tested-by: syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=1564efe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fff88b67220f824
dashboard link: https://syzkaller.appspot.com/bug?extid=7aef76bdb53b83d62a9e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1094bd42580000

Note: testing is done by a robot and is best-effort only.


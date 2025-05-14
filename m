Return-Path: <linux-kernel+bounces-648266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E52D2AB7463
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 20:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6BEA1B66243
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 18:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F30E286D70;
	Wed, 14 May 2025 18:34:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AA928689C
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747247646; cv=none; b=IcvMWEgPSY9TiGOoz2kEbUMtXU/Q/K4Bevu/1eVoSGSg6ikimM2HSggUjjQaw+h5gCAqijx+jLUNKtw/sw3zhNHeG++8Uy3QEIr2Wb4kA2PNJOcVm/DuypM/IaRmea7C7uNOkRbmuOQmb5FAyLSBHpoKgbYmDIxkZ1pxy7RpSq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747247646; c=relaxed/simple;
	bh=C/AMOybXmMNriLmRrMMUjAPPdkqLnsLVfpwHNG3y1d8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hfd81yWtHtNn6XoIB4w5icU8GYnOUXFgYqSV0RhDDZmWlJZQyNcnaFglcT6DifbeyvVqk/C7ag9JdMceAfOTcTtLwcTxnUgEMB/MksjydkHH/NbohSTrs3XCQ2Lh54O2cqFVuysquhigPO3QITs9X3WKoRftfhqIWVLrrtcmWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3db6dc760ffso1623635ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 11:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747247644; x=1747852444;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RN8HMO0gxZcP7qvsx/HaxnOkoUT7cdCTRks8rlUkvpM=;
        b=h9ksOZitT+K1P4O0nVMVjPeAs4PKcaLIIyn3kOAtwx7Gdde7ozvBs1zWXKVF7DYsqW
         uhzFV6rikRDhSV2byZHxBiWdemma8xjOiZOlCNQPmxHLjqtM8jjzVUv8ik/Mhk5ahGuP
         gnDkCgqZxgdMKyBX5CpMSa0kTILWVLC0AE2hl8KDXeEwtCOjJrBDuWQmROE+WNmb3m6U
         d8+BYVP5kbqSRQJZnvS8HkNQeezH95JR6g3HoQqpMKM/LBy8yfkMw5+wTm/MRAW/4PbY
         yB/bwtZmGYCkT0+wkvX3EMUI6Nt8pCfGIrYoe8KCpHutPeh3BbZfK8nxAYcHmv27+8Dk
         qx8A==
X-Forwarded-Encrypted: i=1; AJvYcCVCPaScvLsHkUarGzyJyXvjmVjGy2TJn10Tt8s0BolzNjyYgA7grSdI9LcEY1CsaKwTmVU4phlqe04n0B0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/fVRjqtkvKckOR9l7KqbkjTb4w5Pi2ZVl7ttFzvvVluRA5mqq
	ovWOqcsjw0HsNU7YlHkjAI3z0ziXRZB3MX4RdUA18xGFC5YLzhCgggrym7F9dBXcq00+lXlAZN2
	fQJQ4IjcfQO8XacXZOAKTLHJgKKWm4bThxbTaKtyYdBOPRm/S3W0cOzY=
X-Google-Smtp-Source: AGHT+IGJxcqIkp76cLlKNDnHJQKnIAItIIxRc0KbDG6doO25XH20nuzMroTHS6Spy1fKPEj866mmszfs+8bEXoBqcNxuVQIpawnR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:b0:3d9:3adb:e589 with SMTP id
 e9e14a558f8ab-3db6f794c65mr53486305ab.4.1747247643705; Wed, 14 May 2025
 11:34:03 -0700 (PDT)
Date: Wed, 14 May 2025 11:34:03 -0700
In-Reply-To: <20250514182111.GO2023217@ZenIV>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6824e21b.a00a0220.104b28.0014.GAE@google.com>
Subject: Re: [syzbot] [xfs?] general protection fault in do_move_mount (3)
From: syzbot <syzbot+799d4cf78a7476483ba2@syzkaller.appspotmail.com>
To: brauner@kernel.org, cem@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/gi=
t/viro/vfs.git on commit 8a6d8037a5deb2a9d5184f299f9adb60b0c0ae04: failed t=
o run ["git" "fetch" "--force" "--tags" "52e739496919cc3ebdc35ab042bcd12547=
ec52de" "8a6d8037a5deb2a9d5184f299f9adb60b0c0ae04"]: exit status 128
fatal: remote error: upload-pack: not our ref 8a6d8037a5deb2a9d5184f299f9ad=
b60b0c0ae04



Tested on:

commit:         [unknown=20
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git =
8a6d8037a5deb2a9d5184f299f9adb60b0c0ae04
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db9683d529ec1b88=
0
dashboard link: https://syzkaller.appspot.com/bug?extid=3D799d4cf78a7476483=
ba2
compiler:      =20

Note: no patches were applied.


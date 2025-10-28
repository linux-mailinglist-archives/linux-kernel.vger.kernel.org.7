Return-Path: <linux-kernel+bounces-873016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3374EC12D69
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 864254F1E71
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D8E2882AF;
	Tue, 28 Oct 2025 04:07:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CF41E520A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761624425; cv=none; b=g1bNc3aq45IevqELwx4CcjrV3FLHY9X158FjPft3LpcPVbgnuaeUxo9UcK4skTI3mAi3pKSlR6VSHXk7Jr1qRO2StdbtKSOOD3z57uUIntC+FfDbP63eOTavTwbsoESTh9jIvIWWwp0S0evmPwGrQVScEwgbeGnDrywkdyFU4Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761624425; c=relaxed/simple;
	bh=Xq7NEgU1zofqfNBE8/7q4W38d9vc9gT4PiMJgjZkdUk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dsEdVFJtINz4Oix7Rpwgo0dT2YvVBNKv4zg3yHgO9BCVKpvq8AWHjDYhqiZcwAE92M7dGAuHpwa4LC+qgMQUxrzY43/UEC3a3VCRyG44H8wPK690w/ngi2P4z92oLV0K20R42wsAvWb63a+GKkHoWCnd9kV1B/l5YxqG3RztR80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-940e33d65b8so1591496339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761624423; x=1762229223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAktdx2U7S8igR8DqxqFmRSD8nuZRp83OySSq+/l12A=;
        b=EpR4FwIiZbnN6qNARxffLl3A0xd5sm6tuuPtRNL703+gwPaZXgOb2SxaLLI4APbdpT
         1ASueW139olmKI7X2Si9mv2mOSsyZ0G5UkDSHmuIqg5Z4eDOi5a/bD++Oe1F3v09l/dR
         odQ9XDXVifJsZI/mhrudEbBNSx2JV8liZELjdhioE5bQ9uGSp6PXWy63YV+YObPL/wDl
         EfbkNAj2CCMU4pIlzYEMY3RVGWScWoKOUUdwzHl1KnicqxlRKOHCzxD/8TcVGyqtfswp
         bjwAilpklX5iSnIpyu1N+ooVT5wpyovm13vyiR4lpf5MHUF6yIjyJNoHnNKwmvSutlZ/
         rGmw==
X-Forwarded-Encrypted: i=1; AJvYcCUWx4f+ykYO2X5wrkBeECgUd8uDt58XBpC6Sc5WzjWO9XTDtvlMywgH1AHtEluNz/gvaocJUh8SrkNdp+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJvYxRifEWZYP2AXbzXlnh3aKbaYC8aJkSnx/qG/p3HIfgNUgp
	Y0r3sm7bFpOu7RB/Gga2xiF4PNJW9mZ6beNU/Dw9UXIPB7uhPAkQ8v58ew5IGP3t5xiByyVGlVs
	9lj2ehjRM9KkiAkAJQBuUgoI4EpIXK4VHNW6TJTRnirHj9VphPIZQ+t3WsMo=
X-Google-Smtp-Source: AGHT+IG9PSuXVsRhDdqch1ctaCvkJce7yYq+StAloZQtd2K6btt+9THf0u/ObQk3a0WaFNS62RO1crkLkBqFHe9K5XpYFkjK0z0A
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:240c:b0:423:fcd6:5488 with SMTP id
 e9e14a558f8ab-4320f7bbbadmr41368185ab.12.1761624422978; Mon, 27 Oct 2025
 21:07:02 -0700 (PDT)
Date: Mon, 27 Oct 2025 21:07:02 -0700
In-Reply-To: <tencent_7F051BEF4BA91BCE253CBAA7BB7133FD9E08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69004166.050a0220.17b81f.0006.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] WARNING: ODEBUG bug in nilfs_detach_log_writer (2)
From: syzbot <syzbot+24d8b70f039151f65590@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+24d8b70f039151f65590@syzkaller.appspotmail.com
Tested-by: syzbot+24d8b70f039151f65590@syzkaller.appspotmail.com

Tested on:

commit:         b98c94ee arm64: mte: Do not warn if the page is alread..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=164c0704580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=158bd6857eb7a550
dashboard link: https://syzkaller.appspot.com/bug?extid=24d8b70f039151f65590
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e16258580000

Note: testing is done by a robot and is best-effort only.


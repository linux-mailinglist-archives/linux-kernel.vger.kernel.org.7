Return-Path: <linux-kernel+bounces-864134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE67BFA000
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75AFC564B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4A22D9EEC;
	Wed, 22 Oct 2025 04:48:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1EF2D97B8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108485; cv=none; b=dNKg2xj3s55SiDPoV1JPQx7MDeKrlcp/ii1euhy5uksKXq2RUSveqi9sXueUYgtqoqM5wGr2BeEog+PFdfhq5mPUSCAjIH1lxPUqwBS/wjRboVrGV6jfWLl6FCDuBc1MnJjxBM1VIb+g1QtXbHc4IMS5h6WCSON9VXkzngKnk94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108485; c=relaxed/simple;
	bh=8me1NOBdMkZ8W6KiE2Z5EFwDzA7nqvNZzcJL2aXnWeg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KFtX8s9rBprsMd1W4QgzvsOpwMV3UyzVMu8aO46HKAeHCqsuh1rK1P74eI6dUTmSXa05j+dpt/ScV4lXbvxJPHB7se1r0th0V1jqIP922ZDC9ogHR2YampsF7DOxf/jVHnM79dWbhLBk26z4/ecQ5BQur9jeJcDFsyqJzusVwIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8870219dce3so682377239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761108482; x=1761713282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGJbGP6HSExn3OFh5coEO210b/kwCxD/DWfGK8+Iqxw=;
        b=uw9q095B4R2uuobozqYtga03256BkcbbAfsYs3q9k+PQ+OEiMNEDgttvhWe85pNvJU
         lvue8Ap/4L/muBOhCbFIT3XzjrJ+ept8r2TOjOhoz3rNru+Dy2D3sb3Fg01aqqFOXE/0
         FAsFBOPFf5jYeLVTQKk1qIyMb6rZHpHAFs8aakFLVg9tQMYKnp4bvPGgRVZc6hqV4YTL
         +XG5RLyaq92cvqMGgJ2+48522ijTr6rv2k4LV2sUFeV54qQgQ8oUazgRMGYymfPK4a5+
         OYYTGb88ftLbV3zLVb9gE2byrwFn0MKii9r4j84/7XVmEYUGQx4cNqXq1PbVtEwvUb5Q
         OaYw==
X-Forwarded-Encrypted: i=1; AJvYcCVNker6OurLomo0saOziRfUgfym1Fuho6fNOm1h/QdXHCvXsTJ/yhq9YVRW13nPXuST0p9yvg8tNPGLo58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0YZ/JYAf0Hvcm1UilgWO9W71jl12gp3avEsVYdIj2NyXYj6e
	+SFgBaI8zCCu6WGKOns2od81kjS28pK7DWnKNVWjzh9vhqKF8/AyMcJJ5nrY/PGyZmJXfhUxWRT
	dJbK4Sf20ks/ut8yuf8cWwux3W6irJZVwdAbtuFLFevCUyjPgwQxZfu88Ri8=
X-Google-Smtp-Source: AGHT+IF9oPWKkDUOteEUy3jL74Mz0URO0/ArLBGt57BGmHyjtwRCtxvu3LROu/TzTH0l4z79H0ZLFkecLyTIWykcDTpRO2MeFHBN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:8742:0:b0:8d4:2004:ce3 with SMTP id
 ca18e2360f4ac-93e7627d018mr2441080339f.4.1761108482539; Tue, 21 Oct 2025
 21:48:02 -0700 (PDT)
Date: Tue, 21 Oct 2025 21:48:02 -0700
In-Reply-To: <CAPqLRf3gQMhkX9_Kvh++58PosdA9J29Hx-7baE0sg2R-B6vYLg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f86202.050a0220.346f24.0031.GAE@google.com>
Subject: Re: [syzbot] [mm] KMSAN: uninit-value in sw842_compress
From: syzbot <syzbot+17cae3c0a5b0acdc327d@syzkaller.appspotmail.com>
To: glider@google.com, kubik.bartlomiej@gmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+17cae3c0a5b0acdc327d@syzkaller.appspotmail.com
Tested-by: syzbot+17cae3c0a5b0acdc327d@syzkaller.appspotmail.com

Tested on:

commit:         d1d7f15c DO-NOT-SUBMIT: kmsan: add the kmsan_exceed_ma..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10eb63e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87f87e008168c835
dashboard link: https://syzkaller.appspot.com/bug?extid=17cae3c0a5b0acdc327d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124803e2580000

Note: testing is done by a robot and is best-effort only.


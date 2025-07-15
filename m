Return-Path: <linux-kernel+bounces-732045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095A5B0613F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88D2921926
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331A018BBB9;
	Tue, 15 Jul 2025 14:24:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066A74BE1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589445; cv=none; b=iynMfu5+PISqjCvs06UWoJffdbaXRqbEJgFEVahKhn9i64eT3VxAumTQu+p7I220biGm40J87IPC3ro+YtOVlM0p9Aw5IRRyWujkDO9kKhz8Ws9MsLudt/mWjYUSjPnlLeJwDSI4pLwoRjugPZi0a6GCbp5/0raiVhUjD8l/fBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589445; c=relaxed/simple;
	bh=D17TK6nEg/NA6BHyIg3bDNovR0tCl84lGpdVWztqr2E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mxK4Xfs5w8I6LPVZtmPlm8g+Rw/TjlfkprjdprupKETrO1fc5RdJjS/xNVsd3a8Hd/jLZzMovRLvwzAYcObpuxy3/2hNeP+uUC1xwMXUCCTmzZdAWYrMXOi7g3Ip0kpQ19/ud+YCtLF3GvgVtlT2kVs0KV7fjGP0XDSktN8Rm2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86cff1087deso1103478139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589443; x=1753194243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGYS1KfbG9gsx+nxtfhiWRVKFXM+goAw2DXLNu9lnN0=;
        b=RRaHjE9r3hzioVjHH4BcCZlV5DyA5ESZWb4bmJxRRt7o9OdG265vWf7S7BLUzYT0oX
         6nTGPqU5hrP/dSgADi605p4N16qatuB9dKTYdTQDKBQ5jJ/ML5yLOGKM7ys7t2n5DblU
         wOQsMpcexoFQq4rcBEixJx1zbRZeysItWycL5nBh298fh/oh8SGkygshYB/qCYNo4CDo
         TOdChVTAUa6bL+hIfWfrNi3HkIr+REl9ssPO6tfuFyg43eSv6LojLBf4z4i9zYfOnXDQ
         63m3PWey8ckZe75F+KXXbYbyG1lT534VmljTmDJAImNiKThbGURErgsNHbLmLaJ1Wqqr
         RlcA==
X-Gm-Message-State: AOJu0Yz5iWvuvfDOpfwuqhR2zT5q+LcQ7YD8mJyQiqHUL/dgcuK8l32t
	EuRD9VQ2wkw6h3n7jrovbPBZX8NSCPkH9vkz7SBkwnqlDJ8BOPB4WJlVC9lK0nErEBkRj+B4mNt
	dXErMUU0PQHeMJ1DIw0MwHgKX1q3Hnk1UkC+j49jmj6UghnL0z+GTjaeOKlg=
X-Google-Smtp-Source: AGHT+IENTOwBrXOp7r+TU6vD23V3Yyu144zgS//rjRXrlP4bSsOgVPj64iM7GToHYHNMWxRp/fPU2d6gL0innKovunpxXMp46rqx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4c06:b0:876:7555:9cb4 with SMTP id
 ca18e2360f4ac-87977f57c3fmr1721786839f.1.1752589443193; Tue, 15 Jul 2025
 07:24:03 -0700 (PDT)
Date: Tue, 15 Jul 2025 07:24:03 -0700
In-Reply-To: <CAMp3bLVK6iyX3ZrM7=VUp5RcHcDaTNMRxfYd-Jr2Qr+vzRw7bA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68766483.a00a0220.3af5df.0006.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] UBSAN: shift-out-of-bounds in gfs2_dir_read (2)
From: syzbot <syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, purvayeshi550@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/gfs2/ops_fstype.c:283:11: error: use of undeclared identifier 'EFSCORRUPTED'


Tested on:

commit:         155a3c00 Merge tag 'for-6.16/dm-fixes-2' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
dashboard link: https://syzkaller.appspot.com/bug?extid=4708579bb230a0582a57
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=160208f0580000



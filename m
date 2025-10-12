Return-Path: <linux-kernel+bounces-849479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF85CBD0364
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 16:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E13F3B47AA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468B12848A6;
	Sun, 12 Oct 2025 14:22:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698FA28469D
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760278927; cv=none; b=NCLEAI4i/n3WJnWBvlyPDzZ7zEhryu0H7BxWC7y/EcHlOcmQWj/htwTkrYc2ET0rC1WQic3J1mTCuBMKTlgV9GIJbJSBNP82PNqzNvPGVxamDEmnApkubraFj4LWoxqa10gkhmjfeYy0A5CNYIUlcN2YogjGR3q3FfDLiFqFrCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760278927; c=relaxed/simple;
	bh=9pESG64miPasLo7bV0CQgEu8LhHCXPWVa/VPYfrhM1U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cuXgQbiDkveJZIfzYYAbkNJERTNMF5wIQgTeK+rwAMDpLQKpB7fnMaGjjZ5YoFrlh5dX2R+BnIk3ny7JMTWXWAct6pcRU1NfSuedTPJU03kcILbftt1aeYO6S+GABe2rymZBXYy/FHVHoZTye5ENgEHuH1fCBUlPEhHr445XYCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4257567fb7cso113011855ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 07:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760278925; x=1760883725;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0rSnZy6IeqJJ4+YGSwK6X2T8neJu8Zh87YZ79NTSbY=;
        b=nMHr01nyui5FyzVOpSp656G8aNAoKGFekJZaYNOXDKiHV7qaibJtWen4p9X/wrlrb4
         B8rx9JiGWCuaD0pDgpwswShqdmtrpDJvoU95iQk9NWc6nFD3xKnXMDiVmPF8t7sshdP1
         9otRTFNvB6g40NxscgyuVyUq/3BqMajMGLSZ7HPOiQBYwtvpbLZkOe5D/gqTv+bk6L5q
         p461wlZ+gxnZRMP4olYz/7WSlLx4S3sufSfhtkBlhcFwwx6Vj3Jv4K+mfakoRpavNLyV
         rNChZBcuTrtPs8wCus626mzAEBy0Vm7UsA87tbIdAbho5+4kj/F+JgmBCfJXVxch5OMJ
         D3FQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6rOTAogssF319K6E/pZTtbviTm8syYD9CMXWlhCN8pB0WVWsb+3rHulOy/W7IE8FpWES/iFgYgOTaZV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydsWyC9b0d3XLTqrf26x2urD/wjOeUELZ+5z3Ke78elPk+vfac
	TVEcjbfRpQYrbv080BfhkNKll3edpsr1u9Cav7pFiNcBv+gw8CNzqZ7fMhNFaljXeCSoIdTiCmD
	LwBTkg5UJPVQx/JPHF4CrQk3vfhyviqCqByjtJXitNufKiWPr1q/S5Puuv0o=
X-Google-Smtp-Source: AGHT+IEOWVreDJCAhWA6Zb9zMGM0Ep8ZtoYXbNbJhScWAxb5UUqEZQDZ24kOeejx3drWf4EUBDskyIE9dfZCe8SyAQ+ioqPyW0JO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:426:39a:90f1 with SMTP id
 e9e14a558f8ab-42f873d62c7mr207144655ab.18.1760278925708; Sun, 12 Oct 2025
 07:22:05 -0700 (PDT)
Date: Sun, 12 Oct 2025 07:22:05 -0700
In-Reply-To: <20251012135649.59492-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ebb98d.050a0220.91a22.01d9.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Write in __bpf_get_stackid
From: syzbot <syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, contact@arnaud-lcm.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Tested-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com

Tested on:

commit:         67029a49 Merge tag 'trace-v6.18-3' of git://git.kernel..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=16848c58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=308983f9c02338e8
dashboard link: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=175d3304580000

Note: testing is done by a robot and is best-effort only.


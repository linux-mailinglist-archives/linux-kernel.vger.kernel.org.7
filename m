Return-Path: <linux-kernel+bounces-773690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E27B2A598
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE88566B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30545343D85;
	Mon, 18 Aug 2025 13:22:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C91343D69
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523324; cv=none; b=W/sR7e1sCkUrL5XrqcUWj2WERcPDnK693N42kn8IVYJQ8MEOVu9bRO3ornCR+z+9Y+ANaqg8wN15eKuOlITIae9jslR/eOpDIrdf5VHnQ2G8TzHPPnULAHr0AGQQpL1WMtULsJyMDlGmEARE1pxF1ML6ytJt7Ldqx600b3qvoSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523324; c=relaxed/simple;
	bh=se5n16X3xRtJFBwPLTr7xqwKwNy0IlNwwmS2qh7ZLpw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hu/HG9AcWk0O4EhRR6lA0iH6XN1wwi57Fa9rijpZqhB3u5Fjt6KdTy4sRI5MVvV30RExdCESva2FofTOjkMMexnAP/NVio+TKVJSSDZqKGbpft8WPvl2HdcH2qL+AALG475JojdUFIuF6Wbg0goh1atUzZT+0mk1ZxXg853nVto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e66b7e4a94so32975685ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755523322; x=1756128122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBjSEV5oA+OTjDYadcwIgim28mkwpg9xM7xVheogjjk=;
        b=NMghzdDDKKiBDE/agdkyYKUNUM77OmzOg9rRSvGFU61Sq5A89hC24+7RxtwY25O+Hp
         aymp98be4ibPDpGWkiqZjqSjqJgU9Tzok3ILMWMayEcRk18hTz2lU+BJ1+tJFgLnt4D7
         C3WsYoNQX815yevo2WbOYHkc+4gNw7M9Rdz550JqSCH+vUzBOjD6Q/+YQD+h7ha0aXzk
         uSMZIS7Yl4QCGuzXr5fRnxubrfYFidwwymsRGl+Olh5stzg6wWvDdOR/YJOs16/ZTUpS
         USr50C2ILH3ZfG+FkWw0vfl17S5ZMOWQla2ENreL5bBU8+O9Qt7EeZpV49+ULTJaT6gj
         pkyw==
X-Forwarded-Encrypted: i=1; AJvYcCVSnakgt1R7LHMOYhTrDAaXZp30uJZ+wSO1dKQmAK5Nlw+HDh2HLoQIWBxHvMgK9WzXLW0j/zkD0KaZBh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/fTXECEYjI0Vzh+Wd1bBF59IKonxbT/drmYk3m0NTmLnnx+do
	VuiZv/F2bbim1s+DbGPFjgre9fYPliCLifPI0h5eqT4S/dxyZjHc9FX1otwyqvy50f0wWSSVSdd
	J6iudRQ31dCM+Y3PIu6mo+WrroK8sRQIidHCWe6Ae5xYHofXkOfCzFSZtA1w=
X-Google-Smtp-Source: AGHT+IFeHyKsXWMtuvFdAQyvFVMtBa+BrbCcxBxKglSNVT+gHxpEhdduHZnu4ubmttYznpnz/tSDIlpjoG+UjmUHotmvTJdTKxx3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e4:b0:3e5:5cee:a9ba with SMTP id
 e9e14a558f8ab-3e5837cd1bfmr171751805ab.5.1755523322445; Mon, 18 Aug 2025
 06:22:02 -0700 (PDT)
Date: Mon, 18 Aug 2025 06:22:02 -0700
In-Reply-To: <f07b06de-77e4-4d50-9d97-18590faf0b10@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a328fa.050a0220.e29e5.00a9.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in move_page_tables
From: syzbot <syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, harry.yoo@oracle.com, 
	jannh@google.com, liam.howlett@oracle.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, miko.lenczewski@arm.com, 
	peterx@redhat.com, pfalcato@suse.de, ryan.roberts@arm.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com
Tested-by: syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com

Tested on:

commit:         eaa49d2c tmp
git tree:       https://github.com/davidhildenbrand/linux.git uffd-wp
console output: https://syzkaller.appspot.com/x/log.txt?x=151c5234580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=247d4d29e685f61c
dashboard link: https://syzkaller.appspot.com/bug?extid=4d9a13f0797c46a29e42
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


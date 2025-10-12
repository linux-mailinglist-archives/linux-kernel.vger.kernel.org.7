Return-Path: <linux-kernel+bounces-849458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5424CBD02B7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 15:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E243B89F3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 13:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB71F275870;
	Sun, 12 Oct 2025 13:29:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D1C273D67
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760275744; cv=none; b=lpjZzvysS8JcNYOK1ttxMxUh11QqPIvDU4eSfZ2GKsXUtdW9gU7bC8IvjgcY76rYCqQUOqjOXILbVazQop9hsFIKmUlF/XNpX6WvYDNfqzRZ4QsgLM1k7jBddugCYzVi6/pSfgLIghbZBCJjsz+2oK34Scpb7AF8M1FtcQ7+6+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760275744; c=relaxed/simple;
	bh=irl4flsspEWqN2JbuaaethEiXG2Hm1MSnwEfJJSjN38=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZAwMY75dshx7bLWs8QPBvIHt99y1H8FJAMNG8N6r3YVM5GdPNzm6yr+HwijE5nMtdgWuypeoiOH2KVXaOfxRTMquEZD/6IgQSIYjLhaM7Dtdfj7CFYEgZjrcuLmhKvpprCjuBWzdv9gILpfeCz+vBIMNXbK1PYnhw9tiULooxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4257567fb7cso112755385ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 06:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760275742; x=1760880542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYngBb1Az4lSjC0yPY2rNk2hNyxaE8GGPWbiAnbBpFU=;
        b=LXROBE4DdFxzxqH8K5dRRttXu9YBKHIkDqQ+/OSgFEQ7YnLG5+9BGPYjbwb8/ZD6uu
         619F1X3PIOqA0YDabQti9CtVuJFJHqLujrYMSZYM9iMYAveNaydEw897uI15ZEsitut8
         cRNSFiStoV+pvYYXf4psj2H0wTYOaO88k9eyeLtErj27vB3uPVwefioZrFKbhhx0P/5B
         8oh2L7Um71czFsfftvCb3+jEXiDw3BMsCUQ6tnpUFf23y73rvw4xoDiJDM8V/hnknviv
         QE0fh3KH256VZm90n+MiEoeBU4ZgVwXsqr74D+3muQg+BL2sW0yq81A2hqI3HbtHA/VK
         OWxw==
X-Forwarded-Encrypted: i=1; AJvYcCVTxooGIL6h4eMRk6QRIZ4zbkuYnEOMQFeN+5XbWMVfr7CRgWDb2ePBhzom3oYkNgkIfllcKEJtzIoCk78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpO0qzeD6Eaaur3iscujLoxQqGEU5hWTBWwPTDRGY3IbMAD/Rx
	KdLfJYGqnP3kJ/iFLVsBcumAO/a1QqGfON30uEmKUPjbQa0pjxYHp5PjAcPU5Zkhl3zqpfh3qQq
	V1yr9S8iP40qphcu1w7E7ivw7yca3VgV2N66Erh86CStm4HeWWjngMXrdfYU=
X-Google-Smtp-Source: AGHT+IEJIqNbrGsfblcj3SYtGHu8r6eHFjXqm+qPTuTO7lF+OSeoTjD3z2vlKvgCnXOaf4G93JSCp5DPqRwnYuhOzXtq9nrduW0k
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:426:39a:90f1 with SMTP id
 e9e14a558f8ab-42f873d62c7mr206252075ab.18.1760275742364; Sun, 12 Oct 2025
 06:29:02 -0700 (PDT)
Date: Sun, 12 Oct 2025 06:29:02 -0700
In-Reply-To: <20251012130418.49730-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ebad1e.050a0220.ac43.000a.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Write in __bpf_get_stackid
From: syzbot <syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, contact@arnaud-lcm.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/bpf/stackmap.c
patch: **** unexpected end of file in patch



Tested on:

commit:         67029a49 Merge tag 'trace-v6.18-3' of git://git.kernel..
git tree:       bpf
kernel config:  https://syzkaller.appspot.com/x/.config?x=412ee2f8b704a5e6
dashboard link: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14465b34580000



Return-Path: <linux-kernel+bounces-858676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA0ABEB665
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D6FF349366
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD2522256B;
	Fri, 17 Oct 2025 19:46:09 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4A733F8CC
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760730369; cv=none; b=iLgXIHIys3cI2RLjxIO3bm4U/Q7IhDPYPySIv9HpVgc0NShRYgShKQm3axnKvTBqKhOi/dp79dHMv47h39jZAO7b0hXcMO2wNpbNEcoAwC2iXzN9LYl1cFRuHsTe0Ag8VJn3WUscty4yWo0rIXtDrtQL1Hhl1nwn/JFotRMlV/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760730369; c=relaxed/simple;
	bh=TdkEs9llSN5q7yKhoEQjj1oZJ6YBoRYCSeaby6TELNg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HZ4hSMWKr8wnL0CXgSpSZThzsydjUZ0jCYFG3zNrXVjAKqiLL4B6ib/0JDACEV3+LXqQ28/tAXWvnmdpzQqSay7q82z7uQ65EiaYD0B/XkqS9evi/t8IxAV2BaDEUPz98bs11yULEjQ2cBY5dkvLMaAon00RFBwl4vhCB9a1B90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-93e809242cfso152910639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760730364; x=1761335164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gy+Oad1mE0qUxGPkwtRZT3e5Vb4LahCM0FSmr13EJOA=;
        b=jqCfSsXHOz2QviicVDzs0a4ujEXA/UeBwrHICatXwF9OULGyxcMqUjy8JBLXR4u3h3
         CLaANErLyttBtYsoOiooyhb9AMkJuRqtsDEkLSEzBtwafenqofzy1LlJQDl2DapHY07K
         HIoAmS+3zewrlWs14JosD9mj2z0QjnOAt8N6AFNoV2EHgWMGEQmLwTnw6VlR3kttRjfO
         azC2nTsr3O2N13A00MQZpjd3FPcZ0wuWATMHM0MdARvvcDl+b6VvVRZifznh8I7YWvsI
         Z9CGBFz1pE9NCbJqb964at8Z66SKc3pNcEw5sxRD43KSufRhu1fRjQPWCzPEImZGFnUj
         XhCA==
X-Forwarded-Encrypted: i=1; AJvYcCXS58iKa+jSs7SwSbdfgFFZwvizfA3s6Uyj9Tymodss/u59B0RMxp6FydtE52Otpub+ugf8fqRhfGROhH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFqdjliJ7pQdWIM5tvUahiO+msvg0JbU1y2VWhm0c5HdLTYot7
	3QKdQL/v+aN7QfioTX2fKPV2TMsomDtCIbZeJ4vW1k1nSsGEf/Ovy2cr8/XPPeILQzGvU7141i2
	NA1/PaHCrGbMNcTcOatXWE3j1KtgKOS2az4vgpI8RbAcggqGWfXF0OVFqUgw=
X-Google-Smtp-Source: AGHT+IGd4Oj0obFzUJkDFv8vYM9SXKPpZIoFnelNqZFHOquZDJHzbwjT4Z7tB22u6rRpDdV/6K1pD4NhtWs/n7GRsGkOakzhUeLe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2591:b0:430:c312:214c with SMTP id
 e9e14a558f8ab-430c5234d18mr64854515ab.5.1760730363890; Fri, 17 Oct 2025
 12:46:03 -0700 (PDT)
Date: Fri, 17 Oct 2025 12:46:03 -0700
In-Reply-To: <20251017192527.214711-1-hsukrut3@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f29cfb.050a0220.1186a4.0519.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbAllocAG (3)
From: syzbot <syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com>
To: hsukrut3@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/jfs/jfs_dmap.c:1375:27: error: expected ')'


Tested on:

commit:         6f3b6e91 Merge tag 'io_uring-6.18-20251016' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=4b717071f1eecb2972df
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15617542580000



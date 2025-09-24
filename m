Return-Path: <linux-kernel+bounces-830363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E21DB997A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7662D1B237D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C142E1C4E;
	Wed, 24 Sep 2025 10:46:31 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF4C28AAEE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710790; cv=none; b=NYZZ0ildVGapYirbpQogFcFoxiuq4kX/n0qxOQjPjtdqBE1ypBZXsKkkXjS87xFUWqQq81X1Fpf3WM13wIkV0bZer0HmJlYDGpAYNBgWN4kX2+cAgjVCRWNLHXNy/UDYXQNcx3jP5yIYBFAfyDSz9Nv4uEX3mAMvTpftCD+VFQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710790; c=relaxed/simple;
	bh=vlPY4wX6iz6/QFHZe1QoD92qgakcV+5BxQRAIfGul8E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=hjPBI2vaHMWldjfrLxRjIQ4yrKhk1JJ6tQHRkHhMRuhmbKUaDPZYJaPKs1oZ5XOXbDtwnnt3T9Ty16FhHFb30AIb7mW9YrAgtRwaJatM9QhD3jmtdMKgtHubp5vczp+n7AUed74yCgI0IBFcH2ne+4YESHCCl5+Zaw0LZWfo3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4257626a814so56835505ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758710784; x=1759315584;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlPY4wX6iz6/QFHZe1QoD92qgakcV+5BxQRAIfGul8E=;
        b=bfibf5CDFpWYEqhCwLuGE0gqEGCCqLfV27WKIJL+j2Yswu+2mMayjCj7D0LKC6x73y
         gBOsR+mlZGSacw9fwpn24IUUoBctgz5fHS6rpNuVrKle7cMHSNrwmpzTsvYojZaOahQP
         5XGJc/srVr4gVUN13YOfrA9xVc15iGBgDtzELWv/ficMdp6BAaJLMohtJqDrkmXLsi//
         7MPNfhftRmWUbOEsUhFreSSZhOzd/uFPaeTLbr+evpO/28ICw7ZXsjv3SWXLq4lHFS6X
         b+0LsD+penBYocWe2UB0havF0yen/m7h8XRI5+1AuONVkPY9gfRIOP6UNC3SzBPuLnXb
         9fqw==
X-Forwarded-Encrypted: i=1; AJvYcCUulAiUGV3PLhDp0iQ8rR0QTUMmc8seERI+5CU+BE+rQenmEgC1yApzdXQgJCFbH+gnDZ91K51t+aMSzhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMtawnU5tl80JVHWX+GmRT9qCMOlwnAjVgBY79Z0qk4Vnv45y8
	xaYAtSaY0UK0ytIpdmQN2vYynFtHT29ZiW1VyZiYq4il/Hvto6QauTNKhQKx9I4hkjfEXr51oyZ
	cFtUq+CLp4lQRIJamj4wOAR7YLsP+E/ziIjwAnEatByUF4Csenxu3KbFMnaM=
X-Google-Smtp-Source: AGHT+IGcj9OmeXhFE4Cp+TzIHSDTkXVsNdbRc2Lb/PoahYANqFbknCT3yzS2ylZvYa7Y6hmHi/tN1AA7HB7jE7MFykqRbPRL9Qma
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4f:b0:424:81c1:9474 with SMTP id
 e9e14a558f8ab-42581ec5668mr70091415ab.24.1758710784714; Wed, 24 Sep 2025
 03:46:24 -0700 (PDT)
Date: Wed, 24 Sep 2025 03:46:24 -0700
In-Reply-To: <tencent_493765F76026C1D371C370C96683B6C45405@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d3cc00.050a0220.139b6.0030.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context
 in hook_sb_delete
From: syzbot <syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com>
To: eadavis@qq.com
Cc: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: none

want either no args or 2 args (repo, branch), got 1

>


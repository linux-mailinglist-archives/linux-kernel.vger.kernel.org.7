Return-Path: <linux-kernel+bounces-865958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4FFBFE6AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B67A350CE7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92E5306D52;
	Wed, 22 Oct 2025 22:32:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0963F306495
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172325; cv=none; b=K/6aCz3dUsZclK0lKYs450slJv41hMBJj+gkyOWOxlML0TCEwgSU3GiiqgorR4W6W/VhPsES5CRX16mNhoLgB43gjdiHAunV+4QQQbVCY17lOM9DCGjQbDNIw2S4UYFoMXWVUgpkPfjBi63ABi9aRVmQtbQY8v98p+EEf9B5CGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172325; c=relaxed/simple;
	bh=pvWzVOStEGQwgHi3jA6touh8RrftYGKegfGz7Yq+Uc0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cfhJcubQdBrAYQPnVbzgH5uJvpiPFEa6s9Mu+G35a62962uG6c2m74cbVB6OWCZNTGwVcEZphnWrgYc6diE4Ko/v/Gtba4BncwYpfpGLizRljNCiwwFQr1hD1eIawXOgsJovUfQKFAmG5UCeF0YMeeJUy0zr4HOQoPZKo8/eyBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-940e4cf730aso28350639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761172323; x=1761777123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvWzVOStEGQwgHi3jA6touh8RrftYGKegfGz7Yq+Uc0=;
        b=igQ9SU1cy16H4ai6xMUiGqini+FJcP06DkgEKC7aKvSPtRL6LkCgmYlnKwYE3AUnUW
         YVwYO4QdkFUe1habgZCDApJ3IGch/fXxtycMN3aGB+cBSqmAXM3CB7W/71qkhkIuqRaa
         QHUg6GMQwb6yQANfgUkGNF7t8WJfb93Wr/dkUJ6IXGiscIskClkfukatIQzGPvt4ZWmT
         EwSrGwtHi/ZPjMWcTmAcUQD8UGbQJfpsgJxOU+h0/dt0UN4wizn6CTBGpCLBAPG43hlZ
         SOHMDPMxbJr7LgqF4lchc/9AlkIlF1NA+xZThK4XKisbmiPRv+wCe5fuT6YS5YER9s5l
         5tsw==
X-Gm-Message-State: AOJu0Yzk+R2BN9DICwLxrhd4KI0M6pfc6YlZWbLFXMssl/KC058bp2H9
	VW62O1YZjmgYzbNNqTl4dhVL3rgrw6c7K0u3/KxvRYeGrOpCb1sowb/REyUlMDzuqMRepQtJfxz
	kZxo8xV5vb4nxsUqxcd6GH7K759v3eUd99Lqag9aAyTnorCGHRzJ0G8dpvmg=
X-Google-Smtp-Source: AGHT+IHOkRyM5tHa6TND5ryzDGlGZFpMCF+j8+2izilzDUQOraIZM4ZzEu2OaRkgXyytbozseyEXdv7L8KHjziJPRS3VD7qJMQvR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0c:b0:430:b1ff:74cd with SMTP id
 e9e14a558f8ab-430c522d9f4mr341514425ab.10.1761172323125; Wed, 22 Oct 2025
 15:32:03 -0700 (PDT)
Date: Wed, 22 Oct 2025 15:32:03 -0700
In-Reply-To: <68ef003e.050a0220.91a22.0229.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f95b63.050a0220.346f24.0069.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [gfs2?] kernel BUG in do_xmote
From: syzbot <syzbot+353de08f32ce69361b89@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [gfs2?] kernel BUG in do_xmote
Author: agruenba@redhat.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
for-next



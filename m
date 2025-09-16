Return-Path: <linux-kernel+bounces-818473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9295BB59236
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75403A4C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B03829AB13;
	Tue, 16 Sep 2025 09:30:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE1427A92A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015006; cv=none; b=rebm2PFlqUMXTQdMctSQTqZnE1zOpEdxoRqHbmXsjzNWNK5aiwCWGz/XuQ71wg5dM5dyW9naxyCrmPIAjfJiFdKf2f9fR7cgNjXimOphkDoZEP5XdCkw6Wxg2aBrHAga/py/wdnWbsRIUm/6acgPyXMs4GHdFUdYilx2iEoQmLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015006; c=relaxed/simple;
	bh=h0GFS4netn2g7q+kCiTJSCdPFaq5Osh6HgATWTRnFOo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rkuHVTuE4GGpbq8wYbcLqPKmClXydpqjqB+crDYmOvV+dSZfUDZnV7nmr1PjvlzyixntMr6rFaCnSWH95D1X1RJsBKuggp4GIFcagfCEeYW+0DDpXuSH6zcFVaDil0PZoaMgRMb5teApDFz0rPilqVj5WGnX30rn16XHD32I7Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-400bb989b1aso169301555ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015004; x=1758619804;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5z//DIkbOSKstGPfsK/oOb9sQP56ONMueHPNYK4aR4=;
        b=qBGXETJ2uJdyylDhENyTYrbMqj2mI5uCoVPbc8hwc1h6Yi5WBT9a4KjYtk9A7oOygK
         EyXOgelrz0HHIIjZWAx0/0weFs0djaqsxuOwa7TScovE4r+YchufOKG1/2wUZcP1LsCz
         ibG+Cv2L58+rSEwk9qpPodjvnTXx6E/cSsOMjNESZa65AbDsA90vvmOOAC9+z/Z4L8Pq
         Mdyb95NP5noB8mn73popdSBDp4x+b932kqwW/Vd8XnsrNUwXYeBY7HIR1xnWnHHS0Vbm
         TEyQLaaW6sY6WnK1fKsObSb5Hi0h+E+DP8K35yItkFlHwoBc9IQws4MIYqlpG/Zz7BTx
         8XOw==
X-Forwarded-Encrypted: i=1; AJvYcCVlrjKNJSNBqpGW6/K+K89kkd2DNwDYFOVWw1R/aDTM7/pdcpsyjy8Yt/Phf5nX2ncPLRPjYQ6Is+i159E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmrHlMPXNlfvmpHNvXBnn8CnxAqdNz2bOB2/9hWjd8iAZQ7pDq
	jqleImObi+7Y8MEIEIftgpD8Zoo3Xx2rNviA/WMRFDxerNPYoZ2Iqm1DZAKFg1wbBkRSKmQT83g
	cd8F9Lmh2vwqB956wLR7JSPMf1IKWFcvPMMu02whKmYXk9uqG1+hg/8iIK18=
X-Google-Smtp-Source: AGHT+IG1tIG0BnbUPWVspbgw7zSN1aerhiz3aPyorawhOOGyO7qNXtdqfQCbdSbL73k2yPyo9lJqrESPiz1Xts2QcKczgvlGAoQn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1886:b0:424:a30:d64b with SMTP id
 e9e14a558f8ab-4240a30dd29mr38740815ab.19.1758015004340; Tue, 16 Sep 2025
 02:30:04 -0700 (PDT)
Date: Tue, 16 Sep 2025 02:30:04 -0700
In-Reply-To: <e0650e39-f555-4fe3-8c80-cddc6414a449@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c92e1c.050a0220.2ff435.03c0.GAE@google.com>
Subject: Re: [syzbot] [erofs?] INFO: task hung in erofs_bread
From: syzbot <syzbot+1a9af3ef3c84c5e14dcc@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1a9af3ef3c84c5e14dcc@syzkaller.appspotmail.com
Tested-by: syzbot+1a9af3ef3c84c5e14dcc@syzkaller.appspotmail.com

Tested on:

commit:         e8795f31 erofs: avoid reading more for fragment maps
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=11137762580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4239c29711f936f
dashboard link: https://syzkaller.appspot.com/bug?extid=1a9af3ef3c84c5e14dcc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


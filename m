Return-Path: <linux-kernel+bounces-730978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB16B04D25
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC6C7AA9D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF3019CCF5;
	Tue, 15 Jul 2025 00:57:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E01410E3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752541025; cv=none; b=GB++phqP7AkPSC4yRfAml3QcIdfZIkb8lI1kBzEsBhn+p8j26gyDnfmTF69DpfDyppCzn4wr99IRby8aJS9/ioAL6QsTZDgqNaRZUUCUhMX3LZYx3FkFz8JlpVFrkyEHAjtwGL7calZjqdLdcDUD548J6n29KVdeW7LOmfBeBQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752541025; c=relaxed/simple;
	bh=0SeqKsp0UJ/jK+f4Ysb/fuAU+pqSH2NJSTmYCt0teJg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eHKe6VDLaiOO/uhSoEkdj/aEEFA6oPs6UzyKNsCR8z35Bkdz9TaoxrehpI6DZoZP81S7hbGLmpnYz/xN023R8QFxyFkSi2OUmI+2Es4JZIq2IzNjazT5KLu7F93p2GGWlWFsqRDnqM1t6UFn4uKxnl8r41Lx64p7BlYVCEl/zuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddba1b53e8so62767425ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752541023; x=1753145823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lA66dattmAD82VK5PUKSY+Pdm5OTxEwb+LTbX7T2jaw=;
        b=V6N6XS5+7f5ZgoMANDxsRJpZqY3MlSDw3J9kSmtcUTrgbQNuO1VZHMtq6CORnPmj1x
         wnk4AC+oyojH/aLHIg6tSKXgkXpTC47Lk+EjDMu3FGvsj4SYPZWAOeXwUfqCID3BBGzO
         shn6BEZb7O9j1g5uBpwTLMqBcx5EEni/w8nfKfXZudYVLIAwOcuCFjsPZHAlR7O3fNq+
         c6uAZJgbhjAQ0okc7M+K0VcodAlezGFl/S969xBlBrIHtTQf+mg7xeETEyTL7syGTWnf
         /w3jW3BbdPjfnnWbvSaCVm1M+voOAOCe7X4UOENByp0woGfBa+Qv7sz4VL9GdQUSv9u0
         IPVg==
X-Forwarded-Encrypted: i=1; AJvYcCX91Wu0caR2AWjlNfMGjUc+nYF3vi4FB2utmZF7prqKkwm6nhgrF6fTwZPJabVxIAj5jn6CuGFBKmO9UeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4VjancT+tvnJnVDYBKe5ggH9bf3RvsbbOzTHcTxISykZvoq8Y
	nkyJHvfiIXPWtMk92m6EB5Okk7hn24QxGz9UM0leHjuWSjdpaI472AGt9AvmEalJIKdD1pwleny
	I6gs2a7QZPf8KIhg6qAPGDLfdKCCxIsP+BHizTUdNgVnfbmX7++AK01srSVU=
X-Google-Smtp-Source: AGHT+IGK/NZ4GcZt74U1Qg7QxKlKFJGByIzzfVIx+8+MlbXhqCTyBtZCfub1QqZgZez28RCsGux27hlRmGCP0fKsvdSobUDuzbxY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3190:b0:3dc:7b3d:6a5a with SMTP id
 e9e14a558f8ab-3e2532e9b23mr153405415ab.10.1752541023623; Mon, 14 Jul 2025
 17:57:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 17:57:03 -0700
In-Reply-To: <6de8d555-b080-4c64-ad97-67361dd7aeec@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6875a75f.a70a0220.5f69f.0005.GAE@google.com>
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
From: syzbot <syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com>
To: inwardvessel@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/cgroup/cgroup.c
patch: **** unexpected end of file in patch



Tested on:

commit:         347e9f50 Linux 6.16-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=84eae426cbd8669c
dashboard link: https://syzkaller.appspot.com/bug?extid=8d052e8b99e40bc625ed
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11bffd82580000



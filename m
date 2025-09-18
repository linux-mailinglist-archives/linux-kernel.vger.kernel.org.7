Return-Path: <linux-kernel+bounces-823558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B92B86D72
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33B81CC4346
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BA12D191E;
	Thu, 18 Sep 2025 20:09:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796B830DEDC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226145; cv=none; b=G8F7RBGVETQo0EJ2IVGPD5fE7Y9DESuE8szRT1D7skdARO+WRp506jDOkl61q5akKQjHq56GbuQ7WfqHl829BFRb0i+cbFqW+YB/l1N3QQUMrIMMj5yrhE8Zlx8U25BmIq0VtBapQQOW43AMaYxaMZSUmEEDMR8IyTFXT3sQZK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226145; c=relaxed/simple;
	bh=K/0RY+U//lNSiOUOsEZjBiDLkc7SGRjh8IM6gTefKVg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pbkhnO/YP8XChQp3eVS2q8Cgb4wzbTNGmcWuWjRmWZ/vvdb2gPOHd+TUcZ7q0gb3S7D156jwxqAfCc93SaL8Rn4+jhQ0gfEivmrA8/shOqfy8mJtVUBmLamdC3AjhmM0ionPvCy9x5OTy2cAgVehDbOCYyiRjDMo0FW0dm00n8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42408b5749aso35039505ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758226142; x=1758830942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=voOjB2OWF6sLn5E5FBup+jJRLNg94HSD6qLWSkazTrM=;
        b=VM+RRD1zZt2RVBj2E4xCZuErk1JiuioL5dAS9NBqs1tvo8xHrgCCSlg43InzreQEIp
         7uyGld3/Us1UCIxiU1gZYxaZU6h08IZW/9xu6WeuXzEa2X5Z8mkPWXhHPKtVN+i8Mzfi
         0ScI9OB5gjR1bs/T2vnTpsR/0mrwThhB19xryDFX8l2OlOpX5TVzou/Vf9XFopLBsvuD
         fO+MxdS58NxKJi8UZQfmSJy9UUqoTDR6+TofbtzzLMI+s05PB6UTu+fP80m6ceLKeuxE
         kHfDloVleh29UONsUSWIjRa1N3Boe8xh7CYpLyF8GGGLEoC8Oydp4ha0vanKhkWcTKHO
         ffcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlRUMP/71CwXtSHQ2cGE22JHgqt/PGyZLrIOMTNgC7D922SzwCn5WI8cCWdX8YDfxAr5yj1Q+JFyXP7SU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy75toybBvd8F/O9kPaKdyFhTEtNyEbdp/BrOt90ty08n+5Ixct
	wh+VKK3axV3OURoM0Ao3g2bGB7L/G6xpmLZ64Jo1eONFRz5AufMIfhG0FObl0aHKghxIWiul0XF
	+q28WTJTx3cFmdGKR8PJnGgvvWNttXEo98AlcdSTItIwdHcnPl5zZaJ0QjWQ=
X-Google-Smtp-Source: AGHT+IH3ZdFuIbjPRLldK4iEpnPMlB3ZUGt6lBPYBhiH+FqqHkTG/VwQqTMmqpKt+XPWTUGctUztPYcOiFDy6xCM4et1nFiZA2l3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160d:b0:408:6044:8d1a with SMTP id
 e9e14a558f8ab-424817203d1mr16617685ab.5.1758226142635; Thu, 18 Sep 2025
 13:09:02 -0700 (PDT)
Date: Thu, 18 Sep 2025 13:09:02 -0700
In-Reply-To: <CAL4kbRNSQxepAdHvkqS21qvRm2m1gtO1mKi90=QNsmetDB0jQA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cc66de.a00a0220.37dadf.0007.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING in gfs2_ri_update (2)
From: syzbot <syzbot+7567dc5c8aa8f68bde74@syzkaller.appspotmail.com>
To: kriish.sharma2006@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/gfs2/rgrp.c
patch: **** unexpected end of file in patch



Tested on:

commit:         cbf658dd Merge tag 'net-6.17-rc7' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c6cf62580000



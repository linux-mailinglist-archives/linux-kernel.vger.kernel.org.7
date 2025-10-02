Return-Path: <linux-kernel+bounces-840093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2D4BB382A
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 058B44E13B8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9361E305048;
	Thu,  2 Oct 2025 09:48:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FDB2F1FCF
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759398484; cv=none; b=e1S3sQyz6eFdaNZJtVQ+o2XUnP03r+lFttJeIg8IfjtPRBU5RF00WZ8b9Znw0P5tnV3c/llTHZdA6IhjbuUqa+ZBGewseWNT5Ck5uoRe8+8PsYzboL3E8WpTLvJOFIkIfd1sZUYFhOTTp+T07GeHA/zXZiLwTIbShBekPwgI7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759398484; c=relaxed/simple;
	bh=1cbIbiqAVClpA8TrMP7DYoQ3puZfri+8yBEyuaaorjc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kq9UH7/1LRzQGd7F/Kk8ztl4lYYb9b1CSotjS1l0ez9et9+uBtKY8xPHl8//JFo35jbTlFGuoj+hLmOahuhFGD3ywevBN/Ck7ihQmlQ4V16EeeTCUa3umnXlgz25pzrne9EvYGjgD+hSJ+TJKCxWJoEgCUQ6IEj6IfO5cDmE+Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-91e1d4d0976so191895939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759398482; x=1760003282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhjzZcahkPy/0vjAu3K17rt/nub1ZoKaTIni5sV7Mvo=;
        b=hT9bgw5ZrOyVcT3728YbwzEQxBYQDYSFCUo5rpsAVrDozNT5CRZ8GZ+pzGAKnOOY86
         Tc7H67CI6o859lReF0elOaCitQ7oBNz/bneM38qtnanGEmXwQ/1yYt4gNdYos9SQx3UP
         qnKGSL5pIwsPFUE7WyTh+kNkQPzjEG3Boa+9Pk2D6e1UHwbiqoZ5N57MJZ9r5DAT3WPG
         mdZ+dtqee3Tu84C5lz73JUOsdrFLMQ0GAYrJ/ARmwwJhvFRN4a4ukJU5Mkc2G156zqTV
         ZftLb44mstFSa2QfTCIHPoG0m/328Ng0BUa3GaoQwQzmFrKjUzNT0yLAyND+w9oBw1At
         wk1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW65PeojtxMzm67Wp2ZXdCoXNf0mZyxLGRTwhuSgoqzwhDJ28QtA/PVB3ry4xvRYmPDb/ydXLFozMTlpFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJumVdeTv3MlQ9TfuUk+yyPSfNdRZHURXHB4EdKQGinE2o0Eh
	SY4yVU+xBnZocAmeYnfQuH5E+bsmLpVd+mlflLKFW1sXYgs3qMkT1WlqixPm2w/T2jHNx7keD8X
	pVW1Nt15fe+oFtlfHanrDB3RdCXlGArlQqgtg3YImk2qpUK5TGsnYZL0DOxo=
X-Google-Smtp-Source: AGHT+IGpjTvQ418bAH/miQpEmycK6RHiseZxGhkUsljiaZXRRuCSEJ1MwXFvPQMx/58pE+Lp8pzxlEOq/XxvzwosdHTNbvZ4ah1+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b81:b0:8d3:6ac1:4dd3 with SMTP id
 ca18e2360f4ac-937a87f9d2amr850839539f.6.1759398482012; Thu, 02 Oct 2025
 02:48:02 -0700 (PDT)
Date: Thu, 02 Oct 2025 02:48:02 -0700
In-Reply-To: <20251002093807.2387597-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de4a52.050a0220.1696c6.0030.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_search_dir
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/ext4/xattr.c
Hunk #2 FAILED at 251.
1 out of 2 hunks FAILED



Tested on:

commit:         7f707257 Merge tag 'kbuild-6.18-1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee1d7eda39c03d2c
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1676fd04580000



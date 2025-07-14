Return-Path: <linux-kernel+bounces-729270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F16DCB03425
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 03:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542063ADFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 01:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E5619D8AC;
	Mon, 14 Jul 2025 01:17:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740223C17
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 01:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752455825; cv=none; b=XEGLJrfEAPn2ZJttPC2Brg4hv4jkjTWJneCLd8khcZB0VkdzmhqliFtKJRsRgwjdWqkz+3C0bh0OF4biqLBKfbphdOMnrb/gzaS9rMBjQf+Q92pdQrBDFBTMsMr9uSAxUFwKNzJk49UuPHTFrypvMazhOKkFTvYJNOGooNhyNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752455825; c=relaxed/simple;
	bh=JxwukT9viBrgYB877CKwk7yaZR1dcr/A9TcLbp9ZBJU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AAjclE1BaOpQ4DYAFmVm2vfANPYKC1DX6/bK+UzmE1O90cOzMZ8ikM7MTe8cADjezwlaRb3WKRwR/75sdi9hU7WrfenWP6XHIF2v8zdFQiNXyMBJIw/6YzRru7WqknEj4iZEjujFbt+ihkTvoGlkJK1LQYC+MPP9WvVjhiuoxkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86cff1087deso796508239f.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 18:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752455823; x=1753060623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJtH1dfcPTgli92z0MSxdE2N7i2flmlAatjHD0iAHwE=;
        b=gWGL6Dgwd3k5NLsYcAlImq922pKm1DF18cwwBws4nAMZOKhIEOryisPH50q+rAU8Ai
         1XF594L3HpJw7wcPrOxz8xkGYuGJuJL2Gk/lIpPuQLW/SS+1pqnj+rXvAJMynwkqgUaA
         gRYTxTzp2sY/ocXlm+bd2rU93cCKDV3apNnG55AXSuhlpYyaTSTIwmM+4yN0H+A017i4
         vwpSLM+Ttm3PA1GpqYB7pUqnm9MkhrBLkzwo+seHfFEMSSgbA8BpWugr7cXUC4upOIBq
         Xint6GK5a2EjN53kU5QgP/d58fsyoJkjEWj7VmmPHZGynFNDo/U+2ZnGLG7453hOUXzx
         vxwg==
X-Forwarded-Encrypted: i=1; AJvYcCW0bS1bYtU/X8DfCd6K+zsfsFwlxSZ5+UeEhL/mkWfQpVGiJ8vjeV0g7nw3IjajZ/43Wv3WYQU5xxbIyzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGdR9HSACfhGf8LOUJks6ic53TPYvOtiE5FGNFQkSaisym80qg
	Psltj+hj9NCDlJAKga16LwVxcJIKKLvB0yGpxA0EPA1ijXvsPiL98isAb0g/Y6k7g8SD+Rc9yo3
	4K8CPcFTAfT9Kph0eaJNHIW6SPnJWzo1d+K7iaXRrA27I1mrM72218AZ0sCc=
X-Google-Smtp-Source: AGHT+IHRJrHlMOOlm6vfZ43x/qEwrpSqikTdDwU1gMTPLP71eUduZytt7EXg73SHWTGgioy/I1DfK7TonSag8gw1sJ1OWPfzLf/V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c95:b0:861:d8ca:3587 with SMTP id
 ca18e2360f4ac-87977f7198dmr1385241639f.4.1752455823637; Sun, 13 Jul 2025
 18:17:03 -0700 (PDT)
Date: Sun, 13 Jul 2025 18:17:03 -0700
In-Reply-To: <56cd61d5-b821-4481-9f67-1cfff01abfb2@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68745a8f.a70a0220.3b380f.0040.GAE@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbhid_raw_request
From: syzbot <syzbot+fbe9fff1374eefadffb9@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/hid on commit c2ca42f190b6: failed to run ["git" "fetch" "--force" "--tags" "aadfd0d36b9bffe7aa2ac681e0723ea26b0aa18a"]: exit status 128
fatal: repository 'https://git.kernel.org/pub/scm/linux/kernel/git/hid/' not found



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/hid c2ca42f190b6
kernel config:  https://syzkaller.appspot.com/x/.config?x=76c2fb9aa0954fb8
dashboard link: https://syzkaller.appspot.com/bug?extid=fbe9fff1374eefadffb9
compiler:       

Note: no patches were applied.


Return-Path: <linux-kernel+bounces-739934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F852B0CD50
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB4D17CA07
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF6724110F;
	Mon, 21 Jul 2025 22:35:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED03F1D63E8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753137305; cv=none; b=m2Q5+/+Nxzj5RkRqAU2VfjKIviIu6YVdZJhzLhs0L61F+qTW53dzUTXn3ejXT1s1ctRa3DGqrPSp+adi9IjyJh4MzL13HhwJEFph2N6vCgMKaCPEOo9L/a+sugBUSJXVgY3lLrXKY/vh7ITOVxwTT1T1qiN9CPV+bsRYkYfkxXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753137305; c=relaxed/simple;
	bh=1Hya+ujZVaB+jHFrOowLxbBhMlZK3Eb1wpRpwn/nsFk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HZmF9pKZ61yhf1JwQn6/4z3sfgicF3Mic3Dxyc8C1c/Tv3HZWebQCjRk/QuHlcd+OBPm57IiVCyyAEYgxHEp7TneZPAGH0WzKHBWl8fXwsiK/eVaEXd77CLqTdpC/A8G5A2nvYEae6COh8nHEYyImBh/wDy9HWNjwrHNnuv09Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddbfe1fc8fso105788335ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753137302; x=1753742102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1/D6Laf5go+T7dw3ubO0c67xy6Aq6QnUJlPl/o1Jug=;
        b=B0fLzDg4lifzFfV/gs5hQW8Tz/Vga3MQmlMWVBWqHQtQACw3SoMdsT/L5QTkoSfzLn
         yycixUno9dsJbrxPgSReUE4SAH7zPuy5jBmuo2S3+9xrNbV6KrPkhmSpDfa1hy1tiEQx
         q1Y36zzTuvrJpwUMPqw+BRsGyiW5T//CmDZIRz7dSDR6tEd+5v7X5h2Ew/OirrGaHZXx
         vFFfwFWuQR0PNuQROQE6Wkla5XhGE1XbNXv6YI8U9OmYlRqhYMht9UWM/wu4b3gYPA/s
         2agNB8M0vUh+bq3vf0Rta+Yl+Y3MuqqBHV/X/hExz7Ss+Gt5Q0WyJwhJfYC+6odYxuRQ
         dnOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVebUQSG0hUIPls6EAmmO66A1FVRi/S6lOjF/IkTh3db4IcRHsX3YvqQoLuC32+7LY4rnuZSj5bNUnqnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws8XCcoq9r5djFWtWKcrnEMUsQ8dHJqFZy95phCUEcbWjCYfKh
	al1yF91FkwFMVhGPxK0Ww7n/EbRxcwJTw3Rr1HcRtOIjc0OriINNYDAcPEIwbnCXHx+S4gcsNpa
	CVEOLxm960Rzr31Y4HoJEQizdSF8rOPn8EOj1StT5Htn5zs30FFzCtjb9j2s=
X-Google-Smtp-Source: AGHT+IH/jMeEZnpFMv1UrYQSNLlM4/hDM7rBRoMVVsPkr96Q7p7hOT9vn1pPDubGDVtZEteAwdBCJPp2T0Y6WC+yJthIwHk0NIOL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3cca:b0:3df:36ad:6259 with SMTP id
 e9e14a558f8ab-3e2824eaa38mr266291825ab.16.1753137302056; Mon, 21 Jul 2025
 15:35:02 -0700 (PDT)
Date: Mon, 21 Jul 2025 15:35:02 -0700
In-Reply-To: <qqkqypzrbb3vyc2lm65byfbel2eblpobx6zqityolbzhy7y4za@mcovagqypg6l>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687ec096.a70a0220.31ebea.071a.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in l2cap_conn_del
From: syzbot <syzbot+b71bb48c13bf3fed3692@syzkaller.appspotmail.com>
To: ipravdin.official@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b71bb48c13bf3fed3692@syzkaller.appspotmail.com
Tested-by: syzbot+b71bb48c13bf3fed3692@syzkaller.appspotmail.com

Tested on:

commit:         0ba71474 Bluetooth: hci_event: Mask data status from L..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17af8fd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2210d0e1e4249b81
dashboard link: https://syzkaller.appspot.com/bug?extid=b71bb48c13bf3fed3692
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


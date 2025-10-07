Return-Path: <linux-kernel+bounces-844858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C912BBC2EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3153C70F3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92D6258EEE;
	Tue,  7 Oct 2025 23:25:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063F8235C01
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759879505; cv=none; b=efhaPxzc9+N13KO6ukWIYthW7PqCGzs0v7QVTvubJpTrOtJFzfblMQtAO9u3SOz1H81uIa8Sl2DE40h10ve8ofrucHQRR/tKAaSnQER1PMTJGoij3WCo7EDzXGzbqspFpHUTEMaDPy7EP4y9LG7pbNRsmnhL74UVU1oLMw2BuPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759879505; c=relaxed/simple;
	bh=3mqLMi8unCYBtqBS6sHWqUOKQV8pcV00WogRpanNdWg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FU/Ph1VOTNBTqCNNMNksBGHl7F7emAP6W1ZjAy/F2/NUQrAsJ1Aqg5SLxgfuDRFsVHYTrm7zANCYvV25XRnglEI8dLOKABNMp9GDUoSHJhpInwTPY4UD3A39hBNF51pHa+nRw+B8r8nRqVGk7q7kGjXI4Nv4KN0Ht941+5hXK/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-90e388db4bdso407365739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759879503; x=1760484303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoP/K6iZKVZg7llns/PNRetmADP3Jh7y64NwgSYNlNQ=;
        b=vJQlmWjrH336fpDXV8AhufNG1g4EfTRuI+sWe7AYKLOOSf3BQ2iugqycIOA44oMkAQ
         /tR2nJB4GaylMIAQTN0ME1AY4420NnPL99eP2zOvERpV0EzGyUxsJ5Nngw5enkEYGoxw
         FqbAYxi90HAnRPHo5GwIk2dvMGe0+hGfAGYFfqhjL7zyL//gi/RK6xIXx91eaSvMz8Nk
         zhZK3Ub7CPG0rcePPosh/AMKNlBo3uwPtJi8XSqoFOjykZBHSTrMu97wZSl9DciN+BCb
         S/IhgfiXbH2yYZqLYut0JLWWuPxXweLzbYsmmPK4SX3okh8leCe/+iDCPawIe8iRp94Z
         ssww==
X-Forwarded-Encrypted: i=1; AJvYcCUuriSv2GEOpGU1X1IaNhNi4TA67Co6XL98M0VIhAGAmtWRdfCch7+ie9tODuxESwUjCBXM4Sy4a9WRFsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfhKKFgygUznfU237moMjvvH0HwamU8rWTKQaUmtmEMK3TdgNf
	6ErpauCDqblQsv5yv4/5ytasSpcm5N/jWObRcHA33nWfTdK1OEdrTN7xAEx2a9OHeyi+6BcIxHS
	w5IC95wYAWLi6Q05sQgfVRFfy0HJm3blV4e/45qPYiBtWTyDV48TX18Agj9M=
X-Google-Smtp-Source: AGHT+IEjYzlmPHHuvKttQ8YfsXsMOY93Y5N3wS5MXIAj2Q4cVyJMUTzVz9FqyHGKkvdaVYvYJMwTXRFtBlCwP2KhRMcPdE5Popta
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f93:b0:927:be17:389d with SMTP id
 ca18e2360f4ac-93bd1838538mr148722439f.4.1759879503079; Tue, 07 Oct 2025
 16:25:03 -0700 (PDT)
Date: Tue, 07 Oct 2025 16:25:03 -0700
In-Reply-To: <CAHxJ8O-VdrVEyCpktyUnEE-xwsN8poMvYsXsmQFfwvxi8f-E0g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e5a14f.050a0220.256323.002c.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (3)
From: syzbot <syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com>
To: eraykrdg1@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
Tested-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com

Tested on:

commit:         a8cdf51c Merge tag 'hardening-fix1-v6.18-rc1' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=139b5458580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18b333076bdf1c20
dashboard link: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=166b7334580000

Note: testing is done by a robot and is best-effort only.


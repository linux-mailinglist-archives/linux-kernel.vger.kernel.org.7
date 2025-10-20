Return-Path: <linux-kernel+bounces-860278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BBDBEFBBD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3302D4EC8B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E662DA775;
	Mon, 20 Oct 2025 07:48:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060C91F463E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946485; cv=none; b=gZUJ2TOx+0x7wjBMnGs/POnOmeDqPQhFdKCdmxTnI7xPH9VJca102NvXqm2vRUUZNUx0tY7nnbw9Vt/xsSRnVrBJ6h5Hw5gdHCxVPnjSQYA5w7B9aw5p/NZBLeyQTfmmsrcGudWbuCVv/tb4377NzJig/mMSqzUsV8EqxhLkKlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946485; c=relaxed/simple;
	bh=8UrrIpoflmEZcADGgNjO8rBgLyPHcdaOYtfoz0COulI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aYcYMGckGvkFvDPlrgP14WMRrS0msArQpvNTr2Jbz3VQ0vHbXvSKBsszUUirIUFMXv4Ce7YGIVoT1/1DcXwE6rxB73wuosFQ9vy4PrWrT7xvce/wi+u9/VDDJQ+sSgGjpudwpUl7O+Zi3sdXCgPehJIoG2xRRWhY31EUwUAaVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e8839f138so187302139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760946483; x=1761551283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbXsIMvM9AIk95IBB1uJ7SoFHGqahS4Is4cyVgJ3PHg=;
        b=FKFnH1v418+2NKizChP5PXlssD4TTkBJrOJq45WICZepI5AVylXb7QWSYKWUYVnwN8
         BIXQftlf5DB3pPXf1pGZAiOhMn3ze2IRYfP9+G5LUTD+awFJdt17SuWk5nuHEXFStwVD
         ktEdd/wGaWVHQwGwwoEpqdiN7Dc3HwMp0Gw2bGvKJ5r3IKYZrNCAzKsMsvf9O53pe9AY
         7PfxwqFfMvibx0rKj9XxdVjt3newbxwcO57hcqtmkeoHdbNRKpNIyODl1gFX4rNg2ez9
         DLnqdVjUDAEleAR0rvfteJwo8CN8082eV6q7LDg1Xzd9r/xmOWTywIP75P1GE49KupE+
         5h+w==
X-Forwarded-Encrypted: i=1; AJvYcCVuFkedq0VPBcFKgngz8Pdzto0r0FKiY2wPFYDcwrKeGsVt4DgfUbkTYQwS+g2FVfJe9PHhoas7QoI8lsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJP/cNh7zK6mStWwMmDP3RxYY8/zAUJOYmI3wjTtkQlCLjspz6
	mps6JeJTNphOVcMNKtUnkM6124lMCqtCvAvLec7+Y9toQksGrLGM27KhOqff/6dgzv+8MHqscpP
	7B5Ftjhunig0D9IFCSnxmWLcddoAaWMJNYqDat57hY53O3b12ok4bkH9jXto=
X-Google-Smtp-Source: AGHT+IGrieDAbrQNJOL8vqJi0NN9jpL1v7reBNsZhJ/WI+vA5kUNYc/AcEX8WfCYKJqXtv5stuo7brkGnFLoBO/O6xH/4D3eOcHT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:148b:b0:93e:8aee:f98f with SMTP id
 ca18e2360f4ac-93e8aeefe69mr995989639f.10.1760946483251; Mon, 20 Oct 2025
 00:48:03 -0700 (PDT)
Date: Mon, 20 Oct 2025 00:48:03 -0700
In-Reply-To: <CADPKJ-60g+BtaE47GysMGQzAz9K3mMhUkzqRT-zFrnCRdFktHQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f5e933.a70a0220.205af.002b.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: clf700383@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/key/af_key.c
patch: **** unexpected end of file in patch



Tested on:

commit:         7361c864 selftests/bpf: Fix list_del() in arena list
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16776b04580000



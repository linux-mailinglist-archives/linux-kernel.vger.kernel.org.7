Return-Path: <linux-kernel+bounces-837050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AA6BAB2A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C81F3C627F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376C122126D;
	Tue, 30 Sep 2025 03:53:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B718287E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759204386; cv=none; b=D6JgaFTN+ulrk4men0xEOuh1nQnrqjLcn6QmRwgsxEOkbAFhmen0PVjPU1iOic3LpC7lYyqJWJ9tXw6HZuB9XeCBytSWv1bqB1d9j2BLGhsXj3Zol8odpZmKngTqwWmmnh7VJRaVmMvE/WaA11ewq+S8g+G44bV45sttByZpDuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759204386; c=relaxed/simple;
	bh=tkQ2hYtbRY1GCP5669uSWrP3gNCGwqU9WX8/HkhK/hU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U8XTd+haSgX5nQHb13D6e+HDUQC2lra4wxyMfDd9EDrc9CFlB1jMv/B0nAPhBbMbq64f8lCPUsTKBdiAbyK7Gau4W8LncG4fPA4pCyP900ij6hfoTtQVxWcycor160LHi1aS22Z1jRwa5xdrVoQLgG/vlOuCFxoN1ig/Kdiq9c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4278a8ecfa0so119400335ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759204384; x=1759809184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IakIE03+xhKw5q3YEoZk7SsJa46faeoGwcymfWnsDRk=;
        b=m+JYW7DBdKrnlISlV2W8Wok1JUEHrvq53vEwTNsG3wqaw0JlWRY8wn8wgUJeXztwCb
         k2k874/hM0cy5pQjZzIbRujOCr5JZ/9uOdjUtPTP4XLzbBqhm9y1x/g9eKyoGwpQUGR7
         MhARjyt8xSfDTXhzXFTAh5KJWRiaeePsh7keJ3ET11LOr9QdrMbmp5JHMVpCKrxqzJQd
         aATjlxD1dPSUuU5MuV3ayX2jkOUb8CSwV1IiuvREpejqbRYNUZeqozfAMjU5KXwcRHQY
         WfZeQ0mSq6eIoAJV4zAaXWbW3WwF1TS+hDg8jlU+nJQVkmZ2cI2wPYV18lLurMgErBbn
         espA==
X-Forwarded-Encrypted: i=1; AJvYcCXKiqqXcn6QgipPB1R8skLv0HrbHgDrV8UFkHqIH9bKorg2dA2WwaSK0hnygsEyYdwKiq1hFJkLrniSkmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3DrUPNLmxfM/47J97iBWgTFDuX7heATe/M/bWL8Kd2ocIslls
	9ZFxiQGZAKl2k/IjrrS2LQFuwWgz/Hne1S4plD/fkqVTe1okBB6DT+lSAsSlGh1lHumAQy1vXwe
	UJJ0iCharlbtbzeoa6jDdaIGMPgSy5Uj55DB1SS5/240YSCP628Upsrf8vKc=
X-Google-Smtp-Source: AGHT+IHAzaLhG1BexySOg0S5jMtHulZNHnsnWH4X8htb92vnAeYo656A0J1ludZEsic40eyuQSeCBol5n7oagiXinily6lGA1Go8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:481b:b0:425:8aea:7313 with SMTP id
 e9e14a558f8ab-4259563c0bcmr275920045ab.18.1759204384564; Mon, 29 Sep 2025
 20:53:04 -0700 (PDT)
Date: Mon, 29 Sep 2025 20:53:04 -0700
In-Reply-To: <CAAL9DyBcn29jD3zXqK5-NY-zJPqLE5ujdBPX02JE4GU7HVcwjQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68db5420.050a0220.1696c6.0022.GAE@google.com>
Subject: Re: [syzbot] [dri?] WARNING in drm_wait_one_vblank (2)
From: syzbot <syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com>
To: chintanlike@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
Tested-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com

Tested on:

commit:         30d4efb2 Merge tag 'for-linus-6.18-rc1-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12486942580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eb55ce880562a8c
dashboard link: https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b7c334580000

Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-864760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6949CBFB7A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E683B1EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFE332549C;
	Wed, 22 Oct 2025 10:54:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B117F2F363F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130448; cv=none; b=QXPhX4v9g5jtnCEHJs1olG81mojTudXe+QH0K9h4ZiHLLfQVC0hh/ThomgCX2ZO79zEEJUK+5oSiU8VT6d3vOFbnWP+eDbR8NjYsJLp33KFGpzkxfpZs3acROyHvGgCuowe+deA1zL+CQ86sXxDVlpVSGTu3JxguG9wGx64Ikk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130448; c=relaxed/simple;
	bh=YHVd2CJRLwdWpuyVn6bMGQrYX7Ui4wr/jYNQs+OHyw8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XY3cMUPlXHTXVdo5MFj+K5fnnuH9q6CY8DmMU7332awVKjBpLLsJxDSebOqpXCguYANjQVCoVj/KO7SN1EGkEoDGmPLNq8Wire0/edJ7PS6Ge3T8GCMKtTmLzwo24EYusE42tNn5QdFk6bAZwEUi+tokIuUtSdbeDE9jPddA/1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430cf6c6e20so60720175ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130443; x=1761735243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKADYd98ihTh+c+m4upK4clzAEmrdd6108yoWSCzqQk=;
        b=feuzLUMLgvm1rh/iTv4J1jfbBO2EzQXKuTreK+YHqHJ8cGqY8LzUqdsRW6sKf/qsq0
         lDjr2XS5IZqrh9kx4626vO3PJ1oUQcjR54NHJ5d9XyDNg0cFxalPkOcoUWEoY75xbT7o
         63WEZljGTxzJ876j7JfRwmy93gt7fbsYr5izyhy+FG98xlnjXeCaCCOYBHIm77M6t7eZ
         h7IpEoB9QPbqxTVS3zqaVPGAUz/b6RYtk29uSypKoXPET5prG9F9aMEmpO0ZAI4Jh0Mu
         2FZmiJ7LupvJvsvZEn1X+uz1QXd3lHYIbJAGbee6iJmxGYhUFv3CGVWxahKJLmZkhPNw
         0Oqw==
X-Gm-Message-State: AOJu0YxelR074KgJZLuN6/0epyhlidjS52nBm4mTqmaAeY0FWsVzVznh
	4YlNiZSA20tHKmULyHdSxoiGORvd0815G1GaKe/aX4wWjWroFFt1DNoMl12xjfzB2XpoxsfMm6p
	vj5UeGr8/MnHHtSU9YbtATVE1LqTZcvaqMA94MmUxzC3ZyaDoTUO3zPopsoQ=
X-Google-Smtp-Source: AGHT+IEJC4f/LBJ7iaDt/iPsz9H3NSstdNcHuAh9D0dp24ezEJsI05DsdFzYlt6PW1tXCC2I0KXDFyMCWT+LrTz+k5OQBhW3pqmP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190c:b0:42f:9eb7:759b with SMTP id
 e9e14a558f8ab-430c5306894mr268462855ab.28.1761130442748; Wed, 22 Oct 2025
 03:54:02 -0700 (PDT)
Date: Wed, 22 Oct 2025 03:54:02 -0700
In-Reply-To: <CAMz+-CNpOeZG5hbHmarKRtfWD8kcR2s_ma=k9F3dJRFw_XFq5g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8b7ca.a70a0220.3bf6c6.0014.GAE@google.com>
Subject: Re: [syzbot] [sctp?] KMSAN: uninit-value in sctp_inq_pop (3)
From: syzbot <syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	vnranganath.20@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/sctp/inqueue.c:123:34: error: use of undeclared identifier 'gfp'


Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
dashboard link: https://syzkaller.appspot.com/bug?extid=d101e12bccd4095460e7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1044ce7c580000



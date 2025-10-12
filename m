Return-Path: <linux-kernel+bounces-849743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 101CFBD0C7C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3A43BE4A5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E1922A4F1;
	Sun, 12 Oct 2025 21:03:38 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A981459FA
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760303018; cv=none; b=uyUhHlZXmmPtsxHtpSAw1naROqvMIvahrHdp+lPLxelxyM8Fy3zlXG5Qd2Y2L3IqMToHikDSegd4mFJFdorUE/EYouQCOgMYqmezEUXEKyf9YWs5B2kPTepFaWkrE6JcA8JGJI2JrIrHpk+Y8vg9mewLxFu58jYVyYn6VtElcSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760303018; c=relaxed/simple;
	bh=dG9K3RQny11TepsCiiBuvYME0BwVRns+esU4BQRaTt8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QHSqxl42bL2mkzLMj1c9TAWjzBBUNdfrqUQ1i8Wl3zcVvBLYBOmWip1SOo3mTQ18gB3tJ5Bbt5X5bWIyZWNmQf8oZwL1A0oJ5maK2HoAy0IrPhlQx03b+ib/TSoElU4EIk5uG1mQmv1yeeyIWg3V+dVh2qwv1JPwKenY9c3V7u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42f9eb73b34so92074355ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 14:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760303016; x=1760907816;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dG9K3RQny11TepsCiiBuvYME0BwVRns+esU4BQRaTt8=;
        b=nV8xEbW6IvrTWVuhteYWv67wRTEt25BCX06BC5Bmb3NUFnkPg39oP2L1FcfnaAqMEx
         ouRFz32GLp59iXC5eT9SY7vqFiiom5AcACem0+3SBg/zmn9LYtkCB0DhdM/5gjecp2oz
         ijLLRFIcUHgfQwkWmEBAWeA8kNbe1F/fPxTqxRQ6OJ+5X+vakKpSql7UbaRREMEK7VoQ
         Vtl/LOUfZsdpi8BiF5KCvOP+rTgH79FCz1h3Re7N8+KOJy67JawxqP1Aluqr/TG9bICj
         lbgTeYjHlpXfwm11f8oQjpjcLoypt0EnrnB8rTS2izbV46M30pAlcdNNtFXMjOtDEBge
         pCwA==
X-Gm-Message-State: AOJu0YxrCkmBS0LyR7hwEZLTkUZH+w+LuQNscGvXIbx6BXKgTIOuU5sX
	KxnBW06m5jkzYp+aiIAJGsy+TcLMoJk9FodbADsxaZMmi/0vRp3ugCubg/bd/Pjol293NB90IDe
	D2OFx3/pAmsfyCfTqnVbOIDL6NC0xE1EpR4haSZBYh5in6udu19C/hs0Lcx4=
X-Google-Smtp-Source: AGHT+IHl6t1A31PraVWnpTjo4mpFfo1SLDpoyynDyeFVNE26fAJmnJAxrxXc/5U8kERzcZJ6lyIwpB5qLyVCZULV1DBB8eN4ARlj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214d:b0:42d:86cc:1bcd with SMTP id
 e9e14a558f8ab-42f8736cf09mr200685095ab.3.1760303016166; Sun, 12 Oct 2025
 14:03:36 -0700 (PDT)
Date: Sun, 12 Oct 2025 14:03:36 -0700
In-Reply-To: <68dadf0e.050a0220.1696c6.001d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ec17a8.050a0220.ac43.000e.GAE@google.com>
Subject: Forwarded: syzkaller-bugs@googlegroups.com
From: syzbot <syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: syzkaller-bugs@googlegroups.com
Author: zlatistiv@gmail.com

#syz test


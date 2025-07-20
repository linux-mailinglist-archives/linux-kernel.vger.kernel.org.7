Return-Path: <linux-kernel+bounces-738038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB06B0B377
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 06:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE4C3AD960
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 04:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C728199947;
	Sun, 20 Jul 2025 04:06:28 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F508F5E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 04:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752984388; cv=none; b=RUM5rmWW46WucPpyDssram51tkmBGlYB0sR7Dq1fm1GOiR6YqK8hanxRk/xLmWgF9nV/VXrsNtCmhcJwlhOkWkk//zfv3ma7euewgOHjDYh2wuKMKxunaG5CiMP5RN23rAc3loKT0DDR4BZqGWMXtDtQZRbafcsKBqYxp/gLLpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752984388; c=relaxed/simple;
	bh=bGxwRsy5v7P/zmboBRYDy57katExvCZKTduH5FICWQc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WlM3K7t2aTHhJUVj1vnOiY42JSih32N51fOdx+V2JmCu+WZU6B4Ko1R3JJruUEuJa+MyLBVfd1XvYUrMu8RFWvzBVjFcJrUbjIpn2yq//WQCOlsgnNKr7UjkpMIqkla+HgLlMHiQ8r+63Oo2GKxpsZtwLCIMZaAoMwAzXaY9LFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-876a65a7157so334993139f.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 21:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752984386; x=1753589186;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bf1F7Iqd6vpQLgOp+vEI9i4QKhYDjwNhs0vlkjS40nc=;
        b=hSbXFt6oBY3oXo1kYMbs17ndyQIoFIRQpqxXOhAgf/0Vd4kt9fwzwa+YENKHKo90pk
         3ZBZp8VRo+sKmSJu89J5KsDgnlZgCN/FAp8Hx2yEc7NaYTZUO+2QgxBLKQq3u3xZyhW1
         TRzaixGUsCsBuovk4uzGmzsRkFBElw6SDjax9ZtkE4I93qGiig7/XaORWEsv8l6o016A
         9AzOk2fkNT9Iy/1vHIhzikLUtRPCfOLJLJ44gLU/HwwJjqp60reojMsEnpjAIq0AVou5
         vpb+FgqsTwcIRrv8QQIt1quBYcb1MsVP64iIFi3UbgIY6HiYyjzh0TcvpHR7r7+y55I+
         LXlA==
X-Gm-Message-State: AOJu0YxojW/L394GCqxS/el4ZdrKguxSBsLpHeIZH7ZXOJOCjkPlkmU2
	xKIuxTySVQaKvU8Jjuk6vH+BOzNo0qW1PTKKajPsYvBBXvuQJw18vKbFLUJ6biFlFxx5ryC/Wgo
	X62TrTHSHajRde90vCg42aIneijXzwE+Xi22jQYPg0ixxTtbf9TCvGL+wUVo=
X-Google-Smtp-Source: AGHT+IGoBDhUebY8iTGQMlvMbC+EL6X5mLJf+gZqZEMPtQhZwOUSAkGwk6ttQZb2vkKE4D2HovXzw6rkfFTAnpeAmNLeFFmFmS1z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:298a:b0:87c:ad2:cf4c with SMTP id
 ca18e2360f4ac-87c0bc34a39mr911587239f.3.1752984385935; Sat, 19 Jul 2025
 21:06:25 -0700 (PDT)
Date: Sat, 19 Jul 2025 21:06:25 -0700
In-Reply-To: <68488453.a70a0220.27c366.0067.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687c6b41.a70a0220.693ce.00ac.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+e577022d4fba380653be@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Don't trust sb->nr_devices in members_to_text()


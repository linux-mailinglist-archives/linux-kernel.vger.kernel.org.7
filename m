Return-Path: <linux-kernel+bounces-820439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C01B7E90C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434CF1885BD1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B92E34F481;
	Wed, 17 Sep 2025 10:11:39 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3960E306B32
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103898; cv=none; b=YxMjMoLhwhbaVa0E81hrKoRArvqBNGgYpme0XThfQdObiFQEK7ejjG+7dxNL7WHlbO9WugPHvwJsiJKCDlUsxaVWNTs9ZFj4RTiqdsr/9OBQZoFFMZgEokbnvOkkwHvli5Ib15CfM7pof4vgKNLts7CRrzQYAelDzRBdKtnaMe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103898; c=relaxed/simple;
	bh=fHqiXY9F30VvMHnjpTF1syx8dF7v4pfl9pdm2FAfsNM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n9mw1lER/txpzUDIAkZa1k74jkOaj9AK3ZU02PmKxw39XNY0QNpaVnGR4EZhNbLUfqSrwvKMxcHfP2dyiSTrpg84qYaavT66HTCND34hd1Z5BT58YQ5Fkz1nGU2yTNVYKz/zPn0UldnQTo5IN3J7k2q69JqTAqgg1WXjJN4C7hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42407cbc8d1so36669855ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103896; x=1758708696;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHqiXY9F30VvMHnjpTF1syx8dF7v4pfl9pdm2FAfsNM=;
        b=mZKT0+LZnXp1CwYGDa7eQXXLFHXXhXBUX/qEYEEMuRS6vzHvZ949LY4i6k7y+O72CP
         fuHzAfE/cjxNqma4T3aLC814yTe7E4a+SyQhtFC3aioah2/zV8dNDTkYGT0tp+mVAOgF
         6ye2rPpiuvhm3Ev77Rdq6gzeNTWOcQuPZuwn6KQm91nDtmOoY6r1RAGgZdXKz0xQ5p5c
         UEtYOMIl/eJgIyeJY2xx0M46WP37mmMz5iX6c/H0SpYqgr7QyK5fPEDG75CSlgiLb22V
         UWae8qh9PalnF9Fs+Pj1qQs39khHX7Y5WB7ZjSpAeXpIb3XgoXaNuj0sx64j65puRyIj
         54cg==
X-Gm-Message-State: AOJu0Yzfm7RmP3YERLX9sILqLbYgcZ14cOuMlulZJrVqfYaJBPe4hySP
	7LgmQcxqTF/gaQj3Mgc6vp2wgPNc1Ixo26g7Nrp1sgd0SpnF4JYqnwZiI8lt16xABKlHZ1edPpN
	X7xqunempcsdBFxGylaGWciVQWGilY76tz6iIUMYQoOV+Xh2zX3Qvqw8ANTo=
X-Google-Smtp-Source: AGHT+IEUenegEdnHicxH1TXNeJU2ISGzVreKvsfVWJPYL1GgSaM1RqTVpexwqVOIlCpxVHJE5U4DaEbnjL25gnHa8WZytObZ4t9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3809:b0:424:db:3f52 with SMTP id
 e9e14a558f8ab-4241a578f7amr15283765ab.30.1758103896300; Wed, 17 Sep 2025
 03:11:36 -0700 (PDT)
Date: Wed, 17 Sep 2025 03:11:36 -0700
In-Reply-To: <68b1f3ab.a70a0220.f8cc2.00ef.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ca8958.050a0220.3c6139.0fa4.GAE@google.com>
Subject: Forwarded: WARNING in rtl8150_start_xmit/usb_submit_urb
From: syzbot <syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in rtl8150_start_xmit/usb_submit_urb
Author: viswanathiyyappan@gmail.com

#syz test


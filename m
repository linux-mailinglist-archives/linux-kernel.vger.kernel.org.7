Return-Path: <linux-kernel+bounces-830002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D59EB986E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FAF84C12FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B30212557;
	Wed, 24 Sep 2025 06:46:32 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE631FDD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758696392; cv=none; b=Ba8VEczmfMyvg6/QkVXrRpqyF1J3Rto6FM1WTzvvlDrcBKaLVNO1lIm49gBNqfW+mUvP01+12x1RaLig75OmmIDFnNhneh8Op8B25/dP1yBKmFtWw2oo/YsdK5B95LxB7UvnMI8u3ahMeZhhylJbAwWKec0hvK6uQ6ZzLNHOUmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758696392; c=relaxed/simple;
	bh=c2THiTcMx/kITA23ObrwruPRL1cplr9EbGwCsn/ewH0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tapa1RmgNVe5tvD50swqlhzmGtoq0aU65+tLpIY0muXJdhbcjyk+Zfkh2awY3zvnCOfK2ANqZBt1+wUIET0A32xVxT1vDAMDcmhikXMxiDwR5mX7Qxjn0R5l9wrmy4RRv7VjSqjGXK7q3jbEn/t1wQ+vmeHew8+S0nk5iKfNT/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-425788b03a0so78101225ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 23:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758696390; x=1759301190;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2THiTcMx/kITA23ObrwruPRL1cplr9EbGwCsn/ewH0=;
        b=cKPhMsI2V+HqU7SKqT6qaI1L248UiCqgkACbddbnQDTGC4eFO5oWoplxFjxbsdQI0x
         y+yyBBl+5EMxHRdSxbfwUnq3iTXdtQv73w+hnIoRAswEuv0xUBJDFfWh9Eobf+eNC36r
         DYf0GOfysl1HaQFQ9ou9hnCiWn9GrlXhG4BUEQqSwpE0SNX+r5lsoLOVC+Ll/mZWjIrr
         GFxWI1j0NpNRUWGkTg7slWDtCC7rEE9xijQGOrvaAcwgJ9SwbKj5lm8ztvgX2OgagkBH
         aGlcf49J/FSV1iyo4ZnDzJQiaGkKn+QTj+maMAqttjYKQzDHTdRzkR4BdkoIstQR4jTV
         Dp2g==
X-Gm-Message-State: AOJu0YwKqXHN0k+6uBe5FABMGm6k8fkLNOHRiCtXH2e0XYIQ7aBMJIuH
	9xR592NIhIceQ8rZhbhhSpktUzQQizZYRwbGhgj2yhwezPb+rLcRpxp+jHTWPBM8VYwOpOiqP9D
	KVJFJTB47aMYGJM9Yn/DPm9iLV2Oa3Zq+WJA7wb3Lez9oLnAqdXyOk5UdxBw=
X-Google-Smtp-Source: AGHT+IEE1aJZHGgeqestyz7zJv/ihZoMCp+NZxSfkAr0MOst2uZJf+I7Teio3oAvhaVSHt2oHQRl3GP0yawGJxgB9AlxmnMtOR6F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1949:b0:423:f9d1:e913 with SMTP id
 e9e14a558f8ab-42581eb8a20mr77433985ab.31.1758696389960; Tue, 23 Sep 2025
 23:46:29 -0700 (PDT)
Date: Tue, 23 Sep 2025 23:46:29 -0700
In-Reply-To: <673e3029.050a0220.363a1b.0024.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d393c5.a70a0220.1b52b.02c2.GAE@google.com>
Subject: Forwarded: upstream test
From: syzbot <syzbot+1f4e278e8e1a9b01f95f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: upstream test
Author: kriish.sharma2006@gmail.com

#syz test:
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
7595b66ae9de
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?id=7595b66ae9de667bf35a8c99e8f1bfc4792e207e>


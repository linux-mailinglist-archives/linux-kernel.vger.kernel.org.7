Return-Path: <linux-kernel+bounces-875058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7948C1818E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA64D1C63FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498362EBB8C;
	Wed, 29 Oct 2025 02:49:58 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C252EAB72
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761706197; cv=none; b=ACoTqGSeb4s0NPJvFmZkfwUnOB/K7r/4CeE1jCxzj52uAYwu52bcVKGUDdlOxa0BlD2twvNmPobL0/u08MpELjlX5b/JCyW0YoMOjan9tzUMsZricjH62lEKU5M2C1cJ4ZxGTrtDqhSKPWz9AYWYLNRXWYJ4fc0+9HuJBmlCGQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761706197; c=relaxed/simple;
	bh=Ae5i9RbwIx9CKFb2YmhcSXY+Fe9uMh0vjYf0j9fjrPk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aMR+dxY9rR06VSMrv0QLpngGTPFdaLQixWJju7nf744v68vzZtQQOiopqhScSQxg2nZraAw4JW9CPfiYasvsXvUMHzRfASFmjlc8/GQMhKCcX02wRqcDQDXckuXlvvuuij0ib+5AtRbhyd/nrDQrz1+gxh1S+OBk6emCW2O4kSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430ce62d138so84129955ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761706195; x=1762310995;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ae5i9RbwIx9CKFb2YmhcSXY+Fe9uMh0vjYf0j9fjrPk=;
        b=AeEDP7DTrDRcyOxdw8E+T0KSMqrIuSBCMOWJ4F9oafLlQ1mvtlXqTo75D/sJhxYw02
         kTpQWSERfmjZrLtEDfzYEHAfhPiWggge11LmpS7ED5vg6hAuoGYHhTBCoP/Squotnv87
         yjlcONWMEXQuzRcl29LAOHXj4SSIZ+cj3qAnOLwRD14rz6qNS0Aa5D/FViXRsAsooKme
         KhbhpQ/5twb4DK7f/a6p/mjj5lL0OgrnE3o9NjDNkUIoxRoyDvWovUANyLSGKRJRzImd
         f3pw/TIey6UP6KxF2Ij+x+GQKjmWcN//JoVDaBdswjL9+0e8iYPhwCrQHzgR2KZnam43
         amyA==
X-Gm-Message-State: AOJu0YzdGOaFGt36xWqH02ox6RgxpylvvU1l/cLzX+7WhNoz4gFEUH5+
	tcOoXqn2cXq7oEABF3jsQkdpf/RTn4NvvCxWcyTvw7/uQ5dkSklqhym6eq9Q1jXsYW+lrK4jbIg
	CyRxsn2rKtBE0Arqlaz0lp1L0gV5BWmaI7KeADFSJIlPyKozoTBe1R3jQKeA=
X-Google-Smtp-Source: AGHT+IHlmVhKdMpY8w6fWQi1S+xScIshBinNbfYvQqyfVFy1HKKCtpj55APT7V9OeOqS3za9pgr9iNOLuy5SKqva2Cs6yD1hXaAi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378b:b0:430:aec5:9bd9 with SMTP id
 e9e14a558f8ab-432f8f81cb8mr20171275ab.5.1761706195618; Tue, 28 Oct 2025
 19:49:55 -0700 (PDT)
Date: Tue, 28 Oct 2025 19:49:55 -0700
In-Reply-To: <00000000000089f55405ee486239@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690180d3.050a0220.3344a1.03ff.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [hfs?] kernel BUG in hfs_write_inode
From: syzbot <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_write_inode
Author: contact@gvernon.com

On Tue, Oct 28, 2025 at 07:47:05PM -0700, syzbot wrote:
> want either no args or 2 args (repo, branch), got 1

#syz test


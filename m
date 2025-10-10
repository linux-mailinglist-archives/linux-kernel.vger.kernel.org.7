Return-Path: <linux-kernel+bounces-847938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDF4BCC18C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B369350B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A223C25B687;
	Fri, 10 Oct 2025 08:19:29 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3466825B1D2
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760084369; cv=none; b=mflhMb36afunRBNLZJ5qVxKxjFN/895y4pGHj07iWhPytWoAAOSrdWBsi9LGzU2gF7Z1LG2SfrgED6EmY8VoWZMdefg7kRPcMJdVzRI70Gt+ALtYbgWn84zxot83qPEpq4bPpEOWkDWGBWxhLjBH+OgSB3RAEaAbKbzi270B35s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760084369; c=relaxed/simple;
	bh=Tucj3uR+w3AArMrCxWQ8qKo3fytGp+DMFdrwedRZJIg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r6jkZFH4yGKyva9Y8kmUiwjGTru+dvaBAHFmUG6XNhnk50WQWVk+WX8/AUsDmuzeNnWXjRrX8Xhoau6V+oH9lkYAeUXRzxntzfNfsISVnJT5vQj7QDl598ZQPSvfYAUFbXoslKzPqX0thPkfvTycpXL1AeFzoH9j18f8ce4pB9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8ea63b6f262so856117139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760084366; x=1760689166;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tucj3uR+w3AArMrCxWQ8qKo3fytGp+DMFdrwedRZJIg=;
        b=QDXoT97eughwh7XBBu/LqYC8ncJnXqVphZZHHh/Bgsp+F1QDfN4reIXRrEnRtFrcrS
         DeqZ8DC3Vdzm3nOZ6URadF+7ElpqH90TNRQMUWMutma+D7qragmn3U4CTUEqAxLJZ/3m
         kYDBZMWe1k16fR1OFvTjNTXC/P0EvOOOIccCTUi1uSCdkY8m/rgPY3Q+1J7cfy4yQVKF
         BPUVktUX+RVETju9alLZY4RSo96mNez5azt9bA3BXE1ItyPBjpqM/SG5bEc5jVc0egdh
         n7zCaCD1Iv7+Mx/dxB0wIlY+CJ5NCy4G2dehwgkIzL6cCYnO6BGqEEfBJCnukJfWbKnS
         GJog==
X-Gm-Message-State: AOJu0Yx1Uyg1hzc4YY0g+rqZmOA4R7Zk7Rzu+CTh0zXycXPpnGJM2pc5
	RAArcWQ/tHkRpS1wSfP8vqkoqNGIzY8fvy5DjKNrZX59OTMfnHEIN6BbtH/JryiS2DlI7MHOBCb
	IhY7dAQ7loBCW3hW9GgcP/RLORrJy2IFTzVFLlnDwT7JrZF0OcyXa8mSPWIA=
X-Google-Smtp-Source: AGHT+IGTx3oVkw2ZAbGE3FvCZVVCPB5QG36L1BEBk4fxKlvFJlOHx7WTsZ4ClVHpxsgWtAFutVcewYTJ5FT51Idm0qiB9tWcgAB5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f8f:b0:91e:c3a4:5378 with SMTP id
 ca18e2360f4ac-93bd186b08cmr1297093239f.6.1760084366244; Fri, 10 Oct 2025
 01:19:26 -0700 (PDT)
Date: Fri, 10 Oct 2025 01:19:26 -0700
In-Reply-To: <66f6bfa7.050a0220.38ace9.001a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e8c18e.050a0220.91a22.014b.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 5472d60c129f75282d94ae5ad072ee6dfb7c7246
From: syzbot <syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5472d60c129f75282d94ae5ad072ee6dfb7c7246
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5472d60c129f75282d94ae5ad072ee6dfb7c7246


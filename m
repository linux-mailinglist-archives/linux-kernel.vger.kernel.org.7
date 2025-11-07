Return-Path: <linux-kernel+bounces-890340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A907BC3FD58
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 13:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C4FB4E17D0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62E1324B3C;
	Fri,  7 Nov 2025 12:01:46 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091FE3254AB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762516906; cv=none; b=Cc1q1EZ1g1fb+dzXGV1Ui2kidITKEDn+Y7LWL/DC/iD64uM+7LoDpoVX6dFYh3qGjSZHqEUyu1ZvjNP+VinXZETmjS+U4ExwKyY7YApyMY0agBYNcM/GeF0Unchnd+LTPBwaGastuxfbzItXkOP3NTkAIxQ2hNlE44Jg+PnnVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762516906; c=relaxed/simple;
	bh=3apaOxsSqJwCiR/TFz4oyIhflEgN7YvSUTHSYxwkoFA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Wv21gi4YD5DiqtB5WAneqGKodzw9nqwjJIPZZ4PDDmlyXIoq9SDBteDlRUL684nE4tpVWVaC+8re7UDOf7nMvwlrWCNETVa/Se/mLqd13OhAG6xqEllARTdtKWx+trUzJ+JJ46RTDQkifPGq+92jVA8Oz03jD1zvpPBpGq6ARNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43322fcfae7so7194535ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 04:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762516904; x=1763121704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3apaOxsSqJwCiR/TFz4oyIhflEgN7YvSUTHSYxwkoFA=;
        b=p73Kwa6E6uCnBB73CKb+evkFMo4vdGDxQs2+iC+NNRZ9+P3JacISE5UcLTPs8csS9o
         EjjL2IzTFG7rAPcfy4vIf+OMBskrgUIYnSLy4T+PYDrTem1C+c4sKwYfRfEmGbHEUYRy
         UbW+ZvgIi90Z6sZhbRnfc1oQT4Cs235eqdg185Odf+pesf/RlQaEHXUXY/bFmBdNwZVR
         abde5zvs0wAutZ8QE/ZHoaxiXGntolIPZBeGyKJh3CJcldPos4y2QkpUMeIFl7B5etUX
         8Mv+jcFgve+k7r78xSoyr1TwZxC7wPeX0utxGHrV6zh+4d3lJES4SgBfd7jpV9D8kc01
         E1eQ==
X-Gm-Message-State: AOJu0YxBxP/eBli8pXsVsXif/CZ60WYUIDEv7w0tghVlaRAqsgDyKDgt
	iQVbGtl6BZbZD6/bikXo+KNyOkoUaq1cfv9gRz6Pr8KIYJyZygz+ls5h3SyobT6O4eukA7jRQKG
	MXLDzHH3RlA7QTQc0ENgG0J34EwdRwG+ds3Bmen5bNcLmsb56m9D2GEqeaZ8=
X-Google-Smtp-Source: AGHT+IFsehzOZNvRUtG9m2ZgKjhzDbTGml/DOfw00OFQ/dUGsjKmqRpMPECJ5S771TYTOD5geh0j/DRHcZRjmlvZBw6PdqRuCRLO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f03:b0:42f:95ab:2364 with SMTP id
 e9e14a558f8ab-4335f45b1c6mr35655195ab.26.1762516904194; Fri, 07 Nov 2025
 04:01:44 -0800 (PST)
Date: Fri, 07 Nov 2025 04:01:44 -0800
In-Reply-To: <690be734.050a0220.baf87.007a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690ddfa8.a70a0220.22f260.0048.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [jfs?] BUG: corrupted list in dbUpdatePMap
From: syzbot <syzbot+4d0a0feb49c5138cac46@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [jfs?] BUG: corrupted list in dbUpdatePMap
Author: yun.zhou@windriver.com

#syz test


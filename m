Return-Path: <linux-kernel+bounces-834440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C496BA4B10
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0CD172058
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64972F90C4;
	Fri, 26 Sep 2025 16:43:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D3E244661
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904986; cv=none; b=METlF4UFpmdtdxIvfFUXjAJqZuqf8MRGsMuYy4+1rTtS7PfTrePMzYVSNe8ntJ4SLKLQ7KctClUVaQiKt3SXAdMlOY7n71ypDGsRyimn0Izb2vJ7FCVJY4BxLjEsf+RmUfZivkK+Ehx+VgI2O37sb5NzzWYhkuT2u26KDke524M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904986; c=relaxed/simple;
	bh=iosnXdrb4wvpim9sdbXW1/kPxrsxSqUC8oSDRn3xyDM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CRMuhuqIWV1RdVxWRYrDbtb49w/X/12pB33zLTa0i5qaExRMRFISJR/ghtAWxnQYAv2Nr/v801nkldjaJcsadZK6L/6gPhaBlrECGlBXGpUMNgB/Fke90I3G2+oGeL6YBmAMWgBpE2wrClLFtt9P49PT885HDFh2FouuCAx79wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-911c5f72370so83081239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758904983; x=1759509783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBnTsUrdLzjBCws1Sf3ESqyzv5xZu/VV78rZyVm/ZzE=;
        b=Xduu45QXV+hXPOsoMpbJEEbYHhpvkAdgGdWZMM9lA0nND81gj1aIQL3XmSGxko/feb
         U1+pNpRg7RzTPCvZcv/MC7kk5NHWWRVkINo69byYfu6zqa75LY111iwP7A96EOikoohF
         COyDN76k7eKWgTtvIWKuc0a1qmK2H4S94LFyGnZsCMs3KDFT69iOsZa9NeKWtAHWiqh/
         hczFzeolQGFPDv/2YwbvzhpXfK+QXAJI1dSRrD9gg99nWgCTaKSqGGu3dbRT2c1lqNgl
         M4D9xe/AGZO4ffIzH5SZiIJUewEuMg/95CcjjaIYaMpsS8zjrWXNnyEwveqJhDjxFkzf
         xlMA==
X-Forwarded-Encrypted: i=1; AJvYcCXYAly2tVLmXjX5YJIzpuc/WqZ1nUGQSNvR23jsfbOqMSPNl386CPpLAuRqBe4oUh6wy/D44AUyadtZSgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfs2LnarGJywB91R6R5O5qsDdbwUjiNfGmKZKTgj+0fZGvvTn3
	n5reFwskAW0XWjXk4zi7TXuxWM4Z4nJCNIZOhs0HCN6XESM4EPfsrK0rex1AEh+ei8q7wuAiQpw
	eIvjNv9sVs3pSppPC8E8OgpRChQG2oRsA6H2vfGnsibS16bXTzzsCmoUyqNY=
X-Google-Smtp-Source: AGHT+IGndh/wIJHDzKxJVEjPtVhaNfiU8GvDiopteiofyMWYgR8LFsiXF3GFSwjCIPKnKFonnBsjzP0Tc1UmvCFX/Gft/0HQEHlN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4610:b0:425:739f:bb02 with SMTP id
 e9e14a558f8ab-4259562381dmr122504535ab.15.1758904983561; Fri, 26 Sep 2025
 09:43:03 -0700 (PDT)
Date: Fri, 26 Sep 2025 09:43:03 -0700
In-Reply-To: <CABFDxMGg7Nbg4Jp06Oa7mRfqpAyeUW-=qy1VHaaHaqvSdmaxew@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d6c297.a00a0220.102ee.0007.GAE@google.com>
Subject: Re: [syzbot] [squashfs] WARNING in ovl_copy_up_file (2)
From: syzbot <syzbot+f754e01116421e9754b9@syzkaller.appspotmail.com>
To: ekffu200098@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f754e01116421e9754b9@syzkaller.appspotmail.com
Tested-by: syzbot+f754e01116421e9754b9@syzkaller.appspotmail.com

Tested on:

commit:         4ff71af0 Merge tag 'net-6.17-rc8' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1732dd34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=f754e01116421e9754b9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1365c2e2580000

Note: testing is done by a robot and is best-effort only.


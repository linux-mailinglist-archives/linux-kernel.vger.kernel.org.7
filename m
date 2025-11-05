Return-Path: <linux-kernel+bounces-886947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49B8C36C86
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527D11889721
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C645733554D;
	Wed,  5 Nov 2025 16:43:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11E031DD99
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360984; cv=none; b=q1FQAGWdYHxaTtu7mrt8IdsurDpQ+X8P/p7pELXzOR8V8atJD/uY5Oxojx/hu6FRyQNP779+CT6enEqcHvVH59VvCGcJBIVv3ORyemrP3S9qVvvPdhndtAeYd80zSkL9voWS1a3c73hG36M0krM0qM1ipIa7jKBqpsqPqb5AU2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360984; c=relaxed/simple;
	bh=x5sbSe7Bpfhsx3GxF3kq/A3ndDkGa1h0EQ0Et8nkhzU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ENSEFSrGWgXDwZhc5RLB9n8zvGd4vq4m/c9iMnYTbNn2mELGxVGtMbArbNU/WcH9C2r5F0OMeZPOMdF4afhP8e6zF7Ef1UkGxKi2Z4YubshCHzYsD0nF1Ob2Fcf1FWOdgtjUuOvUf9uBKloHUUnBB3dEeufqqZNMfDR2NWXcOvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4333052501cso33906295ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360982; x=1762965782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mA1rr0UGHXlF7i7+h8drZbzeai9cpNuWr5sbhIJcxiU=;
        b=B4uFZ63m+Y5/VcRljlGQJtfZNzcKF5Heh0vsSVTfMMfQl2c8F7FrArWm4hURTL6wS1
         dw/ZBJVUopoWHyzV77HqeUf/BQC9x9ijUNicgHBjOojMisoeB9MkaQChQ/aIQwxQcK70
         sMBDz90UaaN4lbU3ylZUQfUjwzD14p+H0NXPjWPsyuW0zjqyApOK4FE5bWkyCXstkedq
         BKZhKG6UeUfucEdNJRzA5rrGWp0cy/NtLp+G17q0hNARsLxBSmqvzRq+3U4GtD+eVPIg
         Xb3n7TGPnidTSMcbeI7GlVIuof+mFpunCx5cpoV2PtbZ8H6Y39w9+dycNisA4qCFE8Fl
         UiBw==
X-Gm-Message-State: AOJu0Ywe//5qwVCTSkf4WLmD1ijs79x1Ar5CFc4G16XeZyHjYQFhUTup
	X2nQvKVL6Nj+Ya1KKnpBE2kTm5vwRsBWpsEWEUgm2ab17JSGax7G4myMFZbJFu7IyEMxD2QVmyz
	h0/xCCNis+CQ5coqLZerejj7brQV630L2PiIkm2JS9iljnJIBQVAq1KwOo0o=
X-Google-Smtp-Source: AGHT+IGQB9nZA4FEnFFzHxKJu923DVFr9DgKXDtbfi7TB/tZF1BdMNRUF9lyUSuMRFa1jVrB5LeAAefb0RfJZH1akwZoc9i9EpIk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2703:b0:433:31ff:f885 with SMTP id
 e9e14a558f8ab-433407a9417mr54668735ab.9.1762360982068; Wed, 05 Nov 2025
 08:43:02 -0800 (PST)
Date: Wed, 05 Nov 2025 08:43:02 -0800
In-Reply-To: <aQt1xICrnVD2kpoh@rpthibeault-XPS-13-9305>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b7e96.050a0220.2e3c35.000b.GAE@google.com>
Subject: Re: [syzbot] [usb?] [bluetooth?] KASAN: slab-use-after-free Read in btusb_disconnect
From: syzbot <syzbot+2fc81b50a4f8263a159b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, rpthibeault@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2fc81b50a4f8263a159b@syzkaller.appspotmail.com
Tested-by: syzbot+2fc81b50a4f8263a159b@syzkaller.appspotmail.com

Tested on:

commit:         18514fd7 usb: typec: ucsi: Add support for orientation
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=146fa17c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14b5cef3c2e03af6
dashboard link: https://syzkaller.appspot.com/bug?extid=2fc81b50a4f8263a159b
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=115b3012580000

Note: testing is done by a robot and is best-effort only.


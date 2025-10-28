Return-Path: <linux-kernel+bounces-873567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8343C142F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8CA19814E0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DAB30BF75;
	Tue, 28 Oct 2025 10:43:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BB330B522
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648184; cv=none; b=JGg2tVonTfk5QC3oCZYNeOX3XAO+2syTsFk1R4+ZwtHn/7YlMlTX45VLpLUxM6t9dVha6cM4eJMblgxePpz6Y93+Cjgh4f/r1kzC5M6s2mB8gqxtCwgwPoi0+y8H1y4wlcZyC65FmcT2EM2/uT8T21S92uzVfUCm/O+UmiwIvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648184; c=relaxed/simple;
	bh=o5+4RatVBW6H131lIi7jCEY95o7OPXkouDsF8FCsgtk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YsjFDGYeSmFr4MWuYYLBBN4NVw2U/0i81CQfHsBHsQZ3t1V1bZpcE5AzSgcmw9mieasuODK9ATVI8J6NtokTiSVv2LFJbBmMEKHx8h+NTfDzNr7/dUSXhHdH+k758LhOi24l1DKDL1cAmFNRwLPe/tjFyjpH5YQ8oagNecbE+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-431d8643856so240018135ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648182; x=1762252982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOUBYmtbwQQzZuDG4D4LfuevE3BSkoJm0EVmRhe7CDY=;
        b=AKGgwXlhwNFtdhgF9SjpoVUoVATEaVRMmMEIOZmZZLPDpEHnhA6buqyxN51JnOf/5E
         gPbKiLv5Oa+CeSdQV3qoX+n50yTyNmOq8Ko9uc6l7l6vRg+jNhwaeq3xlXQEegLCiAH4
         PHoCm38ORSD9nOgQb2qFuJLg80By9Wd+CNX/32XPFYwsdGgCXUVTZvgcbMbkamfU8Ga+
         Kx0mE6mLtSqd0eNg0U+8QTBvlm899erBhOvIK5q1FkxsTF3ShSGelGcP5ztUnM9UDw5z
         tC1cLZdlXo0E9KrXVwcW1ahwHQ2NLTao6VK632r7KvGlE+h9MCnTYNjn3fM3N6v3iYij
         Ll4A==
X-Forwarded-Encrypted: i=1; AJvYcCUcA+eskeH0IGrKNCyQ5g/ZPCDTdSkdQJrBzVvHamBgHhZ3Ryj/PMyCQ2QPHwOyZOqidHkhfz3C3oBTIWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHBaeBVEHZzBMjyWurwURbnnznk8Due6lJQ+svuU/oWAYEu9Br
	vo13ypwxsfPrnKF82V6xUfWhJ2b4Q25NA6HqwPnX+bIbulmI0zVwrZwbtBvZsgElDVKGcotVfBd
	n7WVoVUSb/B7vYavWvtPKinpENwX7faBCpqJ0eIpSW1VrskuS9wf2ojOBD3M=
X-Google-Smtp-Source: AGHT+IEUiH3/iOXgHUqX5dpy4D3NvHHTWuMC3SMK+Mb/e13Tzg5SFtkZtUh6vmgusZ6H0e/HIpwMRGSlFiyp9c5c2NpLqyrJIFUQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c8:b0:430:d371:d3bd with SMTP id
 e9e14a558f8ab-4320f844d7amr44643725ab.25.1761648182452; Tue, 28 Oct 2025
 03:43:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:43:02 -0700
In-Reply-To: <20251028104119.GRrZG%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009e36.050a0220.32483.0182.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in __ocfs2_move_extent
From: syzbot <syzbot+727d161855d11d81e411@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.1.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.1.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=84e81c4d0c0e900a
dashboard link: https://syzkaller.appspot.com/bug?extid=727d161855d11d81e411
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169ed3cd980000



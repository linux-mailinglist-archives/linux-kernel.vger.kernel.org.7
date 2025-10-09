Return-Path: <linux-kernel+bounces-846525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526D6BC83EE
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA897189DF27
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A896B28CF42;
	Thu,  9 Oct 2025 09:16:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333326E716
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760001365; cv=none; b=UlhpGs8Z1esxZ8EZYItwgn3NjtVKWqVENGrufrD0hZOfF6UygRul+7UsQR/W7CkJQ5aQ82evIBgaUYQZ+LW4P0qzoOHtXykYcAuasbJ8oP0MDNG14THIB6L8Iz5xRTQjtNgwlWxLFZ+F+RGqD7+qSAZ0IzGiEWrbsR7uNuSqBhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760001365; c=relaxed/simple;
	bh=iuQFriCnHUuilfCgx+YaMklsGuT+Ooz5LIMKmwOXD0I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mDDSyW8MzL/W9II+FEmnJou89YbLcEsf5h5ipE/GKRYTsYiVuN5IOhLxx7iHnQvqPuhpy+pNrUNUi75ZcTj0JWgq9g05O/EdcbZTekazY0cGet8OTJNKn1zg1mPgXrthdL7fYt0F+P+essg6aVldqxzdPzY+xOt/92SsPB3x7sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9048fe74483so152005739f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760001363; x=1760606163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+QU/fP9rvwZ0sM6lFg4dKd6wYf3y3R2HV/ggMf8ZiM=;
        b=sHOuvQonFB1++9ntWuf0AIN/q5vvZGiT4wcQddAE06AVSeavE5aUCqBwcDt6zfU1jt
         KZRTYXOO63EYojxRJg8DAcSzifBMmjQ2w0gYVDBG4uVohjQyFDWAwXpds957d0TPqdii
         1ESc6T1O/HSAuTdQncUZ/HigkFhLdfrKk5BplNeEIJqDo46mMvdL+xvNs4ENlMaQ2DKv
         j2BGvgGjYL2bsjFiFBA9RIcYi2DbWFZgUHwxb7G+PTIpT6QoLFxL0SnDNiCmIyz6e/U3
         ONoyrC2b5Vb1IfSJMLcimkQTwegu3g0yWvX2subUZ4W2WcTduqwo29MiC26BZn92Sxln
         DPiA==
X-Forwarded-Encrypted: i=1; AJvYcCWkQMwJt7ZDbLxxLvYHUaDxdYvTQZZGR/EUTMiiQgryLEejx7vSMoPT5VRegAfht4DsN5ehZaNGCGvhq58=@vger.kernel.org
X-Gm-Message-State: AOJu0YylKaY9eWdZqY/72y9dzBHtW1aJXvB5fSGfnqx32oPManwFCHb4
	QOYVVL9U/A/zNAVnv90Ql7iJYObbKY04/15d55aaPIcvmsqJ8HveV1UvILqMrqwTV/jBS2ujada
	1ECpdJtgHanbVLoLHv6kKmQPjvCes9NLaZhThPwpoc5Wz3Askpui+pDz4ZKk=
X-Google-Smtp-Source: AGHT+IFvO2dCHKwkcLy9ZCLlHVLUGKJPHj1AcNNMYHW++wgPrfzqxaC/+yhP0huzcpebTNTD8x9lzxGk8rBIdAQomP5Y422ncdId
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cc3:b0:92a:e2bc:d861 with SMTP id
 ca18e2360f4ac-93bd18bb6c7mr705162939f.1.1760001362886; Thu, 09 Oct 2025
 02:16:02 -0700 (PDT)
Date: Thu, 09 Oct 2025 02:16:02 -0700
In-Reply-To: <20251009085515.8396-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e77d52.050a0220.2430e3.01df.GAE@google.com>
Subject: Re: [syzbot] [fuse?] possible deadlock in __folio_end_writeback
From: syzbot <syzbot+27727256237e6bdd3649@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+27727256237e6bdd3649@syzkaller.appspotmail.com
Tested-by: syzbot+27727256237e6bdd3649@syzkaller.appspotmail.com

Tested on:

commit:         ec714e37 Merge tag 'perf-tools-for-v6.18-1-2025-10-08'..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16834542580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a19be70789ed377
dashboard link: https://syzkaller.appspot.com/bug?extid=27727256237e6bdd3649
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b51892580000

Note: testing is done by a robot and is best-effort only.


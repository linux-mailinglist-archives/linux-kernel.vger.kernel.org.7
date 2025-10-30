Return-Path: <linux-kernel+bounces-877706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA989C1ED17
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441C118848EF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10837337B96;
	Thu, 30 Oct 2025 07:42:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4BA3370F3
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761810125; cv=none; b=Mzvcy2QBgfTGmPkzLvs390iXVij9SxsPyLXxFKTcKBHTGQhszIaaxGwEL3q+oK0B/PlK9hpxILXmT2Md3rc8pEMvHeVnBJs2oa7eCQMFetMs+v4qekQWcwZfcfNLhLpBwqqHQyGikmmQM2D2XrmHqxpBlIYudoCPbOm51OOdicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761810125; c=relaxed/simple;
	bh=lCojzIsTFGl1TVJIPtjeU7f+5UW+iwMFJ+6iUln5nXE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ti2BAfahejNJRXF4ljwrcAWQaukO0pHtYR/bQd4UsTZfIcTfD5H6pjO8wgWSR+lOqDH4r9NgztvRpnpzSIBg7IUAcgAJwv6ojnxxGWs3gBOAUztxb9S2RrFZ/tYaoq5nu63XFcLyQlOlT31x2KM5o1plkaQx+MD15dvXrRuXqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430db6d358bso26760275ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761810123; x=1762414923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RSmf8987BpTQJqzmW0Dxhs15YbQGxphnSa8IuxRBHno=;
        b=PByCLuI/0bv9t/cyTdkeMECYBAGUiQQ86tWCod8lul5m12nk5X6/ar6EzyY7B2gpR5
         XmLMsRqYvhbE34T2fgBrXA4ZtBMO9DlkKqYLmaHX+mxVWf45M3yH5pxZze7PgZ5klUsE
         VArnVk2JgczArycTSMxjHaesz+zAzqjRO1o15ChI9D8USMTVRd/kLi3rfK2JBeP0ZlyQ
         eoIlswU5ujhWSRLXDcnamwajod2xDjVXbEDJ0QE087HHPXJ9GLbRGhA2t5oPLhXgnd7l
         nDP6sNR3tk0HZpbyXEBIsn2/I9jRFwQbq8mGuuJGIbWAGjGOdsSRicT2Kb90gYgrfzCs
         fxKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj00njrun2l+owCnhttOX6nVy2wVadC7K0wZCY4ueoUwzOVzf5CY3wTjE6udBQ7ojTbhnAtbayNuzy8vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXS3uSQkfiV6U/JDzN+qV6esB+wOrwEmff9f22f2mTd/mf+y9V
	WYwpcbD8IBvyqQEAKz20ewLm8uRGiYDK/lDUHYUF1xy/lereISmUXq5aPx05s/EXFqufskSpd09
	ZI9KEFFchzdFGFLSgcDKckh4hOxxqxbjplBp0s9z7fj6QmBJRVzu+npmaPTE=
X-Google-Smtp-Source: AGHT+IGVSmseTcLwLx0sUVIor4xbNG/ZXWrT6/VOsNCt/mE4ld9elES5xUBU7Ha9LNxul3PwAA6NfCUeY/19kjw5xT/P5YzGhDRL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e02:b0:425:7534:ab09 with SMTP id
 e9e14a558f8ab-432f8f81afdmr76672795ab.7.1761810123398; Thu, 30 Oct 2025
 00:42:03 -0700 (PDT)
Date: Thu, 30 Oct 2025 00:42:03 -0700
In-Reply-To: <aQMPqDAxyM3i3pQk@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690316cb.050a0220.32483.0228.GAE@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: slab-use-after-free Read in xfs_buf_rele (4)
From: syzbot <syzbot+0391d34e801643e2809b@syzkaller.appspotmail.com>
To: hch@infradead.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.infradead.org/users/hch/xfs.git/xfs-buf-hash: failed to run ["git" "fetch" "--force" "679bdfc056221ae86d16104d6de6223afaafa4b7" "xfs-buf-hash"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       git://git.infradead.org/users/hch/xfs.git xfs-buf-hash
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
dashboard link: https://syzkaller.appspot.com/bug?extid=0391d34e801643e2809b
compiler:       
userspace arch: arm64

Note: no patches were applied.


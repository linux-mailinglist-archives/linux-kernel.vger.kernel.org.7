Return-Path: <linux-kernel+bounces-741700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E49CCB0E800
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F3E5669E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AB84CB5B;
	Wed, 23 Jul 2025 01:21:48 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6316944F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753233708; cv=none; b=uTqEKTjIHbe6RBa1Ll9x0bg3n2oOO7PW7qsA+uu5yJ1cydTrXmPDasG0DGwEP97mLYZVm1e14TZT/LPc49ThOCUuILcDJcZgZhWnDhjT8ZQlyfSlt+/pBiyFNLYhUrsSafmi4POmsFhOtqT/tRe620OcTgyp1arecgMOOqcGWU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753233708; c=relaxed/simple;
	bh=1KTEbTEXyrqmDgGUd/OPvuzgk0T4IjtENHKdai4b3B4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QeY4UeJRP+gIgCKp5y6y8UYZhayjLivj5RBvs5DGDj+An4ltCC6ogm2FnPRvteJkqHsyfgZghwSTuQ0pOXJ00y+gegfBrcTojapX5bcUPumW8vCYIuvf7fbjm7D/7xy9CXVuCMsaZ5FNLDIPMFmyG4HZOmsldMC3PkjgO5jaJEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87c1cc3c42aso758124439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753233706; x=1753838506;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aep9h97yzq8BxK3rUKzUgGRp8xlimpOzQ2+X26fDUzI=;
        b=tjLTu6tm0/6d3kscYmC8+uEBKOag08GfA1ZzM6LwDTn2i8Y7VH/O63keHuOcHrLarR
         KoMeu1s2k/i9ZoplZ3bs3uPceH8UTsaXb12LiQ31O3hsMGF2sliyho1UCCM+GsInaiKk
         zUMtlOdcn/YSpzbBtWZZKfgUksX1YZBAkHpcJx9sD3fvaAnYtfzNXxDVT4FLvK3C5/ce
         z/O9EtE5YdETeLBViaBVmyF2vNjn/zrpv4UGc58VD+lUK2v86VWkcGVmKCT6QDlU1C3R
         NlTQk1rMcDi01RXc6grNBq+9jz9hRmLzKSZma4ZuWK43Exfp3CRkJij0v/Jk2L62Z0Px
         Sq4g==
X-Gm-Message-State: AOJu0YxSeQhwJ/asNl2Z1iwQEWvJ9ief5PELN8FSB43U7e3/DYkeasTo
	zek0poWzlckj4D7x+UNURRTXaVd0wMEdDXVNuiM+AXCS3g0VDY5lGMpvHfmMNdUKETMQLj1R2Kl
	EUcn0xD7RLVUbKm0iUScGAyRJhpdRDUWHXot6nwHS8mJgcU8iAhub6tvzpa8=
X-Google-Smtp-Source: AGHT+IHD41dAEEoxpPe37urzO8H9nqkN3/4uEhNvqutKjN5sNad+4Gc89LBOsY7IR3/p1cSrzkdP1RVOZaOKyF3EsWKblxnyvw7T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:740f:b0:87c:3d17:6608 with SMTP id
 ca18e2360f4ac-87c64dc6ae8mr207479539f.0.1753233706140; Tue, 22 Jul 2025
 18:21:46 -0700 (PDT)
Date: Tue, 22 Jul 2025 18:21:46 -0700
In-Reply-To: <000000000000849b0606179c33b7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6880392a.a70a0220.693ce.0110.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+247ac87eabcb1f8fa990@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix:  bcachefs: Increase BCH_MIN_NR_NBUCKETS


Return-Path: <linux-kernel+bounces-741698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFD9B0E7FD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771944E5D70
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2862BB1D;
	Wed, 23 Jul 2025 01:17:20 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219C31853
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753233440; cv=none; b=km98q9kGyOUKThVKdmqtHc5yV81rcy/aPVpRNxS9otLBU6CrWBNgaXZgAoOrF55ykkqaMbUUOMskKb11+nv6ya6BcPUepqWunRAI/Lg0PQ7OGxqttNzTETe9ahwgn+NS46ppOeUxsFfXVkZVD+ObBTeYaS/LR0+sTdfX6EssdzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753233440; c=relaxed/simple;
	bh=9OlrydaUpg3OwHFmFhJUEKn5dj8ZSZkg1QuWWVFtY0w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S4snmmZIFz0uU8BqpDcWFKIhSKZqKS0f5tz4oqcojqXCPzyX7G8BPiHAF9ELY9TPDTQ/7x9Oq2LTt/YkujEr/njEjUqfEXHSSQ9f/wF63IPP6pGFMF/rpH72hc9AXy5fsuAQZyz7vZ0lGWQq3v+JE7wSiFJ0Byhkh3Mvf64ANPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c306a1b38so313562039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753233438; x=1753838238;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aep9h97yzq8BxK3rUKzUgGRp8xlimpOzQ2+X26fDUzI=;
        b=iHsaa/KFSc90Gghcg9mVoM36FD8ez0dc+3K0egbp5qeUX81FgbzVfXHHWIbpuLtNYs
         ui90eB5McFYggvnThXVJG3jbdwTSlUO1NvlVROBs9EPmCPtMmGnrnokEYBJjoDKz7Ecx
         jqxwuH+Q38kn/PZoB0719UGBPum56RqJ1gHTOamA4+4GJKEL+zMotfkXpiapjgGxwIfK
         89h25rrfsUpImZA5SGkr5a3hGvwvqdeCOdHHYKgHjer2cuhRMrhfCF/2UkhsK8tyfe0/
         WJFm69hJTiK5iGjmik2lEkgLuYOKxy+3ffsN4HEoAKj7MKO73l8crlRNTskrWbD6n0/P
         rczg==
X-Gm-Message-State: AOJu0Yy2X0O8yfH/7h6oMrf8vOb4iqBIVDBHc8Q4gJRc/rSNHLqnyvFJ
	ek5dfShir81rMhe6wMYQCXl+RXA067mDTo/27BWeHHxUFvI/GmXLsaxJ+KgCvxzKqEfnKKwEYOu
	/6jJQIldAIzvs4vIEAS3QCRQf93o4qswcZODvQLge9WueZq3dDl0Gg41EqxM=
X-Google-Smtp-Source: AGHT+IEmi1ki6mPidxS9aJGw/Veo/WINjD24WG34z1DrX8GAXU9BMYZKgmqwx0JiwMc0jXF2zRqD0CKoj6M7HF0kkYknwDw9Jgbo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cd5:b0:87c:41a8:6e19 with SMTP id
 ca18e2360f4ac-87c650295d0mr268311239f.11.1753233438252; Tue, 22 Jul 2025
 18:17:18 -0700 (PDT)
Date: Tue, 22 Jul 2025 18:17:18 -0700
In-Reply-To: <0000000000006304400619bbfae2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6880381e.a70a0220.21b99c.0016.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+c6fd966ebbdea1e8ff08@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Increase BCH_MIN_NR_NBUCKETS


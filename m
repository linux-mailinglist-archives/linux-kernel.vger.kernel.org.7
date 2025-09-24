Return-Path: <linux-kernel+bounces-830377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C87FB99825
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E56E3A9E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC86A2E173F;
	Wed, 24 Sep 2025 10:55:27 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406092D948E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758711327; cv=none; b=O+s+8FYjzBzvTfzE+ohM480ZplGko7BCaXkv9yqf3UojLlgl3YkInON9RqBhTfFhXtNWK0w1Vb9yf4ypCw8EQENo0OQwXyR3BDUj31ZEHsu2IulmgcUt8rNvk/dPwONDZR8Bf1ZlrUGNbZURKtn7ez04/1hvDTQA/yyN4CjPfF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758711327; c=relaxed/simple;
	bh=FvmDC6S+rZ9xjFam/7jcMnl6js38PleHmTvbPTS2xQg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=GQV/EbZlsRleTFHusdPFPsYnAUe80b6V+UedaijtNTPYvTzXsYEI/0wn3shtBM5YiVawu5fwgl2f49A7Frvipn5gKcqcfX8snaqHhjuooNpPB45hF++92g8dxQE0UIhbJm4ThyoAURY3whhjqX0CTHcMIq87kPa3qUMK2UdI7EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-8a559429a55so1385206239f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758711321; x=1759316121;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBdG7bZS3KXPNbooAcRTAg8wTxi+OggRKOQrJ0C+s80=;
        b=pfUfCSfgjLo/sFW+ag1y5GRWvafCqMYkm6Mu/vVYqZTuSRvtxS/VSQgOGorCRMVRNo
         iTennJBuUMkAbbOUcvMEezSTFuJhI0iyHnPUs+r9CSC/j2e8amhWyD71Bm8DPQls+mu1
         3lJvEPrt0j8kmUT9Sbj9cTpXUZsWCPU1UfjO1YIQiD16tpjaBjovfW70vgKBL8nGRW1k
         SkEw3fInmWtut8Bbu1fMriiXzkKV0jVkUGOV03XVIxfQ6SsZRk1Xahg4T4+zbmoCEcLt
         QJl/aaSe7j5NA22t4bX0ol2zL7fuoZGYMbUOM2KHcgcxTiJBdhpgyEr5IRNUJ2vRglfq
         x1sg==
X-Forwarded-Encrypted: i=1; AJvYcCV11QCC6frWJB9aTaPMZ2ogjZgAFFeTBWeRONsfT8o1KwND0c/wLVDZF28QxOiZwZnLXpK/ts9r924Ab/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzspFgdwxs54ZmnFAky0aMqFD2qeLFnTp9vdWvQjsb8snTYzpCq
	oUEeY8ENBYXczpagekZLtq1c9YNe8XEJJ8ZZUME369u/6J9Lnp2+qjgB3igIfaLHBBCmyCvdS92
	7E/3ZzqVQZYU9LBqnt2d5LOnSXtdwjg2Rjc1LSmtfu+bAqQMx53yZyh3jQqc=
X-Google-Smtp-Source: AGHT+IH0A3bRXl1YpmLo/ZngZUC3SVlpUthdA9pzXn9WgUSZ7hvvkxc9aU06dKGQiqGS9rJ7KUnWwPjhp8R7PeG6v9e3SaeEK0MP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e4:b0:424:8c2d:ca3b with SMTP id
 e9e14a558f8ab-42581e8ef78mr97998895ab.28.1758711321371; Wed, 24 Sep 2025
 03:55:21 -0700 (PDT)
Date: Wed, 24 Sep 2025 03:55:21 -0700
In-Reply-To: <4f6e21b7-3c0d-4f99-bf3a-3f20fafa9591n@googlegroups.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d3ce19.a70a0220.1b52b.02c8.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context
 in hook_sb_delete
From: syzbot <syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com>
To: twuufnxlz@gmail.com
Cc: syzkaller-bugs@googlegroups.com, twuufnxlz@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> #syz test: none

"none" does not look like a valid git repo address.

>
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller-bugs/4f6e21b7-3c0d-4f99-bf3a-3f20fafa9591n%40googlegroups.com.


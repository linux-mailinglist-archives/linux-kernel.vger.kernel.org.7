Return-Path: <linux-kernel+bounces-874933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F92C17882
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C0F7B354B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9C7275112;
	Wed, 29 Oct 2025 00:25:11 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A8170A37
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761697511; cv=none; b=Uxkn7pT6cRQ1eliAcczrmKljVCLov8XsKS4tM9+osH7bNxgAfqzDEazuFBBbXLVKxTSEFJpniGfNsimykTMCP719H3OKL1Q4ZHQREwNgLKW945R6QAz7aPziVzb/FaXnDlWhtG+bRs0qvJrY/zLSVjM/O3yf/hZcKlKf4Y/2tEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761697511; c=relaxed/simple;
	bh=DjcBVY8mJqbGJnCRObWENCx0c6xRt7QNzm9li1dg71c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=owIs6n2LN4mYO2J3azAa0mlM8gB24TrX4NC0IHdUGGz4erfyRbFYhlQt65Cmmuz9OkYBSLxg8YIhFboy8cpV9QyPT1zXQsXNLpSqC9TWWJMbBx+8VZFidJPR4KmyHGhXbRXdu12RSExdX3dSqovXwpLNStWGfn19c5V7BRO+Om8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-94109728fadso632206739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761697509; x=1762302309;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjcBVY8mJqbGJnCRObWENCx0c6xRt7QNzm9li1dg71c=;
        b=BgEwKI0Sy+SiCqtWjluZzp0ddfLOwCZd4iEr+7ZkHCHO7yeN12jHn7bikJWjxzitw2
         +asMEXBj5IULZrCMlI1ASmYoB4MHXuP7jjsXFNmLPeZzLiGvUzTV8J6Kq/fKGrN7JtJ6
         C3h+AQDIx4LO72UL1lx1N/OTT3gwK5ogd1I6vnpH1r0v4vj8atIVSP4z8PlVSzmXdiNU
         ooDxneo3iPxAwaWWNhEGBqegJ6KM9juZZ4wgZSNsD5aPixLNecyN/xSvBx4Nn5z5JRPU
         GUuhA53xkrmWYTm/dfxgcJsR+o1ubpVcA1hGDi8FkLrQTWtWcoZuQMI6XVlKg7fweIVe
         +NEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd8+NuXttsvPUXaXrlfNTAd8R3Ih6Cu6ItWzZcUPu1poV+tRrOnVZSqNyOoF5YDra4Urwu3cEFXdEZ3p0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5rXyeFYXaHXovS3Uq0q0dKnCbODVGhCHMHsUj5eyqIlTZV1Sz
	9dMMejMAyMlqrbHAeQ+V1FkIuBKoO5j008zki15YjjE4d+R57pBQmJGbIm8L4F3KnL01L0OpqRF
	HVzQCpjmwmdLG21mqzBojD4INW8PYHtDgbX13gMZ3z+o+KE0x3HYV7zyLJSo=
X-Google-Smtp-Source: AGHT+IHRPJ5vQoHGCAChMRTb+GIwk2dkZrqG6byeJVWlhSwoPis1XmTYkNmxVcxDmVOk4U7RHrNmmt0Y0/QA/uPrHF/tucDVAqRX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:9:b0:42e:d74:7252 with SMTP id
 e9e14a558f8ab-432f906642amr16004065ab.31.1761697508978; Tue, 28 Oct 2025
 17:25:08 -0700 (PDT)
Date: Tue, 28 Oct 2025 17:25:08 -0700
In-Reply-To: <aQFeMG8WEvrWaNf0@hyeyoo>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69015ee4.050a0220.3344a1.03f9.GAE@google.com>
Subject: Re: Re: [syzbot ci] Re: Eliminate Dying Memory Cgroup
From: syzbot ci <syzbot@syzkaller.appspotmail.com>
To: harry.yoo@oracle.com
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, 
	cgroups@vger.kernel.org, chengming.zhou@linux.dev, david@redhat.com, 
	hannes@cmpxchg.org, harry.yoo@oracle.com, hughd@google.com, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, muchun.song@linux.dev, nphamcs@gmail.com, qi.zheng@linux.dev, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, songmuchun@bytedance.com, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com, weixugc@google.com, 
	yuanchu@google.com, zhengqi.arch@bytedance.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"


Unknown command



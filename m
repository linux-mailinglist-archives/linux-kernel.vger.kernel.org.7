Return-Path: <linux-kernel+bounces-857818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E30BE802B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E3475664A0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DEF3128BA;
	Fri, 17 Oct 2025 10:11:45 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1263C3128D3
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695905; cv=none; b=gvnBzGBujg4YVN19uxDW0e/+RiK3jR82a6+nGshAe5ehPyj+yw4wDuz8Pc1PWTNP5LOauvIx94aDWfpUFZNu1qOlVZ0uZ2W7lZqtA+UXnLyGqIuPUf0AgMd6uFzKpeJVQVJl2t0NSWOJu6kbVoxKmk3SNWl6LhOUygCn5wZQQuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695905; c=relaxed/simple;
	bh=G4fUvqoSjCdtbOJ2ualn2U77pyd4KZ0RXhhv38WGBew=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fGDfOH7GPDZJowweenqe9L0GPyjsYFEQdcbe73NrQuZ9v93c6rVA7MFPc9x08mJ3difxkueHbR5H7KlV5NuvsOUYO7q/Xu4j47vUjP+3KWV4cTBbBfdTuBnQssvz6OEkq8PT4Yx9U1b/ecWsd9KamKR2QDe9vIc0A9QSAAnuEPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42571c700d2so48010305ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760695902; x=1761300702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4fUvqoSjCdtbOJ2ualn2U77pyd4KZ0RXhhv38WGBew=;
        b=jv652Sz54nYcrfQzPtr0Clk4mgV53T4kCkFMmfvy5H8aNLKVFlNo+KsLrQlrKWZhHH
         HzU+nWeWD0PVbMN/VnlZqIsc5c/lrw4MGQHP9zF/zMQkxpnSTQmAAV/BJkWy5LMy4KY0
         622+mdnTFRl3HzxykO/dYNyy7Xu3Jh+Ox4Cj/q/uj2+qWCgCSZhAucjVCLr5seAhfaB0
         6yNZrQqIMjjKBm/zfPq14jJuBUvp4aXRCMXI8IINAA2dRDD7VdJJIxphUNOMAc7tOUpB
         ijqHczO5Brfd1Qn7EnEUTkh3F4mwbslx21Vt6DIPmWahVYcYxqVoC3MDAxV/oCdI5I71
         JwiA==
X-Gm-Message-State: AOJu0YwJoNBMTZItX/31DR67wYDDOBMSjJbUqcB9HOQD5txGHGuJ/nia
	4fiKboYdbP13w179wQaIaDQDoYwuCGNR6V0uylKQx4R0CyhkbNUcIJ7JIiL5CMaJLuyBHmYHGhX
	Jv0ugzQNcKzp6UrvoR027aQzknGDJpZI0ubAU4y3d11vQWPzaIhs0jk5kOC8=
X-Google-Smtp-Source: AGHT+IGyQTa6uY/lS6lKZxomxt62EezK7SUUN1lndt/wwQ0V9kahoDtWD3z+IEJV6Ks4s/gzZ31X4iSvnxOTzUS4oYY1AVjeq3rT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe8:b0:430:c403:97ea with SMTP id
 e9e14a558f8ab-430c524fbb3mr47693315ab.2.1760695902293; Fri, 17 Oct 2025
 03:11:42 -0700 (PDT)
Date: Fri, 17 Oct 2025 03:11:42 -0700
In-Reply-To: <68ef030a.050a0220.91a22.022b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f2165e.050a0220.1186a4.0516.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
 2433b84761658ef123ae683508bc461b07c5b0f0
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 2433b84761658ef123ae683508bc461b07c5b0f0
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 2433b84761658ef123ae683508bc461b07c5b0f0


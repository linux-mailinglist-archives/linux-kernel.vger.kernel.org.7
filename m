Return-Path: <linux-kernel+bounces-794117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 043BBB3DD0F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A71189DBBA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86073238C08;
	Mon,  1 Sep 2025 08:51:36 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E5C2FE592
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716696; cv=none; b=TXkpWFRuSUJkU77OJVK8MJWKTHTIxUAn40bQq9JFTUOSI1DJ51lh1FZoO35z6cqLpZr60GolNy2qltCStOQ55G6tfaxHcOmqXRPYcFBytUeedKelafT3T60tU8uh64njTvyGlabRrcVeuHWH7bc8UxzGkh9y+z0RMsDJeWQqseQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716696; c=relaxed/simple;
	bh=fknTa8a8xDipkCYrePSsQTLagTPC4FM5VAA/rgPzynU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rAiz2zyrARbYRvgNdtL6a8xv5AKl5vLvv/jQCBGAWA5EQuBAV6GWtNSi0pxTbOZQHkz1YeF8LmaiHgrVFBV9M4CW/8a+htwnuyxlNZgHTMJok//u8wK0JVz/DuHELJSDUru1rgebWjZfqcyKzZwMSuSnys+SY1VJR+h5ShnQSkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88733385338so50216339f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756716694; x=1757321494;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6QhX9JfzOe0jyuZyP+4YKY9K8LKwJP5t7uxyVlFjHVM=;
        b=sfxWpZ+D/0O8f2MEKHrqTK5uOgkmxb1DkTIhnpfKR5Xl/+wE/Ge3BWxZZs44Rmg7f4
         2smgoK/dehVQsyaWmPAdqXrCXZLW3uwYf3zpplbn9Aa3eW6TXjUylNgESHlgKvISIDVL
         it1/eE0qked+GGyZbBksfQJmVUm2ZshfSTlLHm4MJGSEpzqieULH3oVltmoj3wlpyec4
         zqcUPZR1S2jE1WrrGq1d0Rp5Cs5mmpvPpaWysk4KkxITy+CK+EKVQidULhV9Ra57GFXd
         J+Fq9gUPnJD10aqyPvMc6QK2jDHuc8R9rELiaLTcEhobCvCWlJzWSsOrU47f3OOHfMC3
         Ukyg==
X-Gm-Message-State: AOJu0YxvXE74kKDQbGuyxn9N81c4BsvXGZjV2YuYNpPVVPzBso+UIls4
	2kXfvVP/Q9DU1wqcQgS5WIx1MaO5teQ121LTngrhHqmqsR8GnUj6VRBu/hx/Dz3GhMOpZ/jkRyS
	1IzpEGYOZgMdZe7f/FD9mu2iOAbRNQFae7xEt1NwzS6/33VWEWWbQc8+Mgmw=
X-Google-Smtp-Source: AGHT+IEO+IFpWyxZOWrNHE2CB3Bd+xHBTZPUGeX73h9DEmAFht48fwOVWhVNIjf+jXT/nkhJ98MeF5Uv1ZSYIUqYka8nNkplfys0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14ca:b0:887:1e5f:8a41 with SMTP id
 ca18e2360f4ac-8871f41ea7fmr1557059439f.1.1756716693756; Mon, 01 Sep 2025
 01:51:33 -0700 (PDT)
Date: Mon, 01 Sep 2025 01:51:33 -0700
In-Reply-To: <688c72b6.a00a0220.26d0e1.0064.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b55e95.050a0220.3db4df.01be.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+c4f4e64f6ac2733325f9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: nogikh@google.com

#syz invalid


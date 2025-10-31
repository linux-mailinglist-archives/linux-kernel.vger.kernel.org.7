Return-Path: <linux-kernel+bounces-879937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E06CC246E8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CF23B7A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B633DEE9;
	Fri, 31 Oct 2025 10:22:51 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88AC31197E
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906171; cv=none; b=Qm01HTozmgEW1u+UEt9wFiVQfe9KmabVtsrCoPRdyK/L96hdhxQtL/3VAO2MUkCo86H5ORiWDcvMiVjm7LPEhAZbDU4KwFlgUMZxACeiRVXHtOcqxEJcnkXo/cdWYfv0DriJEfF3IatTNMppNMt3+hx9k9V7qhY0r69FvMh0P1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906171; c=relaxed/simple;
	bh=M71T/ZJ+3xq/7S9fMBH541aTzoNX8hQXml3aB8Tq6G8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OxjyrWrCKPNx4Ib9lfO77bfm2Uy2ZUcXiqEs2MyBCkTe7v1IyaWS9SwtugDFy/upD1K7yZ1814z4phxUSzvgufJvl7VMlfV8xwlpfS8It4p++FnKlNpDw8QGS2HFN1gKmFUx7oKOlFPm5TbWsLXqyoC395yE88SFaT7hhuIxWZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430c9176acaso30500515ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761906169; x=1762510969;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M71T/ZJ+3xq/7S9fMBH541aTzoNX8hQXml3aB8Tq6G8=;
        b=HkcppFl5ckl6AotN98e9eTZaVzMK/elYAFcbAz1/G5mdPoCr+ZmtjaOcBb2EnG8j5E
         czb1vFshl7Drnth+elwKq/S6vHFL/upAgKv6vpAmbX49W0X0DatyJ9MI/ooxL3sjEU6j
         JO+QGGKJCl7qR2Yf+DD+DCenJgBqwt0LR5j93oJUyoKapFsIdzRF4BzKqEPY9Hl7DqHh
         A+PfzD/3e6Q7+YYIT4QP34iLoWwf4ByCBhyLY/746bOs5h2u4PLMO4Q1OpAJbQ86qs4y
         pV5N4+BErM9rQZ9M7PKXLzIv5bllJHlsKNytBGjvNy2hgx+IYrXh+wfFKRIqoIFPJkYd
         Xgpg==
X-Gm-Message-State: AOJu0YzXgoNvRNZXbc3R31PytKIo6ARQ9BzNwiV5E8DuRTvWO9U+BUM8
	c0TsuAHv6XC2Fe6BFW1h+ecIlNw6LH8JKWpR+Hf2j88hc76KWwGZLdADP/6Pwwn3IWQ70P8zBEV
	OM0fG9mNtVSE1pbF4Tk6pV6uYO9gm7jcnyb1uvyta6/WpVcH1+dWBDKgkxGY=
X-Google-Smtp-Source: AGHT+IFxb9Fjc6LLuP1TbHD/nuRF5v2ZxI9ESb8Ai1uyQqqs6xHW4xbGJ0d1VNW5J1x5W1KmQ9Kt9jiZ/gf0MCSUqF/fBJB4Zk1h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3988:b0:433:31e:1adb with SMTP id
 e9e14a558f8ab-4330bda90e3mr62009755ab.7.1761906168924; Fri, 31 Oct 2025
 03:22:48 -0700 (PDT)
Date: Fri, 31 Oct 2025 03:22:48 -0700
In-Reply-To: <6889adf3.050a0220.5d226.0002.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69048df8.050a0220.e9cb8.0009.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [netfilter?] WARNING in __nf_unregister_net_hook
 (9)
From: syzbot <syzbot+78ac1e46d2966eb70fda@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [netfilter?] WARNING in __nf_unregister_net_hook (9)
Author: phil@nwl.cc

#syz test


Return-Path: <linux-kernel+bounces-873450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961E2C13F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF973BC4FA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE36A302160;
	Tue, 28 Oct 2025 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhE5EfWm"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8747730274F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645253; cv=none; b=JwbcxV5UMMTj9h3Xl0Y/5gb4n6z5bFnI7tk3jJDeCGjsm14707r3YJ6wZ0rMW3yFGfO0AvH4JRrzr7GDT7H1UobC7BWkY9gVO6tvW5FFxa/pa0JjzBD9sspBaFq/cAMlCMzK5X5hgacLaFNZ78RBmHZlK4weRAeDhlomttYZyP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645253; c=relaxed/simple;
	bh=o4CatTXk3C1VwFfoRAdNv+qAYE3ujOUobvckbuzv3dk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTU5BzplkXTzwq/EOiHwKr7Jt7Bi75A7UE07du8iqCO4E5DdXVouZwXZVqMWFwQaRcUleGT/T24GlKprOYbVPsoBzyGK5Q7dlq9734MhcgnqxS+hBex5fug2/vzxdkp+aInC1qB/yYXBHwEXipzELW9S5LWvxg5moUS8f7fjY34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhE5EfWm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso23108135e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761645250; x=1762250050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eov/MPh/YX8dO6loIW1fKNx4DJr3A70PfDx1JeMPyWU=;
        b=DhE5EfWm+ATSe30OyLNn7OE1r1WkaVmIjp5JuGbRvtZKJs1SKlbDlTwbDs2UlApB8X
         wrYSdE21jTY6miJ5SjUimeoqLCyMMgbX6GGjtf/jWIb7bHFAAEHKxbYaup0pSfrbSicv
         AdMHaklaVqA12UbHVHy6vaW3kIQgvo8K7vfJJrco1IYjw3/2V/AafhUvUPlmbyVe4yka
         zjPx2rfZWLRbMBF0u8eXebtLi1zay1iHEK1ek80orDWjXXm++y0GbXjTObd4qvvwTD/k
         0uHhGq2kOwsl/n1V2UWsAIX9iBUIpANeZq0rkfACv1wzZcoTZwio42AJSvXxgvUd6sSg
         WQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761645250; x=1762250050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eov/MPh/YX8dO6loIW1fKNx4DJr3A70PfDx1JeMPyWU=;
        b=iG+HCuGmt90b7rJRa/Zuj818g9iyNzaAOkeJIC3oZqOfjeniXkzrRUUmHXyCk8ys7f
         iS/DOD55Gm25Jy3QRiOBCI/2rRg7A6/cwZ6TBZaKyWgk8oEbFTk7xp+RuZaJS+nvRuju
         ganDc2VfZ8NXTtf+lmqb1o3au2J8DFyN2fv33OZfAxaCCqIlkRZ/3dezGn/eRhFKSRAm
         MwcwyzFS2/k88bFQQoiAD8KIQWmI+G0FCnMX4DU2EVLSZSs8foHX4xNg1ZMh+IklnoBu
         Z7fF8Vh13GKvIcU4vxeUVVLy/pSHuNwhrvo9551X6aEpPICf2pxZQaXddH8ZxhmMN9qm
         bzzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5v1S1wQKhAqyJv1wImmOEKbwfozZRr6t5tWqJaZM5UWJk3u20d2LHdKWWCKLHZxNJr2Va0op1/rkajv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIrCHE6J/AlL0y5eGUspmLimOjQGmGkj4CoVCENUdhSNE9SirN
	sOukVZH8DmY8ohxDH2Rtn88vNcGNriId06KEI4oohIbLFgpbcBXg5IO3
X-Gm-Gg: ASbGnctmYwa1J+xBTI1/9hPdK9Jy5RgYNzccxdBjTqmuYTo/wlE8gISUgFsEastEadM
	HB9SqyazceJP3ZzD3iXdGQilToA6ipgpY1WrwNKyFwwn42nzn7nLhecSBFgzh3stsSMoGUokpsz
	sIypRNIF9iv5bWTvGqm28cwH4KAhFdXD5hSANN5eD1R6bSago+yNE+9EYA3U/rugLOLxZ6QbAQ7
	aZP0R2xX6MuhB3SDaj7g/xW8sHGZF3CaJ4g8rixzuAOzMDn28bdII4K4+aX63FUUr0y+lz/VPE9
	MdEN8NxXtl6xGnDPaYR7irDW8moCAXtdvI0kq8xO5T8zbM+o7j8VxEKVT5NJ6QvEjI1EypPO0yN
	uwodE7jy44VbhkFRGs7e8Qoeg4/2W11SsFeaJZBDXvE8vrBw3EAioNb204M9akvalpdE9l3NB2j
	dEXzt21qPPp1o8F7ZOgJeOf+LYfSXDPWKAafnQGgoDdA==
X-Google-Smtp-Source: AGHT+IHTsad+5R9VyJ1jsBgS805AF7/gtOcePpU3LeuhaXctgbpE0MIvJRpdSfBK4sVPhc9XIgYUZg==
X-Received: by 2002:a05:600c:1e0f:b0:475:dbb5:2397 with SMTP id 5b1f17b1804b1-47717d488f1mr20861355e9.0.1761645249706;
        Tue, 28 Oct 2025 02:54:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4783b8sm187327045e9.15.2025.10.28.02.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 02:54:09 -0700 (PDT)
Date: Tue, 28 Oct 2025 09:54:07 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dave.hansen@intel.com, alex@ghiti.fr, aou@eecs.berkeley.edu,
 axboe@kernel.dk, bp@alien8.de, brauner@kernel.org, catalin.marinas@arm.com,
 christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
 edumazet@google.com, hpa@zytor.com, kuni1840@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, mingo@redhat.com, mpe@ellerman.id.au,
 npiggin@gmail.com, palmer@dabbelt.com, pjw@kernel.org, tglx@linutronix.de,
 torvalds@linux-foundation.org, will@kernel.org, x86@kernel.org
Subject: Re: [PATCH v1 2/2] epoll: Use __user_write_access_begin() and
 unsafe_put_user() in epoll_put_uevent().
Message-ID: <20251028095407.2bb53f85@pumpkin>
In-Reply-To: <20251028053330.2391078-1-kuniyu@google.com>
References: <ea7552f1-842c-4bb8-b19e-0410bf18c305@intel.com>
	<20251028053330.2391078-1-kuniyu@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 05:32:13 +0000
Kuniyuki Iwashima <kuniyu@google.com> wrote:

....
> I rebased on 19ab0a22efbd and tested 4 versions on
> AMD EPYC 7B12 machine:

That is zen5 which I believe has much faster clac/stac than anything else.
(It might also have a faster lfence - not sure.)

Getting a 3% change for that diff also seems unlikely.
Even if you halved the execution time of that code the system would have
to be spending 6% of the time in that loop.
Even your original post only shows 1% in ep_try_send_events().

An 'interesting' test is to replicate the code you are optimising
to see how much slower it goes - you can't gain more than the slowdown.

What is more likely is that breathing on the code changes the cache
line layout and that causes a larger performance change.

A better test for epoll_put_event would be to create 1000 fd (pipes or events).
Then time calls epoll_wait() that return lots of events.

	David


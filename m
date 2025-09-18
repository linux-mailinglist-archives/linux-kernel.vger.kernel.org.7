Return-Path: <linux-kernel+bounces-823329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725F5B86234
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF22C56021D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030FC2571C5;
	Thu, 18 Sep 2025 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="s0llzcGT"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1831B25484B;
	Thu, 18 Sep 2025 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214691; cv=none; b=u3L2ax/kvCUOfxOE5VIn8QbfZCrqrNVb7ncpVnOR9vhxBoIDfxbfAHNAdbNFyXzscIihOM/q6VXur9ElhtJ3VavYahro61HneHZ4eWGxyHXyfcoRpk3LiDNqMfdsBm9Gzkmvfj5n5TAepSWko3ERL5Det+oT9W1/q2yjfZ4IcAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214691; c=relaxed/simple;
	bh=YLt+tjtyC2ecTThBQ+2PebW/E52xZClKt6CEmqDT5+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d4J/MLiyvx8ECEMb9PeGWflsAHUhSYyoXEF5k+oZHlea2mnfbvvLaxc6tScTw1gD0sutfc55oMB0i7RbF2UVbnDvYcmL/loNsHLmhnLMTTxq2k7NniWTZcdYBtOS66H2zQW8zizvnrflHerr0PWIw5cwEfIHQTr1O0zD+gGQlkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=s0llzcGT; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4BFA6406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758214689; bh=qQYZzRJxBw7EljE7CebDwpEwBK75h9CzuR9gLWwgYZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=s0llzcGT7Co2nEUOVFx5xMLfX5SxOydtRpzpwbJhCYmKcoudXcLiVf9P1TYrWm24g
	 lhgMQoB+kFHBJzWMBJ0fBF3+3Ug+wrZIKylv1sq83iZIXIiLkmbtj4vf3QtTZnW7kj
	 v9RTLg9u+Ou93ZM3DfSn4YyVQl3UcgU99T4mW0y3EN4Zd4It2VpkbgtlM1fUb4ewVO
	 TXi+FpXd7Px/gF0dehadXI76acTRamiefckQY5+7x7xqUIojHqfCN91i5Jfrs9g9dz
	 nxcIt3DuCW/7nqKg3A3N6w+yZFfkQ11DM7h/iYfG1U+tsAJRWyTOFGZnwXms/q07Re
	 CJgkjHhyP/FmQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4BFA6406FA;
	Thu, 18 Sep 2025 16:58:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Akira Yokosawa
 <akiyks@gmail.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/24] scripts/jobserver-exec: move the code to a class
In-Reply-To: <4749921b75d4e0bd85a25d4d94aa2c940fad084e.1758196090.git.mchehab+huawei@kernel.org>
References: <cover.1758196090.git.mchehab+huawei@kernel.org>
 <4749921b75d4e0bd85a25d4d94aa2c940fad084e.1758196090.git.mchehab+huawei@kernel.org>
Date: Thu, 18 Sep 2025 10:58:08 -0600
Message-ID: <87segj7l5r.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> +class JobserverExec:
> +    """
> +    Claim all slots from make using POSIX Jobserver.
> +
> +    The main methods here are:
> +    - open(): reserves all slots;
> +    - close(): method returns all used slots back to make;
> +    - run(): executes a command setting PARALLELISM=<available slots jobs + 1>
> +    """
> +
> +    def __init__(self):
> +        """Initialize internal vars"""
> +        self.claim = 0
> +        self.jobs = b""
> +        self.reader = None
> +        self.writer = None
> +        self.is_open = False
> +
> +    def open(self):
> +        """Reserve all available slots to be claimed later on"""
> +
> +        if self.is_open:
> +            return
> +
> +        try:
> +            # Fetch the make environment options.
> +            flags = os.environ["MAKEFLAGS"]
> +            # Look for "--jobserver=R,W"
> +            # Note that GNU Make has used --jobserver-fds and --jobserver-auth
> +            # so this handles all of them.
> +            opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
> +
> +            # Parse out R,W file descriptor numbers and set them nonblocking.
> +            # If the MAKEFLAGS variable contains multiple instances of the
> +            # --jobserver-auth= option, the last one is relevant.
> +            fds = opts[-1].split("=", 1)[1]
> +
> +            # Starting with GNU Make 4.4, named pipes are used for reader
> +            # and writer.
> +            # Example argument: --jobserver-auth=fifo:/tmp/GMfifo8134
> +            _, _, path = fds.partition("fifo:")
> +
> +            if path:
> +                self.reader = os.open(path, os.O_RDONLY | os.O_NONBLOCK)
> +                self.writer = os.open(path, os.O_WRONLY)
> +            else:
> +                self.reader, self.writer = [int(x) for x in fds.split(",", 1)]
> +                # Open a private copy of reader to avoid setting nonblocking
> +                # on an unexpecting process with the same reader fd.
> +                self.reader = os.open("/proc/self/fd/%d" % (self.reader),
> +                                      os.O_RDONLY | os.O_NONBLOCK)
> +
> +            # Read out as many jobserver slots as possible
> +            while True:
> +                try:
> +                    slot = os.read(self.reader, 8)
> +                    self.jobs += slot
> +                except (OSError, IOError) as e:
> +                    if e.errno == errno.EWOULDBLOCK:
> +                        # Stop at the end of the jobserver queue.
> +                        break
> +                    # If something went wrong, give back the jobs.
> +                    if self.jobs:
> +                        os.write(self.writer, self.jobs)
> +                    raise e
> +
> +            # Add a bump for our caller's reserveration, since we're just going
> +            # to sit here blocked on our child.
> +            self.claim = len(self.jobs) + 1
> +
> +        except (KeyError, IndexError, ValueError, OSError, IOError):
> +            # Any missing environment strings or bad fds should result in just
> +            # not being parallel.
> +            self.claim = None

Sigh ... this kind of massive try/except block is one of the best ways
I've found in Python to hide bugs - and Python has a few of those.  I
realize this is existing code, this is not the place to fix it, but I
would like to clean that up at some point.

jon


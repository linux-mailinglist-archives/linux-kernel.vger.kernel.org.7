Return-Path: <linux-kernel+bounces-724614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AAFAFF4E5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1ACE1715C8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D384A247294;
	Wed,  9 Jul 2025 22:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lMYhXMxe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39223801
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100914; cv=none; b=WKBgTQk0+yimv9DRjYekHvWuFM9buhegCFpdpUi/ee/+Tbtg7uhb1We6U2ri+sVyk0ycM58Z4VFC1Sjc9XUz4Y8WrSENq4VWfQIzfGixoC/3sXlFbfQBRO0/slmw4AW/OkAVpuuUEa5nusQZIPVKIoSfj4eOvG0RXy9vMN70Z84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100914; c=relaxed/simple;
	bh=7WbOlnoAK37r9OVtXCGqBIq/htp16rsXPL68cDGlAlE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=F1+lAExF80+O2Xq2OhOTwin9qJKgbq3WuZzEa4nuVuzOIyB0Hn31hthhqyOqC5Gav77TUZ4LLW6ucAUtRcaprJKenrkKIM6WQRT3HEAoFZhyrJ2E9ovs6USXdx4oqPTiqm8LZzZciQKonI+NBRC+3tZkpOVjZIjMv6NjSW021ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lMYhXMxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6C1C4CEEF;
	Wed,  9 Jul 2025 22:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752100913;
	bh=7WbOlnoAK37r9OVtXCGqBIq/htp16rsXPL68cDGlAlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lMYhXMxeOknpc33muotgQ5z85yymCOFaZl4E4PdBXtqkXZqtYf/msYQm94j9Vw9WQ
	 n9djmUj3MzedJXUFOz641kzDZeXL505BEUULji4T59ul12ZzNLDSsxO8dBb+NCRNAY
	 DQV9eGbaQ+U35+vze5cF1XD6HSuvsZLTROBZV6DY=
Date: Wed, 9 Jul 2025 15:41:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Mateusz Guzik <mjguzik@gmail.com>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jon Pan-Doh
 <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek
 <karolina.stolarek@oracle.com>
Subject: Re: [PATCH v6 1/3] lib: Add trivial kunit test for ratelimit
Message-Id: <20250709154152.8d2a3de8894b80e4d85d1692@linux-foundation.org>
In-Reply-To: <20250709180335.1716384-1-paulmck@kernel.org>
References: <d1007957-97ff-4f6f-92ac-606f68c65dfa@paulmck-laptop>
	<20250709180335.1716384-1-paulmck@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Jul 2025 11:03:33 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:

> Add a simple single-threaded smoke test for lib/ratelimit.c
> 
> To run on x86:
> 
> 	make ARCH=x86_64 mrproper
> 	./tools/testing/kunit/kunit.py run --arch x86_64 --kconfig_add CONFIG_RATELIMIT_KUNIT_TEST=y --kconfig_add CONFIG_SMP=y lib_ratelimit
> 
> This will fail on old ___ratelimit(), and subsequent patches provide
> the fixes that are required.
> 
> [ paulmck:  Apply timeout and kunit feedback from Petr Mladek. ]

The above line makes me suspect that this was paulmck tweaking someone
else's patch.  If the authorship correct on this one?



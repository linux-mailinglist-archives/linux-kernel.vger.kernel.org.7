Return-Path: <linux-kernel+bounces-861544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBAABF305A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB7664E5FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B612C327D;
	Mon, 20 Oct 2025 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WkNfyVdJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB7325A65B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986294; cv=none; b=F4n9mcsUQOTheRumcwpaOLvoxEVVfmBknZqpzDTVi6wE8liHpgtI9g/Zi3ZCn38FTD84n+8UX3nzC+V0sFuKPs/WqXwRPK0COeH1BU7hXPbshN+v5mX6UbsI4aOQxnazNM6euSzt7bN9vjpLK8uQLdBr1r3qNAl3oQTVhr2WP+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986294; c=relaxed/simple;
	bh=40LTusOts5S9t0vBDeulq6YZCZDkQDSQp5HJ5bDVNnU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FjXQy91edt/j6zMXNDuUHfQBY+NtPbXP9eZ57l2HkGhtme4ZYTK7aB4ZjwYi2OiB/XgMTc0glAIVJ23lwzUKckCh2vUFyn/7loftMt+iNZiJq8313VkaDJPSferZS5fP290DUE5Avj7cVZyYnm+FDhkIrR2FRDLmYaFq6wxGLE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WkNfyVdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F2DC113D0;
	Mon, 20 Oct 2025 18:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760986293;
	bh=40LTusOts5S9t0vBDeulq6YZCZDkQDSQp5HJ5bDVNnU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WkNfyVdJHb997RiacCKoiESXQWvl5qv62lTfBduxMC6Yy8VC1R4vLFSo+A44gAAEi
	 nRJsAt91Z5jVmPp61XHAGax5UVBZ8IomtiBGjcPEYnVDrzCS0SIXz96YSSLPlTWD+s
	 Jh4ZrM2NaSu1av+YvsczRKbWIGuAGn5hCFTs0le4=
Date: Mon, 20 Oct 2025 11:51:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Chant <achant@google.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Brian Gerst
 <brgerst@gmail.com>, Christian Brauner <brauner@kernel.org>, Francesco
 Valla <francesco@valla.it>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Guo Weikang <guoweikang.kernel@gmail.com>, Huacai Chen
 <chenhuacai@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu
 <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Michal =?ISO-8859-1?Q?Koutn=FD?=
 <mkoutny@suse.com>, Miguel Ojeda <ojeda@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap
 <rdunlap@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo
 <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas
 =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH] init/main.c: Wrap long kernel cmdline when printing to
 logs
Message-Id: <20251020115132.10897a599c8fbda4829b3f89@linux-foundation.org>
In-Reply-To: <20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
References: <20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Oct 2025 10:06:14 -0700 Douglas Anderson <dianders@chromium.org> wrote:

> The kernel cmdline length is allowed to be longer than what printk can
> handle. When this happens the cmdline that's printed to the kernel
> ring buffer at bootup is cutoff and some kernel cmdline options are
> "hidden" from the logs. This undercuts the usefulness of the log
> message.
> 
> Add wrapping to the printout. 

Do we really need the wrapping?  That will confuse anything which
parses the output expecting a single line.

And the code would presumably be much simpler if we simply chunked up
the printing and spat out one really long line.



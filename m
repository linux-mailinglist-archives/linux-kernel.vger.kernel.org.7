Return-Path: <linux-kernel+bounces-747544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2906B13503
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C633AEBC9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3257E221FBD;
	Mon, 28 Jul 2025 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hovwk7e8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8891C214A6A;
	Mon, 28 Jul 2025 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753684855; cv=none; b=pbS4cLqNm/ttC2um+PSihW/I9NESsvzZNgetiHuMUIZsXwTIxg/vmAz1/tFkUgPQKQsUd8sD/bgLTuug3cPvSBudLBuERyI7HDG258MCqtb8+c9Tdow1PZc1fwprhy/xiovohr7Fr8D7N9STpTuhc0+xysRKwUUKSqv2CWnaQuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753684855; c=relaxed/simple;
	bh=7HB3lxWcDLSb2k+vPs56zG0WwRAzgz2wHlSPdrUB6zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLf5vAxV/W8RORbJHChtzWbfYzKVZEvSkvKcNRKBb1eDeG/4h3cTRub0bApU6A4CnG1WdEx0c37fgleMB86sKijVnjT7o9Kq+/6HRPB1uMVjC+TdF2Ucl9B/p6ZZUUwW6kFUcb9ynZgzssFlTBA8yTJ2vqx8klaa+Tl4zmDZBz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hovwk7e8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04527C4CEE7;
	Mon, 28 Jul 2025 06:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753684855;
	bh=7HB3lxWcDLSb2k+vPs56zG0WwRAzgz2wHlSPdrUB6zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hovwk7e8BJTy7kh1tMbykfASwd/gsx8XFDCYjPQf9OUXYjQKD4q5CoECljPVsPUoU
	 gmeSqzq3lUDQIScJ6qAbF5uAj4bJHvwJx0fE+3fvQYMGNrqRcLx4TkyImbQ2Hv7Yrm
	 Wc1UU6L853QcuHTDYMmxiJfaZA59lv49FTd7fvsdd8d3s3gUFHTz4/BGBNWfFFvZfk
	 xGZ1yaSgdlGrbg6OtNX/R/sGAkqCyM3peXcssh7wrCovdpRxMC0iNNGr5rgqWEJZEh
	 ZW7BQBofDlvpU3R3TH1oT323yPymTAAiw95/d8PwrgPPni2ckaWuFtggBscF0rvmVt
	 NYikTkeCY3YVQ==
Date: Sun, 27 Jul 2025 23:40:54 -0700
From: Kees Cook <kees@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	Sasha Levin <sashal@kernel.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	rostedt@goodmis.org, konstantin@linuxfoundation.org, corbet@lwn.net,
	josh@joshtriplett.org
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
Message-ID: <202507272336.E17C3032D@keescook>
References: <CACzwLxg=vQeQKA1mPiYV9biu=swo7QDmjB3i=UhYmv+fGRBA4Q@mail.gmail.com>
 <053939E0-5BAB-483A-9FE4-92BF35201A4C@kernel.org>
 <aIZJppabYBCDBhYJ@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIZJppabYBCDBhYJ@gallifrey>

On Sun, Jul 27, 2025 at 03:45:42PM +0000, Dr. David Alan Gilbert wrote:
> When doing qemu dev, I frequently run it in a tmux, and start it with
> '-nographic' which gets you a single stream with both serial and monitor in it;
> alternatively you can get one pane with the serial output and one with the
> monitor, that takes a little more setup;

Yeah, I haven't played with it yet, but I expect I'll need to try several
approaches and see which the agent can best deal with. It's better with
non-interactive stuff, so I'm thinking that giving it tooling that will
run a script at boot or have the image bring up ssh for the agent to run
individual commands via ssh... it all depends on what the agent can wrap
its logic around.

-- 
Kees Cook


Return-Path: <linux-kernel+bounces-785743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BB1B35055
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4C2242504
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2903257830;
	Tue, 26 Aug 2025 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="q2z9MFNA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E79219302
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168713; cv=none; b=bpRAiP2rcxUuQ8YHd0SV+b/w2kKl1WF1nqzNtp57Xj8vM76+R+Khf4SPiboAdnsdGi1QQs7ZjJc/MBrnY8syLiHrKB7+zHjMVM40uwP2FD7f5DklCgSXaKCJ1WGYSpW9Lnj9TuIPB10jgOELTzOjd/2Rw2+ZHMSOrgGAH5eHLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168713; c=relaxed/simple;
	bh=6mmNCAZTI1xIaZ5vcp5Qme0Zd0dA/+9Aa12UJu9OxtI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ve30ScxnuKfaomghftaS3JsUfKGPy9rdPXLaLf+WRpADx7dbpmOhUChnE6xTwWecCBi3EWW5Rvc4JF5xDh31PjJLy+j/OFHIDLQ1Jhfc89CmclqSDbQ8XiaChpxUjRYeprmQeur24L0tmGbuoW5nwCiKXcy27vJomI9pkpy7gHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=q2z9MFNA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72337C4CEF4;
	Tue, 26 Aug 2025 00:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756168712;
	bh=6mmNCAZTI1xIaZ5vcp5Qme0Zd0dA/+9Aa12UJu9OxtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q2z9MFNAQRmqmp7J7jkBkeVQLLM53RxPkFT61iLmimPeBvzFob3Zjj7ZVhgH0dkDB
	 HXuEizE/8qFN3gU5HVyc/H8lwJKZMsVnJ2dvBHCzr5VhLRgywYogRRJPavMep3pqof
	 Q9kKvCMjdgOJ3BT8EWOi1u184dNomrKP/xRnQF94=
Date: Mon, 25 Aug 2025 17:38:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Lance Yang <lance.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, Askar Safin <safinaskar@zohomail.com>,
 paulmck@kernel.org, john.ogness@linutronix.de
Subject: Re: [PATCH v2 0/4] follow up patches for panic_print's
 generalization
Message-Id: <20250825173831.c53524b7b6a9a1bb07c94088@linux-foundation.org>
In-Reply-To: <20250825025701.81921-1-feng.tang@linux.alibaba.com>
References: <20250825025701.81921-1-feng.tang@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 10:56:57 +0800 Feng Tang <feng.tang@linux.alibaba.com> wrote:

> Generalization of panic_print's dump function [1] has been merged, and
> this patchset is to address some remaining issues, like adding note of
> the obsoletion of 'panic_print' cmdline parameter, refining the kernel
> document for panic_print, and hardening some string management.

There was no [1].  I added

Link: Link: https://lkml.kernel.org/r/20250703021004.42328-1-feng.tang@linux.alibaba.com [1]


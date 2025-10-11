Return-Path: <linux-kernel+bounces-849222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BFDBCFA12
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 19:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910F73B0D01
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 17:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5328828151C;
	Sat, 11 Oct 2025 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gBHXicB3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE65205ABA
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760202679; cv=none; b=NJpvXysMw/u0hK/3gDvxMBJAP1lRKas7gpSMHQYjUMVOTQR/Tt0mW830fjHn2s+6E68WUtih9Q/roxXpUiAAV5ZQg5EAHGgmFc5mPtnXirDCvVNKzjp9KyPcC2R2qNDUBrN3xn3UgcBnkZQ51+4bqxxobuRiPd+++TjoejFzm14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760202679; c=relaxed/simple;
	bh=SBxfC+hheIAWHetyxEZRKMK9fS8I6+Mjf/rd/aBVjb0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iXbcq5Emiio7KSzqKrZOM0dOfRh2qUs7QAuuYVfKPtuQ3X9GcfGJzETbkk/5ZX+EXgSNq2cnW1sbuakl8286OImZWgkRR1XFe+z0ZH4XwQpiLP+BOY6oKiqIT0FisyChuWxsNr268JbiUFt15CLnxhFJuFY1MrJ/AWHIdakMhrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gBHXicB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F76AC4CEF9;
	Sat, 11 Oct 2025 17:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760202678;
	bh=SBxfC+hheIAWHetyxEZRKMK9fS8I6+Mjf/rd/aBVjb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gBHXicB3RUHU9mx4lY7rzM2lVZuMlvdoCvougTT0t8+D2jpSZmTUSyGmK7BRMzPWr
	 7iAPlbatnHO1qwEInGnbmXPzx5J9wRkkBD/GgD3zHKqMwwvHTzry/C6giC8bNKFRPN
	 MTv6pFX9eAyTD6Uwi0i/uMGo+Rwftpn70Fm2nirQ=
Date: Sat, 11 Oct 2025 10:11:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zhichi Lin <zhichi.lin@vivo.com>
Cc: elver@google.com, will@kernel.org, andreyknvl@gmail.com,
 samitolvanen@google.com, yee.lee@mediatek.com, keescook@chromium.org,
 linux-kernel@vger.kernel.org, xiejiyuan@vivo.com
Subject: Re: [PATCH] scs: Fix a wrong parameter in __scs_magic
Message-Id: <20251011101117.0b48ecef0dc7cfdd1f871273@linux-foundation.org>
In-Reply-To: <20251011082222.12965-1-zhichi.lin@vivo.com>
References: <20251011082222.12965-1-zhichi.lin@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Oct 2025 16:22:22 +0800 Zhichi Lin <zhichi.lin@vivo.com> wrote:

> __scs_magic() needs a 'void *' variable, but a 'struct task_struct *'
> is given. 'task_scs(tsk)' is the starting address of the task's shadow
> call stack, and '__scs_magic(task_scs(tsk))' is the end address of the
> task's shadow call stack.
> Here should be '__scs_magic(task_scs(tsk))'.

What are the userspace-visible runtime effects of this bug?  Please
always describe this when fixing something.

> Fixes: 5bbaf9d1fcb9 ("scs: Add support for stack usage debugging")

This might need backporting into -stable kernels, that depends on the
answer to the above question.

> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -135,7 +135,7 @@ static void scs_check_usage(struct task_struct *tsk)
>  	if (!IS_ENABLED(CONFIG_DEBUG_STACK_USAGE))
>  		return;
>  
> -	for (p = task_scs(tsk); p < __scs_magic(tsk); ++p) {
> +	for (p = task_scs(tsk); p < __scs_magic(task_scs(tsk)); ++p) {
>  		if (!READ_ONCE_NOCHECK(*p))
>  			break;
>  		used += sizeof(*p);

Thanks, I'll grab the patch for now, maybe Will would prefer to take it?


Return-Path: <linux-kernel+bounces-724615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F62AFF4E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE9817B8B5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAAB2475CD;
	Wed,  9 Jul 2025 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bq4qg5VQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152D9238C25
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101097; cv=none; b=nh+zHgqwuUt30jNvbV0GtHrTQ/KcGZZZz/wqcWm23ARGUWUjHFsTwUAnbTremC7mfrJl+6rXVCWGmB5YcH5TbeDT/+MSAGsvv/FCLjqW99rDJu0FngHisxqxXINP91MDgmFVYNolcpsN1AWyoxpOhJM8IDGHeD/8AatGKGP+blo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101097; c=relaxed/simple;
	bh=c2dRUcKWJ1mY5i3urKzMQzGE3xGUFXMxmS1tPCGB3Co=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=K8q1O3sbluNCg23dy/EdeBbDt/bUFGTIotGhzELpRTcCKyqj8XxoKfBdhy5hDdFKCjuiiXswd0i+e2+TljBeYVgQOOI6P4upn1SL/LPFvOxOaJa6dl8dPbBKB7ymnedXLYQnSUxN/C6UEyikUIq/XQUGjJEitdsvOIO4GWWx2dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bq4qg5VQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E71FC4CEEF;
	Wed,  9 Jul 2025 22:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752101096;
	bh=c2dRUcKWJ1mY5i3urKzMQzGE3xGUFXMxmS1tPCGB3Co=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bq4qg5VQVCh5xgUMmCJCd5e3HeRPWKP10H+U8+2qMW/vA8MCygZl54TFHX2eaFXXt
	 Mweu9ZQEzYCCK9ucpeUdGcECo2Jcnfs8FNDhZQIdONMSC0pQXWuYPVkGLxj7nhuA6K
	 mlO2PZP4M3XTg8xKQtfSzkbRcNpQ7ZInwHpzYXmc=
Date: Wed, 9 Jul 2025 15:44:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Mateusz Guzik <mjguzik@gmail.com>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Jon Pan-Doh
 <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek
 <karolina.stolarek@oracle.com>
Subject: Re: [PATCH v6 2/3] lib: Make the ratelimit test more reliable
Message-Id: <20250709154454.fb140093fa88f4d63fa0d4c5@linux-foundation.org>
In-Reply-To: <20250709180335.1716384-2-paulmck@kernel.org>
References: <d1007957-97ff-4f6f-92ac-606f68c65dfa@paulmck-laptop>
	<20250709180335.1716384-2-paulmck@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Jul 2025 11:03:34 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:

> The selftest fails most of the times when running in qemu with
> a kernel configured with CONFIG_HZ = 250:
> 
> >  test_ratelimit_smoke: 1 callbacks suppressed
> >  # test_ratelimit_smoke: ASSERTION FAILED at lib/tests/test_ratelimit.c:28
> >                    Expected ___ratelimit(&testrl, "test_ratelimit_smoke") == (false), but
> >                        ___ratelimit(&testrl, "test_ratelimit_smoke") == 1 (0x1)
> >                        (false) == 0 (0x0)
> 
> Try to make the test slightly more reliable by calling the problematic
> ratelimit in the middle of the interval.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  lib/tests/test_ratelimit.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch 1 adds test_ratelimit.c and patch 2 fixes it.

Unconventional (and undesirable IMO).  Would the world end if I folded
2 into 1?


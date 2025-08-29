Return-Path: <linux-kernel+bounces-792538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0288DB3C559
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FE5A66AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986CE2C3278;
	Fri, 29 Aug 2025 22:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="oPuRIdLi"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7372BEC20;
	Fri, 29 Aug 2025 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507472; cv=none; b=iNG25Th0dBi6Og7iNIgv4dTrkhebkogXRVz1R810tHaubK0+eKYB7LXnoFihvNQstpD9b/S/q4ve3XKlsB/KFQjyqOJ7cbyYzHSd4MMDb1kvUuHaX+Pj2ZZ1zhuOipsD82GjRW8F7+SX45Eq0x591Zv5e6IEQzfp45xq4x+62RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507472; c=relaxed/simple;
	bh=3l9IyZ6E1ykYaE6ZiTn4FwDADVA8vWfN2yBfNykC3nA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hGWODK8e+rtP5RVS7r1oTfpoVV273mWRC2CbI17x2ZrJLFCLz5VbqUo1UfqN/SE/v4t4Bwae6jjKWAAHFpf5nOg172Y4i6x/DuHSZP+vDkeFyUTgCpciMYoXphbuQqjuAibwForXMo1ndwMCmZLQ03xpvem8go6uKLy33oS50wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=oPuRIdLi; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 612F540AF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756507469; bh=XuBKPwHuhKr0qdeRskPKNe3G/Yu1uyjI8KfA52i8W8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oPuRIdLiKHqAKRst3f8bstolu2fx6ZgL3itFUnndZVtPGkMR0TVXeQEGXceOgvAvA
	 RWl5dx/a/uTqboX8u2Zb/L3MrSh/wmfzVotE1GipHMUU0IRE7wUdFDOlAWlSqGDBlR
	 qHGksQs/QHZ4grepHQxOJVaL7YevdC/MR40Th3KNNCli7lgikngkQ/IaEy/8Xj8JL3
	 m71uOmqMI+eAnne33TQ4POGSZtS4ea54tSoJtsigKQmkPlGAUzdm5AGw+IZY/IuF2S
	 nylrgZ6TjXQyv+xKFTYnq5sofmG3eo2SEbWGuUvNMavrd4e1Yy8+B26dvu0T4E8piK
	 iatG5dCQTJh8A==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 612F540AF5;
	Fri, 29 Aug 2025 22:44:29 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrei Vagin
 <avagin@google.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH v2] docs: scheduler: completion: Document
 complete_on_current_cpu()
In-Reply-To: <20250824-complete_on_current_cpu_doc-v2-1-fd13debcb020@gmail.com>
References: <20250824-complete_on_current_cpu_doc-v2-1-fd13debcb020@gmail.com>
Date: Fri, 29 Aug 2025 16:44:28 -0600
Message-ID: <87a53h3fzn.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Javier Carrasco <javier.carrasco.cruz@gmail.com> writes:

> Commit 6f63904c8f3e ("sched: add a few helpers to wake up tasks on the
> current cpu") introduced this new function to the completion API that
> has not been documented yet.

For a change like this, it is a really good idea to copy the author of
the original patch and others who were involved in it; I have added them
now.

jon

> Document complete_on_current_cpu() explaining what it does and when its
> usage is justified.
>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>
> ---
> Changes in v2:
> - Rebase onto v6.17-rc1
> - Fix patch formatting (drop --- before the Signed-off-by tag).
> - Link to v1: https://lore.kernel.org/r/20250703-complete_on_current_cpu_doc-v1-1-262dc859b38a@gmail.com
> ---
>  Documentation/scheduler/completion.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/scheduler/completion.rst b/Documentation/scheduler/completion.rst
> index adf0c0a56d02..db9c131f0b62 100644
> --- a/Documentation/scheduler/completion.rst
> +++ b/Documentation/scheduler/completion.rst
> @@ -272,6 +272,10 @@ Signaling completion from IRQ context is fine as it will appropriately
>  lock with spin_lock_irqsave()/spin_unlock_irqrestore() and it will never
>  sleep.
>  
> +Use complete_on_current_cpu() to wake up the task on the current CPU.
> +It makes use of the WF_CURRENT_CPU flag to move the task to be woken up
> +to the current CPU, achieving faster context switches. To use this variant,
> +the context switch speed must be relevant and the optimization justified.
>  
>  try_wait_for_completion()/completion_done():
>  --------------------------------------------
>
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250702-complete_on_current_cpu_doc-94dfc72a39f8
>
> Best regards,
> --  
> Javier Carrasco <javier.carrasco.cruz@gmail.com>


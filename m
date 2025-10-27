Return-Path: <linux-kernel+bounces-872231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 404F1C0FA2D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDFBD427448
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15FB3161AD;
	Mon, 27 Oct 2025 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="o5qW9MNe"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5B027A47F;
	Mon, 27 Oct 2025 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586166; cv=none; b=jBSRt8ACHQ+JEliVRVxFUVlU4n+T6Ce/xBZZ+Th5tRhBz6vWXo8eed/T/8JGj1pu32SGlx+yA0yL/9qTeHNVYAUd34y3HMnkrYJ6M3DBaXnpnaYkjZSlGMSzG7dffQ3IUeFyfFX7Ntnp3bGUhWShBkadXB0ojVln54h7+LjfpFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586166; c=relaxed/simple;
	bh=Z3F2tXX7F1lgKoPBIWBCsPnF6hDHgsGN4SuNKkya+Mo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l2DHyt5rZq/phU9U/vpckfnlfPDByWOfyKXTy/mzH847F95bbql45uDqtPnduLLjQpRT9DvJP2h3EsHxH+bc4e72eAkBvVUvd8sY/pXVW8uwoqVpa9RcbOrtBFff8szEfMiREpBA85F51mS9Vrr19f/m1jbhD2UXu58D35X6mVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=o5qW9MNe; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3EB40406FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761586164; bh=8RY6ClshNXTTBsicD2sQDwXpiPjKY8koazVs/0WBu9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=o5qW9MNegmY0gvMnVBBsJJidLgwS17RXU4DiN/D0ussYnG/LNmlzqaNrAvVdDbRKm
	 Z9aSMHAuF1AM+jsuqMgCAKKfjfUFbLIPy3caLBtl4vBl+/YvD0AYNO0m6NYVYmLKfX
	 obCi/TYUkRhuuua48bKfdd5pc9hg9FT6oQ3kvfzsOg/xVOVWwF4lfflLbg+llGmGtV
	 w6teOkqiapaiY2xmwJqNVLABiE+HVXyNsHTF9QsabY92GgOBJz7+/nikV9/KKvcsml
	 /JxiYaztPqSwtRjeVS4PzixeCpw+pOOeQc57C0rx/6lGYfYlQPbrwvcLhjU+Tx7lH4
	 w4pUWvyvwJV/w==
Received: from localhost (c-73-14-55-248.hsd1.co.comcast.net [73.14.55.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3EB40406FB;
	Mon, 27 Oct 2025 17:29:24 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/30] docs: reporting-issues: add conclusion to the
 step-by-step guide
In-Reply-To: <9a8d7b58f482cf0669bc5028dd0e01301f7f526e.1761481839.git.linux@leemhuis.info>
References: <cover.1761481839.git.linux@leemhuis.info>
 <9a8d7b58f482cf0669bc5028dd0e01301f7f526e.1761481839.git.linux@leemhuis.info>
Date: Mon, 27 Oct 2025 11:29:23 -0600
Message-ID: <87ms5cntho.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Idea and text comes from
> Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/admin-guide/reporting-issues.rst | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
> index 90b50c27c0d2b6..9676ba85e1b73c 100644
> --- a/Documentation/admin-guide/reporting-issues.rst
> +++ b/Documentation/admin-guide/reporting-issues.rst
> @@ -241,6 +241,20 @@ kernels regularly rebased on those. If that is the case, follow these steps:
>  The reference section below explains each of these steps in more detail.
>  
>  
> +Conclusion of the step-by-step guide
> +------------------------------------
> +
> +Did you run into trouble following the step-by-step guide not cleared up by the
> +reference section below? Did you spot errors? Or do you have ideas on how to
> +improve the guide?
> +
> +If any of that applies, please take a moment and let the primary author of this
> +text, Thorsten Leemhuis <linux@leemhuis.info>, know by email while ideally CCing
> +the public Linux docs mailing list <linux-doc@vger.kernel.org>. Such feedback is
> +vital to improve this text further, which is in everybody's interest, as it will
> +enable more people to master the task described here.
> +

Consider also soliciting patches to improve it - one can always hope we
can bring in some help...

Thanks,

jon


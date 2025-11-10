Return-Path: <linux-kernel+bounces-894024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C946C491CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6964C3A798E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19FF337692;
	Mon, 10 Nov 2025 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="byD5weM7"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6725E274FD3;
	Mon, 10 Nov 2025 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762803575; cv=none; b=r5U57BI1Y0iuXxjKy3S66VF2bb2xk/sIvKJ4/Oc9sM9tDIdBCF+jqNZDmmJevwhSUywZ0ID0C7rfYk9D9hAl+58cJh4VkVIzOw7CW4zbY6LbELo6VBYDbPqNXl6x8erFuTUrcu95oXLJIkVMAjiMIC7XDl80/goDnNAgBZ6+sec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762803575; c=relaxed/simple;
	bh=CYeYsA8LfFg0531qhGsLHlGzEO/Vtz9Fx9DC7lJKP9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eoBjCU8LlagGAo0I4FOxTGklcn45Y2Nj7aUrKzF3QH3X730OkD+cmBGhjaTtmhS3Rnqst7g0VWX3GDxuNvIG41EcF3uLzmZMQpn4v9BLw4goNiFdo4ngNj6cW7fw1BLmI/RZGyZeQVzRrZsJ5sa2TMF+R1E3tk3YDi/Lawf7yZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=byD5weM7; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 747F640AFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762803572; bh=rt33jd4thzyTb9CvejG80y7ao9nKyUh71IctERpC37c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=byD5weM7r37srCYkYCXiqx73LrrNYDEGmxuKfc/3Q9gtrk6RgYaZrSdyKTz8Nnh59
	 /047A1QAqscAAPZARvKI9HIaKA6KgRbTT6d9fm4n8hIBDNyJ3DK4AdOFRPXc8nKtAu
	 ZNEnHPejMG6QLJDqLTZo2YY8PvuE7s36afWrJ+3N+gyjl2v7A+bq/ogds0qGfsf7Zo
	 oP4KNg+uL5narS7C23g+5CmXVd89BSKxGrK3rYWQIL/NDhuEZvu1kLxVAh4CznlNqj
	 ciiyMAUsTiPrINGhxIBe/nLzQ0t8LocY33quftYpBaPYvF0FtDY7GS3oRaLTnASq7L
	 jDhsh7871vmlQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 747F640AFB;
	Mon, 10 Nov 2025 19:39:32 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: pierwill <pierwill@protonmail.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>
Cc: "bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org"
 <peterz@infradead.org>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] docs: Fix missing word in spectre.rst
In-Reply-To: <Ru-d3ltJIyY4Oc6tzHwpSiDeFwSLHEzd7Utcr6iobgIy1B8wLRI4f6JiCb0a9n-0-r19d0dyLL3yS8KWVcyHfpkyDErWXYTkI3AJfUPTNCc=@protonmail.com>
References: <Ru-d3ltJIyY4Oc6tzHwpSiDeFwSLHEzd7Utcr6iobgIy1B8wLRI4f6JiCb0a9n-0-r19d0dyLL3yS8KWVcyHfpkyDErWXYTkI3AJfUPTNCc=@protonmail.com>
Date: Mon, 10 Nov 2025 12:39:31 -0700
Message-ID: <87qzu5y8wc.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

pierwill <pierwill@protonmail.com> writes:

> Corrects a missing word in the hardware vulnerability docs.
>
> Signed-off-by: Will Pierce <pierwill@protonmail.com>
> ---
>  Documentation/admin-guide/hw-vuln/spectre.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
> index 991f12adef8d..4bb8549bee82 100644
> --- a/Documentation/admin-guide/hw-vuln/spectre.rst
> +++ b/Documentation/admin-guide/hw-vuln/spectre.rst
> @@ -406,7 +406,7 @@ The possible values in this file are:
>
>    - Single threaded indirect branch prediction (STIBP) status for protection
>      between different hyper threads. This feature can be controlled through
> -    prctl per process, or through kernel command line options. This is x86
> +    prctl per process, or through kernel command line options. This is an x86

Applied, thanks.

jon


Return-Path: <linux-kernel+bounces-799460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05822B42C19
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1341C200DF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBA32E7F03;
	Wed,  3 Sep 2025 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kljDpybE"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF4239562;
	Wed,  3 Sep 2025 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935926; cv=none; b=OOAaDck1Z0xcfof5Ss5sjTiyGI8XRoIzf6TO0djCLJ9vAHohEZfBD/L0HVqX3KM4Q1WJpBTo1jOUJCd+mCkAHSd1G7FzUw4H0gf6psxBAIaddKJZ9d11Uv5iEG1QSiUVyr1f2kMhQVoRS/OL/Ozj4vnPvUGdvIgSYsSeipdbJE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935926; c=relaxed/simple;
	bh=aC3SpZnHZZsuPCx2+GCZ7/b01ROdd6FO5IexKysTdbI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sZ9vUAxE8EIBXTJ7uJBOKyfrqJ8/ZJDnnTNOED1zsQ1YcPsrphw4/XuVi4kynXdHLyuSb3udkUH+f5JcvFtiU2usflJGJTVpzD3ePJTUfXtvsfB2J6qEzIJGYadeSfFE52b0wQTAm+TKr72T68gqFhwv7cterEfBbP2LvQrPGww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kljDpybE; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DC4CD40AF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756935924; bh=vYUs9gtOzxglzD1m+rOkO0vuKqC3Wkwwf1OjkbX6UjY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kljDpybE12MZXzwKlDcpPqjpJRXmj5VGpHkMKPIy+pqKJ8DYmvD8mqkoe3AD+g5kP
	 HZgEcAmrOhxCVJbySAcURj1rJOwNK1Okn/kpEe+vKWxDb//6csO8WRTJ+46t2EVdys
	 k6L1UnD5pnJ7BVYkFasJSBvvIjJmtJW6iUkP8l5IYDx/f33GjjlqXhGL2v//fkVU+z
	 FzgfYps9YlaC/gyVsswhsA6D2/P6+2UJdO0gTgXxVzvZuHdj9svpHyQdU3LxxDlEpJ
	 UZluRf2T8pJVcI5FG9RSK9yHXnGBmlDwasSrKS3NM0Typ60rxDV9SXQeD0N9IegMVA
	 dQoVJpbU2d3PA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DC4CD40AF5;
	Wed,  3 Sep 2025 21:45:23 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, Rong Xu
 <xur@google.com>, Han Shen <shenhan@google.com>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v2] Documentation: dev-tools: Fix a typo in autofdo
 documentation
In-Reply-To: <20250831151118.1274826-1-harshit.m.mogalapalli@oracle.com>
References: <20250831151118.1274826-1-harshit.m.mogalapalli@oracle.com>
Date: Wed, 03 Sep 2025 15:45:23 -0600
Message-ID: <87seh3p5vw.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> writes:

> Use "cat /proc/cpuinfo" instead of "cat proc/cpuinfo".
>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
>  v1 -> v2: Fix a typo in commit message.
>
>  Documentation/dev-tools/autofdo.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/dev-tools/autofdo.rst b/Documentation/dev-tools/autofdo.rst
> index 1f0a451e9ccd..bcf06e7d6ffa 100644
> --- a/Documentation/dev-tools/autofdo.rst
> +++ b/Documentation/dev-tools/autofdo.rst
> @@ -131,11 +131,11 @@ Here is an example workflow for AutoFDO kernel:
>  
>       For Zen3::
>  
> -      $ cat proc/cpuinfo | grep " brs"
> +      $ cat /proc/cpuinfo | grep " brs"
>  
>       For Zen4::
>  
> -      $ cat proc/cpuinfo | grep amd_lbr_v2
> +      $ cat /proc/cpuinfo | grep amd_lbr_v2
>  
>       The following command generated the perf data file::

Applied, thanks.

jon


Return-Path: <linux-kernel+bounces-744501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801FDB10DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2F7AA803F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5919D292B57;
	Thu, 24 Jul 2025 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="CEmzFdEo"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB6A26E70E;
	Thu, 24 Jul 2025 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367548; cv=none; b=ixo9YIX0Cx+S9dG9UMpVhnxE+Z2gUR3drwMFOd4Jgz9tVr6K4fZmxNH6JjbpVrAKr9T4K1/b6smCUstXYF3iCKyvHvt94ubvY8YXfJFMFPrxsUaMPwTvln+WTPugKBYw7nZDtCTg7s3olan4hoEKhjUIPy7xqqZme8LThPGnlIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367548; c=relaxed/simple;
	bh=vq3529Gq1stJ5Qtx3t+N7u+0xtbCfHj+fQmkWLu8B5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cksZalZoUKQAohQ+4lYSPk4SVPQ7Jn0SroKcDZXD0tviiEalTDJRtwER53TrWWTxfixD0/Uu2LQ16NJgUWGqEcqI0N9ciJwnPPQ1DDNSgor5vjOkP0E7OJqW9VII13yf1fbQ9+oRRycOvRN7swFro/eMeG5ky1PZwbosHqNJP0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=CEmzFdEo; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 75EDB40AA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1753367546; bh=y4g4K3HUugCtJiNkQIV6PNh+UWelUKrKzJC68v8XopE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CEmzFdEoodHJXOcSdun8vUZ+0Lx3olAdFNLF030efYvE2SYL+J9JQnfh3dnPhQrQc
	 R58GDdpjFSPGPd212vrzApXDmRGDMSlR79OmCUzXkHIU9T3DYfk0sKhuSPl3Cmkvlv
	 TPDV+ZKNT3uS6iGIGISUfY2f6xJOEUg/WolQRwd85UqASsuBDTIjdXIAKSwJ5IBisV
	 m88rxdtoSkimNk7g4HCXsJDQj5D5Q2pxYZmxeWv2wAco2XBlJdwkzM+awYnZUen2o7
	 Chw7Or+yaWHdkUGn69TpTgkeD3qPNZqJlrgzx+th2bPgPZZkxBln6M0O+d25uMzVSr
	 3SL+m1Y0ibw3Q==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 75EDB40AA9;
	Thu, 24 Jul 2025 14:32:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Vignesh Raman <vignesh.raman@collabora.com>, linux-doc@vger.kernel.org
Cc: akinobu.mita@gmail.com, laura.nao@collabora.com,
 arnaud.ferraris@collabora.com, vignesh.raman@collabora.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] docs: fault-injection: drop reference to md-faulty
In-Reply-To: <20250723102835.232740-1-vignesh.raman@collabora.com>
References: <20250723102835.232740-1-vignesh.raman@collabora.com>
Date: Thu, 24 Jul 2025 08:32:25 -0600
Message-ID: <87ms8taccm.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vignesh Raman <vignesh.raman@collabora.com> writes:

> Commit 415c7451872b ("md: Remove deprecated CONFIG_MD_FAULTY") removed
> the md-faulty driver, so drop the outdated reference from the
> fault-injection documentation.
>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  Documentation/fault-injection/fault-injection.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
> index 1c14ba08fbfc..c2d3996b5b40 100644
> --- a/Documentation/fault-injection/fault-injection.rst
> +++ b/Documentation/fault-injection/fault-injection.rst
> @@ -2,7 +2,7 @@
>  Fault injection capabilities infrastructure
>  ===========================================
>  
> -See also drivers/md/md-faulty.c and "every_nth" module option for scsi_debug.
> +See also "every_nth" module option for scsi_debug.
>  

Applied, thanks.

jon


Return-Path: <linux-kernel+bounces-823290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7732BB860EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A09018916A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7298A313D4E;
	Thu, 18 Sep 2025 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="N6yC5m6F"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF8E30EF86;
	Thu, 18 Sep 2025 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213254; cv=none; b=rkxlsp45zfmtMtvdajgOlxIrat7FfYqHPaCUjsRoYaw736DrIgdh+8WLrGPe93eZZ5QSwuZ4tXHgXuAalRnrudKf39/kpBp2WtBYvqoXql2OnSRSTRHotn19IC5s6aqZPCuYS4Wl0+bphfgA0jBTPPVSIDmadwPceolrKb6m9yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213254; c=relaxed/simple;
	bh=aqwtNK6di5GBXsobB4WCO7ec6zovjJK0WwMrHWilHOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h1kXvL7b4Jh6v86w+DWUTx2xYlyuOhU+XXgbMPBWSzT2+rJ/1ulRlUriyL7FoCfNWmWyNiiOewML5jOrn2LWHwUxsR+psr22fMhTpLDi90E8jf11x8Maw8qaV0YMJlStqpBWJd3rAfvM0+dRKc5Xrph012V3OebIZJOBwraTVPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=N6yC5m6F; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0B9B9406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758213252; bh=QiJQcaqGnpfxXUttN20FBH0tpTUHOeBQntDMRqt269o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=N6yC5m6FqGKcjEW11nfg02qV8Yye79eP9IihS2+8h4f6RbVGwNyWTq1okPe9nDzwN
	 22PXU/VvThVcrDOzuZQJ2jPiHK++Ed+TBmFm0xmQ/HZtSWQl5CJQIvVNpYYQEcdbVn
	 BLfGPI/ISrUqjA+qSrtlSJ4VCl/ltL238TeQsJCMsMtvte56GVV902R33AuFnlLCn9
	 UW89JMfV1G3v3OrcbT4uX6MjAOaP5pHDGJeSmxad26OToQeabY0OUHMQ3LRSUvziY6
	 K73s+fXQc2pX5w1N2rgEMgYs5pEe7XMcvEaV4ObtrHh6//R1wcLSwBaZGveEbSrpLn
	 w4As8uDxpnLZg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0B9B9406FA;
	Thu, 18 Sep 2025 16:34:11 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Alex Tran <alex.t.tran@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Tran
 <alex.t.tran@gmail.com>
Subject: Re: [PATCH v1 1/3] docs: filesystems: sysfs: remove top level sysfs
 net directory
In-Reply-To: <20250902023039.1351270-3-alex.t.tran@gmail.com>
References: <20250902023039.1351270-1-alex.t.tran@gmail.com>
 <20250902023039.1351270-3-alex.t.tran@gmail.com>
Date: Thu, 18 Sep 2025 10:34:11 -0600
Message-ID: <87a52r90u4.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alex Tran <alex.t.tran@gmail.com> writes:

> The net/ directory is not present as a top level sysfs directory
> in standard Linux systems. Network interfaces can be accessible
> via /sys/class/net instead.
>
> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
> ---
>  Documentation/filesystems/sysfs.rst | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
> index c32993bc83c7..c50da87f27fa 100644
> --- a/Documentation/filesystems/sysfs.rst
> +++ b/Documentation/filesystems/sysfs.rst
> @@ -299,7 +299,6 @@ The top level sysfs directory looks like::
>      hypervisor/
>      kernel/
>      module/
> -    net/
>      power/

I have applied these three, thanks.

jon


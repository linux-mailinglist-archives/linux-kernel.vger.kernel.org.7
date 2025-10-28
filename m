Return-Path: <linux-kernel+bounces-874783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81537C1714E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 416A54FA237
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2822DE6FE;
	Tue, 28 Oct 2025 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="TXOlgmar"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3021279DA6;
	Tue, 28 Oct 2025 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687663; cv=none; b=Mo2cDGMZgzNop9SuOWVf9uTuCo2EjjC1JF2+gRbi4drx6DwLvdpIp0coNCPoGBhrPYi2tz7Y2llI+lLejj7oCkc6XHcaJZCNwmeb1jF5L3LBBBvSjvOCfxCvYt7PuiFtbD12Wkk5tSp5yTSfb92oGRqrvKC69vPIq05pT0Q1QXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687663; c=relaxed/simple;
	bh=xXSLKgDo6ldzm4wbjPgPhCxJrRMif8tXd/+nJSSeCOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jLoOlQ/vHZ/koa3YyT4Yt7fRJ199Hw57eF6dwHkJCyJKFNLEdzbv317kV+1aDv1yQa9570Z97kXDzKx2qGzGOB/NuwD3zAyWykxwooLSe3PqRgigZPmus5VNshL5MS6l6vOwY2i3PMw6g2v7vs59qXqRaoFkZRFUErzhOU5d+kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=TXOlgmar; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C3E84406FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761687660; bh=BevylZwLamewTZQXEZJC/91SjpStaK8994lEiMflxHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TXOlgmarU1ECukgEbUyzpjX8B63ZLu4BTnu6AKcPmWfYMlhg/ev4eMbIANThMyEOe
	 H/oreH4j9MZ6ouJryVUuAhx+cDUvpiqbolEL1NKIhr0f/jHrv6vfm2ZWcHJXjeIj/N
	 ynxp9DDse+l0CKN5vYyzCxA5RkGwhJSvwGjDzjAeuLr5c++TRmOogSp+Bf6rUHfyX9
	 faY/hmvgi2gvXINb4VA8F/eVhVczWGS9nis7vZnDurJsg9CEN1AcjAp61BAABAZ2+U
	 MqySlNMpoKadFHYSAJLFuV6G6+MpFYBn/FUCjl8vFnA6k71Rz6GegEzUPk02vdn5DS
	 H6D+BQCJJKpEg==
Received: from localhost (c-73-14-55-248.hsd1.co.comcast.net [73.14.55.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C3E84406FB;
	Tue, 28 Oct 2025 21:41:00 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/30] docs: reporting-issues: explain need for fresh
 vanilla kernel
In-Reply-To: <616e01c3b2212e3dc7c7cc40f551618092f40c62.1761481839.git.linux@leemhuis.info>
References: <cover.1761481839.git.linux@leemhuis.info>
 <616e01c3b2212e3dc7c7cc40f551618092f40c62.1761481839.git.linux@leemhuis.info>
Date: Tue, 28 Oct 2025 15:40:59 -0600
Message-ID: <87ms5ak8lw.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Rewrite the section that explains why a fresh kernel is needed and why
> bug reporters might have to compile one themselves for testing and
> debugging purposes.
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  .../admin-guide/reporting-issues.rst          | 141 +++++++++++-------
>  1 file changed, 85 insertions(+), 56 deletions(-)
>
> diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
> index 7dfb3ca4b3e322..2f387e8766f21d 100644
> --- a/Documentation/admin-guide/reporting-issues.rst
> +++ b/Documentation/admin-guide/reporting-issues.rst
> @@ -49,11 +49,25 @@ Step-by-step guide on reporting Linux kernel issues
>  Note: Only the steps starting with '*you must*' are strictly required -- but
>  following the others is usually in your own interest.
>  
> - * Are you facing an issue with a Linux kernel a hardware or software vendor
> -   provided? Then in almost all cases you are better off to stop reading this
> -   document and reporting the issue to your vendor instead, unless you are
> -   willing to install the latest Linux version yourself. Be aware the latter
> -   will often be needed anyway to hunt down and fix issues.
> +.. _intro_repisbs:
> +
> +* Be aware:
> +
> +  * You should report issues using a Linux kernel that is both really fresh and
> +    vanilla. That often means that you will have to remove software that
> +    requires externally developed kernel modules and install the newest upstream
> +    Linux development kernel yourself.
> +
> +  * There is a decent chance you will have to report the problem by email, in
> +    which case your email address will become part of public archives.
> +
> +  * You might need to patch and build your own kernel to help developers debug
> +    and fix the bug.
> +
> + If these three aspects sound too demanding, consider reporting the issue to
> + your Linux distributor or hardware manufacturer instead.

So nothing to object to here, but this does make me wonder who the
audience is for this document?  It seems that you are aiming at people
who do not run upstream kernels, but who want to work with upstream to
get bugs fixed...?  That seems worth saying explicitly if so.  How big
of a group is this?

Thanks,

jon


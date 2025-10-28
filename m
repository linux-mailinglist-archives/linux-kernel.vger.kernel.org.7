Return-Path: <linux-kernel+bounces-874786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B67C1715A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7203B6E00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC5C2E0418;
	Tue, 28 Oct 2025 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kvqpHTc0"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6110D2DF710;
	Tue, 28 Oct 2025 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687733; cv=none; b=K0on1EVf5EC89xsagqsUUPoFgymV/2HecBmDKlYH3V62/laOoY49QgrClIbCcMFk08yH2vrbDQeeS4YucXOhQ41B6/BzyZ9mvay1car474bmYCX9Scw9yBfMClnOsFiL+mJAVx68yvzEeBkO/3G0IvmwYc6kULFTwsjGVlYee2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687733; c=relaxed/simple;
	bh=dWpzhXOQ1kERRdVnsqMKXMdU0XPZ0Yb8LEvk7z6zQZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XpGRr/dgBMvEwLbZUQkX7OD+3aiPDHF1CyYgHuLA8CNomDbnnD0TUo/P1OKD7z4JBgbiorhoqaOc/RqvygQ7/+nwitPTOgQ+xpLrL6ybYfivwRmayjSl5dnKLyx2Pp/Xj4uaYOpi1j06NYrrem4pCBo+tzpp8kBCP/6z3Ry3gao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kvqpHTc0; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AE440406FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761687731; bh=UJ3JQGKcayUOd6J2m/S6BNNlcej2RL9ZDNYPO/Xgj1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kvqpHTc0nTwmBN7nFKfGIMLvbkuXeROjcMGWVGzpr2/3a1uizUAd9cWj76gI+fa7e
	 lXdXJeY8FxS+6hwZOVXOd22EcQEeoWzfyUNnTmdKzG9V89qDMFxGF667eG1Zomu7wC
	 Sxu67nhhcXIrXycanQaGn6I6RZtRsT3d7dAwFmG9DdYDkr0+7JjSDHtBdCBD2Ge1Ki
	 Yt2EIr9fwiUaVy+/PBxmsBshO4RqG8Eb6CIVDSg7Gu6DpBU8tjeX6u+10tg1ygfKQr
	 rtl8auJCI+r3UBFP6z8qg1tJcDSzYL6v3HauQtCyruo6FY6Z1FGszNYeM26HqmLeqq
	 eHrScgyOC3IGA==
Received: from localhost (c-73-14-55-248.hsd1.co.comcast.net [73.14.55.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AE440406FB;
	Tue, 28 Oct 2025 21:42:11 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 08/30] docs: reporting-issues: add step about
 processing issues separately
In-Reply-To: <9b6e279c9d11eefe7ff01672a054783dbf651bc0.1761481839.git.linux@leemhuis.info>
References: <cover.1761481839.git.linux@leemhuis.info>
 <9b6e279c9d11eefe7ff01672a054783dbf651bc0.1761481839.git.linux@leemhuis.info>
Date: Tue, 28 Oct 2025 15:42:10 -0600
Message-ID: <87ikfyk8jx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Create a separate step covering 'process and report each separately if you
> deal with multiple issues at the same time'.
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  .../admin-guide/reporting-issues.rst          | 45 ++++++++++++-------
>  1 file changed, 28 insertions(+), 17 deletions(-)

Seems fine.

Thanks,

jon


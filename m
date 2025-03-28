Return-Path: <linux-kernel+bounces-579799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A2DA74998
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 13:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C458189BE8D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 12:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BD021ADCB;
	Fri, 28 Mar 2025 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihWfLiOD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F99A7FBA1;
	Fri, 28 Mar 2025 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743163363; cv=none; b=MZsmf4qiNQ50KaIAUghNlbMMouSz3CsPYBpypbsyqJOVeavQzGWWA0CdPfjyKjZSKEYl/meIwpdA456sREq15kC74e8RScb4zDMTWdVYmzndQmnuGQrGJfXJQJB6gV7fyrADJuavqAGdzRFMc4ZcYAflK/ssFVlUgtAq5HykGYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743163363; c=relaxed/simple;
	bh=WkHvnjBZwMyqtk7FXbtB96R3wlh+AovO1iGTnu0Xn54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5TDFV1HLKFJckc/UsHcCQUrLvIf+Tjs6m1Eq1kUA49u0MFGnrAEZoBu0YK6pBlWYLKXf3wi+IL3IXj5mRQDEWe76lGDfJZIQAP1aMt0/wfva6lb8bHd0SALNhE3DI4ivCS1bdKbtOXoWsq8FKetxpT7SHnFLBcbptb7ZUp9ktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihWfLiOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8885C4CEE4;
	Fri, 28 Mar 2025 12:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743163363;
	bh=WkHvnjBZwMyqtk7FXbtB96R3wlh+AovO1iGTnu0Xn54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ihWfLiODMIlMOtRhLL3ZOqhHgajKSA1d2+sstpiOjTj3iDOlweddEHxks699tGHeK
	 OYSuvGhcTshlax/61AdS3CJxKFvJ27PoKJ68Zrh7DV8oGqrCdjvQD1oKmGJ/hakcbf
	 G7criCbjRu5fHrLJF2ROiZJBACv+47P0xICKyMAKwUQkoJf61cZ2FBhQDfXyDoUKmn
	 5i248cobsB1BwqrQrP8zxUvm9A8LA2juJ005cWkOOqiR+n3dPUO0A48P5YKIsnXalQ
	 Subh2xIRrIICPjkMrbFsEdwJIRjhwiM7VPQ8AePe09xMxIlFMVMRIADSEugGrpC3IK
	 QvVGSXN0ifJdQ==
Date: Fri, 28 Mar 2025 05:02:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Debin Zhu
 <mowenroot@163.com>, Bitao Ouyang <1985755126@qq.com>
Subject: Re: [PATCH] netlabel: Fix NULL pointer exception caused by CALIPSO
 on IPv4 sockets
Message-ID: <20250328050242.7bec73be@kernel.org>
In-Reply-To: <CAHC9VhRUq0yjGLhGf=GstDb8h5uC_Hh8W9zXkJRMXAgbNXQTZA@mail.gmail.com>
References: <20250326074355.24016-1-mowenroot@163.com>
	<CAHC9VhRUq0yjGLhGf=GstDb8h5uC_Hh8W9zXkJRMXAgbNXQTZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Mar 2025 15:38:25 -0400 Paul Moore wrote:
> For all three function, I'd probably add a single blank line between
> the local variable declarations and the code below for the sake of
> readability.  I'd probably also drop the comment as the code seems
> reasonably obvious (inet6_sk() can return NULL, we can't do anything
> with a NULL ptr so bail), but neither are reasons for not applying
> this patch, if anything they can be fixed up during the merge assuming
> the patch author agrees.
> 
> Anyway, this looks good to me, Jakub and/or other netdev folks, we
> should get this marked for stable and sent up to Linus, do you want to
> do that or should I?

Thanks for the CC! Feel free to take it to Linus if you're happy with
it. We don't have the posting on the list so it'd be minor pain to apply.

As you say the safety check is probably okay, tho, it's unclear from 
the commit message and comment how we get here with a v4 socket or
perhaps not a fullsock..


Return-Path: <linux-kernel+bounces-759077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C045AB1D824
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8FE18C6B90
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3443B25392A;
	Thu,  7 Aug 2025 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDQhDgSX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3BB1922C0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570556; cv=none; b=YmdHcC6xe+P4YNkh3u6c4W7AKhtPQCmBcfCY1blXwunD7z1PmRwkBBOh2qVMuAbCnnYQpeMZI09baghPic9F6N0DquYJqsWGLMB5BMrtQDiFbRr88FHGAZMEh5glneQt7311NyKxB2cfBaS2fO41WCG5bC/xrcgNGgm1bJaaun0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570556; c=relaxed/simple;
	bh=mm+ckMKaUNBCHWJjTNLnRTkIpATYJ1MOh5NvG+9Troc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhO309jMqSyeXyLed4kmDRzEcDyLbAdg2QdDobOB+YpTVE/gH4PGvnyP4CBYZUj6L2gN+cNUQgtx4gxdd4P8mXFquYg4X0JX8iQZ7aaq4zTjZD7x/yyygWqQVaKpIjhnndTN5eYMdZilmFf/gAh7xHTv9tgoGZoicoeuh72/1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDQhDgSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DB3C4CEEB;
	Thu,  7 Aug 2025 12:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754570556;
	bh=mm+ckMKaUNBCHWJjTNLnRTkIpATYJ1MOh5NvG+9Troc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KDQhDgSX8xUSILHFM70+/pzosDam28JaDJt3ui32V2/YorOnUImZFt4eECjzia4Oo
	 161DP4Va9z5eWk54JwqxXN2cZfkXDUd2nJws/Krv6SKzf/28R3wn5FO/D5RaD/AMml
	 OsVQ8TlX1x9TKc7EAzZsaa0sMlM+4kQfezKlAKzDbmRBVBK7tO9ka1ZaoNzI2xodF9
	 70g+CdgjGT5mzLKlLlRWAmso16IR3j/XdmTlj8hOuEUzBG/i+CLOK7EbhL95qaHY0m
	 6qqarb96V+qCENWNVyJWFBBLn7Ya0HFrMSYA4c4sGqHyu948qIK7W61HatDohNosDG
	 AJmtuEbE0jzTQ==
Date: Thu, 7 Aug 2025 14:42:33 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v10 1/8] timers/migration: Postpone online/offline
 callbacks registration to late initcall
Message-ID: <aJSfOf5e4BhAmj2g@localhost.localdomain>
References: <20250806093855.86469-1-gmonaco@redhat.com>
 <20250806093855.86469-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250806093855.86469-2-gmonaco@redhat.com>

Le Wed, Aug 06, 2025 at 11:38:48AM +0200, Gabriele Monaco a écrit :
> From: Frederic Weisbecker <frederic@kernel.org>
> 
> During the early boot process, the default clocksource used for
> timekeeping is the jiffies. Better clocksources can only be selected
> once clocksource_done_booting() is called as an fs initcall.
> 
> NOHZ can only be enabled after that stage, making global timer migration
> irrelevant up to that point.
> 
> Therefore, don't bother with trashing the cache within that tree from
> the SMP bootup until NOHZ even matters.

I think I made a mistake with this sentence. Actually the timers are not
propagated to the tree before nohz is enabled. So the sentence should
actually be:

"The tree remains inactive before NOHZ is enabled anyway. Therefore it
makes sense to enable each CPUs to the tree only once that is setup."

Thanks.
-- 
Frederic Weisbecker
SUSE Labs


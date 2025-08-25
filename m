Return-Path: <linux-kernel+bounces-784863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28849B342B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3D75E64BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3322F21D3C9;
	Mon, 25 Aug 2025 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qu2JZMbo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0C68635B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130269; cv=none; b=lbYlfES2cSX2PY9kY0cn9gaAJ078hsgGcmExg3G07bpKrJ31DTJnR5ISYjfIeu3CMhuzZJT6XRYLyf1P1cryEHBHiP8xGEGq/y6bMutnOFByOgsCtrmM+CvLvURHVJJ5+kI5lF8wUqIJ69ShN3hdJ3AVWidwGseuhG+HIEGZgr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130269; c=relaxed/simple;
	bh=nm0ZMju9JBswHUbOFAGDanjLV3zqxh0USdKnMVubIq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7S5ovr8gdBVMHGzZ5reUuD4hlz5Mrn8aGtV1joVzF5fK7c/qJZ+fCLH34ynX3O+pGRdrdwXcDiwQ/6VgA5svTZnGHby8pAuGlm0iHr7Jj9ZCPijpIAlZMH5aaF3uA2d/zhdm0B2WV1P5kWUhFTz/d/w+Lp0dXuPe1LdV/f1a1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qu2JZMbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3343DC4CEF4;
	Mon, 25 Aug 2025 13:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756130268;
	bh=nm0ZMju9JBswHUbOFAGDanjLV3zqxh0USdKnMVubIq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qu2JZMboZJNSu7apw0n7P/MN8YQueRtx6lLmsiLrVIMMeYhGTeV0UTxFq8azx+4nH
	 5tLlKHRXOUwYe92PPuzeoXItL+tz6ihxx81WsdOPtD47eAn2CXLwaG2LHhpECDnuZ7
	 wuzadlPMrXQZVNy3/zTahzR0F3AULtbzshcuRlSJnZJkw/xgot9qE5mkqATe3sswJT
	 s72x+gnslgcJffBCEDXE6zmdeyi5GJMwZOAEYvyTeTDP0HevGNN4ncxzT/pqgH+6MX
	 vJ8z/Ix7hVpj6UgrufvXf781XaQnbw3m3OGCvf0Ym7A68swNomsogDgNbA0FdwMkFS
	 Uk5e9pxcQfEUg==
Date: Mon, 25 Aug 2025 15:57:45 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 4/4] [Doc] Workqueue: WQ_UNBOUND doc upgraded
Message-ID: <aKxr2QH-4Vi8jHTU@localhost.localdomain>
References: <20250825132906.1050437-1-marco.crivellari@suse.com>
 <20250825132906.1050437-5-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250825132906.1050437-5-marco.crivellari@suse.com>

Le Mon, Aug 25, 2025 at 03:29:06PM +0200, Marco Crivellari a écrit :
> Doc upgraded to mention future removal of WQ_UNBOUND.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  Documentation/core-api/workqueue.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
> index 165ca73e8351..c8ece1c38808 100644
> --- a/Documentation/core-api/workqueue.rst
> +++ b/Documentation/core-api/workqueue.rst
> @@ -206,6 +206,10 @@ resources, scheduled and executed.
>    * Long running CPU intensive workloads which can be better
>      managed by the system scheduler.
>  
> +  **Note:** This flag will be removed in the future and all the work
> +  items that don't need to be bound to a specific CPU, should not
> +  use this flag.
> +

I would introduce that later, once WQ_PERCPU is correctly added everywhere and
we can assume that no flag means unbound.

Thanks.

>  ``WQ_FREEZABLE``
>    A freezable wq participates in the freeze phase of the system
>    suspend operations.  Work items on the wq are drained and no
> -- 
> 2.50.1
> 

-- 
Frederic Weisbecker
SUSE Labs


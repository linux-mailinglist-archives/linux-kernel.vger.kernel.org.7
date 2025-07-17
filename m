Return-Path: <linux-kernel+bounces-736076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DE5B09835
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 01:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6321C41D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6191FCFF8;
	Thu, 17 Jul 2025 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZoO+0MH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6442F24633C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795548; cv=none; b=cS9Uckxrue0jRHQ8smKNNUCVpsiafnSYCFdZCN8inh96J1/p8oWRhGPs1mmBBkKs2c3JKY/m6ArpO057WKR9CDqh+SzoLBbdY8GKlNlu8vEAIvwlaOJLAJhqhmXWkt0UmIaVR2i85rCYcx09oeJBKhTVLUd9BsXcalDCFlCgWpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795548; c=relaxed/simple;
	bh=8TvIjZPRdTbYSa/IuclmkB9bUWFNrBRtQ6IPCwzrKxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZMv8iADeiGbcT7Bnz+s3DRLYJ7cLlzQ14TYbIUuwENpqjvQfJLnJg6SCdZOT7uibH5rsbApy9BJ6aAl+a5+Xl0KPvV1uHF/+lX/SZivChh1O6fBoCGyhIC49coBUDnui5uEHndFywn4y8uScg/8WgHGAYpG9rIz4SR3Vei8Q6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZoO+0MH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4A5C4CEF0;
	Thu, 17 Jul 2025 23:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795548;
	bh=8TvIjZPRdTbYSa/IuclmkB9bUWFNrBRtQ6IPCwzrKxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZoO+0MHSyzuybiI+m3bJVKVnvB+87x6ekuvb2zB5M7/r+ClbI5n0oAzVkeMURxVH
	 9mg1vGN2fmFw/dvjjUFw6Z/QV2xdQ2vOD85rexKL+tgMNTBUYbtG+g3gtO/4EcAcS/
	 DZnmhspcJelLILRG3q4fFVnT/4LL6EZhWfDPtOX7ZMw4KYl95M0u0yL94B8VWDTztL
	 VfSYOKMLGIvrojC373V3yBo2bUxr16LO/rfANM3hw1cFrauNVwgopVxPzmk9rNwHuQ
	 cP8rRfi/jPRa/urIldmcRye7GfbarU3GrhRNIAC4dPPKfPWDb8l0N3k0pdnjH5FAky
	 EeaH2Bz+KsRoQ==
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dishank Jogi <dishank.jogi@siqol.com>
Cc: Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] "fork: reorder function qualifiers for copy_clone_args_from_user"
Date: Thu, 17 Jul 2025 16:38:48 -0700
Message-Id: <175279552624.2985786.13005987343271608496.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716093525.449994-1-dishank.jogi@siqol.com>
References: <20250716093525.449994-1-dishank.jogi@siqol.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 16 Jul 2025 15:05:25 +0530, Dishank Jogi wrote:
> Change the order of function qualifiers from 'noinline static' to 'static noinline'
> in copy_clone_args_from_user for consistency with kernel coding style.
> 
> This is a non-functional change intended to improve readability and maintain
> consistent ordering of qualifiers across the codebase.
> 
> 
> [...]

I've tweaked the commit log and Subject and applied to for-next/execve, thanks!

[1/1] fork: reorder function qualifiers for copy_clone_args_from_user
      https://git.kernel.org/kees/c/7f71195c15dc

Take care,

-- 
Kees Cook



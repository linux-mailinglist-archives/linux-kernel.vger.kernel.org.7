Return-Path: <linux-kernel+bounces-810703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1583DB51E24
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1501B18933BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23C9279792;
	Wed, 10 Sep 2025 16:46:59 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E52433A0;
	Wed, 10 Sep 2025 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522819; cv=none; b=XfS6SHkLSD7Dc3enTaFQYuSxd7mCvoTLAWsbaF1W+KKQv+vll9ZTf+AGpU63151O4DpUx8yiNFx8Bzg9DYJJ1Vz4ksbtHpmwRLzC5LFRYYuedqzWmQnX5sctlK/w/7Wl17PsORA9+WV3L0qLbPRiteJn0fUa8KqCHNAAdWChJVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522819; c=relaxed/simple;
	bh=3UE4uHR6aO+OFaypXOwwNEdnfkfmlNq6uFNa5BjW4uI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9zepmheKeCkIHGh6LILkp1o1kmA5aBzodA2PCidkomojDNUv3LQmKP5JCckwYMi7YEMnASCK3v2ox8fA8fvzic8Wj+v/JF1Dy2fOUrQ4C+Di8rrA1lmcpy7rlfmxVTqi7CF0P3W91fSOmOj4qUgWZ5WebbTL7jKkYAdJvN6mY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 5C5F61179B7;
	Wed, 10 Sep 2025 16:46:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id F405F20024;
	Wed, 10 Sep 2025 16:46:51 +0000 (UTC)
Date: Wed, 10 Sep 2025 12:47:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 jstultz@google.com, qperret@google.com, will@kernel.org,
 aneesh.kumar@kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 15/24] KVM: arm64: Support unaligned fixmap in the
 pKVM hyp
Message-ID: <20250910124742.34185645@gandalf.local.home>
In-Reply-To: <20250821081412.1008261-16-vdonnefort@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
	<20250821081412.1008261-16-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: q9cbx38hryj33o5fwyipu7ui3mmw96do
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: F405F20024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19JP+3dHgVZ3OldSVYgQj0MefUC8Z85EjM=
X-HE-Tag: 1757522811-725488
X-HE-Meta: U2FsdGVkX18yi2o/B62gDqm8AYG/9T+wf5t8LxVLQsiafH2QQ0ZSJcX1Vb7j7AiT4OouF7YoGLFO2B2fGds+ZHAWLiDNewTEYVHdqKFpaeyLhLEv9JLayHPnToecZQWsjUPlDVCbcqL3bL4AeMUcrCTQb4kM6TyxEqIA+jRCS/V3seDhQUEPG0w8Fa/+uWh0Uou/l/T1IRlDdcVFx6Kb7kaJ1gtG2oReVEQomDU1nXZWBWMF5eFh4PUamQfSfxJPHT0Q2JNTiLTuW7BnjLlcz0p2nXNAoVRZjazY3QOnAkakhg8Unj47qVdWCCseW1W1wQstnQ5n7CfASD/U738xhId8P4KuziyF


Would be nice if the arm KVM folks could review the second part of this
patch series.

Vincent, I finished my review, and you can post a new version. But it would
still be good to get some input from the architecture folks.

-- Steve


On Thu, 21 Aug 2025 09:14:03 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> Return the fixmap VA with the page offset, instead of the page base
> address. This allows to use hyp_fixmap_map() seamlessly regardless of
> the address alignment.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
> index ae8391baebc3..75014dc7d82e 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mm.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mm.c
> @@ -239,7 +239,7 @@ static void *fixmap_map_slot(struct hyp_fixmap_slot *slot, phys_addr_t phys)
>  	WRITE_ONCE(*ptep, pte);
>  	dsb(ishst);
>  
> -	return (void *)slot->addr;
> +	return (void *)slot->addr + offset_in_page(phys);
>  }
>  
>  void *hyp_fixmap_map(phys_addr_t phys)



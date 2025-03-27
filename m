Return-Path: <linux-kernel+bounces-578084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4692A72A85
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 08:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A77818935F1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 07:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A2D1F418A;
	Thu, 27 Mar 2025 07:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFPMiyMf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F91F417F;
	Thu, 27 Mar 2025 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743060273; cv=none; b=X2dBf+ouUW5IpZJtPF6mcTGrj+MDlOWoI80nAvWs+rL01pN9rAbIfSZUiCUzEhWmwkwhfAMi1By/DMf8LPX/4fxKtmAmVXAvwtOX9IUyXgA51ZlYQWlb4hPxGgQ17OWWYwluqPsR5YM89nbNsnFfeHKgGBP73YW/LtM5samyWlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743060273; c=relaxed/simple;
	bh=5mrwyUBbs/sowRee6ww7D8l8zGKZjFYwwpbZCZuTpyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKQMEHcnhJ3aV7f67336621Eu+FFjiU2hvwCe0JqEU0Vbb5bm1kn6CugB6MVBKPUFrix0xBKH7wudAs1ZWttmuGq9ifqjI/iLBEFSBjJdsygD9a/36RjV6uA720gu+ZI2T1+DGvQ4/2CJVIb35SggHfKSKkW6iBL2mDAWAdryE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFPMiyMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82CAC4CEDD;
	Thu, 27 Mar 2025 07:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743060272;
	bh=5mrwyUBbs/sowRee6ww7D8l8zGKZjFYwwpbZCZuTpyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFPMiyMfUlF2cyye8jxucDWiIAR05b92rsW7clbWkzitfcClfE0VrjRC4PK8sO8Tx
	 AcHIORFD0ieHPtvUOTXnTg23a+wlVrzJC0E7tNQa8Ebx2JwbiZWUj8kFNAMUzHyjK7
	 Lfv5nCGL+Y/jDPKv6nLuYo0nRxP2upNojGSVjUPPDqe9qY4k2Y89EBZcp9ROV58AMF
	 uLbEOKXH6zCcIh0aTo9AOGN5bgQe4OjOTeSBEs7EEshdULmVEuIkG6UueyW5B3xlpB
	 XTV5cIO71M69VMOtWHcFJ81f1CwBMb2d9FrSREhdCcpQ4BVe1JkZq8O4xsM/qEI2ib
	 ShqIlh4acZeSQ==
Date: Thu, 27 Mar 2025 08:24:27 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] locking: lockdep: Decrease nr_unused_locks if lock
 unused in zap_class()
Message-ID: <Z-T9K80wB4xw99jR@gmail.com>
References: <20250326180831.510348-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326180831.510348-1-boqun.feng@gmail.com>


* Boqun Feng <boqun.feng@gmail.com> wrote:

> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index b15757e63626..686546d52337 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -6264,6 +6264,9 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
>  		hlist_del_rcu(&class->hash_entry);
>  		WRITE_ONCE(class->key, NULL);
>  		WRITE_ONCE(class->name, NULL);
> +		/* class allocated but not used, -1 in nr_unused_locks */
> +		if (class->usage_mask == 0)
> +			debug_atomic_dec(nr_unused_locks);

Nit: capitalization in comments should follow the style of the 
surrounding code - ie. I did the change below.

Thanks,

	Ingo

======================>
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 686546d52337..58d78a33ac65 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6264,7 +6264,7 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 		hlist_del_rcu(&class->hash_entry);
 		WRITE_ONCE(class->key, NULL);
 		WRITE_ONCE(class->name, NULL);
-		/* class allocated but not used, -1 in nr_unused_locks */
+		/* Class allocated but not used, -1 in nr_unused_locks */
 		if (class->usage_mask == 0)
 			debug_atomic_dec(nr_unused_locks);
 		nr_lock_classes--;


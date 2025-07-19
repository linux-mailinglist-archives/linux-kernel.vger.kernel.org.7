Return-Path: <linux-kernel+bounces-737925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 654D6B0B1F8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 23:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C36AA4A48
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 21:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA9D2264AE;
	Sat, 19 Jul 2025 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nnb8oH/2"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4EA9476
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752961228; cv=none; b=sFZPIpb2yNBPG1EJOPGufWp9zWdFI6UH9K6NQeHIAEYGd6ZbLC056UI96f6LG0Vb3hXimKUySrGVGftIxXadFB1cK2Ouk5aYQww5Z9ZjSQweLa3zY1plyI6/yAwYxnZ66oyPT1U6aa8C5e+eBxnAkIqrOZ6JjRbVO5sYbmog9vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752961228; c=relaxed/simple;
	bh=W3kN89lj8UvlPBLtKD7mJw10ijNNuV/qoQwYs015+p0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4RgNQg2IBlo4ZNnMxSq5L5p6Jd+OGZPTP5PtbZornYpUbkTdwX0cv4NKk6c/AXZllgS7vbIg4rfQIMkSKayJobrMW+YoTq/rTZUUQGVwsxTOtbosKJkBmO05MgxiY0fb14t9suN1szzA2/E9L1QtwaHItj3jCpvoZQ09L0kRro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nnb8oH/2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3190fbe8536so2800843a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 14:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752961226; x=1753566026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XGHdILxSPuUknW2OGeca/+gI9lek8iAQvRvNWtifSP8=;
        b=Nnb8oH/26kDrfzozTwQtKyBsGAJ6cVJJqMOn3bXdrLyn8+itlGT3hruDOWMVqJlLkI
         R/GvyNBelFg7CUHbDpgFjt4p6qMksgvZtFdMkuXE3oMRGsZ0G7WZo3gl3IiBb0XAZlKy
         f2Th0tmWYCZZl8csjWGju2+arJwxXIlcspn6oArtOB8aXOO1qzMNW/6EBNlmkSGiz2zX
         eW/LrTjY9cbe5XjhE0sfJnR0DDWiCe6eEz043xiIw9DoJ6pPQuoPQDMwnYZiYCVAk4nF
         IiolK83pY7sR8I8x+dtdY4mdMRaEKVlYBCxHEVTWPrHS86ZBDzHvbl5RjOlTR3qLD4F+
         i9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752961226; x=1753566026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGHdILxSPuUknW2OGeca/+gI9lek8iAQvRvNWtifSP8=;
        b=w9Vh2zjc/eEKvxtqApEAgXWndWHQnW1I+7pixA3bJt+GwCeAgIpBZk4oahxb7tjpcD
         aZykLZKs7PEhD9w22vO3Ce7XhDCenPMBUuIuUuxz02HphzyzrHM40usdFzY02gW6wFV8
         DJXryeZO4Rk47u2a4X0arRCh8lfY7CnE3Era4K0kf7XbdVUJfEFhJbH/iqY3c0LREakV
         doU7NQ4MoltLvtYPijsvwCf9npvmzx5Bhwt8ovX0rSZ3gqCMRGQUD4+VOpE6ERXIlAZB
         oFwu2MF+GqF8IHqwqiHubjYTJftPqF1hWwR/wKC8nixQsNoDjAQrpM7uEX5UDtPhKBzE
         HIJg==
X-Forwarded-Encrypted: i=1; AJvYcCWuzuIFjjffaZo6TFO6L8WndPqS7mtsz0q6o97f95NzZywduv0y5FqKFFMriWqhUIuLduYkg6Q4KaW72E8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtiIIgtBfPYMAlr9xN6opfIoKc+AYxIF0nlU3mTuOQmlmgT35t
	9qJlHXom0NATXxiZMQZ0vEGiKT7CKZ2J82Ze0FnEOpxtgoFQP4C2FyoT
X-Gm-Gg: ASbGnctvKny2P9dc1qee09S11QrhGzOmT082xZjGkX/mbn8NCaqb27uOW42aedUrS1X
	t4jAz+M3PkWptB0crSaLwcLLkqPvpIVgG/Qawf5kLelbrHbzTQO8utQsT8dHqOVVu9T3xi2yf23
	VRZPGUZUtwLeZ/6k0BqQh9/jVRB4XoMoK9lrl1/CgPPrl2F9oJBpHhx4ZfxSPD+HtkyP5FrLLdq
	J0xmv+d3T6eRLNBgGaZ76QKFF/G4YgNhFsfOVFbmoXGDy+HBnRdmtfj87173CWZhY4WiYZkZws3
	xrVoSqn0qe9Qpe2Ite+ZrGsAyjdLbaEO4xgAdsB7yiq0qi/0CDfU1d/Sm2Q22lBbc0Wr6gzhupl
	jHTGm/3HHJKZ5BB+GQdGH2Q==
X-Google-Smtp-Source: AGHT+IF6nUgrwAhHVpdMivFzzFjXbU1sNDw8DKG2eqeKgJvlhpc4t7EgyaNv9lWwzvwAARDT9pbMSA==
X-Received: by 2002:a17:90b:514e:b0:311:ea13:2e6d with SMTP id 98e67ed59e1d1-31c9f4d0f24mr23224353a91.29.1752961225850;
        Sat, 19 Jul 2025 14:40:25 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9153803esm5396235a91.0.2025.07.19.14.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 14:40:25 -0700 (PDT)
Date: Sat, 19 Jul 2025 17:40:22 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/resctl: use for_each_bit_from() in __check_limbo()
Message-ID: <aHwQxsmBj1lZBwEF@yury>
References: <20250719213424.403632-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719213424.403632-1-yury.norov@gmail.com>

On Sat, Jul 19, 2025 at 05:34:23PM -0400, Yury Norov wrote:
> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> 
> The function opencodes for_each_set_bit_from(). Switch to the dedicated
> macro, and drop some housekeeping code.
> 
> While there, switch to non-atomic __clear_bit(), because atomicity is
> not possible in this context, and that may confuse readers.

s/possible/guaranteed

Because find_next_bit() and therefore for_each() iterator are not
atomic, we can't make sure that concurrent threads won't pick the
same idx, therefore atomic clear_bit() may confuse readers.

But atomicity is possible if we use external lock, or
test_and_clear_bit(), if needed.

> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  fs/resctrl/monitor.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index f5637855c3ac..3e1c14214ea8 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -135,7 +135,7 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free)
>  	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>  	struct rmid_entry *entry;
> -	u32 idx, cur_idx = 1;
> +	u32 idx = 1;
>  	void *arch_mon_ctx;
>  	bool rmid_dirty;
>  	u64 val = 0;
> @@ -153,11 +153,7 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free)
>  	 * is less than the threshold decrement the busy counter of the
>  	 * RMID and move it to the free list when the counter reaches 0.
>  	 */
> -	for (;;) {
> -		idx = find_next_bit(d->rmid_busy_llc, idx_limit, cur_idx);
> -		if (idx >= idx_limit)
> -			break;
> -
> +	for_each_set_bit_from(idx, d->rmid_busy_llc, idx_limit) {
>  		entry = __rmid_entry(idx);
>  		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
>  					   QOS_L3_OCCUP_EVENT_ID, &val,
> @@ -178,11 +174,10 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free)
>  		}
>  
>  		if (force_free || !rmid_dirty) {
> -			clear_bit(idx, d->rmid_busy_llc);
> +			__clear_bit(idx, d->rmid_busy_llc);
>  			if (!--entry->busy)
>  				limbo_release_entry(entry);
>  		}
> -		cur_idx = idx + 1;
>  	}
>  
>  	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID, arch_mon_ctx);
> -- 
> 2.43.0


Return-Path: <linux-kernel+bounces-794578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1F7B3E381
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD843AB76D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EB43314B6;
	Mon,  1 Sep 2025 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOIymi7k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E592561AF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730518; cv=none; b=oKVRIcOTJyVzWXsT2rypVPf7ibg8QZXw5LQzXD+9uF6G+6pzw5GduNJVoBw+EfExTtTuaFg91xBdjZ/Bv5a12t7Tr1IYn3sZ7lCcx6OT4J+Ld1OsyLMqRyd0blw7VxnIQ8I0XgGhSNMPOwT7q6WJkfEOQiHRFAnnRjJGzs6KIww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730518; c=relaxed/simple;
	bh=AXkFA71h5OvT9VAHVnto4+vhG+89ot6HZfpXUOoxD04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVFqzo0DdzwlaDrL6XAiOUMoViadnkQYhvho8xvLGUuoRC+x2Mwbnb3ZPkDcIk5K18zC9c6ZJpwKRnmk+4pGNNBRz10JNXFSi8XCWFMlhC5CHbs/pZUFzx5c3iIuf4wSzCYznW2dK+BSgKCBNbRNtBjD9SoK4Ycb8D4ey6UdFgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOIymi7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC63C4CEF9;
	Mon,  1 Sep 2025 12:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756730517;
	bh=AXkFA71h5OvT9VAHVnto4+vhG+89ot6HZfpXUOoxD04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LOIymi7k5dE+c8pPEkBBwti3R3Oy/Ob+anmMjUjICORoXKcqpIffSJPAQL/BSaFB4
	 CowsqOrwAKTNfmhhMjiVsBsWrXjrG/89mdLBrKlNWNmONhlXzSbPSIsFZsyWh4NdWI
	 iWPZfhB9Qo9FH2co/a5d/qOhX8/Vd4U6JeD5Vij1KWEA8LxGr3ybbSNPqVyMNz3QCO
	 CGm7lsvyPdgbnCapqOeAZr1+idYU6Wp9JycXZg5shpA9/UWr6y3u3aYEcBYI9kw8JJ
	 sF6ORuC+pg34oTJcbMstwwG8iDgYrB8a5BEJLIh2Ep+SJKmJSvqF3Sj768NKlJ/UWJ
	 FC1vv8013Y39w==
Date: Mon, 1 Sep 2025 14:41:54 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v11 8/8] timers: Exclude isolated cpus from timer
 migration
Message-ID: <aLWUkpKgFFVr_TEx@localhost.localdomain>
References: <20250808160142.103852-1-gmonaco@redhat.com>
 <20250808160142.103852-9-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250808160142.103852-9-gmonaco@redhat.com>

Le Fri, Aug 08, 2025 at 06:01:42PM +0200, Gabriele Monaco a écrit :
>  /*
>   * NOHZ can only be enabled after clocksource_done_booting(). Don't
>   * bother trashing the cache in the tree before.
>   */
>  static int __init tmigr_late_init(void)
>  {
> -	return cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
> -				 tmigr_set_cpu_available, tmigr_clear_cpu_available);
> +	int cpu, ret;
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
> +				tmigr_set_cpu_available, tmigr_clear_cpu_available);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * The tick CPU may not be marked as available in the above call, this
> +	 * can occur only at boot as hotplug handlers are not called on the
> +	 * tick CPU. Force it enabled here.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		if (!tick_nohz_cpu_hotpluggable(cpu)) {
> +			ret = smp_call_function_single(
> +				cpu, tmigr_cpu_unisolate_force, NULL, 1);
> +			break;
> +		}
> +	}

Why not evaluate tick_nohz_cpu_hotpluggable() from tmigr_clear_cpu_available()
instead of this force IPI?

But if I understand correctly, this will be handled by cpuset, right?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs


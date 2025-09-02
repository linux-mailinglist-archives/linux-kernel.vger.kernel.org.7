Return-Path: <linux-kernel+bounces-796408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5055CB40023
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4339D7B56B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B03142065;
	Tue,  2 Sep 2025 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUktvyRy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A97E2F6178
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815578; cv=none; b=uIwQ10BtNj+tzp1uxXbrGWFOSGMqEhvdfNkZWdFGkLAYNn0Hjw8AsV9HtrqAJchEdQBGOLa9fHwszzKvVlug48BSp9rtAn8fe1DjUWUTp9E+KkF1KvGlPY632cNqwL+yp91gzgbOc/6cLDVyz0PBNuJEHzy8dWWoBZn7wRcqQaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815578; c=relaxed/simple;
	bh=XOiN0aqB7+v6nWqmb6IWeb//XAyuKTRXDtPlUA3BbPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lgj07zbRp+ls+4qHs8ZoRAmiMeg7D2owcFq9cKXet2i6MBk0E5Tr4kJVLEBL25kJOD6rrBOhwIXpjFQl2b03HRLB+CoEn+GXjnpMqNMk1ygVz2N9/HZ0bgomU+hVqX4uoYdRhURIfIqPtsMMh/25AD7/S9rIxqrr14ha/dK3pWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUktvyRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C635AC4CEED;
	Tue,  2 Sep 2025 12:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756815578;
	bh=XOiN0aqB7+v6nWqmb6IWeb//XAyuKTRXDtPlUA3BbPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EUktvyRyfplA0PBBbXN35hISQ7bpf0njfITwwOQLU727qPwTR40HZ9e4q002nvTZv
	 zjGTufr/W74IszAOaE81ounF3T2LMqdcbPQZxrCCB54W1/xzfrvTeHXZlWs8uX2bsk
	 wfynsKDFOfSvEDfvKNqmXHbriUp9esNFWPFtg04LDjhNEBsb0O05B9gToQWXYuHcio
	 FQOOwFTYnkX4C4i6JvCdUdvu40kCoZ8LDv5aHXLpa2TtW7FSrM69nhLeUdIHuSTIF9
	 clYydjwJ7AzKlfAoNVZKGk/BetyUVSBae+aTUocJact3aR+UZCkvcS+r6vI94PycE0
	 Lgf+CS1h1ER2A==
Date: Tue, 2 Sep 2025 14:19:35 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v11 6/8] sched/isolation: Force housekeeping if isolcpus
 and nohz_full don't leave any
Message-ID: <aLbg1_DpQNUjsc2P@localhost.localdomain>
References: <20250808160142.103852-1-gmonaco@redhat.com>
 <20250808160142.103852-7-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250808160142.103852-7-gmonaco@redhat.com>

Le Fri, Aug 08, 2025 at 06:01:40PM +0200, Gabriele Monaco a écrit :
> Currently the user can set up isolcpus and nohz_full in such a way that
> leaves no housekeeping CPU (i.e. no CPU that is neither domain isolated
> nor nohz full). This can be a problem for other subsystems (e.g. the
> timer wheel imgration).
> 
> Prevent this configuration by invalidating the last setting in case the
> union of isolcpus (domain) and nohz_full covers all CPUs.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs


Return-Path: <linux-kernel+bounces-767133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 288CEB24FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C7C1892985
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C1A287259;
	Wed, 13 Aug 2025 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ia8Rxzvr"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B085285C8D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101834; cv=none; b=D25yE6sbSqejYqgFppsD+dkGJ67RQr7ZdO8CbqrLTPYxTOdMVUbvkGZnWI4mOOegzzOcoJHVR4n5TFxYcE3Dqai1dLTStNrot9Whq5kXAcmQEU8fE0sDUbzk591Ynl4VEe3xkTrVohXrb8NVVjeHVLFuvkz+87oeM9SPRVpE07Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101834; c=relaxed/simple;
	bh=aLnZpcSWdOkXn92ubxlWxf5O2UCHUI3ra/13J7g/mq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJxWxdMKq3qbEovZoNH5x8NIZGsVRptjJYggNpCiXAMbXq8P0D6xD9UiNBzURRPgxlglHTgV4Cbxgn1mJFYoOrvn66m0wAmcgsskgh2i3WSqDusB68ONFh/e3Ahv9/C2sxeDudliiKqv5gby4wdqp6JMWUx6g52HW++IzzFbMN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ia8Rxzvr; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e6399d0654so505006585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1755101830; x=1755706630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y0r8lX0/1M6KsfijF5/m66QhjeQjFJTvODKoUvnEDMw=;
        b=ia8RxzvrROyJtWb4VyAqvpjk2HWUECUbQcj/XKu2JeVwgr++mnuR6dY+T2hXOQBPtz
         2blZSwirOZPhacLwrC3taqui8/9UJssoM/duHvOZq2HyiooF7r4eM76mPcgRJWeBcjme
         r1gbU1fp5nVp7Lm39JYmKc0huIYgbBDmjb78kp8zhOHhMHHFRmBYNoeqz2x9NMZWMYFe
         GqJVyFJwAZP8iVId1xHYsh1Tf9KpKnGMT65wYXUVjoKI94sXsFMHWZ/nk99EhOhCL3K6
         BV6njPefy1y+Gt+IZyfgcVyg2Ev5k/1j7ujxXhXrDeUtxmtSTXGkDm7/a0KnQi1eTEh9
         fOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755101830; x=1755706630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0r8lX0/1M6KsfijF5/m66QhjeQjFJTvODKoUvnEDMw=;
        b=NQIAAouwLRM9YwB78XHX7FYTkVWHNeK8mbD6XFkq0eJ6lDkF7L/lX8ntvrhalWU4B2
         9duFNabq9Lzq00EaV2e/TbC3iL8fXjt3ks3w2JsMGexGUUkde0SDqozdjd6SnO15jmqu
         QNKJvLVbYl4S1HkN3R9MnLJGQ0M6miMr3+sOuWby/PRfOUTJJRhWeIv8yq5m0JjFxR1u
         b0m9szCvipXSCMwMQCfjO7M12pigXodO2/D/qpt15uzg552ImatT3G5Tka6sL6dRdtrv
         8iQZZdy/3e0pQF4bD0nKIxqG35pUYQwRcNyeWssU9svdMktUqFXlof1VCtCQG1cXBDuf
         81Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUF7wfpsdzIq+ObgYKXN/tI4b9AGQs6J8wZQdXMyzB1qHl9i3lLSKhNpnS/D+rT/C5PFgLabsnYHCljfLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXh5N184cl42N4lBNEdxm+KADwziICgvTYVFcXbL1ZzgA+4EL9
	OAyfyt4sh6U3iEXczUnBIdhyUAcTWpR4EijcWp+rWBxng8hrVHBpHcntqabQsXPzM/Y=
X-Gm-Gg: ASbGncvQln7vFvN0byfq6OOiwYDPqHt+qfSrD5nHt0MVnyfe8QNbv4xoJeC0Dc8L5+x
	QOZxQgmTn9oW7Gp7cVJdxIb2LKKraVe96Snvra0pVxPmhWtJsUHU+8N+1CHOCLAX+FN8ULUIbnJ
	OmXulmU0m4bivzsEwMxSlHOld764r2d5tchLaHCjGWgeQ1yIb3x0FDMbRrZRY6gC7si+eB0wJfC
	NynWpmmB46YZKDSO6P0RfkLp57vB+nOglXY4pQXv8RDyBnNrKTDgYNYOR2Y+/OW1hgkHNVsUHg5
	3XYT36+p4JYeep+Op/40C/78zdIcVl6TNSFLWyZ8RG84JU52Svnjpq9HRqlw7chPu7ZaH4TKGn8
	9lVLNndz5rqm+tZYEN1QF7A==
X-Google-Smtp-Source: AGHT+IGHCZVUArn+hQTSYfm5ZLOiQRAX3EihSL5rOgIAp2pUobtvdJENs5NTWAKywrm2ri8umYv+Hw==
X-Received: by 2002:a05:620a:560d:b0:7e0:e7b0:967e with SMTP id af79cd13be357-7e86522c104mr386843385a.7.1755101829593;
        Wed, 13 Aug 2025 09:17:09 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4af230d8a21sm153187231cf.51.2025.08.13.09.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:17:09 -0700 (PDT)
Date: Wed, 13 Aug 2025 12:17:08 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] memcg: Optimize exit to user space
Message-ID: <20250813161708.GA115258@cmpxchg.org>
References: <87tt2b6zgs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tt2b6zgs.ffs@tglx>

On Wed, Aug 13, 2025 at 04:57:55PM +0200, Thomas Gleixner wrote:
> memcg uses TIF_NOTIFY_RESUME to handle reclaiming on exit to user
> space. TIF_NOTIFY_RESUME is a multiplexing TIF bit, which is utilized by
> other entities as well.
> 
> This results in a unconditional mem_cgroup_handle_over_high() call for
> every invocation of resume_user_mode_work(), which is a pointless
> exercise as most of the time there is no reclaim work to do.
> 
> Especially since RSEQ is used by glibc, TIF_NOTIFY_RESUME is raised
> quite frequently and the empty calls show up in exit path profiling.
> 
> Optimize this by doing a quick check of the reclaim condition before
> invoking it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Nice!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>


Return-Path: <linux-kernel+bounces-860526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93238BF0532
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47FAD3A3938
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7172B2F5334;
	Mon, 20 Oct 2025 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZD5z2o6U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445222EC576
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954075; cv=none; b=jgqsnhmCiEjfFC27FYu/nF0+4EPX179G7XwPqeR4+Wh+mTurENmKnxhfZI47g4ytozDVYzZHzpRNcLQQJSgAcWZsR7S+UejcN2vPeMYG6hHq+3VQyDfwePq1YZfbkLnUPzeFssgQGhhkm3yyRDT1IWweNbhtiw59Z9H+A9DaZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954075; c=relaxed/simple;
	bh=EDh2hY7KcsoLCVNbqCrydEKfepj9ENE7y3LCCo74QDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahyYnnoDEDv1/2mnMng5KmQQES6Ck9sreACGEHYDBWOdMbiqNfBqmLi6v0cu2baIASEC1HOGdvewBu1ncuwFoCjm+1/ldE2i/YCVMRhadmgVH/CcbxK39mHwY8mfxzD4OlSTLljHALOKNGDapCG49fwqrfJWCkSWvs0dI9cQiG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZD5z2o6U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760954073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FOvPujFryMZ7+AgeMw1kh2ZO5Xa2du80EwXqsZUS+1A=;
	b=ZD5z2o6UtjtJmVOkMKRPwAnZFTAWSglCX8QHsHYo8MIgvIEUIcWzYX47STLcOJG9ornSYp
	bcX2QfP68C0thUPUf6A0OQyDN40Osnr59ZLj3vawijvGvZiQ/fO+JaTDP652FmGJb/uVgm
	S0ih44x1CaSNJ+WU2KKUE+KzlxZcB0w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-qQUPM4KQPUuKotvkm1RmmA-1; Mon, 20 Oct 2025 05:54:31 -0400
X-MC-Unique: qQUPM4KQPUuKotvkm1RmmA-1
X-Mimecast-MFC-AGG-ID: qQUPM4KQPUuKotvkm1RmmA_1760954070
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47114018621so20231355e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954070; x=1761558870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOvPujFryMZ7+AgeMw1kh2ZO5Xa2du80EwXqsZUS+1A=;
        b=FNhYhIbVCZbWctIEA6425eQUzBdSONcjIdAl+GIqC5+aL1tl5fXQHgfX9KFnvEAZ3h
         3LRP6XGPgzh5nSZlP8Iulp4nWStQSG0tjH7Ul97mWrsFFYpHCfQClEZyHE9QxEoibaTP
         I241nZsBJnmYV8q8C2TzHsiKwUjQcg47P9mtmfioHjviu3PrErBVgmnQH3hkCXBQVrnw
         7a9YkT26myRuyYZyTDZFY8YE2lQUp9jKIxSE5qo8sfdBuN0DuEwCfqFL7xG2v/K2PfsG
         d7n1dX9JNkPNGUma4k1q2M9AF7w6dwevyI8B6RHjQ8aLs4VoSgTrfcbaNH+YRxH4C2ot
         n5Aw==
X-Forwarded-Encrypted: i=1; AJvYcCW2gePIUTb0aSjlPWB+y/sY3evte9YyzwizI/DGkOjjLOJWl+8BdMERb6jnROMKVmtB1TWni+pDU+9P/kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ZZ7EY44oQ3S3FleyAvkSkYqcV29BfJGAwVrb0TAVaTrcccb3
	5Ff1Si/NUsGdxwZY/Yqy9SS9dEolGvOn3a5iw+chyA0x6ViuGV1JFOpzIFLH4TMqXYrDWD3sQ1z
	DXKRTiIIEzjKKz0x7rFMHjld89esUwJLvgGgxaRqr9m4icADthIPRT0GunozROQl1lA==
X-Gm-Gg: ASbGncuPXjrz/VXZlnomw65yIG66lwmDMmN1GNH1FLg4J1uoWHQlFyaZiNzIsJBeQO0
	2KxAWtHDSIOWDE+JGmrb0PsvbkKChtcDYFYg2pH2bULCY4qQoA502WagBV+KRDgUXHKzK/9+9Ho
	pCnigqHHIgORI671rR1T/ZO5q8LPesuM2IceXQ/x3SB/hhTXq7zU5DkwIZyeJQsANNUCSIRrhx5
	PXlYElnCzbnP/R9qFfmVXqcUgW7Ru7Yv0K7nmV34oEbGwZdT1sFC3zl6uGEo0R45Yv4+nAOalD9
	C16UtEzVgqJYwYzqnAW+PY5iYsvK7IpZJc4vjl12RdkdsD+alZs/93yJzP9lp+p+GxQZAEX3mZW
	1sRuYqKacTHQ8dlDppGqIeM53inYD/U4=
X-Received: by 2002:a05:600c:621b:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4711791fbbbmr98205645e9.33.1760954070233;
        Mon, 20 Oct 2025 02:54:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwQc8jHbyCjws7r+xEl2xJJIVq9zC6q6jCBAIB087YXtxrslD/Tbf+7AnvpKx9nVNS0eYmew==
X-Received: by 2002:a05:600c:621b:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4711791fbbbmr98205355e9.33.1760954069891;
        Mon, 20 Oct 2025 02:54:29 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711442d9e8sm224260885e9.7.2025.10.20.02.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:54:29 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:54:27 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/14] sched: Add a server arg to
 dl_server_update_idle_time()
Message-ID: <aPYG0w4dYZIws9sr@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-6-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093214.70029-6-arighi@nvidia.com>

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Since we are adding more servers, make dl_server_update_idle_time()
> accept a server argument than a specific server.

Nit,                      ^ rather?

> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri



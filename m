Return-Path: <linux-kernel+bounces-598299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA9DA844AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 15:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E48B3B9C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 13:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AEB2853F1;
	Thu, 10 Apr 2025 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="PZcf8lqq"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF952857DA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291248; cv=none; b=iDwa9EeNE/03K3KTG2NRqPBMkm0sMoN8zTUAkcufBGb+Nyp6p428YsWyqxcu2524m3RtElmB+NQYgiLqWSn+nstDox+DHNU+/4iYB8RhSiU4/OpIrvXduPWjOz3T0LGZAO2k5T0QxvApb1VkUQxyyu48xreMkOs0o5ds6HNNUQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291248; c=relaxed/simple;
	bh=eF3229Ut/7oMgOC0TKNVSpPRDMuApGGwnqq+oOTJ5no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxPcoKYyXcpPaBN1SUQ9JBtV8vTuj1ltCupwwjm8E/0qADF6RTTgvVMjQY807BQu8WxaEzO3B8lFqqtZ+zmSgiLFMI6rCvXECIVQrGpBmKbtdIzoMricxHMM2iTJHNLVmn5hI5uC1WzInxbCor9j5pA7t3FAlBxRuGGR+W/EMqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=PZcf8lqq; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so8740996d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 06:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744291245; x=1744896045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uvjpkhdO+uAITJ9R+WF0zbYBfmINwYKjsiOVdhMgoeI=;
        b=PZcf8lqqvrAaY63sOOmDIug7PYxfoffDKqKMQVQY5oEgTOIO0BCAcG3K0RZRqeOQ6c
         sSuSUgyV2tauswe0jv7/OfAq24zp08/l0zJ7EW1AQIkN7SvIpcs6mHKi+fFCAhacMYcA
         I4nBImutB5sKbuAkrqF2QHFLMBqwJifzsMf5+U4MHm456Eil0cwv7bEYReSFPQ3FL0Nv
         N+cjQACbSe72Z/5V0mENkhwKaduIXIsSFfF9qey61jB3/IDMZ5UxJuKuvz8a59e4iN/7
         fBuERL0bQ/V4hm6ZUYowH8njgXe76JmaH5u6u+TQ9BF+jSN3ZY5wUwXuqlKmAZ6wZhYZ
         qIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744291245; x=1744896045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvjpkhdO+uAITJ9R+WF0zbYBfmINwYKjsiOVdhMgoeI=;
        b=BeAbVyENsbYpTi7jNFUqlgmQxfRopP4EORpjRNf9KVa8qhwXgQfakAXeWhmNHmqOx8
         gvT6a66eqXx1lKY/rpz7mPEsh7/D0RqmxJX7Jo2GC0EzUDw1jPCWTgnYGmHU7GEQ93eV
         tZDzM8ZveFF6Xw6/qMic2DKoFxHreETODYDzRguebJ9xOw3KMoqSJdmkPm8oHf8LLVxL
         zi3rv6COtOyeKeE1zUFDWt7JK/dq5gzyFxAoos+kn91ncppHuarhtz+XkTemqU5EQ4sh
         p4yplQ6A2B6+JnZzFcuH0MNDWzBSnj+RglYxpXuf318/81MXeTfUxcm2ngCE2Ki4aDIc
         HD8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeWZqsp8UiNhrfQoxWBGI397MIsWhXaflfu7S6dPylPUgXbpSlGJFbdy9GvWcdt50iqsmd+kQLJ2nflII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKMJMZ6vlZPNVq2YFHVWHbmMgyKe8ZNfHc9AYBj/9eR5VTaYdr
	fZzpNQ+sRhTZ6iGd+yd6yIeAOyrCQYd08yjTFqjysR6lYtLTssozA7QE4LReh88=
X-Gm-Gg: ASbGncv70ZjCNB+AbvQqF6ZUS5ZKvmrZE4gdcPk1qdjtX/DGkPu9BOiQUCvFnW9u9XU
	If3U7MmXK9wrct6edFLULErkR1xSx6BIeCVfXq9V+dkFNjrl7XVlYITKbnae/q/JFGo3aiP0kfL
	MyNX92COKKRHmCNNEh2fnSLQGFVBH6STOhQufLA090FiJmJ4YL64q1sSGPuNziQmsUX6REsg5B3
	J9XvQt3FXw1ZmnmTNGP0IpKRGUVFPGcil1dkN96KxgqpMyE8MfCGlgRV7f4ajci1HwVSXyVYvp3
	lPrj81vmNfaVHrbJ7mI1AUeFLY7YFzede2rDgvs=
X-Google-Smtp-Source: AGHT+IF1TEpqq1y88DdCFclWrDEHt9sZ1im+VnXq/99xnonpkDH+Mjh4Wk8ppzfG3wbI3GnFX974wA==
X-Received: by 2002:a05:6214:2129:b0:6ea:d604:9e4f with SMTP id 6a1803df08f44-6f0e61be51fmr45231716d6.19.1744291244756;
        Thu, 10 Apr 2025 06:20:44 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de95f774sm20638926d6.16.2025.04.10.06.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:20:43 -0700 (PDT)
Date: Thu, 10 Apr 2025 09:20:39 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcontrol: fix swap counter leak from offline cgroup
Message-ID: <20250410132039.GB102987@cmpxchg.org>
References: <20250410081812.10073-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410081812.10073-1-songmuchun@bytedance.com>

On Thu, Apr 10, 2025 at 04:18:12PM +0800, Muchun Song wrote:
> The commit 73f839b6d2ed addressed an issue regarding the swap
> counter leak that occurred from an offline cgroup. However, the
> commit 89ce924f0bd4 modified the parameter from @swap_memcg to
> @memcg (presumably this alteration was introduced while resolving
> conflicts). Fix this problem by reverting this minor change.
> 
> Fixes: 89ce924f0bd4 ("mm: memcontrol: move memsw charge callbacks to v1")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Ah, those patches got reordered because yours was a fix and mine a
cleanup. Good catch.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>


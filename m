Return-Path: <linux-kernel+bounces-795573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5F5B3F4B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69016484BB6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422EF2E2822;
	Tue,  2 Sep 2025 05:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXjDWCpC"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEF12D593E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 05:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791732; cv=none; b=jZGOGXqNH4Ic4fB4bzQRhRbTTvYn/omzLzVFPCgMAu+KYYhMvLt/B6myf0cSrOpCRRDhpLx0HLSwiRqJc1TSNLMHsEW4ecmoeSWFovgw+a9EYBwODEP9P1Dc0zhXrndnhUvCxcxIyeLNc+lz5Vze5ce3UqkZD44fkES38P7YvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791732; c=relaxed/simple;
	bh=pZaGKPAZ4D4liWfovQ4DFxzR16FVRL9jBWQ0qKv61nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoQGBLvo3m5R0WtUWJ1bDcLTJryZO+VnEjJKGFr0mHlQpDJT7MT5TMsTIZL/O0AuZbEy2xJQ+PGrhyvUPGKQGcpmgHpcrfs37LBUuMFGIO88Y7LL4S+HhJt81Vw3AiJbfYhzhOSng/u9CWNWOJj4uatwDLeXoY9z0nKbPgAmrUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MXjDWCpC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77264a94031so673670b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 22:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756791730; x=1757396530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=29jR3k9rMqRnPavHCfPYA2GU7BTpIOhCsdj5RSaJa9w=;
        b=MXjDWCpC3WOkjlOA6o+/CxydSLjRl/ViNkZwObKZY+dTrukdZ0TM9s89BXJ46p+OqK
         3VzgDUgJQfMoz4SaT9CUZIShj/1NYtb40q4U2RjuPlbrjySd8jmXiUROwqPfIwspAK1U
         KTuZmBA28bhanPywyg51uIN2/3129yivPN9SFiGU5CiyB1xTedF7HQsiZH9wdZngrmLg
         w3IiJvEony4C2HblDyl/GrDk1MwgZjgIldp72IrjBgb2UOTLmsv6YMPm31aMBnwptlWr
         rCcVoeENFhuzMPLiIOCuXluTvfIN3VXrPYe2y2PsOeSpwGThIcVBX/JDHCdut9Lq9s9q
         0hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756791730; x=1757396530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29jR3k9rMqRnPavHCfPYA2GU7BTpIOhCsdj5RSaJa9w=;
        b=PAsroQ3B+4IfHl7r/rKAWNE5+RhSmku/zlUs9Bec7XtyHqQih/QlMFjSBSFUqDwvYF
         PFvYETueX7dd1nzlToYwAX39hJpEzzTr5bIlsnNJvCOeuRWvdR694k5SzQ1R+uYNvPJs
         VRvi8YvNHJWZOBjMpZlQbXHx4fssn2adF06TPlZL+ToW02zmqKJEymXmRPNxZr0AffZb
         yw38LAF41jjxHMxHDquW6/mKw6MJZzc/M+RT61oigUsQXpnpJgVPqiERbRyh46+Ld1CD
         JQcOXj/Nmdys6EgDclgaygagy5ZsGrxGPtKcaEjbm5SrQB/oS+apeGFMwNgY83Gwr/zG
         dR/A==
X-Forwarded-Encrypted: i=1; AJvYcCUH/eE2lZMA202GB2cyMKT5azKTvooyxdxPRx5aMVypuToxofWd5rtCKRmuxPwWxcBj1/7QjzBSstm7eiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMCI8XbKuTq018fpHGqABIB1/zn9T3aLpvpQG0/GqfDmV9dqgN
	MulUrkVrXqq9hXBTfNmVCO7txdjRYY8vQpUepbG14pEXJHXTRYbNR54bV3BHbjT5Mlk=
X-Gm-Gg: ASbGnct+XvIlpOM1tYk+v5O+WgwZcAbWYHYGYI+Ymmamb3fnWWVazfP8Atop26mHYl0
	AlbUPhyCucPMR8aj2qqTISGpDoiGvseVhMHC8KhOE7oVJI1n31HLkVeK27VY5FpBRNbrGmQRUK8
	W0fVZUrBJZVtjWELmRqrcsG5bJ18xuqzPYZ/wO5uZYPJq1IhIVx6f9ykteOg539tdYc4Nds3xso
	Go8CJt0ZXIdL4B31jSE7+26C3WwY2re/gHM6QEZLnHiCrG3vzRWmcwck5ivvdPzBe2wB/GBILka
	2IEnQUSI+ia4ILJj6CHZwdGMr+1ybDAKypF+UScIuBj+saDLy0nt5mE5mRVlZhkIxI+Jy50cuOz
	TWQ4zJPeQsnAGg7KGlfvN5ZdiIYGjox6Bf3U=
X-Google-Smtp-Source: AGHT+IHgtpeK6x+sOCjFIsM2TVd58y3MaGgb8bWKzH0H2wvyTxXZOIDRA7XC34qnep/kILfY/MTD2g==
X-Received: by 2002:a05:6a20:a105:b0:243:a02b:ca64 with SMTP id adf61e73a8af0-243d6e5d1a8mr14547776637.26.1756791730571;
        Mon, 01 Sep 2025 22:42:10 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd309439dsm11045404a12.43.2025.09.01.22.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 22:42:09 -0700 (PDT)
Date: Tue, 2 Sep 2025 11:12:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] cpufreq: drop redundant freq_table argument in
 helpers
Message-ID: <20250902054207.zke5xg3su2vpdob3@vireshk-i7>
References: <20250901112551.35534-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901112551.35534-1-zhangzihuan@kylinos.cn>

On 01-09-25, 19:25, Zihuan Zhang wrote:
> This patchset updates the cpufreq core and drivers to fully adopt
> the new policy->freq_table approach introduced in commit
> e0b3165ba521 ("cpufreq: add 'freq_table' in struct cpufreq_policy").
> 
> Motivation:
> - The frequency table is per-policy, not per-CPU, so redundant
>   freq_table arguments in core helpers and drivers are no longer needed.
> - Removing the extra argument reduces confusion and potential mistakes.
> 
> Patch details:
> 
> 1. cpufreq: core: drop redundant freq_table argument in helpers
>    - Remove freq_table parameters in core helper functions.
>    - All helper functions now use policy directly.
> 
> 2. cpufreq: drivers: remove redundant freq_table argument
>    - Update cpufreq drivers to match the new core API.
>    - Calls that previously passed a separate freq_table argument
>    - No behavior changes, only API consistency.
> 
> Zihuan Zhang (3):
>   cpufreq: Drop redundant freq_table parameter
>   cpufreq: sh: drop redundant freq_table argument
>   cpufreq: virtual: drop redundant freq_table argument

Individual patches must not break kernel compilation, but compilation
breaks after the first patch itself in your series as you have not
updated all the users.

Merge all three into a single patch.

-- 
viresh


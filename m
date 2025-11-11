Return-Path: <linux-kernel+bounces-896100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9B7C4FA4F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7641A18997DB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E559A34D911;
	Tue, 11 Nov 2025 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M+HGwQjc"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6757932C312
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890490; cv=none; b=kVsskEiE/l6GtnA3q0aQjVDDJl0sFV+wgA01aoqM/yX2EtI4niHLAiTK8QVNJqUuAjWXebM3askAg2b1TkJ4FJSIUSyIIeq5a2RTV0/hlmLw7ntR7urbwapTvPjYDE9obwkyL1u1CEJAdREo+h9NVdEuHJ4uhR6CU9jlRwZTOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890490; c=relaxed/simple;
	bh=7NdM9un//Qfx73SdLhAZgOos/RHP5qnSPQzhB6KpO0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCjzmVZ5JUeu7k9AIsf2ikbN11LYOSEL+zlAcnzBF8E5Kux4sKNMyvIlmth9Axn3B5IJJZuvHpnIYwyuGBEPprbwXR+AoGKJhfD3AGu5wMWU8J55do9/TInqNDUzL+I9xwy0IRC9f3pCVfgndc2DXtm6DLUOmTiF6pNGoAT5JXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M+HGwQjc; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b72b495aa81so19093066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762890486; x=1763495286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lKDhxqPky+srato1DuJ5M1fuwPAvG3rezlKsBwQc3xk=;
        b=M+HGwQjcYfUdbj3df22FBRRQUUcEwQVqmaxOs75Z2J8aVsx9lVFnRP+SGNh0qzig4q
         JHTMx0kiC7KoUFCJ92wZzPidu1KZ7RkvZGF8HuCADjIRyuAPkObgQz1FU2+wvZw/D0+d
         frjbwY/Aj1XUs8r2V2hB1XXBGNPwFBcQhUlEcZQ/lp5FVT3hvIeZ/rF0u5l038uKM4VK
         sfuh2BcvOaA1HHSihxT9Ggf7614QBX+CPM6fWS6w9rCcaksnIpCS3sko0m75mJNnWoKl
         5057wFox0GHKQlu+BXvNjMYIMA0IjA/vrHJqePUfdKUbIvo35/1A5b0fNkA8D2j7zrDi
         1O5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890486; x=1763495286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKDhxqPky+srato1DuJ5M1fuwPAvG3rezlKsBwQc3xk=;
        b=jAY7e20sXntZhI5JCmtGvqhUxxrFtSBdEeDfy5F8iJ8Vt6//D9WG0Hn5xJ4su2Hp/O
         qUIYnM18JJee67fbuap0hgUfIRNNKjt3yQhRbEe0zvCmasngTWvFzrVsRO52VUjK/JH+
         16rQrQnR8KLkBxAwtkcss8PvKPu1cN8mctS7/lWpSWCcDKFDQrh45CKDKICBE/h7Cj5b
         IEj9CHgIs9Wq7msC6TJVZw66o2Kta6WKEAxuhUgQNSHIXI+I9EqAQaLZoUs8Raxzt7B/
         YiJQNm/HnDqz5Yo8RJhMrn6/S42AeuGNQO2DrYILxygbGKaMf8yWHvpcHh36cCqLby62
         Oc5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWk9Bp3GlN9mYrH9dxeUGDRC5XHiGi01/mx6H48s81eG2v+ehy9bSkwR8+z/wDUIk/rMlNaO4GO0T8YHJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLA9+ZgtqQNi7G9yLLrmlBJT5TCuUMcgoOGQ4s003uS5g1BDHZ
	rhWZ73+cfNc14GYbnvAxb8bm8noBnLoofDPAUFSfxMV8KjxeS1gl0mxgak3FKcZCTQw=
X-Gm-Gg: ASbGncsbzs82U5Ope6lsPVR7RCkNIZW7wG+bk2ErfuxHVMT0f7V3Ns55ncAjQUZXFt1
	A/Z+0KyRc/8wWT4nLeAZXyU8MypVAwyE6PmE0bIre7tBzopd78+o3YsaX75BKl8RcwcFEQ6N1SD
	TBaZb6VEst3HPWNX5WY9MWnAa27zTiOazzNT7POV+aMTwJEg5c0WOsoDPBQuG7JrfN2nmOHTfwA
	MW6OQTtYb9Ah5wm0o02kZHf6OvLu8NuzRHvuRSgFVApCUuXeBa2Pu6MwVTytDZeG0kzp3z+uuHG
	Qeeov3mg8wuLoYLsS9kcFrb690/W63KP7LFm+WgjSZje7N7F7cBuLzfn2JcvvltyAp9/uBOrPdk
	TAnENMLNLU9yqr3frCLgxJKnLTJvCbZWYjrBFeiYQPxJk2FkspmBopnKCVCcZbdQY/ejfYDtth6
	K2I9CQezgXtgIN4xd3w3Cfu4Cq
X-Google-Smtp-Source: AGHT+IEelejsUR71Jpq8Ao/NajBuvRLoWEBkOC/8vGvaNmUC/dfrqtprfl//rF6trpCO0nJn8h4ofA==
X-Received: by 2002:a17:907:9812:b0:b73:21db:53a0 with SMTP id a640c23a62f3a-b7331960eb5mr32990666b.8.1762890485668;
        Tue, 11 Nov 2025 11:48:05 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bdf15sm1411961966b.62.2025.11.11.11.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:48:05 -0800 (PST)
Date: Tue, 11 Nov 2025 20:47:59 +0100
From: Michal Hocko <mhocko@suse.com>
To: Waiman Long <llong@redhat.com>
Cc: Leon Huang Fu <leon.huangfu@shopee.com>, linux-mm@kvack.org,
	tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	joel.granados@kernel.org, jack@suse.cz, laoar.shao@gmail.com,
	mclapinski@google.com, kyle.meyer@hpe.com, corbet@lwn.net,
	lance.yang@linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
Message-ID: <aROS7yxDU6qFAWzp@tiehlicka>
References: <20251110101948.19277-1-leon.huangfu@shopee.com>
 <9a9a2ede-af6e-413a-97a0-800993072b22@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a9a2ede-af6e-413a-97a0-800993072b22@redhat.com>

On Tue 11-11-25 14:10:28, Waiman Long wrote:
[...]
> > +static void memcg_flush_stats(struct mem_cgroup *memcg, bool force)
> > +{
> > +	if (mem_cgroup_disabled())
> > +		return;
> > +
> > +	memcg = memcg ?: root_mem_cgroup;
> > +	__mem_cgroup_flush_stats(memcg, force);
> > +}
> 
> Shouldn't we impose a limit in term of how frequently this
> memcg_flush_stats() function can be called like at most a few times per

This effectivelly invalidates the primary purpose of the interface to
provide a method to get as-fresh-as-possible value AFAICS. 

> second to prevent abuse from user space as stat flushing is expensive? We
> should prevent some kind of user space DoS attack by using this new API if
> we decide to implement it.

What exactly would be an attack vector?
-- 
Michal Hocko
SUSE Labs


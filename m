Return-Path: <linux-kernel+bounces-780498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31891B302BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9761CE4120
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7A127A456;
	Thu, 21 Aug 2025 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVPUZeYw"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ABB19539F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803885; cv=none; b=qc0iU0tqMlflEhbdiRm2lWijChuZmCbt+NpMI+cdI/R5jqT1JT0MSI+hdVd8wOJkFUHRtRdVqSvqGTurGA4BlQkpK9Wvg9PeBijBsBE9F7pt/FC8wdq2DY7cw+yWPyUzFLpPhqco7P03JyLC69uA9uMHA2mC05GNPdFFmB80IwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803885; c=relaxed/simple;
	bh=KAFpepcrog08PKjGcqCrxufg2PjJ+TTIjpUBSlX06Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnGeCNmG3Noq20j2vupUHig3SMr23vPbzw6oRw6sEvcYkEzPMHhdbpPcOJt1o3ZC+64ANXoaJdHDtbttmNsR+K8PkyvLsjSQuVnX/BbvdUAiM5v8yKUwuNJsWfkanaha/T6Mh46IQ++zTpOvLRs8HTOqhTOW/PZ5/QCmJNLxdBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVPUZeYw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9e415a68fso1165597f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755803882; x=1756408682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OIUfadtyrX+885VNIhzlz6298Jbid8a7B3cqJAhGNyw=;
        b=EVPUZeYwvHISA4hulNeiyXhs5dG1abSK7PD9PvVM7SB08IqAC8ei88l9g5ZNRwVszn
         S/k4x2fSxD6lzAd8rvWbwHwxE+ie/j2Kz7xXIPfxSYV2/SXzgTpji64+Vx5yXp/fMopQ
         gsFoEy4mQ/Pt3Q1gKggGtzSiZVbm4dKUZRhPSU+p1DFWoqN+6cq3LOO06/SfzU6Xnto5
         xD7Bgi6y9DB4t1Ryp9m1aYUgRgGDhojTad0/FzMXBpGVLxiYe450Y0wOjdrj2PFMFg+B
         TVZ62ghRu3Nl9B3Rspi6b0HXznK5jFdbn++ytfelVGU2qFVXejT1vPpUvjWN8Sajr1wu
         ulVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755803882; x=1756408682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIUfadtyrX+885VNIhzlz6298Jbid8a7B3cqJAhGNyw=;
        b=BGDn4EBJkxm2zHO+i+7ObEjE7vbdukvn/PNQay1mbo69HOr9dTNe8iP6TsRZxqmNH7
         z/4JHuXS+oopi6rM3JoM+P06Fqh/PD8ffODmUVlTVsFMu0guFEDyM54x89ZguxTwnUkV
         IGBSJPXkryB4OH8V3IxzcAThxsOVjIrkmTW2TnR/ZNQgmzump2W42PoP0oWB5uNFhNGN
         12B/zdxTy/YpeqfM65szOvq9PwqyW8oLBSCX/JI9n8bpkwSQDMQ6Uv33HWdSdxX3DaCD
         R1NdFeESKr1HmeM+B2K9NNx1PfS2SM879xvl/eYV3+Z6Zl/Mre1Sp3pqFJpCz4MuQyYx
         vyGw==
X-Forwarded-Encrypted: i=1; AJvYcCUJs2TMnPkSld5XUKh7gKziNjPkE7AZYASfrdaP1uHjza7edeF0HwaISN37eRFvMhvd4GLRulUaKvkprK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBg3T93VSeB1EZyyR65AkYgYUg6jKaVAp0TVTCW/kYBkAfBrJX
	F3e8UlCA7nXL2malCndCOeEBUy1r6wGpyKlK8ale2dBcQUBTwpfrODjD
X-Gm-Gg: ASbGncvMhHH2Mt0WBbjNpsP7hGBfbgW0o3nBCb/Cjwa0fyNmwyCQyhPGjFzmE7bm0WF
	C+pgLp67Y8DWHJIrXSzj7CXJ+MP7NNwiHiFuXc1PomcOyLbp/GIuI836EGKwZvCV7LnV2Xy+8vH
	Yiw9Nu6/zDT5GeZ+tF7CX3I6Arg3IsuuT7peYAvaO4uupOVXYnrsKteUvPg3O6bR5UrobT5aWN2
	NR3zfWK3Gmq44dMw4/0lFQ1rFApAVX74nUjMDE9sKa92ibCh3uQpvEBW9GQLpr5IS60GqGVLHue
	ew+YaOuVlgpa1ExEIsX8InwvYEKWgMzZMoMf0hc4ywy490TI5WsibfzqVN7w2TLeuuMxRnasf/l
	9IChW2fam1ttK7OxL0Jpl2y9qyROJdplik3ArtXE=
X-Google-Smtp-Source: AGHT+IHjaDlr+iR209Oc/z6JbUmzDrJHC9V+eZOuu4bHyOSAYWtRWU7bYzUgOQc1ufCzQDegRKL3yA==
X-Received: by 2002:a5d:64cf:0:b0:3c4:39cc:366 with SMTP id ffacd0b85a97d-3c5daa292d1mr128606f8f.15.1755803882226;
        Thu, 21 Aug 2025 12:18:02 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:4e::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077789d1dsm12574809f8f.49.2025.08.21.12.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 12:18:01 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:18:00 -0700
From: Yueyang Pan <pyyjason@gmail.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
Message-ID: <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com>
References: <cover.1755190013.git.pyyjason@gmail.com>
 <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>

On Thu, Aug 21, 2025 at 11:35:19AM -0700, Shakeel Butt wrote:
> On Thu, Aug 14, 2025 at 10:11:56AM -0700, Yueyang Pan wrote:
> > Right now in the oom_kill_process if the oom is because of the cgroup 
> > limit, we won't get memory allocation infomation. In some cases, we 
> > can have a large cgroup workload running which dominates the machine. 
> > The reason using cgroup is to leave some resource for system. When this 
> > cgroup is killed, we would also like to have some memory allocation 
> > information for the whole server as well. This is reason behind this 
> > mini change. Is it an acceptable thing to do? Will it be too much 
> > information for people? I am happy with any suggestions!
> 
> For a single patch, it is better to have all the context in the patch
> and there is no need for cover letter.

Thanks for your suggestion Shakeel! I will change this in the next version.

> 
> What exact information you want on the memcg oom that will be helpful
> for the users in general? You mentioned memory allocation information,
> can you please elaborate a bit more.
> 

As in my reply to Suren, I was thinking the system-wide memory usage info 
provided by show_free_pages and memory allocation profiling info can help 
us debug cgoom by comparing them with historical data. What is your take on 
this?

Thanks,
Pan


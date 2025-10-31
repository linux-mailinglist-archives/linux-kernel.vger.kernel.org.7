Return-Path: <linux-kernel+bounces-879789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 975BBC2408B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9F874F4BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BB232ED52;
	Fri, 31 Oct 2025 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qa0LOxbF"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106F832E6BF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901565; cv=none; b=jvGq6740zBU8uD+uKg9TMbZcFs3K4C5r7NxUh7pnfjX/dvg1/dUTvVyJDkFYbbSo8QwmiYLdbVBkb5nlZ2U5Kj0oGrOCHD1Abjgl9IjjEVxCbIIot7TnleLe+UY6D3HSHRrmPtbrxWSL3epBmukQuofHpDaUpXnUYFE2k0OTN/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901565; c=relaxed/simple;
	bh=ku+s48JLQC3eWSP8xQJFPNECjEvh3Mo/HcgF5mJuAto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/IlKqF6tHmFXPk9EtVnn2aUk5x4XvH6EZUZaAgGjiTvAVtkrY2l1vCbOO05zcyZwwmXw4PYlkNV5jOxcGtv6r/XOnOSmD9EXtBnmWkXf4CV2xckm5Co/4AkTnfVoKuhwLw41OD+Dest55snBo9iJxVXOJpkIY4jxoDMZX9jNEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qa0LOxbF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso26216255e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761901560; x=1762506360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Je1BoSkiy3cQsPMrVyvcSTGyt460ikMCavqziE4oJW8=;
        b=Qa0LOxbFPBTIZ5cwkjkceemeoaDAvEF27VjguwYlURhZ2PL3DLN3BKqVlQepHUHutb
         cZ3jjSitHVmjW/ptrGxl0LMFy1BzL/MK1QV/GobRfyDX+rsx9g2vNyk7A6nIxtWK7DQM
         XI8U8HPDA/yw+bk86n4qo4IPX4RVPStvIT0L9aq9462QVqJAVLQYK1ek3/Vlue1pp7HG
         NrhsqA6uj+dLRbXdoAHFKyqL+yrK889PHMATq3eWmr/6eFRIJuv2njqQXiku02hVjy5Z
         6s8QFWQ+qAb91+kZsXHuY99XKNnDNoIL+yYIpRwKJzY035098x/kZVKCEQi7d2TSGlvd
         6Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901560; x=1762506360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Je1BoSkiy3cQsPMrVyvcSTGyt460ikMCavqziE4oJW8=;
        b=tBUGsTbqiGHOVrBMMAzuYOKDi9L18qD7M/k57o6QZaPcS4zeXsg+7StgRTVPTGfUl4
         Rmxy9J3nBXGJN37wP8n/FN4bZ2Q6rrgByJHNo9J3cFSLGd/UFC1NZogE5ox7ak08T7yq
         P7DC9em5APBsmI4wQoSNDFmS3J20u+vt+burZDmNo5uq8s/gua13X1ude/ey1dW4I4WR
         vebojDIBD5NR7MFPRBWQ5yUb+ZNsN38eG40Y9DfLpZls/CN7xEIeJSsynDKt8ANpZHQ1
         rkTkgWdsOby8aq+YDt/syv22aF6MPCvd488qypJquCNPqXU2Ognd+HkbKiWu7YVbr/Qc
         3M2w==
X-Forwarded-Encrypted: i=1; AJvYcCXWY6X0bTMYmxVr36L1Q1MUMj9LIPd02bQjKyrTB8dbNQJdYp2wcWyCpFS32dVUgDNwYPdXV7DBeaUUpW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKMa49nfiN9aNV78mN9gnexnkHX4wUSa4lWLk3tBBC5QaYg1Ev
	9yjTLPX9VwkZ7TrJ10YGBqJWmBwfUfWUmeTA+cf5qHOnXGTw3DnPN9J7YS3zALlvLoI=
X-Gm-Gg: ASbGncvvYbx4NcoxU4e5Fzvs2+dB7zcNMPyuBPh0ofTsC1RUVHUXQO0Y3F6qWVqDMz7
	JSHnRe0Q55d9zl68lHXFwzDcnVHi06kf14ZHL0mppckSR3ShtcvKBV5yMYGSxm8m6U4D2ohVQIR
	tXCz+FsXeYPmqO3niCFNaS6Rh4Ga3sCKU+iY+u31Db9Nw28wN/aQJCczwA59VgcCr1rWNO/uYLD
	g98ekULeccOLszr3VhwpiA1syORS+mJ3Le3zhDCAsSo7ExNFhlWodRAKJGsLHjWmcL9hqfvq2Au
	iMId3fHjsGz+WeQNDAtYiYYstOuXWEk9RbQy71G5cmzmcu013ejNSOovm1k0DnOOy4zSWXbjmqb
	p0t8MNGkM58EszuHU/yQ8Qs20szjMVoGr1MYP9VfeHXxismHJd1l8mkFcr3X2WZtPz3jOWIxJ8e
	YDQx4L2ok7VCWvtN0ORXRuyD25
X-Google-Smtp-Source: AGHT+IFDhjw/NQy6gXd0KrwaHxidybeaclTmSKM+ZycX2IB9hql/be8JKkXi3tpvF4ocbMgb128LQQ==
X-Received: by 2002:a05:600c:4e44:b0:45f:2cb5:ecff with SMTP id 5b1f17b1804b1-477308ce7b2mr26457735e9.31.1761901560280;
        Fri, 31 Oct 2025 02:06:00 -0700 (PDT)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fe5719csm17619365e9.3.2025.10.31.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:05:59 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:05:58 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 07/23] mm: introduce bpf_oom_kill_process() bpf kfunc
Message-ID: <aQR79srdPzyUT9_I@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-8-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027231727.472628-8-roman.gushchin@linux.dev>

On Mon 27-10-25 16:17:10, Roman Gushchin wrote:
> Introduce bpf_oom_kill_process() bpf kfunc, which is supposed
> to be used by BPF OOM programs. It allows to kill a process
> in exactly the same way the OOM killer does: using the OOM reaper,
> bumping corresponding memcg and global statistics, respecting
> memory.oom.group etc.
> 
> On success, it sets om_control's bpf_memory_freed field to true,
> enabling the bpf program to bypass the kernel OOM killer.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

LGTM
Just a minor question

> +	/* paired with put_task_struct() in oom_kill_process() */
> +	task = tryget_task_struct(task);

Any reason this is not a plain get_task_struct?
-- 
Michal Hocko
SUSE Labs


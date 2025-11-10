Return-Path: <linux-kernel+bounces-892736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63506C45B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 931174EBB69
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA68302741;
	Mon, 10 Nov 2025 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Af66f07N"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAA1302142
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767980; cv=none; b=JSkYOoh/BCYPhmfxfW1z6GPAQ7WeDM0G8isvaf/N/ODyIdjmRgIjbyFCuHuINXlyt9/+CmfuX0B6DvJlwum6yxTFC88CnRFIlKSiaUYemixieBjU5fz0HqQ9sipzQZZcl9/bAbPHbJ7gnsVvhyDQiI2KZOvrWTtBhsI4EB108Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767980; c=relaxed/simple;
	bh=NMx+80RAtRR69xjJFiFNTuk6xFPiPToOmJjCwv8y9D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTOXIjYYxmTweSSaBVEQI3ioxkW882bJ7j08svtLbU/CGD34q/uFxvLoFnSNbF/CkLOFABZKer9KczHGQGSEjW64uhpoNLsA3NijYcFRX6zlkrvHYNcb1VgTmW/M5lES6MHiWDDiUraqOSfTzscuEta4jAeCaQMT79aS1cxwcvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Af66f07N; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso5700527a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762767977; x=1763372777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+ENjiuiICq/dHaWISCwIQ30N8r+q3a2JUSxj4I5SZ4=;
        b=Af66f07NTIFdPiwJPK3OpAEebehX3C63WUeCT8aMrKjlXeyPR95kfKf4evVzlI0q85
         NVEnXFpJnNl9t6U5VnFZKTAkjE0Ay7RdhsT08RRh+nt4Cz0UcKHD+JnmonIcFrqI2QzS
         dyTz3j7GQ8FlfOsRtAApdXSdgh8Y6MACXWEN0dWSiiQsl0saBfbb8lzemhx2YWZ2v5ak
         MlHIj4QjckjjFjqcbv87nlc7WXduJqj3BhM3uKCpHpLDN1yhBlbqCuuc4Cd8RXf3EcSs
         Cio697HK2urzJXhXJUK54/fesnsGcKioiAueNtCnbOrAfa51hfXCqe//ZmIT5P69BVHv
         2peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767977; x=1763372777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+ENjiuiICq/dHaWISCwIQ30N8r+q3a2JUSxj4I5SZ4=;
        b=i0xzSZMbjwSihefSs/EXovyrcwy/4v3gjpGK3QFpQGfN2mu2jOaPEImKpzQpeoKiDk
         BTzYDVGLxdXlfgwWoWO5FFVT5j+ivI/0lvLbx8aDcJqnvbckpG7YzVS/spe0nYwyO9Qc
         S+MpevSiJo238ITYcPwngIHdAHgCDs+zWsMIaKhQl5AvsWcIzoZtr1ZUR3R6nk0wOcME
         CNxlJbWJKIMUzHqs9uH/QVqMa9zo1QzxsFXqowCO8Q/ezrt5MZlqOU/38cBJgJHHOVDy
         vNej27VDfwZDGBjUgRkQTbl8lVFGk4zKolzMMXtuOLiXeM69QSAhfnnRHyCpWkkMFiNJ
         vfmA==
X-Forwarded-Encrypted: i=1; AJvYcCUHoqL4+rJqJxaIl6ebD6DcZobyVFUKcGQeRUcm7Ds062Giw/DNJQEI4HeHj9NGhvAy8l6kPz91kTEw9qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD/RFBn1s12DGU/as5ir0mOl2xHjklJBxIuVhUECfO+FYmX2sF
	jELmE0Dx+OWuzgWn2XphYZTmHhKvRAZx2u6H5y+Hbm3VZqAAsMmC/gaW8tB0uZooE4o=
X-Gm-Gg: ASbGncterLLvjAHZYGnRUnfwCaKgFFZx4vAAlPVcXP2wZ/6hMRt8BQPXe7rj5r6e6ny
	XdxjwkV1mfIsW33+BV8K52ggv4tr3eEbuq/WIrnA9vbATxsqhTioEz8xb+ytdDguQjd8i/uO9m0
	1v3CPwX5LiTK/MUlb+mrLRPR/bghrjbyhZOqYar5Sq2stFxkSMDwfvOEtrJKbHL+xRUkf8wLSOW
	r35j/9mFyOq4g7sfJo1Zi1EvOCBpNdds5cJMarF/Q2vZn3f9HZzwWUKpQHAGGUz0e5cc5thiojn
	CEFN6n9Mtm1A8BJzy9PWQJ3pLAgFfljAQ0MG61BPccAuA/v+gqWO4dVBy+z2xn85ryyNzByzMAr
	ipr3YYq3mTYGhShsFmEO6zPFMTZewXwuF2kmEhtP0h0S6RF2+YHC19bMNbreHxGC28YM2LXqduf
	r4hLUcQRUdkcT9uw==
X-Google-Smtp-Source: AGHT+IGmZmcainr9lTW69kXNHob9h7gFoRrMJ4orD0WaJEzcosAR93nxuffTYpmtgx+UXuB6Sga00g==
X-Received: by 2002:a05:6402:1d55:b0:640:ceef:7e4d with SMTP id 4fb4d7f45d1cf-6415e81207dmr6218186a12.32.1762767977000;
        Mon, 10 Nov 2025 01:46:17 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64179499189sm3896343a12.8.2025.11.10.01.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:46:16 -0800 (PST)
Date: Mon, 10 Nov 2025 10:46:15 +0100
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
Subject: Re: [PATCH v2 13/23] mm: introduce bpf_out_of_memory() BPF kfunc
Message-ID: <aRG0ZyL93jWm4TAa@tiehlicka>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
 <20251027232206.473085-3-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027232206.473085-3-roman.gushchin@linux.dev>

On Mon 27-10-25 16:21:56, Roman Gushchin wrote:
> Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
> an out of memory events and trigger the corresponding kernel OOM
> handling mechanism.
> 
> It takes a trusted memcg pointer (or NULL for system-wide OOMs)
> as an argument, as well as the page order.
> 
> If the BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK flag is not set, only one OOM
> can be declared and handled in the system at once, so if the function
> is called in parallel to another OOM handling, it bails out with -EBUSY.
> This mode is suited for global OOM's: any concurrent OOMs will likely
> do the job and release some memory. In a blocking mode (which is
> suited for memcg OOMs) the execution will wait on the oom_lock mutex.

Rather than relying on BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK would it make
sense to take the oom_lock based on the oc->memcg so that this is
completely transparent to specific oom bpf handlers?
-- 
Michal Hocko
SUSE Labs


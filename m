Return-Path: <linux-kernel+bounces-899731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D102EC58B21
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03484505CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5681B357A2F;
	Thu, 13 Nov 2025 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgRUwT5/"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0803570C6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049626; cv=none; b=AsY5heHwgifbb8GlkstIQDT3RrGrLvgcOtFYr8v9HHVTunTrM9jfZg3Edp+JUgxW3DQJNKwCW57tA8qgrK2tx+y97srCZb+AyOqgf3X5D6smVmlluQiTZtanVjkpRPKnrA6NxmPAXo/ZOqtIab9wFLfL7pjos1SYtYIkko8VROs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049626; c=relaxed/simple;
	bh=Vp4rIQGpH9tuhUx6e8f2LGfVf7+ePCFWdukgjpjRGmU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzrEf+IqzowEz6faLMMS9F+mNBhRLzBZ29PTx8T4sQt/BaC6k9FHJ06ZFQp/ey0fQ6i5IPQQ3u4kEf4jDimrvFw6aLnGI+0DwlGuzr1UBCXRupbGEZeb6cPpBzZqGJ9vm6vy/8Nqn+OeubP+bpWiJyiyGjjiw6PqxBjBCn7u6K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgRUwT5/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b728a43e410so151246066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763049623; x=1763654423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=80JtMfsdtaRpjMfo2AMqSTwjIMkYXc61RQPSQzuIeBo=;
        b=fgRUwT5/p68gBWLmI0vm/DxZ9ZnZwegJAJqt70st2v2DyXfi0Hxmm3MHpT3/wRaV0e
         G5mLPO7XExYeRJL98zPXE63vAIzBjNtfdeMWua+pgMO/7Em0Hgk9adSgPf7tuqew7ReY
         wjsrgnq7ETdTcp7fAjd8JvW4XddE1Ro/shNMCBbqiXX+FetwyVCczBClrRL4Y4mQ8wVH
         08+dD0hke5uVDdUKRQIJ/56JjiKUQ/gyCQrT+L0eTtKmentHGtkC1wmP1QfsJ1jnZKol
         4FfWZ9IN9kWklUq3obJqghy7KP8HIw3ZWhw1Ltq/V3CjkXK3k7rU7wFx3ErUvLA95Buc
         ot0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049623; x=1763654423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80JtMfsdtaRpjMfo2AMqSTwjIMkYXc61RQPSQzuIeBo=;
        b=BD0tFt4yxr5og+J43hNeyP+ZrB6aHx3GeDlKgs3FF4vBI9yr3syc6wZ8gYLaiIgwRm
         bTWlHDOUnrdv0tR7XMnQasTBSmsTcBhd74cySs8LDlef8WY47n5RajR6xN6tSNcAAfLI
         2HqmAJFz6z3tgRuL24llWktM9h7m5ejwRl8L0URqb6YYiufAJATTMa3dMJhthby0C9KB
         wxFNmQknwZoDgigjVlpSXZ8BZr4NYnt5ujjNuV25a2SSVFNH/lnSwDlCPLtBFCfwjz0N
         wYX7HUG015KglRWWKGI/H3sZm1U9cle4zI9QHu9xFtwZ3zSvCWPeM1Wh8QrnQJ1KNx5e
         ROBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzmo8VZt9jbWeWKdxq+6WEUp3EO8rvyTA6naBDgFIMcQ3p3SzT0gBemPfzRjj5KeI/CcP7URFG8S1o6nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsDSGeDq7YWbzb4O2ZgIX2HyIXyKeMgDgEU9sWmUpPI+8dn5/Y
	14zCGRBBC7SEFqQW0UIXL2iFuwXUOwQ3GdjxGlkUH/HRp6Au11lrEkMc
X-Gm-Gg: ASbGnct4ajWMookdUIlHKlXEaKNe+aoCCTS0oUpk/iHn55nw+CarlemGaWy/Mc51g4X
	vj5ISjxGkAidtCAM0w1yuDHJNNIW1NYPqukC8sieLqAArPn+O7qxmOEl4CSzS+zi6a/9fe9X5eG
	4Kn/BDKOZrhZF8ZG9MbwGkWBSulzkErN293AOw9KP03KZipu3pvlsSG+3nq7WknuowvifdN3yyX
	M4nBGlyxijGMRGkXGZeuutrHxV+KmrdF3BxjycwV2o56xp9bbZ/wnr3zjl6XMeB0dA+9uWLCQQ5
	VZ4ozWhBHDCGa8XypHvzCv3GouF6ofFaRzhXC3GmJKV/2m/JKjZIyHH4XSOpVrBO+jtGbhMHWo/
	ZTcQEKHRRRwMP9OAMwQAYsy4co8RmPnVEN8xmhtgGVJmc0eFWBqt9aXiKKn2A9+CqPAvntuYBJR
	8MzrpoEKMIgJu1A59BG7AQAiM=
X-Google-Smtp-Source: AGHT+IHxWTR+gxCCm5O+QnaZgcQbkYMnHS+HofPNLwkm1lurpI4br2sYZn3D0vg/6s301g3YrvxytA==
X-Received: by 2002:a17:907:6d0b:b0:b72:d309:5337 with SMTP id a640c23a62f3a-b7331b4c280mr700851766b.65.1763049622904;
        Thu, 13 Nov 2025 08:00:22 -0800 (PST)
Received: from krava (37-188-200-155.red.o2.cz. [37.188.200.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fed90c0sm189439066b.65.2025.11.13.08.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:00:22 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 13 Nov 2025 17:00:16 +0100
To: bot+bpf-ci@kernel.org
Cc: rostedt@kernel.org, revest@google.com, mark.rutland@arm.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, menglong8.dong@gmail.com,
	song@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 4/8] ftrace: Add update_ftrace_direct_del
 function
Message-ID: <aRYAkKc2uQyofL1i@krava>
References: <20251113123750.2507435-5-jolsa@kernel.org>
 <367c6cc9ffa12937ce18f37fc1271e3d17a3f7aa6ea6d1152cc8a41539994865@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367c6cc9ffa12937ce18f37fc1271e3d17a3f7aa6ea6d1152cc8a41539994865@mail.kernel.org>

On Thu, Nov 13, 2025 at 01:02:21PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index ded3a306a..433c36c3a 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -543,6 +543,7 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
> >  int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
> >
> >  int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash);
> > +int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash);
> >
> >  void ftrace_stub_direct_tramp(void);
> 
> [ ... ]
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 311ce6406..345f3fdd2 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> 
> [ ... ]
> 
> > +int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
> > +{
> > +	struct ftrace_hash *new_hash = NULL, *filter_hash = NULL, *free_hash = NULL;
> > +	struct ftrace_func_entry *del, *entry;
> > +	unsigned long size, i;
> > +	int err = -EINVAL;
> > +
> > +	if (!hash_count(hash))
> > +		return 0;
> > +	if (check_direct_multi(ops))
> > +		return -EINVAL;
> > +	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
> > +		return -EINVAL;
> > +	if (direct_functions == EMPTY_HASH)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&direct_mutex);
> > +
> > +	/* Make sure requested entries are already registered. */
> > +	size = 1 << hash->size_bits;
> > +	for (i = 0; i < size; i++) {
> > +		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
> > +			del = __ftrace_lookup_ip(direct_functions, entry->ip);
> > +			if (!del || del->direct != entry->direct)
> > +				goto out_unlock;
> > +		}
> > +	}
> > +
> > +	err = -ENOMEM;
> > +	filter_hash = hash_sub(ops->func_hash->filter_hash, hash);
> > +	if (!filter_hash)
> > +		goto out_unlock;
> > +
> > +	new_hash = hash_sub(direct_functions, hash);
> > +	if (!new_hash)
> > +		goto out_unlock;
> 
> Can this leak new_hash?  If hash_sub() succeeds for both filter_hash
> and new_hash, but then either unregister_ftrace_function() or
> ftrace_update_ops() fails below, we goto out_unlock without freeing
> new_hash.  The cleanup code only frees filter_hash:
> 
> > +
> > +	/* If there's nothing left, we need to unregister the ops. */
> > +	if (ftrace_hash_empty(filter_hash)) {
> > +		err = unregister_ftrace_function(ops);
> > +		/* cleanup for possible another register call */
> > +		ops->func = NULL;
> > +		ops->trampoline = 0;
> > +		ftrace_free_filter(ops);
> > +		ops->func_hash->filter_hash = NULL;
> > +	} else {
> > +		err = ftrace_update_ops(ops, filter_hash, EMPTY_HASH);
> > +	}
> > +
> > +	if (!err) {
> > +		free_hash = direct_functions;
> > +		rcu_assign_pointer(direct_functions, new_hash);
> > +	}
> > +
> > + out_unlock:
> > +	mutex_unlock(&direct_mutex);
> > +
> > +	if (free_hash && free_hash != EMPTY_HASH)
> > +		call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb);
> > +	if (filter_hash)
> > +		free_ftrace_hash(filter_hash);
> > +
> > +	return err;
> > +}
> 
> If err != 0, new_hash remains allocated but is never freed.  Should the
> cleanup code add free_ftrace_hash(new_hash) when it's non-NULL?

yep, that's a miss, will fix

thanks,
jirka


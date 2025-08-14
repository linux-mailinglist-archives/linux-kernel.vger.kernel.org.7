Return-Path: <linux-kernel+bounces-769539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5C2B2700E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7BA167A77
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C312494FF;
	Thu, 14 Aug 2025 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O99XWpzu"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2716823B629
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 20:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202281; cv=none; b=ql0OpGeYhD/mo6LwLglkXaGWc3ku+iymYwfsJn5FiBitOxdH5tlBkzBiVTCkyf9spTGViAd6EfYAXl8fwr9mOBL71Q6MMCGjiue2TkuJyaS8ahh8mO6Ng+s06sABlCgqg+Jj3f+sVCLir9En1uSJ7GlAUA6bTJ2Cslpa4pRtZ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202281; c=relaxed/simple;
	bh=iWez+dKq0W6SLolnZkKF+q+WF+8+Org22NX0pWn1muY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7gsoXTghgrrIXcBUxB6n4pPqWQkcfgrviOqPNrFx5ne4f2eCAJYTz9gukq4Xa0yWl04kpiJfCLBMy3b+bS1b/5XJFfETkGltRcmA6w4UeIjJUXMS4WWH6J87/8KVnQjFCbQnYtfQyraxNr+5C8GDMYMi8B7xgIWzHnRhocBO28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O99XWpzu; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e931cae27c5so1413458276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755202277; x=1755807077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqQpJ45auHuyENf7Xrb4hjMMbZo4/kym1zJWi/LJlxc=;
        b=O99XWpzur+gGY/vosz7kvnoe9fh1UJdsRdS+oBG1z7+6z/hX1fEJjdQMmryT8S+KjR
         Dk4FX/HSy64VjXN2sGY6GA6SQn5wGEXNo5Q0P0mTA6lBm3vK5wxdygWbZ/EguaDzi3W2
         hOHQW7d8YAaVODyicoRClBTWDAd+JSkuC2jfVEznvZT9IxX9t+2D2NDOT1ojHh2JO7Cf
         Cey8xF+DXneh5Et/wpAo6wExjw32nrAPO0GoqvA+2u8UQ3OcROQgLc8uMDIQIJzTBf12
         nkGytdF2c0OtLNc0OHn3loslzbb5xrKiqGjUNXDG8qFTv7cEdQSmyJTXx3ruSGoTWkBi
         GYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202277; x=1755807077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqQpJ45auHuyENf7Xrb4hjMMbZo4/kym1zJWi/LJlxc=;
        b=uh0H5qiaagxMuxtaugnJh5vqxNuXWGMik/HacwViakBbEq+jfd6vhvtP0nEGKhtLjt
         FcV81CpZJvkpQPKIDbnW3Y7N3Na8IiBqLmW7ojLMauZrry8AuOIwQCK+Q0D6Fk385DPx
         ZMQgUJ9+AkwzKWPIYmw01jxrZwr69c3iJGp5xMiuPxkK/Sxw1J1VM7QpmZRCayU/YqYv
         AV1YBbJaYmAqppFnW8nCKPInP7xpXtpXVuWGXVSFOEvdCbtNUslYJU08ht3KbCj9easJ
         BpBf60WEQzW20S4OWhsA2LHCURngOoL90c+AlCkPTfTVk+BL/WA5SP+cilsDiGP5jycQ
         hLOg==
X-Forwarded-Encrypted: i=1; AJvYcCXEnbsIzpmK1vplGG2cqRQx2Z1e8OMy2OGFkBUvf4Sgo5s6FBJQek3+NvbUZ/Cx2ZeFd6GAN3PjCLJMTuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyejGa/OglCUnk874MCxVpOQ3tG1PcYn1bnW3hb+V9OmJMr+Jv9
	5kFuKRz0gOOWSa6JsPaMBjJSKHTW67qkDhIrH/gv1p66eta5p+ldFScy
X-Gm-Gg: ASbGncsSU7U15+XoFMGn2qV37E6mRSXpquP0PH3ArAdHeXF72gvvmAeitXvJhNchbL+
	1wvWJAq4YCWsR4Xf6cKkEpLLms4VGe+lCyvCLGCoFplvAFApQaAYhfgQYibeddWRcAjNV1sURUp
	3PnqOff0wxXusBvYyz3ixrHCdcPgL/XPoxvw5oCN3s2AZv0MzgGy5SgS6BwU+fhpQlP9D8By2ym
	2aubuct4nyDsfD27Ie6AS8yPpy8TcsDdgmQrl+fYvs7NxlGdUp604onI388syMso7aIC2TZUi0H
	dia4x7wzWY5/sbkBJYvnuCCuqnQGLJxFBu3lTQgv9hIcrTOktWecDXtE1bjsQ/A42Cw/BlXBmvO
	4OWHvVqEw6E/bWB/MDoBi
X-Google-Smtp-Source: AGHT+IGZ4r+yBtbQRfO+KcqX023xsx4kj8P3ukZFnSPGCzjXMXe4Xf7eM+FXEVmJxWIT8IPWpDPdRA==
X-Received: by 2002:a05:6902:3485:b0:e8e:1e32:c2ac with SMTP id 3f1490d57ef6-e931e163b31mr5382666276.16.1755202276774;
        Thu, 14 Aug 2025 13:11:16 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e931d447899sm879567276.9.2025.08.14.13.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 13:11:16 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [RFC 1/1] Add memory allocation info for cgroup oom
Date: Thu, 14 Aug 2025 13:11:08 -0700
Message-ID: <20250814201114.1921580-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <790da5ffebf18a5a1211ad8dbe4e5b4a19871408.1755190013.git.pyyjason@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 14 Aug 2025 10:11:57 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:

> Enable show_mem for the cgroup oom case. We will have memory allocation 
> information in such case for the machine.

Hi Pan,

Thank you for your patch! This makes sense to me. As for your concerns from the
cover letter on whether this is too much information: personally I don't think
so, but perhaps other developers will have different opinions?

I just have a few comments / nits.

> Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
> ---
>  mm/oom_kill.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 17650f0b516e..3ca224028396 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -465,8 +465,10 @@ static void dump_header(struct oom_control *oc)
>  		pr_warn("COMPACTION is disabled!!!\n");
>  
>  	dump_stack();
> -	if (is_memcg_oom(oc))
> +	if (is_memcg_oom(oc)) {
>  		mem_cgroup_print_oom_meminfo(oc->memcg);
> +		show_mem();

Below, there is a direct call to __show_mem, which limits node and zone
filtering. I am wondering whether it would make sense to also call __show_mem
with the same arguments? show_mem() is just a wrapper around __show_mem with
default parameters (i.e. not filtering out nodes, not filtering out
zones).

If you think this makes sense, we can even take it out of the if-else statement
and call it unconditionally. But this is just my opinion, please feel free to
keep the unfiltered call if you believe that fits better in here.

> +	}

NIT: Should this closing brace be on the same line as the following else
statement, as per the kernel style guide [1]

>  	else {
>  		__show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask, gfp_zone(oc->gfp_mask));
>  		if (should_dump_unreclaim_slab())
> -- 
> 2.47.3

Thanks again Pan, I hope you have a great day!
Joshua

[1] https://docs.kernel.org/process/coding-style.html

Sent using hkml (https://github.com/sjp38/hackermail)


Return-Path: <linux-kernel+bounces-868171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCACFC0490C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC611A62ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4944525FA10;
	Fri, 24 Oct 2025 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PlTw5qoT"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A9263F4A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761288654; cv=none; b=NJmWcQen3cX7QY8P1nIu2f+kg82Hyd/7wUc0DrEz0bjhnH7/VQF/EMWlYOr+SV618R30Fzt+gsRWaULa5w618w2cT7+gH+gJ2Tncfs+a9UbfsglvliNE7/PAIJ+D6viiH2N9xQWs9mz4WvDAd4QqFqOrnXqnhXRMf7SEs7qgfOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761288654; c=relaxed/simple;
	bh=gNJBLOaDB8XjEP7AnjsKksq0AWMpniJyz3WgFUGQArY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkKmp4bIMYA66sjZVhSqSROJROs+sTuuK8CwhfipMyDT1ZxNGjeTa78IFk+xTpYVK4RuVUT39vqv+sSo/uMbxdyU7xvrJdlLyK7aNsWLOu6MuP1rd9n1Z7mOos7HN6+iWnFSP3QKPq0Ey6io9tLByPGxveLoz/Yujszrhs7SQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PlTw5qoT; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47106fc51faso21286175e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761288651; x=1761893451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTVHW40Zh+ZcYW36HL4c/rT2R0nqusYCaOB5DUxW5hs=;
        b=PlTw5qoTHtlQLUdH9VQuIazcx78CQZhjMAe1qEfedhSTgCpebUjKyAXwmMtzTcrrBT
         W/FKeNsN/i47gN43cY5qXCuO5J4MrvqUFO/obkByR+szYbSvpw66q9Vyi44C5BBwKmb7
         8gCspOMZkUIPgGXOMNP51EZKNz7zUigzgvp73CIStmhCyctwItd+ALAy30geNlymivl1
         H9U2oTThmtxYlq+KZ+Cr9HFzgP1Uyi/+kOjgjXhElW8FTi0OEGhBTCLwggYsZ6j+Bvvu
         F9YV7ugxFelIL0vVYJUh71RrS0+NL/bIN5Z5dQFtiu9knZhc8L6Grmo/p4rFyn+nJqTy
         aQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761288651; x=1761893451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTVHW40Zh+ZcYW36HL4c/rT2R0nqusYCaOB5DUxW5hs=;
        b=AHUZi8WBHiQwIgLD9Y17rNDBFRp9YEowDFa0qwS0+XvjO1180xqCHrawHnJlgpzBCC
         SBU/4BygZ6HJp5LOVUsEGi5Ky01RcR78kjQxNonc3O8iGNJyWTJ6H+e1LxFMIM+9hVom
         tVx2luq35nEx/lyKJ8f08kNzYvkkdWqIHqjXIWg02quWPMwNz4ZdZwaEHCD5C79l8E3E
         ejayPwjWNzOEGiC3Nnhkn5u2iqYZtLeR/SE4qxRVIq18tVkSwGkbbvx/ctkMxP+PMkkS
         nDEosEZVSIKKOVEDyZYVyS2oCGEWSKLiZab8aKgsTvfBnbGJ2mbrc/9Gh/s8opL+lZGK
         yF+w==
X-Forwarded-Encrypted: i=1; AJvYcCWJ1UcCc74DEfWI+YSsXQz597LFHKDATYvWqaSqgDkMi5jwPI8SfifO6cm4/TeVD2Gapfdz3LssC9ZGeZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2YTZJXNsRJ+/bEEWqWoekPzLUPs7DVEChPQ3slxcQLfRX9vZZ
	70SzIRqr6nZsYafKHu1l0YsiF2GPbPd+PKXrGu3gxgqmDYcp0BmPvfyOD7KN7i4SONY=
X-Gm-Gg: ASbGncvtYk6/UV63nOsbNZGNUT1OtI4DTH3D9EiNsXMWJszccMoILMA/oL/BITPzrxk
	z0D+ZzDyxQeQqvqJLQE5FX/LSw/q+9Dc7gGVrx1++TVrYbNXhU+BUqWT5VK3dBtFLGFJkqxxXyk
	x7neH0o3rw/016pDI2Fm3TmZMhgJzkJJCV668sKU2HkHv8MfqZeFg0iDPXAr0Futcg5u0LNn/2u
	qSl0XeCy692SXXhLlJIup1GDi307YoRjOmn1+gZGHzn6BbnrXLdCeMGv/iNm34MnHbitWnwXZ7c
	sxiUQn0+VS9+sL2feru4pkeuoPOsnqntw2m6VYslySZrFVbERniCSAixp9HzFyBHfYsAf85AmRv
	NOtrfAtMzRPVdvD2iAMWwXtoV/t0KiLRVSe3aD05C3aZnZIUEzMcoyWhCvBRlZMV8wJLcMfmNDg
	S1ot7meD9YyVI=
X-Google-Smtp-Source: AGHT+IG6AHY5dkgO0Q5DKGmqzwIVnALLho0wguGOP10IdFFJoATiZ5dycE/1wRVFF3VxetAiLmfC9Q==
X-Received: by 2002:a05:600c:3b03:b0:471:6f4:602a with SMTP id 5b1f17b1804b1-471179068f6mr191913555e9.23.1761288650660;
        Thu, 23 Oct 2025 23:50:50 -0700 (PDT)
Received: from localhost (109-81-19-73.rct.o2.cz. [109.81.19.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f685sm135434275e9.2.2025.10.23.23.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 23:50:50 -0700 (PDT)
Date: Fri, 24 Oct 2025 08:50:49 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: manually uninline __memcg_memory_event
Message-ID: <aPshyb6okUnRMZQL@tiehlicka>
References: <20251021234425.1885471-1-shakeel.butt@linux.dev>
 <aPorFhxQc7K5iLZc@tiehlicka>
 <jnzfiyojjwvrj3eemqmpigfyjxucdqe44fjy36nxkly6urtn7u@a6pfcppla3r6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jnzfiyojjwvrj3eemqmpigfyjxucdqe44fjy36nxkly6urtn7u@a6pfcppla3r6>

On Thu 23-10-25 14:35:05, Shakeel Butt wrote:
> On Thu, Oct 23, 2025 at 03:18:14PM +0200, Michal Hocko wrote:
[...]
> > As the only user is in tree should we make that EXPORT_SYMBOL_GPL
> > instead?
> 
> I just followed the file convention i.e. all other exports in
> memcontrol.c are like that. I would keep this as is unless you have
> strong opinion otherwise.

OK

-- 
Michal Hocko
SUSE Labs


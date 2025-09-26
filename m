Return-Path: <linux-kernel+bounces-833661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5070BA2956
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F2E1B26CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA20B27E07A;
	Fri, 26 Sep 2025 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="flTsrTHt"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4002AE8D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758869756; cv=none; b=OLuEm2sRFHBflbANbOAOrINwzU8GnNHK57+gfna/DJAD/RvJ41WIV1KFPTBmyYfw//ZJLZ7mv6cDZe4un0BfTl7de2n2Dge/Ykz3wkEvPMe+wrS9qHJirP4ckZyfuyQKhRNym883Ps33nanY8yVmRhlilanV3XSBnWcpMbiBLjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758869756; c=relaxed/simple;
	bh=nFJLNEkH2IX3YFhOiDo6hqrynaMOOlsQe69wzghy3rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYPluCVoJzCYc2oEPVKmqp2RpuERIR3qoyAm8RdX3NAHiKWtJZfnz80MUb60dMqGTEikqGVC3Fw8tN6OxqVqBR3BtCmN+uFXHGI58Q7P4H+nJiLgruLJEWIxEKwGIcDrnzgmzGjED18AWWfIvYmce8ULyHw89mcwCMZ9NgffI08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=flTsrTHt; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b2e168f0a75so318347966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758869752; x=1759474552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yFDpZWjJo+MAyxTSC4DRhbNn8DKisYpUFIU01KiJ2vI=;
        b=flTsrTHtwyymvsqoDw7RbJ/RGUTxfbohI7uvqSpB7SA9k8LkX3BPTtnpxjEe6RdMjP
         +OWOCGICOJ8LX6kFUECKvNUTs4jbOSURk4G2Tj87Fv0zYJYtnDYeodkMudtIKVVh6SEW
         8nICFMCS1nn7VOR9nrW9xM1iL9h5g/bns0/6krBziFzCQOJVJ5llNCvmyNeGElvjKb0H
         ji0BNCTlSgcXZM/U3zJHm51ejm8jKOd1XO4vKhzgxaksGmLMS1Ba540bPPl1CWQyJdtC
         TUXm5yRkeT7RW7AvXHPygVHUXcmUCjdSjcZbvlqiU7Wy89iLPkmh+H6bOBlEB00FlZa8
         Jk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869752; x=1759474552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFDpZWjJo+MAyxTSC4DRhbNn8DKisYpUFIU01KiJ2vI=;
        b=FB5TbwOQNtOjsk38EFjY0k8pTn28rrCWMqTO3eey3bJHAlkptY4ugup9d0cXh6XyzP
         FXLwzIQz+ymGDA9p9ab3CRPtUUfIG4SAwkZjoJGa4eU2JAtcBPfOR3kd3fuWF4JikKBm
         7SBgK2OKZvVie5GZPeTPf3oGr22kYzIHspSA45I1ieM6wBblLzzins0wP8OPKsTPJ4ph
         BtiYRmKzrMK0FoykxayXXnUda41p4LkUU/ORiKsfW7CWY/w9nmp/UcuuEGsiO6miJpAt
         V1XQnrhxXPSuJOYNbNKHz6kZ1tLOwTX5S1waNb+KD+XRusSxh7AxQI2txBykh6bhNJR5
         5wuA==
X-Forwarded-Encrypted: i=1; AJvYcCWqVHQt0glXut1e1FhZW36Jcs8vj3N3DVb5fgFI4sEVMjtGib9CibV4irrgzzORuLU2kfxwMpARXzyZ2O0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhLPKsw8To7zYoYwY9JhBIlvN1al/dbpImkNq67kCgJEJBrg0n
	4JHj5fFm+2qV46DMzcEm8I8hubPq70zV9caQ5+IKy960a+DivjG5/uSBdqgxvbdLxIs=
X-Gm-Gg: ASbGncuV9EpA7XB9HJe9RAbifiHgmA0lSpZLOMtA0jlyxIWH9RwFJpyxU+tDmyWFWO9
	uyxkZQiI+GIvqRhk5kE03DjXCEEz+8OLNoFTx8QxEmR/dFZQ+9E4W8ANudSNfcFx+vMcTtinh8S
	OMu6IuT0GghVDCcFE96unE2mki17ycRnO+4zFRwAHved4CtUE8Np1Vxm21dcFeCPWEu33oCx6id
	HhGfJPdD1ETgsrt3uInWUXSp2X9hjy/M1V2UFHyJlefPQGB1euU3kx4dw69+xKK1xHiWT9fY6Yp
	OkvrLwm4/id6I9XVJHkOw4Uc4C3V/2KC2pAK1L3OolsOlh8a4NVG0IHOB7lgXcMEODbSPHeAG10
	DmxsV/4a1OOBZQIY3RZdJ57tOx0GLHL1aAWGSYDaHC7T5
X-Google-Smtp-Source: AGHT+IHgyGHYORuYwlYRUngGDj0p7gh2gMef0eybT5e/qzeN9cCCuM8737g/O3hSnQVg25LntY5HQw==
X-Received: by 2002:a17:907:9447:b0:b2d:28fd:c6bd with SMTP id a640c23a62f3a-b34ba450e21mr629911366b.36.1758869751875;
        Thu, 25 Sep 2025 23:55:51 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b35446f758csm313713666b.53.2025.09.25.23.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:55:51 -0700 (PDT)
Date: Fri, 26 Sep 2025 08:55:50 +0200
From: Michal Hocko <mhocko@suse.com>
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH 0/3] mm/page_owner: add options 'print_handle' and
 'print_stack' for 'show_stacks'
Message-ID: <aNY49sdoFVe03m_Y@tiehlicka>
References: <20250924174023.261125-1-mfo@igalia.com>
 <aNVpFn9W0jYYr9vs@tiehlicka>
 <4c2a467113efd085530eb055e4a4e1fe@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c2a467113efd085530eb055e4a4e1fe@igalia.com>

On Thu 25-09-25 16:38:46, Mauricio Faria de Oliveira wrote:
> On 2025-09-25 13:08, Michal Hocko wrote:
[...]
> > Could you elaborate some more on why the performance really matters here?
> 
> Sure.
> 
> One reason is optimizing data processing.
> 
> Currently, the step to obtain the key of a strack trace (e.g., hashing)
> incurs
> a considerable work (done for all stack traces, on every sample) that
> actually
> is duplicated work (the same result for each stack trace, on every
> sample).

OK, that was not really clear to me but the above seems to suggest that
by hashing you really mean hashing in the userspace when trying to
create a key so that you can watch memory consumption trends per stack
trace (hash in this case) without post processing.

Stating that more explicitly in the changelog along with an example on
how you are using this would be really helpful. 

When the interface was originally introduced the primary usecase was to
examine biggest memory consumers - e.g. when memory counters do not add
up to counters that track most common users (e.g. userspace memory, slab
caches etc.). In those case you need to see those stack traces as those
are giving you the most valuable information.

I can see you are coming from a different direction and you want to
collect data repeatedly and watch for trends rather than analyzing a
particular situation. This seems like a useful usecase in itself.

My main question is whether this should squashed into the existing file
with a rather strange semantic of controling the file content depending
on a different file content. Instead, would it make more sense to add
two more files, one to display your requested key:value data and another
to resolve key -> stack trace?

-- 
Michal Hocko
SUSE Labs


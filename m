Return-Path: <linux-kernel+bounces-878128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5EAC1FD9F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B338421E93
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11179334C15;
	Thu, 30 Oct 2025 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D0IKrB+Z"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E17223D7E3
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824177; cv=none; b=IBuCz7SoRSyM6yr8Melf8ysEaACCCvWkxbbMweoeB+1SDAdovbfQ977386Xi9ZUCU1xTOZS875Qha5zNV5ytlmukcEl7PKxKVh1bENEMLiW99WxTuh4KSwNCqdxjCQ4fh2D3akxGmBIqCVQcWqur6xCgBZjjh3vEiWEyLrXgze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824177; c=relaxed/simple;
	bh=JU2RzdzNoNinIbpfBD3TA9Hnte4P5nV8fq1kuymzG2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OnLzA1P99Mcku0HdJqk1yed1uKtPDWzfQUDmnuGgWUwUqnvjJd8xZTxPJwYzvwEWgpMH8crYM+NdiX1crt8VPfJMwhNA4Zn99ytguINwRKVC5WlHghV7jPz9OGWuGKcW26SvMGBY6JJvI02jFfFf953U3rBFoZ0mxByRuNZnWlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D0IKrB+Z; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b6d5f323fbcso20226366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761824174; x=1762428974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bK+xN2oi25pfNhkbHeqP+Lhc4lHkzppS0DihgpAOqTw=;
        b=D0IKrB+Z2g0nUremVjv2tCgCHRhGaluKK3qrHwJKIvyOUTPZBWMMIfbzals7I0hnjv
         LQV54KEFJd0pXkUP+c5gt+Yw/3U9Xvheu9NagUUYRnqzK+3feaD1vJaTEteGRsPLBueB
         cSSvdPya6Wu07fkayWFjQLwMQ93gEhGQhleRaYwhk6EDoM4Llj74Z+g1Kq4sqsHzvlve
         uilSKIVaB1xL25RIownFD+P9bxXIfuSPpbNy/Ls9tEhMqVSpYMB8QCZ4I7/PdRImIkAq
         Lu83m29xe5Lli7JweiqVhoGsbXOmA7YYbIAgVQZ1cL/FyPTNF3Q/yXq51OlA91BQ2xIC
         Bm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761824174; x=1762428974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bK+xN2oi25pfNhkbHeqP+Lhc4lHkzppS0DihgpAOqTw=;
        b=MoYAuxbheqSuhg2lkKkCoXoH4Jr539oiP9nBQi07EGgW3LDng8KOlYEG70SbW7S80s
         QnLQsVBr6BWGPty1THQ2X0SAl6vE+x34prSt1QmnHJPbLKG5xsblGcb19jOtTSGQhzkC
         Xyp0Hk6FMkjP0bouVbHYrE3HmouAhbFkECD3J+xcztmSpe0fRpeGkwMF62VwdPgozYTo
         n0Ktso0hgv4c6FYlHkI18hITGUkn6fF0Pd/qL+VWcQ/AyQuRfmPf1amLkmcA3jnLH47j
         JhGm+YPe+8+Nb6gKParnkcWKZkbCS9h7BtFvxLGD8as/VkDuiJpKTcfmOUYDcvgRh2uH
         T3mA==
X-Forwarded-Encrypted: i=1; AJvYcCUKbBad6h9j/yKvwP4CQlJejsUKl73BBLwoUDu6jfcY6La/wmH1iDNWWaHDBTKFncEcp2VVW1SZ786xC0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLy+LCKB6UcKdhv186YJoAus9aJ5w7fTfQBWoRour4cWtYbe4
	tRaHa6BtVkryLJV0eYIFHdCk3+YKUgoBPftCxXvIQoIOyl4gm1vNU3VOGOwYKYUh8NY=
X-Gm-Gg: ASbGncve7j5rpVvYDll9bOcxkmYERmJOuPE4jsGVMWu5+oWXFrytkPPRz8TLU8ZTvZR
	D/WnNpjtYchIY5oP92wBVkD5ep0a6W1TXxYO63D5GuY88UMS1XML542R/iYHUGCojG+vb5jeWvp
	MxniiHOsDC2+yfNBhdO5edtQNy4zXdROc4QSXvZ2tridrzSFPcGilMmlCyyyOM9+tqjcwfqT/CP
	uwUWC4ADKkk55VguZ4Y0ePJV2/6hHl4niB20MvTf/X6kJz2eNqsWO+wuNMdEUxaydBNoqvIOGyP
	6QUb9Z6n1D5hgQOUwQsk+SzJEYyx8Kzo36i8nywRlO6UziDX3c0l+gnymjc0IEiVLGFbXZHisi+
	/iEBH+lIsId/OE0N+ycUlvaF51XWjNKzsnVkRXsLY8i+neZ4i3WFN1gO5GSBjfn2G5hPTceoKC9
	iGQ7zzWxiWRhnQ1KUb4kq5GuznKS6mM6mI2iFNc61FywV+7rfjJ+WFqnGebN8jtVg2NA==
X-Google-Smtp-Source: AGHT+IFj9ZpM2DdqZcpwsXqHdAysTt/TBVGsjkwzkXEBmVWTbZUal3znf8YBaAwZI6eMSQW9iDxpEA==
X-Received: by 2002:a05:6402:518c:b0:639:e56a:86e3 with SMTP id 4fb4d7f45d1cf-64043f48007mr2792028a12.0.1761824173886;
        Thu, 30 Oct 2025 04:36:13 -0700 (PDT)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd116asm14938765a12.33.2025.10.30.04.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:36:13 -0700 (PDT)
Date: Thu, 30 Oct 2025 12:36:07 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] slab: switch away from the legacy param parser
Message-ID: <20251030123607.714bbaa7@mordecai>
In-Reply-To: <2236fdb6-4616-4b9f-82c9-eba3ce5d371f@suse.cz>
References: <cover.1761324765.git.ptesarik@suse.com>
	<2236fdb6-4616-4b9f-82c9-eba3ce5d371f@suse.cz>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 16:06:21 +0100
Vlastimil Babka <vbabka@suse.cz> wrote:

> On 10/24/25 19:06, Petr Tesarik wrote:
> > The handling of legacy __setup() parameters has some confusing quirks.
> > Instead of fixing them, convert the code to struct kerenel_param, which
> > is a saner API.
> > 
> > Note that parameters defined with core_param() and __core_param_cb() are
> > parsed early in start_kernel(). Do not confuse them with core_param_cb(),
> > which are processed at a later stage.  
> 
> Thanks! Added to slab/for-next

Thank you! Appreciated.

Petr T


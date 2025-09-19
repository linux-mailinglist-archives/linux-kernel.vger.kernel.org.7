Return-Path: <linux-kernel+bounces-824776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8349DB8A233
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4935EB614CE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644EE3112C2;
	Fri, 19 Sep 2025 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj0x2aZa"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AC4315D43
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293888; cv=none; b=i5eD8/Sr8VcVTbhrHGLi0OGb4ovxDah0UZz8IqkGFG39b+G8fzRy8f88K6q8ZH4wvgfRevnczSqmybnxqE4BS5y+FIerewD4AO+rTfafDqH+p95HeTvGjkj1cI+4hDR2nI6x+ZKqttFaLV8sH2aVLtueT0qQO55vg/kpV7YttPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293888; c=relaxed/simple;
	bh=Py4GUmZ87SApJfwJMPgZpB/eV2Lr9AROagLar1KLjmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uz7HOHW28TG7C+lZY3YFA0tQ6q2eVOjxVq5/lbZcMcWUovHOMhSy2IEa3uHDgf40m1/V3cUbsnYV8hEw/Q+17Wtf7F2gZsck7XnNlLEGW2d3KVwAXGiq+1vUR3PXsV4yP6JIUV9H3gEjcxtzNO6LhtWzEKciNGNyIYhE+oql5HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj0x2aZa; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7724df82cabso2741321b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758293885; x=1758898685; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AVKp3s6W/4GIBYjxgJWs6/EpdsSodFQo2wJl36RQSj4=;
        b=Yj0x2aZa+7bV8fZQ7xIdgApzTKXfmULu5QrVxatquaRDOfRI4e1BQy2zq3k6AY4YLA
         t/x/yxLsAnkFO06XpESmN1bEsVJbkY89p6NhndU29juSAa5hD2zIdfu0icuuIpPId/Ag
         gzc1PjhiMioxE20eepoNtZllvkMVoVo48R4DlwGuGJOXcxj9/HDQSJ59XWAna+c1yquD
         YxWvREr6YCWMg8cXcP1pypWEpBKSmLwNLeuQc8Zr3Dcke0AzufeioXQY4s76BbguwWYI
         vLCh6MpfqLR4e1chRpupYMEyyue+gTZ0yTMbePNJ6IMFQXnCVbzmx56/XZlpzlDaM0jI
         N7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293885; x=1758898685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVKp3s6W/4GIBYjxgJWs6/EpdsSodFQo2wJl36RQSj4=;
        b=Bfi407OilqObYiX3oMba3ARwI1YjgeW3ymNkQACgiGUAZUQ/Mew/youIvwUXUdi50Q
         bJIVn/RAtT7EK88UDFfwVQQ/ySCxDiXRJQoebX68Gl915v4BTnPIh1jLcWmFNFrToj1r
         46yRyTdF7X3pduJvSgYwoY1risbu1cb12sgiY8zPOlpqCwDLI8zwkF3C/rW4nbbauOqg
         SUf8dDW49s3dVdROSKM3xWq1/UBFkjRZtG3GeWT1ieOxeP+J+cvTKa4OeBg0fjb10wDJ
         aMzpncMACNP9XXNpccWWOU/Jq9vNzCl5SL6DuHpCTN9AKTabPwVbgm5tpH7iBlZ6B0KZ
         brlQ==
X-Gm-Message-State: AOJu0YxD+OT3JhMmAcW088Lpw+xc8rp3V+pQ9s84dK0IxTdRlQVvGQ9Z
	wErYoP2FlnHWAeFFm+Y0T6OdZ7EYH7pBIzkXuwFzuAwssxAj6NzpZu2bJTZFsw==
X-Gm-Gg: ASbGncubHY1IwhwWRuG5+RwY3UvuG5jfSk1hPPF7wOJCduCbtuJ+AzgRPHV4E2Auqjz
	WXDd3mZQ9O37+ntkr5ZqF/VtO8g41XRKCUe8RK+ZbqJqDhUv9kvuQsq4HLzg0jZHdkmMmWbZdLu
	6yZPUMXstNaPAc76Pf+UDY0zNyKPrzXXL9kNMMoO7iH1GE7dUJZq7wzW4PlWHrZPQnYEnn5u6CW
	WRvLtxziN8M0E7cPfOUaPF8eDTzw+gy6oZgSti5fMIICxvSdyxNXaq+6wEKCmjjdG7ztr+iQ1bo
	VdAlCXu1NKSR6ZOom1NrGOi6ZW5HukDDXwLZ3PLaERUz0on6zCInyWpcFzi6OfoUVRAOTzHPH/G
	vHZVpb6/yJsyh+ukb7bfuLg==
X-Google-Smtp-Source: AGHT+IHLEqBp7dm5q/kj0V0L0zK/QU8kml6mIhwRXPd6XcM+Olgk1aqn1/gtwDOQ+4Z8YRYvaLpkjA==
X-Received: by 2002:a05:6a20:a11f:b0:250:f42d:84af with SMTP id adf61e73a8af0-2925d0dcf8fmr5663999637.3.1758293885261;
        Fri, 19 Sep 2025 07:58:05 -0700 (PDT)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff3750e7sm5078648a12.17.2025.09.19.07.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:58:04 -0700 (PDT)
Date: Fri, 19 Sep 2025 10:58:02 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v12 8/9] cpumask: Add initialiser CPUMASK_NULL to use
 cleanup helpers
Message-ID: <aM1vcBuOSh8OV7mN@yury>
References: <20250915145920.140180-11-gmonaco@redhat.com>
 <20250915145920.140180-19-gmonaco@redhat.com>
 <aMg5EzmxG3hG7aJK@yury>
 <820443ea-56d7-4fd0-9535-b1339e53240c@redhat.com>
 <aMhcYCCJDFWoxcyw@yury>
 <aMlJqDjWNyak07LX@localhost.localdomain>
 <6aeda48661359eedd232c9bb0c337d93c36dae70.camel@redhat.com>
 <aMqdzQcwvkjl5WNA@yury>
 <1d15af4ab9f8f63dafbf4810a76eb3d547217596.camel@redhat.com>
 <aMqq6zr7_dJveu3o@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMqq6zr7_dJveu3o@yury>

On Wed, Sep 17, 2025 at 08:34:54AM -0400, Yury Norov wrote:
> On Wed, Sep 17, 2025 at 02:08:06PM +0200, Gabriele Monaco wrote:
> > On Wed, 2025-09-17 at 07:38 -0400, Yury Norov wrote:
> > > On Wed, Sep 17, 2025 at 09:51:47AM +0200, Gabriele Monaco wrote:
> > > > According to what I can understand from the standard, the C list
> > > > initialisation sets to the default value (e.g. 0) all elements not
> > > > present in the initialiser. Since in {} no element is present, {}
> > > > is not a no-op but it initialises the entire cpumask to 0.
> > > > 
> > > > Am I missing your original intent here?
> > > > It doesn't look like a big price to pay, but I'd still reword the
> > > > sentence to something like:
> > > > "and a valid struct initializer when CPUMASK_OFFSTACK is disabled."
> > > 
> > > The full quote is:
> > > 
> > >   So define a CPUMASK_NULL macro, which allows to init struct cpumask
> > >   pointer with NULL when CPUMASK_OFFSTACK is enabled, and effectively
> > >   a no-op when CPUMASK_OFFSTACK is disabled.
> > > 
> > > If you read the 'which allows' part, it makes more sense, isn't?
> > 
> > Alright, my bad for trimming the sentence, what I wanted to highlight
> > is that with !CPUMASK_OFFSTACK this CPUMASK_NULL becomes something like
> > 
> >   struct cpumask mask[1] = {};
> > 
> > which, to me, doesn't look like a no-op as the description suggests,
> > but an initialisation of the entire array.
> > 
> > Now I'm not sure if the compiler would be smart enough to optimise this
> > assignment out, but it doesn't look obvious to me.
> > 
> > Unless you were meaning the __free() becomes a no-op (which is true but
> > out of scope in this version of the patch), I would avoid mentioning
> > the no-op altogether.
> > 
> > Am I missing something and that initialisation is proven to be compiled
> > out?
> 
> When you create a non-initialized variable on stack, compiler does
> nothing about it, except for adjusting an argument to brk() emitted in
> the function prologue.
> 
> In this case, non-initialized struct cpumask is already on stack, and
> switching from
> 
>         struct cpumask mask[1];
> 
> to
> 
>         struct cpumask mask[1] = {};
> 
> is really a no-op.

Alright... The above is correct for optimization levels > 0.
With -O0, 2nd version really makes GCC to initialize the array.

https://godbolt.org/z/e1zG4K7M8

This is not relevant for the kernel because -O2 is our default
optimization level (I'm not even sure that -O0 is buildable).
But you may want to mention that in commit message.

Thanks,
Yury


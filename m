Return-Path: <linux-kernel+bounces-855346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC36BE0F88
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 00:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1477C4E1587
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0C5314D3B;
	Wed, 15 Oct 2025 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgiPusAT"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026C3081B7
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760568380; cv=none; b=cZz4vVucy4F5bpWskH2rfwi9wpwtdR0hIqXOazYRD6UfzZWHbC0qLCKuJQ6lYYLJovQGt+Jul479fWsi4Yq9YlqibWhc3HQ6/OaiSonagw2vYJZ3sw+J1Iy+e1wrSCHY8C7MWxAx1Dzf4wT4Nf4z+di8nCfwivQ4CNZOD6Bw04A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760568380; c=relaxed/simple;
	bh=gn+jrn4+7QL3Axwt5qY/3ILmL/rIrIqQI1AE38f9NE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbqXrSAh90j0pqgyHWaWmjE1CvH3NUfzp1Ik2jEgdBLaig6VrNVXSsY7Utn+STvBx6yIdExYG2DYi7oomw225qLn+56T3SswufX5Gt/aylNsFXGzLK0r18dg8vWONks6IxFyZMe9+JqORqMvYxM/uSG8cLGEEElI6Dh96/acXzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgiPusAT; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4256866958bso47931f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760568377; x=1761173177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LFKGoddm59QoTZnWfmZZLtnAiNTcYZnAo8RKS4lX25U=;
        b=XgiPusAT8KSHDeK6P+zgcm9mDgaHjVahyirDtpigJDdASvWwb3T3gMJ3onOhsD9QNf
         ShZzWpSfpI6HtW9td5PghNLRNfoA9bXDebChQbfmtiXEUfk2qrtdB7Nle56YZ/wGjc9n
         qTYl2++NzTM+YBXQEoxv8m54LZqD3FVoPT3xSd0s/caswc5bhx1oK7LHu1xYCDiY85tb
         qiLwwesAluS/UNR4k4uDuAw1ewVutJBcNVomeZxOYLLMvZQdTOEbTQs0kT+0eVDg4yN4
         h6DMMr5DdmIFDC+3ihJtAn1uP9C8JaXdtkNBgNMEzJ+V2l607CJrukrfFdgOpV7qDH1Q
         Ut6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760568377; x=1761173177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFKGoddm59QoTZnWfmZZLtnAiNTcYZnAo8RKS4lX25U=;
        b=LcE2vTdQ0slIYhF/ozRze2AjFXgMiffe3ZbYf5c7DAuEsktLQQ5r42oBYQfGOeAuV/
         O/gTo6LJ0olBRviZRUys45riGXlJEm911AJVhUZAPorCy7pGwzRQznzLFKN7rsCQgzLD
         7mPG1+7OFmKSki3kNVn2Uad3KsqMTxBXJ63k/FQoYODp6StnUDO6hFMeATWja35K/MzK
         yZZBWIuho0DD8egarxysTbR6m5CN8GZXWexPJlrw4VrRYlN7grEe29cvZhVYrv2KsLir
         a0/eOrdiFLqEB0ObWIPmRksAZ7Y62MFpM3tpayF/rc7s1SZpSqv0cK60DjY3wlf/Xeo+
         TtsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU736bsdWuq82KGJhs3c66KTXAM61pmH5RkvS7GePwfTuUIzyjuc4t2GRfgKpQyUMC9qymwr22FJGvPwmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQwLzZjqNGTd6PtmIEVMsKZ+d3DVm/tEH+ABJYkYKMacLtppcc
	8ReUtHJFPYpYMSNLqxPQaseErF+42XtkGJzmPgpK+dHsawWPAphN92ny
X-Gm-Gg: ASbGnctJKqLh6UcBy4UGphCftCnJpKfHwiwVnxnMh2slufL1QMr1CLIO62zJV1nMc+B
	8RGrI8ry18y56i1KGqzs/nJgfCD8QsN2kInximMOiMWvuDR+USjvEADq/nHoQtzqcibM3urx14s
	VM9We/9pewaFIMwSqwtn7nPY5TNeFc60Sy2ac5w3JofrsQYY8FOznY4l4Lk+qxbs1km8EXB+45N
	SQQWxoQhL3StwjAeMqrr9AODjEdX4xkMDzZmVwwAmsFbx0bnRX+83HGqtpz8Ni5m4KY0HQYWdh2
	QIWnnlQOEPoWeUdHgBx1MaTtUNeJE+DPCqCFvfzr4DKNQz+3ukNATz2Ftq+JDNwChOT7kaOJu/L
	MvlxWyGkZ9aQc3EKPA78VwCmoxT5iNfR7a+NucIiNylzavu0CLwLUTYPjPMj6IvW51EJNKQ==
X-Google-Smtp-Source: AGHT+IGDAo0cT2+uD/d095c1GDJkVJ/8fi2Txwb/AFql1WXRzzbLwuRU1peuUU2qA3ABNJ3YnTjhYQ==
X-Received: by 2002:a05:6000:310a:b0:414:a552:86b1 with SMTP id ffacd0b85a97d-4266e8e48ccmr20078648f8f.63.1760568376783;
        Wed, 15 Oct 2025 15:46:16 -0700 (PDT)
Received: from fedora ([31.94.20.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426f3fa3bdasm9095798f8f.46.2025.10.15.15.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:46:16 -0700 (PDT)
Date: Wed, 15 Oct 2025 15:46:13 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] mempool: clarify behavior of mempool_alloc_preallocated()
Message-ID: <aPAkNZDr_HAA_d75@fedora>
References: <20251014-mempool-doc-v1-1-bc9ebf169700@linutronix.de>
 <aO_taH9CKxmJPnhV@fedora>
 <20251015192717.HvwzCChE@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015192717.HvwzCChE@linutronix.de>

On Wed, Oct 15, 2025 at 09:27:17PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-10-15 11:52:24 [-0700], Vishal Moola (Oracle) wrote:
> > > --- a/mm/mempool.c
> > > +++ b/mm/mempool.c
> > > @@ -461,8 +461,8 @@ EXPORT_SYMBOL(mempool_alloc_noprof);
> > >   *             mempool_create().
> > >   *
> > >   * This function is similar to mempool_alloc, but it only attempts allocating
> > > - * an element from the preallocated elements. It does not sleep and immediately
> > > - * returns if no preallocated elements are available.
> > > + * an element from the preallocated elements. It only takes a single spinlock_t
> > 
> > Might it make more sense to say "It may sleep" instead of "takes a
> > single spinlock_t"?
> 
> May sleep usually refers to something that can not be used in an
> interrupt handler.

Gotcha. 

> > I feel like the fact that we take a spinlock isn't the important part
> > here (especially because we always drop it before returning).
> It actually is. A spinlock_t can not be acquired in hardirq context or
> when interrupts are explicitly disabled via local_irq_disable().
> Therefore you should use the function in a local_irq_disable() section.

As someone not too familiar with how the locking intertwines with the
scheduler contexts, seeing something like that makes much more sense
to me than seeing "it only takes a single spinlock_t."


Return-Path: <linux-kernel+bounces-820571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D383B7CFD4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8734A4880BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347E93451BF;
	Wed, 17 Sep 2025 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxhB8vrb"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2696FBA45
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109139; cv=none; b=XD72z14wqpSa8q7V7t54wY7wWvNkg87i0z1w/eViwfigoVcXkCYE1QrX8W5m5Fp8rn4zKpW58t0jVAp+rYHd15GrE8oyDkylduXaU/1wORpdNYFevFAWvIGiGwGAdgeP7HBfRqm/6RQ8A0miNBTGbGIwg5RcUbQJO9qWccC3Fpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109139; c=relaxed/simple;
	bh=+eHjxgaEecbcTbWLpznRL2cg9KRJdjhCDJbZsX+LnqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgSSNMyz1NvaxSkrLrUpOmAD2vscGnPmcLiCvH4rVCwm5+OCXlUg8oLJB6WcFRevpVnjH4MsJ4Y8ED9F7gu0XQlzE/quE8J+u+7J7HQh23XFqRbQ+F9D5DCiYTBtvEBpCtDC0RG3nxC7ep1aAaBJMtaK9xXmFoE8e5d13Skckz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxhB8vrb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7761b83fd01so4866118b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 04:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758109137; x=1758713937; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=neR9szXF+jYu0k0oU1DH93F32CcLNg0Qg7FVjsgIc9A=;
        b=PxhB8vrbsX5dN/u9YRiYJ3tIYehcJ8fZ88ZGBZ48rTNLe5zta4oS2JF86ClgwU1yqQ
         rjqFxz3xbik94rWyRxVrs2SgT8rUK6wi4dbkG2xrNtdPwQylvgOYiC3Vw4y1WH+DzEy2
         v3aKdyFQs8sqTQG9IaXW0ThWmYhAi/QeOQGJAUdH2iD0oAVt5bKhw4f/+d1B/gC8hmMe
         vO+wpdm/WRY1LZzFrso2Drh4K1X5I2HCLvEZsmugkBopuL3809XjZAkU+uUAsppa51XN
         qPeGLy6dPxK+HxzLq00IHOt6lhAlmek1jriglApSERLdLHq5SBDGqPg1IclNJdp5SobT
         JH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758109137; x=1758713937;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=neR9szXF+jYu0k0oU1DH93F32CcLNg0Qg7FVjsgIc9A=;
        b=Y4rTf3GDqrdexVq4NtEAvPaNRePUCmo07TBL5Ze4ae5sYMLrDD2kUtrqHAD6yHXfBm
         yW6/6l1Q1/Gj454Ib5bGrfywPM2zmEEgtRUCGwyBHGIMQmPQaTbqvum1KTgDi4CVYkyq
         8v4f+B2+aDWzqMB0kCRGG1wtqewON0FrqkZ4erjFLoQ5wD3hmuEBFeJgtRR2O5cb5d8j
         uLI8zMvUL1JCLUVzzKYUHN5WHTD0joUGjpmdv8UHxQuJLOmsN7gjBprqclOzgEyr3bZl
         9QnMSu2g3IQ6aDIhNI+A5FicOLrbGS0WKm1mcYWW4N2JOW9akU+dqcPr4flC0d9Bsjfr
         C5CA==
X-Gm-Message-State: AOJu0Ywgtf5C3BxUFUY8x94sK/BBpDkw7OVrTWJ/5uc50vJKhDz/jvF9
	dLFTvQmaFXpZ9zBSZYcFhfT7JW8UsOWgD5HXxKMc+7LLYPgd+81RsSmE
X-Gm-Gg: ASbGncsagMvJ+um+toRugjQDFgXx1NjDkAQxW7vg62tCtFcld/zhz3DAkikQId9P+/f
	2RV9iZxznxlNpgC6NFTGYboLgice2sKoEU22D2E8wAolp7V7uUwn1VD2zKL22tE30eb+Hq0yoIZ
	vRwAFfzGQw54YQVsZ6e2t8O76Xn6C3H+Hc+Wm7zzWuha5kSjjKSn0qQIdmidfecUy/bI6/ncvoX
	u8O7QUObl0ukWr9gcecO7uZQghRw9nRGTH3Hl0aKkjPbwRYFV9J5WHigaPb2T8UXrl4HCdnnrWJ
	TrjiShKl72vbINnzJklgPg3MLUiLvUSbOW28dlS0GTL2UVbP9UPQi9aedIWcuuT6E3LPpCty0E/
	768Vrl9fnNj/t4IgtL1E3Gg==
X-Google-Smtp-Source: AGHT+IGGJ4nITeama32y10Yw/ToZmDhS7TuvXI/+z5L697loYAj1gT+EekIjPh+p/tzTcWk4EgD/Fg==
X-Received: by 2002:a05:6a21:33a7:b0:248:92f6:b5ac with SMTP id adf61e73a8af0-27aa1c7a831mr2230084637.32.1758109137365;
        Wed, 17 Sep 2025 04:38:57 -0700 (PDT)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3a9e9ddsm16533212a12.51.2025.09.17.04.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 04:38:56 -0700 (PDT)
Date: Wed, 17 Sep 2025 07:38:53 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v12 8/9] cpumask: Add initialiser CPUMASK_NULL to use
 cleanup helpers
Message-ID: <aMqdzQcwvkjl5WNA@yury>
References: <20250915145920.140180-11-gmonaco@redhat.com>
 <20250915145920.140180-19-gmonaco@redhat.com>
 <aMg5EzmxG3hG7aJK@yury>
 <820443ea-56d7-4fd0-9535-b1339e53240c@redhat.com>
 <aMhcYCCJDFWoxcyw@yury>
 <aMlJqDjWNyak07LX@localhost.localdomain>
 <6aeda48661359eedd232c9bb0c337d93c36dae70.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6aeda48661359eedd232c9bb0c337d93c36dae70.camel@redhat.com>

On Wed, Sep 17, 2025 at 09:51:47AM +0200, Gabriele Monaco wrote:
> 
> 
> On Tue, 2025-09-16 at 13:27 +0200, Frederic Weisbecker wrote:
> > Le Mon, Sep 15, 2025 at 02:35:12PM -0400, Yury Norov a écrit :
> > > On Mon, Sep 15, 2025 at 05:02:45PM +0000, Gabriele Monaco wrote:
> > > > 2025-09-15T16:04:53Z Yury Norov <yury.norov@gmail.com>:
> > > > > So why don't you pick the original patch instead?
> > > > 
> > > > In my opinion, the /juice/ of that patch was included with [1],
> > > > here I'm just adding part of it.
> > > > If you prefer I can pick that patch and adapt the commit message
> > > > to reflect only the part included here.
> > > > 
> > > > [1] -
> > > > https://lore.kernel.org/lkml/1706509267-17754-3-git-send-email-schakrabarti@linux.microsoft.com/
> > > 
> > > Yes please.
> 
> Alright, will use your commit in v13 while changing the macro name to
> CPUMASK_VAR_NULL as suggested.
> 
> > And can we rename CPUMASK_NULL to CPUMASK_VAR_NULL to avoid
> > accidents/confusion with real
> > cpumasks initializations?
> 
> Note that in the linked commit message, you have what I believe is an
> incorrect assumption:
> 
> > So define a CPUMASK_VAR_NULL macro, ... and effectively a no-op
> > when CPUMASK_OFFSTACK is disabled.
> 
> According to what I can understand from the standard, the C list
> initialisation sets to the default value (e.g. 0) all elements not
> present in the initialiser. Since in {} no element is present, {} is
> not a no-op but it initialises the entire cpumask to 0.
> 
> Am I missing your original intent here?
> It doesn't look like a big price to pay, but I'd still reword the
> sentence to something like:
> "and a valid struct initializer when CPUMASK_OFFSTACK is disabled."

The full quote is:

  So define a CPUMASK_NULL macro, which allows to init struct cpumask
  pointer with NULL when CPUMASK_OFFSTACK is enabled, and effectively
  a no-op when CPUMASK_OFFSTACK is disabled.

If you read the 'which allows' part, it makes more sense, isn't?


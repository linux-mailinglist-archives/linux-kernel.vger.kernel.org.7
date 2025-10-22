Return-Path: <linux-kernel+bounces-864698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27087BFB5E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A431B4E8D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85141320A3E;
	Wed, 22 Oct 2025 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DzCFpZJc"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4713161AF
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128382; cv=none; b=ugvS1WfsfxK0zy1HipoJXWKGiBS1NAhC3ei8eKVnXGxNImztLkVCmJe72AIgpkUE8If7mRELJ72t0F5WulsmLh2Q4F4KVjlG1QXZqiOUl/QTqUhyg46OfslH++sKS2GZTJ2NpVB1F9nPoIkK+AjpQTUNYMlrEZLDw22NFGuzews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128382; c=relaxed/simple;
	bh=joBEyn5l111nZ9jGESSCAOmkS1tgkzPeMQXORmoeZRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvxe/L9fQCs2Vwk0OyFGUiN98uuUMZDkq8a/zNzHAclyjzc7lg1D444ACcUMToeS74EOWbaOsDJSxVPfpWbVnp7lbmx2aEwmLcYnViOcX9eqRqCTN14mdEpZGwP9oEObknxpKDDV2Gmiqkp3hmpBM6eGUiHWPjboe15ubHweSlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DzCFpZJc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47100eae3e5so21712905e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761128379; x=1761733179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXyDXixja6RmZT39Er05ZzpCC3vXUho6dl9B7iE9rfM=;
        b=DzCFpZJcaEvh+evRO3GsyZ9vyb4yBLLh3ggw32alsNuqluiISUpz3UoIumLk8EKYWB
         j1tKj9zYVv+b254EpxtPmDtClRMxMaStwRi2SJCwGwIgJRd7+ynAbhYuisRLRCkp6nHp
         1/3VJaWJApP740/PKVxjX/I80Kw657fBVlQNXlN3t2aWnqOQ0aN++5fHDgP1jt3yCcYA
         L1Jr4hLl6sqwLAArSavbfSTnWoxi/+pE+O1vouEu2PiOeCCbGRnXls7UNJ9CnttxvnnF
         07N5sztahQPybwTnLOY7zpSeXqIdeZBKIJ6ZhmcHsPaQ7slVUGiIuqvGO7ISAeDTkZCU
         lm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761128379; x=1761733179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXyDXixja6RmZT39Er05ZzpCC3vXUho6dl9B7iE9rfM=;
        b=Fid5d5yqea7e5i6cW3/jo616lU/9MVhkALGuUpnq/9RCq4vjG41EoDNAWtK/kLYPy9
         SlMH6H9rTyrtCr2x84YuWQkBX/YzRmnadXoomln39YwuATBLp5QPnEfIBdYGHAoTLM2E
         /66a+q3LkLC0sVgLnIBLzVKHojL4SfK7km3d7VebgykkBz4zy7GavaWiqPP9vhHE9NoZ
         FXqPcyYZh49XO9V5Igi/cV/Li0vPToEchbOVUO0GKSUARZHSD/ivRb7JWA9aysvb8hUq
         5qL4ztyRN0hKUbED5gbfuvjU2TsmFE3UTyvxjIHve9pRcJr1OJR1H1CxQ/b+sH21RyFA
         oP2w==
X-Forwarded-Encrypted: i=1; AJvYcCX/4a4K/f05CdPlg2XKJ7Or9wTD7rZTumAow7aUDALPkPLhFenZXJ5OwWHeZGd/qS7anf94kciWtClCrRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvoS9Uh05S42DkcBbRMNnbjozOFECsQWSOfZzXWTij+A2GALnS
	kIkKC9MhxUDuhXSDuNSt/Ejp4v+xW9oVaIbhMU6c3WXQHAGlKNqlu9EWK4N9rhupYrE=
X-Gm-Gg: ASbGncth1m529hnDT6QUWuxKOYZo0uSzUPe0w1eOA3HN5utnOFF71I7HO0arHoHokZU
	UoWiwPz3ch1JgxEroq7Y7iE2c8EgHQ1UugT/egk02uERqcumZ0UXDahr/j+TWNJnRcgeG7W46GE
	ZS9Oi+rBX6Pj7wBnva7xWF3l1mzzUHLopDgAXkd3H+VO/7Ujp1lNcAyVRq7WDDe0RHZFOxClXL9
	dUBb8JLGCMxs4YtjeBOB9Rp4zOO+nit2J9P0uCjjlX/DYqwdBjmU+g5UrQkGrSg4Ou1dOFElS7b
	d+97trp96/VFg9cm/7T/SxHehkNYFjZNXsJ5FUarqB+BnjFtIQBN/U1+h3bks6gESAmaFySKwFt
	auLlis3lFwiaIm781S3ETG3Q6HZAXvkSXKUkoNniv7N8XZMApYLoNB/5vSXhTCMI3wD4obBqJlJ
	TUTJxNuQ/87lfSHw==
X-Google-Smtp-Source: AGHT+IEbwRIxqwOcW6k8/RNZuYBz6gOsWXSzyHrVYvpQPGm+n70PNasZXailVMdY6Pt7W5w8c1E2Ig==
X-Received: by 2002:a05:600c:45ca:b0:46e:59dd:1b4d with SMTP id 5b1f17b1804b1-471178a4bb0mr148080655e9.16.1761128378963;
        Wed, 22 Oct 2025 03:19:38 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b3esm36179955e9.13.2025.10.22.03.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:19:38 -0700 (PDT)
Date: Wed, 22 Oct 2025 12:19:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Randy Dunlap <rdunlap@infradead.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] taint/module: Remove unnecessary taint_flag.module field
Message-ID: <aPivuD7CWwHBRcZI@pathway.suse.cz>
References: <20251022082938.26670-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022082938.26670-1-petr.pavlu@suse.com>

On Wed 2025-10-22 10:28:04, Petr Pavlu wrote:
> The TAINT_RANDSTRUCT and TAINT_FWCTL flags are mistakenly set in the
> taint_flags table as per-module flags. While this can be trivially
> corrected, the issue can be avoided altogether by removing the
> taint_flag.module field.
> 
> This is possible because, since commit 7fd8329ba502 ("taint/module: Clean
> up global and module taint flags handling") in 2016, the handling of module
> taint flags has been fully generic. Specifically, module_flags_taint() can
> print all flags, and the required output buffer size is properly defined in
> terms of TAINT_FLAGS_COUNT. The actual per-module flags are always those
> added to module.taints by calls to add_taint_module().
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Makes sense. Nice trick!

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


Return-Path: <linux-kernel+bounces-774071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F07B2AE4C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 013007A7742
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C66341AB7;
	Mon, 18 Aug 2025 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EOG8YPkL"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D391735A293
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755534981; cv=none; b=EQxSSwL8vYKuq1K+KD1k3b1pERlNOuNZZ1lVJP15DA9R8p9N/OOTJbJgXck0/CT4THdPnpkk0fFZFz+DjkUvzG1tYBfhOnhNjlQFRTBP+WSPfoFtRmqDDMqSY7q6rxnojZ31LEmLW+BgM8Cu2WJEneatgroeQzQw2v435s9j9rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755534981; c=relaxed/simple;
	bh=g8Qw52IvfeGqkNMfZ2jn+p5tbsiqR4BTKmRhpUh8Pow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nl66ZENC/q1ewrTfQo7YRcmPLVQxPECz4i5LsNANtLhkE68CTTRyoRIMYlJgj63o9T9dNG8ehMhck3Gi2UP6fmFcPfW6Ah3pU5QPvXVMVgTxDcOYnfC/0ZraVfkHZXQJjKFt1OcKoE5fOy9St6XVHt8Fku+FHFi1PZJ7boPZa+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EOG8YPkL; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b1098f9ed9so28025291cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1755534979; x=1756139779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g8Qw52IvfeGqkNMfZ2jn+p5tbsiqR4BTKmRhpUh8Pow=;
        b=EOG8YPkLaIaeD1yK6oNx7KoI5h1XOvg+FTh2CmD9p/ixJxezZOxblb3i1JHPOwuD5N
         D5ak9pf/4Wp0qMvlx1g3fe8G40ep5aST6dNKcPDn8ZN9QN46r25EOdTVgyMUsJ1CP613
         ehBUPGVsmprhS6RX6yXNJAsbCZXYkypUOW1jvBCMjirIGD+o1R/kbtJRe6FeLyHn37rc
         5KzrzFlQu4TQaxAhvvi+bEssfHiNpk93uNw0+ir01eSUwQzqUTBfKfAEv9TF31aGjLTI
         lL4kxHMMaggQrkvv/Bx/qY1qH1kUo8qIHyLNN8a0iN6Qcu6QU0mT5FxzvpsJ7jZjzWP9
         Ho2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755534979; x=1756139779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8Qw52IvfeGqkNMfZ2jn+p5tbsiqR4BTKmRhpUh8Pow=;
        b=AtY9df0k3Cp37hOFJ9rjDZmScDoY1WGzXjnCWeKYr9wRdwK6I5JFBzfIHNc0qAdNMn
         QlCTfjaEf901NbUGAZrEsWgzBHXpg/RC80/0MN0aINCk8iOF1Sd/EUML8J4Xosxe0+/z
         YB571c+jNGub3Ih77bR6YrUafgrA7a3AIZafoIeb9JB8xJnpm/gTyT1C9Qko4XAdtQIa
         AOigrd1n2DezcKdfuYLmbOngQk+XHJVNAGMGy/xhdlOB1laLAc4ORwG5Rabr0zdEjo7c
         Gg/+O1k9BnGK5Sr6lEW5Re05/vSajskFD0Pfb6dvb8x+F3349N3Xt25Q7+kNWBdZSWcY
         GO/w==
X-Forwarded-Encrypted: i=1; AJvYcCVbBEyhBZeWfzD6MyfwacPVVIRVcRfDwr1D4MHIrYMqiH8bkR2CQRspTVnd+tliWbxKcWctcktJhK58P5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4xXXepXP3leJ1iBe/5PPvF8rKOB8cWBAXJe3jllD2QiySniCf
	KjNvdZElw4vokvq5t1ZmVaHwO8wHy0d50RZ2epBLoUS0eHkD4SGSq1dFDwHh9HoEnbs=
X-Gm-Gg: ASbGnctXZGKb4OF1cOq1mlO5f3Ex4krYxtxl21sBe18Z1E8SXBu+ern8Lzz7rg39+Pu
	pA6jM+KlOmoTnaznmbO0Z2sTuYbKkZe6sKSvM/dQWkJBijqAPDqV02asnCdn9FRV0PCQx1Q6huV
	BORocBAv+cw1Tqu94fZKq/pMwO3b+CCZNqOdKYpw2HauCTPMeJTNmqXonNNp8dHymrn9PsMYXF2
	c17aowUPwWSMh+rc41+OXQSM3oU8HG4M/PCYx1pDtsUce4/ToYHLXamdmePV1yNu0ll5ZFl763H
	6SpVeYjJT3eeFJKQ0KXtYqeqkrnDc9GY6NdmddqQr5sHIIx51J+/0MVz8ecSBWDKnIuORNJP
X-Google-Smtp-Source: AGHT+IHVTekjFOmo8tz7Xgwi6XnFUskfa5a09qL5qXfEjb1nIAksYckiRGpg/LVtaH6xVkuRuKrP0g==
X-Received: by 2002:a05:622a:2d5:b0:4b0:b7d2:763f with SMTP id d75a77b69052e-4b11e29510cmr187661001cf.47.1755534978599;
        Mon, 18 Aug 2025 09:36:18 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11ddd8727sm54906631cf.39.2025.08.18.09.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 09:36:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uo2qH-00000004PiO-1QzU;
	Mon, 18 Aug 2025 13:36:17 -0300
Date: Mon, 18 Aug 2025 13:36:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	intel-xe@lists.freedesktop.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [RFC PATCH 1/6] mm/mmu_notifier: Allow multiple struct
 mmu_interval_notifier passes
Message-ID: <20250818163617.GI599331@ziepe.ca>
References: <20250809135137.259427-1-thomas.hellstrom@linux.intel.com>
 <20250809135137.259427-2-thomas.hellstrom@linux.intel.com>
 <20250818160726.GH599331@ziepe.ca>
 <aKNT8GUu0r3i4Ikq@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKNT8GUu0r3i4Ikq@lstrano-desk.jf.intel.com>

On Mon, Aug 18, 2025 at 09:25:20AM -0700, Matthew Brost wrote:
> I think this choice makes sense: it allows embedding the wait state from
> the initial notifier call into the pass structure. Patch [6] shows this
> by attaching the issued TLB invalidation fences to the pass. Since a
> single notifier may be invoked multiple times with different ranges but
> the same seqno,

That should be explained, but also seems to be a bit of a different
issue..

If the design is really to only have two passes and this linked list
is about retaining state then there should not be so much freedom to
have more passes.

Jason


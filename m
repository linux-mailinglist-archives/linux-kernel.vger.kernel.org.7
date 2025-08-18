Return-Path: <linux-kernel+bounces-773387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE15DB29F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0253BEE5F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E5D226D14;
	Mon, 18 Aug 2025 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cBAiafiL"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC96258ED3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513181; cv=none; b=U08o07IQMtpvrPe0vrvND+pfGVA3VN0TbNglbrIudjPA9L+kEd4mB3fD72PiGAnc6bIJykOFyfUT06+IEHHUZricc0fpo/2hovdiXw5k8hZOIfaofQDEb97j4yVMFWUbF3jbkL9pBRnEK9MsBZP3wUNyhdfVEa2U/94CCkMh+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513181; c=relaxed/simple;
	bh=jGu0g8N9DbdvHLEkr3IQmTQcjJz2j/XCthQ+fUUAMmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wy5O2xVt/DoV10Bmhv7A5DfkeoRGavfokDCxhRtmjm8Zpja1wgfwyuUP/srq5XCTKgbx0E9DJosR/1ASdSuQet3AP/a/u6F6bN943tRaA7rmtPL3kT8z23prgZkVUj7hxSlc11jirczIiaeMytR5OOC8+eAGW+w/H0mJas8eM9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cBAiafiL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b5b7c72so5505020a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755513177; x=1756117977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YFAb2peAQnBRSpCYeUdIv2YpqMbX/LsoLgoW5Q0xsQo=;
        b=cBAiafiLzV5XN/UtgRu4xrcrcHJ62sxw1KHU2JwGrNQoslnJ6+aoXheqg2Hv0QJSSm
         DZLPLk8FP4PG8HDs0/hrtle1b0RCmwUhczsSK3lDaVKozFrAC58dgakMriVUuHvllFI8
         /zv0YuaIV7BxssmW9gPbHoWY1bENt6fkxfDMT4NzqF1gkwv54SDs04j85Xgbti4gYfKd
         6s98Zw4LbF8OR5m3ByvHRpQICHP+JjLTxJxrxm0hn0z1VgvH0H8bP7QRC9n8QYbkmZXU
         IkTxHHNCfS39Wzcs7QQwgs5CoARyXPY2xc57dwOEaeEtE98cBaPaSzEl5O6jrGXYx9hA
         pLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755513177; x=1756117977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFAb2peAQnBRSpCYeUdIv2YpqMbX/LsoLgoW5Q0xsQo=;
        b=aenSESFacw8VYnfFf9QLyy/qQmEoUNheLgcfR/BVXJENcPZXs5V3tSJpO/j/Br47+d
         9MXvLzEvDiakIC3lKNi6MDM14oMzbWOMbniX+pJ3OYDMtlxfctlrg5PIweBcm6vQdl7C
         2DWL3xv57ADfWH2O5rizyxAzsNUsAZqwxm/ffN+Hj6YAKggd8tOe7j2HMoBy3FJg0hvp
         SbRh6NKxUzC1pL83ZNkW/xGTUVykcSOo3mJ9shEh1Rul9K+8n9YWZEn6j67HvFXdsLJ1
         AoTIm3Kl3vQGpnSuNesCUSGbu0us8bG7Bt9y9ww+GNm5TIw7fBo6BQHK1qSFW5bmfvks
         mW+A==
X-Forwarded-Encrypted: i=1; AJvYcCWWpCkyLvlTcLPBWwbCRNNHLwKsLbQreAczc7KN9u+Kym9HyshCNx8AeMh4e+uxYsXQZTFeP1tFAtssKc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTo+fYt4dLa6GBW4dHI7vbNA7pbBju5K2btNJbcApjk3BdwwSM
	KQvHIAa0oHBnyVu2lFgL7AAfK1K0M45Wc7O95uE5hU6k+GV6kXlZJzkkZwieGDEtHrY=
X-Gm-Gg: ASbGncsu6SQhtkJboCtM0pra5NzgVqFN4qX/6ltU7WsswK6LVdeBLEP4QMS0xkmeBlK
	e5o/0Qj+sDZxgC/sxJUAqKdTJcfRmuUu01bJW3ZXxJt5UXfIDCmKViMv7JDNatXuaB5/G5QYCbY
	NsFbqZBL0QDk1PhRbeNC3YF51NU1ZL/gVNHfGdccHbO+078C4jiWMLT4xAHeIg54daTFaghVqx6
	/51MDW931gBEfjj0+njr3m0U6inGkeEgvCDCnZJOUkGtuqQQ9mDdNRfozkD7VaeeUKX0ia0ixXr
	MNghs8FtwTYQzqrQJcxIW/C4A+YVbm1WGXhjiJL6X5I3Q+fA6TosNagV7u0NctS5z/EmTVfgs9J
	rLelU1uegba+lTudp5V5QiFoIHg8IE3FR40Mz
X-Google-Smtp-Source: AGHT+IEHoyUEzJLivgsaxPJyaX0pojnZJD9gDn1yL9lMrMY1Om4L937p6B4a4FV7zN+yEwekT9sCZw==
X-Received: by 2002:a17:907:78d:b0:af9:3d0a:f390 with SMTP id a640c23a62f3a-afcdc3310admr1124112866b.43.1755513177186;
        Mon, 18 Aug 2025 03:32:57 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce53f49sm774967766b.7.2025.08.18.03.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 03:32:56 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:32:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: please clean up the livepatching tree
Message-ID: <aKMBV6LfqCYw1wQm@pathway.suse.cz>
References: <20250818121456.378af88b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818121456.378af88b@canb.auug.org.au>

Hi Stephen,

On Mon 2025-08-18 12:14:56, Stephen Rothwell wrote:
> Hi all,
> 
> The livepatching tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching
> branch for-next) only contains 70 merge commits and appears to not have
> been updated since March.

Just to be sure. What is exactly the problem, the merge commits or
that it has not been updated since March, please?

I have just removed the merge commits.

And there have not been any changes ready for the livepatching core code
recently.

Best Regards,
Petr


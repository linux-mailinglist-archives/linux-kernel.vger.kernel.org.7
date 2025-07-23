Return-Path: <linux-kernel+bounces-742956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9BAB0F8B9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5779C1C86C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD34E20E717;
	Wed, 23 Jul 2025 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="awHqmAbJ"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F764A28
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290821; cv=none; b=U/o0RPYw6WP+Ot+h4JIVLlGTIj5xEKxl1CPoavxGB0Iga9bfVmvtRNwBantutYRtO/AcTUUEpNElgLDprUY9qZCUWgUo/8QLP/uHsD3P4fatR0J1qs37gJCg9NHCarCGg7xpN0eBh8XWfl/rzKh9IiDmFOBidJCoXT51HkPEBFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290821; c=relaxed/simple;
	bh=02phW/kJoqrTRvi+SiCfo0sg0dwIafOxxOfUn4ZtSEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ome4FlmY9lR0dGh5RUDmu9TZ/f131JI4uSkqjt/8v01OsY58obHjtT37KUXe+3pjCYaF2esG16XW8kT7w4t3GOTvXJ+Cwv3eNz4YnqdDOd4gJkI2JUS5Ozwq0UnofcF5EWj7b3GxKcB8kqT3xeOEBA6SNfD+f6mTpCI8MmC8bYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=awHqmAbJ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e278d8345aso17364385a.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1753290818; x=1753895618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfPJ1KI5q6cIQ1/grhOrHOy9FqylsuGFeadXkjjdSH4=;
        b=awHqmAbJaSMs6nGWQ93TWAP4wLhtbUuKnEN2/kgTkrwasNWK5rjDoeqy+BT2PeDsIT
         l9oUB7r5PXUQXcKS30Uc2KaTHozsHXIBhULkNdTRr25h1snsIqtvv6hGaS6K7NWWIM5b
         GJwZD9D5xN2sNgXMmYDqCDCZCoZV2n4igCFJhvUah8UKwbfuQbAnmRhMC28NjZjXRaYs
         BcYIyGMe5JhvJ0Lz0ap0ArmvKU7jGf8iL/iwUcwP1MUx3a4eOD8mKFCoeX7h6a96w4+N
         bcGu/8mfDEi+kMqQjXq2nIu34JvvyrZU/jDiDL0AZMmEoYegTylbOWrXuHAEBo1h9Hx5
         ToFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753290818; x=1753895618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfPJ1KI5q6cIQ1/grhOrHOy9FqylsuGFeadXkjjdSH4=;
        b=xLKuot2mk7OY5lnT7SVdMwJNlXL0TjLUOJqPDZK8xp7AIX5pUs67vQVkU9bwhGi39o
         4KVF2LTlwtGl6F7V1UcZ63HnHCCWnSKoo8V1TIW8IoGr8t+LjPChVixMF43AyjuYMR0k
         E5AQS56C4+q/fHBRjRPdcT24VUK22kiVTcfKAQcBID5phWUNh5tagG7iGiOvGYoZJLJN
         v9ajjw12xF1R1iEd4CKfpWuaC+yIUl7rcQ7ZrDA2pEL57U1kHjKvKHFmd4ThCsFFsCXF
         Sp+s2MgTbxmL1Ih+xeYsgMNKXPtsHP9QVR62qbVWYkRKRM/6MMR7A3YtjS4KjrxIShAH
         U7sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpI/BwKKN8tlXVO5esjJElnB8x+6j0VsrHnAH10OARJeuvyNu0WkjVXJfZVsTi0vuZG+Ts73i45Mapoks=@vger.kernel.org
X-Gm-Message-State: AOJu0YweTIuWzWbGTTfXszxH3IZrT/sLJx5YHDaRGqg80Z8MJ4GHBI+v
	U8WMRNi4wilbIgs+8KkhLZRLZhZ28jFQHxZpxE4VDOQUxgeQA6T8N0nHg1RQJJ2agQ==
X-Gm-Gg: ASbGnctDbbVjAjs7J2lAoVE3YPPjuRMjhda7+wpaAAxme3eGGEnYPyWQKKAW3PdVRcU
	GpmJmhlplJtz9EoRAU5620MU8fq2+91MMYy7HGcFCr6VXHGGjThJpyJesc2u3gToQKeUjduTKxi
	9giT7qOgMdAsSESY/HJqUjblKWz2K46PA+vKsG+RjrYLVO1Tx82FnU5oZbiy5jlmm0G/q9i0D/x
	pswYV9OSAKwTW/S99MlA9M5zUuyFleULweqOEttGLAMIV7kHeYQUmg5fgTBveaJ0M62b1BG2Pmv
	TI8sF/bQV+zAlV3Bqh7NiCDC2746ARDiNu81wVr548WUuXeksZm3B+Yq21P/Nj28kuRsgSs5NPZ
	+PxOa2gQnv4u5WL0fhxUKm6FsB9YHDytESSw2sLYHEqWfmFx4dsqIZ8hVYtNMpYL6hw==
X-Google-Smtp-Source: AGHT+IHGdwf01nnbSYZJolJcE7oNtlESdrTKJFxeHydgcJvjRDFHZh43mFdvETydOI903RgS12ueDQ==
X-Received: by 2002:a05:620a:9c7:b0:7e3:3c02:ee8b with SMTP id af79cd13be357-7e62a1910femr416771285a.43.1753290818371;
        Wed, 23 Jul 2025 10:13:38 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:3d4c:de64:63d3:50b5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b62e63sm684966185a.47.2025.07.23.10.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:13:37 -0700 (PDT)
Date: Wed, 23 Jul 2025 13:13:35 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
	quic_neeraju@quicinc.com, frederic@kernel.org,
	linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
	hernan.poncedeleon@huaweicloud.com
Subject: Re: [RFC] tools/memory-model: Rule out OOTA
Message-ID: <abafbf9b-d13d-4389-82fe-501810388a10@rowland.harvard.edu>
References: <20250106214003.504664-1-jonas.oberhauser@huaweicloud.com>
 <6fb01aea-f7b4-4f38-82b9-fd6c360514fc@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fb01aea-f7b4-4f38-82b9-fd6c360514fc@paulmck-laptop>

On Tue, Jul 22, 2025 at 05:43:16PM -0700, Paul E. McKenney wrote:
> On Mon, Jan 06, 2025 at 10:40:03PM +0100, Jonas Oberhauser wrote:
> > The current LKMM allows out-of-thin-air (OOTA), as evidenced in the following
> > example shared on this list a few years ago:
> 
> Apologies for being slow, but I have finally added the litmus tests in
> this email thread to the https://github.com/paulmckrcu/litmus repo.
> 
> It is quite likely that I have incorrectly intuited the missing portions
> of the litmus tests, especially the two called out in the commit log
> below.  If you have time, please do double-check.

I didn't look very closely when this first came out...

> --- /dev/null
> +++ b/manual/oota/C-AS-OOTA-2.litmus
> @@ -0,0 +1,33 @@
> +C C-AS-OOTA-2
> +
> +(*
> + * Result: Always
> + *
> + * If we were using C-language relaxed atomics instead of volatiles,
> + * the compiler *could* eliminate the first WRITE_ONCE() in each process,
> + * then also each process's local variable, thus having an undefined value
> + * for each of those local variables.  But this cannot happen given that
> + * we are using Linux-kernel _ONCE() primitives.
> + *
> + * https://lore.kernel.org/all/c2ae9bca-8526-425e-b9b5-135004ad59ad@rowland.harvard.edu/
> + *)
> +
> +{}
> +
> +P0(int *a, int *b)
> +{
> +	int r0 = READ_ONCE(*a);
> +
> +	WRITE_ONCE(*b, r0);
> +	WRITE_ONCE(*b, 2);
> +}
> +
> +P1(int *a, int *b)
> +{
> +	int r1 = READ_ONCE(*b);
> +
> +	WRITE_ONCE(*a, r0);

This should be r1 instead of r0.

> +	WRITE_ONCE(*a, 2);
> +}
> +
> +exists ((0:r0=0 \/ 0:r0=2) /\ (1:r1=0 \/ 1:r1=2))

Alan


Return-Path: <linux-kernel+bounces-800374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C022BB436F6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896A71C2712E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99D52EF670;
	Thu,  4 Sep 2025 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fyyW6M7y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F69B28153C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977783; cv=none; b=if3KRUBBhyUEkWsfr+0IoOSvPz+HozQVaYyC6uhEKckIclIWPGd/5ttKovMCbw4LrLNTf09AcraZRLPsfdokGjtEHG97aXhJQ2YNA3UxeIuzPWUZisf7w8bZKC0b4wKxDvpaLwPYCDlE8yV+A2uhM4vVqvWTq2SOrBsSyZdszIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977783; c=relaxed/simple;
	bh=SPIcDcUjJW+xGdOxRnKMB9CM92syOi04RFBqMxMlnsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgV0M/JCDdURMWO1i2nM6w+DirbNgr/Os61MPCAzAD9S2rrdCs0+21Z0Ml6nAJvpQhOQ5D2g8RHlzKsCoTIiDew94Z5t/r+t/E3FOks4UbmTNqHC7gvvcUhmjWFwDwyiskaXNI8FARPFIWiHgAM+JG31ChlFskTrTLeNZTxDTJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fyyW6M7y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756977780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ubblfPeRh2Q+m3RO8Feite4aPxfDgEI0Wyk6O/0MLN0=;
	b=fyyW6M7ycr/Vgugknd4Xe76LQM/1cDaF8eNR5/dv+QMdevDvU02wcirsgu2CLP3dMpktWC
	WfSIdqlG/62dEfb3lWT9x+s0YnqQyHWjjZr+tgEJIjxXl9lCrVGhB7CBM6FNMtXRuX27H4
	jBHRB+GofQeqJyASux18C2PfAC+m/sE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-UfNHq7B-PT6rjpr6QNOiTg-1; Thu, 04 Sep 2025 05:22:59 -0400
X-MC-Unique: UfNHq7B-PT6rjpr6QNOiTg-1
X-Mimecast-MFC-AGG-ID: UfNHq7B-PT6rjpr6QNOiTg_1756977778
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b80aecb97so6702435e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756977778; x=1757582578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubblfPeRh2Q+m3RO8Feite4aPxfDgEI0Wyk6O/0MLN0=;
        b=i7UX6EgIKUatmwigdDnm4zlwZ6g73rAMTRpgT4xKYviDTbBn5HIUB7wcV3w1ue/IU1
         ExRDGhbEdBGBMzjdfPmjCl3nLMmr0UCoQS4XUeNAB5V92hwSPZf+1lq20WJDWoE7hd0L
         yM/Jq0CJHJM6Cs4GuEterEi9UbOKUG75/G6QIXUVQhXCGYn3WK5JY1Ok/1PTyuhnQqcE
         qczmua3Vh85QNyLfnybkfD3DR5Vmg7Q5Hbx4eDSJyuI7veohki9YuWHIzUGLJv+gKXfc
         cfPIC1PjvWPA3hyfvVjIdsa7BrZEqM0gBqI4gtK4gzsrUWv02117tvmmGZ7aooEtXJHp
         rRYQ==
X-Gm-Message-State: AOJu0Yx8JKAhIK6Cl60cf4pUWMmrwp5cRoucdIbGiWaMnrKDVZdxnbof
	brj0KQeh51WTCrV22eYv4lt+cowzZ79lzJ+39ppRuSEgnfgI5YalWD1eV2WU0pW0AUCU7tjXR2j
	zgPhbVamqJCMvryHMykjhTb2DS2wScjPXFQkymPKhjW8Td05H+lXucQZlfCNfukPSrg==
X-Gm-Gg: ASbGncukQ3wT6JjSigUu53/dMo4+zCfMuXPvvxV08hIg2BKuEn55iHaPCkmL7Ndob2b
	mrwH/u8Opc6eOLUOy3J0eODJSr11IlF8dlY47wvKmLSBK3IbqaNnnvwY/TLqIooOaI6C+BXDJo/
	ke97LoJ/m8a3+YZwvrZxG53aptksEiYJL+CwX0z3tIOsaC1Zf7tDkBiJJxr/XfQvTIcYU716Qls
	r6U72Vt7wlnoGnBvbPGS6wpsiMBEzqkJOoDFb4VWChGlTWhqTat/nlXEmcUK5JzFkm2cgVFwvzs
	ezjossIOIAo3Cfnpv/P6hRWEqEcwRTqdLbpL3QUz6RzEQHq9yAJT8dWzT4YqmiVhHhwp85A=
X-Received: by 2002:a05:600c:3b19:b0:45b:9a46:69e9 with SMTP id 5b1f17b1804b1-45b9a466c97mr86776695e9.31.1756977777878;
        Thu, 04 Sep 2025 02:22:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2JWZ60/knV9OgpBT7SZs8IxbNlk6vlAnUh474G2NebtwKbT/w3RxfdYlO2ffoQJspwuPqDw==
X-Received: by 2002:a05:600c:3b19:b0:45b:9a46:69e9 with SMTP id 5b1f17b1804b1-45b9a466c97mr86776415e9.31.1756977777442;
        Thu, 04 Sep 2025 02:22:57 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34494776sm26799771f8f.61.2025.09.04.02.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 02:22:56 -0700 (PDT)
Date: Thu, 4 Sep 2025 11:22:54 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Luca Abeni <luca.abeni@santannapisa.it>
Subject: Re: SCHED_DEADLINE tasks causing WARNING at kernel/sched/sched.h
 message
Message-ID: <aLlabksolt1imHXe@jlelli-thinkpadt14gen4.remote.csb>
References: <a90ee087c4dc21bbd548c933256d6b4a877a9fd9.camel@codethink.co.uk>
 <7481bbd7c6652a963f132191dc622f1003938706.camel@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7481bbd7c6652a963f132191dc622f1003938706.camel@codethink.co.uk>

Hi Marcel,

On 02/09/25 18:49, Marcel Ziswiler wrote:
> Hi
> 
> On Tue, 2025-09-02 at 16:06 +0200, Marcel Ziswiler wrote:
> > As part of our trustable work [1], we also run a lot of real time scheduler (SCHED_DEADLINE) tests on the
> > mainline Linux kernel (v6.16.2 in below reported case).
> 
> Looking through more logs from earlier test runs I found similar WARN_ONs dating back as early as v6.15.3. So
> it does not look like a "new" issue in that sense.
> 
> [snip]
> 
> Any help is much appreciated. Thanks!

What's the actual workload composition leading the warning. I noticed
stress-ng in the report. Could you please share more details?

Thanks!
Juri



Return-Path: <linux-kernel+bounces-812052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A3AB53247
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758A916B76F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97FA321F29;
	Thu, 11 Sep 2025 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="0Qd5rfbl"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631AA13B284
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593868; cv=none; b=ofBMOnPoSOK6D4SNJcpUEHXLdAjelf8DxkgfYkzvMLlleObhMHxKpogSkD8rHoYHBN8XXHEXlsjXELKMcpMrPGxAtOxII2xxneFrURd8hG/tJkCdLtdceecGd0ACycu5vl1boFPoVrf+ngvIVbYE0PCVvGZiyaptMw9PFMgrtVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593868; c=relaxed/simple;
	bh=XHkroccFsI/PPvcFWnEEfE8rDO99rv60wkCb42lbW/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKen2s+yqW7CejMeHq+Hl+CEo9CW2dpNeRwU93+DoHMtiUsDHrRQIS4SQrT9KVTIvvCpQUOakRZb58FwkpDpN9OHtiSXoFvS8YfeJvG5Ixq5ubjzAeNwSCoCNADHf8D5r3f91YSN1mMCwWEGMLRk33Y7c3Qdi7/srlaoV5Jk4Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=0Qd5rfbl; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7240eb21ccaso15407886d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1757593864; x=1758198664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PpuHj1F+BrkKFutKG3gDdW+7++9553BIyB97K8B1eyg=;
        b=0Qd5rfblIKM0mkm2Vmr/Gvwo/lngrvt73jHzT/7IT0Uvujhujgmk7ayAiuZApq2OEu
         4/d7lQMG4mZDEfxTChiJqK9xJaNMIyb/oxFHJLRoIfDm7Y8MnP5JnWkTscVcWrkyaVSp
         FEzgHTlAYe2eKrEB41deB+JObs8Zc6/6KbUpwmjOfymuuZAlSJjA3+nwh4yg1NP5jUrn
         mIqjMTLNL4hUsq4eS/rQtKb05XHlD7BL1gzTm5/67j1lCM4hJ5tLLb+wli4X9qWF8ojI
         DevOIP530q1fER8d64MQhzVzK2HiVCiZzgF9Z584wQLXe/knSNKrKs0UeFyjKA/++bqk
         HEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757593864; x=1758198664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpuHj1F+BrkKFutKG3gDdW+7++9553BIyB97K8B1eyg=;
        b=LdzCAMoWZ/NFkJ7rcocUioScnvxJBNotLSvaWCu5PHvBJGVxFkgUd4EaWm90pEsjyK
         eWsv5bVxmVdjmDavYf23yWEG44P1PWaqYUjVvnaLEP8SkFLnKNyeHWi0S4wqEuUY0twV
         VOtAjWJW6/arrKuAgWWoWja8TV4MkPh4YguNTZFLmN31Zo+lgrzjvR5cWvh26LBfB2I4
         MYxulMg9RcOPjwTJXspRiR+HQOr3cpgmoit39TR8kmXpins7xExc1yyoFpXhBbENVrEp
         ezu5UuLQdTNjeFgoPtaRtPixhDyXo+Zo/LGTeVyuew9ud0u60S9aeuLrFbjm0NUUtdEu
         EKhA==
X-Forwarded-Encrypted: i=1; AJvYcCVklRq4Qpf91veH2DYvp7Nlb3fUcYmwIwT1QS8ZUMk3F9DtO5xrjHdY7r4HwkIdxtTwaZKh6HudCQLLmGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPN810iyeSsWLHOnZxRxjnMyLSzbu6yGhShNSHulupmaz1OH1Q
	DC26k1TcDSckNRvF0eJ8r+UvGbxmJFaDNRtYuzZbIOi3OLEd5kTlybTGwnImNogh1K4=
X-Gm-Gg: ASbGnct3LuawRtQq70W4lVWOjN2b7rcct7gZ0Q1WrQUYxLkyqgIxM9Utd6W33WvDIEf
	4VsZkQIGG/zZk1eI3AM6q6CdO/SXiBvJp5lshJvRtV7nHkhwvSXMLOPGmnuBGD8Bem/HSHWhEMl
	g9yx1lXDbL8jSw7X20evg0yVW8rI4WvjH4uJtnGkOnePHU9hZO/YWibsVZB22cRNiC+WOthE/KY
	Tt8DBxKWEfu50skmx4mRab+GiTrOsclz9+NLynnWI4kLyQ51exv1XHLTaj7j9Dyk+qz0+uhouS9
	ZL1X2SL+pebcbHYGz/tYqHpIG/AkVR0G5+oni4prP62stIOWVM5Fcs00gD8g94JLqDXi3uM9PJl
	TzTAw8yyY0l+34k9UJmNI/90ygEANpAkk
X-Google-Smtp-Source: AGHT+IFcdYtp7UocDozjlEvj2oAiymL2RS2sZ0/qaE9q57gl4Br+ACFwqJ1RTF0HNC8BjqC9/1PwFA==
X-Received: by 2002:ad4:574a:0:b0:70d:dbf1:d082 with SMTP id 6a1803df08f44-76224bd0780mr32970706d6.21.1757593863949;
        Thu, 11 Sep 2025 05:31:03 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-763bee7c80dsm9791846d6.52.2025.09.11.05.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 05:31:03 -0700 (PDT)
Date: Thu, 11 Sep 2025 08:30:59 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz,
	usamaarif642@gmail.com, rientjes@google.com,
	roman.gushchin@linux.dev, harry.yoo@oracle.com,
	shakeel.butt@linux.dev, 00107082@163.com, pasha.tatashin@soleen.com,
	souravpanda@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
Message-ID: <20250911123059.GA794451@cmpxchg.org>
References: <20250909234942.1104356-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909234942.1104356-1-surenb@google.com>

On Tue, Sep 09, 2025 at 04:49:42PM -0700, Suren Baghdasaryan wrote:
> While rare, memory allocation profiling can contain inaccurate counters
> if slab object extension vector allocation fails. That allocation might
> succeed later but prior to that, slab allocations that would have used
> that object extension vector will not be accounted for. To indicate
> incorrect counters, mark them with an asterisk in the /proc/allocinfo
> output.
> Bump up /proc/allocinfo version to reflect change in the file format.
> 
> Example output with invalid counters:
> allocinfo - version: 2.0
>            0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_data_nodes
>            0        0 arch/x86/kernel/alternative.c:2090 func:alternatives_smp_module_add
>           0*       0* arch/x86/kernel/alternative.c:127 func:__its_alloc
>            0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs_set
>            0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_realloc
>            0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_enable_hybrid_capacity_scale
>            0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func:init_amd_l3_attrs
>       49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_create
>        32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_gen_pool_create
>            0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_threshold_create_device
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Suren!


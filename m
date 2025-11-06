Return-Path: <linux-kernel+bounces-887996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DD8C39864
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E116A1888875
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924173009FE;
	Thu,  6 Nov 2025 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V/CgFgLL"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8891F2253F2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762416602; cv=none; b=Vifl5wiLQk4pG+61Rtzl+WuOt096n1y3yTO++MJo4QwxwAI0XzIZ7gD3Y3qQvVA8kumPfAP2LcNBusJewezg7qLvHbVKc+LQKKBf4p47cCyOkw6Wiyh6HdOyWCmUlTmxh+J5BkXUlA7rjLV/PdZTyATz6KQAerrzCF5yGfUIpfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762416602; c=relaxed/simple;
	bh=nYMC3tYhsJiPj5/AuJWflyAhT3wTf3TyEeTHjOndv6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgSiyDggwdwdONVCHAdjhfHNZDP/zue2QoJRTdarPXx8c7sDuI0DCTPUgzmqqU/awzgcbcrRkH48XYjA3fMQZTCa8BgEnBwPhCzTtArR10znNQRBMeOOayyBeqYOyve8eZZH+EpEHkChAiCNqf3p6AZTlJGgGEGE5T24gEOV5fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V/CgFgLL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b5a8184144dso94542266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 00:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762416599; x=1763021399; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lfRQ4eBcjmm2Bq3zjTX5qrRFTj0WFq+LzwsImYnihBs=;
        b=V/CgFgLLOOo/3TfIQ9FutUBbrbg8svVcAANc86jGj4upBOb5V8ewQLBqmDk9exDEwp
         C7iVo8CxlLj8tuep/jWeQikPPqQKNIMdXisk8/12W1BBQ6G7Eu2gDaxiEKB/uypUJ0r/
         iKq3A5jjiIJc3rgR4qz45a+oRZ150LJzP8VXRinluQd/l+OCvj/F2+STGGjc6IAblSNb
         n3UsAf3Qzvx/iLx/d9jM0Vjgh4bcnaw8vrgxChzZ9lNPVgakMjtysaXV5i94H/RBLU65
         VCYVw5p9i/pT9QVinsraZrrtd/9K39RZpk1jzFJrvAy3iHmz0daamhsnc3EZF1aqN0zU
         AiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416599; x=1763021399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfRQ4eBcjmm2Bq3zjTX5qrRFTj0WFq+LzwsImYnihBs=;
        b=rJXfantu0cKt9YGPLJ9rOzDUG5mCqIALXO4TqsMPtH9C9Jy2lkWYxs+hC6db/D0xxo
         EnFksLPHwt88Fmem+mRVmQhhSpi3RwUiiP7YwalLQTgDXfz0TrNjxRG62cANhkYJCdBX
         kvV9A0m1oZUveQZ50KdZDARLEf8hj+qsPy8c5Zf0QysYX33pDJpUAtn7ZBBwRrxLu+47
         v0xBFOiNxsGq/KLm4Lkns3IfnCmG3m8RoboKcnE/TVux7a0PkNBcnaQ2jc3XXBLO2k86
         kDfRHA++MfNuHED4loMKjnODFDXE0clOWC0JjwOxMPWCpnyyl343Xa5VoUivIwxIoMg8
         OVDw==
X-Forwarded-Encrypted: i=1; AJvYcCUcS5B2ZYD74z2msW7EUyqNbhBJAwgTUxdL4DNoP5chCirqEwhYtvbKaZx/+QFfYsBrUF0CZi5aMs50Vuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEpWNBcp/+iCcvwx3l+G3jh4RGCdoTeqCzrTPcTPhLExUTlvrc
	7LChLU36m9aFimIEyGjlkVz6t3ca4mx/eACmJQCBQ+UW4gXPR19NzPMm6i31PgfAHvQ=
X-Gm-Gg: ASbGncsCSAeZkogQ35djG5YnuAQSQAUDVkh97ybuM5UjAi6ifvzYmb35ztByfwl2jk7
	0eLvn+5s7Gl1b/khd+od7HELvM8eHlkyv4KGFocNP9S296033f2m/JVAziGFPIKPFN3h+83WQBY
	2kRhnkwLuL+hf5yCLdEzQZju3B3fWPeM92M1HMvABiPp1q8V64H6IvgOsu+7qfddoFuOx6eLLaw
	OLQDJTNVTBl/cuOtYIu4nk6g/rLdh5AeC6NM8Mp+ENIIsw3oFg1B4wgNSLpRtONGv7KVWwsMIt3
	O5gkKkeHqI1gTQic1x5nyFkaCTQ1a9H7cEYLhk3VMe5H8Rr51c2NfWfZK/GEtJNX4foNH3lhVJd
	WxahhMhYcC+dLGnzTxIdYVFvnbpmq6y4bdMrKpDvCoQHHhl/fIyEK4rtn+mwpBQlNAs2uPDZI12
	E0gQABgw7jt+9WwX9eyZ/HVIhH
X-Google-Smtp-Source: AGHT+IEo2DMbd1CJeXhEfOo3Lj6cQEv/ZFkX4Hv0G5JRAe6kcb6PCnhyhUmPNd+1xBCZ+FWTBl74sg==
X-Received: by 2002:a17:907:2da3:b0:b5b:2c82:7dc6 with SMTP id a640c23a62f3a-b72654ce3ffmr706771766b.40.1762416598738;
        Thu, 06 Nov 2025 00:09:58 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f8578d4sm1211858a12.18.2025.11.06.00.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:09:58 -0800 (PST)
Date: Thu, 6 Nov 2025 09:09:56 +0100
From: Michal Hocko <mhocko@suse.com>
To: Robert Dinse <nanook@eskimo.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Folio Related Stability Crashes in 6.17.5 and 6.17.6
Message-ID: <aQxX1HdOnVZJAERp@tiehlicka>
References: <b964df0f-45e3-4fea-a84d-852869b49502@eskimo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b964df0f-45e3-4fea-a84d-852869b49502@eskimo.com>

On Wed 05-11-25 19:19:17, Robert Dinse wrote:
>       Since 6.17.5 I have twice had one of my servers lock up in a state
> where it still routed network traffic and responded to pings but no user
> programs are running.

Can you reproduce with the current Linus tree?
-- 
Michal Hocko
SUSE Labs


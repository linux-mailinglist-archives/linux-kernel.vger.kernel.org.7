Return-Path: <linux-kernel+bounces-747982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2636FB13AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3667AA605
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BC1265298;
	Mon, 28 Jul 2025 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gxxvMy9t"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B7824678A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708016; cv=none; b=IUJDUNA0hjzEQn8/nAYgD0s4YH5csyvpnSCjCWzmz0fiuyqG465gKKkkEfqdAbYhthHGmuaN9muDQige3fUxb8w0kg6jjEVl/LkBXj/zLjmttipfyNpk5rvzofddyR6l2E4qz0FVCf2/cH44rymjHXkEBYa63IbyIImvv6X3Vvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708016; c=relaxed/simple;
	bh=LWv4LvXPIWsBIZ9CQoHQIdPcTFcYmm1rCR89Mt/KvKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuId8jnKTkbQSaBgzrS7sL1/Fp1O982qjDqzDtWcZ8w4v7ZU/76sxG88vhcXn6JUNXjmPD8wHdohTjud8eqqAxBzGpthd1jC542btx5EiVWDq1Di8NpENqvpd8KMfT5kirFQ63mOjaJcprrGwZOlFx2CXkX2Dc7QA4CEsJE1nRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gxxvMy9t; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso7023395a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753708012; x=1754312812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e0cA9rfA0/RjVo/W7zMdajkdBMWZ2roOYs7qPdBTCbU=;
        b=gxxvMy9t9J1Pmd1xLCAwZnqmWLhckLGXmmUMYWrWRrHn1BRhiGjm050JIAfY06n4Hg
         Yaecy4bccOEpkwAyNOc/sC+vExheUyrDCNmh+28pCcR/0trBsXsBI+IqBaWabxzqXjkS
         QG56lx6IW53/ftjqGMizTSKzmJC+/iKrt++EwEm+oFA+NXllYbQMOsBIU9B09AnTTNo/
         KWdKWYoRtiYZPzqC/WGacCz52B0wivEbtV6cSudDCgzNJvnJ0541wBL4KrIFlxt+xExh
         UCZDuzASUt/T8oY/cn4AjEh6ZnbLBdi7cNWEV1iRe1gk3vzg/nwNcrvg+Y9rDL/P/smH
         xkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753708012; x=1754312812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0cA9rfA0/RjVo/W7zMdajkdBMWZ2roOYs7qPdBTCbU=;
        b=qHSbRAFeq/R48bc6YTZPWofpPzmHEL4BJte3kKTlVgfWYuCKAVGKJj1+rTvxbmCwBr
         zcaN7x4VGGDGc17gCdj6iTuLYRsTYAqZYvCO92I/KsU/TXBn+OR+j8ANTk34gWnSXlgy
         gEl2DOWdcWeZa50gkLsLGd0v8PZxJJs633XBVCBefCcWr6ziMNU1pvVbtKjV7ww+VIp6
         UqELQGTJLc0a7t9sxGwzKhrqD6MTolGVQu67niLsrNRZqqZOT0OckYxOGZ1MpZx1oEEc
         WWr793PlLfTgg0McPJaC9FNLtkjjRt2Gh1qe8HBffnBqU226+t+LeQmu+SV9qqgoA5Kn
         DLig==
X-Forwarded-Encrypted: i=1; AJvYcCXjs6dj7XImgamZWxz9QtYIX6V9/QvRbjis933f9i74CF/kzahqvyNwtfSbVieqsZjj8xcPAJXZsKFb/3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXr4TaJnGbgPOkHa32aaVBCkNoarreS4u6iAc4dexIePB4sLI7
	bNXIAmuXd3Q5XBzkUmDoRFROA4w4/84BwD9u4sDyQmcX6XO6eieuiwvW4tKaUgj9jas=
X-Gm-Gg: ASbGncuYGLf6Vi9h23q69UF/FBs+4m34fXm777D/4Au46DoaKqcLL5yWgpFoYiuaiaQ
	hieymBfVLAdUhA3qNXYvEa091WhQHPX3kHpog3MronLahOsPdCh/gbgayOrac4tWRyKcDWIuJcE
	Cezz9j70O444b1K81sK9vH88+yGAKREtV66wAtpS0fEVnR5sXd/zyIKvfLABxnzK9CZXQAbMvP8
	L8nVmgBpiFEdnRpvIhqoPndkr8fb3fTgOGqp+zci5VMdSrKtjhZjHkuaO27SR4tsZSDG2wXbDI8
	WH0sUjRKul5vJSwaZ1+eVATbDAFhA7ZFDxM0ZZc5+OtM8h+w8XpM5YvH0NOiWp/ugMX5Px007Aj
	gRkliPr3UYNWWUnjv/d1tGzX03P2UxXC9Kh8=
X-Google-Smtp-Source: AGHT+IG9NBHXdbyzLYH2o7xnbpc3Q/Pq7Orr4I2+N60CLFz7AZwPqB/BkF650wz8S6TPyC8dgZVLCg==
X-Received: by 2002:a05:6402:210e:b0:615:546a:932f with SMTP id 4fb4d7f45d1cf-615546a93e7mr1693570a12.18.1753708010755;
        Mon, 28 Jul 2025 06:06:50 -0700 (PDT)
Received: from localhost (109-81-20-172.rct.o2.cz. [109.81.20.172])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6153143af17sm1824507a12.62.2025.07.28.06.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 06:06:50 -0700 (PDT)
Date: Mon, 28 Jul 2025 15:06:49 +0200
From: Michal Hocko <mhocko@suse.com>
To: Hannes Reinecke <hare@suse.de>
Cc: David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
Message-ID: <aId16W4EaqjANtKR@tiehlicka>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <aIc5XxgkbAwF6wqE@tiehlicka>
 <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
 <aIc9DQ1PwsbiOQwc@tiehlicka>
 <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>
 <f859e5c3-7c96-4d97-a447-75070813450c@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f859e5c3-7c96-4d97-a447-75070813450c@suse.de>

On Mon 28-07-25 11:37:46, Hannes Reinecke wrote:
> On 7/28/25 11:10, David Hildenbrand wrote:
> And to make matters worse, we have two competing user-space programs:
> - udev
> - daxctl
> neither of which is (or can be made) aware of each other.
> This leads to races and/or inconsistencies.

Would it help if generic udev memory hotplug rule exclude anything that
is dax backed? Is there a way to check for that? Sorry if this is a
stupid question.

To me it sounds like daxctl should be the one to online the memory
excluseively and udev should just care about regular memory.

-- 
Michal Hocko
SUSE Labs


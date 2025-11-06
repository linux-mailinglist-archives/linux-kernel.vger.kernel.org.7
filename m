Return-Path: <linux-kernel+bounces-888069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA58C39C25
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D143BF373
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C5630B52B;
	Thu,  6 Nov 2025 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UDleE+c/"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84D309EED
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420187; cv=none; b=VkfkZdtmCYWzlySm+p1nPIdEVJy+FemaqiOUmQkL81OapvkVf0R54CYPthI0cBFMQj9aAF39Hkm2oLCCZUjlx0BBGYuC5hVKsoYMXj+RafRxux67DfJ+P0AWWwmIPz/IMVDLC4PH+kfqn14ft89NZXoKKUe6id1jllLvKfgYS5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420187; c=relaxed/simple;
	bh=A+fJ6C2TyRkaYZ6e4caNNMAApswGydyjEpobUyAnKjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8CTGGFW/RaK0xgrKH+JVmFNtSG5SeqdKOPw2DpMEkLD1geRSPnFHQqSx7mvYalHtjpLSHOjU92DBM6feEyUgkX+UDySlAW03R7bENJKkpDsqd9ehZLKMkQdDFXdiWubKt3BgcqSyAsk7CuIkgPSzOfav7KizynQrccGvfDlnS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UDleE+c/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3c2db014easo131448566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 01:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762420183; x=1763024983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VRMNgmont7IgVwl9qnGUPPyEimnvNx1oY9lAMYcS58E=;
        b=UDleE+c/DF3ba6HBZzGAA6CT93kTVkBdXftGuG1zFhJKxLCoeYT2SkLIH3Wtq293VG
         Xwz0y6tzZDyL1gd+cJ9/b8NwkIycZkLMppsE6w7EAHnaNvkhjYIlP3t8Lr84J5ZMJ80w
         iqQrkOTP8Qx8sUkWY0RG/VKsIM0nPXoEESuPBjoOmecyqgqD9o5owzTbJYNY3Y294ro2
         2+BEWsYieSWqKPxZqPi7wMkYknb+Yig11q4et9oI/Rrnc6wBsqXmh33yLxer3KQWEWiT
         IrHO/OBm6UHkzYVSr8qR+ho2lpJLc9MNHzWTIPqRcWxzF8bPNMT7ONT/IEKENRXCQT+i
         2O4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762420183; x=1763024983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRMNgmont7IgVwl9qnGUPPyEimnvNx1oY9lAMYcS58E=;
        b=Z+yeqz2HGUrGRIFo06yzA8UY/meRyvl0vU8LHDBiU3IxqG6cjwP6Z4WC/FIhFhCwso
         PZD699M1PMYdtKKLTRYWxyB6Z/HfzoolLUY0Xy06y9vJV0vp8bQpOMfIz+PB0pCJwAlQ
         Br6khRZ5g2RQUpcp/zWsoM/3UBe93/PwF16tGta4K1GMCcgHMIbFSahJd0GrVz/Icp+q
         qgcNziciutaJin56+Y1GWu71jeOSimTRy2xtW3AH49uwTJ9HPLsb+0PZes6sWJbq1iEC
         q2s0tBzizNkcHTQ2tzEmUQlmQ1Q1ItGIyYwmEb8fvoPTJ5SrbscQZ7yoM22X4oL8CZUG
         1O8w==
X-Forwarded-Encrypted: i=1; AJvYcCWqiV61s0nYbjhQHknkzePy49UYHeccqQer97mBNWUGRS/fdXHPcxJFn8XgYEmSCwWmKkj4Oc8CTbQWqkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY4Wsqxj6i/Th5Dufwem+ukwR6quYH98cwNCCYVj874kcsg9Qb
	g/otNfgDBgqa4jWdXMPnSzjr4V9QjNzglWKpMe1rDkvxenCc2HOAyxW0FLSFREwKblKsxhzJCda
	yW/+e
X-Gm-Gg: ASbGncsHbJunK9HYucPlKcEbWAPsveqT8jXOuKSl1gYw/yy9uoJfyRFdVyGZWbeSAb0
	/dHAa4BYFTQHt3y9GnAFIzoEyeq0PqqGfut8vjkyvddWWvsxA0PYCUw4uR8rBP8Ty8jO2p16Cor
	eSIHIR7jnhqu5Oaswj/TzshgK5j1irnrVnUFEQ5M6Pf4bfqFs7z71YzBuvCeH9HupM710sPpsOb
	4y1U3ZgdOk9wp5kq1MYpBBROjYYfvMAp0ylge2HUSvh4TkYkwC03ZyRNg2AmsJEmK6qQRHRhohK
	bYpuV5kcn0AIdYslMhi6HL1DQBM/Fgwp8dWs8Y1rs24+fSHKfym0KYLFoYns5nzarUeSbvCFhf1
	PVzP1pAZ1wrwXV06Rx5GA4QMkysNdo296ecBW37TuPFY9yVcrnAXTmEKtCNkDU0VSERN0UgmcgC
	8zfSdSJsrmiXjw2Q==
X-Google-Smtp-Source: AGHT+IGWIwUJw8AUjr0vFraqyyD//Jj1PNVLmvlu/ItjX+PaA6mUvXXTfUULBc/crgWlJQF5efqxRA==
X-Received: by 2002:a17:906:7944:b0:b3f:f822:2d9b with SMTP id a640c23a62f3a-b72651557b5mr720415266b.9.1762420183629;
        Thu, 06 Nov 2025 01:09:43 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289334101sm170946766b.11.2025.11.06.01.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 01:09:43 -0800 (PST)
Date: Thu, 6 Nov 2025 10:09:42 +0100
From: Michal Hocko <mhocko@suse.com>
To: Robert Dinse <nanook@eskimo.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Folio Related Stability Crashes in 6.17.5 and 6.17.6
Message-ID: <aQxl1sXTvhIB753a@tiehlicka>
References: <b964df0f-45e3-4fea-a84d-852869b49502@eskimo.com>
 <aQxX1HdOnVZJAERp@tiehlicka>
 <41d1cb48-7711-690e-c9a2-978e0f96f5d6@eskimo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41d1cb48-7711-690e-c9a2-978e0f96f5d6@eskimo.com>

On Thu 06-11-25 00:24:36, Robert Dinse wrote:
> 
>      I am installing 6.17.7 presently, I was a little resident to install
> the current tree on a critical machine.  If need be I will.  Also, I do have
> a crash dump on the last failure if that would be of any help.

Understood, I am not sure who is going to be willing to debug this on
top of stable tree if it is not clear whether this is a problem in
vanila tree as well.

-- 
Michal Hocko
SUSE Labs


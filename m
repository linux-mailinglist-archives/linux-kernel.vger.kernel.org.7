Return-Path: <linux-kernel+bounces-768326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7243B25FE5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309C31CC3F77
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D5D2F60BE;
	Thu, 14 Aug 2025 08:55:29 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFF92F60A8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161729; cv=none; b=KAZKwu5OT41IaOCU/GOaud4DXKIQEMv4UfwibBXHpBSLRqqdiXdA2NFwZbTYasmKgHyUcyfhc7iLhzo3W5VNw9ZUSVc8JCpWAGw3r34rBG2vnycFx4EI2LiL3KbySDfbUp+WhJfCb8y03Ls+JLOWbZW5Rq0I2a0C8hUu5DAi+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161729; c=relaxed/simple;
	bh=DcwxJGts/R3dmmbotCoEDGJjh3mvNYr7aL8U34Dptgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clZ+kya2eZGGWpPiYPsnxufXGmycEZQsF6+qn+2U4SP+6l+KE/6uopHUwbyu0xjZuiJ7WFCFpM8CZBJ0QlqUtX5OcbWEqVjwAHGfHl6PrapKi8OVhDu9y4hPP/BlueSMWAzLqCzPEiacxszGhN8QqMiGkAI1Z0hTtNjI96HojTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7a3b3a9so100758066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755161726; x=1755766526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZtNCElo7WE+nzu4BCwOhJK3Dw0zvE8kj/CvAGzsRRs=;
        b=pIWDp+78+TcwvmmFZu0uHGMN4lwTTweFvpnViT66hdHpVHr7fzisgEe2n7AMGX37hi
         fzGrZDIXvM/h6RSA9jbZ+W0hKAAD9onAkZ0VTa98VH2e8urfRFOAjTltEeMUn7c3EZxL
         xTnjONZCwiTsEFuyDswvd3lIt63ovKTcclaAi6sdmyqMRLMEdqV1D2NjyEk/8gKL6jmF
         b5BxfZ+d1axJcnK6eQOZuI2p7I7rY37vtcklk2RE6AY1tUB/CzxGlP/SkgpLDuLjDJ99
         C0sqzf4uIDsk6/tmAHpC1bVG0kTyBWQ4eLEb3ES06Tgl3td/k15CaEdED22CqgiWEOXu
         Hoxg==
X-Forwarded-Encrypted: i=1; AJvYcCWnuT/F5wOKdqi3t21hiY5DvugVk+54jfhhWAAsH/rGUPeZ3kajNbC08tNGknhmUV4MrujmaOQZ/D94Shk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD4fCGnbFKcyT1xYWjIlH37skGRzkdT+dYJuc49aNMQEpZ7ip/
	yZDCR+62iPjo3oJK6Ssw7qiLgeclvVSBB5h1fCah2ua/J9Ouw2Pm6ATYWiKI9Q==
X-Gm-Gg: ASbGncvRMUKf3mmpADtHRi1hRYPc+LkrGbs/9Sm1DK2nPA7KYjQbUxY8aYUAiMoj0p0
	rWXxAKQPt4SwbNZ9bUiDYA4FOWS8Nps+pGehOZlce2V00aoDKO2RTlGXL0K7zEnDzdyfjVKpKNZ
	gecr6TSdOyimEU3E6EZd4ln05MZ2RK0TRy4Kif5G6adVOh7vSN1dfkQ5HRwocawOQTOUx4YCaut
	RMdhW4Ls+0FdNkKAoC+Swgy2o0YxJJwEm2E/xQSZvuItn0EpNuskFl054LqBxpyBqb5ykgJT16/
	DcEv0EKDal7H/ihxHBipQV3CKzy4NYZ6qmWh9ht9uHFt8sYi+YydOXaQ1hDh2woTnCwlDqKTWeU
	Jjvp2VwMkCHiY8eyGxbtqLQ4=
X-Google-Smtp-Source: AGHT+IFRGkoVS7Acn9L4r8RWCLiUOBGOr0mn71xPK1e9P6PVy0km7Y3j83X7SC6nvkPseKknYrg52Q==
X-Received: by 2002:a17:907:3c8a:b0:afa:1d17:b5c5 with SMTP id a640c23a62f3a-afcb97c34f3mr204145166b.19.1755161725686;
        Thu, 14 Aug 2025 01:55:25 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0df2e4sm2544896866b.62.2025.08.14.01.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:55:25 -0700 (PDT)
Date: Thu, 14 Aug 2025 01:55:23 -0700
From: Breno Leitao <leitao@debian.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, 
	linux-kernel@vger.kernel.org, john.c.harrison@intel.com
Subject: Re: RFC: configfs attribute description
Message-ID: <rrhhdxjo5igua66ttfoyij7xewoftyjsmg6oogcuipihmnqopw@cf7dh34h63sj>
References: <sq3Xfp7-O3mdRYm2TNLAYvv-kw4lb-5S-xl0S9wEcvI72GSytOQIzslrYzZ92KTGLo67af1sraVSpb3sIgMtdQ==@protonmail.internalid>
 <otrtabbmkoutnvku7mmoecw3f7bjqwhxwuxuu4ewhoseixxgpt@fn3dt5tgrnf3>
 <87349vf65u.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87349vf65u.fsf@t14s.mail-host-address-is-not-set>

On Wed, Aug 13, 2025 at 08:06:05PM +0200, Andreas Hindborg wrote:
> "Lucas De Marchi" <lucas.demarchi@intel.com> writes:
> 
> > Hi,
> >
> > In the drm/xe drivers we recently started to use configfs for a few
> > things that would be added as module parameters in the past. Configfs
> > seems a much better fit for us in these cases.
> >
> > One thing we are missing from module parameters is the description.
> > I can point people to https://docs.kernel.org/gpu/xe/xe_configfs.html,
> > but having a short description somewhere of each config at runtime would
> > be good. I thought of 2 alternatives and would like to know your opinion
> > or if there's a different way you envision for this.
> >
> > 1) Add description to a module info. This would allow to show "all
> > configfs attributes this module implements":
> >
> > configfs.h:
> > #define CONFIGFS_ATTR_DESC(_name, _desc) \
> > 	MODULE_INFO(configfs_attr_ ## _name, _desc)
> >
> > xe_configfs.c:
> > #define XE_CONFIGFS_ATTR(_name, _desc) \
> > 	CONFIGFS_ATTR(, survivability_mode); \
> > 	CONFIGFS_ATTR_DESC(survivability_mode, \
> > 			   "Bind device in a survivability mode useful to unbrick it")
> >
> > Or provide a single macro in configfs itself. This would "standardize"
> > module info to contain configfs_attr_xxxxx to describe each entry a
> > module implements. Main benefit here is that I can take a module and run
> >
> > 2) Add description in the fs tree itself, similarly to how perf adds a
> > .unit: 2 attributes are created, with the second being RO:

What is this perf .unit exactly? Is it what we see when listing the
perf events?

From a broader kernel perspective, debugfs and sysfs don't have such
a feature, but, module params do, and they are useful sometimes.

But, in general, the kernel documentation is detached from the
binary.


Return-Path: <linux-kernel+bounces-750604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549CAB15E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC125637AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE718291C23;
	Wed, 30 Jul 2025 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="doBpC71v"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39D1624E1
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873069; cv=none; b=aV9jmDAgdTRadUe29qH7aLQHRnwHHSib5DvaxiaL66y1Yrr9Y9YUZLDZBbO4evgT+5/bodYb5b2ubl+5wNu/ikQBhD60wbKlky94xtcyJ9Bx4Yq8pFxD7uDFdLONmd22rih+2gDMNinyakmI4dN8iGv2CVi9llTOfUbFAXbVuc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873069; c=relaxed/simple;
	bh=DQmcKnGKJN5RrMHBWyXbcinOiyM7f1vIIndXQ5oJZhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm/17X7ykbp8CUZ4nEpCV/aO80lTz9cEteUJgeS4tKwx757YQsLsfqjR7dGkznhMR438wzi3W/t4FivjXXNpQVrs5s3Y8no8AUxgj5nFMgRgP02bM6s9XN2fEraC13P/jnFErob42dtkP/gNq5nWphmeiN6MoMoN+aV8zzs8cOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=doBpC71v; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24022261323so8174145ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753873067; x=1754477867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dey3O+8JYJ0+DC9nws58D9CFVLsgCTJwkc0ezpPGS4U=;
        b=doBpC71vTDbBBaaqJwEMLZ2QF0+EwnhjpBipEWo0M6a8LxUQddepxim2/6vJSxtFEx
         OauL6GallItBlY4v643V+w1RC1qlP2a4ISAdz2dj6wOgpnj6+toIcQu2Kq/uGFA1TkJw
         BlRdy2z0z+GWXe27nY9Yi5OtlE2L3Dde/JCSrS4g54DM7o917g2rO14X/B/yUg1Xr3if
         DvyCM6HXWGevW+FmUEeRt8ypqg80ji3iM3X/wtgeG7vGAufLgKypyJUKtbKLgOB7DG01
         1hmJuHrFkWCUoVDkW3cQJpVK95O+NNXu5MMhdrXQFoyBawNGWt5Qi+xIfwdLBxLEH7Dn
         JlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753873067; x=1754477867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dey3O+8JYJ0+DC9nws58D9CFVLsgCTJwkc0ezpPGS4U=;
        b=PhZA0bzQQYaMOBolayIN6+5UfxME29YKgsVbGHiWWyUC9tudilWK2l6hscXxGeEU+E
         JfUlEtRFnbYZ+YP5NfOUqJslDp8WwmULqNusg3LsRch7u9qlvXNlYRBfcj5sRf2svByu
         Ts2KqgVic7DulT/Ec0gwkFeW/3ZUH0RA5Ob04dG+4LNT5gbueKx3yy0y7qNCAc2C5GRW
         SanJtDNwKDWBAFLzoE3YBw6Mq+YZE4iA4cIqAjaUzb42Us9Fb+xnKZZq9jjui/vAu2Ob
         ue/Zi1VKG9haucdyLBl0g24ea4DYEoU4yBb9gGSbjvu2LBSnmJn9ItIMUF98r5NOL2cq
         Rm4Q==
X-Gm-Message-State: AOJu0YxqSAGDM34hNLCBtlFHhz/SB1b7EImWgEzXTbRW9Cwb4omwZ36q
	Wu65GaLyAw+WAIXR8nkuHwZqKRE8PVY0npbfpzFIYcf8xM6TTm8vHgpfiac0dCPuowE=
X-Gm-Gg: ASbGncsXz/06774FgDjyZ/1cbFYF3UaZ7mxObKBLBeUdVtTGvOYHQwL3tIsw77AVgXj
	HCTIT/yu4+2AVW4a72KlV894+fjaxR6KzxPDUDYur7VMtt2521B57E7PzsJASE0CYYqFiN9+YsN
	mTuBp3aiwe2jEvV1DcAg6Dw6dvcqKje8iJTnuPhJGIepvlqWwO4+s4cY7BH6rHCoGGk4nkFGNyJ
	W3+wlCezCpZoQcqGRDmMZqv4I5UjJczaRmPH16zThnpa3Bvi9FJirrcDFPw52o/qlNnuaDXSjlu
	UCzrNz4lScsF2urDjmP3sqoYHIkwZ0LkcjioxZnDOvl/zNSxrBtnRo/I9jJLCgad7YmQ09ZXyV6
	bF2bWojCKWThKJcen5RMQMNs=
X-Google-Smtp-Source: AGHT+IGLMQbx3bVJOXpmSkSx907QNjU8+Ld7Du3dzmjXKj+AuNh+yN+/PiipqFf54/jcg5ZF+q9LkQ==
X-Received: by 2002:a17:903:90f:b0:234:9fe1:8fc6 with SMTP id d9443c01a7336-24063d8ba20mr111820815ad.18.1753873067186;
        Wed, 30 Jul 2025 03:57:47 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ff1edf4cbsm83526835ad.184.2025.07.30.03.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 03:57:46 -0700 (PDT)
Date: Wed, 30 Jul 2025 16:27:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, Sudeep Holla <sudeep.holla@arm.com>,
	Bertrand Marquis <bertrand.marquis@arm.com>,
	"Edgar E . Iglesias" <edgar.iglesias@amd.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [RFC PATCH 2/6] of: reserved-memory: Add
 of_reserved_mem_lookup_by_name
Message-ID: <20250730105744.w5arednoluxufvio@vireshk-i7>
References: <cover.1753865268.git.viresh.kumar@linaro.org>
 <feb4591cc48c70f9790c3f4d37c149fc336c3110.1753865268.git.viresh.kumar@linaro.org>
 <b32b9698-0254-43b3-8109-ee8e37482bae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b32b9698-0254-43b3-8109-ee8e37482bae@kernel.org>

On 30-07-25, 11:46, Krzysztof Kozlowski wrote:
> On 30/07/2025 11:29, Viresh Kumar wrote:
> > +	struct device_node *child __free(device_node) = NULL;
> 
> This should not be NULL or this should not be cleanup. Follow coding
> style for cleanup - constructor must be real here.

I may have misunderstood how cleanup works, but this is what I
thought:

The cleanup is defined in of.h as:

DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))


Doesn't this mean that it handles the case where `child` is NULL, by
not calling of_node_put() ? So it should either be a valid constructor
or NULL and not some stale value.

> You probably wanted scoped loop below.

Ahh, didn't realize we have that available.

-- 
viresh


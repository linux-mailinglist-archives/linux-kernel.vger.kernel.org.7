Return-Path: <linux-kernel+bounces-749246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486EAB14BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8593E4E0851
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E394528850F;
	Tue, 29 Jul 2025 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mh3H6eua"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F355419F135;
	Tue, 29 Jul 2025 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783699; cv=none; b=GY0N6/m1PofdrLKiwafgc9V5bkY8+66Re0BTWDde9oWTNKNEBf4Kw2RzxazjGpjlmWgT7TliRPgpsfRT8QpiCpIxJSlJ+MeyKX9MtAa2CxNJajUxp0z8DuUwflVfQliXremjmlsUhOrfs7sBwcf956bFzVbsYdSVwlfA+EI0qVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783699; c=relaxed/simple;
	bh=OGosdO2KeVDO8t3U7SonJQRnp74/Xp8fe3CRi+fdJ6E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=PoV6kE3OUbukU/XOViPv/nJzNx/mx/IF9DXfw3jEA2SUD1U7xmZHr0qQXzp/1qcBCbetSXWDPUQ6xX4hHTIIRbmiCrdjOWYWg+7AVynuK+udbFd3aC65eyOws6qHAw7QpFHxf763Ry8pH3uPplO85u6qU7ZInbyIbovCBhIDHhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mh3H6eua; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23fe9a5e5e8so20328635ad.0;
        Tue, 29 Jul 2025 03:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753783697; x=1754388497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJ+KwSfiflEOad1vnlwG4cDUQJNqhilVwYeVCUL1vss=;
        b=Mh3H6euaJJhlCvVFeqF5RMmlXsY3+3Tfah4QMVC3tsZsvOWE9H4nQ8eCE4SUaG2LTN
         1dhOmSNlI+nmGxQD8C1Kh6qHFitibM3QGJ4CrTJnNrGsAKirovvZCFra5562MmTqkuN/
         7LdOB35FTwRgTtkTekXW0ku+u2+8f6dvVJ4v3xL29uHj+1i+D8v9hyEz4bkpI7WnSYBF
         KMkIMXCz0cj2n980D5kM6YP70lLeXjautZQceIvmZxp+KN2qfU67TbcUBBme4EvwvVjN
         oE/CgKtwt1hNedDqvcD56Tj7LcQ0yZD0OdtgHJ7HRMYUYGDm+Z/6So9dJsaC6iuUJD7+
         YnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753783697; x=1754388497;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJ+KwSfiflEOad1vnlwG4cDUQJNqhilVwYeVCUL1vss=;
        b=qA0gZSU5fGTgGYXE2IAUCiSg+VDZ4dmp9wvyx3HLSDc0rvwFcp6CjgG5tmJqQxxKeC
         nla0SlEJ93rXblW+xJHTUr+zwZ1PuWRLAXPbEtDy2fONFlgpswf4ioV+akN2hlfeL+Po
         B0nU7oLEWYM8QUUHW8RpTBNfIgaE/JdY87BjlLeKSeKxf7QokVr9nMBKfQFDt5XW7H0e
         DZBMbxqb9BrneaM4CMaWl3iSMBtw5g24GV74VW3xKvJg78tmvMqhFeQg9pTOJ7mTub2k
         Aswyh5fnmzpb/EP3O9l/HGXyy3idEmStQDXlfk1CrmDxX9ODOqrT/zcOeYKCwPM0paj/
         2zOw==
X-Forwarded-Encrypted: i=1; AJvYcCUsyQxetRQ/6JSXAMlEFGVlSdXvEdS5Gl79LEPlev5PLeQyMFAFqFV3atj9ig5rZ0y00N0Q4XjF+j4=@vger.kernel.org, AJvYcCVVn6kAg6MBKJzt2pItLMw9RG5ckY2Xl3HNfaXFPbV8hRedrSv42VLyX/mhAQgCnq0FIn0ZkQ7JjsKn8eRX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz49IRXrA8VduJ6//ucpGL4X2EXC2jHm3fGewtRVZSS4rBucdSh
	6GHYkrXDy31/GsJgeyWxw0Zr0JjCcBg2U9/3QscE/pOXJJUfnvn+Wv8U
X-Gm-Gg: ASbGncuYkBbeTm9mWc7EE6LpFY7qAM9Y7resJ+N8y5+BFKlyP+f9m/xMVKPFvBz+J6J
	cSGV9xIIGunUZafbEVcw5MkS8DKQWFAoxnLBEVRFHztaenYte8TwutjWr3zvlVf8C2RNamb/NyQ
	VXcW4Rigu3CBzKnPdO6ARYTnVxByVDzXA2ie0rhtlHufQn8xSsiJxx2tDwCyFZXppwPjXCSUBAJ
	6Hw968tv9W1Jw/B80QPdpRkQdyQ7T2yb00N/uj2PLJsSZ5SjvhjbAbGko+8KqakuuTK4MjfCedW
	nTF/nRkRHS0JsiLS0yJMMBD4dPdXHc5g9MA01FX4TyYpccEgYji5tgbzwXPpWz48VzGamV0Fk3J
	7WH/Arp1AvV1pmYpdId1rAWtSIx2iX7kMHtZkv+Y+mu6ChNdV7WSxP/34gMhqMfj62xF6
X-Google-Smtp-Source: AGHT+IGD75CC4tkEH447PxUXbBuvlpYj6gZ6jUZjQPyhXGP0P50+0HwAYseIf7w9h+dIqJeK75JaVw==
X-Received: by 2002:a17:902:ef48:b0:240:1bdc:afc3 with SMTP id d9443c01a7336-2401bdcb260mr107392805ad.44.1753783697119;
        Tue, 29 Jul 2025 03:08:17 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-240723c84c5sm11332425ad.109.2025.07.29.03.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 03:08:16 -0700 (PDT)
Message-ID: <8251d567-5218-4fa1-aed2-f38ec089989d@gmail.com>
Date: Tue, 29 Jul 2025 19:08:14 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: mchehab+huawei@kernel.org
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <dc75423e817f92cc6b8369892ee79166c2fb5ecc.1753713955.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH 1/2] docs: kernel-doc: avoid script crash on ancient
 Python
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <dc75423e817f92cc6b8369892ee79166c2fb5ecc.1753713955.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 28 Jul 2025 16:54:28 +0200, Mauro Carvalho Chehab wrote:
> While we do need at least 3.6 for kernel-doc to work, and at least
> 3.7 for it to output functions and structs with parameters at the
> right order, let the python binary be compatible with legacy
                              code?

> versions.
> 
[...]
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  scripts/kernel-doc.py | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
> index fc3d46ef519f..d4f9188d6a19 100755
> --- a/scripts/kernel-doc.py
> +++ b/scripts/kernel-doc.py
> @@ -1,9 +1,19 @@
> -#!/usr/bin/env python3
> +#!/usr/bin/env python

This would conflict with my existing setup which has
/usr/bin/python3 only.

Please don't do this!

        Thanks, Akira



Return-Path: <linux-kernel+bounces-849662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F13BD09AB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641603AA47C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85EE2EFDBA;
	Sun, 12 Oct 2025 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0XHL0p6"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E382EFDAF
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292792; cv=none; b=MQYCqSarDrYTzu+IjI5n+GlfxycXpLxVfZc68PYroZkdZr4S618NuUUGGBKfOGL3vKjrc9CBctEy4pkfSrqY/toxMS0/VYQ0Y/xAJhgPzlWLTAVBaNjmuvD8Xu8qAMFkCZWjLTXNIyZhXsKx3jAYc+c1nvRj5sOnlEWN/UdGlX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292792; c=relaxed/simple;
	bh=q/N/f6HmcB2jX7e4IXefTOYn73Ai6P8q2POflYDeu5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgFzfPYehxbY5EmHOFr5VyBJ+mDqDXVhL95h1PgTM1W7wQ90Kq9AJ3M6o06tcoNI5hX4i4xd54xXAdGq/mSVAJVt8oEknd8JKjFlYJMKIptNpurMum3JcxsaH5OLomeQISZ43NamCkDOpbAQir4NY7VH5prBTlxO2ExYC5ZqqrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0XHL0p6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27eceb38eb1so37341995ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 11:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760292790; x=1760897590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ovw0jKQ6NyztYytq053H+NNFHTumfR3yxd0tQVKwQ8U=;
        b=M0XHL0p6iGHN7/377DueXqSoNCJv6t2+R5201ofHPTlcuazijIKySbd4MHNm6r7+DU
         hy9vTPdhiLf5l5rBlVcDh5U7tWJKdjmgfiWY3MegXkqG/Xojz9M6jGWcHCnAJJop9D6q
         zGvzmXN3wIKv3m82aNfu36bVt2vc5Q054f2XZ3CTuS4/ImjXVeCFMIt7DfXqjUo/Q31e
         e/V1M1l1vmq2uEbr3i04v6Pr7sLlgG/K6PKQmyaRitlrkljCjxVR0ZtXHa4d0gw2VcPF
         oeCQgKC98ix0+EvkMdYxbWHPQ0wIe5qEX8XN33VZ6/z6A4esCku4JMjhg1UeqM4owUXu
         uUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760292790; x=1760897590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ovw0jKQ6NyztYytq053H+NNFHTumfR3yxd0tQVKwQ8U=;
        b=e45SmEK1D8MfBTVSpGRs8NGUBOC+8Kap5/PAJbrT6CqZDvMqtD9IWcxf/S5JjaeTyV
         gWD5+6Rj0MWh3yPql1l9HoPWtdDdNSUQIl0baNMQdYr/noHTD/z6/mO60CmcVAqkbpmq
         Md4E/iWpSU8E3BfZmsMC/YYypJS6ZbET7oeo5pWv11PcsxXeFmgxEBD55G5R+TFqLOiZ
         EndGRHqNd7M5OgKMGKoMdhXcpPko6Gs0S2v/1qecceDFIFvsHwq7On7rv0KNaDxCAJlZ
         oWC3WRJnoWe6jF7gu+ptOmEEFJ6dDxkRHQOJA+cPJUsbQavHP/KMLyayT1voB3s9BAZe
         dFUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbYkf1u68tlezR0B6swUxZlZsK+zTW7EFi291N6ftisR05NsMNSTaTnV1PIL270fiJkykx/TE22Y+Qnjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUXfd1Ig8v5SR6WD2uie1NThgsidnvO8ufcH929iyeg6rhq5FI
	6eGqufGIbo5F/5gNB3395uO7QmlZcPsJRmBTKSq0NGENHA8voNvhlau0
X-Gm-Gg: ASbGncv9oh2v5OB6g/0redKWv6yBirKTsOOuFG8u30lLscLiMrz2SmHEU0VyEgRrqgD
	Rbce715ETLbCj6AvFApBIzglPS/QWn5buy8K3QHy4viHJ8C4NA8OOoGjdt5LIkPHSS6/7q0kLMR
	QHb3a4+AcNck8J+pJRAD3KzaxHXNT4P8LA3cR0GF0FtH1ocGdG05JbEwkMT9n8x9ciCknZWNr2P
	HCKCPEsHaUoKye0urvylOu34o5B5yVeiXtrz1M1bfnhYPBw0K2TMy137YwdvpuOQcMxC+O8dnOZ
	rUBVgoPDJCgmvnj0cX6FubnWlNbwkcQPTuB3T92tgfZ6RSmm2MKyqqqmhRbkajvGvOIu5FzB51L
	4F+6hVhYh8HDzy27vjriAPPp2sqWqRnWA+gQQFayNhFBAII95OZJQEg==
X-Google-Smtp-Source: AGHT+IEmQxCkFFO7UZ24b+yxERi/IFGxEwxA34m8F4M0YMaCMHA36BPDMhCCaeMBaLNEhVfkRsdkgQ==
X-Received: by 2002:a17:903:15c3:b0:27e:e55f:c6c3 with SMTP id d9443c01a7336-2902741d01bmr231063125ad.55.1760292790123;
        Sun, 12 Oct 2025 11:13:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f8770dsm110734015ad.117.2025.10.12.11.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 11:13:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 12 Oct 2025 11:13:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ivan Mikhaylov <fr0st61te@gmail.com>
Cc: Iwona Winiarska <iwona.winiarska@intel.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: Re: [PATCH 3/3] hwmon: (peci/cputemp) add Intel Emerald Rapids
 support
Message-ID: <4afd6c92-887b-456d-a5e3-a615a595a834@roeck-us.net>
References: <20251006215321.5036-1-fr0st61te@gmail.com>
 <20251006215321.5036-4-fr0st61te@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006215321.5036-4-fr0st61te@gmail.com>

On Tue, Oct 07, 2025 at 12:53:21AM +0300, Ivan Mikhaylov wrote:
> Add support to read DTS for reading Intel Emerald Rapids platform.
> 
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Applied to hwmon-next.

Thanks,
Guenter


Return-Path: <linux-kernel+bounces-750904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A51BAB16281
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C65161E06
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0FB2D9794;
	Wed, 30 Jul 2025 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ME2Rr1Qr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509C1296159
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885097; cv=none; b=UYYO6X0Hn650TvSww0AJQHgbfsBwwrGmCMO13OQO/JfITMXdc/JrBTQEwNn93NnZOXzJDKfmAZIYqrKeMEidVTRnfFNDDghdf47Euhh5Qw8ZyH5+FY0K5JAvu1Gj67vz1xa3SEfu34qruugkUERBRx+2cYFQ/qG7IpnhwtPZGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885097; c=relaxed/simple;
	bh=t+XdUySbetWUIJJo0KSa7Zw1Ei6449339h1xdEc7AKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u69DVGp5bqDOsWx42MLGr63+sm+zYFjdIpWCBvdSFlWp+r+5+hW5a3th5rk6Fa8yd28iacYfF8YmvP5wx5uqKA+x0OUbn2G/brqR8J9gB6wmDK02+0ZzPBf8sunzi9YCyvqFDNstpPh4D0r2+W6G3jlQjuJ+OzrVfZFxa3vMLow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ME2Rr1Qr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753885095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+XdUySbetWUIJJo0KSa7Zw1Ei6449339h1xdEc7AKk=;
	b=ME2Rr1Qrn36RjrgJMJ2G64oeQaPut2eY+fdOv5qV1TRT/t1u75lXHwOcWLDkMD83y1qJQc
	RzceXj7pFbw2FTGtaXVP0cP4JRjNbWqw3j4yyHc40uNFvpgVZmJzmEglAseRe/W98KZIxu
	b/UyKWAhhC2Z3B2EKHPS6FPJ1bdeX+g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-ZG3FwAd5PniV3733AwW8ow-1; Wed, 30 Jul 2025 10:18:13 -0400
X-MC-Unique: ZG3FwAd5PniV3733AwW8ow-1
X-Mimecast-MFC-AGG-ID: ZG3FwAd5PniV3733AwW8ow_1753885092
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae3c5ca46f2so518764266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753885092; x=1754489892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+XdUySbetWUIJJo0KSa7Zw1Ei6449339h1xdEc7AKk=;
        b=KYIEd2sqNOnVe5O3FxnQigeNOQ9TdYoJY87100cilmRzspahb9jjJGSnUAYw36wjQU
         SIz7j8AfgzypxK5qprLRQ5rDXSJhxUCw+CsujJ3BFEG8tzegp80COIlnz/MniNMCeHOp
         w0zByz3lvR/zv69/zbY29la9ojil8Yi9LSyweATKiLJGF5jdzk275zRzoY765EFUQppE
         OHDw8nwTs6BTtY74p0gVvSN6hegm1wnIGb8/RvOl55VVD3IoRw/yb/w3tK1ZcksB4gWZ
         CF73MOhOW2M+g/nZKG+bNPFgqx1/X5Qi31ublYOV0buNd5Y2yICnmh5zZjoDFs1PtxCY
         O9SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVesn+4Km0Yr/H9Im8EeyPzJnh9fcOygV2q9BKoQlswEb4KtjFOLscKquVv9KAthspg1bhCm15QbBCZA84=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFq9lesjNIlQ+tpPabVqwkzzhMx7ZYAf3FaZXNwCiELhUk3u6Z
	OIorFA17Thg2qTdjcQxRX8Wzsf/aeL1Ow/cX+Dp2rfSMCMm+QEsQIVtAjVNIdp1AjKap+qayUBa
	efq5NMLX+TAKW9LrbGEE7T5jXkOY4Y/GEHAUb92gcDff4HGvoYp/GDeizqmdwmu2uwM9FEsPJWb
	HRlUVs4PLiO3FeTkRGSwO8YGziHeKU9hU8FknwA7T9
X-Gm-Gg: ASbGnctu89fD173F550Huk+F/KdATDxKTfTgRKD77N5cBd0ox37/ZMmNd/zn27OMxcK
	6UOKULwaB8O1Tj6Z7A+VDCXZ6at2yPsZCMIbq89ZMutoTZOTdfPPfontqUbLtIuuQa9t/rD+K8g
	/OLidyTUhZgVIabqvZ4UHT29w2ZLJUxGQKX6qs6wH82pGqaBXd2TM=
X-Received: by 2002:a17:907:d88:b0:ae0:1883:78ce with SMTP id a640c23a62f3a-af8fd9b15a2mr449199266b.47.1753885092395;
        Wed, 30 Jul 2025 07:18:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlSNefCMn8VL1asAYFBErw9EQVssdL+ytIqdvxN27jklDKwvouyVj4iHUy3iqQTvHr0jMpgoVmlIpd0cOzuIM=
X-Received: by 2002:a17:907:d88:b0:ae0:1883:78ce with SMTP id
 a640c23a62f3a-af8fd9b15a2mr449195666b.47.1753885091955; Wed, 30 Jul 2025
 07:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726072455.289445-1-costa.shul@redhat.com>
In-Reply-To: <20250726072455.289445-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 30 Jul 2025 16:18:00 +0200
X-Gm-Features: Ac12FXx4xowUzfg1QpHqAj2vPs_ZSJpkqZBvPfLdbkfVkH-lOdJVad_fyktbcHo
Message-ID: <CAP4=nvREsJ=y0F4UhwhvUvK4JUxCKAGXNmDmiDpPB4bdGTs78g@mail.gmail.com>
Subject: Re: [PATCH v2] tools/rtla: Consolidate common parameters into shared structure
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Eder Zulian <ezulian@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Jan Stancek <jstancek@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

so 26. 7. 2025 v 9:25 odes=C3=ADlatel Costa Shulyupin <costa.shul@redhat.co=
m> napsal:
> ---
> Changes since v1:
> - Rebase on top of recent changes
> - Address Tomas's comments
> - Don't change already not common members: trace_output, runtime
>

Just a clarification: runtime was never a common parameter, it was
just mistakenly added (but unused) in timerlat_params. On the other
hand trace_output used to be common before the actions patchset, when
it was moved to the actions structure for rtla-timerlat, but stayed
separate for rtla-osnoise. If rtla-osnoise also adopt actions, it will
go away there, too.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas



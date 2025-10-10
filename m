Return-Path: <linux-kernel+bounces-848724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F0ABCE6F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0218B3A3B3D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9DA3019A2;
	Fri, 10 Oct 2025 19:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="sOmoRPuK"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E52FD1C2
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 19:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760126120; cv=none; b=dMrng2ifp04PYo5HZC+E9Oj+EXPBoJm4XFck3Xwn62ydBPBaGrYQg0mRc20oJd35caWAIpH3+/1JZTkyvO7CHIarfFi0/KwkUYwruHIzDeF54+T3hVdFqpSZqkr2DW2YBMZ8tlP+ujtzswOukuSOrQ6A/Mq36fjZiwwtsrASJxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760126120; c=relaxed/simple;
	bh=SimwkdUwxyOn+voLJS/BfWE2ArUJiVBnyTuBlpymv+0=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I173dSyvmfdzBacTflIIXc2OMMCDnIPNi+ixgZ2M7V5ubkuURp9jMI7fa4HQRZgPb2eR0t/VbjKq+St3k+kc2ti/jZ7QZ48dvrHKagszTJJh9tR8h/+YztBousmlyIunX6PFyzIdRmlZSfn0dpQzxoks4kWUAX3CKOY53EyBOi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=sOmoRPuK; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B128C3F7C5
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 19:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1760126115;
	bh=kPhA/oNdZoYVHAUf6Erq79uJcMcXf1/DDMPMdaotDWc=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=sOmoRPuKaYsz6f7ZTh7PXV3LCwUPYu+GEuU3QuZ4VJ4X/NN7UAK73KxpQkxBMjCtH
	 VMiPFcnQ2XvcYeAGgegEYuX1PG1fCbKpMVMYmL2BUPf830Zf3kSi0wMYeQqfyF+VG7
	 F7CwxqY6t6JE/Y32ELYwwp76o3FXfMcPF+T189nxhuDBPOeOEBHe8ZWRIoRbTSV+E2
	 V804ciQ41PGoxefutoXg0P422sUgUbAW7Dca/xdKkUJ/+hAkD70+37Y60CmN/4isPN
	 T+AqAqheHHp5YQOSF7HkA7nzfZNc/vB0RRgCfBrFjHLUFyCDaXd96BLKMPww1ckk+r
	 8kpAYR/Ei8an8xudguvBPWloQ7Z25RMc99aPqHNYt3snQ4Hsc9SjcsrNYrSMshX10a
	 COre8EO/jvq2S3RO07KsuvjyOsyeU0IAEzng5or9ppQmZ/jnfFE6RBbnMPeUBx1Nnt
	 s2iW0hJe+bD+/HxVCd4KlyjtFO5clWuAMFgr2Hx8gWVGMFfmi/vQzPu8XNcDD/SyJc
	 ivP0q74HE/sI/9cn6Bo3canH5kgaw0Rw0Stvk9V+CSgTgzGM/N+Qm13THRqxqYM/KG
	 r5W3qayQRHLhX4eRAjzD5+lsyuZTfluQha5xpBGxCnZW0rGKfsmJSqGt8UKK2gr3Os
	 3Z0Bck7vCpAYPC0P2Lo9Yi70=
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5a6a9eac6daso1925942137.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760126113; x=1760730913;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPhA/oNdZoYVHAUf6Erq79uJcMcXf1/DDMPMdaotDWc=;
        b=dRSVR8Gd1yHyJXPnclIz9llLopmbhxuNmoQFpwgtd8+tJfF6JyoVnYGk90zABJQqwu
         nhJ0DNyY9eAFhZosx7MSgqvRKcK8B1pnvQTu3YXFAql0JL9G/PfdfZuOK49OGB8llDQI
         4vDH92vAtBGXteZ796/142BDyKLzIodY4u+89vKNGulF5HqvtF6R4csDQyghNervj6qR
         dUFHPsLpLJWRTgijmwfF7StdkbYAW7b7O4XODPObR08DE43Pg8mIDLDpyO+0eIZ7kTgN
         0rha6GvVYtW2Q3grcFfx6iR3ivics80a562qWTyx3ltFoSyeeKXYYuq6Gbw7LlyXYL0O
         ULNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkXvE3q8JcaW3UCdbNITUNBnqni50WEhmFohqTH9PCl+Frn9Fwh8Fw2gFdsoSfXhWsX3kSAGzBqOkZxWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk33rBMvfWeLMMTMK+Ej+dRPs4MA0/WYn/3G/5nE4CiYsI7edT
	DPDQIOV/5mpu4ofyHBidc+t4SozmW+nPXjHlS1GfUqvYvs9jGq+Y0y0LX3e8QsTv1wYehGgq4C1
	ZUHfCGJeBWB9jX/13rGSClHijerReq6ck57ru3p9Id3Ya8HGILaW8PFIcYJxO+92RF7vrxzrRD2
	6rGVCHyM7BSElmzIDU/6zNHxIqSOWkVePj/rBueGobiTJLZPlvAMhlHiuE
X-Gm-Gg: ASbGncu2/bjvAnaVC4UCsnza8zfN52HUIu/JmoTxSObgvyYlSLpIKo9IXNSCrOirg8s
	ZCe4xxepYCG9lhXZOc90o8WsSpSCVywMQLzhQvHTrj+BAXnDlD0jsIn1HLYyBEQuhj6Z79ohyvL
	I+SW/huWau85B3612BmfU=
X-Received: by 2002:a05:6102:162c:b0:5d5:f6ae:74b4 with SMTP id ada2fe7eead31-5d5f6ae7587mr2959667137.40.1760126113152;
        Fri, 10 Oct 2025 12:55:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl7uSNVMd1/CraY5eNdtkJsmXLfjZq71soXKG1D0wdaThXC8TnpM49Ya9Dq+mRSUiBMq5+qPE5yVu6PxXKKHU=
X-Received: by 2002:a05:6102:162c:b0:5d5:f6ae:74b4 with SMTP id
 ada2fe7eead31-5d5f6ae7587mr2959658137.40.1760126112724; Fri, 10 Oct 2025
 12:55:12 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Oct 2025 14:55:12 -0500
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Oct 2025 14:55:12 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <178f4daf-c752-457b-8f0c-c6273f3a63dd@sifive.com>
References: <20251009015839.3460231-1-samuel.holland@sifive.com>
 <20251009015839.3460231-17-samuel.holland@sifive.com> <CAJM55Z9kRpc53s3Kip=U-CcDxAX0UZD5AbTBy_owU8xPEYH5MA@mail.gmail.com>
 <6fa3c728-5048-4d26-9b6f-21757320caad@sifive.com> <CAJM55Z8masgGn4vVe_2g1e9WXnLu0Vf5oGxbiniGpsbOhYPLRw@mail.gmail.com>
 <178f4daf-c752-457b-8f0c-c6273f3a63dd@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 10 Oct 2025 14:55:12 -0500
X-Gm-Features: AS18NWAlCRC7l99R73r3woSIp-vlQ76Jq27BWW9v6hsv7x0ENpHaGmY-XmjOCps
Message-ID: <CAJM55Z_wOkC767T1p749aVzAL5uQD5Lw6D6eqHb9wp-f=nAO0g@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] riscv: mm: Use physical memory aliases to apply PMAs
To: Samuel Holland <samuel.holland@sifive.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Conor Dooley <conor@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, 
	Emil Renner Berthing <kernel@esmil.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Samuel Holland wrote:
> On 2025-10-10 12:04 PM, Emil Renner Berthing wrote:
> > Samuel Holland wrote:
> >> Hi Emil,
> >>
> >> Thanks for testing!
> >>
> >> On 2025-10-10 10:06 AM, Emil Renner Berthing wrote:
> >>> Samuel Holland wrote:
> > [ .. ]
> >>>> +
> >>>> +void __init riscv_init_memory_alias(void)
> >>>> +{
> >>>> +	int na = of_n_addr_cells(of_root);
> >>>> +	int ns = of_n_size_cells(of_root);
> >>>> +	int nc = na + ns + 2;
> >>>> +	const __be32 *prop;
> >>>> +	int pairs = 0;
> >>>> +	int len;
> >>>> +
> >>>> +	prop = of_get_property(of_root, "riscv,physical-memory-regions", &len);
> >>>> +	if (!prop)
> >>>> +		return;
> >>>> +
> >>>> +	len /= sizeof(__be32);
> >>>> +	for (int i = 0; len >= nc; i++, prop += nc, len -= nc) {
> >>>> +		unsigned long base = of_read_ulong(prop, na);
> >>>> +		unsigned long size = of_read_ulong(prop + na, ns);
> >>>> +		unsigned long flags = be32_to_cpup(prop + na + ns);
> >>>> +		struct memory_alias_pair *pair;
> >>>> +		int alias;
> >>>> +
> >>>> +		/* We only care about non-coherent memory. */
> >>>> +		if ((flags & PMA_ORDER_MASK) != PMA_ORDER_MEMORY || (flags & PMA_COHERENT))
> >>>> +			continue;
> >>>> +
> >>>> +		/* The cacheable alias must be usable memory. */
> >>>> +		if ((flags & PMA_CACHEABLE) &&
> >>>> +		    !memblock_overlaps_region(&memblock.memory, base, size))
> >>>> +			continue;
> >>>> +
> >>>> +		alias = FIELD_GET(PMR_ALIAS_MASK, flags);
> >>>> +		if (alias) {
> >>>> +			pair = NULL;
> >>>> +			for (int j = 0; j < pairs; j++) {
> >>>> +				if (alias == memory_alias_pairs[j].index) {
> >>>> +					pair = &memory_alias_pairs[j];
> >>>> +					break;
> >>>> +				}
> >>>> +			}
> >>>> +			if (!pair)
> >>>> +				continue;
> >>>> +		} else {
> >>>> +			/* Leave room for the null sentinel. */
> >>>> +			if (pairs == ARRAY_SIZE(memory_alias_pairs) - 1)
> >>>> +				continue;
> >>>> +			pair = &memory_alias_pairs[pairs++];
> >>>> +			pair->index = i;
> >>>
> >>> I think this needs to be pair->index = i + 1, so PMA_ALIAS(1) can refer to the
> >>> first entry (i = 0).
> >>
> >> The code here is as intended. It's the PMA_ALIAS(1) in the DT that I should have
> >> changed to PMA_ALIAS(0) after I removed the special first entry from the
> >> riscv,physical-memory-regions property. Patch 18 also needs this fix.
> >
> > Hmm.. that doesn't quite work for me though. Then the "if (alias)" above won't
> > trigger with PMR_ALIAS(0) right?
>
> Yes, you're right. My fault for trying to be clever last time, where the special
> first entry meant PMR_ALIAS(0) would never be used. (And for not testing with
> the same DT as I sent, since EIC7700 needs downstream DT changes to integrate
> noncoherent peripherals.)
>
> For v3, I plan to make PMR_ALIAS(0) set a flag so it will be distinct from lack
> of PMR_ALIAS, and keep the indexes zero-based. For now, you should be able to
> test by keeping PMR_ALIAS(1) and adding a dummy entry at the beginning (for
> example by copying the first entry).

Great that also works. To be clear the JH7100 also boots with the pair->index =
i + 1 solution above.


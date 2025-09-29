Return-Path: <linux-kernel+bounces-835873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C03F5BA83E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D1517A2146
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9592C028B;
	Mon, 29 Sep 2025 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRX0INB5"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742D32BEC3A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759130938; cv=none; b=eVqhZ0t1gstiM0F6XKKjgxsVi2Qxcn2P4AkAS1i5mWIcrv6QFXpCcVUomfOO/8FMK5HdLwfVAKzJBvcf3GrNIS82lBHfEpIk6WT7UGeQ9yaIrP5+Vf48dyH/hXqZV7cxlPCCZjUl6UUnw3TIoog1WVf7M1DR8wtc47qzEjH0FJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759130938; c=relaxed/simple;
	bh=7F4Bd412NUjkHLR4AZb/VhkbRK5cWLJC7xh1AlsvUNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pi8dwGNpJGjkijimR8gG5YI2p4AosKZwO7rjTzPxclU3fBmdZUegAtIgdAAj0bzBLwKGjwIP9vj+Ge5wyxk9+nCQyNhENvx6tFkUMFOEPDqAIdp4YHxHheP5R3X9Ufp3FcJ6+dZ7E5xL7ahpSAyBkXT80w2Sclk1ooVzAF3bgAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZRX0INB5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27ee41e074dso38050285ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 00:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759130935; x=1759735735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vUgMt/Iu4HigVywPOVpy02As/ACdmcQ/LQX8wXFvh6s=;
        b=ZRX0INB5ednEuV6egMHPHfQXIVcrMHwCk3izCYJVrJfRq0aHh49niegTpoLK2GZ5hp
         0Ksx/55lEPd16bu6L104h6AMAybWD4QfZwY5UE+k1lK5i5vr24XcECN8WDPL/o8sToDQ
         NRuvuw3mzMhz6Ecta54WtJgC1uOj7L/mmCEFl26BqszKdVCrWC+EbLB2KAzj7xE4J5yl
         nHOvh1WqnLlGAbS8EZNwD17hHrobPc/ThmaRjpYFNt0UY9BlrWQ3xTAkTjwvIra9X1SN
         fO7nXlJctLWAfhsJCA+1yYpqca7/bBW2fKgVOor27Y0Ir18zqnICIXOZApoF2AcoVlWn
         nMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759130936; x=1759735736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUgMt/Iu4HigVywPOVpy02As/ACdmcQ/LQX8wXFvh6s=;
        b=I9QQwiq1FaWG+MEGVzHYrfN9jls+jSEyHY9NYOqGmbDjTGDy5qXy6NFjAPWO241dt1
         E2YPZ2IFL8+BpydFRzkAVfHfUzEFHwICU8JSS4+vk+Or+hGocy5iTCKg5y1kWZ181beH
         1rpTRzT2XpGJsXHlFSbcRXYhJvpy9N3z9A8r5ClRNVmplcjAK0R6IDGj+4zX9k895UZw
         Wr0we+hn6sM26TwJpNzKOw1sCM42aIdcSQp9psHhzEcWTG2nz/zB/TAfbZl6T0WlthkT
         FYIfUiraEGIi2St5D3Gnw6A005+SsQkks/3cco5uKQdcv+8L8Cnz34JTL9LLxbJod9dZ
         vPkg==
X-Forwarded-Encrypted: i=1; AJvYcCWCo68liquu9cKTfdVB/Gdcb1tW40CPyBZGqPp+xQ2t8s+prewnUJSIVBBnrHRIi3Kw8g0/NsS8w/cSiao=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywov1Ad5Hh5uvso5Hmc4a580ShklTpShlRajqIlyLlnQsRBrfQ3
	OdveYKMWJekwORIlo1eIsrlJHk5dGYgCj8p5tdgvKPYwFaBZY39drVOK7gXDPXytTFU=
X-Gm-Gg: ASbGncsFvXbGkcCWb5ZNq+Ww6uUlP6DWOJ0ExznAduQs8WRaczK4grDJBa+LsWXXDVP
	OciFQcm+RFp/+eQb5Sf7QCSbsRSE5bW8JIYc9wwZqXnKszMa2+HEcPKgw37Rycb2EeDbBSA8242
	dzta+zn6UMUgHh4AwdjtY4WD4wijfihEauj6V89YEt3pnZXbSFIYleMv7a186Zy7dToQRtgH5Up
	oLsz60NGIt+4lbvvKtTf4wpolHbKw7mbtF85op5MDAt+VMzKZ2hl5tPpZY5F5cwHj9jzFbcvGrb
	Gm1IIbbIuvKWGGMQ/gmbqUjtrodrFgOyhCx49Ubb+9Dvd89GRzIYAh9vlrmFg8ZHuCSvP02+XNW
	euWaGSiUl/t2WD+Ov5q5YSnuc
X-Google-Smtp-Source: AGHT+IFV04UkDk6nLUCSmgZN+tUyoArW1g8+WIB0WCKL3KwMarnJ2CKoOoUMLY19056+D/VsX/c/Zg==
X-Received: by 2002:a17:902:e890:b0:24c:a269:b6d5 with SMTP id d9443c01a7336-27ed493e891mr151642625ad.0.1759130935564;
        Mon, 29 Sep 2025 00:28:55 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6997ae3sm123206695ad.106.2025.09.29.00.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 00:28:55 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:58:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Qais Yousef <qyousef@layalina.io>,
	LKML <linux-kernel@vger.kernel.org>,
	Prashanth Prakash <pprakash@codeaurora.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 0/4] cpufreq: Fixes and cleanups related to
 CPUFREQ_ETERNAL
Message-ID: <20250929072852.2krpxwaq2uxwj6cp@vireshk-i7>
References: <8605612.T7Z3S40VBb@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8605612.T7Z3S40VBb@rafael.j.wysocki>

On 25-09-25, 17:42, Rafael J. Wysocki wrote:
> Hi All,
> 
> The first patch in this series is meant to address the failure discussed in
> 
> https://lore.kernel.org/linux-pm/20250922125929.453444-1-shawnguo2@yeah.net/
> 
> but in a different way than proposed by Shawn.
> 
> The second one is a CPPC cpufreq driver fix preventing it from using an
> overly large transition delay in the cases when that delay cannot be
> obtained from the platform firmware.
> 
> Patch [3/4] makes CPPC use a specific symbol instead of CPUFREQ_ETERNAL for
> signaling error conditions while attempting to retrieve a transition latency
> value from the platform firmware.
> 
> The last patch removes CPUFREQ_ETERNAL (which has no users any more) from
> cpufreq, including all references to it in cpufreq documentation.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh


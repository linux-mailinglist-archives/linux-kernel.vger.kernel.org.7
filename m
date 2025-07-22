Return-Path: <linux-kernel+bounces-740161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D94BB0D0CC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA255188AE69
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA8128B7F9;
	Tue, 22 Jul 2025 04:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wr/BPF+v"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F27D4C92
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753157451; cv=none; b=amoE+T3LrUGGCWIkQdR1c2gxF/qexg5eEvI30wUBFC+TfsZ8OtS9blR9VRUe46+a1GunYIqsDSJoaOdYUmJvnPvmR4YGarX1R+yStWrJenhAPvJFVDhyu89weVA5aPPkWcvHLmRptlg3YIIaIea9AoilI3otrZKP+/YeZx2OiWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753157451; c=relaxed/simple;
	bh=OqCNRS+72uajszDzG6n+T34z5A+LL4ACekiWWd6EEzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfdR3Yo+E74QWROunb+xbEHAzl5YiVmwEhiQOaPdH7gnQuXbesoFR4lmyzrOf3BIg2blUDsml3KhHUV9NUHOK2vgBwiPhDzqX5u+1FNahXWupjGJoLB1LMSbJjIkEnc3S8mRMQVYpN9RQ9d0hhqUvyW4loiGPMeqbBBrBv8H9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wr/BPF+v; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74b52bf417cso3314346b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753157449; x=1753762249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nlBEY6HRx3gs6GmX9n8FOaCyjO7em88PtYwWGu+mg9c=;
        b=Wr/BPF+vf/8Jh980foQMoEUznzRA7ZAjuL3JQ+v8LvyydzqW1nNIZBWDXvAzE4qfAG
         xKz54LHvoq4IRfpFzYo2PWvqNb7t9Jsw5K5qRJl3rzI9EDyaMs+MAEx5wHm7BVGSJCni
         XBbs/wnGUmxlDyTtf6pIynJrBFtYJpk4pKxb7wvl/ct4gRuVTJXPB9WoVCdAMW3Z3RZK
         kA/r/AG90FM0V03YkXEJB5LwLCONJir1WUq7x2BkeFD/5LRLfr3bgZgBWqYN3ZGAQSsI
         uqa11XqJPLt0hXQmtGJHoCmLLj6v6MkaDP9QqdCCD5OrKqxIEpzhKbhOOWkiODpImmDh
         VqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753157449; x=1753762249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlBEY6HRx3gs6GmX9n8FOaCyjO7em88PtYwWGu+mg9c=;
        b=Voa+xw+uLlfw3pmZrx1aW80BZ1geb986+5jcv0cziNYQ1/bMnbpgtIp+6zbFT8O2yV
         SMqZkRD8+ixdY22g1LvJbeWIutsLaCmwV41py7X48xRbMxw6udC499g0jDxS1Yh2lt9Y
         o1Ex/bAei6vwm1pKH3oYtrrjAAyjMk36vA3UBmpqZoum4szdo9RljrnpdS63XS/NWT/W
         LWXcgr5ZG50VcC4At/FqEoohXMJeKjgpx/iDYfOgp8O7iiSWfmBnaKJZjHzCFcAIq0kA
         3FPNA3r6ukrBk6YdrbLOiTrNhOAUoP/UHMeZuH/4YgxwLuzDShB1lpWn+p0XjrsSieVL
         P+aw==
X-Forwarded-Encrypted: i=1; AJvYcCWogekUPjhEJ8aFGk6MEnNTtZhyh0P/yyWkiWI5I63KHAuVo2kKlX9kVbZpL8p5PydgWSi8mNMOpnSTFg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEpEuDH1mCQuPodyRnxynEd6lUkjGcfK4GA6/o9reIVqLqGv/N
	pv4dKiWWTLSBO3UTH/enkcgMIF5SP5V7qZ48CN8u1PI9ptMzE6w0FCf5nXQy8GUheD8=
X-Gm-Gg: ASbGnct525Zp1i1XhzVq8yVy0sHZ2CZZ5C10Y2lX3i/ffjj+PR9QTafFCaukgznKlPs
	eJ/pt+bJFglj0a2sQnudXC9uRiecU3WySyfJyh0Vw7LFx8s1NaSjlF4jMXtuMNE67wNnIND5yxa
	bBuL7LWfBhJHn/RmoJzCejH+9blWeeBV8XsTGYBkKohCl3OEs1pjUnsuibrAW/ciytbwuUw/YcW
	t/j4iLXeBrpF9rfY8MLscgGeg/fN+bFaOMo+T7mQKccoi0t1i6Kyt9GvAXHwwvNajuYqvJTM/32
	eR+VRlto+1P04GP/AMibTteRtQN1imJu3mvtzBI7gSAhERtmy6/cMHrcTzzFCwY6d4Ng5vF79lq
	Jn2RYi/Orwmc3M5bCwXwgbrg7kw3BIkak1Q==
X-Google-Smtp-Source: AGHT+IHOKWMEzyu46KKsaJPjgo0xgycpcDzWx6CxVzgF6SZy+41yLFML71qXIxEHlqlltMpTlo5GzA==
X-Received: by 2002:a05:6a21:648a:b0:231:4bbc:ff09 with SMTP id adf61e73a8af0-2381313ca9bmr31553876637.36.1753157449486;
        Mon, 21 Jul 2025 21:10:49 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e2c91sm6537501b3a.5.2025.07.21.21.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 21:10:48 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:40:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 0/4] MT8196 CPUFreq Support
Message-ID: <20250722041046.lf4b267bmolm4exq@vireshk-i7>
References: <20250716-mt8196-cpufreq-v3-0-d440fb810d7e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716-mt8196-cpufreq-v3-0-d440fb810d7e@collabora.com>

On 16-07-25, 19:51, Nicolas Frattaroli wrote:
> This series adds the necessary bindings and driver changes to integrate
> MT8196 CPUFreq into the existing mediatek-cpufreq-hw driver. This
> necessitated two preparatory cleanup patches to the driver.
> 
> The CPU frequency was verified to actually be changing by comparing
> sysbench cpu numbers between fdvfs being enabled and it not being
> enabled.
> 
> Enablement in the DT will be done once the MT8196 DT lands, so don't be
> surprised that no node uses these new compatibles so far.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
> Changes in v3:
> - bindings: changed title as per angelo's suggestions
> - bindings: dropped the fdvfs magic register range
> - bindings: dropped redundant description for #performance-domain-cells
> - driver: made fdvfs frequency divisor a `#define` instead of part of
>   the variant struct
> - driver: dropped fdvfs magic check
> - driver: reworked performance domain resource offset
> - Link to v2: https://lore.kernel.org/r/20250714-mt8196-cpufreq-v2-0-cc85e78855c7@collabora.com

Applied. Thanks.

-- 
viresh


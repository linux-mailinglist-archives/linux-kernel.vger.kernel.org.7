Return-Path: <linux-kernel+bounces-773223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E810B29CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2F4189559A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFD5307AD4;
	Mon, 18 Aug 2025 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="df3D12z8"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F881304BDC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507323; cv=none; b=mJfWNJoSkNFPWtUVrefye8Qn4Tp3ezbi6NJH4Txdb9iMJ5XwNUcFNy3+d0aAoi09TibOE6vHDIgDLbmhBIHC19xuBml5id9KB/oDozKV9um5mpYbD68MdJq148zmQxC+mfsEE4RRyKOKJg7cm/ueovVMMHuJr+MDNJUalmPPDvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507323; c=relaxed/simple;
	bh=doHN6EunE4q7NHlaNCFD732IGI30PIFL/jWt6aNwl7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNUhtaj8YMT2l8qD8T/RJYa/w6XRpJkr9G75Ia/yArxwDYEpHCOSsX35STbo2lDBdUf9S3EekUCKb2Ks0wmA9DSo0evbvAqloxh5uWaUSVCpKLd2srSjo2C1ZJMYJTKDljN36ep7VygSQldlqjjIe8OnuLDO8qdbFnLvjzTfdS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=df3D12z8; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4743621044so542842a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 01:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755507320; x=1756112120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZn/2dNIEW/eVFC5JfnC1aipczmqj7uzjriC8bPsWpM=;
        b=df3D12z82MVMhgsPXGUVgJaQC/OJnuqLR57UTGn6BL2o3il38p3Crpd2pcBReCyM0s
         1vshYXWzucKA4YmZxkfswh0ntUBwHAqmUudGvuaTDTfdG6J0FxLTpQWdmuL7WtHZoDCJ
         EZJWeNExogFV5DWN9duma+fTuMzVpIF94rhsDLmbBwW4WwGYZUs6UqRrWs0GtGL9sZhc
         FG6soKSradjdaxELBs7Lhd673NHlqAIcFu+p4wMkoVlIIiS9XiSD3wd5sgfOKltj9CLW
         XfZH7b32d8Y5QGUOCo7V24+me3NFhb7jXeYVrI3BwkBc2Y8UuwnPh14xcJNm+hGOWGTV
         tvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755507320; x=1756112120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZn/2dNIEW/eVFC5JfnC1aipczmqj7uzjriC8bPsWpM=;
        b=WTT6MKe30BxQq2aAvw2I/Z02+gEbIMmraY6z8Rxf8qtXY0zrIsBvkXyAWMaZTwtPJZ
         3AWgnk4IdXKntvcILudQjMIlZw1Oc12S2JUj3kVk9xN9KJfbUdb9OoliyeWQvO6D6z8b
         gG4KK4wk/hsr77sDJvuS52ucjNL6ySPwmR1sQ/3wwnF4zfdMNYVz6tmjtMklu/K+nipP
         a0nGH7hsN3vvfoRp/A0eWWsE9Cii8f8zP7yIWxnI2WHBqyrYXFGRQHpbIjQbYE0P6akA
         KXbAguxaRmxrgYZcJ+fWIi2WfCwHxBFz//9gIhyWvQcNtLqg9TtiPM8p84h+jClxk0/K
         xPGA==
X-Forwarded-Encrypted: i=1; AJvYcCWVrDasPGp6mUOthW+iPxVsgTMQDJiAWTGSzLRoNPBT62uAR6qSwnEqB2Um/zraI/z1mxpAR8YT6NtNOUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZQvjCMXMGc9ehd5s29Bs555rXK999H/IvaqICVPzgAR9YlfHy
	P85HFA0RMNxntzzI2cT1JgATscXliJl3h/e4YLFxVFOBzJlOoiEQddr3u78Vefy314o=
X-Gm-Gg: ASbGncsN84fd7FEsWa49fOCbM440FGfdp5lEVq5ic/7F6d6aaweSk0BfWFtr/IOZ0QB
	sZW5u+omD2ZgYUwcOuif5h509vMo6OeDkfbr83KHHngNWCfovFOAMHj2xaszGS/c59AfDeQrcSq
	ka7Eao6Ivl8ZxXPwo9tQc73t+ED3a2QjG/5o5orlax3c1MY2S5w0lkhJin+t0Jij2bPhd88Udv9
	1UzmO/0WfUHm+gv3gPs5S8zmr/NonhTbHiv1kzGn2mfXNy87wUU+V5pi9X6ehgw+3Oz3n1LTfkD
	kaEAo/OvmY7Yju1xJ8Of0DgJ3FEjEgMpBgXGwHW/DWzK8Z9tDxA/d+Z0YI6JOJF968uTY/1NjL8
	eqmwuxo/qF1zIeDABzrFH2HU7
X-Google-Smtp-Source: AGHT+IEwAoFmY5jt3W71l+SnRGhFYQeBBiVkuaX1UqUzqxvAN/4+HpvtbFxN/YglucS1GoqaljzKwQ==
X-Received: by 2002:a17:903:1c9:b0:240:6766:ac01 with SMTP id d9443c01a7336-2446d6f0386mr165051835ad.2.1755507319891;
        Mon, 18 Aug 2025 01:55:19 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53eec7sm73735595ad.118.2025.08.18.01.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:55:19 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:25:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PM/OPP: Support to match OPP based on both
 frequency and level.
Message-ID: <20250818085517.dj2nk4jeex263hvj@vireshk-i7>
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
 <20250818-opp_pcie-v2-1-071524d98967@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-opp_pcie-v2-1-071524d98967@oss.qualcomm.com>

On 18-08-25, 13:52, Krishna Chaitanya Chundru wrote:
> +static bool _compare_opp_key_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
> +				   struct dev_pm_opp_key opp_key, struct dev_pm_opp_key key)
> +{
> +	bool freq_match = (opp_key.freq == 0 || key.freq == 0 || opp_key.freq == key.freq);

Why !opp_key.freq is okay ? If the user has provided a freq value,
then it must match. Isn't it ?

> +	bool level_match = (opp_key.level == OPP_LEVEL_UNSET ||
> +			    key.level == OPP_LEVEL_UNSET || opp_key.level == key.level);

We should compare bw too I guess in the same routine.

> +	if (freq_match && level_match) {
> +		*opp = temp_opp;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +/**
> + * dev_pm_opp_find_freq_level_exact() - Search for an exact frequency and level

Instead dev_pm_opp_find_key_exact() and let the user pass the key
struct itself.

> +struct dev_pm_opp *dev_pm_opp_find_freq_level_exact(struct device *dev,
> +						    unsigned long freq,
> +						    unsigned int level,
> +						    bool available)
> +{
> +	struct opp_table *opp_table __free(put_opp_table);

The constructor here must be real, i.e. initialize opp_table here
itself. This is well documented in cleanup.h. Yes there are examples
like this in the OPP core which are required to be fixed too.

-- 
viresh


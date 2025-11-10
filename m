Return-Path: <linux-kernel+bounces-892911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 560F0C46188
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B9514E508E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61553306B11;
	Mon, 10 Nov 2025 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FERCo2PS"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C83074A7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772459; cv=none; b=avMir2YJqxd9deGTyXgGz8yE8ieeZitrYJW+jMqCTh8Eh3GRB/lBsc+tHwk5UQOtucrC57y1wRSQk8q1aMkl/CQYdVeJnrcRDnb1vhbXvBzrC3CnJGuClG1tgLc/A9BfGYlFzwXUMzSotG6c0C1lyow6756BXgJtTYQ9kyZwSzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772459; c=relaxed/simple;
	bh=j/sDhA1BE/crBk5MB3jz5Gyqsa0mwcEpYJuOnY+51Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IigYcS/6/YJW7H9yQ0/kupKQkIx0EPZ6cfKVGUaG1DccIvmmcuCgRJJIlhifoU7eINKdyNX0pskgipHVqlo9T6Vsjchw1EgxciD3KQHtK8CSbUP4CMWhmTz7K+WUA1VHQrd/eYrG11kL+6GLKwNKJ6lUEHf6fLlDuGlPKs1GCfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FERCo2PS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so1048845b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762772458; x=1763377258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YrIRy6Lhq+4eE5yPFjSN9IOBDP8Cyczj9KXwJvvJFlc=;
        b=FERCo2PSoBNQtTChiehfpbLnw50KiNnVz+AkGOggeiHrMtC0lXCfB5/Ml9jmkM32By
         KIzADgVhLjmlH3Yqjxqz8N7B6c8j23rlqG5wCIlkT6yr/CTVvwNqAOK7srMX+WPF7ZgT
         HMeF9c/0C4iU5xAj2OUreuY+fs28qJJes8O9oNFlqKyETSfoGh3d+6KvgsOc1WsUuV/H
         gp9lu0BMOOFuekHvAh1lSggn/wNJdH4xsRpafFrz7yYEm0oW0MILDLY5tfXwvMj6LKYC
         to5NW3Oh44oflBCtq+mPx41g1a+hJs57ar22wZucpypChkZDo8OrMPVzZBcevDyzPRkW
         bKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772458; x=1763377258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrIRy6Lhq+4eE5yPFjSN9IOBDP8Cyczj9KXwJvvJFlc=;
        b=GV93/c69MWjeraK4buAtWWmxtkIO8HiJVBykLsMyB6Og1sVcJkClVdiK5h5H6fDLF0
         P90jPW2+a2yxN7SVrgSJO83QVvFBh+Kz8qPjfesEhWZKYdsiok1yCGHbaZS0PfKypMza
         GMB8kzd0VRRpf5y6ZbXwNizoymT4AYby5xpOxGLWoI054yh/siKhnARs1DeJ8hkFlGIA
         CGNpA4yAr/gKabPqTUZ/uhmJhCMUMXoEUeXOlZqMFK4ph1PaoTd2e7NtrJRFHA1kb9/1
         6ihvNGEN9R3dFm4cT3+Y9108qqT0OWjSU7ggemxOOApLm2Kzy9VAQSLTrbKFBpX1NxxE
         OJpw==
X-Forwarded-Encrypted: i=1; AJvYcCWRmbIBwrH7b0VW3X6y8Ip/eVh5uzM9bCgJikjZpGKe86KmLnqWCg3JF+vPzn+czNSWSqojtDcG3ugKGDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypj72afFanyBLIC3cVW/IcPQ/YbeGUDMhcPxABgZu2jVRjOb08
	OBxNikPp2t9eNUZU2fPInkZEBAQu8P1PodZFwrrMYgp3bF/mqPPN2LrDwtyCOExdH28=
X-Gm-Gg: ASbGncv8ZiEFBFMonS1mtDcJJLsvvIF7ZP/rs6aHi8M+3UyZwqmb9fYa7sTwCNUJOMW
	/3LMAvaDS7AQ/bXi0giBw2GR1mX8p+Zx/2oHlltFWX147PkHl7HKb2XxJqm4iZugQgXyqM9zWuR
	Ot9bgmQCa6beLsg7F9IODJyagTzMhdILtp9KPP8OOiBsqMsEGNyG1f2WchjfqFYvseDKUFPLRKF
	v3W4wMm81z18M2y7f08YB5RPIKEmvl9sdaQI5ZQJfvnaJdH4bEdSmiTgLfCFBhXmaBwoIwGpWUU
	h70K/ItGi2f0uO/53tsSmJePO2fifuXbJZfmwKdpRY6JM6qEIummd/ClszeRq7bgYD2PHhXj2MH
	1K3tftOErt+ni+OxaJgJ/SpgnB/+Sr/0b1jPIPPMbc6KfhY2UAd615fcBRMXXvgHFpKmM51bdWO
	d0JL6GbtDxtXg=
X-Google-Smtp-Source: AGHT+IGOFDbu7mquDmNhSqV97BdY6cG6MLgvb5Xp7QodBHXn8La7j+gNEL/xmdVl7cozIyrmwIAy9g==
X-Received: by 2002:a05:6a21:3291:b0:350:1872:7023 with SMTP id adf61e73a8af0-353a4163b2bmr9937463637.55.1762772455121;
        Mon, 10 Nov 2025 03:00:55 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c963586fsm11304602b3a.10.2025.11.10.03.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:00:54 -0800 (PST)
Date: Mon, 10 Nov 2025 16:30:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sumit Gupta <sumitg@nvidia.com>, pierre.gondois@arm.com, 
	zhanjie9@hisilicon.com, ionela.voinescu@arm.com, beata.michalska@arm.com
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	corbet@lwn.net, zhenglifeng1@huawei.com, rdunlap@infradead.org, 
	ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com, 
	perry.yuan@amd.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com, 
	ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com, bbasu@nvidia.com
Subject: Re: [PATCH v4 0/8] Enhanced autonomous selection and improvements
Message-ID: <hjrcoq7dapqcodk3iiyvjeuq3cwvyccqr4wnlcoi6eduqg5ahf@tszrjvfnkjux>
References: <20251105113844.4086250-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105113844.4086250-1-sumitg@nvidia.com>

On 05-11-25, 17:08, Sumit Gupta wrote:
> This patch series enhances the ACPI CPPC CPUFREQ driver with
> comprehensive support for autonomous performance selection, expanded
> runtime control interfaces and improvements.
> 
> It adds support for below:
> - Expose sysfs to read/write the Minimum/Maximum Performance Registers
>   using frequency (kHz), with internal conversion to performance values.
>   Also, update the policy min/max accordingly.
>     /sys/.../cpufreq/policy*/min_perf and max_perf
> 
> - Expose sysfs to read/write the Performance Limited Register.
>     /sys/.../cpufreq/policy*/perf_limited
> 
> - When toggling autonomous selection, synchronize the policy limits
>   by updating the policy min/max.
> 
> - System-wide autonomous mode configuration via 'auto_sel_mode' boot
>   parameter. Mode can be switched dynamically on individual CPUs.
> 
> - Generic sysfs helper functions to reduce code duplication.
> 
> The patches are grouped as below:
> - Patch 1, 2 & 3: Improvements. Can be applied independently.
> - Patch 4: Sysfs to update min/max_perf. Can be applied independently.
> - Patch 5: Sysfs to update perf_limited. Can be applied independently.
> - Patch 6: add sysfs documentation. Depends on 'Patch 4 and 5'.
> - Patch 7: sync policy min/max with auto_select. Depends on 'Patch 4'.
> - Patch 8: Boot Parameter Support. Depends on 'Patch 4 and 7'.

Beata/Ionela/Jie, any feedback on the CPPC changes ?

-- 
viresh


Return-Path: <linux-kernel+bounces-799958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E88B431A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9E56808C2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3698123D7C3;
	Thu,  4 Sep 2025 05:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ke8g1+F2"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134888F40
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756964225; cv=none; b=pVTRGPVam6yLUUKW4+jZfY+h0iHSjpGM1vzdV+OEODOW0PX3JbhN7wUcX7/fYjUOwkFn9PQJGKxIKgTQqutQ6I0qnNp29kS0MF3EU0oK56D6bnrpzijldFBSbhRG8uNIgXL8FGxuE9AX2QTexpIHTtj6hy7JwOq4I8eYhl0XnOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756964225; c=relaxed/simple;
	bh=b/a2yCMJq8KSVArlkt++a2zVi4wOLEM4CymEyHYWhJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LD4mZGpECZrsdF4VApuJo3wxGepUnzch2JFgcrkiKcBv6AVvdRfWGyFo5CQzH3nAEdIgm2zlRUkofJqn/kqrEV/8y82srLOO9/xRwDWkPV0zSxAc+396R4sLLyF38NzqPHwafVUshdOo9Ab0Q9PqEXZTclaILwLVxbOvaogE3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ke8g1+F2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-772301f8a4cso928210b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 22:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756964223; x=1757569023; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EBf1R6dd96LkyOGtYdweLqxruOgKvQ3zhyso28sYrAU=;
        b=Ke8g1+F2ja9KN+Hn4KbFn5qyRDkNn7NZqmGsxVkt4n/EJc2gxEswOEk/4AHLE5QePw
         6D5r+MNGaVIfedR2QUmYKJWc29OsApzzb42+3pArbH6VYRFc2GKevZBvFw9vIDyBFqlj
         ZPkQ68+bx3OjyXvOim9lXqhz2dYwa4/yiaMudMfs7VvZirC3fWKRbCjwBGBavZQBCybk
         1sAyBe6y3o1qXkwWMJzIqlo6VcVWf74TkLJXvIJ5u3D/QGMwWiUMlTShzf4RlRsiR/NV
         kNJZ73HV9CZm2hNNeaVm253GvN6MJ3Pz8EcJ/1ILUy3yP7d8+HyVEp0/DF15qmEplfIl
         Qdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756964223; x=1757569023;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBf1R6dd96LkyOGtYdweLqxruOgKvQ3zhyso28sYrAU=;
        b=k7AIo1C77j+VDG1Zlg9YR9Ze5muga1lPwb1GnZxFeJnObZ0wz9beCncSNg0N1xTObC
         XUv9xyzhg5YxXCMi4eJVSVLh9HsmvG8YityGAO43OimmjtrTNDkiLSIN15a5tIe65MFF
         +W8Kbgo2Y0rJvol1lHSz1PbiVlg4YLqxtP0gA539R24k2lUG4iozgfVTk9mAhkSGfwjd
         xEkmwbLiap507UnOKWdlI7xWkPE486BRluoujjRkcDXNR66nWWoWammBM1Dr4ngitju6
         HpqVqij5QhoVrg3JibzZamrPj6MXmgXLlYaZC5oGm8eFEII73GI8vwJUVgAOI73Sc6OU
         EvUA==
X-Forwarded-Encrypted: i=1; AJvYcCXHzlUeHIsuro3Gq13E90Eg9XkANUYXw10hF9sWt1wflaaduzVOQ0z1mrFR784ybBJ6Y5vLrcw/xQcUmEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfpyiUxsljPJF2pld4oSOv0soib/YeYT/vaj96yGht6LQIqm2O
	2S9Xregp08wUtGx8LzI5ygfiCDpRsQ4wn7haijdU0KwDT81MO4Blh4g54xWcxK3PLsg=
X-Gm-Gg: ASbGncshkN/2MrlOG0ft8YVy6yxq2sYRfaLdalKXuNWlDcf6QYj0cMvb2WnXtD8NE8d
	zUFmc95Si4yWhtTNhQsm2HVqY4jf807mByeQ2OT82R7avcjC665JM/9MJBO1tsIpV6XsegaYVpU
	erF5zR9DfQVYXR6p1jDiR1V5WGaV3NMvg97hXHeH+X3kndHYOrY/BJQNjiHUmz2x67PunQD0LSS
	/pYvWlpAjbggd9n9dchWFp6ufQ3uj6Jb+2rsm+nMzmz+vaSs2US02ltBXPJJL/8NiS/aov69nax
	0D9o8BuliWwUUDhc0yeSL5zosEJCnuWlS9blNp9KvzpQXYPO/Bag1yVmlcDhp2n3V6n+Rdl9bcO
	LLxoWy8ohYr3pYeceKxUWfA4O7Mt14UyC90A=
X-Google-Smtp-Source: AGHT+IGYv9Ir/Bw5lHB3i4/uKJRbACnb4yPE53+Njb3AnK4qpxjJlR6XcFtBO92SmhPZXbDvwrNAgw==
X-Received: by 2002:a17:902:e5cf:b0:242:8a45:a959 with SMTP id d9443c01a7336-24944ae5ff7mr238904595ad.47.1756964223270;
        Wed, 03 Sep 2025 22:37:03 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249037223d7sm173520045ad.32.2025.09.03.22.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 22:37:02 -0700 (PDT)
Date: Thu, 4 Sep 2025 11:07:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cpufreq: Always enforce policy limits even
 without frequency table
Message-ID: <20250904053700.abdkh23zwi5x65do@vireshk-i7>
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904032210.92978-3-zhangzihuan@kylinos.cn>
 <20250904044812.cpadajrtz3mrz2ke@vireshk-i7>
 <540469c3-9bc5-444e-87da-95dc27fc481b@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <540469c3-9bc5-444e-87da-95dc27fc481b@kylinos.cn>

On 04-09-25, 13:23, Zihuan Zhang wrote:
> 在 2025/9/4 12:48, Viresh Kumar 写道:
> > On 04-09-25, 11:22, Zihuan Zhang wrote:
> > >   int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *policy)
> > >   {
> > > +	cpufreq_verify_within_cpu_limits(policy);
> > So if we have a freq-table, we will call this twice now. Why make it
> > bad for the existing users ?
> 
> 
> Just to clarify, in the third patch of this series we remove
> cpufreq_generic_frequency_table_verify() from the table_verify path,
> so cpufreq_verify_within_cpu_limits() is now only called here. There
> won’t be any duplicate invocation for drivers that already have a
> frequency table.

Maybe I wasn't clear enough.

int cpufreq_frequency_table_verify(...)
{
	cpufreq_verify_within_cpu_limits(...);
        ...
}

int cpufreq_generic_frequency_table_verify(...)
{
        cpufreq_verify_within_cpu_limits(...);
        cpufreq_frequency_table_verify(...);
        ...
}

For a driver with a valid freq-table, we will call
cpufreq_verify_within_cpu_limits() unnecessarily, isn't it ?

-- 
viresh


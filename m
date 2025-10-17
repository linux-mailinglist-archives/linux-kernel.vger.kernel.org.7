Return-Path: <linux-kernel+bounces-857226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167CFBE6407
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE1A6223F0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B33530C60A;
	Fri, 17 Oct 2025 04:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yH3HiPNV"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586772E2DE4
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760673903; cv=none; b=eAqHa6OeI+a6vfiJd8bacC3rfkIPhoPpME1Awk4lTOyhu0YXQTj237TPcWAl/8UHyYZc9Q7OpUF73yJScubU13Pw5ZDrZ/1Ou0rQZsJjUY8A4b5XdYK7i8m9q1ZcdMLjpAAI1ANk3GLwggVWEvVwmTGd8i4LpXaFIcECbJCrvng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760673903; c=relaxed/simple;
	bh=if0Z65l0iVhtqX7EJ2LAVIPGjJ2azbvYwOOzwnLay28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiCl9M/5jOragM0yw05ORTqRlCUWto64M6Nbo/OQLlwZWD/0iCcL4U0GQKRCUTVpNOVH9f9a6jpRjvgriekwYEy1QrmLwjp5oLEuWLnJfn30F9caKvoVyr52ua+Vyhpu5h3iQgooqFFNU9ZMLRTcsMCDc/5MfAHauT0eZiHZP0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yH3HiPNV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29091d29fc8so15978245ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760673901; x=1761278701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0yTr8XYfVKTbUORpK+gdA/VSO6LmqQtreJ6mNFyN7AA=;
        b=yH3HiPNVqT7TeMPYZQ8eVgmKeW2i6SOA55ddHBELyM89fNjkyuP4hqXPVItkNThNJh
         mZ3bcpFim9K1Bsygvbqg1wm83Y5WQYhG/yy1vlNtNwGa3cFI/l6RL7Gtt2mdd0V1wBI4
         GAbSqmHJPSzGW12Vgl9gW3dIRMBgUA3Jvm80k1QPpBvQ6EJczV+Zn1/gkobOs3L0rc3K
         6QzbnsOLVYOnyjWUzOLg2XppJzD4C65eCBPgL1ncrPdWmY+a2NepMMlG7b6KCYMetZV9
         4OfQgGd45kS2wkxO9Ga6GcoY8+5bgvJ1hkXudq3XcKwKpgOCJVzNOxuXFhcPYpvsqJ/h
         TCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760673901; x=1761278701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yTr8XYfVKTbUORpK+gdA/VSO6LmqQtreJ6mNFyN7AA=;
        b=MlGwI2o3qJbLojh+m0elWeSlgQMzCqIyv0S0H8A13tNTpc3n0MLHrDGi/S0UCpmG7J
         aIGauGfVuLRW5ktftxM50A1yvlgmP50ijnc+OVgkzNf/QVSp53f7NVlqnyids5DjqFz2
         cIT9oNvap90+EAvhVNrP5UpBguk3S8z7siMFnLATdNEDBEnUslPtcjtV1kc9XI1yKeke
         FKOzPcNBNH+YsjbJmDw89Ismkxe6yUSJ4+Uawf86pBgT0glGaAzLdhF88rses6JCtGHY
         /HgAgkjdfkp6SEJhfNDB2nlGJjujQ+34EVLfkUTAUW40Bv5BcqW2KfBlB6ScjOZLGneC
         U/6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbimK5wSvmfHeLOm/KwhcSCxYPgYdOV8o6xLnx7xGApKfNRuN0JM5Io+XUjxbxVwD3osQNcbh+HBbv1PY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6S3xn+wn4UB2VY/eJGSfmdustysNCB4xmRZ6/RRcHaJAaYkBe
	B7Xp0c9ygieLT9csYV00pusDdTyw+/wtU7mOqiGVl4oakz3irw/OV6udss6tN0+6P9U=
X-Gm-Gg: ASbGncvksCr8OzsnRJ0rUZ2uqxSr0ktelFksV+j8lahmN9JF7NBP2+5aXh/kHspetfG
	ZZLCkOxbvb2pb2qPeJ9NYfR6Kiv3adXpUBTwXDsonKiIaJLYaw3vt59I7+oXFOrgWlGdtRq2LLf
	btKSVYYdtFMlFWHronbzlQiU4k4Z3J6CwSNb3Fg5JBces28IkugOMoCQW7qJajD9+EUBHAyCx9P
	CxkrCBp/GnzT3Mr1A/1bOWt2xSyyZde8tu7j3CxSkU5uGGmaCe2gjnYEC0CqEDjal8kCCCohY1/
	L+YmidZCbjDaExHhWkZHX/MrMJRcL9/+Kq/oqI0Zosyl+4gPQ4yaDTbocZGgzG5DmtbPevwiOiM
	8ADvAJlb0ZGF3wNbwNXqEva9hDpUkeiYejABhQapBFVrPdC3Hxa227/VSR3j2+0BIIMS2eddw1N
	OcSQ==
X-Google-Smtp-Source: AGHT+IGPSjlNzo0y0i/+GbYPAiFlc7JbgHfBpNrj/C4bxPOi+I7rIKsQiv4+wobJzyD79esO6O++kw==
X-Received: by 2002:a17:903:1746:b0:28e:7ea4:2023 with SMTP id d9443c01a7336-290cb07d430mr27595565ad.46.1760673901015;
        Thu, 16 Oct 2025 21:05:01 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-290cd93f570sm13832535ad.25.2025.10.16.21.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:05:00 -0700 (PDT)
Date: Fri, 17 Oct 2025 09:34:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
	ira.weiny@intel.com, leon@kernel.org, daniel.almeida@collabora.com, 
	bhelgaas@google.com, kwilczynski@kernel.org, abdiel.janulgue@gmail.com, 
	robin.murphy@arm.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: driver: let probe() return impl PinInit<Self,
 Error>
Message-ID: <co76tfqycdxhrigoxv5expmozqzgq2rjzxvfkfwqzyvlplrfih@gsi5yarmilut>
References: <20251016125544.15559-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016125544.15559-1-dakr@kernel.org>

On 16-10-25, 14:55, Danilo Krummrich wrote:
>  drivers/cpufreq/rcpufreq_dt.rs        |  4 +-
>  rust/kernel/cpufreq.rs                |  4 +-

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh


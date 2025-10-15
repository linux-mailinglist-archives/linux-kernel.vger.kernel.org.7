Return-Path: <linux-kernel+bounces-854547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7008DBDEAF3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 030F1501278
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2837326D6F;
	Wed, 15 Oct 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JOI0xuUD"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6540A31BC94
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533894; cv=none; b=kekWbNSUkdYtjZYcF4zpuawm+kpaBGGVmmWrlMMla1qvdlln+mnKxdvhLdrYLFbIE5RPEONXFP+Gp6QNKy+GuHf+3DgzFF+C/08NaLemaB0Ob22ExA9Vp4Y4QvCLIQ8gi9sPeK//EtNZyo++IR5d53N/qbqynSfe7pH9MBP4dlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533894; c=relaxed/simple;
	bh=TNN71mayoTkmy8rd0PDSJ9nlu4EsONjvOe6eFy+t5ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bogu55LgZRk+zV3V6YiHsb3RR0xAeN46MklabWETh57Fmtp9ikcT+m6+jfA5SlcLQUC9GIAcj2AuPkkmuljlZwkYUV6Gzv1cY2WP1m40KyRPrlwgiTjJiF+EI7+nn6oly1x3mcep2G+3d2LAxKHzXx91jBQowPvaakCjlGPg03Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JOI0xuUD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-471066cfc2aso3788665e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760533891; x=1761138691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KSEXKmipGPjNX9UpQ1OcPNXCLJIBowGxqHQC/E69W1E=;
        b=JOI0xuUD0xScKu7yRljROe3KNMgEatUh2Robg4Dg2gAddZtwlzJaa96bdV/ZCZkVap
         oR5ie552WvYnBhRPG7LhHZm2gPgSYCKcWvPQH8A5SuRFJ5y6DsG66LRxDhuH8XwsHZSv
         u5E462/5bE/CQ9evoUxaMrLZ9K5hCv9WRGwnbqK4/d6/bRT9zGiiwpFJTUvlEzH00HuY
         b8fGUVl37gftDO5FlKsv2SHq/ZTNKcHC/md7rQkXk6O/8FlGUKNq5RtP8aHk641ymllu
         0qYjEU5dSMA1xBei7tOHn4FLEdxMK8TdZ0a/tW/xZK3WxIQVdeNwY+YFk4hWt5QSMg61
         kpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760533891; x=1761138691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSEXKmipGPjNX9UpQ1OcPNXCLJIBowGxqHQC/E69W1E=;
        b=SgXx5OPzrO9tD/AnbGS6nTVpbCZLhpqmnjoPGa9r+NzFcgXlIaMVfF43pyp+CCBlz6
         nrPxUQ01asbkS3uL4Pq4FcVXVMAQegLZDuW7AqV3LRN5SbBqPzovZ8gPDlTk75Qami+z
         fiWSrlRJBA9McuitTl+s3GA7/FFq/0EtiCgKvqGXhw6j201W/9jm1ABaEy4gIDyezcBa
         4iksEjfpzrieNTOj8dD/KQQB13ciiEqYRzWglhQON4Dq3g5+jfzWSOupBZxIEKGZtXm8
         /v4I5GQ2rIPTHD+wA2OJw2HUhY+W5T9yQjiv2dZNOW+FTagiS7XkJ4Dc3zIc21inIVr+
         kpOg==
X-Forwarded-Encrypted: i=1; AJvYcCV+No4DxdVA7NM+lzzA92CL3xM57oxELd+A96Iiu5b70j3MUNeCBgjgYxU2/FyafBABPH5Oj7TL0WlshJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZQsktsbpuOjdpts1dRh4tT7gns4SEmLt3lhNIfpdpgG4FeowI
	ujYM9xwTYK+qXaQlYBsjCaPFwrWreLItym8jRQfhpQVzbhxn1plhEN4oQsaWUXso3qc=
X-Gm-Gg: ASbGnctHBJkhjdGjr0SCVj7cElQpC2nYyDDDjjDxKyCNEddcS34ECgXaR7VqOEPgBUf
	5haO5+iYSTHUdxuxJOJ57zW4uhWRNQ2ADFK34Lta0isUjYf2t5HbhsQNy/ss0zM35ZlCYS/Vd9p
	Qt/MvtTUSm34yFzpPtZMzJzNqJDV0OW1IJ7GkNuO0ejidovPEheRFgRT49sybNOZWd3dfOCa+cl
	YwMmFoUmDGyVxo7Vm4Dlboqh1/wV1TDQbR0keCFhZbrxkCKwKLnrR34t1M+f6nokfhx9zYOhEzX
	QiBANLoFm5VUv4+SHD8HSOy6Mfxnz42t2ay1J0bCPh8rKuaUqwjZG5mzbPHTrtCK9DG3SjOqPJ0
	UiMSautgpflcCKlvMARxwWpaKexU9+k8/Lb6OAjMrm0hN1l6fBHDS6q8=
X-Google-Smtp-Source: AGHT+IHb7yqFd13CCRX2ZsPulLnmXAv3Os19z37S0V2UZLXAtIujA1Vyw8h33iB673wyOzI9vd+ODQ==
X-Received: by 2002:a05:600c:a309:b0:46f:b42e:e39e with SMTP id 5b1f17b1804b1-46fb42ee4femr110401385e9.39.1760533890656;
        Wed, 15 Oct 2025 06:11:30 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482ba41sm294145175e9.4.2025.10.15.06.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:11:30 -0700 (PDT)
Date: Wed, 15 Oct 2025 15:11:28 +0200
From: Petr Mladek <pmladek@suse.com>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: livepatch: use canonical ftrace path
Message-ID: <aO-dgBgwnkplkZtL@pathway.suse.cz>
References: <20251010120727.20631-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010120727.20631-1-wangfushuai@baidu.com>

On Fri 2025-10-10 20:07:27, Fushuai Wang wrote:
> Since v4.1 kernel, a new interface for ftrace called "tracefs" was
> introduced, which is usually mounted in /sys/kernel/tracing. Therefore,
> tracing files can now be accessed via either the legacy path
> /sys/kernel/debug/tracing or the newer path /sys/kernel/tracing.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

JFYI, the patch has been comitted into livepatching.git,
branch for-6.19/trivial.

Best Regards,
Petr


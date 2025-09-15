Return-Path: <linux-kernel+bounces-817235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E01B57F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B190A3B85A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CC233EB10;
	Mon, 15 Sep 2025 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaSq6V5I"
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4B333CEB5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947922; cv=none; b=GOGqFFPS83mjBUbAnQyCcvzNQzs+wAWBkkJaUWe0CpGWZCrsI7JNWKC/A/Lh4FJp3oFAboRdWbpkRhBdEJ6NMAjYTBgu8A5n4+lLML4EHqb393yypYNDNHJQOwKF+6upV9ngpl1HEuvOway74D6J/ap7UN/XCxmQ4rFMdg3Fm4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947922; c=relaxed/simple;
	bh=uFptEW9cg8S61E+y2uh5ogEGKkvDUbD1fy4yddAhBVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgqh2ZEPjP8Q0HctcyFH8P1GTNtaGToTV//q+jZKwKAP3uoQrVgI6vN6gTDACkMO5LhZmYyAf1rdKFvhx1vD7RjcSU4wh/bzKr36fY/zYcdHbOvVci5DDtM+OhQc7duOm4FSAjY6VWsAaSo7O8oJ03TKmXsS1WRPsOQpdQd/Sko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaSq6V5I; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-62bb2e28ba9so1203146d50.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757947920; x=1758552720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qAlpp2q6p0FpxveyekskbKJV1WmCNzmzFjExvczEyQ=;
        b=MaSq6V5IzAnW0HdCoF0Sblj9P5sXN5rnDG9wG2ciOtaq6Fslbb8wy7V5Hz1VrUPyzV
         nrRr7b0mmKueta8QxPi2RpWHdoV2jv6YR9Sa+F6YIsXYznJZ/jr/RyfyQZ6SsGiLmVTs
         os/BmfB+7Sph5hbHzgZb5vi7FO6dsJSfcuI2j3G3FBM8bMZEY5WhBc/UK6bWPblo7pnh
         6+Vb43LIFeW0RXt9WQlXsRXRkbdSExfN7FM4IJCz4yzIU4PdLI48oPqR2aZI/UxR7OCd
         zI3a9OyKK7j/MnlzJMzve53CRqAvgAH1AIaupbxrznA3AmJleTeQXhWBUU0UmSbNLhPz
         Ohqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757947920; x=1758552720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qAlpp2q6p0FpxveyekskbKJV1WmCNzmzFjExvczEyQ=;
        b=fmPj6FuLSmT0FNAuTpThASD18ESL6ufZmnrGpfK5q6laVuOgtlEUnx1SJqwkDizEOT
         Ae3JhoWIj7mRnInSyXQ4UBLqrjjVoOHar4opq7ed3NUphycM+91wxcs3JmPB1qQxnisp
         4AdQxhpaVW6ZsWzf3f2B4pHtZNyXOGOLNPjyvru2U9BRrm3XQhqbnxVtotIPH8p2F3No
         GySBVKP9R6CD8bLnIBaLihf4smJQS6DNg77GXTLN4xYywXTAmiiEsVTUha9IQ2VoypTX
         JE3JtrVRLx9Gw+Vobiep64xMII0RyaP9yYvVQc8I+rZFHo2KkxHjh/1J6AginpqReDNh
         UrgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXStaoHOgQUwG1kKXoZ7T97cEvuEjKJVRmBqkG0jWk2COVMHfkzrGnzdH0iOqxM5aHM30sho9BmGLNMQ/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyURDWFeSMpcj0m523qXw7T9E2acAvgIYl1sk1u6qdEm7nnHRUM
	K12gqu/mWG3vr0TmLz5ChZBsVub7evuq/tHFOzOayk0LTOQAWWweFQ5Y
X-Gm-Gg: ASbGncvISxHO/QNwzunMuwXqwYjZ2oizheCrXMDfNhdNgsJ/F9ObbEhyVFPnEvI55gN
	JTg6N0/8N1uwdebFLgMzL4d0xlyIRXO3REV0o01jamq5HUlX2Kmb6Uq5gHq1s0DaFb6pkxvdu+u
	b1cRyDVbctmZnvEmREdJVxOKjnrWGQvnWRjZR1lVweLbOv8nbA656JiIV89entxd2HiTSlUzGzx
	ZUk/tGgS+qKCWAaguIT6AtuYEtXvjKFyoZQXbFTUwKwGnfnBq59Ru2hE47Kb6WPwk+bm8NKb8iL
	aiwoBSKh3YTpaf1F23bR+IDwTKXMcUzPC6BBu0Q9fu8Vy4qlBCdof9nxRIKr7JBPrKxxgtOWc+7
	8LJRLWTdxW18kK9h5OaKdHsnrFPLOHZWNejIp2zSLDq9Uht+WiLimCeeUwI/RYNg=
X-Google-Smtp-Source: AGHT+IG0/Tp3b8E0G2GYoA6L3RRR00/SCKeeLmJaTBzviTCWD28HNMqArXMoHbpYGOzCSnzzapPt8w==
X-Received: by 2002:a05:690e:1651:b0:628:10ee:ab85 with SMTP id 956f58d0204a3-62810eeb27amr7094360d50.3.1757947919804;
        Mon, 15 Sep 2025 07:51:59 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f79794201sm32181467b3.62.2025.09.15.07.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 07:51:59 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/6] mm/damon/core: reset age if nr_accesses changes between non-zero and zero
Date: Mon, 15 Sep 2025 07:51:57 -0700
Message-ID: <20250915145158.1425390-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915015807.101505-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 14 Sep 2025 18:58:02 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON resets the age of a region if its nr_accesses value has
> significantly changed. Specifically, the threshold is calculated as 20%
> of largest nr_accesses of the current snapshot.  This means that regions
> changing the nr_accesses from zero to small non-zero value or from a
> small non-zero value to zero will keep the age.  Since many users treat
> zero nr_accesses regions special, this can be confusing.  Kernel code
> including DAMOS' regions priority calculation and DAMON_STAT's idle time
> calculation also treat zero nr_accesses regions special.  Make it
> unconfusing by resetting the age when the nr_accesses changes between
> zero and a non-zero value.

Hi SJ,

Thank you for the patch, I think the goal of the patch makes sesne to me.
I have a small nit / idea which I think makes the code a bit clearer, at least
for me. It seems that we basically want to XOR the two values's zero-ness, so
maybe something like 

(!!r->nr_accesses) ^ (!!r->last_nr_access) or
(r->nr_accesses == 0) ^ (r->last_nr_access == 0)

Can achieve the goal? I know bitwise operations are sometimes harder to
understand, so I am just throwing the idea out there : -) 


Anyways, the rest of it looks good to me, please feel free to add my review!

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index be5942435d78..996647caca02 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2261,6 +2261,9 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
>  	damon_for_each_region_safe(r, next, t) {
>  		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
>  			r->age = 0;
> +		else if ((!r->nr_accesses && r->last_nr_accesses) ||
> +				(r->nr_accesses && !r->last_nr_accesses))
> +			r->age = 0;
>  		else
>  			r->age++;
>  
> -- 
> 2.39.5

Sent using hkml (https://github.com/sjp38/hackermail)


Return-Path: <linux-kernel+bounces-821102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4957B80658
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1001C838DE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C132333AB3;
	Wed, 17 Sep 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pI7nT7cW"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D05617BB21
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121263; cv=none; b=D8ZyE1Ca88xo0Ztjp3bhthgSlLP/WqZUtsdO5SsOVv2ni6iIhKb6Q5vJwTRdiKETOLKTl2guKg+1lEi8uRs+MK2WDOa/X/ScbI1QOBQysSoUOP9jomtsXofa3ce7x09cDq9k48dVgKWOv0hU8gdV6zjaq8K5OmQuD6aR8thmFKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121263; c=relaxed/simple;
	bh=Hk7PlUV7DRaB6Y8+MXwxOd574HrHX06n8TKlKCQ5qK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVtdOMuZr+5lRjZuhZjHZshTwc5fJA0lvqn8eZQldoZI3Vzp7Ek4TO0HK7dp8rxDahgRHwEhAMu7VqCFkuwf6mOVDZSG0c2NKuB+TflNt9Wx9wDLYIKWFoh6vDxjBG/gj2egjhS42qNtamqQDrt+uP/4iJ9FrKVk5Z2yK5tQ724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pI7nT7cW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45f2d21cbabso68065e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758121260; x=1758726060; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PQv8x46eYXApZo970LUOsV6mmTMwe7go+DO7Uot/fuU=;
        b=pI7nT7cWpyHghujHfdRux1GJ57Y/Fes0XjTFLQnMptHYAWaMVGqN2KrxcEDqHUvhEp
         cxOTox3zZEPRb8MAzaVTwsz35vPoCD0Wl4cxmrwJYb4BVUOYvhbYdC/igJO+Tn/Wr4Nc
         WNFGk8EPg9j9zMJY0hg82zPqZFfqGrVgZKXWZ/rrrMpqEh8zlM/Urh6HkeAkQgI2YNya
         joC2thEW0lcWT1YVhH6AUqgWVlSyTizilikiJRFhV3qmCCt9GXlsmkQ3B0KjHygXc4qo
         6rHMoTM9Rv+6OGkYNpKn8MHmyR0ywkTbKae27ejunqKwAJdsJizc4lHmzns97dVL6UUA
         XM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121260; x=1758726060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQv8x46eYXApZo970LUOsV6mmTMwe7go+DO7Uot/fuU=;
        b=We/Mw49ZxlC96eFSQ1zEVX+SkvbewrqFOL/zIY5hA0Lz2zNtbcavJOCsJpvjKxwfW1
         O3mayAiBi/J8PEYbotE6fjvVCQf2aflkhhBV1opz5VliFJTgap+NWs7OQ3D/GyF2vkWY
         8o0oP3y6woA0mbPaUX2I3uxGpLTMkU12qjyN0G9tZ7mWk7EKiJuhJZ4Zjd5i66AP27fl
         HzSS7rHvJiSvnDIjVbLWm4sa+xlM0FuRCfd6wliSckdG9G9KaaUrmze+jf//lsUnlG8x
         5IX2fOznMGYBcU4x3OcJNcgKJD3jvsURONcZ34NHboFNs2q5ZOXWb+KamOkcNJfTIS0N
         AvJA==
X-Forwarded-Encrypted: i=1; AJvYcCWDR5L6Js4SmBWrBqZ6WM7IXfSsZBTuG04yB9A9WRJruZJxW9WsFpk1vKtAUitvEpsJmGQycSU2g0yvvak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKLPoFciCUm0SuEh3KkPNGf4cje9OJmE8NnPD/XvbtJ5fDm691
	s9nO2rr7a429LKYZk7s8NmZpFTMCGKGAZbY5WcmpUKS9CGJrLcOvKHEzf+khCow089kBoWEgGlD
	3K2T2uw==
X-Gm-Gg: ASbGnctRTsEaFel747/N/zmtIbkBP8Kxmb2PS9y8Wy1vablkStpPtVVk/VWe8RynCCP
	uiaHnZAlWwiPvMlz+kNl8tGxkxNxGH043s+EKnJYxscvMBVJFG7O1rJ/f68hdQSUvqNmCdS9gMP
	fYLb0KuVg1wik+tYwFUUCBb/6s5zH8RJd2p/s/kyBs2qShV4VnEJlrOeJjwPegiYgytIaXBClps
	63glIm+QSrTteqQdAfW9webqOZiQ8uFlZsGJJTk67sOAYosonvZaIe68dvk7Obv1lE+W/0I827T
	FjCxChfoVZrn4mL/wN7mmKWFK8tj/+j6mVzc6GdHDxcSti254nJlwYXyoSh775hVjaiuwdbZ5Ol
	Lmfx0LS7x3dCb11LZ48hGVlrPy24WYYB0k3jehRzuKswk3RbiAxptVyG8EZfrAjzfSjCJGA==
X-Google-Smtp-Source: AGHT+IENFLjDgY/V9nMPy/hERD3SF2EFRD4h9LqOWJ4wBVjA8e0W/iIDo4QRwD9b9SDaGu4uXHig9g==
X-Received: by 2002:a05:600c:4850:b0:45c:b621:9199 with SMTP id 5b1f17b1804b1-461a1cdbcf5mr875645e9.7.1758121260129;
        Wed, 17 Sep 2025 08:01:00 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-462d525fdb2sm18471915e9.13.2025.09.17.08.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:00:59 -0700 (PDT)
Date: Wed, 17 Sep 2025 15:00:55 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH 0/2] Move io-pgtable-arm selftest to KUnit
Message-ID: <aMrNJw3obyu8IvBL@google.com>
References: <20250917140216.2199055-1-smostafa@google.com>
 <20250917144435.GE1326709@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917144435.GE1326709@ziepe.ca>

On Wed, Sep 17, 2025 at 11:44:35AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 17, 2025 at 02:02:01PM +0000, Mostafa Saleh wrote:
> > Instead, we can remove the __init constraint, and be able to run the tests
> > on-demand, and possibly compile it as a module.
> 
> I think you can just put the kunit in a module to avoid all this?

Yes, I don’t see the point of trying to run everything from __init,
relaxing that allows us to use more of the kunit infrastructure.
But, it’s more code to do so (it’s just longer to explain :)),
I can add a patch in between, modularizing the selftest before kunit.

> 
> alloc_io_pgtable_ops() is always exported, and I didn't notice any
> symbols crossing from io-pgtable-arm-selftests.c to io-pgtable-arm??

No there is not.

Thanks,
Mostafa

> 
> Jason


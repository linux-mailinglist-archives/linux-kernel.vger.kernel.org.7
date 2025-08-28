Return-Path: <linux-kernel+bounces-790347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EC5B3A5C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C92162BC4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C8229ACD8;
	Thu, 28 Aug 2025 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiPR3XXk"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC7B274666
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397420; cv=none; b=gEocCxdACpNUUjcM42qJaP0/BuHymmJNxRAuiMk5PjmfYv2zIlsa1LshtTl/AM/Y0A0fjmv4aIBEBLg5GgwL8auNRf7DEm9MMUT++RFPkrdFmbDrxKYb6DOcIdZWYPfL78VCtR42FTwMfYjglNAuwL9Qpws5Mn0Ko+oZ1KbAyAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397420; c=relaxed/simple;
	bh=kOVKQaK8fXX3EdVsUxkmFQsK9WvZaywNwY3+kAGtDbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BB+IAc0seWbtppm0iv/d9QeeijjChpVQSlBbaZlkrcwYM5EDBF70Ct4yGpdb6V1iRpAOePAsbv9tUYkKRFNxqL9m2VrLTbysyoksMOsffzJ5uHTNPoEJ688POWQajH4JJWQUWkxuwy0sM28q6urh8qRdUFfqbaC0iw6/TbJUUKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiPR3XXk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7720c7cbcabso854789b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756397419; x=1757002219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nRTOW2045DXQQ+GW8Xk5izAs9xkstSciGXpe/X4tnN4=;
        b=IiPR3XXkkn7kSHlz4y7hiTjMQersDfYmXK4s8b3uS+YZSe1vddwQwCHFUJBfP4rZ49
         8NqDszke4mDmgUfPA/7j+o1ha+3ArSwyxEcccaRINy/WeQNuK1e9loinqtzgB2rCazFk
         w7FKaXp5pKuqWOzxet+ZyWOeti+2HGPGOZ3FIwvEJiL8tKiJ6ptWOLZ+ZuJ3VIznDDqY
         NqrykqyBrjQj6MElJp/7+dMgSNWrf+ZZoIEwVUHsYFUOdGNLhY+kJnOF17nsDLoC1P/s
         ruSdJw02XoSBbzvVfeqTTommG6XzU5EoGryt1ZPrBccbrvCnDLsfzV9kThqZ4T9gg7wP
         xKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756397419; x=1757002219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRTOW2045DXQQ+GW8Xk5izAs9xkstSciGXpe/X4tnN4=;
        b=nWxcZm4a4K9gMF46+E5ulxGJVf03/g3w7/Rvapd+FmiT9OqZYwwUFSKVfzlcez3orc
         k4Oj6Z5WnFMmQBc4lDz/W0auEq301604Oir4ywAoArIS2syeiEJe1cBSNddJhYkCFdZT
         po5jzfZzx0ftWxAy1chSetW6xqJdjwiLqUVjuMedgvN2I+dgJC2OxecGBMpMeZop9HmS
         uUFbOXjePaW0fpsV82e9/t5RkeWT+LCJhVstPTZ29Ze/f++Tmy5GUjdbG3z0haQ/OY1a
         gkvX0DdxG0LxPoERcztVWLkcCWqSyzIke3otzZjPcf6q/jq/LdLHqhtR2STKKVVpETR7
         p1pA==
X-Forwarded-Encrypted: i=1; AJvYcCXtquCWB+aKnjYJEeYy7FjPqzYPrrnMpMpTzeeWyovJ0XZRZEyw3zABuGw2phAISp/DV1Y7RNvNaTkmS+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Btq89xgcInEPc6rFJlEAEpMsyA3OtNcrk1wk0pZ6p6hAl2Kb
	gB24VKriuq7/xKA5HbQKQjMuSQiaC8ybEtV2JftrmNwjt4lh8OM+8I/V+gGlLg==
X-Gm-Gg: ASbGncsxZay20FKqgxEGVBzkK2jNl7ExYAqLAwiTmkB79A1nlrSOyeB2zY3zeOi8sry
	8Bb6im1ex9OHRU7ZwXnAMSXGnwO32qqv9EvirS61+6bxeVTksNe7tRfXFIGj5qPxzIUWW8KrzeF
	emTGyeQTebnA+jNpsOwQ25k3czqFXUmQ8Dq688WRov5XILGjK3AzWSFFV2aKNrnVp01/MNJgpHL
	zKkyO03yHYiq8HCEHbV6tUPt0gXekQC/c7yfox2+CVReJpvADFlN9rsSHfvFU2K47vHIH6YBBH7
	ZB8WMPmpZnSLDMRQNqFNBnGoK3InMjuJFwRH2kZb9e4G5MjPOs5kifbOYLb6AHqpuoZF0CX5Dpv
	ydLAdqhwIDPsdw9iV+AubMexRY325AIwRtRimtrRgZN9kFirum/FUPQ==
X-Google-Smtp-Source: AGHT+IGQ8xaVEq/0IKPq/hc5a9wL5srxZCFhCWzt7RsSEaXP9yO+1p1Sd5ZE9XcNBfx7e810X1mGrw==
X-Received: by 2002:a05:6300:8b0f:b0:243:78a:8299 with SMTP id adf61e73a8af0-24340e068d0mr32039211637.50.1756397418589;
        Thu, 28 Aug 2025 09:10:18 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbbbd1absm14421652a12.52.2025.08.28.09.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:10:17 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:10:15 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pagevec.h: add `const` to pointer parameters of
 getter functions
Message-ID: <aLB_Z3dv8dBYt-7V@fedora>
References: <20250828130311.772993-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828130311.772993-1-max.kellermann@ionos.com>

On Thu, Aug 28, 2025 at 03:03:11PM +0200, Max Kellermann wrote:
> For improved const-correctness.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>


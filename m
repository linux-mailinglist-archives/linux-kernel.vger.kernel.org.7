Return-Path: <linux-kernel+bounces-761887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4DDB1FFA4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE7F1790FE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009902D8DC3;
	Mon, 11 Aug 2025 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vgfcBgvU"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FF62D8793
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895192; cv=none; b=uG0jOxWT9z7Z/1nkXWfQ/waoVSFDVFDdiXnsclBpiW6BR00MGp54AiXYLx9pLWJ7y27Vz6aAV3Q50krU0Cn+Abr0BXWCkSaCP9aKy0o60CaJAsmFup3v9MTIpG0KJxDciczUTnhNCMjkEu+OeMVlbFtVGWmwipM3S2HxVdpr5pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895192; c=relaxed/simple;
	bh=xYbuFuOQE2iRVDFswBjY22aueZfkpLjtRD1jEbIWSZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDe9UfOgXDL2XK+YlfW90vFUEZxG0M2JKLcrEgdsO4VMIOnJbP/16/TG3EZiFIiA77SVzmEcBer4uJ3VtOJAPW6zPdgCBkftyiuqzN0O+EPYHhz9N42sbMgvrudE/loSuOGcN+6WbAdtLekQXDMLU4Dgl7JquL4pmB7V1UgFm5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vgfcBgvU; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b3226307787so3122062a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754895190; x=1755499990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+6IsZOxTo8GJ9RAKnkhWQjXljSbOqRKPbCsXfe50Af8=;
        b=vgfcBgvUEbX8AhNNIcr+tQQJucIVVv4ckY0xteuDev/qh850buDy8QAzuOrNco6Dbo
         pMy8BKaKMfNFfmUC17u2ATGylO80QStfYnNP/eKElwvJYI5nBKeCkfxM+x3OQpBU0xjJ
         gLjcjL2mUdKhG/5EddhaxxOrf39GnAh3zJXQ+2k4G8pfflCt7CssaeJj22msrS8FjVgs
         DY4kUEadlW+j6obGYwV8V5e4uXxwRtsqarEFv37RbB/Fvn8UEGzTf76/BontntC9A+21
         /qDqfE4dlEL4iJ5O46/vtXE6yqnwGaB/rIfjNcH3lJES4tPZQb+G1GksFwQn7FqQJU+U
         Ymxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895190; x=1755499990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6IsZOxTo8GJ9RAKnkhWQjXljSbOqRKPbCsXfe50Af8=;
        b=KWdZ+OO28HyhrBWEhAyGgTLaP6KgVyitqMlU6bn3zoUTSmDjVN6PxS4wy2nNyIUI4Y
         RU8xVnLvogejBfGFLvcW+NcwLfX+FkYiOSeDtWDdq6X2wN6atKAPYmfPdQiokjESoR/D
         QvS+fQHc+H7Ww3MEPKZncLYhYT10s/XPB/xcKNYJiQ+QNCL8W+IDtA+B7rdZQjP0uELJ
         EFFvITKFH5DvE1E3nlNm4BkxsX86e+YWPA+YvMykRO3nL3vIRopElM7LUxPHffABa93j
         ub9CT9pHo+tkk4jVbpRxWqm3GhggpPDD19JOdXVLyWEZfGDxQ5OhcwaTPIcgpxTi/ocf
         HP2g==
X-Forwarded-Encrypted: i=1; AJvYcCUb8FHfXTuZSZsHvInFm1MAzshWI2vqmK1V8iaM9a6UdnOK0qFuXzFeQ1Zqn7/ipUAITIi8nPZ0LYX2JjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoUBgC0qDNM2EDDn6s0dZvAZDci9a+DrRpWNFhIxi4mlTvRf4/
	CtJxdMoK5ux56K1VYTaMwQ3d6bIK9GMktddQ+jfQKczp5jNu4cQkpZTy6gtXD6fAv4o=
X-Gm-Gg: ASbGnctItknE3A6GE2anIkw8VO119gXqmgiKEHgWJ5JN5Hc8FxHbemRMnF0uAKvfL9E
	cvdQnd2Kv8pb2EhJTKelEwZBTuD0zLPdAfzc/eYRT191tKfISdO20vi3OrLwT09SNUWWLx3LAwU
	y5IPQMe4HysoCy8CbvXw+JUdLx7GcBWffhLs/EpG01YLt6KMdtmsKxXvzsrp6Oe0Jli1qthhctp
	6p6sKcsqikym2KxDUDaFcklCs7LaWkiE4X6T4EF6Lh3DABqqjGczJlcAOKvZ/heCSzRI4Nky0vF
	+tgFgEOV6iU65/BVKWxZtgnTaDc4XWO0ajOKxEKE5YTIpQZmlaGyewwM04ujku0XjCAxJLYV0vI
	VmNseMC2zsWPyB/F74Sb9cysJ
X-Google-Smtp-Source: AGHT+IG95Z25+MbEXOab8ZAB57TBt6vJ69oSa3ZxghqlYC/meL+6fjmVaH43MbKEjD0vda80hIJ8sw==
X-Received: by 2002:a17:903:ac7:b0:240:3e40:43b0 with SMTP id d9443c01a7336-242c2225db1mr157984975ad.43.1754895190122;
        Sun, 10 Aug 2025 23:53:10 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef678dsm265507785ad.39.2025.08.10.23.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:53:09 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:23:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: airoha: Add support for AN7583 SoC
Message-ID: <20250811065307.2luk632awfrjfx7v@vireshk-i7>
References: <20250809112832.15830-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809112832.15830-1-ansuelsmth@gmail.com>

On 09-08-25, 13:28, Christian Marangi wrote:
> New Airoha AN7583 SoC use the same exact logic to control the CPU
> frequency. Add the Device compatible to the block list for
> cpufreq-dt-plat and to the Airoha CPUFreq driver compatible list.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/cpufreq/airoha-cpufreq.c     | 1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  2 files changed, 2 insertions(+)

Applied. Thanks.

-- 
viresh


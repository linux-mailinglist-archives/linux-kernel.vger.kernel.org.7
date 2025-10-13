Return-Path: <linux-kernel+bounces-850685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703E3BD3824
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0D63B8C06
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FF619E97A;
	Mon, 13 Oct 2025 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XaYIeMNG"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB86917332C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760365702; cv=none; b=dGPbVTPlKWan7pdYiGisRifImVj3tBKF3epvW4SR5la67NTfkVEZjPNhXUtNZ3ZtHOIkYpSaGRis2XjnLBlmbwSQKzP7VpvFRPWThxfyGzzH2KwGvajhmN9gGviHO2quAaxb5WSs8tIi2iLDUnYo+fHX26DxtDknKc5bsDGHgR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760365702; c=relaxed/simple;
	bh=qSDOgIegj5/7OLJprxaVbbB0TVpZscq3uNLHReohDL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhUvEf2sPrI9shD2aTCu9U9i++p8GrwurgE1GnoHkAeAhsKyDnHHKREURuKxc6dMNlOjwqHVvpjvrvhemWFGi8ak6isVcrzXtc921aBp6Q14m9L1ejr38fNC4OabAuYyHWjYub/xaCbPWbxfq4Y8JDuWRAwhhJOSGKuNnNcTS/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XaYIeMNG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso38385105e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760365699; x=1760970499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C5Wf2L6pRYl1VWb9gXubP9G4VQhPo6XTkf/wwxr/MaM=;
        b=XaYIeMNGWaUgtVrfEHK9RXbqupkAyK6JPiln4+2GcmePr48TF0fHvRzCWLj3/zv31Z
         PRLsfJbO2EnTlSd+UD0HoeN2IIZti1anOjPCG/a0hk2K16r0uqj5AFUyRJlVIxeQwoeY
         hiAzVVSfdd08/3zoTYploLsWVggZUJCUmF7H19BA+HVLe+zDR2R8VHD7COhw73DqPlUs
         Rypi7om5ai5boUK9AgHFspy5l9461mUrmn4FAShnBsAaKGmBl/T7cYZVoj6nXiHcFM+Z
         NdSYLr7bFkx1sGczW9vJ1v4je0leAkEL8jwH/qoF4cqq8bebXqFF/ZXmyf5cDBQ3RSpF
         Apiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760365699; x=1760970499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5Wf2L6pRYl1VWb9gXubP9G4VQhPo6XTkf/wwxr/MaM=;
        b=Z8PH3VMZ3m5s/LOy9hrtyDGr3ax42aRYsnh1CqKYKkWmPSzzoSmRqEcI6qOV4+ymAo
         qFvZ4k+VeB2pE18E5B1CCVy8XJ5GKhOzqUaYSu1a8e8UF5p7RBFOe4OlgBy3m1Wjxw8R
         TFnpcv71V1i8jPl732apl4efKCnDVFe0gZPCJPdNdu2TjQjNo8EFgvqcwbkk24cQaYg4
         0qVISr8DoF68hNn3PmDLDKECDrLgHaCjpQC+37AD4zwWDUEbiUttKoifnPnxItsADFi0
         Lq7dqW7NSJClSSn/IRHGXq5GcdrhfjiiZepguDMPhgWq5fbzU6sTJgEY0sVrVITjPMH7
         9zlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEpSi+hoQr4Ox5tUAHEU9cbXU/3TTZAlVbzxI01pxkbXAPZSDmUc7BI5HZiK3GGnrQXbWDSCsAeJZ4lAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0J6BMFxvXij8Aa2qkNWjjFHbBIb1fYdioKpm3nwdWU8Ulq4mS
	Gj1e401zkz5fyZxbTTvHL1KxIiG6vZH1qNVPxmbZJOemRWBsA6iBjbM186EZgBb9Yug=
X-Gm-Gg: ASbGnctec8Y8ps86kDcxQ4bAI7RrqY6km9QARp8JWodnedelIdCWR4zz4C0PBrvv4BH
	5C3uQUfxhUNjdQn4E7CV9KaV1iF19ahCxhopzmUiYQovsg91zaXBI7/KJWJwmL+pSEjiK6MYqzy
	hcx4i8JN1blQ8bV14qusiOpwJczpsmFbSBln9fbOAhJ8LxOQA8FPvmPE4zgey8HdrqO+7iTmLK5
	lYmunROTDbNVoh1C3J+twmDds6diilZtK+ZP6tEzzQcB1jdVSIx9FWGaB6ODYzwxQVqwVjGNbo4
	LkSnvFIeO03u/McZ2Ju8q8yXRpNUFAtb+KLtgwhKMz3agZzJu8H3GLW4WMzXu3N6R5vlhXXsRHm
	wGVhfyEOAuLGCOVeqANPfMKZnlmKH7F6HPgzFinu8TiPmue+Me8j7teM=
X-Google-Smtp-Source: AGHT+IGNKekYnqITqrySsaLWx5aXn7KMrPP6CFyNtZxLh4rMKjgJfx5OlzNfjh75l7Ry68CnQOurFw==
X-Received: by 2002:a05:6000:2586:b0:425:73ef:b034 with SMTP id ffacd0b85a97d-4266e8f7f4cmr14241752f8f.36.1760365699040;
        Mon, 13 Oct 2025 07:28:19 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb479c171sm188616535e9.0.2025.10.13.07.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:28:18 -0700 (PDT)
Date: Mon, 13 Oct 2025 16:28:16 +0200
From: Petr Mladek <pmladek@suse.com>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: livepatch: use canonical ftrace path
Message-ID: <aO0MgOhfrMAoPchy@pathway.suse.cz>
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

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr


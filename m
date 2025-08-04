Return-Path: <linux-kernel+bounces-755345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D38B1A539
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA2C3BECF2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6A2202F9F;
	Mon,  4 Aug 2025 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ahzPL6h9"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365681FFC48
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318965; cv=none; b=LkVca2k5tFC6Ev6i+j3fvGGoXC4LAVWyk1rmzJS+f7//UT90czUlCytXpwll5b70eP7hnyW0rP5BeHmUaYcrWkFHfOa0/n47rh9+JuG+hqwlnNBAfZFF2jPvQ74c6OY+bIxPWpRtFrUQ7b3zQxO/ztLTrBx6gF9dmoBdyALX1Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318965; c=relaxed/simple;
	bh=VUlFsH8Z1SwZJTEqRqnj7yvZt19eBcmsv1QjxEHuuDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzjAN8i0iTSVqUyj3fMaYyqIZJN9EOoRssCj10XeqhEKtt7gXOl8HEIgynFGbdJ7QaqMbubzXMadOFYSYki9J8pfwntFdBTNmqg/OfqA5+J7p7qhfB2jGy68fo7UlsmK+ZswdeJWMgHM4CrD8IIL2m9ioLNDf15EqVgEjykFVno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ahzPL6h9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so31351275e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754318962; x=1754923762; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5MAh85Y0saa+euoszKw3nA4pGBPwcX9w5nxBz0NKd0A=;
        b=ahzPL6h9cD59BkDG0r+kCOHMNFnRsl6Xygb5ecwHoJl4dUeeKBwj5+maE5fpNK0Q6F
         L7lKQ54YqE4q/WMuDUhy0jYPpg/raaub0fTgDG02WFV1aJh5aI0yI7xF23kaeMfvZhml
         zg0XXJOPdkUcTVN0z756eAYOHvasfR47sdaXakOtLLtQadWJPUv/HZa5d5S2kJYbx0B6
         j40Lvrh7I95vGO/rQVjMKNsw6JNmEIOQeIxFtiPwn+9z2Fgc3Qq5Ky1JvqZhn7gU7j4+
         pKp7cqTwa4uq/VdP2CkZpqC4r9juCp+gKB5OJDqu+fQjLqzxDQAjiA5QPQt+2MQBRX8G
         ozCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754318962; x=1754923762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MAh85Y0saa+euoszKw3nA4pGBPwcX9w5nxBz0NKd0A=;
        b=cgecKCQyXKX5V42P+wl1C6mKBG0MG79mO2B5JgT/eBPqDCNq9GqhAqAzhCj+WgY63I
         vQQ7zefQIVTb8o4qPQVfGKaDK+D4apUHIXmgNuHKU+wtjAXeGd5uglT9OEuMjhOHnvRv
         krQoijshvtaxKw72C3P747A5nRxRMkW7efMFXZHx06XMlKj7NVJZ6kaBlzkant4K01I2
         Mjk0cJyVu5Czk3mRsS+QhtrWF1vv0p7MZpraf8bQ9KW6lXctpvxnr3Y1oe64gZ5acLJs
         Dvi0ELfkN/NRWDhz8LjfidblqbMhjzCGoGnpxaIEffjvWS545RUMMPlkgsCup44Hjoke
         JQBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrI+xFiz8G8kR/B2DTfTLFji9f69DZqaRvPZ9bDMoljnhUJplKrroQFSb631CzHALdk1mfgX53q6R1r2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxObJqnb4iQubcarxYc/9KdBd2cHENBbPIG7Yywi4FetHylGlHP
	o47ZAfqGroMu1lEqODTj+vCCv8NTO0/6DumXHpDX1hWLRl2S1ERabMDhlF0AvIi8tLY=
X-Gm-Gg: ASbGnctW+4kMlvR2CRdfj8stsBLEok9J7GR+Xf0wG9iIj9u7UY7H9U+zvYHtqFHd1GW
	8MqhOsGnv0fuT98LDzfrflG2o5tdaRgQMVD+ZUyKXFgRwbvwNE280WSPLhiMod+b3Ro+zKdK2BX
	a2OG5/MLPjMog9J3ZuBNrCi+rAoUnF5HSzNjP2FUtcX5twBqFqgEgOorwxdaem4WjfzM5UlKuF9
	wqwm4LorehA6f6Mn0mGF8B4IzvyM47xwdmBnT0sFL8q7AhrU4Bsx3EXo/KDU7Obem35lNNOy1Ab
	2mq1B1mCs+nyiV/rHeK07mlwiYZ9tvjWZuRsK87LQX4pryH2QJlvYw1MSXcHdj9qsvRJYsLpuGp
	XTJxoj6B0bEG552qTHK7W0wZBUHTNbq6QVBvpvQ==
X-Google-Smtp-Source: AGHT+IExUksj+hCR+gj7NMUPXAk78VVx0bqD4AGsjGqehS5x2aQlIlZBpW0rJUPuZBL200EPhOnGsQ==
X-Received: by 2002:a05:600c:3b9f:b0:458:bc3f:6a72 with SMTP id 5b1f17b1804b1-458bc3f6d41mr61463425e9.4.1754318962444;
        Mon, 04 Aug 2025 07:49:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458a7c91c0esm150589255e9.11.2025.08.04.07.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 07:49:22 -0700 (PDT)
Date: Mon, 4 Aug 2025 17:49:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Ethan Carter Edwards <ethan@ethancedwards.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu/gfx10: remove redundant repeated null checks
Message-ID: <c82931b5-0de2-4e45-a80b-3a90b0cc98a2@suswa.mountain>
References: <20250801-amdgfx10-v1-1-e1dcbe18d84e@ethancedwards.com>
 <CADnq5_N+bQppUAD-qR8QC8M6nW+oRF8+7z=Qakcxc=a6Z8q4Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_N+bQppUAD-qR8QC8M6nW+oRF8+7z=Qakcxc=a6Z8q4Gg@mail.gmail.com>

On Mon, Aug 04, 2025 at 10:32:43AM -0400, Alex Deucher wrote:
> On Sat, Aug 2, 2025 at 4:22 AM Ethan Carter Edwards
> <ethan@ethancedwards.com> wrote:
> >
> > The repeated checks on grbm_soft_reset are unnecessary. Remove them.
> >
> 
> These are not NULL checks and they are necessary.  The code is
> checking if any bits are set in that register.  If not, then we can
> skip that code as there is nothing to do.
> 

It's not a null check, but it is a nested check and it's a local
variable so the patch is correct enough.  At this point we know that
grbm_soft_reset can't be zero.

regards,
dan carpenter



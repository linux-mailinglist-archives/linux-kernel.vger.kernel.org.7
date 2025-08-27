Return-Path: <linux-kernel+bounces-788602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 569C7B38721
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BF707B6439
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2BF30146F;
	Wed, 27 Aug 2025 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOsJzOlp"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B171DB12E;
	Wed, 27 Aug 2025 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310099; cv=none; b=UkCqQjdVxs13YSaH2Hpgca1mRPLmzmUsDz2QuysE38wTIddovggMCJSskP26fACNmOy/LBBjQGPcDTIpAKV7VWF0LGgkelF96ONvqnToT0VDp2u6Yr4LDyPA4vzn9u85/ImzgPMqrvk1h5pKgZpPU6TfUFXVLujEfTMMB+9ND4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310099; c=relaxed/simple;
	bh=slAwgtuBPuAS5plLF85pexQqBs2rd0+QlT8X4nd7zuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heGjscLbZXc7BrSmMeFyH2EDtwOjbaqxaRGlSoPVPzkRcocIBCK+Zv2FyCsz+PlQnkp0mJwWS+Absv7DMFXZK3TwNY0jbStCeCJaXyELlJ/AZBk0lNthmybb75KL0QQtnQ8eVMvXAtBmYhD69u/GSxhsEi6TONpT7cWpJy6mDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOsJzOlp; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-324fb2bb099so2491a91.3;
        Wed, 27 Aug 2025 08:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310097; x=1756914897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62GisA5rnC+wo5UZXwYeDpKJheGjASkJMjHpvtPAWh8=;
        b=mOsJzOlpFy7oC5KEA4XfaExyCvMvkoGoaT6bGwrASXrfXSbfRISiqd2VPsHU+BqqWy
         DlMqOO7AqKshvBLN85/izHnXvLbugSAJpj1d0lryVI6zfKYle0LKOUm5tvUHAtXFqFP+
         5qV1X3uJOZZMHu0vYOoTNaZzt8J65+JCcxff1/STe8VAtSiiOnCedocYDCdHMtb82EY9
         YwraB5zqcYzJHVjOSmDx1/8Wun4fW5H7yM+wVWhz4cZslWtO1zYcE41oX/mpRaMEqJnb
         JjeI/FBxWsEWl8wNBbJCM8dVZTcJmuztbcuKZW+3uXMvWTlkiM21ZhwBvhlkcjYpuggv
         G7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310097; x=1756914897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62GisA5rnC+wo5UZXwYeDpKJheGjASkJMjHpvtPAWh8=;
        b=KfAAdNS5pOdQU6v3j1qX2d7JL3Z3XzmQErGaXFZOxDVk1UaSR9OSbN+PAKynww1/iQ
         +aPUjXEuPVO6tI3uZE7cu55sZ2LMZEa3eEqUrw+bPC2hV8bGOv2ACCCAEGo8VlExbqhX
         KqhKFxSZtcpTrg+RfUEnY5nup2tJZrDxxU6Y3ITAYQ/ML+T6K1BJC+vQSix8Ai+RV+dX
         bLLTsndHvqzWWUnbn/4grwsDCORUSnrYxZSIwOZ1olqUrbfwKbJdZChpSymsyGuf6Pck
         tugryHKsEY/1bGOmwBcUDAdtQyHUj+Ov/z0nkWV0A0NnoYYjfCjDGkSih0V/kcoRJQp5
         BLwg==
X-Forwarded-Encrypted: i=1; AJvYcCV6v2PVMpDCIV4IhQr4EUvu1gB6I4UeVxJES+PX7BppGkmkzvw463QyKEZQNjh1dHNVKFyk72/EhZJg/+rB@vger.kernel.org, AJvYcCVikOCuSmgP+ymtEKeCXeY+eGMnQaukh1VSc8a6cH6gA5hzIqRwh4wrDiFMUFr6Q3qF/S8Cy1+Gq50ox90=@vger.kernel.org, AJvYcCWFZkfq+hp6I+NgyNw26e+2oiUNvDBXKbzi2u9XCeFEisHKgrgBjmRR9j2tll1EE/YpGXUGXfiXBnQv@vger.kernel.org
X-Gm-Message-State: AOJu0YzjasdSyLMTQEZwrhwtlMF4G4vLl68dlbAVdg3Q1kj/aDRaHDRe
	ON4eGbsfe17SMvzbPJg/GwneIBeA2duGwvEeQAaxKonSYYxiNc5uji4F
X-Gm-Gg: ASbGncvXJn8YpwIqUm9TtWPFuZB5FmZEup0ZAey5flkv3B/2+TuVwRavpt2vNxtuqnQ
	jADOqofFJe6lqPY0iVdP+YspIx9vkFSFRNG/mt1b1Dqd6JwYkgezu1oWHyXo49PRHHTUMrOTLgb
	uwWxrQmumkt56Qye0vXIFfnUsXuCzH7JmmOUHMVM8Av5j9fIFRVlyW3L4/iu8boBvP7PNgW3D9G
	MmdnoT3nor/Gy9TFENSn2tZFnAQE+ITJ598smQA0BQcx4qdh7/WeWoK0RkEIP8P1s7ntqODj/ys
	RcNJhbjSD9f0NMrFvsvNv1pt7ae6VkIjHUwJqvjQXNPXoFEjkGk/D0ujJhqzhbJmUKls6C7BLwQ
	o8HS7OS7WoAZzxxkvAyPhO7+SIfdU+v4/N3Rh/kgICFAXiA==
X-Google-Smtp-Source: AGHT+IFw+aQ5CkX4zstTGzHwNVZ5Jtmgo7gAK5olfawHxegAAus0hAhlyIQ1D7ufJxYXwtO7QYsV5Q==
X-Received: by 2002:a17:90b:554f:b0:321:27d5:623e with SMTP id 98e67ed59e1d1-3251744bd6fmr24808070a91.23.1756310096958;
        Wed, 27 Aug 2025 08:54:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f8a452bsm2339858a91.17.2025.08.27.08.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:54:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Aug 2025 08:54:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, fe@dev.tdt.de, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: hwmon: convert lantiq-cputemp to yaml
Message-ID: <b9c704c3-36c9-4d30-8c7f-06c60359d2ea@roeck-us.net>
References: <20250814080708.3054732-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814080708.3054732-1-olek2@wp.pl>

On Thu, Aug 14, 2025 at 10:04:41AM +0200, Aleksander Jan Bajkowski wrote:
> Convert the Lantiq cpu temperature sensor bindings to yaml format.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Guenter


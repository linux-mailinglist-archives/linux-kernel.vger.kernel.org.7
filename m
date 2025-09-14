Return-Path: <linux-kernel+bounces-815424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F75B56411
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 02:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9383F189BA48
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 00:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEA21D618A;
	Sun, 14 Sep 2025 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctM31zlA"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CB51D5CEA
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 00:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757811365; cv=none; b=TRxGaw0GbsLoFGhqmQbnF9VAng47GG/Ajtnyvk9VSQKFLbt9eo/BX+9s3dtsvjxuP32vPQXb7oVlyiblk77+v+KzW7lwYflkQi7CiZ5mwAypax6Fo3WxUBlozsGYtHEKPHgmcNPdeqyYRTqoFRBGESxLFDh8UihwEWB5z/BynRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757811365; c=relaxed/simple;
	bh=sQOJHGjft/KlAachSJp5PgYvmPdmVPqHui94Gg1UBoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C28lxbQabE+rD7uXAI1akb6+QvnfPPpkCz2Fz8vSzMs79Pf5Z3/YNjyjj9k2KewjQbTlTJ+1wzppJwwP00I21BnlrbsGIwWrHQJJfITesXSzbXAP1geuBGjlof4/41yWmaiem8l3t6jV8cQdoaKo04xrRxmWZh/3JxVNqQBlHNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctM31zlA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7761578340dso2223972b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 17:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757811363; x=1758416163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=skpuijfI1kkYoq0fGNxEYqoTv07yh5MDibZzRDosEU0=;
        b=ctM31zlAJgmZAvZaHDja4opKBsk24alrTSWleT2DkpR1+ck0Ere+/+4zj5HC5qDp8O
         j27AuoiFPt1U7dde3jaRkP9zsm0z8oqO+AC3nUiux8RnqkRsZHFPm+PVDpfXpPe/Aolq
         nex38d/by8BixmB84bPYI2kE6ytSmDI/5KcnXx7ymD7FugrkINz2mqwx542gM0Ge3mCz
         0TD6NMd1jgHnEyNmfh+MW8bvA6BZHifvRu79HCOpWPcaZcIk2kDTJGmGYSjjLHu1StCw
         Gdnz0RsBHZKnGyGcGnDd3g08ObmJ41+QDA80oRQzI58rk6DsBwQUXDYruzfErRcP7WlJ
         cCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757811363; x=1758416163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skpuijfI1kkYoq0fGNxEYqoTv07yh5MDibZzRDosEU0=;
        b=JyLBZft/310wAFL5eK+BE7xoDyibBu4xLirYcQmxief7BkCCrOpWNw8dTlXfUS1QID
         Q1wWwRUuWgls3GF5JaB8UALUUpMiwA0iG19d3ZgleUUwSAhmXwXKZcfWHtsMtlLLg2CY
         1xOSrGUM1lMP8wyNqLEQ4T2Pqoe2634k6gz1EXkfP0DKOlLDudfK1UgF1z3DfM2mTeGi
         Hd37hl8KonFqwjJT3pkEX1why2cAr75XcogqxxHGnGoUiugCV6e8h83FsBuB4ES9+DAf
         Y+L/FpClCYBK596iu2/2djWHxcgg32aIGKgTKTKw/0xZRxZVYToREfGuQSFFOAo6qIl3
         vxlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqeYZ8dAT57e3xDG0AluD19LOkCHBOOz5g5VfUEnXbuuFyydyzvgaQDw/5LWk0DJTUrsvBqpLPYAqEjgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6pi12aacoqMiDcbYIyQ9i/003uU9ZJZ4e4uunsmbL/KRbzs92
	SHXVTCyoyw5B+FXj0WXGBctSCbvaNZMc2SqKTdS3yk5ArCi/04EIj8uZ
X-Gm-Gg: ASbGncs6EiXgEnsI4t2+zUhSnD1RSRdjzjXIdYtpr6zN6XVFGllCjU6z1lCRNfsVgZD
	LLad//5RcmlIgdNb9rmvROYOXOefPoSgJLdvBdxMzy3zM3hTyy7lxoPNxdc2998Tbw4LBG5uPpP
	LzSuD+WqSdufPkamc0M35+PCCjIgS8JHS8VpjQB9pacWjnA7KI94ojbEB/yM3JGm6zrXL2PcsnP
	KzyhYCOR4xp/Aps+/e3Zl57M4Gh28idXF0dMk6vJFGagiu7HvQyP7HxLoUmc+nmfM6trPwZsbJz
	dXvCpxxvhuAQguinR9wJxT1h9Ed7+fJMIPA/a6j52AFIbKrNjfzuIBnwdSq1LFMM8MzpKgsUPpU
	u36gyGrQDG/jxgzTbZ6SIEQ==
X-Google-Smtp-Source: AGHT+IG/MC0BNxR5psJcDVkiLJEWDgoRGy0p00LDxT4S1aXwdHypEa5Hz3n6uMlecE7b+WI3VYn9ig==
X-Received: by 2002:a05:6a00:8d4:b0:76b:fd9d:8524 with SMTP id d2e1a72fcca58-77612077d7bmr8482487b3a.2.1757811362986;
        Sat, 13 Sep 2025 17:56:02 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:81bf:abc:6590:f690])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b18400sm9348698b3a.59.2025.09.13.17.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 17:56:02 -0700 (PDT)
Date: Sat, 13 Sep 2025 17:55:59 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Input: Drop melfas-mip4 section
Message-ID: <zhbhtoofltmrdxpgrqz5x7ferxoqsewq3bvrqn3pvlanau3bnf@g6qg2vrz75tz>
References: <20250910142526.105286-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910142526.105286-2-krzysztof.kozlowski@linaro.org>

On Wed, Sep 10, 2025 at 04:25:27PM +0200, Krzysztof Kozlowski wrote:
> Emails to the sole melfas-mip4 driver maintainer bounce:
> 
>   550 <jeesw@melfas.com> No such user here (connected from melfas.com)
> 
> so clearly this is not a supported driver anymore.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thank you.

-- 
Dmitry


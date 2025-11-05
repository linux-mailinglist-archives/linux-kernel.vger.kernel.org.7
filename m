Return-Path: <linux-kernel+bounces-887019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 536DFC37093
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1E8750867A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00281322537;
	Wed,  5 Nov 2025 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SKjBZKV8"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517F631353B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362813; cv=none; b=KPwLFJhdYsAJt4PPf+q3RttyNhl1zxqI6vrOL170wl3WbL70IBF+mknwm/wwILqfgpRLVHPCmEDIAM8BNKth1aNpNvCIR2Y3C8OviUzfNXpZlfPDKVKdnUl2etF7xIY1l3t6/dSazMUW5j1AcK+IW8DaPbBJrFD7iyXkPCSh7JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362813; c=relaxed/simple;
	bh=fJ1j5M4Uzh7dF9QWtRSTcy7soZzpyFOdthif8hR356s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AiV3O4/q6mVqupetnLpWW1XnB79bCm+qjSHnA3aZxE7cn0gw0EZmOvlf4xEZB2FlKtHDJr9155VKu4Ncz7R93fMhPwR9/PL1yl9j3bYezHtGDfLPZphb+C5aytdmyqrCBsi81UcmSHPS5+UHXb1R5Uyx7HhTKlWe8IlwgG+HVUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SKjBZKV8; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-9483e51d774so48710439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762362809; x=1762967609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Krh+lHfAiaYuFIm9yjGcUPl8AxxSVocyBSJOh5XMOss=;
        b=SKjBZKV8jJCix6HNRd0gx2gA3yhE39IyELIHgTZW9LO/4mQFAvpge6IdMoXTygKsrS
         X0TkenbBo60SlHst5d6GCl+C9rxASyeT53H1Qn4xlJUIIGqswXN09DXcFZv+R/LJ5gNH
         E9GPwXB5PfEAUCr4aMPDeeCGnKFwEGQUli/Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362809; x=1762967609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Krh+lHfAiaYuFIm9yjGcUPl8AxxSVocyBSJOh5XMOss=;
        b=khDMuje/vnpLX1CRb6wGsP3gIEamO5ND/TBtDC37nAf1Gsw8aLHHpvNacHXrrr6/oQ
         mDsPUHSKk7hAMdmBKqTrLsuhNsxL1TVBz60vKw+PTBxi8JWnQsV8xN5T3cwfcdeL1QTY
         kD5OwfzIJImF6XycdnbrNomq3hKDofG7kdACtPnmVJDKYMGjMn6xIPMTwdoEP99N4Imw
         NMMV3tVwIaMrOrjcmY0TPYFhto1TAZXcXk7Lzqwriora0BS5vIu+5YUahAuYosgdXV0H
         fWgL50GK4jPU+Jgn8Tr0rlIn5CdrNVgNiUqxfJmYulcBtr/8wyXow0WZIrO4W68r/wg3
         z9hQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0DGS9W/FWzhRuaPtsYBp6YAfaWbKxThSAuQqYFlvb7EG3z53mEz7Mp0i+YeDJZtgcDs50CH5nnahD3kg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/pY6C+s4Qx/AkZ3beNBj3bCQ8coZqzphdZFfmfsTa8AmgaTLc
	4R2hbI0Exh52e7A3DEFsTracaoxjmcELOnvKi5wn8zIGL3JB9LCKKNOrvrcq7IJcWgI=
X-Gm-Gg: ASbGncvtNyhJoxmdIWaxEx+kUHVuD9q4f1biONDDGGArMtvNxqBCxbEoeZY+abtKmQs
	w8XpRqH6GC16qTZOJNyabXXIXB25oKaQg8olTvPM2E7ffn3ZY4yXl3tJ24rWO20+gr7KYRwEX0Q
	g892rD144OZWDgpyJd6cUQCZQOpe8zLHCoTfYC+GkYPQSPyVNdaaLoOki/mEnKfxy/aRkv+HC4+
	u//0V08+Jhd8BWKarZDI48sfAAcmAJTUtZ3s0kOM77pcnIDXfKzO++v821AYVVUA0PgcIxuhMt0
	Mzj++9ZAt3bIRmZ0NH+X6QO48bHzztnaesrJJ3A3QQdR3SQvJBdCbRaqcjHncUf60IuDmP52fyH
	MyMwLLCOZLCUtIHyqpoIYwX2nSNrFiJA3Vjhipvxb7Exai3KX/tWDEaHdStK09PPc1ry/95CrOo
	6cOAT7wVTq1SSk
X-Google-Smtp-Source: AGHT+IEnWfjpMUpFTXcYKkaNwF3Yr8kygQ3Z8/qPeVCdcw+B5jrsWpOIkGJ2g0TLDrdKnsnMYU/Nxw==
X-Received: by 2002:a05:6e02:3cc9:b0:430:da51:95f3 with SMTP id e9e14a558f8ab-4334ee1fca4mr3032785ab.3.1762362809273;
        Wed, 05 Nov 2025 09:13:29 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b73e5f4021sm464454173.53.2025.11.05.09.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 09:13:28 -0800 (PST)
Message-ID: <959ac74b-a8b7-4d4e-9d34-3b3d971f9f8a@linuxfoundation.org>
Date: Wed, 5 Nov 2025 10:13:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: vimc: add RGB/YUV input entity implementation
To: Pavan Bobba <opensource206@gmail.com>, kieran.bingham@ideasonboard.com,
 mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251101052651.6197-1-opensource206@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251101052651.6197-1-opensource206@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 23:26, Pavan Bobba wrote:
> Introduce a new vimc-input entity to simulate a color frame source in the
> Virtual Media Controller (VIMC) pipeline. This entity outputs RGB888 frames
> and allows testing of pipelines that start from a pre-processed RGB/YUV
> source instead of a raw Bayer sensor.
> 
> The patch adds vimc-input.c with basic pad operations for format
> enumeration, get/set, and stream enable/disable handlers. The entity is
> registered in the VIMC core configuration, replacing the previous temporary
> use of vimc-sensor. Frame generation is not yet implemented and remains a
> TODO for future work.
> 
> This change enables link validation and format negotiation for the
> RGB/YUV input path, paving the way for software frame injection and
> test-pattern generation.
> 
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>

I see 4 patches - are they dependent then gerenrate a sries
with cover letter explaining the changes you are making.

thanks,
-- Shuah


Return-Path: <linux-kernel+bounces-788597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B506B386FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B011B22FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC84E2F0671;
	Wed, 27 Aug 2025 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRjFyk/q"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC9B20125F;
	Wed, 27 Aug 2025 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309909; cv=none; b=kLJy6p7IAE08JunKodDVpklxhKJ416VE7FGTfJDJXzYxt92AW4mzqMZT0ajo/fhg4GvHkBxRS5OQ7C9nm1E55BiBVnodF/yznqCOfJ8JUkDMbZg7BalUYZxIFBfodrdYo/cdRbZF0xMd6tQ6PyTKqcFG5n13oX03lpnJcTBFJKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309909; c=relaxed/simple;
	bh=R6ZzJJr7yKN+evH2Yas127pK9B9NPN44NuBz8K/mJn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctupXUCWAdZ3J1t3TfZGOGQgKqxzOgNEFFrug8FMQHSy3lh3Mi3OmkOF/XXctHxFOGUnlB72GUY8xHMeTLvEiJeWZ0z30UPHOwDiEGXPKZJPrN53XkmDP7azMo7IuGONaED1xqD8Fv6L+y2HlIfLNkEXT0qDxTSbk+2+Q2YkUhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRjFyk/q; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3252c3b048cso3058a91.2;
        Wed, 27 Aug 2025 08:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756309906; x=1756914706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ve8PY8iV/TLSghGkfjENy/kd9wFBUoZljLYgGaTY0Xg=;
        b=nRjFyk/qWb5FQdgi0PKTyvyg5GU/uCB67dkhe7oWm89wpAk1viqFBu1G9UVivpNACx
         rOeLl7h5w6V5o1LDHUc5FeszUgjMaOnYIoeOcm028+5MGkRij9uAgJUu6foOmvKl0AKG
         vX6UhiqryALzCUQxy8oq4s5SVeFNYNidALGSlf5PEUgdJmNVF4GADEqbyWLFUa3GMUkd
         zSV4I61XkFvr8QSp89g5GrYaHDkhxu9iF7mn0Goa2nFb/NgFZPZ5QcnY9EQLWIziLn2p
         tiZeL4FssZLKuFN8bvQ171RJ84YpifaQdp0qGgpkMIVZ7gOjKtYfcn/pF9DJnom8BQhu
         9A/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756309906; x=1756914706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ve8PY8iV/TLSghGkfjENy/kd9wFBUoZljLYgGaTY0Xg=;
        b=aDvYFiqdO+WUvjVgctu1xwoh7HCxBwBDCFNULEufb0JE8mbkkh+LZewXyafMbmSVSD
         TWKf80NLwrbP/16a/eLMfeKR7CvEotHlEA40EXtghman8pPjKqE+ntJuRGAbyMNqX348
         h+SJuE+QXQf7E+oZVvti5VNpIjZSL0oK7OerejVKBgUzxyFGXlnDwx34M/1dtShiO5gS
         Sx/KteIVstTEq2wnzwJydf0nuG46BDRQ20rPwpNM8QFU2rbQVPnmK0qmwLPTAjFG4XNg
         dRQ6TYUPmKYxdOsciq3M3GFkSv1zoqGUAve1z1phnUfxqudDahxw0UHDH2hv6uVZ56SI
         OJDw==
X-Forwarded-Encrypted: i=1; AJvYcCV4NIsByclC+uqnFC/raKintl7+QFC6AR7gNEhXFm1rmF05F/Y7uF2+1NGs3jzRWwvOteZG4RWEwEUq@vger.kernel.org, AJvYcCVqXZt/C7to9Qm1y4wMhGGHoyvi2JSCt/yiq658HbCbUxhqWz+eqKwmEIotLEU6INgCvJeUbKcQzoWdT4PK@vger.kernel.org, AJvYcCXdcVqL5QVOEJ7a1AjQR3UwAROcjmT6MxpItfCD70VkVZTL5aGgAmlH43I0rG1rbSrF5XLKdNcBoa9j@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXoxvaeJM6uy8BjdC5KQqLmaFR7RPzA6f8sh87L2zbM5g9t9F
	RZPzVi0hdC5ckGM7eKiEyoOEQF01RYNQ250Sb5TuKDU99uijzI8jczEj
X-Gm-Gg: ASbGncuOEAUlFd1w0zP3q+RPmeRsrRRIQFu9A3u8zbYBotcAtM0FBiVKN5pN2m4g4Gf
	0oDVKHrITwR6ZDFkip7mDrMHIcz76+me02OMunwNDHkeDhgUIZ/OnwbDjcZmfqLkh4Dkskb43uu
	vXqYoPgR6Ac1hPFK5IdFx5Cc6sg8/Ml+Nc6+fO5CCqzRHRYXI7JJBmYKbcx0o8zL1WbPTLsDCCF
	LggzmglF2C+t0GlE3E7z6Hux4WUrZYocx2owjgFu2M7lW2gXm2RIaxy4h5Pu8ixxofAUGGlJaPJ
	evSXkSQnfOs4eeAuZviqhwKRqv1AHhigsPLjpA9qus3u+0E8UMC1golxZb6gK2jMBqeLkjkME9G
	vdDL83Avkd09x9JqGssKsZbFHJvY/UDIwsT8=
X-Google-Smtp-Source: AGHT+IFW4KVXufm0nSvkd5IZSTWbRQWJsTgx0kxi5oYz32KT6Vqz78+HzXxdoBks3hAq9RnjJlFOqw==
X-Received: by 2002:a17:90b:3905:b0:323:7e80:881a with SMTP id 98e67ed59e1d1-32518b82606mr29161556a91.37.1756309905981;
        Wed, 27 Aug 2025 08:51:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f592587sm2398767a91.9.2025.08.27.08.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:51:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Aug 2025 08:51:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: ChiShih Tsai <tomtsai764@gmail.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, t630619@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: adm1275: add sq24905c support
Message-ID: <c8cf8a47-7355-4624-a42d-c7b1d5abf18f@roeck-us.net>
References: <20250806223724.1207-1-tomtsai764@gmail.com>
 <20250806223724.1207-2-tomtsai764@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806223724.1207-2-tomtsai764@gmail.com>

On Thu, Aug 07, 2025 at 06:37:23AM +0800, ChiShih Tsai wrote:
> Add support for sq24905c Hot-Swap Controller and Digital Power Monitor.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: ChiShih Tsai <tomtsai764@gmail.com>

Applied.

Guenter


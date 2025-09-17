Return-Path: <linux-kernel+bounces-820759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFB5B7F1AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C821B239D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442CF3195FF;
	Wed, 17 Sep 2025 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CBsz/ma5"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD091E25FA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114204; cv=none; b=btjUhUq0tb12Y0RsMM6oB1FfNDrY6DRudanC1VbUbN3SdBoKsayG6hL5Q/KancRGmmXxIGsT6R5vLhHBxzv7UySF3l0VHCmOsv5OFQBNLD6ggylHmCDM2ISbvA8dc5TiLpJW4vxFiJ2/lRfBnQPEtr2dVqqVdQxqXE4bnCIyDAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114204; c=relaxed/simple;
	bh=zl8dtS2s8MYi3R+5GbUzLpCQnvnRdqNEFwiEPzkST2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrZXKRsPQOEkvzNM4jDdUUdD7zM7+NQWQsi6UywoENVrY/xOJHkPfyPsgBlMwBpbkUQ2GsctYVkgZjP5aOJENcVuVfKYbpXPWawTRC562LTuNTWLpOnEoIikOMmBxPl80QopbtCfxMPWS07aMLvb2Cv3W1iy0Ls2MU38egW3vK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CBsz/ma5; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-80bdff6d1e4so667390585a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758114200; x=1758719000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IYcedJ+FRQjWVYCRh7ALmsdypiv3CPiXNm5ziICxEq4=;
        b=CBsz/ma5UaoPEMHnobJn1kkE2SZyZPJ2lXMgwFVHgGIMZJrpZMTK8jfF4gV4ru1M6v
         65sE5AJsMqMk/Yito1i7YqFhvzt/NMLI84q9qXf3H++ADKVukdDBEgCExwSCAGyC2+w/
         C784ULEh2DdwtIGAF8mhQqylPOPodhSQ6QZ2sdOZvUydW8yKtAHDY/L+CnnRGTvJTJGT
         iQh72Uf4JrSBvbegomPyNAFEdTweQ/Is5+BigyoKQ8ZPIPYkIqsQP7JlYd1e4SvouPIh
         Rt64azi9glApLuXC5cXrec46S5ngHwqAtp+HhsWgAf4fTarAxyg8Q+iuoUeXq2H4wY4y
         rFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758114200; x=1758719000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYcedJ+FRQjWVYCRh7ALmsdypiv3CPiXNm5ziICxEq4=;
        b=ZlYgB3lKf/rpnCYCm9l8e2L9ravEuSsAhqX+Oq92xpmuia7Byf7ZPchEI3rlMK4t5w
         Fjsg0fFKuHlZqeTh3BkB9iYfLhLTCLTVLaquE59Ibnx4CNbsTFpixqA3lXA5RYhGCR2V
         lSRDOGrkvfQUKQJ46IHJpDYr4c8d+UdnqAuyn2UyW1+9siT3Ud1BprJUBrdsuVyCqYjc
         K8sOu5X6898AkPznVf67NqCMMUAcLIDbyKNE7uiUni9cW4MtV/eNspaYcHUvUJ7Czaob
         ie2BOGm6vahrh8UebopbkC98lkEJX7wrPB8eyll/A//E6TBJN6LWGPly5tZc5cCh/Qjf
         RhwA==
X-Forwarded-Encrypted: i=1; AJvYcCVldqJEp2jPep/m8FEPK8grTda09Y5621jGmXUmDYCMLrmUImgJeJfwkHpfFK75ATPlIl93gj8ZvDmjWeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHv6eeJ0QKjwxkfNWsEPYh1Rr7EaeUG+eotgJDwanZxeOOzS4Z
	utvhD0AAC6K8GqlcB6ZDmeAqNnwvkIj3Jqc6/aDgAbb8TGzbDD/KKH+mhGNdl7MGGHU=
X-Gm-Gg: ASbGncvTaQoEJED/mws4UmhhkwSE8KxD46jN5X+iSVj7mYlXMSUrHJtdaWXDftWa9dW
	oetox0zKW7kDlUDWzQqkPYtIkM+dWapRh1FDQG4z29c0tyywXEH47Hm5WAdaER+bI+mCn3ZH61r
	h/zcXuoRd/8NWY5QbkjBsIvy7DgAqNn+HBMKYmjKGZdXXlAyEOocAEI6rJ5t00vdEcwZRJCiGqU
	+Xves7IfVEI6r9JAq32ZMRllQ3xs5boxzauP5AunEYj7bcb1sLXf91IxDFTfYHUsGG9WKMTT2n9
	e/5GqYCWBPFJLfGBx3pHvroQXHsMzg5UsYRG+sEOkEiV8lDOgJT+flY14Xz7xu7M0MFJofhi
X-Google-Smtp-Source: AGHT+IEXcfwq6TZFvI1/bsiI6XXtPuNGpklsTOThRAzYqIU6ebAxXzOJL4H5dXz0lx0Wgxd1JKJqJA==
X-Received: by 2002:a05:620a:40cb:b0:81a:63d5:de93 with SMTP id af79cd13be357-8310f02c0a9mr217416385a.45.1758114199998;
        Wed, 17 Sep 2025 06:03:19 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cf9be9b5sm1117778885a.70.2025.09.17.06.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:03:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyroc-00000005q2E-1030;
	Wed, 17 Sep 2025 10:03:18 -0300
Date: Wed, 17 Sep 2025 10:03:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>, Avihai Horon <avihaih@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH fwctl 1/2] fwctl/mlx5: Allow MODIFY_CONG_STATUS command
Message-ID: <20250917130318.GC1326709@ziepe.ca>
References: <20250908165256.1255985-1-saeed@kernel.org>
 <20250908165256.1255985-2-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908165256.1255985-2-saeed@kernel.org>

On Mon, Sep 08, 2025 at 09:52:55AM -0700, Saeed Mahameed wrote:
> From: Avihai Horon <avihaih@nvidia.com>
> 
> MODIFY_CONG_STATUS command is used to enable or disable congestion
> control according to a given priority and protocol.
> 
> Add MODIFY_CONG_STATUS to the allowed commands under configuration
> scope.
> 
> Change-Id: I6099206ca683de5173fe74fe56f63994f1c4c911
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

You left a change id, I removed it

Jason


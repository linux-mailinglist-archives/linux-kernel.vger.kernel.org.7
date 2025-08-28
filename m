Return-Path: <linux-kernel+bounces-790749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D313B3AC88
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4EF1C879EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F34429AAF7;
	Thu, 28 Aug 2025 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWe092uA"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9A32BE7C3;
	Thu, 28 Aug 2025 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415281; cv=none; b=eHJNaJnw0+D/agYl0Lxw9Ugx2AfiNgo7w+2Aa6lzdBYlKCUDIZLLlgGTMg9o5cVID3toaodLhzwJGE87RTPu7TZGStTk/N+apZyks2oWMvv2sL8Cm5RwITsMbEmg9URiEm7IgoaBV5wtg3viBUdX0rmHwPwZgeNTX66WzB8M1q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415281; c=relaxed/simple;
	bh=sAgoWZLVy26Xtu9EucrrC3kMadCaTgQlZOIyB1s3rM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hC9TltEf4yu7dU1Yuzg+/KAgdii85QL0OupNLOt05kzyrQpWAxH4jpnXWrm6WAbQlh+w1ngzL8BQxPeKvVi9qqq9vYgVdveHQe5oT2ByONa/4U3S6GdmCBgSJEZTb/Xvw5szaKZlZ7ae4UDYe5ZbgqgGvL01BMXaFeCWjbD/6OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWe092uA; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3277c603b83so859632a91.2;
        Thu, 28 Aug 2025 14:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756415279; x=1757020079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ai9Otp4ju4eJRJL4vnQSDGnKFae/SWB7fQDAzUaPcaU=;
        b=MWe092uA7nGjNPbN9PHujueBI+uYB4JnXdDlrVcZgLSNjCVfKBtoFYmTMHCYLq9HvD
         aXcsoKeo6Ry1cqmfNtbSskotNmYuJPlro0ua3uzB/nnCCsrbUMoBkioYRcz12zfjxei6
         RULuVEYBFVhkEdYBkH7ofrXjxjMw/X2mj+X8EepRw0wzM+56vUBaxGFlbGJWqMZKpQNr
         iJ69JRkJOEQsYmLo87haukzSAm4m6ys0wrYe9Y3by3nCV5H2GLhJlLbzdcR08XCt2N73
         pRM4o/Z2OVzZKXypMubWqpl8K1KDjM2hZN75W4tfLeX2ZClUB+muypH6BulgRqdWiH4G
         enLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756415279; x=1757020079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ai9Otp4ju4eJRJL4vnQSDGnKFae/SWB7fQDAzUaPcaU=;
        b=heglKqnsW4LElYvgjtONUig00oJSbTOkfDErW6oK+1G31xg16lvrHUNGjmi/p1bPIN
         Q8AoyvRcEO7+GgmO0dgQ9qaj0HIyLMjSH9j73vITcjxoCAnSNLfd1dKbBd7QT4htdQig
         nqaEpMyvvTPOpNi3DRFgqLAnqMzx4GZM8vpzQCFTfDj0XFlxzMXJSOIoLlk+PX7FoGqZ
         leMVIbDrUhPEtJLz+uchT4Qn/rwNbNatZIZ8GjTQes6xWVl1Sy88U5+O/Ix5Qyhf1x5p
         MBsQ0JeStkCthFb2q/6sO9KdUhC9MrSYCn8Bolkut+6UeB0LmMBrTAP3bjj6ziHEaiYO
         j3Og==
X-Forwarded-Encrypted: i=1; AJvYcCUSqK/Y9FBM47eHGEzkrzmCSSs4h5HkiA//06Q1zeR1bnxCsexSLXidkIx3HqJgWcQSYU31I7/TajhMRGg=@vger.kernel.org, AJvYcCUcsJkKyz8tbPvyWBS5iLjTMPkVmiaYBNDlGIXTwqOINmdjA8bsJa909oYEHiG4y6u4yH4NeAx7Wu7M@vger.kernel.org, AJvYcCXROKssop4JjoF9t8B9Cz+qqIzu0fVkBnDOVEQOIQ9rmf6l/0kmVkq57uqr2iVFd8zMvd6Clu/1h05VAPqd@vger.kernel.org
X-Gm-Message-State: AOJu0YzoL8CBgfxU7ce2Vhpa/1h0fgGxRBYSOE48xAXl/+2cJPiltXeA
	YTCy/SHqM3QvpmzwDBG6zyZCZV2427I7xmR/rS9V9GXaPYdBZnDFqe23
X-Gm-Gg: ASbGncvYBuFqUyOJBNrHVSA5GBgZOcB0luresOXTDewoIMvbYuGQ+WCZQena4EpUL/c
	XZAnkHjL8+XhozDKowt3kD1jSx7rtVfUkd/hOGPW1bZi2NmTfuahC1ULtnQ+/SgZJ8kIvZqhmic
	tTkeXZFaPkNIAEMcOGoVHAl015vJYrdkjKfR71H9UJzR828cXGkQl12NvmPaBbpAVVl2anZD1QX
	L+J5GvY8bScbhE+EC51Wgrana5X2QczES/ApJvevWq+0M9jZOl9Xg0KPVsW8p6oVPDmeZdO9ZUW
	HTnSEvAlEjObSFGhagiQS3xO0IxpTtp9KG8HfbZPc4YG0RHYSZnMTTYN0e7QNbmOv1B9jYaoQQM
	scjWq73qLOskSq8T0G4V1GuqfbXhI/FXM3hI=
X-Google-Smtp-Source: AGHT+IHTZrShxnkzHz5Xi1INAJRX/IHoAcXVifSZn50s8Ju3ekF+02BqhtrSCH40eJt/QZ5rHGYjdA==
X-Received: by 2002:a17:90a:e7ca:b0:325:7825:f5a3 with SMTP id 98e67ed59e1d1-3257825f735mr23806722a91.36.1756415279502;
        Thu, 28 Aug 2025 14:07:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd3096d1esm313791a12.45.2025.08.28.14.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 14:07:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 28 Aug 2025 14:07:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Grant Peltier <grantpeltier93@gmail.com>
Cc: grant.peltier.jg@renesas.com, robh@kernel.org, conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] docs: hwmon: add RAA228244 and RAA228246 info to
 isl68137 documentation
Message-ID: <d9f16c66-401f-4726-9532-94fb7bef3147@roeck-us.net>
References: <cover.1756331945.git.grantpeltier93@gmail.com>
 <ddeaf4d2fd1f9c85302ee9b5bf16cfaecf9b89ad.1756331945.git.grantpeltier93@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddeaf4d2fd1f9c85302ee9b5bf16cfaecf9b89ad.1756331945.git.grantpeltier93@gmail.com>

On Wed, Aug 27, 2025 at 05:42:47PM -0500, Grant Peltier wrote:
> The Renesas RAA228244 and RAA228246 are recently released digital
> multiphase controllers.
> 
> Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>

Applied.

Guenter


Return-Path: <linux-kernel+bounces-774617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFAFB2B518
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2401A2A8362
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2682765FB;
	Mon, 18 Aug 2025 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Kku+p2z+"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A0721576E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755561228; cv=none; b=C3VkjSGNqp2mMMzUBEB4vp5j2dZbb7kumlFyj7Ss5EcXLthBC7vRJHbXpjTjFh/zbExFpNpoWuH5AhLYFHX2Y3M7B9muC6u+22Lf59ZFlPpmuXTEtNjRtRT1I1VdOah6bKSbAPvt5KEmFQRvKYz0qwNK50lPPNYCUih8t/rhu7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755561228; c=relaxed/simple;
	bh=Nht0mdPJltmD++9k46F2FYhtjUh0UhQGYhqewb3paJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtJzLdRdP/g/V41jaw/SVg4rHgJwzfwxj+W41woPCa4ILGTDDXgDYXoBqehssekhtfWixQWvqOcze7cGQIKvy8HfXM6gS4OYXVtEkNoV2+u9Vf8F8fqvrq/oNxk5tpf+KccnCF/qKt8AN5qobUS6fOaK+7AT9qiDrUM9wUCHM2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Kku+p2z+; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30cce5da315so1419017fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1755561225; x=1756166025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3wBQqsSZdP4vMjgFP1xZzlO0vzxLbE0wxJRdpLrh6Qs=;
        b=Kku+p2z+ZD10tkLcvXbrOSkFreJC8EKHbeW+4BGEzv1nFhDu6mWB2tDTjsbhk758sE
         ztSfD3xBxVQ54QnMu51AvgElfaK0rmvT7nnjoUj9OJzMFougheJFAnVc8VtaNKQMa2mG
         OZW7BNq1Quq2oLBfVCu5fy3KEGvZh/V/h2Bo+86ijMX5HvBAdTF8X/AE3wmjoEvP24B0
         1MgSfdnCUejK+HCpa4VcHaYx/vKTufpa55nNmiUlHcJMevt5xfkVEM0JSeziB+b5yOLZ
         vj7fK9L/5X826Y+RBkQ1p4gTRG/4cuUxMnewPlM+PR9XG3THAq3CFqpmrAk5pss6k6gY
         gFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755561225; x=1756166025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wBQqsSZdP4vMjgFP1xZzlO0vzxLbE0wxJRdpLrh6Qs=;
        b=LVkzr559/YLa299s18Fd13K2I+ZFyk0PlFbXxb+nRM4zW/M1K71cgRuunwRA5d8q4r
         92xaR/7m7mm4Ab1GTWSU0aEuxEOSxlGb3G3x9qHY0P1zk3X/ChPvvHvEY0whBMS6gy/V
         /fTahLe+Sqvnpc4ZhmCskqeCDg/ZUi8TWfy4uKkODIRxQlL/Hzvf16/m2+VyFffGsI4G
         GY/R3xjR1mlIo3wZ5P2ZHe2b02cuNXEh3RJJbS7mbgRM8c7eOlAlbbQxqAPWjKoZWbxW
         JPT25e3SR8tWAHD7ia+9YtnBgbATHsM64ejTqjM4+Bdeuwbl/8+iVQmIDG9TlX4i9qoP
         IktA==
X-Forwarded-Encrypted: i=1; AJvYcCU34ijEko+UHJvP7/ukeGEhl3ZIyhazdeTcgZZK5LEyQPaHyzjVMm6Z0FK2N7an7JndF+jrKssqXjC6urA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE267IO+shzWiNq9/sFYPawvw7pPhc0ofQJKLL7QIq2rXWDJ4v
	93WAK//XJf0swiXtgVZc0H42RTqWs/BTEz71SddF+itzD5kiePBWGagDAKfiVhf4uZ0=
X-Gm-Gg: ASbGncsv212PiP5OP9Q26QAf1fUoG1/2U6dDKls0yXfsJcVTdJ7atuxTfGbUjDKiuyB
	yOhlXTEkcA9CLM44xeiJAzyhojM2j0oHEzaoLDwny6okfg+2SJqVwJsjPepKLULinVS5L8aUyXz
	F3fUhzXHXb9c4NXMr6fF7vsBB9ZbF6WaaX9fjoIHa6rGNiCTejJitlhbj73y7/TqrqgzpdpmH1f
	t8kovlFlEmzhX+m8CT86H8Q8DdThgdg5UsgD1QrLLxVXrz8nEeql/HN0jnGxE8pzMP3mz26XrEF
	WECvV5qglOWx8QqL4Yd5LlWZvvWGglMtnEFxucWVaWrkvVt1H/lx4FCL3ukB7qvy+GtCdzE+Z7j
	CwCgqmgs=
X-Google-Smtp-Source: AGHT+IG4XGLQZR4wLXUR4bNYCGLPxYgNkMO+6vuslEdlEnlKjMHiP2tnm5B4xgYGljOnp8ugBhvB5Q==
X-Received: by 2002:a05:6871:e01d:b0:2ff:a1b9:881d with SMTP id 586e51a60fabf-3110c328f4dmr624215fac.36.1755561225136;
        Mon, 18 Aug 2025 16:53:45 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439204e556sm2119680a34.43.2025.08.18.16.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 16:53:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uo9fb-00000004bf9-2L2h;
	Mon, 18 Aug 2025 20:53:43 -0300
Date: Mon, 18 Aug 2025 20:53:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: saeedm@nvidia.com, itayavr@nvidia.com, dave.jiang@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	Markus.Elfring@web.de, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] fwctl: mlx5: fix memory alloc/free in mlx5ctl_fw_rpc()
Message-ID: <20250818235343.GK599331@ziepe.ca>
References: <aJjiRqLx9TEg2NFj@bhairav-test.ee.iitb.ac.in>
 <aKAjCoF9cT3VEbSE@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKAjCoF9cT3VEbSE@bhairav-test.ee.iitb.ac.in>

On Sat, Aug 16, 2025 at 11:49:54AM +0530, Akhilesh Patil wrote:
> Use kvfree() to free memory allocated by kvzalloc() instead of kfree().
> Avoid potential memory management issue considering kvzalloc() can
> internally choose to use either kmalloc() or vmalloc() based on memory
> request and current system memory state. Hence, use more appropriate
> kvfree() which automatically determines correct free method to avoid
> potential hard to debug memory issues.
> Fix this issue discovered by running spatch static analysis tool using
> coccinelle script - scripts/coccinelle/api/kfree_mismatch.cocci
> 
> Fixes: 52929c2142041 ("fwctl/mlx5: Support for communicating with mlx5 fw")
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> changes v1 -> v2:
> - Update commit message with details on why this issue needs to be fixed
>   as suggested by Alison <alison.schofield@intel.com>
> - Update commit message with details on how this issue was discovered
>   using coccinelle scripts as suggested by Markus <Markus.Elfring@web.de>
> - Carry forward Reviewd-by tag from Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/fwctl/mlx5/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason


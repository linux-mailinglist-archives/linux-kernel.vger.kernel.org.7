Return-Path: <linux-kernel+bounces-894273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C8AC49A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0166818833C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FB12F657F;
	Mon, 10 Nov 2025 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI11pCJO"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89078246788
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814480; cv=none; b=kHyADKRKOQ1JxYTDR5I9+KqP+c4OCJPQutW0L9iUbFiQbXrHQvIF5J5gTqTNdMqOy4X0YExjEAwXXY+MKpR/ixWvlHMtd5veIciXmEAa5JIzxVse/cxkEu0M9T+zzen4mjw0Nh6zRV9RzWgbC0Ji/f1T9f1zSCdriTr0MMUpD/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814480; c=relaxed/simple;
	bh=okNOORu/lmN5UNbsZPnsNSLoAA0dk4lTm7t688EICLU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V930SoppamUrSPvDeUhUOBAT8zhv+EPSvwuUmswHFYTX8oIkGlNKRxrMAUw3Y4TTn/3FUTP21zAGORqVhz2Awa9dxrpu8jLfgvb818hDd6RZSpZwlJSgrAwu6ZXupTWsHB7vcfYXWbIYdD26iFZJnyww7XDCetdhhnBOuPzcLio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mI11pCJO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7260435287so533010366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762814476; x=1763419276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy3DRtjQseWH8sSySHjHEiCHuYld/nXxCZdq01rPWwQ=;
        b=mI11pCJOXZWW2p/wPWf+tBiAF4qxoV3mNy4+tXHlw0upNIqm7KVCA0OmXZB2LUBkXm
         rzt6XTqtIjmSZe0ja1/JKOxYLdytUZDXeWigVvkaSU7+RFbx4RJsbOi0J3V9/h7L6r8V
         dKNZAukz28sOxzL4OcEowGt8BHk34dSEi2lXACTlRg4FOsjO+pbsLshyyfEfAGvp4gQt
         jzqAyZf74wxbTKTY+Hv2sbYg97Njubyh+GtCCSA8RyBW+x5/5Tv6u0mI5RXCiPQSlWfM
         n36g9oAjkL/eu0ju3/tnh69vSjKZFnJnJe3M2uc07IKbkj+Z59q1dL6rI93EuWjigF/y
         t0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762814476; x=1763419276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hy3DRtjQseWH8sSySHjHEiCHuYld/nXxCZdq01rPWwQ=;
        b=JSpfphrPH1MfP2JJSG+E1Ap8zkLcda9mGULkw2oj1uLg3oBa3Iif9No1ujxWGLdXPW
         PMX8Y+XLTU/2YjeaAp3TbRzhZ3iA2J6ztZbgHYjqSeb8QNYZqhV1e8VNAeREXo9DgY5t
         /U5FQJ07oEudTnO57MhCynYBq4NrODdQbZVSd2cJ53U1c0BHG1OIV6WeUeClJZdsWAOW
         RBBH44gFLu7ePKWIY9mCNFHrUFG5yeUry+bi4wQCbS1WJikcxmJQr8oVzlHbK+kwqNv/
         k0tccwloe2sml4IUCVeJoBwgFxq8KHU2/oygLC/Ne+NcC+gwFAr8FZzCYpin1N2P1WqV
         N2rg==
X-Forwarded-Encrypted: i=1; AJvYcCXccy1FJiSD7x226WvnOGtTWTxQq0IXmwE8M8KK4dhHU/S/dnYH7Eglj3e3O4McuxQSnk3rM2BFxteOV2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCLJpFoVa+XGTNkdgw0LPhvZV2JKeGDMHEmHm4tdYpp0DmpZrU
	jfxi6K5rm6i4+FFH+8A9Y3PhiLqEepqdxq7XWIXe9cFOgnQucFBAjqCr
X-Gm-Gg: ASbGncv9MfgRctrJc4Ay6KepUJKBU1MIT0jo+7EwTJTfZRI2yenSbU4v4FGIDBddX7/
	GJ48y9Ro49nX/R3+9t40UPjG216ifgBJ5k5ErjH61rW0q0B/qCnyMJhHRjAozSMPh8wUVhyZlti
	HF93zjZINa6NeNsGip0LPaLRccwlLWjApi4BW9fP0ZEus8ktTrJfVwivNaW5TLVZLvlsoTFpY4o
	oraPPmS1250eoq14GQXKLUudGDk5IPh43TB/TnTEN84bYAhWuU04CXcP7nBXpTWXOS54sdrNQOb
	R50WVPPS30QPdm3Co1IVQTU4JguU/u6PBDgHCq1dciWP32erv+0LyCnCWjFteamd+8b1Pvi21xz
	ie05wgvQsFOvQPTga9MKVRhMXmKyRZVv8LNITk4FGLIxokRt2GFVI5EaCk+teSpSwcSSn1Y+QDP
	Z/a6SeyDr2mVqH
X-Google-Smtp-Source: AGHT+IEdCNnJArmT88Dy24wvZrQSZRRx6rM0pDkfV8nrA7AwoMe17Vp9sJfSj0pDcqFVKzMMqcvg5A==
X-Received: by 2002:a17:907:3e08:b0:b72:5a54:1720 with SMTP id a640c23a62f3a-b72e058f3acmr1065004666b.57.1762814475569;
        Mon, 10 Nov 2025 14:41:15 -0800 (PST)
Received: from krava (37-188-233-172.red.o2.cz. [37.188.233.172])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bd72bsm1199771366b.49.2025.11.10.14.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 14:41:15 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 10 Nov 2025 23:41:10 +0100
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, jolsa@redhat.com, mhiramat@kernel.org,
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] ftrace: avoid redundant initialization in
 register_ftrace_direct
Message-ID: <aRJqBkYtMAhhO1yQ@krava>
References: <20251110121808.1559240-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110121808.1559240-1-dongml2@chinatelecom.cn>

On Mon, Nov 10, 2025 at 08:18:08PM +0800, Menglong Dong wrote:
> The FTRACE_OPS_FL_INITIALIZED flag is cleared in register_ftrace_direct,
> which can make it initialized by ftrace_ops_init() even if it is already
> initialized. It seems that there is no big deal here, but let's still fix
> it.

good catch

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


> 
> Fixes: f64dd4627ec6 ("ftrace: Add multi direct register/unregister interface")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  kernel/trace/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 42bd2ba68a82..efb5ce32298f 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6043,7 +6043,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  	new_hash = NULL;
>  
>  	ops->func = call_direct_funcs;
> -	ops->flags = MULTI_FLAGS;
> +	ops->flags |= MULTI_FLAGS;
>  	ops->trampoline = FTRACE_REGS_ADDR;
>  	ops->direct_call = addr;
>  
> -- 
> 2.51.2
> 
> 


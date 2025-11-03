Return-Path: <linux-kernel+bounces-882494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA16C2A983
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4297E188E133
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82112E092D;
	Mon,  3 Nov 2025 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br2j3Pyr"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA180277C81
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159246; cv=none; b=hSwUDmEqFJym9gty47ZCSAN9rcjLdrdvjpyjOQglDPmqZ8adzrjDcsNAHcvG8qYF5Z0AbkSNAmsVkKRv5PC8RpgpYjDUkGMqjB7AjWE/IonEu2z1JWvR+ARynGiskJFlc3TP9LmDaUmfzdrBzx78LbmbDIhzZcd3pXeViwLyrZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159246; c=relaxed/simple;
	bh=29HFx4zP5TuqH7uQu/O1fuNnD/tVpYqYDYodAqZeBmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WaJYsMcA35GSb9vnD3XJuNG7sU3q2ax/BBokE0VMhMOIAXJu2zGiv99t2I+5dln04/8hMQdppU1M5OI6/vzevCV+T4KSv4+V3fFUpNINB6lJF/8DnnZBzQF3C7OQvFJ/RlmIh7bcr3T/bI5ofmt++CCbhCmmF6lJA8vnf3bgv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br2j3Pyr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3c2db014easo866467966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 00:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762159242; x=1762764042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rGUbe9xbBxnFtXv4tRwbVKKr3k/buEiL+8Ja5DgwC4=;
        b=br2j3Pyr+iIwYtFqWffaXsnBuGo9C+qM0u+YB+Ng1oj0wLL3Y4bRjOa/10dW/R3hN4
         lKQMfM5V1Q22cAldAQhg3Kfk+6azI3fhh/Rr7AoB1hcFE3gy9ka0WJ83XL7kqDO77yMn
         yMNXLHuYB1mFy+4scZrINNdUJJS9YcjhHQSGGeoOazwvloQAHrc179We4f3zhVAWW3c3
         fpOnjZiIcXElTm657+YKosK9ebQ7TaK14jcBEyQYaUlf2qwIs/Y4+/FtlWYzHABNqf+8
         ucVoQ1Yt3lhAYV3WvOYPEoPKdIGZjKrOIiOO1GzHilhEhkmTCfYUwnpoUlV+CL+y8WAS
         j/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762159242; x=1762764042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rGUbe9xbBxnFtXv4tRwbVKKr3k/buEiL+8Ja5DgwC4=;
        b=SMUfbWsn04jVOyqlZHEFVvTgcghgADH5JSaTqV1zunuEzjRe0BxmKhj8AXYxFPeFLR
         kZNT05XdoYS19CEc58Gb2gXQVYS8y9S3IyCv/7uMh6+1G91OZWrN6vwxYaFNOtZ9AFuK
         wbNZ2+7lXd48UZOWU/pCPwNMstI9o6QXXMmNRz1DTrXiUnFCJ1U+uWDHAjsvkMn2GYF+
         KQXzUAEFqL6FUbTPqoskIOtI+G433nTW7TScKBJXA2fgo7WFv3Z/Kx91aoDtXYAwCgJS
         rxgPYc2CSXMqC40TwCTu7ZW1x3s/68r4ucuMABd77cODorHTjKUy8vvD9LppHpHW2VM1
         vtIw==
X-Forwarded-Encrypted: i=1; AJvYcCU/D+WNjma6w4YDig2v0KB6513gr0FTToMU8vKpTPtqltElYZ+6+scj5VDgoJk7pQJf3x9LvnWUuIV4q34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ykOoq2TQHkEvt/BsJfGLjGtSDvwwduhiqqrUNBDXPFKqQWRC
	YJQGeOZbCHko+IjHGbdmZbnuaBWGBbNf2LhMOng2SPsQOId5+n232jvV
X-Gm-Gg: ASbGncuUcEVBOF3J8gq2gYiHxMGYwS0CCDsIesRydscflGn5ABC1cbwQL+9z+ObFK6m
	GfdIVdanxTCXgvLBbCU4G8E4QFcYUTiG3XneaUbpgF6Klkk06oC2wD+XufnV0hLSK2V9Plmt7Yq
	J5upCRjf5ppaUiOyDjI/o/r8bSyW6vkjQBg17/3Mqz7bcRiPUKtoTYFYLgXjqv3lso/f4bppnfn
	2GBUls1JjhUYi2nKdJpxNwQVXiRwAmzgiKiG6NviHwb2DpdIpVKljtc0yZYmSltz8MrWVuG2ICq
	zIntjQCOYh7AecoLqYSKM0TfTaKrHVY5vLzG/0VmgBA5v8IK87xu2znJ1ioI+uLReNuHrSLpmA1
	jOLZ/kV5xmoEAxSTyogTNeC3MKZluB79dul2eiBYpdSqoxsBHqD0zfGJ8RV9cW31hA7YyPOevr4
	4ljWw9WHqJtefSnxtyCyxTblk=
X-Google-Smtp-Source: AGHT+IFpmxasMMQzw06+y85COr1wqLp8qW16dzYeDOlLZQvniK+scWKjZBeCw5HSwxFEJ0bUijUNZw==
X-Received: by 2002:a17:907:968b:b0:b47:2be3:bc75 with SMTP id a640c23a62f3a-b7070848658mr1145584866b.60.1762159241950;
        Mon, 03 Nov 2025 00:40:41 -0800 (PST)
Received: from foxbook (bgu110.neoplus.adsl.tpnet.pl. [83.28.84.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70779e45a2sm967489266b.31.2025.11.03.00.40.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Nov 2025 00:40:41 -0800 (PST)
Date: Mon, 3 Nov 2025 09:40:36 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, Wesley Cheng
 <quic_wcheng@quicinc.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: Check kcalloc_node() when allocating
 interrupter array in xhci_mem_init()
Message-ID: <20251103094036.2d1593bc.michal.pecio@gmail.com>
In-Reply-To: <20250918130838.3551270-1-lgs201920130244@gmail.com>
References: <20250918130838.3551270-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 21:08:38 +0800, Guangshuo Li wrote:
> kcalloc_node() may fail. When the interrupter array allocation returns
> NULL, subsequent code uses xhci->interrupters (e.g. in xhci_add_interrupter()
> and in cleanup paths), leading to a potential NULL pointer dereference.
> 
> Check the allocation and bail out to the existing fail path to avoid
> the NULL dereference.
> 
> Fixes: c99b38c412343 ("xhci: add support to allocate several interrupters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/usb/host/xhci-mem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index d698095fc88d..da257856e864 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -2505,7 +2505,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
>  		       "Allocating primary event ring");
>  	xhci->interrupters = kcalloc_node(xhci->max_interrupters, sizeof(*xhci->interrupters),
>  					  flags, dev_to_node(dev));
> -
> +	if (!xhci->interrupters)
> +		goto fail;
>  	ir = xhci_alloc_interrupter(xhci, 0, flags);
>  	if (!ir)
>  		goto fail;
> -- 
> 2.43.0

Hi Greg and Mathias,

I noticed that this bug still exists in current 6.6 and 6.12 releases,
what would be the sensible course of action to fix it?

The patch from Guangshuo Li is a specific fix and it applies cleanly on
those branches. By simulating allocation failure, I confirmed the bug
and the fix on 6.6.113, which is identical to the current 6.6.116.

Mainline added an identical check in 83d98dea48eb ("usb: xhci: add
individual allocation checks in xhci_mem_init()") which is a cleanup
that has a merge conflict at least with 6.6.

The conflict seems superficial and probably the cleanup would have no
side effects on 6.6/6.12, but I haven't really reviewed this and maybe
it would be simpler to just take the targeted fix?

Regards,
Michal


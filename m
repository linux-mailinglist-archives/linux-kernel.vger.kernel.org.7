Return-Path: <linux-kernel+bounces-761937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB08B2002B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886B33A31D3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB682D837A;
	Mon, 11 Aug 2025 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmNKZKW0"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1116D3FE7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754896728; cv=none; b=Rh3zHKFjZuGvPZ95TxnZY8BTQJrKzNgtKkE/aCcfQ8eLizQJzgOPdHxhmGKOOe66hsyC5LBcbXrMsBKJnw8sVJBEv/6+7EBvg51dZnIyPNb07vnTNWoNgvRIIP7rP2y/ZUCpo0MIIN9BtOceCuAokKRGCwTcjKHJwcnyost2Eco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754896728; c=relaxed/simple;
	bh=ggjySQY5Vol6DrnOGZD8iVo/inq6Op1ME+IJmKvjb+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKxkQdgqBzkX2FGvKhX4DXg0d9Ewq0gqYfDYoNrU3K0GPVA/JTMKbZV6wo+mOANkblTtB8+g/iS7lsqFlZTRhgtVFdLSLpB/axYH3NW4gnJ1LJ/qPlIG0c3ZkhY5qURTZmdVAWpgLzlpL6p4NeWe0njP2AojDbFYtcZhHO9AVjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VmNKZKW0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so27101915e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754896724; x=1755501524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RpUUZlyBw5CZbLmUvdnvRJjVMUKN0ib47e2Swl1lxkY=;
        b=VmNKZKW0ItmjzxO5OEjgc1Scdzo3FPdXfiI3lF2Hyr9EvuTiR4iihuBRuXuILmqOOl
         i598bmxXzhAIAW+xz2riTeNDoTlvMig/lTrMlkt9bgqtjNNpUAtdKCAQrFvBKSqJXYk2
         60R8ZpuAVtA9p4kikg8i12YoYb2E5RLZr7fzLrrw5MrhyJGs5Ilh6/4LB+Scotz2OviW
         7CHbR6zVkJUdpwYPJCAQysnr2QpFgzLpauGFe02MBd3dWXMpSHqLNx0rRobcbq2+v5dG
         VlF0Id+o3k0ujvvOHA9chATaqMeQ+wG7k7DCy14bq52s8fBINrcC+7X3J+hf49iOAXIS
         UZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754896724; x=1755501524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpUUZlyBw5CZbLmUvdnvRJjVMUKN0ib47e2Swl1lxkY=;
        b=SO5NQ+xh794dF7Bd9g9BhqV4Qzupd7X985BxTRX+mCvsBEAfFmZagOwl8CUVCoZBkx
         ZgNwny3UerPsRWyZ32ieVjEdDGBlXYpHn2AXd9dM51pcJ//X+URBN/H9HdjN1/CjBz2T
         OU3IIZIonRj0m3155UUcZGOERUYh8o6rETb0lnYvtOQjZBWc+nGZjHgr4Lnyjzuevn5/
         LqA0RXlW9OopyMd5CKaX5VIL0OaNFBAWZgLbsjm3m+GitSsDC9Y/JSzgQCA3mv6ZUsMP
         nG3wv0pnRiPe5swzunfuGngvUpXPY3RjR8oeYgGVA9hcSWkLeeOBLiAN7hfef6l720JQ
         66gg==
X-Forwarded-Encrypted: i=1; AJvYcCXwm9QoWnMlQdlCyxlRoT28l84dKPNbNDbQqtdoRGuFMFJFiDAN8dAQ3CakonhApBpVFIrwzujV+2HUlHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+TGJhGN2fC3tbEpC4y1Creg+1tBcKnT+Auyl32idiWy/E4xU0
	MPGf954xGM1rL1a2tjYIfWBhcDdXPkqej6iUcnePzY40Zk+AIhsiC+Q0vWMm52SEKmI=
X-Gm-Gg: ASbGncs1ag3yetyoBsyWubYG4FUqfjrpwlJ09Ixxr2GO7SwdbmNX17h8/LoFNsPWMuk
	9QXIRp7yP59SXm+/YvEt9QLvTSD3TnSWvRCXoiqnTp2jpSabQ9OA3sG+oOEho8W1aqurWZJ/EfI
	R8F54Z9n8lWiUVvSWfrxo9LIYAHR4LVgO+REiCl4SWKyMhxmM8n5BkAtT0GkaDW6bOvD6Qv5YWl
	L1/FlbZRPFnTepY3e4eKHUVnI5/kGriS1Q3qVcz6qMOi702v56goVkND6hJt8+AXvUlTTKb9SGR
	oUOAYlAPT04G3GpHMSn+ErT4TRfxAoaUL3qU0apKJowOUKUzoCEqx1FLHdYNpwP5SdenWvnahDM
	g4Kn8omZJl58FUxj/b+HQubUJ9cA=
X-Google-Smtp-Source: AGHT+IHM1bJt/BxDNFMob+UudNS2IHypTA0r8GLa214hR+v10zUWeCkb+vfD2av0PJ9nHp20erEWjg==
X-Received: by 2002:a05:6000:2c03:b0:3b8:d7fe:314d with SMTP id ffacd0b85a97d-3b900b4d813mr8056322f8f.36.1754896724211;
        Mon, 11 Aug 2025 00:18:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458af917d20sm235005985e9.2.2025.08.11.00.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:18:43 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:18:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Haoyang LIU <tttturtleruss@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	hust-os-kernel-patches@googlegroups.com,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] scripts/checktransupdate.py: add support for scanning
 directory
Message-ID: <aJmZUJeKJ6hd_pmx@stanley.mountain>
References: <20250810161730.6530-1-tttturtleruss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810161730.6530-1-tttturtleruss@gmail.com>

On Mon, Aug 11, 2025 at 12:17:30AM +0800, Haoyang LIU wrote:
>  
>  import os
> @@ -131,7 +144,7 @@ def check_per_file(file_path):
>      opath = get_origin_path(file_path)
>  
>      if not os.path.isfile(opath):
> -        logging.error("Cannot find the origin path for {file_path}")
> +        logging.error(f"Cannot find the origin path for {file_path}")

Send this as a separate patch with a Fixes tag.
Fixes: 63e96ce050e5 ("scripts: fix all issues reported by pylint")

Ideally, pylint should be modified to complain about this or something...
I have a script for kernel patches which checks these kinds of mechanical
changes and someone could make a similar script which checks pylint
changes.  https://github.com/error27/rename_rev

regards,
dan carpenter


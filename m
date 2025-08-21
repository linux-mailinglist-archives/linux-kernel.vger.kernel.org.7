Return-Path: <linux-kernel+bounces-778830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6321AB2EBB3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 326C74E54CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80AA2D877D;
	Thu, 21 Aug 2025 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bt8D3ZiA"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F872D4811
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745908; cv=none; b=IYsUhCSBufvE1Rz+YOy51Xey51EBbHR3r4Ljo/rydZkaxfVDE2maRfCKXhT3L7GwOszPJb/0EAbw77VBm8Mojn07IpZQKpk1Oh78VTFfS1adNyRATmL9kyVtFodx8wZXI/UjRoW2Nip/HUjXg8rM8u+t0locKEUTxUvaTGmgA24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745908; c=relaxed/simple;
	bh=3Yf64pfcogQlk4v2s2J2th+rjyDqCfKUN+6JYBEbPuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBbqe7PE/VDE6/JHDzQLjuwThSW4I/9GkN/JaNpmBXxmgjAB7E2ollKfHViZbyNBv34T6XPt2MAm4VrXHrjQDnq+qDsIUv2KVYp9tmXgCpK+iBwJIiOxYV8jnBWu8ZZUaMCggJyRddQWs61yBLK4KnqMdV/2pQPwC7MY5i+P5R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bt8D3ZiA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2e613e90so443082b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755745906; x=1756350706; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PwWYwojP48UP6NxxlGldKYH4e+LIBgJy3s1OksGbUiU=;
        b=Bt8D3ZiApfUY996bUuWIFwEUiiPgeeyxVMK2FlISwK+q79MdZLp+o6XlzPx/CpQus4
         xoMBV+YYHlcgN5V18OUoOkzPWQ/B3jWnTEXBsM05moCcBzoqpssl8I1OZ78T7sQKj/E5
         rtBPm3TbAbK0nXGxGLvRnC0gLf2fKrB92/ih4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755745906; x=1756350706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PwWYwojP48UP6NxxlGldKYH4e+LIBgJy3s1OksGbUiU=;
        b=xSbZR9ZtZMUmHA4Vw+xpCIBjcfYmYnxYfQvccFl7HEVsu67Zi/y+sQo1w7/O7G6ohf
         yoyb5igCHYs12yKVXFmojakGKcizXt5lPCZVyZ6jv0+CaZyal3omb1QoUzjTkz4Bm7KA
         PsKarYZc69di1Kp74xJVE+4RpO7iGq+xR1TfS08umFKhNUEILhqI/acr0EaJBDlJn0ep
         6ogkJYD/EwVA7dMDNnlvX/3XcK+LSrtWwXuDUJXQKy17DQaqA9Eiiq2vhgXf20ZDf6CC
         w5qV6s2Ds7pFlOZhbXLvVldtpQnLqirC4C7oukVMGHc6tossdTrA7AA5ix8YsioOct2s
         DDlA==
X-Forwarded-Encrypted: i=1; AJvYcCU78+a4bAU0SQn208ulf1Xps4l0aeKS/0SI9FNXklU3f07KbgavVgvzTJNXUMI23Ug9SWAtx6NqzELVHvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwW2K8fxGJfJMKqmjTnv27eKLHFQeU1gSR3jwjEe7Gg7K0tsGD
	6RjViW6e9gtugmoak86petvc06s4yqc5bz6boy2v+6FB06AwEAhC3LxzrPdMKRR8Kg==
X-Gm-Gg: ASbGncu3Wkg/pEjU3uh8wNFBoTtbbDe5cTd7zvaxAzWa/hBJYwF02GdRwVx23tzOlKp
	NLmdHtATQeZU08+zmKNQ22A0m14BwTRosdUvKFasrbhFew6VYTDCFS4E3GyYpEm0i5dsvlQ9OIc
	+eOFCxeGhOExNiDNCgqMznVemJoQYaiy9fwRriV3Jm6kyA2j36IzWFoj7bbaFCU5hVyVAL2DDFd
	pyEV1s4RwEY9dByKsigUCn7ID9z21KcWFeFdiC7CC2gXpePXtPeQIJDOfhgHEfKsCsarfbqxN4t
	shT2HawTM4Gf6/91U1TVWr//11dWZig5uLLf2pF7KTYInJcpmgPdsrnQ6nLNWPSGVHkc38f0Vm5
	EE0MICvlRssnQ2Ww6mu/Bpv8oqA==
X-Google-Smtp-Source: AGHT+IHT17C0Q/6Um/csBodwgEZCS+XLQhXWDgMHeLxbo55N/1nXjbuRKVPPv1kJrzzv/ZBDssvW9g==
X-Received: by 2002:a05:6a20:a122:b0:243:78a:82bf with SMTP id adf61e73a8af0-24330b1656dmr1182926637.57.1755745905918;
        Wed, 20 Aug 2025 20:11:45 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:389b:e3de:fe43:6aa0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d1b63sm6911845b3a.7.2025.08.20.20.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:11:45 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:11:41 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: =?utf-8?B?54mb5rW356iL?= <2023302111378@whu.edu.cn>
Cc: minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org, 
	axboe@kernel.dk, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH/RFC] Zram: Improved Compression with PID/VMA-aware
 Grouping
Message-ID: <a2xcxelvtrmclzkedyfavynsptiwmeky73esh4ekxzbyuicem6@6atx6b4cgwdp>
References: <1709a150.2340.198c223db7a.Coremail.2023302111378@whu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1709a150.2340.198c223db7a.Coremail.2023302111378@whu.edu.cn>

On (25/08/19 19:43), 牛海程 wrote:
> My recent work introduces the following changes:
> 
> 1.PID and Virtual Address Tracking: During page swap-in
> operations at the swap layer, I've implemented a mechanism
> to record the Process ID (PID) and the corresponding virtual
> address of the page.

Just curious, how did you do that?

Otherwise, I agree with Barry, this looks sort of very complex.


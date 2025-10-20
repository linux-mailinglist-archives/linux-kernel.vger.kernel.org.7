Return-Path: <linux-kernel+bounces-860935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E08FBF1603
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573B918A5AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C58248F66;
	Mon, 20 Oct 2025 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fnrN3EMb"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1367C2F83C4
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965061; cv=none; b=jPSAQa+TpUA9wgbLq27C/IlMuUw8sStbuLuzgt7ENvJBDNM3GewZKALjlrKA7FsZwVDw57WauLjtWAJa0Kc3FkXQx9PF1ehhUdo8KAOUOWfyChJoIVlAIMiKouC+RsFH0seW4IVGwGaxH3CdS4pOyFrGCeXDUnEeX4pEbNVmMa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965061; c=relaxed/simple;
	bh=7sUddBToXRDuVpOAdbh5+EOipFsXxszIriq7XYYoywE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3OB6ojDUPLajREjE5DbrLT4+ho9zT2PMgIBQIFu4BSxOgQyz5k8qVbK/ewbghGhTbpYYe5VesFoE/j1D/IBF3UR5QrEON2m8yAOZ+c/OlG/YWB8dlGlGNHfb4MNqT9t8ciS1Oz0pZ8+e9KGN/qD9jHPWpqoLmmhifYCYYX0FRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fnrN3EMb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so28203555e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760965058; x=1761569858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXAZo9QKBPHm6dHDU8Xx+AOp+3XH61eqHfx+Vq3xM9I=;
        b=fnrN3EMb2lDaS/rRAMvI/yge+4d8oOuzal1q+ZhATLzbDHuKSQdimSiTIMhuchctkW
         HHtj/eMESZtru312iCNA/aAGmHIR+4fAOkmOkjNzw5BB0Q3plAEnkueGBigUGAynE/Iu
         yisJ40wKDDsKf6jSnxdacvamnCKKf8W656mx+JAgOFWI2S9+O6A2moRd9T0z3KqvEDEl
         BizIyViy42SqZ3EAnWZR7LAp7vaW6g5bX2sJ+B2uUScAgBlbOSq5NRAJMzyOmyat2oad
         bzJ/KWYNaKCy7/3ijNQ/UosAEmQoIC5OIoYta/URzPW7c0SwVTd8AXxfLlZaSZhc43qt
         P40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760965058; x=1761569858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXAZo9QKBPHm6dHDU8Xx+AOp+3XH61eqHfx+Vq3xM9I=;
        b=QXa9JqTQXmnozXd8W/r6hpjkw+ieLHYOKZ1uXvinkSIuR8HvzCgEOcMT2QNO5aeuLr
         7tXfSKVfRK/3sqafw7J2lvAm8ZZ5aCLQ9y3JM1gVJLqH6l70dHCj1wvGy44E1fPhoV/6
         dk3UQDWyPy6JIhLI2DWRnE509wAp9qvJji80h7IWRkYOuEdN1fGAiokJXJuBfD1zyQ2O
         EhXD9NTmfNlblTOK6J7yatVHQQDGM11xtvFuyW6ulEhw2Dj8Mr9vqZ8abTzHy1ZjKKO5
         gfMubcBitYWwjWQBJXI9Vu3f9FBTYQdRwKMIvmo40lQsIRRKBs70JcvX/G7uAzMHIoOn
         ASPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuwDCs+zHolJTVuEPyZWAZmmbxiOJ/R2joJ7J8jpaOWYcFmDCl539j9uDNHtPz77eI2xYVLsFwX6OAbC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyidEL/E93HXAj+6JjA9umjP3Lmmy+73WlV5bBq583morAoMwvm
	olmHwhP5mgQip4jAC89jCkUTxjrGvA7VQz5v8d/NFU1BcXIpQoB7/fiNMvZMk23I50E=
X-Gm-Gg: ASbGncsIfJpuTOdyI8cXt7gMz36ilrYaJaVygAIu6hrfS22E/U5zF0levqwmwqLlto+
	jV9uye/IaG1/jV6JQowEJm5a2EGY/cTuXH2LaXrNoHRAE8uvGHVRV3xGwfGsh09+tUtqsZl/pfH
	h/6ZB8hJt+1HcOIJAxJ4+5VxFpRHMoCoY0tfLCCgiNTQ+8oviOlVWz0wFbGdArx29Wi77EpeBLk
	5/E5VkXHFLs+WRR5cx9zFsjKFOD9Qha+yrLR9JUhbkSbJQrFa2VA46Pxr/DzqENXKRBsTER9Cd+
	8desPgICrI6i3wBW5i85w5FBA4T+CTE6EsWpRdumNswaCyXdPCs/c/lKvoJAklmOdVe2aU9Dclc
	yKzAtQ9MwmnvXf14hqIffLdSp7cdB9RWHjrkPeAVJLpMsjUVILx1zx09zwlCLHoXmP9zGTD6mDb
	6TF1ycUYbdWkVkrrE0/wQG1DVQMA==
X-Google-Smtp-Source: AGHT+IHM395rDiD5CS+0467HtGNOVSysUdUFMEFD/wDZ4ikUr6eXNC1u5lSYEQ5rloxVyaeKMi9hbA==
X-Received: by 2002:a05:600c:5287:b0:471:7a:7922 with SMTP id 5b1f17b1804b1-47117874a26mr111763615e9.6.1760965058269;
        Mon, 20 Oct 2025 05:57:38 -0700 (PDT)
Received: from localhost ([41.210.143.179])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5a0e9csm15431843f8f.5.2025.10.20.05.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 05:57:37 -0700 (PDT)
Date: Mon, 20 Oct 2025 15:57:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+2860e75836a08b172755@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] netrom: Prevent race conditions between multiple add
 route
Message-ID: <aPYxvdLFjjduK28o@stanley.mountain>
References: <aPYKgFTIroUhJAJA@stanley.mountain>
 <20251020110244.3200311-1-lizhi.xu@windriver.com>
 <aPYqRJXGhCNws4d3@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPYqRJXGhCNws4d3@stanley.mountain>

On Mon, Oct 20, 2025 at 03:25:40PM +0300, Dan Carpenter wrote:
> netrom/nr_route.c
>    214          nr_node_lock(nr_node);

I guess nr_node is different for each thread?

>    215  
>    216          if (quality != 0)
>    217                  strscpy(nr_node->mnemonic, mnemonic);
>    218  
>    219          for (found = 0, i = 0; i < nr_node->count; i++) {
>    220                  if (nr_node->routes[i].neighbour == nr_neigh) {
>    221                          nr_node->routes[i].quality   = quality;
>    222                          nr_node->routes[i].obs_count = obs_count;
>    223                          found = 1;
>    224                          break;
>    225                  }
>    226          }
>    227  
>    228          if (!found) {
>    229                  /* We have space at the bottom, slot it in */
>    230                  if (nr_node->count < 3) {
>    231                          nr_node->routes[2] = nr_node->routes[1];
>    232                          nr_node->routes[1] = nr_node->routes[0];
>    233  
>    234                          nr_node->routes[0].quality   = quality;
>    235                          nr_node->routes[0].obs_count = obs_count;
>    236                          nr_node->routes[0].neighbour = nr_neigh;
>    237  
>    238                          nr_node->which++;
>    239                          nr_node->count++;
>    240                          nr_neigh_hold(nr_neigh);
>    241                          nr_neigh->count++;
>    242                  } else {
>    243                          /* It must be better than the worst */
>    244                          if (quality > nr_node->routes[2].quality) {
>    245                                  nr_node->routes[2].neighbour->count--;
>    246                                  nr_neigh_put(nr_node->routes[2].neighbour);
>    247  
>    248                                  if (nr_node->routes[2].neighbour->count == 0 && !nr_node->routes[2].neighbour->locked)
>    249                                          nr_remove_neigh(nr_node->routes[2].neighbour);

Does neighbour->count means how many nr_node pointers have it in ->routes[]?
I wish this code had comments.
KTDOO: add comments explaining all the counters in netrom/nr_route.c

>    250  
>    251                                  nr_node->routes[2].quality   = quality;
>    252                                  nr_node->routes[2].obs_count = obs_count;
>    253                                  nr_node->routes[2].neighbour = nr_neigh;
>    254  
>    255                                  nr_neigh_hold(nr_neigh);
>    256                                  nr_neigh->count++;

Could we just add some locking to this if statement only?  I had thought
that nr_node_lock() serialized it but now I think maybe not?  Or maybe we
could increment the counters before assigning it?

			nr_neigh->count++;
			nr_neigh_hold(nr_neigh);
			nr_node->routes[2].neighbour = nr_neigh;

I'm not an expert in concerency.  Does calling nr_neigh_hold() mean th
that the nr_neigh->count++ will happen before the assignment?


>    257                          }
>    258                  }
>    259          }

regards,
dan carpenter


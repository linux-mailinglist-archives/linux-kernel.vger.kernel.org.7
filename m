Return-Path: <linux-kernel+bounces-868625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DCBC05A64
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1491897DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CF127AC5C;
	Fri, 24 Oct 2025 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HtNoeQp9"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011D9233128
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302724; cv=none; b=VMr7+Hbv9QiMCgP4I2C52N4W9nOJx0UhZKENzmmazVJen9f/xaeSs+iPOtckoBYHdrHnlKJw0qaqFXK9KYkYj/THMNkvoauBk5WyzCNL4fYpUnPj40fGK+jqqXspFowqJprPReZRpSVPnHFtFJPn3nEWd+dBKJTDve5d8ATUNHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302724; c=relaxed/simple;
	bh=zitpUfd02mHfmWmKbxxXVMFAcuXxYP9GCRpf0oeD/9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHl76Gfyt4vnCbGOGNZ0sP3UdMjwlYlD+L3iFaOj6piSf3YFSYtgPV9nM56AlFEedbZsp72HuDhSAdYTodjNOuqpfk7FMUEixUTJ64nD1o2GnpbXri8t5y+O9i+N7nxoExJ6samqLJh0XIpzjG3NcJ7o8cp5LqR711954Jv105U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HtNoeQp9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so1383201f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761302721; x=1761907521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0LzYC4CXNtIhbU33+vNcLU3UwFYwR0NDqLzt3aZXlS8=;
        b=HtNoeQp9JLCTH6rHZfTLnO3p7RnUjvCDk6KwZQYZ4/QbVbWV6WlMXpvXCiEAOsRVbm
         LlXw8hekf3XHIYP2b//FxrTwO5g1Xu8g7v49t10Uzut4M2WCL3Q8TZgdH3X8n39wisQd
         3Au6JfXCk2+cbtBaSYAo54+ujmQn3bCjyWEGNFXbRQcbZ0Afunq9mhN0FZBSc65DmtCV
         IQbbk4ptLbpZroXzLhxN/vDCWGnClKNef1kj5GXR2X58DbbwzWfeAH8QWIa+re86tdfS
         q8a1CknnjTyvy4pJGqRkZFdxx5yK1Vyiam7K5k27AzbBaIusDRHwmPUKQf/N/HHjPpZa
         bybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761302721; x=1761907521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LzYC4CXNtIhbU33+vNcLU3UwFYwR0NDqLzt3aZXlS8=;
        b=HGI50IlfZSwttI6bsZgRrgGSc7tHe8CvEgLNCWSeb6gdsgu8SPoQWh0sLgf0F+0lHG
         u05rLp8Z+HdEnoCcUYJkano3ku2gzWvDD+zlAGNtXtkOVie+Lw48kQwOGWbHh9UXKyW0
         llHUJpWtqELFVWtWIfdFJAbPiI+2m5+bqEZiTYoeq9IffJ4erKHdwsOf5qu4l7+8Bu0e
         pY6weVC+K5qy2NIhImpieRBoD7Qn7N87aEHyMap015nb8JCfET3DMc/zrhWOtFys8dxA
         lHClQS4USNeSVDgYxjVQGObpGXqQ0mOtz5GkL7AnRxflClQHodnpyphNiol7gHUII+n8
         bovA==
X-Forwarded-Encrypted: i=1; AJvYcCU4uj7hD3AMeU6W1GEtdzOsN1RqqtoqMP+k5BBYxhHXPOIhH0P7lJaCyuItNnOYvv+UZgg+Uaoq6L00Ll0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvdFgam4JsJ9Rgg/RJxaM4Wed4uopnjLlH4hB1W8h+xazlHR2s
	N+giUrjlWDCDMWsiUxJ+yK/06YQPMxbzieuMbuK3BfI5MJzsloVR06yEMz+O5VeUZBQ=
X-Gm-Gg: ASbGncukL3VkGHMTuBIbAoMgA+48E/+1y3IaVLbvPbRh2KQtjd+uS3FJO0yWkRR6PQa
	uOK+ZScuxQkPtPXWBi8mm8iDNaid+vDI49s8HCJC49q3Y0VYWEQ90p6DVKlIZhlNYgcv/wcSixB
	EHRp34wqOw6FS+PQEVDHaxHIxLB2OY1ECuWdY/yDAKsLwSDWbqwTvYR5EH9hv7+uwKxs0Y/rPwn
	zdxOwBkyAjV+ldpJyCBpyBju3+BAcPnNYrpmWWyTQTuWdyecnU7V8qEzbpe/Yc7wedZ6Pc1aZRB
	B63IBGELrhHXByGBAtT6IUuss+VzogwFQ2k3x7xgRf6RNpdl7JS1Md8aBrnQTvp+UpfwxglCCw1
	a7lI0jfEtT/nOhjycaRLVi+XeANrzSiyKcJWIiazlr4eA/Ny0GsdqXY8iLXDJ9xlnmNkUsKPwZA
	IYt1eaFqCle9Z8PCpv
X-Google-Smtp-Source: AGHT+IFndIZtTS7LJDDfqCt6ZeNmFhEZyimvvM4KVVCj0BAZcLMsAD53m+FlpSvkb1XScbIdB5nUsw==
X-Received: by 2002:a05:6000:2888:b0:3ec:dd12:54d3 with SMTP id ffacd0b85a97d-42704d9396fmr20083040f8f.35.1761302721251;
        Fri, 24 Oct 2025 03:45:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429897e75a0sm8916219f8f.5.2025.10.24.03.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 03:45:20 -0700 (PDT)
Date: Fri, 24 Oct 2025 13:45:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Lizhi Xu <lizhi.xu@windriver.com>, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+2860e75836a08b172755@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] netrom: Prevent race conditions between neighbor
 operations
Message-ID: <aPtYvPq12Txu9JCG@stanley.mountain>
References: <aPcp_xemzpDuw-MW@stanley.mountain>
 <20251021083505.3049794-1-lizhi.xu@windriver.com>
 <7232849d-cf15-47e1-9ffb-ed0216358be8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7232849d-cf15-47e1-9ffb-ed0216358be8@redhat.com>

On Thu, Oct 23, 2025 at 01:44:18PM +0200, Paolo Abeni wrote:
> Why reordering the statements as:
> 
> 	if (nr_node->routes[2].neighbour->count == 0 &&
> !nr_node->routes[2].neighbour->locked)
> 		nr_remove_neigh(nr_node->routes[2].neighbour);
> 	nr_neigh_put(nr_node->routes[2].neighbour);
> 
> is not enough?

There are so many unfortunate things like this:

net/netrom/nr_route.c
   243                          /* It must be better than the worst */
   244                          if (quality > nr_node->routes[2].quality) {
   245                                  nr_node->routes[2].neighbour->count--;

++/-- are not atomic.

   246                                  nr_neigh_put(nr_node->routes[2].neighbour);
   247  
   248                                  if (nr_node->routes[2].neighbour->count == 0 && !nr_node->routes[2].neighbour->locked)
   249                                          nr_remove_neigh(nr_node->routes[2].neighbour);
   250  
   251                                  nr_node->routes[2].quality   = quality;
   252                                  nr_node->routes[2].obs_count = obs_count;
   253                                  nr_node->routes[2].neighbour = nr_neigh;

This line should come after the next two lines.

   254  
   255                                  nr_neigh_hold(nr_neigh);
   256                                  nr_neigh->count++;
   257                          }

regards,
dan carpenter


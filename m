Return-Path: <linux-kernel+bounces-859197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CE1BECFDC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635735E6633
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB1D8287E;
	Sat, 18 Oct 2025 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fw3zI/Sq"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45346155A25
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760791819; cv=none; b=rwPBLsfvi0qdtytf6qyCo3VKjEy4r0w++mda4ZnSIkdCLSmvg+7M1PmfwKvOONsWTbzDw8+yPMKVoy8w6TjsyDQTsz1e80+K6THADrOw9L6Q9sXupebcpjZGT7LfEiM81qOi5GU1q0AKEt+74FntY0T/S9eP22fjQxL7enNJHG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760791819; c=relaxed/simple;
	bh=JOhRgmB3DaDqj/0okhYJAPGij+Zt4PIUmY8n5GbX1DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RG2i80suKD8N6wIopynaj2I9b4dKTB3ihrEreMdtTr1GJSnC3I88w+hvWeJy775+iHuFeAiUF0xU6Qa9H3o5r5KoCip0f6Sfoh1hQUpnXLH1VCAZPizwRLUid63NDjOwBfsiiOhhwb2FXK4Gvm3+SJ/koLwLRd8hjhxBH/8cBlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fw3zI/Sq; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6a7d3040efso216555a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760791818; x=1761396618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYQhiSmjIKAg9JpgY81CKHBnsaXySUjIdDWp5EpwSqw=;
        b=Fw3zI/SqZl3cgkqNzT+1oKFCWSaZs0qCgrtmcTIf4oFqdwfqkpDA5qE8cQ5UNcsO7G
         JZF9MZZVUCkJtJSVtJs3mNHtVYbww1Mte06xUIRDmKtW7nV6VG+WcY7G9xxYjjlg69RO
         BkAJGIy1q1yrJ3syx6Yh0kFAUFiInDS5jVebibMC4xt8XAXaL8WmF1DjZfyD3Wy4jy6P
         G6Q+5QUHhToUmTxucWJgHbX7Gtt9HdRVugT3naKFELJaE4bl2qLAJgDX6g1cagCsySxw
         fzP/aVWR6UcRy9bRbD5jsutsth027K529KIPb/FYgXZTIC9UBwuh/dz4EsExo7uzM8hE
         fUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760791818; x=1761396618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYQhiSmjIKAg9JpgY81CKHBnsaXySUjIdDWp5EpwSqw=;
        b=kTZCMRmeSSQtVJnYl+rs1cmASLMfIqSBy/njgQNkFebJQRyPq/yXWxCwkbDdxrBleb
         rziYUAqYAOWM7BEONsNWTC1yjK7Fh4xCeUa/pv0jtQrH/x7+xdruE/2JZoxv8awRkohu
         6LOaViJg/WAn1Dg3YBHzHhZvsoSLbirVGOXH3qguCmafgefg1nCPnM4SLV8CREC9okyC
         axwFhWykXRQj/1r82uPE8fzCHEWVeF7niH94lFsAh3/jW5Chk/I37Wyyki9w4lh0SbBp
         6HD/r8jToJH7cynFDgSE0KT+UeP5FVlXljOqTnGKPyjm9ni7B+U/EqccnBoPxGHGCl9J
         lwfA==
X-Forwarded-Encrypted: i=1; AJvYcCXh6X9O2Ty9ZB5NTKMLNY5HZcB5UxTLdX5eJraYxmRHit7j/CAvT0WV67oYtQxRkSt0Jwy6JvQxRUIxj2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTPOgVwUSbKZ1IL2VEs3B/DaK29sBPHpvY2simMXoA2d1EEfuR
	YTciY9MErSYggyIuUpdN/uga+njhgC5gPIvzsO877Jvtr+Go0ybN9MrK
X-Gm-Gg: ASbGncsfdl1nDRjsRwH1D7+F9yghOQSE9VZuskLn3f6WYoNRUxafBPsfD+x2GMnl6oj
	3LBPMcYqMImD5CPN22HQA9Zt+xA+frmJrcN/MWt3HdPngdcEhxEdczTjU4qBdMIW7rAZ3ggvjX+
	u4ofbvA62kpmh2JWyYrXJmJDs/iUdq9C0OpsAPrPRzlI3chcFrp0LuLEf1DxY0OGCjSt0cB13Hq
	9H7mmhekuDtsd87Rvb9NKNgeD9NnGcq1dWNjECVsfYYlqvJH8qyiWlFOT9JcAKyiwVMy9yAYi4z
	YaqEjQf4qqx+rAHmwkojRMpp8cN272NGFWexG4M73zB85fUCn0BGsJ4SqXI2wBNb2AZVyD6ew21
	J4yuwC/x42tW3YraNZdjswO9d6H3YcchYJQxznfar4tGRUvJWM1qBNj59okW8LnXwazIyOHkq4E
	Pd+xRtzp+rbEXSvuARS+NdsjSMnomnwt7S4A==
X-Google-Smtp-Source: AGHT+IFp+N9rk211Uet/daZeKCeaXRrs242HKJkWvO8lWmZmRSdRDNcuzgrJxXar0a7TiUsx8ojtlw==
X-Received: by 2002:a17:903:2b06:b0:272:f9c3:31fb with SMTP id d9443c01a7336-290cba4dbb5mr86424535ad.58.1760791817569;
        Sat, 18 Oct 2025 05:50:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdcf9sm25575825ad.91.2025.10.18.05.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 05:50:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 18 Oct 2025 05:50:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ankan Biswas <spyjetfayed@gmail.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, khalid@kernel.org,
	david.hunter.linux@gmail.com, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 2/3] Add missing datasheet links for Maxim chips
Message-ID: <6e12dd80-e02f-42cb-848b-6c79378e25ad@roeck-us.net>
References: <20251017105740.17646-1-spyjetfayed@gmail.com>
 <20251017161422.4404-1-spyjetfayed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017161422.4404-1-spyjetfayed@gmail.com>

On Fri, Oct 17, 2025 at 09:38:05PM +0530, Ankan Biswas wrote:
> In 2021, Maxim Integrated was acquired by Analog Devices.
> maxim-ic.com & maximintegrated.com links redirect to analog.com.
> 
> Missing datasheets now available at Analog Devices added.
> 
> Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>

Applied.

Thanks,
Guenter


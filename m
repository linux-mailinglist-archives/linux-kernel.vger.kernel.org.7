Return-Path: <linux-kernel+bounces-849663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4555BD09B5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CDFF4E47A1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F23211A05;
	Sun, 12 Oct 2025 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MinxL1VP"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D234BA41
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760293273; cv=none; b=qnjQHqQnkid08ywo3GgvfBNc01HLC7CKiji1GeL5Udr5XO3Fk9vk7tfmmzhzXUzKRX16FJppnuBgOXpysI+W6l2FHgzP/gSntI4XBIpy/JkpfFRmD4VOCtyYfFA9nOMUX9XOJjFNxM9CArft9uxgrtQ1HGCyzuPt1dHSxoOVeww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760293273; c=relaxed/simple;
	bh=VzQQ8lwm0Lk05lofP0JJWoxbz2rX9HlWG3n01ju/+S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjTAcA7IVbHiLdjCxG2i6MfwsTvAZ9po8rgLwAhaaF1SYUiQTT1ZyQ5zIsuvtjAxQ2yBUiaO2fASLetAmMYEEK8HFyyNlpd280dof3c/GcHPtXgaU0bW9mPIRvL04Igvf6nQ3vh9M+exmjz+tVZfiLKzFJOXoIabEK+qKWHRQlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MinxL1VP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-782023ca359so3630751b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 11:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760293271; x=1760898071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lc2pFYPu/FDbU7u3HBa68TtCrp3O8IJos6ZWXp+PENk=;
        b=MinxL1VPOqX1V6yOJcchAFLom5ZcUPItqjGbyfkq2M04v5prr0hN9VaWN4dwCtsTUU
         kvixi4fxnelwSXyO23Ysv1Stfl8fD9uhdNVjZ+ZXdYnbbioEdNGyvrS2Oj4bBVmOs223
         d4C3AHL+8YxUx9U3jfWOtPdoJDdFtNrsL2ebQZGDbyMvhn3UZWg8ijLf5CpBNQg0dcRi
         LP80XEw/N098tTOXW4BhZhiJ/7ghX8zEFK7q2yBqnvGaopach7XVfG6wC2aP7hUkG1Cx
         l5fgX3YmbPOkPDJFDh4T+/TuuLZ8JDvhJD7GcHEz6ZGwZIXgs/Kb7eO0IppJiPvoTIvT
         qDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760293271; x=1760898071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lc2pFYPu/FDbU7u3HBa68TtCrp3O8IJos6ZWXp+PENk=;
        b=UXAt0dVHAgKhIQ4quuTDoThO05U+9rb7d9uudi5McJpUHsKsgCtKZpgAXyh5e8MCBG
         4mHWPs/RxGkgflXwe2ob8JM2KsFX8ZpczH/qaJv+UnqJxTuxGtkm1s8cU72CnJIb5yGK
         eqVjIVihvTsQng3eW2PI680lDnwoGI7xj0POaKqtZgFs39pgAziultBuMbji1m4lcO5y
         EzyiyBjLYL6105u/nw9A7StG+POH3urk7tlTEkg8yVYhGJBdwsLc3H8P55/GYI+fKG4N
         6uvVBKkd1M/FdtP7gei+gLwBqY9ah5YjhpBqBV+9eS5wyDAA2t0/+x9DU3FYzF7GIguK
         EDmg==
X-Forwarded-Encrypted: i=1; AJvYcCVVUqqcZxIgb/izzPdLJjThEV98hjYj0egH3yPUxfOX68BbJejw4eTz21svWjPvx0uInlDfVn1iuDVHfgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbEe9G/CfWH2+r530MeBQJCYUnrzObF49nn70etHKJxT/eaJTu
	YcbzSqxaKYDp9ggUWogpCbp4pMt75/fnUiwNX/M7AUkiUulZQVn4Wsj1
X-Gm-Gg: ASbGncvQkozAx25dQF92YC1Zsm5uRypU+eD+oG9n1LYEdojjuyNd5hL6ADzOO3Eue+x
	hvCcOl79uKuXxZ+Va2l9GwgsH58lC8VDTiBgsLM9h0fkTNvIkSTjZv1d6xNRKYXhVC7IcWmXmhd
	YMzxyksNAYTeGaNqyHTDSqWgMwTSMKeR6+oIzcrsqMdK8j1rgWUkUCWQr5d1TNuojCANGaf9oh1
	FAIl35pPC2IG+SMfvtu5jcysCIQK+F762lqYqH8Hdp5JHz73JxyC86uOSbfY/t5sfS8UyhdKd88
	EHIlVL+h8xsJ3yyMEQxveslomBanNOjRxh2KydwWqMHLCcrsmoBGOaoLBf+lCjx4Jae6cX0sUdg
	vTTZhKyuj4Vc/3+BjayX1E7brBHWUVxqaHPtgoD7e7b7PXx/FqLqZm3EeHoK+FOTY
X-Google-Smtp-Source: AGHT+IHkk2i5DXG4OnAiCP67L8ZhLd7RY2HgyjdnlHmDsHdgBJ/DoJ1fgGFW7r0einETEXYUTTYkzQ==
X-Received: by 2002:a05:6a00:179a:b0:77f:11bd:749a with SMTP id d2e1a72fcca58-7938723b2acmr18715348b3a.20.1760293271463;
        Sun, 12 Oct 2025 11:21:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0c349csm9070219b3a.50.2025.10.12.11.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 11:21:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 12 Oct 2025 11:21:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Erick Karanja <karanja99erick@gmail.com>
Cc: grantpeltier93@gmail.com, chiang.brian@inventec.com,
	gregkh@linuxfoundation.org, peterz@infradead.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus) Fix child node reference leak on early
 return
Message-ID: <7ed7d257-4744-47a6-a86a-4da8c54e38db@roeck-us.net>
References: <20251012181249.359401-1-karanja99erick@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012181249.359401-1-karanja99erick@gmail.com>

On Sun, Oct 12, 2025 at 09:12:49PM +0300, Erick Karanja wrote:
> In the case of an  early return, the reference to the
> child node needs to be release.
> 
> Use for_each_child_of_node_scoped to fix the issue.
> 
> Fixes: 3996187f80a0e ("hwmon: (pmbus/isl68137) add support for voltage divider on Vout")
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>

Applied.

Thanks,
Guenter


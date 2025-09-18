Return-Path: <linux-kernel+bounces-823676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78675B8724F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8508FB648D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7B62FABFE;
	Thu, 18 Sep 2025 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItzNtb+Y"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937BC2F7AAE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230974; cv=none; b=q1z3NXpP6NX7OtQk+lU5G/q8mEquZPDslAse/F88h2livhyFGqaypgfPtBXBOQwxskmdQQk+S3sj0ZJRzHAOApAkC18WH7HsZiS/RorHCT917iAl9oJfyO5DQ/6vMNxznUm7bgtuAgotuO3CcPeVj53BQgvYy1w+lQr08fxOWQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230974; c=relaxed/simple;
	bh=Y/g7MH1bz5uUTekQcW8JYQMQ93odnK04liGdY8dwB+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVp8ffQKd7U5zZ5tR0EyWJfYT9pZ+v549RUaKglXg0OFKlom+EBJOMBCT+Wjzisw3MoWSjCAsc5/sEGanHd2EcmgbdtzsaNpHfA5S5NU6D/2LdIeA5b9Pjqi5W4XLXivUluOS+t3NgVk8dywHbLhoVN4SU/PMGi7pP0jdhH37DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItzNtb+Y; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b54f57eb7c9so830413a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758230973; x=1758835773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OuOfn5BynYjHyfO8hnZOpVSeujXtYV70hxGYV5OTCNY=;
        b=ItzNtb+YeeFoSQlDfyJ+4n14NdYaJbAqRXompb1OYGEJ6WmMjVltaIU4n0c09vLiQN
         MxlOSzVmfiu6C3Oave+ZpvVqDXZnZl7xEQ2n1yceIjHyheHAo/ziO2CJYhzdAhDN3Can
         bjH+pMtZjP9B5V5CvsjulXnHnqWPdsb5tXu7yl5gwMapEqTY9JoBHRYmlTBe9uaAfXdP
         8hfYUUVuKAh0Sj1u9LkGCGShS3PhEjD+x9bzVNssJVSV1Tu7KXgu/4FuDyeow10xQ/Ou
         +xvITm6pG0TAV7ksdtTLHe2XDj4bgHDd+qAWCO2pFNLRAoY/KA4U0v0B39Jca1T04PxV
         l1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758230973; x=1758835773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuOfn5BynYjHyfO8hnZOpVSeujXtYV70hxGYV5OTCNY=;
        b=HDkMuSwiS8QVFPHi/Yd2KLA/wpTQ+Zfx2Eu4Y0YrgAMGjIVd/KKoyhKJLsrUe9mLHV
         PFPqi8llBXFQhR5VwldYnoluALW/2/l1xlLS/TV7RCzo3wTJ55jc/aH6YxUvuqoJGP8n
         jx+m2pZHtebEWP0bmJQEO+G/NwN92A0DOltRNgxsQSsYKbB5e4PnxD7F2TEZJavum7pJ
         +2qjAUD8MxV7tfHpkLd2UD6e0Jyb73yeoqZ7AJYY6JwlHpmhf4a8wC08Csncu1YCwcAF
         kE5sZmklhbkDI3khAELn3uQufP9gOxCmGWA3GtDgCFdiNmTUBiTjGuxK20Koj9cmwtyt
         dkkw==
X-Gm-Message-State: AOJu0Yxp0gScYNg2EzFujVIJkhJrb7jHUlrzK/p0/UJo22ThZjN4rz7d
	cwJb9Bd2EfywagS0N77fiKaL3jDMcqKydigMZmlxuBDSbGm+I8LwcryC
X-Gm-Gg: ASbGnct1V8v6wgHvSRlTJNLO0CUQ7lYQVdfoIvvv9iVcADy5pZhUpeiBmBcJ3VECOHn
	7jTnYCfCdXBE0Cxeg8a41wwxtCnpu/imRF9U5C4izq8he7NAMqCRjnUh8BZ4rSUPFvHRsULXN5s
	ZNvVmkLGFkXsY+L2y2lpb7q30vDnFy9a2jG9M/ymFgTtqz+IMJ4zb8QJuDGL0CvXLYrtu5YdibG
	fzJMUy+D0mFfrPv1YqiR6VG4i50jiNTfI8OJHdggyqJgKq7Y1bD3VlRg4IFQCRYGogIvG7iGW+7
	SHBU+MjQCj+hLxdmLTxTrI+r8SULJ3Zv/bm/frqjYpkcv6O6aBkzhsLTOwED/hCyMVejF1SQ1AY
	6QAX2TjroQCtsaISWXdruHhqg+bJqPXbXLmqyqcMob2gXaWWD9yit
X-Google-Smtp-Source: AGHT+IGJVCoAx599ArMTaqWmQd71Ibkb5sXiglq6XEMSs2fJiAQc2hYEh1dHQTNHwRyHuT99FrXNmw==
X-Received: by 2002:a17:903:3387:b0:260:c48c:3fba with SMTP id d9443c01a7336-269ba53b148mr9460685ad.47.1758230972743;
        Thu, 18 Sep 2025 14:29:32 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:8e3e:e1c9:1151:50c3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269a7dcafb6sm15559465ad.83.2025.09.18.14.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 14:29:32 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:29:30 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v4 4/5] dt-bindings: touchscreen: convert zet6223
 bindings to json schema
Message-ID: <jlncvy4jmxwcuryvrto4jxudnohw4berxa67avjqzrxsdakbvj@tlpf54cr3acf>
References: <20250918153630.2535208-1-dario.binacchi@amarulasolutions.com>
 <20250918153630.2535208-4-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918153630.2535208-4-dario.binacchi@amarulasolutions.com>

On Thu, Sep 18, 2025 at 05:36:09PM +0200, Dario Binacchi wrote:
> Convert Zeitec ZET6223 touchscreen controller device tree binding to
> json-schema.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 

Applied, thank you.

-- 
Dmitry


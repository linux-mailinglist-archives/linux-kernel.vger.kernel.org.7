Return-Path: <linux-kernel+bounces-764257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E31FB2208D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8EA91AA1AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD532E1737;
	Tue, 12 Aug 2025 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="emf3/dML"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C18296BB1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986725; cv=none; b=SmMdJcmTOoGKUPyxY9Rj6TXMvN47vzQrHIXaUPl59xPkj8x7N4aquhygdAPrrcANLSVgaow2egbC2LKcJULWShnD0LP8EwW8eqZPW9rX3+h9ahEMXYmP8zqi0NnFUcbhCxlr1IqlixXbBArqA5M6TMFtCzPsqqIH/fgvRUeVhYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986725; c=relaxed/simple;
	bh=neZ/vqHeDssNB9UqqyaDghlL5EhlgwrWjfSDuIFVMEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ntt2guS8MUIGVuCA6tdlDl9VMnB8gwJovqhDiagqQF8wS64ZESHOPktb5lxPAsJIluX8NuYCUyKCLxaLAtSxsxLXaJj20l8hTZ7dZHWfeVw/9aufsNfsDcIeOFWuOQgijP4ZYLGp0J/IxhujIj9vOzCfKoSZ6WNaVD14i24qqbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=emf3/dML; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459e20ec1d9so50964385e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754986722; x=1755591522; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1dFZVTGwXUDluCsSFx8fL6z8SdCWjGvQ8onjZgK6EXY=;
        b=emf3/dMLbZxRXr8RgIcRzhKBH9vAasdLOVEKKirkXLPkm3zAh7AoTVGDKXF6TlkSZg
         o03WDByRTePn1zKWCU71nRXGEmGn299EhluBdbc+3j8pAxVYOoRgZfJYoJ+8WgLTe9l0
         4X3q7efXVJoTXXjpXMhW8zGXGAY94GaLW9tFHepYFApl63E04vTDbU4Q+ePV5qvp11L8
         IT6sV4nlEAl7cca5+txWNHySmu6Eq8SuBIDuRmURKoaajj2Somn/qQyK2ysg65rrAXkJ
         4+PrSnNvQSYyNic8+SIAG6FdlecLuEWB+ubSX05zi+Zxms6raNZrAm9Hjyp9GX9X4rZ1
         7dEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754986722; x=1755591522;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dFZVTGwXUDluCsSFx8fL6z8SdCWjGvQ8onjZgK6EXY=;
        b=m5lQcrf0PQxdIWTFEP5lUYrTG7LonxY12Pz6xerXBiN1yU9KNKyzkIS806AMXJhzae
         1wtAnMvfPWkc7tYTONYavS/tbderwpWPUbRH+1rNJx6iWJDPACk91SOHrQt+mUT7TdQs
         zz7FonsfpwLsOnj/0rrlAM6OtyLyFj3KC+U39LucPih0kyQdYfgJ7NPDdtPb82mI4l2P
         AHoDfjW4lI6djMgvdtvoRxMkD1NUR0Me6IpKgDHdQ++asuovCaL4ZdRmEATEFVtXJl+/
         +8DbnWl/8+Mj+DJJxyoq02zcBQU+lhiS869jt94duRsM1kEYvtKKebBhF37U0aOHkSvI
         VNow==
X-Forwarded-Encrypted: i=1; AJvYcCVpNyx76ySsXiGmx+LBCyLMnjpJPUJJHSypFV/0L2EmD71mQE0CQ0CbPuuLWwO+D8W54jYCyKT+ksDu/lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA6Sjp+1KF0pgbuLXwVgEaiv6eE5UsbCMUDaKEis3CjWEWV+zy
	R8KbB80XUWA+2r0MlIaq96xGx1hIe3AwRKcyjREBnqjglO/Ue22y2U8IEVzEgtPLq/M=
X-Gm-Gg: ASbGncs6O0gJzh/qwD0EUN+rRcT3q6PHD3i/q4i8M37ANTo7Z65fcqadclILYCEle7P
	hy6/dkDbFXMeSpfDXvgcq5gCCZI/XX63DZ+d1U8+CSHH8Xm6eXEkx2xUbazYoxGfwUCnhA1izLo
	kZiZb/5qkdpey/tlZ/wJv3Q86a06hWd0tHWqUt7jVeG4206UwyQjPpaSGIl+ZNQqc9UpAp4oV9K
	0zAs6CSec7pSOt9P8eweHzjB/avsW+xU1FCWH/QW33sZBkLd+Cr0qWP0K9fou999m7ReT+ngYY5
	JiO3UaZ6jlBWuoiOgPOUThEG9fgu5ymCaFo85WatBOTh87lrBkZx6fkqSclK/Xz31LcBRbgHEro
	JDZSDctmc23sldWNGfZfjw/yFTlVHbFuvN6gwDQ==
X-Google-Smtp-Source: AGHT+IHN1f3Uj/iD0rR/P0kz0n+e4uJ5LS80ahPGJ2u5rWUrfdqpbvNFxOh7h6qh7RHLWO6E++a52A==
X-Received: by 2002:a05:600c:3b10:b0:458:bf9c:274f with SMTP id 5b1f17b1804b1-459f4facbd3mr123467115e9.29.1754986721942;
        Tue, 12 Aug 2025 01:18:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e5868fd7sm306386425e9.18.2025.08.12.01.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:18:41 -0700 (PDT)
Date: Tue, 12 Aug 2025 11:18:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Scott Guo <scott_gzh@163.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Scott Guo <scottzhguo@tencent.com>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] squashfs: Avoid mem leak in squashfs_fill_super
Message-ID: <aJr43n1np2nB8bht@stanley.mountain>
References: <20250811061921.3807353-1-scott_gzh@163.com>
 <24759bdb-b427-47a7-b9c3-724a11d0162e@web.de>
 <461ae944-5fb9-4860-81c1-1ac48c3d888f@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <461ae944-5fb9-4860-81c1-1ac48c3d888f@163.com>

On Tue, Aug 12, 2025 at 10:11:21AM +0800, Scott Guo wrote:
> > 
> > By the way:
> > I propose to refine the goto chain by using additional labels like “e_inval” and “e_nomem”
> > so that another bit of exception handling code can be shared at the end
> > of this function implementation.
> > https://elixir.bootlin.com/linux/v6.16/source/fs/squashfs/super.c#L434-L466
> Will have a look into that, but maybe fix the current issue first.>

Please, don't introduce more of those e_inval, e_nomem labels.

regards,
dan carpenter


Return-Path: <linux-kernel+bounces-845489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF6EBC523E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4CC188B125
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E27927A900;
	Wed,  8 Oct 2025 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qt5WkABl"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063442741C6
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929046; cv=none; b=vFJylOYs4KZ7m3z0YOF2y9NymTFgNtsqnXQEulX9ysV9xGj70FFSW9OyWLgoBhIpcDeaDKDW02NE9cwX+ynlbrIJrw8qhc8ek76JwPIfA+yCFWJLJjbxZAmFKfZn2ctFTwPZo9CkFx5n7GKrMb8XeBF5WyQqgvXDeRrSeAeiQ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929046; c=relaxed/simple;
	bh=bzwdPAuM8Rz/Bvizjj7IemyxtXu6fMaEk02nQJZstYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALviU0kh55bBbVK6E74YjOvkY56wG1gn7xBM6Y7at/jCh5xdNVpQ91hOMHxF/whHWFrLyo02jyjBTvbIoHNxAuGrBh2xlSEDUSlCUaOiBnTLSW+Zxz69RcksvTp/mvEJxu88mtHtWkQPDzHnha2m8sEJo24dUF8nyY5OQMxYomI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qt5WkABl; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781206cce18so1065572b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 06:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759929044; x=1760533844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bzwdPAuM8Rz/Bvizjj7IemyxtXu6fMaEk02nQJZstYQ=;
        b=Qt5WkABlK1xlksYE+WbyFB2oYorVn+YS8BaJnRYC2xhRMrPhTtJBIxv6A1YKEZ5e43
         EJ2hfvLucsUoEa6/+fBM6PR4dmQH1e/7/zj1+oYgYvK3FYoC9fOfxrSRNmCM8f0h3gBf
         rRFD9yNwMyovBRUcXhO+WEDMYomhJ/+suNbjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929044; x=1760533844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzwdPAuM8Rz/Bvizjj7IemyxtXu6fMaEk02nQJZstYQ=;
        b=byvMQokLSsZn5X+AsG1+qWdnu6OSHLUTwet42hPrcZDKMlg4NuQDtuNE6Agg8uPE1F
         LcoO5WYR62UO8d+V/nITHqdtg7x5M8zmFCLr+wIfM8MjwU2RK66BbMM516MStofvkeBE
         g6M4As4sCOYcpGIr+pLb3IppKXUQoUSWvWnwu3U+EEbeSwocHBaWAQ/BrYumcgsq4HM7
         VN3u2W+nY+3Q6ltEullUAOtKUJFIToXRUVfQ8+ysJnm1qOztmsL5re7OxCsG+Dfpxthh
         pr/gAMr8p+7CLgK7Q3YIgbZ+EklpLp36ScGZ1/36II/Dy9cM5e/De2BOCGNYp7EorE8D
         9JvA==
X-Forwarded-Encrypted: i=1; AJvYcCUPvMF6j3EQT2xEsqS9lCaXfNar40em9pnIZbazQfe5bewMGhL6kWBIvppxBe+uwIorLrzdACNWV/NrctA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/JbAqWIhhhvlBOMzxVVuR+sOIgpx733KVWA7SVZE7UpFNdpy5
	pZD7EiRKI7Hf4FUTkpKHICqO+bTgYeLbsEC0qhB9Vgp6zn/7LgFjp1qg7YBXZOgz0vPNQCoGajU
	I3gE=
X-Gm-Gg: ASbGncv+jO9Sukjkk6KNwkHUvz8yZyTME4Ak5dVI35OIia5hyol/YXsl8nLutyd6wKe
	sTj3rXdZYIa+UIkJHmnaHb93G83UX0wzlQD5ZIgVMb/i8JoabCeCCfTfI1tR0D97+vRKJSTBhfP
	yO+xriG6uWgaNSriX1GX9F4r3pi9WdLc6dsgatNimMCny3R1OYuR+kKC8UqpCaeqde5NLZwuUxn
	LH3PlvCjDo/EzSGbtxaTVMh0NCuQWgH43PVzjY9DzkLj/XopmTxPpd2eCrrlqU0d2yiG8gvuKuX
	8155NZJsvN2xdu43E4/dlWqfns3CnmHJez2bezWAb4I2Ni0EDfWd6Jlsg6CQyqETffa4hIEM0/j
	znmMdkNQF3L2abnF3IrciIc4+T286mWryP9K9hKBsuXvvf/05IA==
X-Google-Smtp-Source: AGHT+IETXMqAb55o9uu6gXXXJpn8n0BcOETXjMMNThpqVg0lzq6C+Cs9NvKO6yDPfW+DQ/3AHfGB2g==
X-Received: by 2002:aa7:8291:0:b0:77d:c625:f5d3 with SMTP id d2e1a72fcca58-7922fab2513mr7191654b3a.1.1759929044216;
        Wed, 08 Oct 2025 06:10:44 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:465a:c20b:6935:23d8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9dae7sm18883416b3a.9.2025.10.08.06.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:10:43 -0700 (PDT)
Date: Wed, 8 Oct 2025 22:10:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Pavel Machek <pavel@kernel.org>, 
	Tomasz Figa <tfiga@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] PM: dpm: add module param to backtrace all CPUs
Message-ID: <rbap3e2chlgx7zn2uw5fntjfjoqlfdebsautmiaq4oz7y2ecnx@ejmbrvrtbpju>
References: <20251007063551.3147937-1-senozhatsky@chromium.org>
 <20251008101408.dj46r66gcfo26sgl@lcpd911>
 <CAJZ5v0hBzgJP2L0yg4JtP2c=NxA=MqAY_m+9GJ9P8kszb1hWvw@mail.gmail.com>
 <20251008130234.mw6k4k7fupxma2t5@lcpd911>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008130234.mw6k4k7fupxma2t5@lcpd911>

On (25/10/08 18:32), Dhruva Gole wrote:
> What I meant really was to consider another path instead of a mod param,
> something like a /sys/kernel/

Modules' params are exposed to sysfs and are writeable.


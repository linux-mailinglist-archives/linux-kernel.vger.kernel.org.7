Return-Path: <linux-kernel+bounces-830705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A786B9A562
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9901626AA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8248E3081B8;
	Wed, 24 Sep 2025 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0SJUo4s"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916CF2FC860
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725350; cv=none; b=Ckx/tlLQKbuGv++pwo7CDHpz/o8ZkHKF4GKG/oCxlGyknYdpAbaHXB0eYrvILNYeuYs8JIllBp+A0D6SAnzgT9r9MSODsVi/s70OMSMacsAr44uc2gayH3AgxEhq2a352JiC8w+1cKIWw4PprQ0TXyxOjWeolIzmNuJZpNSaDJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725350; c=relaxed/simple;
	bh=Ne3PQvFuXYtDil7myRTwQQ61xiDQTxe02MSNqQTq5D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJMawOJtOVFSW3VRG0e2s+uKUCPn9s8FlfhD5vhX6flvxeixw8L5F45bjbmPRhepFqs6bsKJf1UMqhM1mPsJ4CAAUoHxVTTccHQtELtsxFP5Az2F5oFdf2OVuF2etbUrgtzVtcZxL8zFOHw/rCMXn5DwEkm2amGIG8R0KJlJj/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0SJUo4s; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1174076b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758725349; x=1759330149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTcoa6Zz9kvrOd/56qsfvcd4iv+T5ivIw8BtHV3xup0=;
        b=F0SJUo4sWzkP+5cN5TEHBExEjCJaMM6mLt6fk/j7pASMaVYEv+aPLb/M6PdGdI4CD2
         y/eQ1TKf7p0rUUGbuChZLPziVe7KXN1c7X6ps8XqW5ClUaWIyRo7GdJQDL+IaHEdGjK1
         /XCWWIQOJG46NOTd/XAfNg7dJLxSI2EycxBydJkZ6yRNaoG+tH+NGMumn0Kk2rkUCIYe
         8l3tpKjbZveLjxaQ5ggJRjD8Tfcocwtn8wnukrt8xcB9a07h/6TUmz/lcXH22f9bzhQ5
         GyEb2/90qJC7Wd7a4iuTOvTCgvOvudxkEe3Xmz2U4wWGi/J8FT61PtM5422YWo7rLkh3
         Lo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725349; x=1759330149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTcoa6Zz9kvrOd/56qsfvcd4iv+T5ivIw8BtHV3xup0=;
        b=AsfGoNW8c98DA+ziB3Tq5bXBa8xZ7klMH4/o/jT3zKpXauclJHZ3C/S7OujePqdKfV
         p95u5eE9y7w8P1gl1ACSOF9XSb3o/M1QtewkHmeOZpGG/0imUYiEmdcsRRgaK4oGdKrR
         9IDXMAr9wAs20s0rmCpDg4isJNYMRUHfRCXcM767PS8BBj0kL5szwVYsGt7aq4+jeDsN
         5MsOqPI4bMzmqo5GR1H/orwy650Z25baCoUAq13/5Ih826munuByhCC8prKRy5V3q15Z
         d3cpFaqVG0GkoOm49bMWGDbvoOtYkT4wIVGBvEbssr8FdxgnzFZ4qhKTodUgh7K7A/O/
         ORRA==
X-Forwarded-Encrypted: i=1; AJvYcCXGOK2xH0O2dCLqu0Y5/Diqa0K69pbtrsrG1ISW0FvmEs7TPw1qL/40EVTLAakUpn31H1KYojhSxpSHQ50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3GjaBKR/u3dkbwM/MT2a9uBCqEb2Wkj8vQYptiF9O1cQib3Y6
	v+qfLwo9V1aKy9A3jQtyuEJoUlq80ixAX6204iFHPlvrCBRBY9Et40rI
X-Gm-Gg: ASbGnctsbgucUSMeUlc2DrP7eNJJKKzAcVA0oN5ui0VQa7ydWHCllZSStIQIdLRVVdv
	/TWmOuZwkW3Ye9MlX/sZUqDgVF8Rju3LYlLNiQ+pIWFa3bTA8EsbaxzpBJpQSNSpxzdfTdAKqxq
	Awe45Hy+sDPMzcRNBxMeJwhssiBE+3q1mffWA9BjM9Yz8VkQz6QZW4YNS0NjwMd0iRSt/+KsbAL
	cCum14Mt7H8SK5Z8EAncOXlu6NkRxT9Qymc7NfyxHQiQRcswGLpyB5N+gdOkCf2y7FbvABPdI/i
	b0BEz9bHnp30KofkxWA7BQw8qB45McIsXIIT6vuA/vGcH8FYsjBQ8d0Jf2kPicv5se7F3S23qlL
	aIPdayNkdgYUNvhttNzrCoI6ZUC7UOx8IXXB20dDG6NU63A==
X-Google-Smtp-Source: AGHT+IE3H65r5seFjizDOCCsJIiCdUp7VyrXHd8niwx/uUBuHdurOAYlr+ucwqg/Q6jxd0cGQwOd9A==
X-Received: by 2002:a05:6a00:1490:b0:771:f071:28fd with SMTP id d2e1a72fcca58-77f6983579fmr2710893b3a.14.1758725348826;
        Wed, 24 Sep 2025 07:49:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7805ca5f7c4sm1821991b3a.81.2025.09.24.07.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:49:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 07:49:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com, niecheng1@uniontech.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] hwmon: (gpd-fan) complete Kconfig dependencies
Message-ID: <7db7fb9e-fc02-4d76-aed8-c32d59d51f4f@roeck-us.net>
References: <20250924-hwmon2-v1-1-fc529865a325@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-hwmon2-v1-1-fc529865a325@uniontech.com>

On Wed, Sep 24, 2025 at 03:48:38PM +0800, Cryolitia PukNgae wrote:
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> DMI and HAS_IOPORT is also needed
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509200214.i2QX7iwD-lkp@intel.com/
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>

Applied.

Guenter


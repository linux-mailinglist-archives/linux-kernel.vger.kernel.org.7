Return-Path: <linux-kernel+bounces-734348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EC4B0807A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6FBD7A7BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B396E2EAB7C;
	Wed, 16 Jul 2025 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FSz1fcKs"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3147B660
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752704723; cv=none; b=TMaLqXPw/qtXHeCO1LE1MRaUl6fvksdCI0U1qrGnB3b+gUMR9HT52sW7G5dB79ap3Kf+zPy1vtnn4W2i2Gj4fXkZ/hp10Etl2d4JSPV5sPphi8etj1swt2wk+/0NkrH+GQf7Smw8CuRkU0PEr9Zfx65QW4vlNh+obnf4F8QwNdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752704723; c=relaxed/simple;
	bh=oZuh26iOTA3ERNW2NE3pui2MltuT4r+wNttdePHurfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJlvmwzFPqEWLJ6P8Gb8phCoA51DUoKEq1UUIklHB3e9koAEfiuqvSA4kapzEv66gGJQaVh3BS+7ub9AIP8pBsc4rqhVI+EyfWOWUB2eKf4Wr28fGWe/TFr8VRyZDbwDr7/J6jnKv1p4Lx4HmWcEf8cyhnX8WBkL63cK/bMQsZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FSz1fcKs; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso400815a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752704721; x=1753309521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GhHtsrisAm1TD+wB7FG+SIYPIUgcXpj9jh2KYAYBvgg=;
        b=FSz1fcKsi/u10DVwMLA5drdZaXY7um3aivIhrVGqgY6iKvjghcpdGwOVK2YBmtFGTu
         mmNgu6LOKI3l5xKk9VIlYdH5rZ+f7ngDfdQ/KLwyylJ0pO8Pgmpb45CbCaeidgM+MQM9
         cSCDk6Zb44G4oFelXM1xMxHwHBmGyDs3SqW/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752704721; x=1753309521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhHtsrisAm1TD+wB7FG+SIYPIUgcXpj9jh2KYAYBvgg=;
        b=J6YoZKr+lR+cmQvQWBUwCVcPHxjKsK0MPN6ZRDwhFbeUeff2Jrx0gijYtf5EXwioga
         P/mcXlnVtR2cRPVVlqfRGsWFqJ0h5QHDputdPQ2vt7Zyrmy9Ot/f+21EFkXTVw1moCky
         sBKWsRoopGy65EsQ5XC20/cKtvoD+AHo/WFdvfLxk35/uUiMPGRjabGpyoUEbbTEh7ht
         bv3lnrYXZ708LIMA+uC7WbowpSub7eNc1ZDqmPsUszqa7p6JiYN9l4S2TPMGZ8DZPI+0
         VknDhLt2JYz+ICyIRa1XxfBVo5zng+E/FZjq4fk7XhclIuN7YNLMcg/u8bCv2g7mdfgV
         6JQg==
X-Forwarded-Encrypted: i=1; AJvYcCWNV8FjhWnr8+8IFONqe6YmjZyYSYJJLGmgq/Xp7baTDpmQDT/CbirHik0IOgRtWoCuCpwYEfk/3kiv/bM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Y2T+m/6iBK3FhDBJIXyOu1wXUvJe1H6gmmbFe583HqyGMwTw
	xSi4KN1pRO0y+BlXPaZt6TVK7dTeRQhAlZP4R+OsLWlnDvGqfFbQ+YOcIep9LW6VNQ==
X-Gm-Gg: ASbGncv8XNO08sUpI2VCBKDRlH97CT/OmdEq6WaM7N6a0bYVjK9jRUBN6QNcRafSDE1
	hzNpXMLXzz3DifqzmF+Rtt8LNv037gyZxj8BGb9BWl7gmSCpQks43ayi2T834c7uueM985R1a4Q
	6rtUwukO+PyV5uxZzP+/jpAtwEIo+n6sjXKM/dYkFJfRCvo68L3Of6qvfvR2WidZwQGMZIYy+3J
	Aho8RaTZqlE14vFBHwDemF7RcLDT12Sc0b0o0NSNVIC73DCbcYB3p1zbxJXJKdq4+mIdw4ROJhs
	uPqvR7HCG209coBc9Ma/aeCS3D7F9sNnPuAReKOJEPJmNimR56qkWc5AYSkypjHm1GEtSJ6lfms
	jB8B8dcFHDGIcQpKLxC+0nze4WDoa5egtCF0W6SIRNboE9O5EeRKuNXtUMyg=
X-Google-Smtp-Source: AGHT+IHqzQ4p9upHg8ZJ6UFR7/+avGiS90D6xyNA8ohw41tdTjIaHUs9wHZaUtjeEqzUJuPA+j2A7Q==
X-Received: by 2002:a17:90b:2584:b0:311:df4b:4b81 with SMTP id 98e67ed59e1d1-31caf8ef446mr760115a91.25.1752704721051;
        Wed, 16 Jul 2025 15:25:21 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:cc53:25f:edba:bd66])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31caf828a0esm185075a91.42.2025.07.16.15.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 15:25:20 -0700 (PDT)
Date: Wed, 16 Jul 2025 15:25:18 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: Only destroy alongside host bridge
Message-ID: <aHgmzpNzMTL2alhp@google.com>
References: <20250711174332.1.I623f788178c1e4c5b1a41dbfc8c7fa55966373c0@changeid>
 <xg45pqki76l4v7lgdqsnv34agh5hxqscoabrkexnk2zbzewho5@5dmmk46yebua>
 <aHbGax-7CiRmnKs7@google.com>
 <cnbtk5ziotlksmmledv6hyugpn6zpvyrjlogtkg6sspaw5qcas@humkwz6o5xf6>
 <aHfXrT_rU0JAjnVD@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHfXrT_rU0JAjnVD@google.com>

On Wed, Jul 16, 2025 at 09:47:41AM -0700, Brian Norris wrote:
> (2) Even after resolving 1, I'm seeing pci_free_host_bridge() exit with
>     a bridge->dev.kboj.kref refcount of 1 in some cases. I don't yet
>     have an explanation of that one.

Ah, well now I have an explanation:
One should always be skeptical of out-of-tree drivers.

In this case, one of my endpoint drivers was mismanaging a pci_dev_put()
reference count, and that cascades to all its children and links,
including the host bridge.

Once I fix that (and the aforementioned problem (1)), it seems my
problems go away.

I'll let a v2 soak in my local environment, and unless I hear some news
from Bartosz about OF_POPULATED to change my mind, I'll send it out
eventually.

Brian


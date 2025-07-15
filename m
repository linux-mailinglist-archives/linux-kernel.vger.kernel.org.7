Return-Path: <linux-kernel+bounces-732551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F4165B0687B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3BB01AA1541
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624FF274656;
	Tue, 15 Jul 2025 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MJ30Ubpm"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E88D2C08CA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752614512; cv=none; b=L7Y3343B7zshaKe4I32Pm5/Kwd9F+v+yLPpS9Yx3JiI13BgZjgd7447AHfJ2UsgyjnOa3O9Eezg1WXJHwSPnNhIDkFA1Y+yprTIAvtFgAblbEA9jT8GlawWFkYYnKTukzYf/ktlkxQl8vA4F04l9Y+RmCal+z+SKGdx4liDD58Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752614512; c=relaxed/simple;
	bh=0posatzBS12bnxXIcdwVeW/8+FWeoy0Gki/K3o+H0vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB9PTtd9Po1v2PmAdVWFh/Ja1D+dx35bHV/imtRCkpBAs1P3ZQ/p2brA8AtzhrG2Xo9SIa2prQtDsQwhkyXk8JYH97Y4bOSytUIL5bHpbkhBXY3K0PsYvwQfm8JCmfFRcjm8G4wbaE+MTfagRFX9dJMJ5mU+gTx3Ragnxiks2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MJ30Ubpm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7490cb9a892so3614158b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752614510; x=1753219310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0posatzBS12bnxXIcdwVeW/8+FWeoy0Gki/K3o+H0vM=;
        b=MJ30Ubpm9Lw94C/WgU3M3AtORAsWsQcDpxH8TKVxaEkdEYEVDMHNS2S2+g0roaWh5X
         91SvQq8tDEe5nu6QdVvmM78LQ8+VnpCi3tkdcev9nZ5/8qr5gz65bn2h7i7cMMAohFCc
         1ePNCrQ3YlqaFq49luqpkliLY/8O9RsOD6REU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752614510; x=1753219310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0posatzBS12bnxXIcdwVeW/8+FWeoy0Gki/K3o+H0vM=;
        b=YhWUrF2OJxjPy4CD51a43/oMLhFmw9VrU6OZBh7EJ2T87nDqc5DViAPP03R50S5umo
         fb5F6iTahMKsdSII9YMRnJUANIpOBE7jsEjypK2hFm4NHXoGBSzIr+o+k2xqL2AAQigY
         waklNYDzpSnIQUVt688XDj+Y5L0xW61SDqvBNijjj6L/bZtG/yPgz6UYTChgVeIx0RKL
         E8/QszqzHqid5dxYplzCBLPA9AHa/8qqAzTbldXbqi+UczniokuXohKtHiX54yWkCzCp
         lIzZfJc3wfNsaon8WVTq8CWhPuKu5FRSBu9Fq7HWGMA9pzW0aAiQsXHIdrOi1KtytZAK
         J7BA==
X-Forwarded-Encrypted: i=1; AJvYcCX1tA7n/kochUwz443dajK1x9GR0OAmUhxJArmxhuk5cLa9OopbmyEcfqF0iBEuBEZFtGTYPk9CLGFmKOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YypvvYgOxxGTzp5020ZgVBmO8pazjsUNx6PgfaCbJKYP89CUs2C
	2/+jeyHBZxAHWDsPi1DBv7apiq6R9uvmWDwLezWIJ4GThPRxhCIIZKrEItynQ4DmG/PJX64pSFU
	GBk4=
X-Gm-Gg: ASbGncv/VNstrNr7i+coEzk7gHo8ve0AQ3TzCCAI6gfctJ+NSkTYSGg7EP0WlL9trDn
	epbcHBSPfQmO0tqIPToDdzMhDPnGmYNf20XB03trjcc1Wqv0yKr248NsJOEoIpUjWEslSLB21jE
	SL41jVLiglXrL3VCEPBdi5StThKsWZMYg3bxBj9XdlGUjh6LlqICXdUrSOrn28zIg6B0Qgrs1y8
	0pZ3vT0WtAUude+z6JQuw4zigBlZ3QJKJaPmwLxNkTz3jxgg0UzB/lKuyLuEwUl4hvwgdiyGa+V
	80VglB1iKi9nnd3IG5D1LOqK/w0/jvbhaMILWZFzlCOArOFIa+ecHZQLn11AqkEzOphs9b0Vgm5
	GlZPWZXbkqCwu4azujuMRlN67RqIqG6ygKRGycpxNdtxwc1oYyN8S2vcAhaA4
X-Google-Smtp-Source: AGHT+IHA00ykSXTlF9u0u4zAwk20CD1AsunIiRFsvPWNEZAqEjzuHzWlIZZqhbaIHo2y7XvhujW27A==
X-Received: by 2002:a05:6a20:5483:b0:232:f438:d424 with SMTP id adf61e73a8af0-237d5a0cbabmr1442953637.18.1752614510336;
        Tue, 15 Jul 2025 14:21:50 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:3478:49c2:f75d:9f32])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b3bbe72f8a9sm12246651a12.74.2025.07.15.14.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 14:21:49 -0700 (PDT)
Date: Tue, 15 Jul 2025 14:21:47 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: Only destroy alongside host bridge
Message-ID: <aHbGax-7CiRmnKs7@google.com>
References: <20250711174332.1.I623f788178c1e4c5b1a41dbfc8c7fa55966373c0@changeid>
 <xg45pqki76l4v7lgdqsnv34agh5hxqscoabrkexnk2zbzewho5@5dmmk46yebua>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xg45pqki76l4v7lgdqsnv34agh5hxqscoabrkexnk2zbzewho5@5dmmk46yebua>

Hi Manivannan,

Thanks for reviewing.

On Sat, Jul 12, 2025 at 10:56:38PM +0530, Manivannan Sadhasivam wrote:
> If you take a look at commit f1536585588b ("PCI: Don't rely on
> of_platform_depopulate() for reused OF-nodes"), you can realize that the PCI
> core clears OF_POPULATED flag while removing the PCI device. So
> of_platform_device_destroy() will do nothing.

I've looked through that commit several times, and while I think I
understand its claim, I really haven't been able to validate it. I've
inspected the code for anything like of_node_clear_flag(nc,
OF_POPULATED), and the closest I see for any PCI-relevant code is in
drivers/of/platform.c -- mostly in error paths (undoing device creation)
or of_platform_device_destroy() or of_platform_depopulate().

I've also tried quite a bit of tracing / printk'ing, and I can't find
the OF_POPULATED getting cleared either.

Is there any chance there's a mistake in the claims in commit
f1536585588b? e.g., maybe Bartosz was looking at OF_POPULATED_BUS (which
is different, but also relevant to his change)? Or am I missing
something obvious in here?

OTOH, I also see that part of my change is not really doing quite what I
thought it was -- so far, I think there may be some kind of resource
leak (kobj ref), since I'm not seeing pci_release_host_bridge_dev()
called when I think it should be. If I perform cleanup in
pci_free_host_bridge() instead, then I do indeed see
of_platform_device_destroy() tear things down the way I expect.

Brian


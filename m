Return-Path: <linux-kernel+bounces-644696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D6FAB42EB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 20:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506EF1889715
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B49E299AA8;
	Mon, 12 May 2025 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DXcBYu4u"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06071299AA4
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073400; cv=none; b=IvIUJCke1cifcP+FlrPX1p1LHfF35szGtu7Pt1NN8nIgRB9ZvV5ejR1KNCyqzB8d3Kxky0jU3+JOfv7hfZZkLXSttdP5TAExe9sFmeUlWDYpFhuquFs0Ylv9udWjFR1qxZsF4rZP2eHSyUPrtk7Fb1nHSBJFwJBY/7rjNoOkIs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073400; c=relaxed/simple;
	bh=cWcnF6hGE/Ye6ZO375UdjwJyHtfdTGvvw2msT1AGNEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtXU63u2Bzn2mW3kLIOGoCbxkED5mmQLCaERaYXdKQXSly3YRyqHg30ieiYyyBQtp8sGfuU/WTvleu5vOlYIBvcRUI8erWqBwd8p8ZZDkKoKfuBS59qZ1PjetfYnXLHq6c/hHsxQtykq3AlTJppKGiW15zbhDk+Ywa+942Cd/4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DXcBYu4u; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f0ad744811so35934866d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 11:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747073398; x=1747678198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e/iDvEsSNRwi1aH8iKQVOJMR248bXxybzmXa6GTNy2M=;
        b=DXcBYu4ur+MLYeTARtLxuSjGH0G8R3OlmLybrW/19tyVtnmpPM4AUr2/oKZ+Z4cP2c
         War7lY9LK4tXjpahUK9j01otA7YguUdEWLtB0eV0OLigUsvEM6lMp62CxJ3VRD+7iq61
         g1st8fzKYVLAI3nktlTffEf4KG56/IvJl22/LO5W+ChSNZxpm4HvEj9D2vFMWNORG/fg
         FWYHso+brd7AtIuDYnDROPK8vTB0eRAiTqh7eS3lbs77dPyFjJo+M0Ec/B2J91imbvqY
         PfEp/B5u6ynu0YDN90VbBHatQa+Ducqm2FEoJ4YJvTeE1ZJ8Khz10TNR6p9mTEzkGsKA
         2Jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747073398; x=1747678198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/iDvEsSNRwi1aH8iKQVOJMR248bXxybzmXa6GTNy2M=;
        b=MiWnqiIxC89+YnwxkKC81958saC58KS3U5L0lhHKExTvNuzgLGbfdH+8c8HGLhwu9J
         Ee7aEbcf1WhMPfEMuaNbs3RKlXMulrDNmwexWkdKLkYsGEGOPL5pqTi4fJCtkeaI5pnZ
         8/c+NNTpiYjVjB8HmHdeoDd53pzq6pqOCaopiQQjR0iGhxiBX+atgfaQpjPkPXpjSEv9
         OZFMneYBu/95ETIuZKhjHfYAIgbUNAyiBOg6Ps1CnlzFiTEQCHU9qiZEzJP979uCr4a6
         OqvYjfT2dUFyKvBOdDxD4HdRB0STWt9o81j4LBozUWbe6P7nbTl52FWMH4U+gNH6qmL2
         6kDg==
X-Forwarded-Encrypted: i=1; AJvYcCXMqnYtkrbQW8wkHt6gaA3CzvyJt9z7LrVW2zYmO7/NIlsY9076tW5TgY2bBgtBlxVuBlRPnE+GMPIooWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy43qtSu7RguLmiG6ZOXfXrxJTg4JYwjCf+/w+k92SmnjppYM6D
	Ly+cqpTQhBkNZ2EY5ky3m8MRwYX03kDEIXIa3Wf3vcIIF01hot50+nwGlkGFebA=
X-Gm-Gg: ASbGnctcTdNMfEMZjw0AsVk7dmoJVk0BmJ2pAAN+tGgRFyt7scsdB5sLRbQ2oad/wzf
	a6eEV9TkzqzgXOYVKWfpV+mjKP3iXwJToTNpsdZrk2Z/LCYOBg0+bkRjYFq4AHgh2mXF5hSmWzu
	+JCYfw5xrx9kyG8S04KGAovlVe5QJZmcj6CIeltTR3jX143z7ceIje9u4gRhGzORRLP69DM6nHt
	IjSGJf/r5HoekumBaxDdAUA6eyIuYNkf/9my3ZIXx5OPxsllxjU1qKSOWP9nJDEPC4iRDrROr1t
	hsfPL0EzxCS5ATdCCaK74wQOxv9S4dAvb6i5Jn8BmJ9b46HM8gEdfLc81GLpQvbay+r6b5Ws4M0
	xLgQ9HICXItgACQomFDgJvRinD7eNV4I=
X-Google-Smtp-Source: AGHT+IHfNuX0QzD4BdSUhiyIBeelzyTiA39KqOo6r6tn5oIPKGjpRdvxCGpkFc3YRqf63eD/EfUW2g==
X-Received: by 2002:a05:6214:234e:b0:6e6:5bd5:f3c3 with SMTP id 6a1803df08f44-6f6e4821690mr177034106d6.44.1747073397756;
        Mon, 12 May 2025 11:09:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a4729bsm54875686d6.70.2025.05.12.11.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 11:09:57 -0700 (PDT)
Date: Mon, 12 May 2025 14:09:55 -0400
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, corbet@lwn.net
Subject: Re: [PATCH v3 14/17] cxl: docs/allocation/page-allocator
Message-ID: <aCI5c_hIS8bWgAaC@gourry-fedora-PF4VCD3F>
References: <20250512162134.3596150-1-gourry@gourry.net>
 <20250512162134.3596150-15-gourry@gourry.net>
 <aCIjMNooAzKaONod@casper.infradead.org>
 <aCIkF6RZJtU0m3Ia@gourry-fedora-PF4VCD3F>
 <aCI1X3NZwuagNOqS@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCI1X3NZwuagNOqS@casper.infradead.org>

On Mon, May 12, 2025 at 06:52:31PM +0100, Matthew Wilcox wrote:
> > 
> > Feel free to submit patches that deletes the existing code if you want
> > it removed from the documentation.
> 
> Who sneaked that in when?

The ACPI and EFI folks when they allowed for CXL memory to be marked 
EFI_CONVENTIONAL_MEMORY - which means Linux can't actually differentiate
between DRAM and CXL during __init and brings it online in the page
allocator as SystemRAM in ZONE_NORMAL (attached to the NUMA node that
maps to the Proximity Domain in the SRAT).

Not sure there's anything you can do about that.

And for DAX:

09d09e04d2 (cxl/dax: Create dax devices for CXL RAM regions)

Which allows for EFI_MEMORY_SP / Soft Reserved CXL regions to be brought
up as a DAX devices (which can be bound to SystemRAM via DAX kmem).

Wasn't much sneaking going on here - DAX kmem has been around and hacked
on since 2019, and probably some years before that.

~Gregory


Return-Path: <linux-kernel+bounces-876811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3F9C1C732
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B7B627576
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A803134F46F;
	Wed, 29 Oct 2025 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="c8pjbcQj"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C61534A76D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758381; cv=none; b=AydAeS2P/zycOnmG0bFfhRasrdIlF0evVg/em9H9m9HYVOJibAl8dcn5hTsywdlME26fjPmGFw9VbY2Fbh0G2wH9Z0zkyreBMSQE7+jOvupZ2pc8huNrEP7CcLD285B6gMIpJIoor6LsSXTSIuwGPT/Hzh3QHPok6gNHQKMClww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758381; c=relaxed/simple;
	bh=bSNd3wWUQQy2YBLmw8YBigmBKjZAe88REZ3E0Gos148=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJFkacIIxlICQOFowsX5Sx90wnddrCoep79pidWkhraewkvvTYMdxXw5lfqpS+YYlJIdeDlgEyYhqzYzGOmOAiKyLCuwZ7pdd+Js33ndF+J1Kiry0S4eWTaJWP2pkcF+bVfaJ2dS8xN6ba+XUxlZ6wKhbRyiRRTlelJzEgFs1es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=c8pjbcQj; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-89e93741814so7637885a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761758378; x=1762363178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bSNd3wWUQQy2YBLmw8YBigmBKjZAe88REZ3E0Gos148=;
        b=c8pjbcQjxYYDCLYOpUG3c+UetpD9UmMy/mJjP/03CJP8njtwrgRzXB/HgFJGl4wT/D
         jjnTAwdncSiIYxVxS4NKNf+sRZICL1F7MbwO9oyo/kls3vL4lAflySgPYCDmDDVikQ7C
         238vFOO19ldNgXjx63Z1OJyIfwcKIcR6FcKbfAw9VJWXC1VLhbtBWuzxZ45KnHuCyMB2
         Y5HDUegpQuHOhxBr7jp8EuagqA/dgBhHQnkhVlBso6COfgKOzIPeMaa7LV34sV1yIPtO
         t5MnVyO+aMaWUtG5jn4ztju/oLfFp2Jq5oFyC4LbeIX8Z7McFa70Eba5fPcikY0Lh359
         kbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761758378; x=1762363178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSNd3wWUQQy2YBLmw8YBigmBKjZAe88REZ3E0Gos148=;
        b=Sb93juicND+tDUtRRLWahqqP9m+gZ0Uor0bcCRhLe8K5+JXT4kJlsD2Qr59iEzrW4L
         WLe6Vhpy0lV9ifIB1P5ixw8vcozjIaNBj6PWTJ+oz1FxxQXwCOqMclQXfQm6ml8To9Nk
         MQ2A4ltYy9IVcJ+UDlgyk0F1ifH0G00GS7x77DJBFJJbA+vqsVcc7R9RDBUhyeRb+A1c
         /OU5WZB1UrMCIjguRRzZJJy5OzqIHYZA18nYSJynuJL4zESSGtrPcXU8bfRbktiIKsfl
         Mm8mIZmKLR5cY+8ZTmDnV8bpGW1O559ZrzBQk/DUNIOEuUmhSRPvWJziPVWfJp90lNGl
         zayA==
X-Forwarded-Encrypted: i=1; AJvYcCWqnQfuDZ1doNU1RA0wdn/OubEDjeeCJYqXrG9MCtNkIkroUSGRlJTF+KTjIArSC1RkqRjyezaCDKiLCXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzodnuPIueqfiAu0VmjkuuJDnD+GxvHYg4SZOO1Qazpj7ZTmiLL
	SIZVs7x5kttT+0wjc5MBxAW1gwoB0ggw1exDwO84PrzgDt7bMijmZ6GB9C/Sg7xQK1g=
X-Gm-Gg: ASbGncvfJpmUFBDQGrI2DmMGwcgQoS1fDsWdPbgcTLg1Vi7BoeVhJKIWsulFLNZi6Qd
	koYukVLfoK+pz2HodiF+pBxAYCJcXk12N7MR/AJ8SS55dPOmD6tEnscQ40q8dZ9ZJeUA/e8YAZl
	Knj/3gWeO9e6mUrVb533xkvHAyYBTUledxbIQ5PQGf/RmjoBPUR9yB6pBqKmZgpxDuw6U5YsQ6h
	g9pPm3MpliZrJkf0JoUtWzje2S49smF9ZRYMH+6bkjYyoZj7L0vZ66fm1Yno8M9RgRC0siFGn4G
	KcfWG9YZJpfskk24dHBB3KwkmpDqUb71xnkCmk91U7irpX+TRE9xAn8XAqZRFkE2E+K9DRYLMNW
	ruk1txqX6SZ1UDoSKHsp9Fzfz1QUpS2qHeqV99+wxuebkmKZ2A4L+rqlLVLNBLwuVyAsCUddWc4
	bHsAOfHM8qEN8k7uDLZCtzLldh60j+hov1Hg7zj1PkBqYUK5n0NhgxCuu8
X-Google-Smtp-Source: AGHT+IEE6XGe0cEoiRKL4NLOLkjviUWVkKq1s/Sgdt6ffSSTAqyCXCbcME2UvP5qWSwdJ9Al+rYJjg==
X-Received: by 2002:a05:620a:bcc:b0:8a4:6ac1:ae9 with SMTP id af79cd13be357-8a8e436110dmr482308385a.3.1761758378351;
        Wed, 29 Oct 2025 10:19:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f247fe594sm1089845885a.16.2025.10.29.10.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:19:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vE9pg-000000050Jg-2H4f;
	Wed, 29 Oct 2025 14:19:36 -0300
Date: Wed, 29 Oct 2025 14:19:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH RESEND v2 12/12] coco: host: arm64: Register device
 public key with RMM
Message-ID: <20251029171936.GR760669@ziepe.ca>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
 <20251027095602.1154418-13-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027095602.1154418-13-aneesh.kumar@kernel.org>

On Mon, Oct 27, 2025 at 03:26:02PM +0530, Aneesh Kumar K.V (Arm) wrote:

> +DEFINE_FREE(free_page, unsigned long, if (_T) free_page(_T))

Please put these sorts of things in their proper headers

Jason


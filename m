Return-Path: <linux-kernel+bounces-889120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F24EC3CC44
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C27874EB206
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB9834D900;
	Thu,  6 Nov 2025 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="n3jgQyNj"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734D22264D3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449109; cv=none; b=JeBhqDEWyas7ixe04/aleTpzbdZaqiRJ2SGeVpr/5UBj3Y5Ywef539zDk4IloSw6Kkn/QnbJw4NpDqXU2w2V270n1gqaEjtCMnqiJ/GL7Yg0kpnAhuSid/yBmk6E79GX1j1euJgWXvXprCDqdg3Hzlk21D6le/Stcd6p/EiR49U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449109; c=relaxed/simple;
	bh=pBncupXbWkCVN1fOd+MWv1n3EGow7Y78ZsUbGG2oPVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XavdEedKhfSh0Qh4GYy5fPizTMRYfJTX6T+bn2y6UgjdMmziBDaeg6HpzIhlXxXISKh2CjBJWMuOlU0yTrAJdbmUa9gg/Z0Ez+C+3/cgeYI+nuWxnmk4EcRuuU5DSaSTygwxcqlGgLv+avoaXNEVQInyG10k6UIC1EP855dEf7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=n3jgQyNj; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-87a092251eeso28611996d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762449106; x=1763053906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKXFhe1XgNsEqIm7n3PyjdJL5U3TbOb6yB6jqMWUHW0=;
        b=n3jgQyNjKBrhEYmKfs/HF2geSjgYhKEq/bvuMz+VOrujjHOqwIquqimWN0g+HE9GkX
         g7dmaS/0I1VcZDwOhuzZ0E3s5jszR4aejv/zhci+5kjtZtUSDfgGLxTqvNV9wNtwkgJg
         6c9UswPNUOIZVbs3MFqSmpIuVfRf/GqLVnhfCIi8kEDITV4xJUZU/Gk8hyDWxDBQeb1Q
         TF3fuiUrV247AzlODSNdJnDB6KUl7bt75G73tPjEtWNk1CY+o+PSVjVPKoBBsusmYdKo
         5TsdrLz12KzkYH0lCQyZROfKzU44EOxioSd/znx5IlpYFdiuUNkIFgBdp0QuPvzYk12P
         omgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762449106; x=1763053906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKXFhe1XgNsEqIm7n3PyjdJL5U3TbOb6yB6jqMWUHW0=;
        b=QwZpcxBUXIYyILhNPJF1URtjbLxd08bGZ+LrU1Nlpqg0lX4j+H7j+o8CQjomQVLlvD
         ukGtrsg9i27ZAuWdR8OaQUqeH2dGbnRtBrQtOvwGoSbOid4XnQqJ3kfLp1cSmj8y/8HB
         gQGSrHeDN9f9PJE2eIAEP3PqVb3FgbfXZ2vLZ1luowwH+Z71KpogGC5PgavfpM/LeJXS
         X5zn0MIi64cEz6uThZTJZc3r0ivZ1+E7pGXo4hfXarFEYwtwkBnrgh39fK4jsEtdPy5C
         +uPg160mB8+FIUl1piycsh8CpmRwbfx32tiUh8dOVEqKqJMY9Sv8INcRgFEn6/gzYipi
         HzsA==
X-Forwarded-Encrypted: i=1; AJvYcCV2vocoPLrU8+i/Zhvps9INZo50FohFl9Q7fCwGqnA5XhtEjtz1xBLbz2q8O2Qx0bcA1mnqmGKSR2nC8Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7gG2wicI1rqtImpKPFH87+9SjU4kQPJ0pvjObgC0zc1Hd551f
	whEIEitGrYqS7o5rwXO+PZVOkRtT3dFQXjjHaRweRqFxhUO80B+8m02YedayTm42Xic=
X-Gm-Gg: ASbGncufr65IrzfBc6s1/lS2zkgB4ZiZDU/aqoNI0QDVCvVHXtuzDEyVDV1mJJSHcIJ
	6VhmCI8Lh+PHqv2G01iM5qdlGGaHYxeaBEo0uk181Ii0wnNUpRVvYGT0CpOj4A3sBBRRh1gKssE
	TP0Yxdx8Vk9Ry4g4wuIrLQoSQKix3fToOnWavuFUDHVvh5ovF4Z0HyJKTqZR3D9730HeAbr+Nbn
	xptK2zmvBv7AoVkDitbN7irgOuxb7wr8DmoyE6MNWgg3A/T9E4Siyuk9S3oQK9tX+yNPzqILhbD
	83Rp9uT7qfBruNaKwBPedLoj7WMuF1usP77a/qTz3EXvrWZu1IaBEoeAsiV8ub6MVfhgbHm7V5B
	tR1DDbAtWCIfHLtPj3dYY5Yj7X3VcjO5Bh8ZmVlEnSQCKl7eBxM7wCcZ+tjHNF4WiYG/an16mea
	+hHxKGWC1URnE1Lg/PLVqITuDZseeDhVTVKOPwbf1AhVTULnBnkDgJDEeCoq4=
X-Google-Smtp-Source: AGHT+IGtpHAhkhHyR6o5AHtiwz5cY+ehhjfBP8n5EpJqyPwP3g9GbLdMDu/RgBohpPPk3DUjCzmC2Q==
X-Received: by 2002:a05:6214:62e:b0:880:53a8:404d with SMTP id 6a1803df08f44-88082834ec4mr51601596d6.3.1762449106390;
        Thu, 06 Nov 2025 09:11:46 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880829ca35csm22268686d6.35.2025.11.06.09.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:11:45 -0800 (PST)
Date: Thu, 6 Nov 2025 12:11:42 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND v13 17/25] cxl: Introduce cxl_pci_drv_bound() to check
 for bound driver
Message-ID: <aQzWzp4DdSqTj9Hc@gourry-fedora-PF4VCD3F>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-18-terry.bowman@amd.com>
 <aQuOiK8S31w44pYR@gourry-fedora-PF4VCD3F>
 <aQufg2Nfq8YqkwHl@gourry-fedora-PF4VCD3F>
 <aQvO-eBboCOhRDOO@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQvO-eBboCOhRDOO@gourry-fedora-PF4VCD3F>

On Wed, Nov 05, 2025 at 05:26:01PM -0500, Gregory Price wrote:
> On Wed, Nov 05, 2025 at 02:03:31PM -0500, Gregory Price wrote:
> > On Wed, Nov 05, 2025 at 12:51:04PM -0500, Gregory Price wrote:
> > > 
> > > [    2.697094] cxl_core 0000:0d:00.0: BAR 0 [mem 0xfe800000-0xfe80ffff 64bit]: not claimed; can't enable device
> > > [    2.697098] cxl_core 0000:0d:00.0: probe with driver cxl_core failed with error -22
> > > 
> > > Probe order issue when CXL drivers are built-in maybe?
> > > 
> > 
> 
> moving it back but leaving the function seemed to work for me, i don't
> know what the implication of this is though (i.e. it's unclear to me
> why you moved it from point a to point b in the first place).
> 
> (only tested this on QEMU)

also tested on Zen5 systems and others.  Seems stable to me.

~Gregory


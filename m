Return-Path: <linux-kernel+bounces-858666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 869AEBEB602
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 596CB4E57C9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C4F2FC01B;
	Fri, 17 Oct 2025 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jN2bXa+Q"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD70133F8A2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728807; cv=none; b=bDIA/aMbDK36XbjqTq/kgD8KSwo5mGpSm05Fic+4NYxwlDuW2GgUf8SnuKmBs2ND3ltlmPcPijfo8SM29DPPRZNYxhreNQQJpfjjJUsbIEhsz/evWVJwMYySqi71xaKBeYihFv6AZoBgCV6iZVNMglUG59LOCSJvV2mc1W2muoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728807; c=relaxed/simple;
	bh=dQc0lw1C6VoW7QAgpMjyWsMfikVa/Qn+q5wJUy/awm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gz1mu7hPE7xKykQP3Oo7wGAiLUXDDXZYePyzL5up5Y3IB2NYACR2zaBVBQVhiM5pDhUY/4REc9y6zqSSLNI2i57oZ6eSIyHoztTWo97cWfgzS3KQvDYjv9YqkkEj2/Thw+Qypxym5/tX5Tehd3O/kI+wcCIaTvzsxMl4+n0/YCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jN2bXa+Q; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-269af38418aso24716685ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760728804; x=1761333604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHXngnuNlh6itPj8r7imVgK8MxU3nTSTL/IVvz/XXP8=;
        b=jN2bXa+Q2x7zSjnPgGSv1JJ+CmfYRgTXZk0b36p96awMRMI5WYzIoTOM3jMs66DfD5
         lvk8d34iHxWZ0zwAioU4VhSsA0jS1Oku5Ij5PXkMqe4gbRj9LY/ydu9sJeo6DT+RKTwK
         r9ZypfgoLOjJpvb3Z9PlwdG2pN3qtbD+13jbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760728804; x=1761333604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHXngnuNlh6itPj8r7imVgK8MxU3nTSTL/IVvz/XXP8=;
        b=UMv+gRoBsHtEJcKxJ+jFD+q4M5xWWxju8rBS9CcaCPN55Yfc1KSiTM69tjcsGw8Xer
         eFdTdcHTzJYS0lI9Lla/ILFwH8coZYNmHOOgK5QawzlxpvFeATsZTyUppD8B0tsXHchG
         AKwzje4B9GybbG3VU7TAGGbJnX0iEbebEHRnkxaxZ5Nvk8atMB0hrTolISx0WeFvH+1p
         /gCcb6Oe/G6eVBvW+jRfjDmk0Abps+Y9J/aasyickBWzHF2py/lggCHowkRg9BoKSElQ
         rnVGZARmRnE+EGlnk+Oidn8ul8Pz2aH4SL0KTmIaBowGj9d8AzCAkX/WMyyKmisNpXe1
         akkA==
X-Forwarded-Encrypted: i=1; AJvYcCXZQWLoMf8wdJKxmmAuGQW8tGwXxK4VPIN6nh+Azi2rk4W52DsSM/MyhZs9dqw+pm2eAUnKpl23jPpHWaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4zjuJSqigaXkdj+hhk38q63aIQxSBvOKu0eacvP0BaCmGE2a5
	prkk0dh6il3VdZ+Nu23EOoOcjjannaGERuw5er1jtFsITJNZRLUksz8xVBXD1Vvs7g==
X-Gm-Gg: ASbGnctbG25kQcOzJsTPumDpQjuDwdDyYJmXLy1kCYGy1HKATt3IfFfPPVH+Et5iqyI
	wdsHXbGKa+Ui9CH87PhPoFtOJpBX9ywwrCABg+lQTy7UG2EkQWAGdFPOcu6WAZSO7wMPDmGaL1Z
	FWn4cbfEYLD78knknjvdFM9X6saw7dvb8UDClK6X4q/cOtLAWDy5yuIBaWDF4lsg8sPYYoFcms2
	Bjse4paxxE8U5bN1DJfzkynClNBlZDGEvOBpv7yTKDqZhSAGsRG9Kq6wWAu4PsXpt6bC/pH/Nph
	PLoQxmEtPR1uAPdBXpyNWstzb1ztC/78yF2BJSq1FFINzAGStcpLrbN3Hmajlq/Q6T2FFuxrgg7
	/vM9ZWR9P1L/MdXhAW7VVzMDP2AAI9Q2XyUJxVPl4PWmv9LgilHr3EtJTNHQaUCy1ZAPhaR2/bs
	gHWPvr+cb/9GQuYndpAt9e7L1QL3+ZhWWslPUfD0XoojTVhEMS
X-Google-Smtp-Source: AGHT+IElkrHhhyNLeAZol7uw4OirIzBxUzQlJYrmC4LJFvDksofq8jEPQXbrqyZan9Zi/uQsogvSNQ==
X-Received: by 2002:a17:902:ce87:b0:26c:2e56:ec27 with SMTP id d9443c01a7336-290c9cbc92amr70205745ad.19.1760728804005;
        Fri, 17 Oct 2025 12:20:04 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5ca9:a8d0:7547:32c6])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-292471fdce3sm2636175ad.90.2025.10.17.12.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 12:20:03 -0700 (PDT)
Date: Fri, 17 Oct 2025 12:20:02 -0700
From: Brian Norris <briannorris@chromium.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully
 initialized
Message-ID: <aPKW4nXfQxl6SmLE@google.com>
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <aPH_B7SiJ8KnIAwJ@wunner.de>
 <67381f3b-4aee-a314-b5dd-2b7d987a7794@linux.intel.com>
 <aPKANja_k1gogTAU@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPKANja_k1gogTAU@google.com>

On Fri, Oct 17, 2025 at 10:43:18AM -0700, Brian Norris wrote:
> git-send-email has --suppress-cc, and maybe I can convince my tools to
> do that. (e.g., `git config sendemail.suppresscc cc`)

For the record, that'd actually be:

  git config sendemail.suppressCc bodycc

I think I'll use that, since I usually track intentional Cc's with other
metadata, not (just) body-trailer "Cc:" lines.

Brian


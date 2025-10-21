Return-Path: <linux-kernel+bounces-863526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C631BBF80D6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFD4560161
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB1F34A3B5;
	Tue, 21 Oct 2025 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jjDF/Mqa"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D77634A3A5
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071263; cv=none; b=eUOPPJQAO7VHdhafG6jJhIb8I8ggsrjM+CIAALATy3kuqcFtDeoeznYbeSpsT4NazPUr3LwHAoyNRhED93M5UpwPMvSRIJ2kI+oUHo/6Ye5NtjCQ5lqRUehb3Y1fg7mxCYvDyjkLW1jNTJD1yp6aptjES38c0wj1hpTKmgUk6WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071263; c=relaxed/simple;
	bh=3RjBXAGDusLGx9xDc6Pf9biTKmKASJPpEkqNe3B3qqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv7OC0Xj7CwpG2miVCTYYIpJJwqyu1HOjEO6yM4Jxlp2NFyEG3iQ6l1x3zWQTH5hgh2jB5Tm7tCGxbUmJ2/ccwDsqExlzIaFjf+rcBFaYJHm4xIdO8k66sS6WnW1v2DOrv2PwjdUbe+ikqc1LtcFoXxYNNP5EICsObU2I/P+ALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jjDF/Mqa; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33d962c0e9aso146401a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761071262; x=1761676062; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HqYzl/UW33J1zC9mz6UdaYFjF9I5n2x84L74tPVphTs=;
        b=jjDF/MqaU5GTQPcB2gFr/gXDPEVkGu8EP0Eq1OctL+/pieLOP1te1UXphA5cmVB9mF
         vwrr/AF5EyNRaia6YwloBstsG8dJRObDmbe/mnFaswYrXHsr4UtsBgjuRwZL1LPDz3Yf
         0BrHoPw+GYuzg/Qycfpq8hWzxheHPthQPTAeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071262; x=1761676062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HqYzl/UW33J1zC9mz6UdaYFjF9I5n2x84L74tPVphTs=;
        b=DjtUFxxVyR1+89SCfHx3RjjV9vH11K95/d+rn2yv5FI/CcKcLaAzmNeu6qZ4EVghY5
         imShWk99MN2T9t2hUs2I3j6hgvJrZtumw9xOB19WugcjlHed0ZpNYy/w//ebN+UnTZtW
         3/LI52y+uIyTZ0lDjJP3uOv+sZSLq1b9hTzu8emUOSd7amA4pfnAt1JYk++qID1Xj0Gv
         q8ZQOZiOUfwfD+CIPRX4f91nkiB7bao3Ob21i8TlaZ5wtOaCZuti62CdqOSLxF+jHUWN
         hfRng4cSqFl/n1O6cWXIVyCDwBMvxAACw3kxDcZzIUVnYVMAbxN+g/EcxL6NLjzE6nwV
         t0Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWqo80fAVPkRMNsk3MlAi3AHDYPXy7SdkO7rDOdBxLr4Tt8EQF08isbNmbCOUNfYY1+py/Ep0r67iN5+Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKJi/NckMpqFhJ7SqnlXzeOiVnsfXc8mFn8YE+w4GF4H1jTeVm
	xid1q3+r7bOINVcZozYshojam76eg4XWpUkRsPu0c3oTLI3e1NEs92RV4h/Sg2/yfw==
X-Gm-Gg: ASbGncvj+IvdUhUfuLOZzpkPx9/uCPEyU3VSts08KTwn9Mnf5jYgBZauQKyGbkgGNP/
	YoFXMBrXvjuam+BGwOG5R1AglEodV7eH4KwQ3ZmfjkRDaOGMjogIjnB09wDKGp8vAuRE2okErtH
	t9AJ825G9U5KPadLFMFXA+in4x86B98++nLBheyiqkMuhKSKDxDlOIuUn2+0BBcST/U3l6ofwkw
	Ibkr/rpiIb5EQTrXici+jvXIaltpWQng6kkSLTKe3qxDKLLb67+CiTWeDgQ54ORumqffFOw7d6Z
	0PWmcEAoNSJ9nVfWbT839SdaPgUzfkpAyAx3C7+n5vIQjajHvl6iITg2BQqsFtIm+0VhvbHj16w
	bH0j2pLZhHzIU0TnWalUyusyJpSqOrD5gvA4Ek90p9TV9bMUvFIR4AqpvnYQ96jiXJqFt/YpeMm
	HuizmTlLfKIbTCwnX2cHWcEWw84ommHht0EzoUGg==
X-Google-Smtp-Source: AGHT+IF8cBN5zDoXETXF5lzZV8J3PI7WMOXfoZlFBQttwsFJrfAQjOmOSkixYd7wOfT54VYENlNFKQ==
X-Received: by 2002:a17:90b:1c06:b0:31c:39c2:b027 with SMTP id 98e67ed59e1d1-33e21ef1205mr1063117a91.7.1761071261628;
        Tue, 21 Oct 2025 11:27:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:e63a:4ad2:c410:7d7e])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33dff3adf7bsm1416782a91.4.2025.10.21.11.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 11:27:40 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:27:39 -0700
From: Brian Norris <briannorris@chromium.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully
 initialized
Message-ID: <aPfQmy0-7Cd0I9Jp@google.com>
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <aPH_B7SiJ8KnIAwJ@wunner.de>
 <67381f3b-4aee-a314-b5dd-2b7d987a7794@linux.intel.com>
 <aPKANja_k1gogTAU@google.com>
 <08976178-298f-79d9-1d63-cff5a4e56cc3@linux.intel.com>
 <aPaFACsVupPOe67G@google.com>
 <06cd0121-819d-652d-afa7-eece15bf82a2@linux.intel.com>
 <CAJZ5v0giOw54L6M8rj-Q8ZELpFHx9LPKS2fAnsHHjHfhW_LZWw@mail.gmail.com>
 <41d5c358-e469-3757-8bfb-e88c3d187e02@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41d5c358-e469-3757-8bfb-e88c3d187e02@linux.intel.com>

On Tue, Oct 21, 2025 at 04:18:54PM +0300, Ilpo Järvinen wrote:
> On Tue, 21 Oct 2025, Rafael J. Wysocki wrote:
> > So the purpose of this "forbid" call in pci_pm_init() is to "block"
> > runtime PM for PCI devices by default, but allow user space to
> > "unblock" it later.
> > 
> > Would adding a comment to that effect next to that call be useful?
> 
> It would be useful to improve the wording in PM documentation which is too 
> ambiguous. I suggest changing this:
> 
> "void pm_runtime_forbid(struct device *dev);
> 
> unset the power.runtime_auto flag for the device and increase its
> usage counter (used by the /sys/devices/.../power/control interface to 
> effectively prevent the device from being power managed at run time).
> 
> to:
> 
> "... (used to prevent the device from being power managed at run time 
> until pm_runtime_allow() or /sys/devices/.../power/control interface 
> allows it)."

Looks like a good change to me, even if just scratching the surface. If
this goes in a patch, you can add my:

Reviewed-by: Brian Norris <briannorris@chromium.org>

A separate problem that sorta stopped me from trying to rewrite some of
the Documentation/ is that we have both
Documentation/power/runtime_pm.rst and kerneldoc in
include/linux/pm_runtime.h + drivers/base/power/runtime.c. It doesn't
feel great having separate variations of the same API docs.

But hey, I shouldn't let "perfect" be the enemy of progress.

Brian


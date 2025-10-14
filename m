Return-Path: <linux-kernel+bounces-852030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25D8BD7FB1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999AD3B54A9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A8B2D8DD1;
	Tue, 14 Oct 2025 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NksN+hxK"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30A336124
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427832; cv=none; b=mjSwzfg/K81diEPSfqg5fxUK+VSEN3Dr1EQ4SYd2lK5pNiBA3unab+d+cMbgXuMXvTZ+4H14w704OfkoiUlagJMmUukMJaeL/KMT6SDszbxL7XqkRqju3dytey9C9Y47rfxhc4WaiuL4XQ6fNJsAkce8rK6t9xXx58i0ZZRa0xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427832; c=relaxed/simple;
	bh=5XIOTuXhcfgvMyryjkrWnOKtBwIw5u4qV0qabQznBgs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oSRiX+bQIsVACITNs9+wYKoU+odLa5Ywm0N+3JAFP2Yc8ethM2HJ6ob118Q/hXrzTVVgVBPr5ART3hLhCCJtQlUWBi3QZXvvpT89+IllssoE8UXyPrROdJ6ZEr4gISOUrer/Nj8tKcBQRQsMXXHirdA0YNCRsKUQe4Es4X/iDiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NksN+hxK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso293956b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760427829; x=1761032629; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4DlbE9d0672+FMSDbkuv7W0GPOS3Q83G9ePLSrqsDOM=;
        b=NksN+hxKLeRHLLpxmy7kf/1BCi1nudO+y+Chk7V8qgehN8PwHKRjbPvsBxHpGnb2Hl
         yiorbUOgyGHRcLzxQukCkUlvFDrHW51kFxySNmpJ803W6JNWGY504dmB2AIo++eqFucm
         QvU8d5ISe15jsZf8kCnR8d/vgwsscCWSGzgKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427829; x=1761032629;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DlbE9d0672+FMSDbkuv7W0GPOS3Q83G9ePLSrqsDOM=;
        b=WVdXH65DWcoA/TjXBxrLqYUQSJwuAXxdlvFslOfhvWyeefNi5wccKis7rWVfz10ldx
         fZKOpOdOhYjMroe//B8MxJNe+T6oIu0oralAySlS3xuXxnZiRJsMnpLB99N0RpqbZ1jG
         HyGBGS7gv9iiho7xp67ve3Dn+O5ldXBuaSFoTSKrnMiHXPWSXdxdjToNdis3UPJkiWsX
         VU1k9dx4Va2Pz0pH9gnfZkr9byuc4Cg3df4P+oXzekUOx+G+JUKvNWpr/e73teB9gQgk
         f+7zvU1k2/+U1esSlOBfPSTEitQw7WM9gwZNsdSYeCygfb+He3br/qS9s1hpEgB95J+B
         7vPg==
X-Forwarded-Encrypted: i=1; AJvYcCVOklTsJS1Qva96qtDReAaEd3YaIv0WVzPsvJNCcaOOHrGVjJXXsGk49b/aklHNmwjl7O6F6f4evwseFXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YysjK4FOxPr7NEpySFDQDEadw1uZud2iW5LuFhAeL1OISbMncx4
	JkPYeOzala+oyqdPsITBmxyj2hz6xz6vKM5h1r/pU6SkP6Ztwl26/IxJ9p7XzOr+ZQ==
X-Gm-Gg: ASbGnct2dpFVayqbAYusqIjpv+g/Zo0KEI9Cv3FX9xmTnRSPYvozfRtTTc6WxoeHY5C
	p/SMmLoOFcLxaVML6o2BRDo+opzOMVTIm2ia2jRkszd2dK/Agtdtmp4nwY6fuqSN4t1FVxRos7z
	pOwiAxEQsXlhLX73k9NbMJ77h7h/8m4Gybi82pKeWLYKzbSaiC7TCgtkH6tov19JhwG7tN82LC1
	2IuoJIcxT+jLsQ4aPgeUAY00HZM7DHHztYDSX8JuDgiBUBXSKKyipY58j1+eWPa1QpN9pn00r9c
	fEVFvlodLVMskehCGHNdFxC+dO15u4kk5rfJ5HnqnQGIDpPLxNDCIUDXa9F204tzfc42LJkaMCX
	ozPpYVSYc2sEkm1vjYxWORses3PPQ0j10JspYEajVdsJoPyMImpTymA==
X-Google-Smtp-Source: AGHT+IE0JPbH8RFvmKwtEh2tQIpvat5nn43ulCK2cRbdX4/desLZYKw49GjSVt+mBH4CgFZZKXWYLg==
X-Received: by 2002:a05:6a20:3d94:b0:2ee:4037:1df7 with SMTP id adf61e73a8af0-32da80b7fccmr27471304637.7.1760427829259;
        Tue, 14 Oct 2025 00:43:49 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b67af9dbf32sm7952404a12.21.2025.10.14.00.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:43:48 -0700 (PDT)
Date: Tue, 14 Oct 2025 16:43:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Christian Loehle <christian.loehle@arm.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tomasz Figa <tfiga@chromium.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	stable@vger.kernel.org
Subject: stable: commit "cpuidle: menu: Avoid discarding useful information"
 causes regressions
Message-ID: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

We are observing performance regressions (cpu usage, power
consumption, dropped frames in video playback test, etc.)
after updating to recent stable kernels.  We tracked it down
to commit 3cd2aa93674e in linux-6.1.y and commit 3cd2aa93674
in linux-6.6.y ("cpuidle: menu: Avoid discarding useful information",
upstream commit 85975daeaa4).

Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid using
invalid recent intervals data") doesn't address the problems we are
observing.  Revert seems to be bringing performance metrics back to
pre-regression levels.


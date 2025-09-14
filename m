Return-Path: <linux-kernel+bounces-815566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A899B56841
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6E3189C4BA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049BF253944;
	Sun, 14 Sep 2025 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5ZZAITz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF4C1F8728
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851499; cv=none; b=nkRRLkvalJULwepR6LAzR7TBYAVxyC0z1xO/B1Y4Q6c4shfN6YBD87VJukNUmSCtGfeHdvsQIIxMUV0a2eD34FakxQWTGTUcPWXllXt7/WVaZQIVnjVRVF3aQTTT9eY1vQSn2EwpGLw65OhFGdcs612qaJyXYQdQn2N4UlRbDw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851499; c=relaxed/simple;
	bh=x6/x/F9H1jnt9+oD8dGb+mTu5SQ8wNiEgVuCPP1souw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4yNYSF5zuCx+BHiHmFG8HmhKg2vjzLF7r5Xp/jiWMmUGk8zPJ/Bk3KiRZiSyiSkUFmTuAhoPuJATVq+mGUHCsrJy2c0c/R4l7djXK1mX67WQMz4JZqfVkmTOTLJB7zRolL3AyfUZC0IdCptINiPPzDKjol3lLUBjSsijCM8yms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5ZZAITz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757851497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6/x/F9H1jnt9+oD8dGb+mTu5SQ8wNiEgVuCPP1souw=;
	b=h5ZZAITzXo8KAYM3+hLK7JY28tFnwccMEBj81vOMSyNLJK75r6gUsq8UtlBPr3MmJUbHwI
	tr0iDvCIFm+OlI4UQ6zD2P5mNKR9ZICF3cEO1aEGBfP9a52SgbgPyydz2ky/Frc2ZsDLR6
	1oAf38H3vYp+HpbLf0EXbKSEzoxQdGw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-5Def34AXNl6QjDVGKciqqQ-1; Sun, 14 Sep 2025 08:04:55 -0400
X-MC-Unique: 5Def34AXNl6QjDVGKciqqQ-1
X-Mimecast-MFC-AGG-ID: 5Def34AXNl6QjDVGKciqqQ_1757851495
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-775a4b30153so18121716d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757851495; x=1758456295;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6/x/F9H1jnt9+oD8dGb+mTu5SQ8wNiEgVuCPP1souw=;
        b=uggJr6XLV7acJ+ATIKweFZ47t0ww+nkf4DPt/3D6qFZBAtZWmZdGlCNKmPMrfXLS/P
         0LZi9wBXW8rXa2E9qcp3CN5p6jcPjgbeL+zkdPLRPCYktNfoPU3lW9J5fMA2GuWSRrAG
         /F3fe7Bp7Jr1OCFo1sZ+EVCO4+mXh004fO4o9ndiwlHT9kLOm1m//bzzdW7n6hMTK49z
         rT0nbK7R2ood8NIVqoy8pd9E4TN+QW3dXc5PtiLhaObxL24sbK/Un/MPH98kOGUXL5kQ
         YvJ76k+92zcLm2YG+9lnq1BU9AJje80pjazf75lBasYvYmtOsO8glBCAzpZLbWFx0uD9
         h1eA==
X-Forwarded-Encrypted: i=1; AJvYcCXeNrUw8yZvRmD3jodeP/X1/QtmilwqFZSrGTYv6IZBh68H2jeEr5LIcPiHi3ybFZ8OwiC5H+rtZGzv7As=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0c1itf3+oNP1u1wXhJGeL5qTC+GSUAFHCVbjmMVYdyTEu7OFz
	O+fDDAAqYIDn2tMN5mrmNUYKXWdERoccpTeN2a+eSzHVyIRYqvSkBDU1nstwWCoLFtsFj92slTM
	KpMN3RTGbLoZ5alC55i/px762fRclLnpM7kPtAZ5zBgpXdODLCBBigJ1xoSIn0ATi0Q==
X-Gm-Gg: ASbGncshyocKveCnMOzSGAmhebcRW+y5y4bV1J7PfXuO0ZPySlddZkQSajSzP9FF4CV
	GDSHbRg7nOIgC0SnfpLaj4oF1EUzVzQOC98DF/UqWNYU3c7jUHgf61LYC6pnLZtLzz+xFlepiSc
	dJL+U9XBaHIY/yu6OxvLgWKiKzGBAk/5T/FLgeJZxbWwaegp1nGd9c2EGg4ays6g1Zwms0htREN
	wzHDbkhvMcI9NIWUk7KGk7I3ARgdC1KkRAzgXoDsTVuYr7dzYQJVHiy6XLEKRYXjgHp/hs17nFX
	AzOAVT295UgJsddkqV6Ul6rTkalYca1gyYcrRzS9bBkddG+rE92KnjXdq5J4IAkzGOuI/8nyyJN
	jrjnYfWIYvP071a6ib0RenK1wxp/4lpY=
X-Received: by 2002:a05:6214:a54:b0:77b:dd92:d8d3 with SMTP id 6a1803df08f44-77bdd92dc85mr17330296d6.7.1757851494637;
        Sun, 14 Sep 2025 05:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECmPphlLafTRPXos3E/qMQLqgcw4g6SL9e96QNHBNQO+FV4Ve60CSx7PadzySEh8hyBowFVw==
X-Received: by 2002:a05:6214:a54:b0:77b:dd92:d8d3 with SMTP id 6a1803df08f44-77bdd92dc85mr17330016d6.7.1757851494267;
        Sun, 14 Sep 2025 05:04:54 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-778d99113d1sm16067766d6.68.2025.09.14.05.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 05:04:53 -0700 (PDT)
Date: Sun, 14 Sep 2025 08:04:51 -0400
From: Brian Masney <bmasney@redhat.com>
To: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM: convert from clk round_rate() to
 determine_rate()
Message-ID: <aMavYz5z_CXMh8MD@redhat.com>
References: <20250710-arm32-clk-round-rate-v1-0-a9146b77aca9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-arm32-clk-round-rate-v1-0-a9146b77aca9@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi all,

On Thu, Jul 10, 2025 at 07:42:15PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated in the clk framework in favor
> of the determine_rate() clk ops, so let's go ahead and convert the
> drivers in the arm32 subsystem using the Coccinelle semantic patch
> posted below. I did a few minor cosmetic cleanups of the code in a
> few cases.

Would it be possible to get this picked up for v6.18? I'd like to remove
this API from drivers/clk in v6.19.

Thanks,

Brian



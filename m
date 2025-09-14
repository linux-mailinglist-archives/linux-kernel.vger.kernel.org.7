Return-Path: <linux-kernel+bounces-815562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CD7B56830
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A3D7A19B1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1FD2566E9;
	Sun, 14 Sep 2025 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnMrSSpz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CCA11CBA
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851167; cv=none; b=SSpg7/t/Za0OiIBqE0FsblvuwWd7y2jg2c5P+igmbiK6Gf59M0XkpxC2j8PbT2kQ0BZgsL9lD60u21j0uKwlep3K9wqcyag1VB8GcBzKbJZHgMUHa+JRLQgN13nwpp/vEs8msgdsmezzpnWuskGVfH1jdtLpO7fqN44WUbR6PHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851167; c=relaxed/simple;
	bh=TuJ6ZyIXo9169+QV437Uuh1TahXjuW3Nbjn9ho+NqUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mII66pS/tKMp18pPQYXlVv/C1cWth+KitfnzvZOrp8GjBA5lFUqBv3PsbTZzQDClPysIIpy3T3RlFteuP0qPH/26AeX/yTqxMQiL6tzzcln+9vNpIGW2fH+3TsM0DWf49hrLOt/ImszOA/IsN0Wt6DlmerXIRPenpyXY6ugmcYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnMrSSpz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757851164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TuJ6ZyIXo9169+QV437Uuh1TahXjuW3Nbjn9ho+NqUU=;
	b=VnMrSSpz2kxfge5cK3f0hWy2OUuzhvozdVorgJ1yOI5jSQPgh/fyeIaJoE3Ham8/4k862Q
	tgfxNbs5Gxfz6MzZFq1ZmuQkGUBRV47IDKy46Lt3iSE7VPqezcoQVaPxslivgBV6ouy5Bv
	WofcqCwm18QyVIGJSDFBG5s9LaKQesQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-GrhzC2gcOP-qInUDyUCl-Q-1; Sun, 14 Sep 2025 07:59:23 -0400
X-MC-Unique: GrhzC2gcOP-qInUDyUCl-Q-1
X-Mimecast-MFC-AGG-ID: GrhzC2gcOP-qInUDyUCl-Q_1757851163
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-782fb2a5e9aso188496d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 04:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757851162; x=1758455962;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TuJ6ZyIXo9169+QV437Uuh1TahXjuW3Nbjn9ho+NqUU=;
        b=p/N71zrPbcqrr5caoQjYGsBYE8dRUd6qOXMzQqphmwsbbPgW7Tpz2x7nTPwyEdws/T
         uLY+EudyO4U7/z4hsH4jp1mYbZjml8Ci2UomUOuPcWekIsLv4B5JhfVZDUh4MgH/zXlM
         KkVZjfo8B2pfe/gNlcYTun2CQWb+QHjNrHH0G5HrstwKsL6L6RfFyTj5qU3EJojzF5XF
         1I3uM4ADMfT3IKJ4ir+Ndx082wTcxZj47n495s2Y6U3lOVY3Glpr3x0/sN+mkHMSgVQe
         Qh2R0di5GZHAAdZWszliQ9TplavKG3QuPVivjVrw7EAzn69TT/xroQfTuhVMMoOEVYXE
         I3OA==
X-Forwarded-Encrypted: i=1; AJvYcCVkghDS8WiZ2l2RIWQzQFulIwX6ZC6bMyDKfTbjsLLCg8fPXAGFM0dIfvfAFTeM9CqDT/WML3ksw9kG5cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEgycVHEjgF51aM90WuouHOq2VQTNsm//4U7sgNzokKd1EUiq7
	6h20aO5OEUEqk9VUSojTqnXEubEU7mp2Ry70nA5KApi1NxxK3erI9zcmr8O1UIirV6iGwaz1hqr
	JnwFNnXk61mwTMyrJskgVxUw+aKJTP8DayJGwp0shvkBgVCZ9ck7jWlRPIE4AUlz1Hw==
X-Gm-Gg: ASbGncs04mAbzjTbeuQv2NAK0PMXb1XteK2wdv5wJYeocmHnHz/8qV6WCrfVkcrX5Fe
	JKD+FJdENMp3gbE8+/tC+nfQQH/X8UfgXyeCuQx6kGTY8rKUGJm/yIq6x1X5txIT9KBOWUeSTIr
	QYH0pRuR9GlvPiHRcbsTk/Agta18246w0wWmI1HidYBskb05fehZDdkiUbGElxZwd69ExvyR9Mc
	EaItwIiJY63j75Qpcevv6Q8e9fZJWUQ1MvPOJ4RM7kYrDJBsrrv+vKwDTM+ZHZRHPXHuhR4KsBG
	Cy2oOYoUWLXGqtOp0JfQ7io1strz/bYku3dCT62bBd/o3zbhsKoUr/zZ+rDcWREPYNH42P1cE9a
	rHi5wIKt8fia40kwYfXhbM7KrCqV3Eiw=
X-Received: by 2002:a05:6214:29c2:b0:722:3a59:fd9c with SMTP id 6a1803df08f44-767bc9e3085mr125308596d6.23.1757851162710;
        Sun, 14 Sep 2025 04:59:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8iWdV2eUk9Ftv51+HsH9mmPirIh3yTgTyTqB/S+vGeXIJXMY6wV4xvkdS+fQXOzonhJtDiQ==
X-Received: by 2002:a05:6214:29c2:b0:722:3a59:fd9c with SMTP id 6a1803df08f44-767bc9e3085mr125308326d6.23.1757851162326;
        Sun, 14 Sep 2025 04:59:22 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763b3f49139sm58611576d6.9.2025.09.14.04.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 04:59:21 -0700 (PDT)
Date: Sun, 14 Sep 2025 07:59:20 -0400
From: Brian Masney <bmasney@redhat.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Julien Massot <julien.massot@collabora.com>,
	Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] media: convert from clk round_rate() to
 determine_rate()
Message-ID: <aMauGOA-9FvJJ7eD@redhat.com>
References: <20250710-media-clk-round-rate-v1-0-a9617b061741@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-media-clk-round-rate-v1-0-a9617b061741@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

Hi all,

On Thu, Jul 10, 2025 at 01:29:05PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated in the clk framework in favor
> of the determine_rate() clk ops, so let's go ahead and convert the
> drivers in the media subsystem using the Coccinelle semantic patch
> posted below. I did a few minor cosmetic cleanups of the code in a
> few cases.

Would it be possible to get this picked up for v6.18? I'd like to remove
this API from drivers/clk in v6.19.

Thanks,

Brian



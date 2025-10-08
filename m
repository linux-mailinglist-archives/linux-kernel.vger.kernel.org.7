Return-Path: <linux-kernel+bounces-845318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC55BC4632
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92A7A4ECEA0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D932F60B3;
	Wed,  8 Oct 2025 10:42:16 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560725D528
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920136; cv=none; b=WNLEyQN8h59IVx1HO9Zj3m1r45jQbxBrlyESNvAXwkdgtvqDBFGL5w6fKLiSn9cr+C05HIrYIKvtjBNnQ5J0IlD3f7l0TU37fUlSR8Qm/xNeH0yEqnq2AhIAUWlxFukHGFk5eXqHBy6XtKj54tRMRAbzAAZJ7BIiTV9zzPXDEsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920136; c=relaxed/simple;
	bh=gXfZj39gOdPe4cV9/pLXEx0hRGUl/o9LSz6BtiMyxTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLsTWNFmdYvUWTM4AHY2C5cD/B40H4agfFFj1b6DT+I9JrtBhvTWNMMZKyYSzA8D+L5ZJZ2BlXNfyOoy+KB5kgwjWIDjYph7HtH3ediTUZ8n+tsq5wRv+Z4p+gBqnR95KJF76WkmLSlPxHvNVQJNNAfPLxzz6LKDq6nirzyiIDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-637e74e9104so8005202a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 03:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759920132; x=1760524932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXfZj39gOdPe4cV9/pLXEx0hRGUl/o9LSz6BtiMyxTo=;
        b=kA82cUJrcqFUTQocUqkQA8Cxtp9WKFiY4uZiSSAWb+X/vJYLclw2spQRwihGl6Q8zg
         a3oepa8rT5zx/a5a/ZL3iiKwGR7I2/DqFgqeGkMf2C3WJNplekaeCGa38iXRC5FcjQ6H
         6OlPu5rvFJcaS8x+8Zm5hT/ec7AFhQdBBTVCsF+kaF878C3YQ49G8El6nCvUB9C+NuD6
         1qrKODl8zqio3b/gXMgYEtfZ0HCiLUuOOydEfReUTPlozCoKzD2mlbIc8aW3xWzHSnS+
         f+6BmRSDKSKYXPBlnx9sI0anmnLvbm58R3t/fVAqqO+Tgm1XJdDXb0dbtEl9Ds8xp0Z6
         +MYg==
X-Forwarded-Encrypted: i=1; AJvYcCVeZkXeNd9XAmI56Y2GoPiygYG8HYtisx/ngev8oalF3kOKIJbUdIlApulgpAOM5MU5jUaVnAVbwo3zvxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGyGuU+QN3QTPmI/PTdOUYpPpqKxbLF8Vu4oQiu0SOGgbMWYFt
	YEG9p2/IiKd6lH2I2wlnfy9fqF/vUYk4dMFinzldDvXS9qGrkJJzilZJ
X-Gm-Gg: ASbGncuXVab9IWpgSb5K5D71OxaHNJJ4elThku7N75aY+xAcsISD/OhcDP4e8RoB31r
	Lhiwb1Rut0mVwDUDIsa0nk2bJDY0hNanmJuvu++GXwulZNuluRK8zAAGhox/R+TKGS0y2pqGRAV
	sdHHyN6EwV6v6U1kEwyHabyFkI7QdLO5nh3lXDI/44Ul4p5eHrJ/tMLOAG60upIvf3MYgE3QNod
	ptaA0M5jgbkf7DNQt9kEJUqR+VwNvy/UWr5QY1pSwTO8jWPRimGSIDGkYmoQc8Ch0jlBOvFqr1q
	9z0F+U5acO3YDiWyGTBesslv8Uy2z/tmmgosLEHaHUbapdB6cMp4DL+4XeoK9jcmENrYIvxqTH9
	9KUtoAjzIz3z7Wq5Tdq/8LgdTeIFiuz5qDWtZ3w==
X-Google-Smtp-Source: AGHT+IECD7wKvTZ6+MU6CjYIhyoFNKuj3KFaek4NzDOSYMfoAgnsoXljdX2X/uCFDDf8Ajmh077qIA==
X-Received: by 2002:a05:6402:50d1:b0:634:a32f:abbc with SMTP id 4fb4d7f45d1cf-639d5c53171mr2450513a12.25.1759920131891;
        Wed, 08 Oct 2025 03:42:11 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639773d4d8esm8697663a12.30.2025.10.08.03.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 03:42:11 -0700 (PDT)
Date: Wed, 8 Oct 2025 03:42:08 -0700
From: Breno Leitao <leitao@debian.org>
To: Baoquan He <bhe@redhat.com>
Cc: David Hildenbrand <dhildenb@redhat.com>, kas@kernel.org, 
	Jiri Bohac <jbohac@suse.cz>, riel@surriel.com, vbabka@suse.cz, nphamcs@gmail.com, 
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, 
	akpm@linux-foundation.org, Philipp Rudo <prudo@redhat.com>, 
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>, 
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
Message-ID: <ctrpw2ppozwtsj7544jx45kpexmaackpzzyeyhkqsjrf7cz2tc@7fmuzvy7uwec>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
 <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com>
 <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
 <2e35b6dd-56dd-47e6-8dac-54f446f763f0@redhat.com>
 <aOSO/e68pZ7FGKm1@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOSO/e68pZ7FGKm1@MiWiFi-R3L-srv>

On Tue, Oct 07, 2025 at 11:55:36AM +0800, Baoquan He wrote:
> On 10/06/25 at 06:45pm, David Hildenbrand wrote:
>
> Have you encountered a real problem about the dumping, or you are just
> worried about it?

I haven't encountered any issues so far, and I already have a set of
machines running with this configuration.

I'm planning to roll out this feature to a larger group of servers, so
I'm currently performing due diligence.

Thanks!
--breno


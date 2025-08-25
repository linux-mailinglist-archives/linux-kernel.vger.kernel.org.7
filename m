Return-Path: <linux-kernel+bounces-785273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69388B3486D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEA2188DFB6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E5330AAC1;
	Mon, 25 Aug 2025 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="CuEm3kAe"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE472302CBD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141983; cv=none; b=eVWJ3ReJFk+QN7jsR5/bUU4VZLZS6ZZpffuUN8QNnRkYpJdlbWu6NOwzfr2yPguFYaakWB4nSMyzC03pGlX0Z620AF53OmOcmm44y7IFRpvNS2/i1Du9vvtDy6631CyAiq7wNdfkeQDb+LRshsY9gaSVVQhdCZI0e5iNK48OdXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141983; c=relaxed/simple;
	bh=hanUCkPuMxovxHm2S6pFpv9hGnC1yWqateRLvQpTuKQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=jv3Ef8BXRH/Gj9Uh0HxT5SY5N1Boirul5AbQ5D4JdwteYAl8TqLfzDkGrjDp8cFzqHqL1NXIhamc3syNMgp6cq9f7pIIKPEl8HFbONb6Hd94PWGRTEDJU1hEmpK/3aSUWSATr37p7MDQUhRT/NmEZB5e0eJt5eFkBon4yN34WA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=CuEm3kAe; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso1434226b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1756141980; x=1756746780; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JIy/ikd0BLnHtzJtlevyIk9/jwbmefHUhOitr8lfoE=;
        b=CuEm3kAeom/Zc0mPKPE5sPi4WEYbclhvnbZvHDH+zm2b2sJM+x2BrD4lE6MLhWqY8b
         H1m9poQ2b922Mhu9LxZS1IoG56V/sS6vRQzRh88CysKeBuxI9s6acTqHMPZNKeoiqudJ
         1wc7Q9NYtusFP0mjZ2yHkIwQZ8Nwmn4LMU9QLGzHPaSwubTmfSjqoMOfESJtZh4pv+kN
         O5cwE273GY4NTUHLAi0ykEQF5LQP9CUC/l45dXQTlSVtu84vTCO/2XRfuQvcaA+pQJDT
         RXeZZsi7oc/aJgZw8nIzQ6HuCCexiEqhFOaqJygx3Qi/V4c+DlIeDLdwRhcG5UTjQN7+
         +MTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756141980; x=1756746780;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5JIy/ikd0BLnHtzJtlevyIk9/jwbmefHUhOitr8lfoE=;
        b=b4JFCIxwDbonXqNlXKzg/V6Y019jfPDQDJsUB3Qx9bSeGUc86gYjlkOQ0TCQOihnuA
         PiRipsnQqnuiXQeVqrBiNdK8AbAf1IQd5tkxl3ZbouTszfke58dkMGyZnq/o61es3MCN
         gIvvrn2t1hFjRfZ5Uj+WX7VWhK/fU99snKqMaGEJSAIA3TpPKnGvvIwMBHzcSNd7Pqug
         qRUZZMi5MI+OsL3xHD1CdoQsYoUIQkTbno8GMUh2a9Svz4I1MKyPrBGZmM4r7ftBad2i
         gEZcI++viipLlcpAX6mO8z2hdDvLVhqT9fq+wrOnts7w+TPA/o5dZ90grdIvZUXp/2Hr
         au5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrUxqRjtL9h+eNgxncyJCH+gqJHArVLVS+7Bxu1BfqE4P2GZ7G9NSzcmNdmPO7NT0ceYFQZAqm4a3rk+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoqPASxOcLbI1/fXp2LEZYnMsdJatgydxi+6U4QMpuuKGkYOY6
	wKYLpalviYzQrwWD26/yc1A2Hhrbyvee+56Whix4ETCnbqgvQb8Ki6gCR7wseGMnIfg=
X-Gm-Gg: ASbGncvHsEDiNRERUF2YgVt+RrDxKMBSAnkmGD251MGJPwWuDss6mz9IM5DZfswiW+y
	plZFiofzR8u+D0uxQtsMQsCAs3E3Lt/0kTH+I/aOt45Bch/IeXztsMl0mRFVnfOu/vil2mkam+v
	l30JocH8av/wfQAKU3EuqrX+Wt2JSU6jGKTkQrsmnW2Kn3cvv4cwZgcmmhmKzZqk26edJm78JGd
	shwWLel19WbzFidMni0gO1cW5yGpoGEMO5q4Q6XOSXRqk9K07aESYx3JrBNMLV1PyUnqyKpaESj
	ar0iNt3M5yk697qQDT61sOvBicUViPS6NMDyBYeeSJF0zS3ji5Yv1sVqg4MnUMY6Pck4y7vpI1t
	v+kmPsZfN8iWY/JYJsLw=
X-Google-Smtp-Source: AGHT+IGeInbCP5zEJV/VOWe6y9YTaEHSH8v+IWrNO4j77bL4LJuoltCMmSx3sMyg2xrRhCTkabtopA==
X-Received: by 2002:a05:6a20:a110:b0:240:763:797e with SMTP id adf61e73a8af0-24340b8a6a0mr18926571637.25.1756141980050;
        Mon, 25 Aug 2025 10:13:00 -0700 (PDT)
Received: from localhost ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f3c94c05sm5317223a91.3.2025.08.25.10.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 10:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Aug 2025 11:12:57 -0600
Message-Id: <DCBODJ411OLN.1IGN033564525@brighamcampbell.com>
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Dan Carpenter" <dan.carpenter@linaro.org>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>, "Jessica Zhang"
 <jessica.zhang@oss.qualcomm.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Douglas Anderson"
 <dianders@chromium.org>, "Diogo Ivo" <diogo.ivo@tecnico.ulisboa.pt>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <kernel-janitors@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH next] drm/panel: jdi-lpm102a188a: Fix error code in
 jdi_panel_prepare()
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <aKcRfq8xBrFmhqmO@stanley.mountain>
 <DCAVWVJ990VS.255346CDNF1GK@brighamcampbell.com>
 <aKv5tkJghj6DZQIB@stanley.mountain>
In-Reply-To: <aKv5tkJghj6DZQIB@stanley.mountain>

On Sun Aug 24, 2025 at 11:50 PM MDT, Dan Carpenter wrote:
> On Sun, Aug 24, 2025 at 12:54:41PM -0600, Brigham Campbell wrote:
>> Good catch, Dan! Thank you for the patch. I'll try to be mindful of this
>> kind of logic error in the future. Please let me know if you have other
>> suggestions.
>
> Heh.  This is just static checker stuff.  https://github.com/error27/smat=
ch
> Humans are expected to have mechanical attention to detail at the
> same level as a computer.  I just try to write the commit message out to
> prove that I've looked at the code as well.

Good to know! I'll consider integrating smatch and other static checking
into my preflight checks.

By the way, I'm interested in contributing more to drm as a hobbyist.
I've been working on todo items in drm documentation and I plan to
continue doing that. If there's anything you'd like help with or you
know of any work to be done which I may not find in the todo list,
please let me know. I can be contacted here on the public mailing lists,
via direct email, or via #dri-devel on OFTC (my nick is xeyler).

Cheers,
Brigham


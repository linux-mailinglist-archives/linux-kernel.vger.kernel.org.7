Return-Path: <linux-kernel+bounces-733744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D68EDB07896
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38540188F81C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B7D28C2CA;
	Wed, 16 Jul 2025 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvGDidOf"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694D264A60;
	Wed, 16 Jul 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677233; cv=none; b=MCHpENGgZ/nVRr1YiFmK7UpUU0KVL15zW5REma9kIxTmW5Qydt13lQ4Y7I/b1n1kj+pVee/NN+uEc5LeOK2OrFcj8LOfLpn41wC2g3vNzURYBEjZIwa+3IFJWJJ9l6usdQ+T3D0i/MVos3jtS4BSpYzFDwzGzUWRtpcdF1+XNsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677233; c=relaxed/simple;
	bh=W5wFt20w1Ni7nqNTkDqi6h+ZIafkAew+bVJTdIx9GKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vil1rsuD2HYaNMTeis4O5uzLAdVkxs+4lnwJf4FKPTaVM5EJ0jWIwkzwqS5ffcRMvtKEXcaroWUcjLAU//NdVlIl/o9w6D6JYg15J/IjUxxyRWOMTZSNhhqO2tfr+q+YG/Iwbn6O5uDtkZ2yydgRPhX/ZjU+hzvl62HYk3ahWR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvGDidOf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23aeac7d77aso52566815ad.3;
        Wed, 16 Jul 2025 07:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677231; x=1753282031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyhqH9rBj38O/KLz2od0guZjtxbURMFycDRjSPDgZGk=;
        b=WvGDidOfE6pDuD2uocPwtHar19Z1DRHsSdI/C3cJYuQ5W8reOZyPx6lHfgXy0doNp3
         k6xP7tewOLv7KBORxCzKRwfrgQRhREduXj5CRNxQnHauDLsetjmdxkxaAwASeTWtkK/p
         N4MlHbI1I/PuSFs6Mv8VtsHnv4fj3ycITviBxXLVMyVEFo4eP58w380J2eCxDvzBvWtp
         EfmoBIK727jWO5tB23yQLxatCZfCuSh1vhseSdy0DtxVx5BM9/kxiPQXcOmCY3IYGHOG
         +BlY4RgN61nb7mG2Gb/5pbbjCNKErxV4BFj3lfnyRf4kAW0AWdLevmTSgo42yPyAJJRQ
         hnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677231; x=1753282031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyhqH9rBj38O/KLz2od0guZjtxbURMFycDRjSPDgZGk=;
        b=siNZGCU26GlkULmaQUsQUJ5aSxsLbNiTjDBsWr99Fzo+aBdey/rzUHej8ELgdEW5j0
         3Y6OPoj9zZ8vWXkmPduC+l6ihxd2K+iIe1ELn01RrrklrqTqSh4xmEV7Drmzhp8qQ50e
         hbJwqSJodVkgXlRzuGCt8ETIeahsMByh2Gff/tnqPWdjW86/YinJebVjJL2oXaQ9RwKP
         zObcqjLfLCzhwRvBWujJw8s6/zMwOY/BfNQ5FpgtODJ7DDHt65xMgyOFC9IASW9YbK+z
         mps6H0Ynhee9EKEpNB0uP+RknVDN9emomgh+CG32HHK2zIglsoK+FuQQ9z/L32KFDQ0D
         KM3w==
X-Forwarded-Encrypted: i=1; AJvYcCW3grlh7rx/LMVdaAXGdGgK57w2cXcjZKTzEjI/IpPkocsHyCYONAe117SvhH+WptIh2z8NRQnZJ/7ZxX51@vger.kernel.org, AJvYcCWOPQ4bibcObxxhc73RdZVSZ2C8b3hdBQM3/ffhu+dXHAj7pJ+5HQ01Skw/5uS/iGqElH5tT1JZlwegO5Q=@vger.kernel.org, AJvYcCWaGN2cTcu4l1ulTHUQWukorrC8z8fTEyqAj6YU19zna0PpYBD3QXW+zPL5aea2duLPGhNjlqPHbFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7JCmzLX0/w7WeNlMa4OIW2opG7Tv/vfOqrQA6qaICxRL6C1/T
	HJjvBsSqGUjx2/Cygb9hCgeMyERIsmPnELDbKKVZAhPmbyMtf/sIZJWZ
X-Gm-Gg: ASbGncvNRQmVnVW4tOvfMA0JeeKzmsIsBUKMpOx1QoPQDik4sMidJbvrc6QGwlGSbR/
	MXdeFs26B/T3WU6TgqhZWCT9xZxgikWhzvnQgqI83CdXfSN2aXniKOglA+NnkSTdzs18X+1487O
	VqoHaMiPXfk6OEBxbMTqZIyWbc6W1dN0DmHAgSegCODKrHr1n0bxcObEs+UNHTlS/lTlfNU1i84
	xRmHrD/wNpb2Ex6MckGCPVFjCAZrOKbxuihiXIDoExwpK+Zj2W/Qi7F00YEVHulOztqSkLnCEMA
	2Z8XMICdu6CA9leH2WxuKWx23prM/WyVXH06gAh9DqHkBqJX4h03Q4eVNxY9KjKVEwvNHOB6Pn6
	JhL/k9MVLl45UET2ipYbJNRNZUhvSJDf2Olc=
X-Google-Smtp-Source: AGHT+IHA1X3jxfx075HPwj1sBxYjx4O5SOe9ENUbuI5e7Oa+FVOPkIJztZZseIzYY/SDPrFNq8FV8A==
X-Received: by 2002:a17:902:e78b:b0:234:9375:e07c with SMTP id d9443c01a7336-23e24ffdb01mr62197105ad.46.1752677231444;
        Wed, 16 Jul 2025 07:47:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de43227c2sm127573725ad.107.2025.07.16.07.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:47:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Jul 2025 07:47:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Masney <bmasney@redhat.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Jean Delvare <jdelvare@suse.com>,
	Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: ltc4282: convert from round_rate() to
 determine_rate()
Message-ID: <978cd1e3-24eb-41fd-9e24-656a2051f98d@roeck-us.net>
References: <20250710-hwmon-round-rate-v1-1-64fbe4bf3d05@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-hwmon-round-rate-v1-1-64fbe4bf3d05@redhat.com>

On Thu, Jul 10, 2025 at 02:10:41PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> appended to the "under-the-cut" portion of the patch.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Applied.

Thanks,
Guenter


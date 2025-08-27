Return-Path: <linux-kernel+bounces-788601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579B3B38720
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5B1B7B43F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CF63019A8;
	Wed, 27 Aug 2025 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUHuW32o"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2452F363B;
	Wed, 27 Aug 2025 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310064; cv=none; b=tHIHRbglgSEC5ibEbqP9Ts4KmXpM7EgOO3vw5nU0Ag5CTtYchV/OjKlo9mT2URScVAwy3y8f/nBQI5f/GYT3mNjX39Uo2nhxHNY/SL5OjIRpVyf0xQ1nUAtgYQ6wpD5Ijnd4851DQKFCEkabbBn4xZ/0QcnTylOVztvAB9LTJX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310064; c=relaxed/simple;
	bh=s+1V+ph5lD768Tfn6TzN4tG2f1brVf4Reb5FYGv/efg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ujf3iyU55Ed7oHB7mmO/Dwq+4dsPntyvrgQzZusLdJVz4S5I7sYSk3Zp5ClHfiUS5Vjn3Dy0zh846V3/q3h+8xL9XKGebXvh0+Rzo8h7khCh3N+bTf4e71ju8aLZHSO0kgCwqhGFzJJxB8gWUSoLAbJAJgiYbmtLumzmhdrVIog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUHuW32o; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7718408baf7so11739b3a.3;
        Wed, 27 Aug 2025 08:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310062; x=1756914862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mD62+FeZ9pk/ZgNE9O+o0Zqp2k2MTQTndpR1dIrjpI=;
        b=hUHuW32oKIGBSDpBhi5+oeQMuWcP7VVm+Si1vbgeri8o/pK0vgbUx8xR/tfFZ7Uz0b
         EAED6A3MbT4v1d8lPzKIwWKzPmKyOw6SdcZfskmzmAaFDNMjj9l3VnSRDyvqBO6+FZXk
         /VG9IL5yecDeJUHkjhDxJQ9+ZJu4CWRNjoR/yXK9jpdlLoEF7vMyKGvF+FpWO/BNITDo
         8H45XFomYbTx7bXcDTvCVzqRLEUjyGoEFnAENFcgAZPZ/p8ralC7/lzcYrU2a5xC5Hsy
         dHGP8K7asiTcp2/bE3v4LeZh8i8BATwfESsVOWPCRrFab0I765D+11bFSPAbU7H8xKKN
         Ox7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310062; x=1756914862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mD62+FeZ9pk/ZgNE9O+o0Zqp2k2MTQTndpR1dIrjpI=;
        b=vt+lfTc/q+rfcmfs0dX4+fUA/UJr9+lMFdYzPEKUdpXCTdpGsKKvaHjr6k9K4wHkZd
         Jkw8TtjiicGevHtcRLSA2gkSTP7sD0O9T82gPKDHrZgdOs2Bghljh95WYNlVL1Xu7Em4
         QIU0fZRSuI+WPzZXfPtQ6/URGuz24wv9U+IB55DNhW5886b4t8oMTNfyOsuzySlZ6tD5
         bJbn3xzyXZxZE/eiLYLKgJpthHsFnSCOZHH0oxLOldex1O1dc2kNjrTljrR71PfY6ZH2
         fhQZLj7G8EnSyDV0ewevx7ATh9ExRqHCiBcmue3MFQ9bW2IrgvbKEx5WFeiDN7QX6h6l
         Qzxg==
X-Forwarded-Encrypted: i=1; AJvYcCVFTT8XKHr3kbIpcQetSDEc/qmPqx1HrbGUPLRc6MOWb0IpFP/503ADwcn1OlGWMsLsqzluv3Aw5AhlCSX4@vger.kernel.org, AJvYcCW/D4vpTZG0MkyfNCeLLn4VJxbYg2TfYRVrUGwvO7Zox/TWV5F4HPnurwVYCvbneZS11QCTZptS/2gzQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAzefvvOEveRqYdW62r49W7WaEaWfI8aZ8Z7VDJkqyQ2XhPAvp
	4e68ARmF42SmdKkWAUm6ltdqW1fEGdVMmL7z+gxILUviebItrr6gIK2qtauZ2A==
X-Gm-Gg: ASbGncvCvIq2DjdLXvZvFA47058R+J19sMpTDD4Lfv5muwxoN5hkrV/VnyEm0rKWjdD
	IGyr1L0SFgtcpD2G+GT8xy+wRGoLftSXqjCBZBBFtmyWbxKXN/MM1f2kd9aSJVV10vVd8rN6Nm2
	jP9vdeqg0DQn1WjvZL8P0MuIWDipIuNMq9+H196TJkfBaHYIpwFttS2ylJTRSt3zNu888Vjv65z
	Jno6CWfqAm92J2DAhJF7Ga3FBi5V091GK/nIm+NcNyvipgcT/um/FFxV0toOyIrxLYgZvAEYqPr
	itmzHAmKsaCNQ6yDQxGDCSXk3IXhSvdnQPbZMr2WWAdmumOtfosUkNNhCOX9ThQHs4pDOSw+EPw
	JTO3NiTWk2wo61Kn9ZDBcWPT+pXH3dE7O3Tc=
X-Google-Smtp-Source: AGHT+IE1yMgCJPC8FqoYDPx/cTvWrWpIS+8aIQdZNTeBHLpJ0ui1mZJclnWAdxnrCkwkXYE9jbLU8Q==
X-Received: by 2002:a05:6a00:130d:b0:749:464a:a77b with SMTP id d2e1a72fcca58-7702fadbd03mr27378252b3a.18.1756310061882;
        Wed, 27 Aug 2025 08:54:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e814cbe1sm7940609b3a.27.2025.08.27.08.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:54:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Aug 2025 08:54:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Jean Delvare <jdelvare@suse.com>,
	"open list:LTC4282 HARDWARE MONITOR DRIVER" <linux-hwmon@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon: (ltc4282) remove the use of dev_err_probe()
Message-ID: <4885ab8c-5e15-4f48-855b-ac9a6f4564a2@roeck-us.net>
References: <20250820131509.502007-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820131509.502007-1-liaoyuanhong@vivo.com>

On Wed, Aug 20, 2025 at 09:15:08PM +0800, Liao Yuanhong wrote:
> Logging messages that show some type of "out of memory" error are generally
> unnecessary as there is a generic message and a stack dump done by the
> memory subsystem. These messages generally increase kernel size without
> much added value[1].
> 
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
> remove the useless call to dev_err_probe(), and just return the value
> instead.
> 
> [1]: https://lore.kernel.org/lkml/1402419340.30479.18.camel@joe-AO725/
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Applied.

Guenter


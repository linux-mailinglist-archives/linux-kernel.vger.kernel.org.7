Return-Path: <linux-kernel+bounces-881977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFDCC295C4
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 20:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1ED9D4E5DD2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 19:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7324B21ABD7;
	Sun,  2 Nov 2025 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haNWGGGQ"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0EE34D39C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 19:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762110515; cv=none; b=nFRn9rHlhQV2aKwOHM96flPGY9P0wMnHxSjy2HQVFP06xD6ma+r2w9ChNMjGAXrZvF0zZbFS0cEv+gDr2abydTOtT934KqCM2x1GHunEr5hjdO3aSHbX4HcbQT56Euj7z23pssLnffhh7VA98csNQDVWdNXjdLD4dI5+0jbOhvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762110515; c=relaxed/simple;
	bh=xL0+0fqs5yDODEbAwb1kuJnyeaQuLpSps6L/qmcOFZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yb2vSdROYQqYGAHl201lMHnpFve8/DCdh8Due3t0rYT66gXgoYlvueouN6pBG8gddwuYczkZCXZmJ3krNtGublkTVEsrNmt4lKeTqZ4ppUVPt+vDhDp1w+QXHKAa3f/2il90aVNJ7m6z0AO7gamFvWQjjYWnXn15CFsw18qnWrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haNWGGGQ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-340ba29d518so1126574a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 11:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762110513; x=1762715313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8rb6E7vJv0wdgQZQe1lYWjk3hPHSFp/A5kkbljewGg=;
        b=haNWGGGQPXxRW8GvkFYJSczbiJu1s5rAsF6jFD28SkG2e8KTktOYALvORupn4PoXK1
         xjie/bZXVnK5eOrh97eZ+4LV/QWYtqTsX+2c4iW7FHetJbIvKVg07/sVW+NxFtMIi8xC
         97+bWCnMMJxwq9OLwdzkvJcwuDJM1X5H9enh79jn29adgyB8fcpBpObyjlJ3MGZxaz4t
         fcwTohVz4RtDLh0NJSfuwDB68mfI/08X3Wulaw7gh97o0sr2DtEAfWAHc1SP2zgi0Kge
         r163mxYoSZG51Hg32l2p7IgjPNIRdGHOasOGC5x5iSLRaHER3yLbAESsolSV4ILSgtbq
         /ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762110513; x=1762715313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8rb6E7vJv0wdgQZQe1lYWjk3hPHSFp/A5kkbljewGg=;
        b=UkkfOhEdo571qiix/NiX7pZzuh3pOAFhPyr3EHrM/ebBH6s98Iy1j56CextyV8jYDv
         w5WcrIrC4lFvIkni/Lz10R8Qd2t2sWuuYPn6/0L4Y5+/LL8k8gw6qRP5bMgChHMiT4to
         qzKAG18I/QQn4sbCEc1emUhJ8TzDcbXnLdkyTjTTmDz4tUC/HOIWBgHkamZt+48WCSPl
         QFmouBgCU+6xHQDnIWUCC31r+/QZ6AMQX9udq/hkz7DVw9mKFIelG1+IHEZcIq8h1iu5
         pPUUNlzlFZfkAd9G+E8GA0teI7uERfMFA0f3mcMUM23ylJxfTogdWBoq6XVeUMFrbKT1
         W49Q==
X-Forwarded-Encrypted: i=1; AJvYcCVq2Sm3K4EFlcNe5o6QoxR2oAnioMiILCW1V/kak6wWqjmxDm4AP+rP3DYUUVkGymDy85slbKRy8L9EP8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1sTUw4tPNDF8hQbB5TrpjFsVSkvoVRAOTAiyv2m6vvdYiZJiz
	z/luxEuqciPVoDApf8MdbNuijn/N9LSpETFjK/45Npjl69IWQ8ys2FnyIsr+dQ==
X-Gm-Gg: ASbGncvj7jfvz+U4cN9oLQb45TTnOxUJ8YPSTtmWYlRhW2Z61gCgZmruknXU1z6ltqP
	70MZzS2oInLGYuxQdi1I/ERs1S5PXz/NcBLgfKqvss5dsyqWk171JGl/3w8KZo4LTY7DObrAsBm
	lLs8u6meukVWUaFVmCQIK0xCnLpPRLDRVse1Yv2/3F3QkJ9lr/Pi6ZV0ZyWIQUpxD6MJoxut6cr
	+kE4G3M5CdX8/sno1H+ZOGOqnhQOpXKqCyL+L8//lMihWAUgCmMUdE4OuRaEj2CNBmMoFvCsyeA
	vZabtEeJQiXt6oq8paGljCq+Sbcy7QaiLYCQ4tV41zqoSBdwtfqm64na2ui5rOQyPX3T3XOTPB6
	rDc21cp3zpdBqP85cbz1Adcawb3es4Ur6Fr2AwD+fQvfgc0UfIiTy2TEO1rop63qMpH034kXfBs
	Te6oukifPIuMCA8+e55GDZvl0=
X-Google-Smtp-Source: AGHT+IFJT5BZUNr2n9mLnPHEaAFZFvgfxudFvf1695PqfpPWQnLXpDGuuzR4qckE6/SBOiHCas2PXA==
X-Received: by 2002:a17:90b:1807:b0:341:c89:73d2 with SMTP id 98e67ed59e1d1-3410c897455mr2210378a91.22.1762110513492;
        Sun, 02 Nov 2025 11:08:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93be4f8cccsm7963373a12.30.2025.11.02.11.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 11:08:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Nov 2025 11:08:32 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	niecheng1@uniontech.com, zhanjun@uniontech.com,
	kylon <3252255+kylon@users.noreply.github.com>
Subject: Re: [PATCH] hwmon: (gpd-fan) initialize EC on driver load for Win 4
Message-ID: <b68d88b8-0eaf-4f9a-a847-befd95659c5c@roeck-us.net>
References: <20251030-win4-v1-1-c374dcb86985@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030-win4-v1-1-c374dcb86985@uniontech.com>

On Thu, Oct 30, 2025 at 10:30:06PM +0800, Cryolitia PukNgae wrote:
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> The original implement will re-init the EC when it reports a zero
> value, and it's a workaround for the black box buggy firmware.
> 
> Now a contributer test and report that, the bug is that, the firmware
> won't initialize the EC on boot, so the EC ramains in unusable status.
> And it won't need to re-init it during runtime. The original implement
> is not perfect, any write command will be ignored until we first read
> it. Just re-init it unconditionally when the driver load could work.
> 
> Fixes: 0ab88e239439 ("hwmon: add GPD devices sensor driver")
> Co-developed-by: kylon <3252255+kylon@users.noreply.github.com>
> Signed-off-by: kylon <3252255+kylon@users.noreply.github.com>
> Link: https://github.com/Cryolitia/gpd-fan-driver/pull/20
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>

Applied.

Thanks,
Guenter


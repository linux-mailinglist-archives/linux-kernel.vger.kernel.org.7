Return-Path: <linux-kernel+bounces-734406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB9AB0812E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA9F3AFA17
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 23:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD672EF67D;
	Wed, 16 Jul 2025 23:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbp50Zzp"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA1F2EE5F7;
	Wed, 16 Jul 2025 23:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752710224; cv=none; b=V5YEQuJlA0UPskyT0caGLc/srX0Uddt8aGp6aFnFrvfO/4Ndy1lujo3JV6q72lpDMPjfQleq2W0MAjmJBdmGzngmdtGL7rqLHLWmXXSgHjskJCxHktRF28UJe+2R+his3hIgUxXvuCtCHFdNtvPvBfd3+cdwzeRzVfCg6WD/vnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752710224; c=relaxed/simple;
	bh=k3g0w9pa1u4j2IhXx0X3BkHrOmc8Cshe8hrnzc3HdD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtVvaiPXUS8FLGPVAiVVGNwWZneGNn3M3fpSk+Zdx764FYgBaPCyXYU/JyKb+F4fIAUllTDJA2Azb18BgfORqjn/oMC/cXyt++9O7ulpL0P1HnLoEVexEPc0Dp/EaonqDiNBFYzVXvimS/7DJpI+LUZHn+aMiFuh2j0uVSRmBgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbp50Zzp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74b27c1481bso306618b3a.2;
        Wed, 16 Jul 2025 16:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752710222; x=1753315022; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qZ8pegaK19UnX8P3aXiZbwIlDfmCOBIl37WYmnvnaJU=;
        b=Sbp50ZzpIEjVCdrJvWyU3fgJmPFT7flOQpK3bbPeR/aUDrtHmyHVRw7u45KEg5FL72
         dDPTnRvkPr/iq2dxxXEQFwBJfhq3pQaJjIMJzT67IMR746TYoF+cKdPTNjwzSbV0Cf9m
         DRoUco57SpxJRF5h+5tXMkjclpavm6qFbS1cSeCa3uQC/S75jGgKF0xwtv6IE9b2rNrH
         scGZRvqpZ49PQP8aOwc73ckM7AsECz1A23a7XyFJtLajy+ufwFr7ISsazaluDqCnNkhu
         gFj07GKlSNSVosUxmUxTUn3UOqTV7DYoPgwbjZAfev3ctdivhGX8wRA7hewSapcCYD1d
         HPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752710222; x=1753315022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZ8pegaK19UnX8P3aXiZbwIlDfmCOBIl37WYmnvnaJU=;
        b=iQmrvNRU5dTJ7X5aEGVzDDTpGPZZf0OZrbPtOFTz2YqV1W3chvDhfumouF0jTIjXCc
         wU6ArPcBQpEcygutrCnAJ0rpdoW2F31J8DupxhshmRsXDLCQeqYv8B7S/Et1Wk/nQ2gi
         gwJ4zNob9bksqA2bB3/nJOqonnjnh8/+bLmdrQ0kx3ycytkCTajkeWei8bfrH11PZqh9
         WvJCbo/iEJB0inMQAR75ww0x/horsVhHPxpk2BDA7dm1AobJb53BLH9Odu/DXsWbDG1s
         dQp0jlN7iMWUjHjs1AGdudnrPBDWq6CWsXCe1ogm/I4fgfYJuHgKCBmzKUGRekCMVBWc
         fagA==
X-Forwarded-Encrypted: i=1; AJvYcCVkYg9NcN+GX+TvRg+gRm3CT9XobrCVybb3s+fJOeJLJH9RU3yq7yv4k05axcbqpGY0LszV1H5O6bC8Wkc=@vger.kernel.org, AJvYcCWfF01cl0CbnwfIZpEhs8qeOLIR2dCRB0KQ+fAHLsSGQ8RpaTib4EaCMO/jVlYG6zvhdOY+5Osa320=@vger.kernel.org, AJvYcCXtbN8IYLF0z7spsso8L07KuDowO8/6cf0EHS20LyFxfgbwCBCJ4Ds7p403be5msER40RoWNI0O5Yk2Ncni@vger.kernel.org
X-Gm-Message-State: AOJu0YzPFqnUS2dfl8ftf8YFwyi8L87EcpJoOeKQ8LlF/QbvN8grGfdn
	GXNPcrkWPtDNqA9cKC7BD/kG14V8YMoGGzNZKxjbycw2JKUij7sPKC56
X-Gm-Gg: ASbGncsGbAUam5ge5tBWmTLQfC0ed0kOkULPilFBGC+m5dterZDfNVnVGqlvlNij+Mt
	PjQ2knR+OeCzvxMUgcsNWIwWZRnjGJHZupY2rb6eGpyA0IJK/t28N9yTjG3oi5QjFaRqCm9Ewx+
	B3URO+AkJJ43RioZ6OlkcADmzWxXMnKos9nY9ViaIpIpHjnE9yKYLnfHFhFH7QzVl93YF+MtGsf
	nr1UPdR0/bLAwXOtUMefWFw3GbqTZlxrc3RdHgnHrDRricqxSFl1Toi/mIXCVZZBXJBl0B/TNJw
	36lxlmYrdCr68dyNymwCq/LkE+gpbaTjX26FRbHG6Kj2YlAY9+C4BVJTGczCEhl3QT2vFcK0kRl
	emaqhBE8/tB3IGiiQ9QjXzOS2jx/JVEQUswQ=
X-Google-Smtp-Source: AGHT+IHrZv6GVt9J8YNPbDKjaIrzg0I79N2W6dpo4CjweOKAtdxJMZFTo8vv4NtmBAMBPUMjBpq6Iw==
X-Received: by 2002:a05:6a00:3e0a:b0:742:aecc:c46b with SMTP id d2e1a72fcca58-756e99fc423mr6735056b3a.15.1752710222283;
        Wed, 16 Jul 2025 16:57:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5e9asm14800090b3a.25.2025.07.16.16.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 16:57:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Jul 2025 16:57:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sung-Chi Li <lschyi@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	Sung-Chi Li <lschyi@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v5 1/3] platform/chrome: update pwm fan control host
 commands
Message-ID: <50fbd7ef-8983-4453-92f4-cc9e8516449d@roeck-us.net>
References: <20250620-cros_ec_fan-v5-0-5979ea1abb31@chromium.org>
 <20250620-cros_ec_fan-v5-1-5979ea1abb31@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250620-cros_ec_fan-v5-1-5979ea1abb31@chromium.org>

On Fri, Jun 20, 2025 at 02:49:12PM +0800, Sung-Chi Li wrote:
> From: Sung-Chi Li <lschyi@chromium.org>
> 
> Update cros_ec_commands.h to include definitions for getting PWM fan
> duty, getting and setting the fan control mode.
> 
> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Reviewed-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Applied.

Thanks,
Guenter


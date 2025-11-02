Return-Path: <linux-kernel+bounces-881976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 937F8C295BE
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 20:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E06944E7741
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 19:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819851E1A3B;
	Sun,  2 Nov 2025 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6vVJ45f"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C56979F2
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762110325; cv=none; b=aLYbMi8KGbW8Mi8CHiDiNG4xYptkuJe47B+U6QvgX+iNa2uj3UQbaO+En+At4x8XZcbkHpQqV9HEKTUXupvfwX0mO7zqotrsFfe8apkRZJIam/UAvbqcBx0Q9z9z9ZtFpDJQMybm3NhVVwYntbzZVcK+lKLUJ1Vf8fEl1dc8te8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762110325; c=relaxed/simple;
	bh=CL0xm3KqWtIMl9SlvJ1SzuGnrvB+jFOJq2mpjvkYzlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5/lb9nb3BTBl3ar6UEBSOpA7KzYtzwe9/So2ZHvsmAxwE+IGyYmb8KshizbJbdo6WNNvcVx7CdhZTtuZ8My5T4IUiK6tRoyXWY5RRg7qcwLi+VhDhltNHDog69TfBc7bj5pu9Y6NKp180o9HrivCkmCE2lhxUlelHDydKYCObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6vVJ45f; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6cf07258e3so2429002a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 11:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762110324; x=1762715124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Da5DNptY032BPRk+5IeMxUscoEVtDVHR7BE+h8K5Bs=;
        b=I6vVJ45f73QhGYG0ExBIqOH8Y+D+wucarWqUUD9iRhkeeuDp6tPvnoBehvGUnLAv6Q
         kLFo3d9lOG468cLQU6ZcBHbtFLAT06fey0CIkKbptWiva4yRDsq27TDhHykVX+eWpfyM
         6HwOmP1hweZJfr5+QsdBJy3Ns3WhLG5EN7Z7B2uMXIAfVFoCHcUNIx8ouahsnczP4xBj
         MUvQiXLXMO3Io1ndrrXC1Ilb2u8pVwny4FuLaJnpmhERe0kbL7GBQePr6AXRdgmoc17a
         RS2W4l+2s6agCAF7bNOvZ9xCpCKBTyF+YUTYr/28kaaIvll2c1fhPfvTsOPc4snBxdRX
         R9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762110324; x=1762715124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Da5DNptY032BPRk+5IeMxUscoEVtDVHR7BE+h8K5Bs=;
        b=iQaRBIZpM6wgposzwVo4KWne1j35rk/xl6oktJHLM/J6LT5nSHTUxkHNG3oytBnyCG
         AwA4DX4b8sGZnSnrv1PWDQDFekWq7rNuUqBUINSkmL7D+RMgbOEuI4t7Pvlp5gBs+GYf
         o6b873Uhr481HtuM6gn4+Uwmh015T/7RMOnNiJVyx1Swc/kEFr00qfYxMw35BcgC0cQf
         yESnopeoeHw0gv0e62IdwjHHDw5MFwYpGcF+yO1zkbLyt2utfd6a9tO0ujF7GZkjxK8H
         j8tlUPZ06rVuIhUInASZoUKQ8NIx4z0dKnboEcV+MKC8j9+nuMoyXXL2GZm8dhACX6kO
         HLWg==
X-Forwarded-Encrypted: i=1; AJvYcCVdKsXrgyQCsaHcYm6C6DC70Tpxjtemnm4dhMXfA2oRxsRjnHMKt/XB/uqtGqHIbu3+xiFScW/TUah5t14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLCFPiPaK6lftKm2O0HmCpV2V6QM7ANK9XKyXAr3/v1R2tlBk8
	ccYGHtzlHjnQ+KfAc7b2clExe0UFKAg+FAoY8F/xJhQrE5HTOpmYP8vn
X-Gm-Gg: ASbGncv4cOo8Iaej+cfnVQEr3vC3y0P7/95FwB85HbFWgsBdvWqFuTZwkN7gThmt9oN
	KOrhIUbniiyZJE4RnZz9r/6jyTBe4EQ3MD67+o/u2DtIa/EvEaltCIvFaTqTxo/KzgSfptyDs4a
	AiF0dCjNHjV9Pp/B4U+ortp3eJnKhiOAeGgkXwn+Rglkkyvil6oFPSJvX8nc/t0RUbqgYyoiQG2
	FRo8TGmoolpVxJiGMyo5OVe8Pos3WwmJkjCyfJ3SLyPjfjg+AwKM7k48BSjnYEXFSZQ2lkd2E7O
	y5zGk0CoN9bTFXCtmiPvEvRdH+ek55lB1pyoghrp2QcjVH8A7CXTzCdFPIYjgV4SY1xPQYcuyTg
	tQMdYlH7fLjON25gkrfJyXuh5Xcd6Swga22GejNrTo5vDldGq8aysVsEJT+9Emi+7ggnkazRC05
	lqrt2S0GDp0J8BIyrGuxBFbV0=
X-Google-Smtp-Source: AGHT+IFrXifcYOK7J176L3K+BDvbzXMdXVhenewgHc8f7GJsEfPeOUwKCAvP8Ce7HpQtenvpH4HJwg==
X-Received: by 2002:a17:902:d491:b0:295:557e:7487 with SMTP id d9443c01a7336-295557e7b75mr73849905ad.9.1762110323785;
        Sun, 02 Nov 2025 11:05:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340d1a4a587sm4454621a91.3.2025.11.02.11.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 11:05:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Nov 2025 11:05:22 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: jcdra1@gmail.com, kiriyatsenko@gmail.com, afd@ti.com,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: Re: [PATCH] hwmon: (aht10) Add support for dht20
Message-ID: <8dcd27f4-e297-431e-b763-5cab3f85be29@roeck-us.net>
References: <2025112-94320-906858@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025112-94320-906858@bhairav-test.ee.iitb.ac.in>

On Sun, Nov 02, 2025 at 03:13:20PM +0530, Akhilesh Patil wrote:
> Add support for dht20 temperature and humidity sensor from Aosong.
> Modify aht10 driver to handle different init command for dht20 sensor by
> adding init_cmd entry in the driver data. dht20 sensor is compatible with
> aht10 hwmon driver with this change.
> 
> Tested on TI am62x SK board with dht20 sensor connected at i2c-2 port.
> 
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>

Applied.

Thanks,
Guenter


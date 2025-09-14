Return-Path: <linux-kernel+bounces-815429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493E8B5641C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 03:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CAD17B4C7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 01:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9531D79BE;
	Sun, 14 Sep 2025 01:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyu5u5jY"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7491D5CC7
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 01:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757811759; cv=none; b=jx781rKpsrI53VQX+22fjrL4Ypq6hmwkSYSrKLRU7+9PBvqHpY+SOijYhL3ZVNlLPHa0I26IGAiRDjF9ljSWo5/eStsaD9PmGUAqH29G8Fcyp+ON6ipwoH5Lixu7yMA6eUVOhAHRl99SDdZpAVjORLap5K2oYOClUDpfmsbw3Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757811759; c=relaxed/simple;
	bh=YcKYuOsHQiDmDHla6Xc9HOipmRbCz7uiQeIiuNrHhNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j42++Tir2H+88f5XiGQWo7raHvtdA68GfCKcT72gEIez9i9WqEcww7Q/jRpJ+VNmWUN4iF8eDoOrdHxIOobOpOTt6Bru/GoP+fY7KNbaC4Ag5s1gHsVpKwFRCBn54tK1/FzB4i/yyiKW6R0N7nFL00DR8N5FOmUyoELhH9zOJCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyu5u5jY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24457f581aeso30642275ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 18:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757811757; x=1758416557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3tFCttzaSkqmy6bwSxlBN+tHDcFNxwADclbMsDDT+0=;
        b=iyu5u5jYxzEeJuSktwBJGH9fXc//pmvM052H+KsPQ3F51JhhYk5mu69WFxnoj16vsr
         I24Tb+QF19R4w81muZtAdQ8CIikps/a42aNpmw5ip0cIi7K2Iv1Ec7NuiAstHFDzDBk0
         z1EKa+bGv8rwpAav61zktX7J5EmnmrqWDEsGXD5CVJY/BO8ioCJgA+ij5SxNwkn4f4EZ
         QcUoysVyP6wsasG+1bWCp7i6mpc0quAmWoJHUuZHrm2YD9f1Byq35jOjlVtwQsLGDn7c
         99/4JeVwJXO/2HqcxGfFKKn9RatObRRZgSZicKRk/O8PSWX4/0tSztxP8+mWIeF70b18
         5VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757811757; x=1758416557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3tFCttzaSkqmy6bwSxlBN+tHDcFNxwADclbMsDDT+0=;
        b=UpuyItZwckgns1C1bc38FS/oysNPaQoiz++XjmEm/I2vImcnvhV41+BMgDBEv/INLh
         aihOmqpgBLQnYHxkVhtgmSnRSprFLMjhg0I59RGe+pviXoaOPz0XyXiR5auhqML4000X
         RW1dUUpPX8pXqBf7VWZ3UaR2M5kCqH5earREBNekDVnO8y9dxXicxDaZQIpulnilXoky
         jKDWmL5+7WnLORDtN+xtOYWQvow+c5nnStb75V+J/xUkU0XTbJZ92YrZjLdAYzsGU/Z1
         avLCMbEA4kCSBJpVtZW52r+FgdfScImGDE25b2WLfZlHcRDZ36yLlqTN0fRoI9SUbVZQ
         nXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN64QBX6b1wpRgtbyyRVgTwmyXRdCRe6KnsGc0zBTk1bBHD6xFz0lwMeSdAPF793eVwhXaMuGdTsbp4GY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6P5hIKEkbnPCkmbVJBQmRxrjPduJk+ScekvTQd53J7s4vO1dq
	/RvOWtgNEt7QVZRDACFwhbvIyTVX2Rw+unRqzsgUdDSc5owQPtrTZTRp
X-Gm-Gg: ASbGnctNO82yWEGUZ7+ocAg66Y0lTgOknWxrdBvYlnE2YuxjyA4SzRXz5KwHpfheTDG
	h7pGDde7D/uh1ZjTk6f2xj88IL6wz4khbjrMbZx6IDZ88CFpT6QQhbSGD+E5eHc6MrGgThJzH3Z
	Rx7hmtgVNPUEopvSPNA0UklF53EbgDveKAXlEUgiI1keAy2/RfoJgyrVopLr+KpQ/EAu+Sfa4eX
	aPlsrZB6/23GgiPuZYgrc9URUspgSzYoiVwZXP0CexPJ3Gh/alC03EjXyHqCA8RWgAtCSUtV9an
	Pc2S6QB+8YNYP3n/hEV8w6/uW5K3BwKy45+NgGL6yIOfmNHNWZEVRiR58JhUoT4C7361rAmFq7D
	BuxtZaJj12pb7SwTztBmZ0eYQMwAoi3/M
X-Google-Smtp-Source: AGHT+IFasP1HhTVqhnuZkW+GMDcgc2NkUjSJYBWWtUuBHkU3lows+k2RPUZ75ndHMNEh3G6ASPvbfg==
X-Received: by 2002:a17:902:f707:b0:25e:78db:4a0d with SMTP id d9443c01a7336-25e78db4d35mr62051075ad.36.1757811757158;
        Sat, 13 Sep 2025 18:02:37 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:81bf:abc:6590:f690])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b20e01esm88107345ad.126.2025.09.13.18.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 18:02:36 -0700 (PDT)
Date: Sat, 13 Sep 2025 18:02:33 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Denose <jdenose@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Angela Czubak <aczubak@google.com>, 
	Sean O'Brien <seobrien@google.com>
Subject: Re: [PATCH v3 02/11] Input: add FF_HAPTIC effect type
Message-ID: <u2g4fikyekkk3yku5aqcntk34zrefg6tr5yaqygrqosr3elh47@oexr2zrxkza6>
References: <20250818-support-forcepads-v3-0-e4f9ab0add84@google.com>
 <20250818-support-forcepads-v3-2-e4f9ab0add84@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-support-forcepads-v3-2-e4f9ab0add84@google.com>

On Mon, Aug 18, 2025 at 11:08:43PM +0000, Jonathan Denose wrote:
> From: Angela Czubak <aczubak@google.com>
> 
> FF_HAPTIC effect type can be used to trigger haptic feedback with HID
> simple haptic usages.
> 
> Signed-off-by: Angela Czubak <aczubak@google.com>
> Co-developed-by: Jonathan Denose <jdenose@google.com>
> Signed-off-by: Jonathan Denose <jdenose@google.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry


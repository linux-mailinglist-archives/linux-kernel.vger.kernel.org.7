Return-Path: <linux-kernel+bounces-840818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14944BB57D5
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0A819E77CC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DBA15687D;
	Thu,  2 Oct 2025 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqbNY72q"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A35415539A
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759441083; cv=none; b=JMNNV6+EPE+X/fGTYYfT80mO80uGtoslX0UXuZEGWCPrXYpTlgRqqySZS5j/8Q6mGVKk/RdCGYgoz2Yh7uwjyWXK17rKrQF/jPP5tgMEHGGlj4b8WduufWQ13BrN3gLENdKe8FVXm27GiiA3S4+MM07SBVXAw9MZZDC8wwJkIQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759441083; c=relaxed/simple;
	bh=Wa3MaIt2OTfDMAacePpuDpp+xPuK/PWuzyclDSFj+t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUCBsRVbHlIxhIgdpUkpQQ833zcBSFGw96lIg07SejJHgf6B2XKOrrjtsyIlMOJ6zUQoMUrITIlttL030mfWcfaAyOuFOQZ8/LJxjD7Db8lVN+YrKwdSqHueiJnJ9RDb6tCu54O9N6b0W5HHBgYffGGFf/zpLUm9l0gQokAiz9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqbNY72q; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-789fb76b466so1538359b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759441080; x=1760045880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UYjs/DjWtPFJ9SkgiQewKjh9UT4jabvAen7EJXFzrU=;
        b=CqbNY72qE2w3zNKipvYfu4gbH+WsSVU0jPrnZ7lPyqJ5sEUbMA+S93FfUSPW/wGrgv
         yHd/PvzWVwexTYq+yTJCcZLyufzOK/3LpjIu3HluIhs9HVn2wLZkleBCIQXsNveaSfhK
         QV9497y9rCsWmZMK3VBIxytH6DnHYYsMq0BHxDl9PIbRCKbuhBI5VJZAXv8BpYh3n705
         LzgYyJp6FQWB3xCehIly9OycrMpd5U+68M0jIn8bJeEG+5HP7sgvdipBem1PLxFf97U4
         LAqCY+mHuUQEoK7dajhok0XHX0882CogkILYiDb6gXlAhkgWeBmqQNcfYGvZv0udvi0t
         +yCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759441080; x=1760045880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UYjs/DjWtPFJ9SkgiQewKjh9UT4jabvAen7EJXFzrU=;
        b=Vt8MnfZmWd/siSTYB9PjkpSosQ11u5LKZywzsSkfgviAPiX6H1HfUXPcC55+znJPEv
         imH6iIxXXMt+sfIaR6tCzJ1u0DExd0PspGYLWH3dYFYH4YGmH1kamve2NWfiUPKqv0DI
         UQ5/mEE156l9E4180+b48iCSjZ44bIgkQkXrW5Fj84voZNFodQRxbgMZed+fpiLjw3Ix
         5l2WtNf6yop5Kv9Qz5AUR5NDnGux+BoRZsMzuYSKgUpshBmZVO/yv1RMPMxoCz+EHOLG
         7KjtmXj5qjC33PRHomMpLDsNdga+lfm0OZfzDt20zCY12WCJMN68Ie15vqZOocG5UdsN
         7UKw==
X-Forwarded-Encrypted: i=1; AJvYcCWuXUxe4zuU4HbY/ihFqNLNgeRR09jclKq+upR7fYB3Q68S4mAHeRIIQGpK6WrX6mEVeE7gQHckNg678nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNtRfYl45MrDzqHKKWPIpV0gMpe4cN40mw+CW5S6XfB23/sqaQ
	P3ls3QFrs9je0J2MzdbrywSyC6gbgztbZLJYpOIXCUqRZSbxTdf59Wl3
X-Gm-Gg: ASbGnctpMHNODM7Q0ltXcNH5G0gL+6kz3JZ/4BhTJ0+alqfvrHc7Kga6yoTEu+eqOfe
	xMaTnfmnz9uSu3kglmgqoIokP4yfzHzc/20W2BozwpEXx2MKJHBr79rWShgfrwDwBQzlkXTpXP+
	r4ylIBOouoPqnPsvvL+1Qga3ziKH6tb6zNIrfKpJ8NH9JbvjEKEaVkUcU8wiJmxiC0kJqt/8n/A
	ky0tP4nrvNSpUc2BCw7+hUI0QfOxWGYb10Q5lAOwTw2Jx8mx6keJD0jYvip2cHtS152BEK3tXmA
	x2ExwgblrQkSUHpD+NyVmac3W9MoHheYDwPSTfxo5CH9fR8QTLHKtL4u4fefdMb0zxG7wnKlLcR
	5Yt9eiuQfduEIt44O6uXXaHSSrsL5Ir4W7V68YETgjfHKdU7WR9VvW0tzgWo=
X-Google-Smtp-Source: AGHT+IGfpeSt72PLiRG8302u7jW0eS5cM/tPuBTjoCfYGBR7WBrL3m9GghHnqqRwzstji5FK0/L81g==
X-Received: by 2002:a17:903:2ad0:b0:264:70e9:dcb1 with SMTP id d9443c01a7336-28e9a6fdf1bmr8314995ad.56.1759441080436;
        Thu, 02 Oct 2025 14:38:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d122d96sm30394595ad.32.2025.10.02.14.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:37:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 2 Oct 2025 14:37:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eddie James <eajames@linux.ibm.com>
Cc: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
	chanh@os.amperecomputing.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v7 RESEND 4/7] dt-bindings: hwmon: Move max31785
 compatibles to max31790 document
Message-ID: <4b617318-f76e-47b0-9744-6a79803a149c@roeck-us.net>
References: <20251001144441.310950-1-eajames@linux.ibm.com>
 <20251001144441.310950-5-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001144441.310950-5-eajames@linux.ibm.com>

On Wed, Oct 01, 2025 at 09:44:38AM -0500, Eddie James wrote:
> The binding for the max31785 is the same as the max31790, so just add
> some compatible strings for the max31785 chip.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter


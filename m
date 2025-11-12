Return-Path: <linux-kernel+bounces-898107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C7FC54654
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D4D44EC5FF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1B927FD43;
	Wed, 12 Nov 2025 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qtu3eSCZ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA4C27E040
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978132; cv=none; b=IH7veQxwoiM/GxDbgkZWeVWluAjMbXq0ELtP5fiIngGQTbYF6L1EB3Jv0ojzvPDgO6ndGeHNyM/QthXlVXpEn6r1IamP0UIc8njA4Bd/iffAGWUXGFvhfb+4Mg3t3vOYyd/eWIRwNuiLsuL2dqzUyMnwExjUerImbA5EskIxDLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978132; c=relaxed/simple;
	bh=0B2xRy3DtiRYJVW5uqqFoE1hZORZpikyOoZj3dabAHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPbfM2u5LzpTbHqdF8RH+ja8H6ihS6ZEr0GBYQVTK5EO5iogG+rNBX9TjD14D/oOitJme7Wco24uA9Gemtb5SD7U5Mwrh1GLQvt30KO/nCGm4jf/PmpGiqWfTcXpCp0VRZqu038VqpBgWqv70FI2BuHbS82/HZfS1SXRlCiC/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qtu3eSCZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so17187b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762978131; x=1763582931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arO3innaom8XEOzV6JBZdbg+gJkC7Ox3enKZEFIeZyE=;
        b=Qtu3eSCZFvMZUPvjYh13A8XhukWrwkl7R3hac9VkdsG4kawSlPYlcnBfSDD+cvDUdY
         8V1Gk0akSAFa1yV5OOP4TpTX8Ycmk4BgKVYzn3tEr9iq7fpCQXdOGJOiH2EP8qkrIgOw
         bgaJ4Q6XD6A6epeFBaZiWL2qSXeNjf+jtUdk4JEpUEOYk3+F3nBOP153kRl+QraXGT1X
         L7mMvVv9F+mRHqbPHNXIHi5uEjQOPqwbXQphprcXM/I+GdzYCdqCpTEO5MbDpL3CXVua
         SmOAMYQpq4uwW21jKs0uurTmvJfMp58knfaZRan1A6Zb8MIk+DJhdeen1TitCwfE0q/4
         O8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978131; x=1763582931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=arO3innaom8XEOzV6JBZdbg+gJkC7Ox3enKZEFIeZyE=;
        b=iA3N6fcNndRgG+MKtUGHlUfhOgz8o1FbWs5IsAC2F0mNxG1Yzdf4QHzxKw8RJttIR+
         PeqEkCLWOKUmfsEaCCni5LqzLe1Jlk6b4BXuBpd93xIMtWbpGUltE2DJheCW2NDeH4HU
         OG/5qRQFk5UavrlRRjjYJX626ahrVKmqfkN7OYgZCVgSOL9N7OOevQ8UzaGx6ollCuTI
         0V3DYutfhJJsh2OI+eNyknngY7iG1zTCOCP6UDyVkVpRBvx6c2k9vBhJqngeRP1ow7ZM
         kkTuahxus6NfMkcZhdDXlRD6EyFZqjI21ocjjrt1ZxN8qrWUBjzPo6v6Y5RYpDsT9tmb
         xieQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0iBlkiXTm1HkeG1SRp0VJfcsXwzs70rfX4YPpsafRR9ApvLNKNw2p4L/JQdVPRHJcPNAjKlH1jfKN554=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ1b4w3gsutE1ddN7mWy+W2yGXH3ZJWG2DkY5573aEd0mYQ1yd
	hbDPoRyAq89djSwy/xNW4En3AUXEZ5oaN9BSwDXaJ2mO+Z3bwRrkV7jcdOsKoA==
X-Gm-Gg: ASbGncvFpJaUH2kZoLA7/GC+c7lKgNKXPa9mZcGarsjCJdOi+YTCxkf7x1OowyIYElV
	LOPqYVsSUGjYw2vNh+Za1qgP+lzn2B3ZKqK+/UU4LOXuyuoay7O5Y/ewaAF0NOp6+gS2nAu2zcr
	5CLpwW+qjyJu/siCjeF9UfQ7dudM/Mwdij5vi/cXUV9fwGgCapYbte2sQ1FDT6pq9liYFzZhz2C
	MMuDVDmUbMtSTRXYeGEM9dMxvpX4WuAOfkjgxw6dSosdH+9kWC1zjyEN1LmI96vWrOxuRPBCZWJ
	PJVsTM7c7Afn0uDt1u5/LVQOFAnMJAE1r5rjI4j95OD6PXX+VZ+y8nyX3ivbjvwjWaxzhLFjlFN
	hqvYemuSMvQcCiyDD9p4DccorPCUFls8cUwECSF/MoP8abt77tdSRbxJBNmN0ncQMbxwV7+O8RX
	YJnpZKjRqwPbQH
X-Google-Smtp-Source: AGHT+IHXkVLeQmU+R1RNhYpyxag5ZVsaYVozFw1cdOfqrqm8uZqqgBlwBnx8aFYxTtDQsPwukjdAfQ==
X-Received: by 2002:a05:6a20:7288:b0:34a:f63:59dd with SMTP id adf61e73a8af0-3590b826447mr6333583637.51.1762978130558;
        Wed, 12 Nov 2025 12:08:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc326f3e8d6sm115288a12.25.2025.11.12.12.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:08:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 12 Nov 2025 12:08:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Igor Reznichenko <igor@reznichenko.net>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, david.hunter.linux@gmail.com,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v4 1/2] dt-bindings: hwmon: ST TSC1641 power monitor
Message-ID: <1dae4ff3-1b51-4e30-b874-83cb9289efad@roeck-us.net>
References: <20251105201406.1210856-1-igor@reznichenko.net>
 <20251105201406.1210856-2-igor@reznichenko.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105201406.1210856-2-igor@reznichenko.net>

On Wed, Nov 05, 2025 at 12:14:05PM -0800, Igor Reznichenko wrote:
> Add binding for the TSC1641 I2C power monitor.
> 
> Signed-off-by: Igor Reznichenko <igor@reznichenko.net>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter


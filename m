Return-Path: <linux-kernel+bounces-840822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41996BB57FF
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B43D482BB7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D61827A127;
	Thu,  2 Oct 2025 21:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7lplOoU"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4801A9FB5
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759441209; cv=none; b=nLIke3Q5pPj7Ues1ykNZW9aO6b4GtGKLEaQ0PH2+vw6JCnMlsX2yo+p4wP/ZTqn4AG5RmSbYhgg62ZD9Gt59D1POeWdE9XL8+UfBkutyjyQlRRa0dXhfxi3lkU8fHuogmgwEjSWxP77GJpCW/EiQu/CtlggvTo9Tr+hneYS8BT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759441209; c=relaxed/simple;
	bh=QZyjVm+9qlTscaf/2GM3pYF3vTllD4oGUQoj5iijRD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aO+98BM3uDqD1yGiN/Mo8TfCVGIqlHcDUmBSzbLhQq4YlVbA1DG2Kd6IEyW3rORVBB8Q0DNNLgXDGeVnXYgpF2rWY8gUtzZeJhYMisKAsxyUPscnGAzLUB0Eh/s1RtYcJ/kWnw5qeZwjyxj1SP2nA3pmTlzfH6JOs1OlrE8Hy8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7lplOoU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-78115430134so1127896b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759441206; x=1760046006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzvSx/NUfO5A/sP8Sid74JR7vLvHKqFXwTADDrDwvwI=;
        b=B7lplOoU32NtZnBaEcAoUDF7zee/6T7oDovCbzrgfIf+jFb/adJ5olMT9BTv8dO4Q7
         7+ZjsnEtQcdo+5nCblClYC4eaDBXfLIWqtMtkREa1T6WPuHcwitFgWKu7BQ6eNBaGEso
         goXogGxuv4pxjcCI5vBK9gqduy6bkiIFAWw19ClYLUnfBJ+lsVYBYRi644jOV37VOvOC
         NOxYG6ZU5a3WKaR7s2FETmKUvaCBoEeL0juweza6J/hiXRR4KIl1Z6quWy6C7sEsm6d2
         UZgjBiGfmr9C0i23givvd2PNfa+f0zwUxeTSBad5IJfQdGhKuinX1QYDgryvbb517z2u
         aWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759441206; x=1760046006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzvSx/NUfO5A/sP8Sid74JR7vLvHKqFXwTADDrDwvwI=;
        b=B1Wgj9xGW0T2dE1ic2KbYuCkIlIbvliB/D9bGJYdRR9CSOJYvHI+kVfU9d4QSwaxSb
         A4qZZ903B/SVPe4+7WDIBZWlto0x549FkcnSnkDQ1y6I6iko5A9Id4vrXKIqUx10ZoYJ
         6aufXdtpt9ZA6pUS7jp09CMHM77BH3G5r+5I8Y2cmD0JFC40uxeJb3DhkdZLOnmVn6TR
         3SyLGYNZx/bG2F4fZpN/mCNY09aaTvX8HI+ddmf2Iym0W4gi4z4F/MOH597mzMptSp9e
         Y5t3QAmmIXuv4qvDOaaFIfzt5uYqdDtlTPhlc9zk2nPOy6b+JjQov4C7jdgqf6I20d0+
         beow==
X-Forwarded-Encrypted: i=1; AJvYcCWTrQtspSDYQ/GDY8av/OiDPQ2qRHaS8nXabQuyKMQaXFOn4jxrSYvXogyaTVT3D7ctm2Kq/OFcZ/EtsqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq3qmBaXofdre5cBANptm/kcpJANKAdNbgQm6dQhzow8SzWQ1U
	8NKT3QWC5w2NQMrJdSTmwsvFjXQaRlhhy0QvINQtguwnjgoJL/OPG6MR
X-Gm-Gg: ASbGncsjUA9JN6eCJ6NrU4PuRvR0g6TRoHxSxh3hiLiLJZNZDrC20lhe50C00J+zflI
	Q2mCn9mASe2H0wgKhDksx0DPj48tWElJ9shgeRBXZOMVKX0zouiumz+qzVd1x47DXYt1dkIJ34d
	l0ag5KdT1HpnQVrwyOQ1JjvRZGzQ42SJ8Ef+ssAM8e1FfG09R+b0wHCd6asv+V+XvJXzngFvSyZ
	w8RRsuiATVuDTlrBO9aU5XzJzqebetazGgY2O146yJBJ+ziQaml+O6oT+MAHNzHc/uF3sXYMMlv
	VKf+vFutkX4jQZxkZxzbuNQfYGzqtqaafytHW3LQQxJjs4rt+VkcrYomP32Wtb8Zc8OEdobG97O
	wiQnOHnHR6bl6ZIy+hOh5kzqS2r1515SOg1gUt420yxbaf/waC5HL6Du9p6E=
X-Google-Smtp-Source: AGHT+IGk4gvP/gENOkVT6kjl47nctt4XhJQnUfoV6K+YzmVcO1xaHw+ws/N6KwZw6NEFY3MPioctVg==
X-Received: by 2002:a05:6a00:3d16:b0:77e:7302:dbe7 with SMTP id d2e1a72fcca58-78c98cc299fmr1139185b3a.27.1759441205632;
        Thu, 02 Oct 2025 14:40:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02053b77sm3004309b3a.43.2025.10.02.14.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:40:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 2 Oct 2025 14:40:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (pmbus/max34440): add support adpm12200
Message-ID: <c6ec8937-91ae-4e0b-a0dd-183c5b150b2e@roeck-us.net>
References: <20251001-hwmon-next-v1-0-f8ca6a648203@analog.com>
 <20251001-hwmon-next-v1-2-f8ca6a648203@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-hwmon-next-v1-2-f8ca6a648203@analog.com>

On Wed, Oct 01, 2025 at 08:37:08AM +0800, Alexis Czezar Torreno wrote:
> ADPM12200 is a quarter brick DC/DC Power Module. It is a high power
> non-isolated converter capable of delivering regulated 12V with
> continuous power level of 2000W. Uses PMBus.
> 
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>

Applied to hwmon-next.

Thanks,
Guenter


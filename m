Return-Path: <linux-kernel+bounces-899981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 448E0C594F8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FEB54F64E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B087350A04;
	Thu, 13 Nov 2025 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTCvg3wn"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D5626FD9A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055730; cv=none; b=otu7S+K8H44m64aWTxes+nbUf7FrCAWQ9V+tQAwOZtsRxck27A15PT4kYLFfkuQR4ffNLxxcl//CZ94j5rY6RRM70LStj4ufSJP6WAwyfhRrWptewHdqxHKI+eGlx9Is9ihcGXZ3x6DtGx8skHyCkRsLNnrMX6a/N+LpYiwd1QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055730; c=relaxed/simple;
	bh=5k3TYzWX0tli7R5eZBUCXexnSC4WzqvF6TKvLC5ZZe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXRIz1dvaSs8Sh4CTszw8XkjLCviTXkw101c8HcBYV5bRBd5XAEpx6iE2ees0sFARrStG609ZVCPa2Dn098BHtP3fmOhmrNeFHi5h5ibCiTsXarf53EFyildl3+1qoWNsNgHjQAcdDFOwkOmu/kBH7qWALBpg5tLPKWCcYTp8F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTCvg3wn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29845b06dd2so11517615ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763055726; x=1763660526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/YxN0IaaSRtHs4Twn/apCZNadyeY35CF8Eo/Wvzl0o=;
        b=NTCvg3wnt8AXUJH+E5DOQU82RPMFtQ50xmTT0sI9mj2KynQNE5uyhHlUJEcIhoNaxh
         zMZnzgEtiiKhB1jju4BC3bkSTnfOzNDWWktQfJ/wRLwd+/GeKfRHEEf0s7DDUaGnq/gx
         S2bzH2G6ShLnc2DxrspkEN9AcdPR6APlMsoXp7q0EmOchgGTEWGPPDD/npPc43KI4uBn
         wxDo3qAo+9qWmUhl8VPLoCuP+cI/+SPR2QxCMTZOKuRDCzrDW9IXZqFGJMEBE3Weuwx0
         Afo2xUMVyFKvESKcFIB70XYPu0YxBPcIMXB8ZvUbA8c9OLj+MvTdeWjg12VNJ44zvR5x
         zifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763055726; x=1763660526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/YxN0IaaSRtHs4Twn/apCZNadyeY35CF8Eo/Wvzl0o=;
        b=aqgZZ1p8k89AasUidwGtO+l1bn/gtz4lZA9Iwa7MEKakytp0vNMLOSmnVnjTR639Wk
         8yPNjdy7xr1ViyAQlRXXiG9ZSFm1jVGQp41wHUCf8hN2Pkoa4zHloaaQbZQQaH1CdHTv
         C/pSmo8MvIYTVJIk9178++354uSyWHQTrAN+GexL4uNRnW34PI3pF7iVnYTnyFvcXYq6
         KniqEA8BZkFyO7epaQSTsOO+6mcUKCdr9VWBki9GhMj9DvqqNwf44iQu7nfaJuSCHbYU
         PZGBWhvuwyScGAXHs6Z/P3NnGkgEBkGHC3BHjNun14xc/OsMDa2Vp9nMZ6Ti3EgSEsw+
         e+8A==
X-Forwarded-Encrypted: i=1; AJvYcCVXYn+cUUSUUwm20IrkeDkhj+5czCcIWJp0ZufND/OuQhtzKEJXERRQJ20zyZ3PqnWaHu+DijQgexMJHI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgCiWnfinugYFTShraSvLrPLmgUTnY2Jub6FyGziLtUntCHPn6
	cD/NZrcl8VriQVw4EG/BWtmr9RUvWpB3u6wYwveGXq4zEP5o+VGBKRl9
X-Gm-Gg: ASbGncsFwkWgwuELWW73R+qWA33HaL+kVTNCg/TMEVn7FU1G4svhl70NyCV9JoBHFvt
	iQo0XiS1PkfC0c1XP+WIo3mNaNLxLAfSJj+UdHKYB7xS1rxm2OMeGhyPEuy92tTChsCkh6lpVZB
	rN+IDNnp9iYHmkz13a2KHI+3xtBYL14x7cpWYtbANy9Z7H14vUq9k1dceeaDAcCitPJKr9LtNLg
	gdjkHwiSnxRZfG89jcVLl+RAW1IIKarbhxl/Um982C3yL8hi268AR11JiAIFiFEfLIovA5S4Ht5
	wMFOFxO7XHxH31vHoGgCBfrTufMzeoNEWjk6Em4cdltZA/ISlJWhZy71IDrn6YYo9NWznNrxg6M
	GjI1PmsF48RPr0bJ0JM4P5cW3NYBso/6EPDfFp3UwX7qtoC4OxSla2HQoexUdd1zmgtvFizPdb8
	k6x34Ymln5sRCV
X-Google-Smtp-Source: AGHT+IE/pJRY3nngi2DgKMYCqUyhmOWVCR3MREP/oPv+Ub4Rm6wTg7qm8PAbN3zePLKiTi0tm13/bQ==
X-Received: by 2002:a17:903:94e:b0:294:cc1d:e28d with SMTP id d9443c01a7336-2984ed776femr103313625ad.25.1763055726547;
        Thu, 13 Nov 2025 09:42:06 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0d76sm31278425ad.68.2025.11.13.09.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 09:42:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 13 Nov 2025 09:42:05 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Lakshay Piplani <lakshay.piplani@nxp.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	vikash.bansal@nxp.com, priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com
Subject: Re: [PATCH] hwmon: (lm75) Add software-based alarm support for NXP
 P3T1750/P3T1755
Message-ID: <0b7b6086-ec1c-4623-b836-a1450d39b44e@roeck-us.net>
References: <20251113112011.28909-1-lakshay.piplani@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113112011.28909-1-lakshay.piplani@nxp.com>

On Thu, Nov 13, 2025 at 04:50:11PM +0530, Lakshay Piplani wrote:
> NXP P3T1750/P3T1755 does not provide readable alarm/status bits. To support
> the standard tempX_alarm attribute, implement the comparator mode threshold
> checks in the software using THIGH and TLOW registers.
> 

The ABI says "The driver should just reflect the hardware implementation",
which really means that it should not try to implement software based
alarm attributes.

This is in line with all other drivers: We don't try to simulate alarms if
not provided by hardware. The key point here is that the absence of alarm
attributes means that userspace has to poll temperature values to determine
if there is an alarm or not. This gets lost here: As long as the alarm file
is not read, the driver won't report an alarm. Userspace polling on the
alarm attribute (using the poll or epoll system call, or udev events) won't
get notified and miss that an alarm was triggered. This would be much worse
than the current situation.

Granted, many drivers don't implement interrupts and would also not get
notified, but that is a driver limitation and not an argument for
implementing software based alarms.

Guenter


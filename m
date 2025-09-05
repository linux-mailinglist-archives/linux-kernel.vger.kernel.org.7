Return-Path: <linux-kernel+bounces-803788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC78B4653D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0741F1CC207D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FA92EDD65;
	Fri,  5 Sep 2025 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnYF8D7C"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843E2EA493;
	Fri,  5 Sep 2025 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757106695; cv=none; b=c9xU7tDb4WMjS+cf8Vbv3RgOrsB/lsjq3mGSq2wftyzclsHfD5SoSz1izScLUAwTL47k9xlP+MqZwoiHBqggDV0Bdx6DlBvCKQuMYnhNhvBVDsO7bpWSdL2Qd6XQTPl6HNUuNuQBIp8KGORF2umWkTrILgCC5pK4PzZ7jqNW5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757106695; c=relaxed/simple;
	bh=8PkpIInGM85gtbwzO1eVSfzewzaGUuJb7RwTaXh6y2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWdbeVhCt1tukTpYDccybr/y8De1X7YcJjayTGfeSkHKnW3Iu01kbXP4uTEpSNOBXqDKbrRNn2+lRyzahHTrK6YAuI09M6SYKNkW+xc3sAt2Llx1YubqwYMEch2F6PJoe8CAfvuSbLbnHYmKHM0VAy9rYAxdaX/mwQIicnpVg88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnYF8D7C; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7723bf02181so2107916b3a.1;
        Fri, 05 Sep 2025 14:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757106694; x=1757711494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+1Jgx4TsbUDwWMkNtvRRVRf7sFRhVCLbOW+P/LGwSQ=;
        b=SnYF8D7CXO7Qw9BR5YkTAgbrLC+aJuTMYT6zDt5xolCAj8leA8pQtOVBgSYYaut1jv
         tqhzNRFFTcJxvXwKTRmVw1zyi2/gI7PDaqSMeNQmfGWWHRE+ipwNNlS4gxHZyP8G1kAd
         T869CpkX5fO/jCnLnYB/Xn8xIzAeJq14tADkgtUJi6oEA4ueuXDiaHNu1cw+x8CrwSLZ
         MCBArtrYZnPYzZ6OUXleTwb9o10CUFoR34F1HOqkPzCo2RonF9au5WRhILG7MU2yrIHs
         zFZ6Z0op62p1ZOIoJrBXKE7qB8BUxfIMAMgPQy9HUYesbGHuwN+1UcGnlSuGCGQcypGD
         1faA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757106694; x=1757711494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+1Jgx4TsbUDwWMkNtvRRVRf7sFRhVCLbOW+P/LGwSQ=;
        b=c3/3nwPbqKxMhpxxMHDXTVQk8zltZyMx5xUSIEMJPdSNj4pvifQurC9c6BFzUBZL3E
         3VEI6ae5HSTR9EoZ7iXsVPwRXB2QBIk7LXNX9AB7o6/Z3kuhbxqWFUypFQlNfpYAGyLp
         v9DnpS0+JiHLHeIDTRSopVQjxSOtmzuiJMTKX0FtPvvocZiRJj4F0/7HcMcCtprq7BGx
         sjFxjeF4tRH9/Ll0UBJagPda7Wjncepn3ctczP66tOHEajyufdZFFKinkw/HdEQf0SIz
         2nRk+ZfjsQ5yYThU8yCEY7cM7LNR7WywaWRO9OE1b/VXVM4nU2cjTcAuj3GoRbrf23pf
         L/uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUx6xhLKN2AhOrL4O+1GsizxLkhz2/r9/WZOyx8OkYyRSQtlwjNr5HFHwGDPwyMAgkcp04IVJXSB+nl913/3jX0CItfQ==@vger.kernel.org, AJvYcCUhLnp2Zvc53CJUcnbp4kw1WfW1o6AOwgzv0yydoebXxdmnHDIo0MHuwmqYjM0F0rtooHUVA9BQD6T4Qg==@vger.kernel.org, AJvYcCXbtM3pod07R9l4jHkGtwWci+9FhfBs9Ndl+oKtjmkM6zdjoegUe9ojRKRxgwyY0e0BegDEEx6g4QRZc256@vger.kernel.org
X-Gm-Message-State: AOJu0YzD/9UWbnE4g7/TAxeM3HsgQ12DFCBwVtNcpGl8g0aKa16q1tKm
	d945X5BFrIuKJllt/3qJji1zi03OEgzBfw0MBL169pqv3tTxULPwPBYyxEMhJ6VL
X-Gm-Gg: ASbGncvd8siWPDPCtwc8HSegnbv9/Flc2FVt8W1FHOvphgB2SOZxVJf8z7X529XS83k
	hQNRXNZwxe9TyHYKWmywnRq1/2BW8UUqlG+ig88c27k6YZq4nsC/m0PctNKaaDa/etVNR5Kui2Y
	wosGE5SwjT0M0sOdnxpMrS17VXnoxhCIJasTdaVx/n7P3RVtEhhXV1LfdJjXrsD3IT/qw8ThAYj
	5OmlnetPHaxEPWZ88eiWS6eVi88+JCxhM/4wt69izlwXGuml7UXR7OvXILCqsIq60z75SM0evzU
	hg1twMsjWmSSN7oR4ZCz9OChXvrdhWzPA81kFjYSJOhCSHkr7IbOWPiw0Ma8aReqoFNJySeK9LN
	y9eXIA9BLNx67eM7F6ugKd+9NIyzvqfPvKs019UYGtsIoGw==
X-Google-Smtp-Source: AGHT+IFbE1wcQAMT5FctyjRxUPKR3qfGzsN3l79PQislJ6TbLtV8sOiukUHddnAe3/z2lDB8ayZFaA==
X-Received: by 2002:a05:6a00:3d52:b0:772:295b:e6a with SMTP id d2e1a72fcca58-7742ded3993mr144977b3a.31.1757106693547;
        Fri, 05 Sep 2025 14:11:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2dbcsm20670884b3a.50.2025.09.05.14.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 14:11:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 5 Sep 2025 14:11:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Yen-Chi Huang <jesse.huang@portwell.com.tw>
Cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, jay.chen@canonical.com
Subject: Re: [PATCH v4] platform/x86: portwell-ec: Add hwmon support for
 voltage and temperature
Message-ID: <a763c871-55c7-4d7d-a38b-e7b1b325b9a7@roeck-us.net>
References: <a5edf505-9b77-461e-ae8d-510e6ed3f950@portwell.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5edf505-9b77-461e-ae8d-510e6ed3f950@portwell.com.tw>

On Thu, Sep 04, 2025 at 05:29:23PM +0800, Yen-Chi Huang wrote:
> Integrates voltage and temperature monitoring into the driver via the hwmon
> subsystem, enabling standardized reporting via tools like lm-sensors.
> 
> Signed-off-by: Yen-Chi Huang <jesse.huang@portwell.com.tw>
> ---
> 
> This version removes board-specific details such as labels and voltage
> scaling factors. The driver now follows a generic approach, delegating
> customization to userspace (e.g. via sensors.conf in lm-sensors), which
> is the standard and more flexible practice.

FWIW, this reasoning is wrong. sensors.conf is intended to be used for
situations where board specific scaling factors are _not_ known.

Guenter


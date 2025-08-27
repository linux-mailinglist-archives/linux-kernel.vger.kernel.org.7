Return-Path: <linux-kernel+bounces-788612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F2AB3873E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 373E67B7341
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B778130FC17;
	Wed, 27 Aug 2025 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgiYrZ7Y"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF4E21CFE0;
	Wed, 27 Aug 2025 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310491; cv=none; b=VScb/GE6aY/3Q1FTgZkXDTeAnQWDhhVz8noENOkau+hSa7oaJwmL+9TxlSbThF7Igdig4HzAoY6vPgpRIhUiFeNyDUGpH7rPD3xUX1kAqwwBxpjVXoWn7g4UzGnXisxpU60bphcImVD6MD/DkzWOpmer39plAWi7uPUjIcZ4Ygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310491; c=relaxed/simple;
	bh=kp/w6AzZyIB9KT5/NsdRisVgPHsORJ2EnEz+/qXk8S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghnjBMqhJtpFnUlfy3twAa0ibKSwV7224zj3NxXg4iufpWGwG2vFdpT7u6vJ2SPBpe04CuAJ1ynRISrJHYsPq4BggcbO2PkIDEVjZDto7Ryu+gtbskj0jQngY0zl85/y5m6LwkOsdpJ7tsEUY+DFYHP/87OcGqx9xBDs7ZoGxOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgiYrZ7Y; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b476c67c5easo21651a12.0;
        Wed, 27 Aug 2025 09:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310489; x=1756915289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JD7wQoK2zlo2cMxTvwLcG9xLyQPV+uT8cZXA6JqR7rU=;
        b=LgiYrZ7Y/dZKtYIVgsoxP5gh8HNw4sK85NRxRHOm3iC2jK9WMvEFFItL8IuuVAdkbX
         0TyGAUDzJoI7KuKe/rUXbtA4kq0JwA+41zqCZXfJO8kkQyWKdaqhhYoz8zKNdk7/QAC4
         ygPXrbIvpJFlMuc1qzGnB4gK94T/PrLS8pvs4gKd02SA762alb1PGg9uZSRT9ynl/qsO
         2vQ8KJINztHz+HgkRT+Xh52ifKBbg5AMG8EOG99Ie6CiJ+nE5bl7fhzaq9BomCCTJs/D
         Qj84SgIoPwwkWOI12Y4638myqVsNV4kG1pkbdCQaco4GYqfOydl3u2/7sM6PAA2WfEzi
         Gccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310489; x=1756915289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JD7wQoK2zlo2cMxTvwLcG9xLyQPV+uT8cZXA6JqR7rU=;
        b=NKiBtbaLFLDz+zlw9KFsphUyoJoq+RcwaI82msCgNQb+Dhr3AdLaxoZ83KVX6c7CFf
         wlsv+Tg7THBiytuMQ7GOXEJu8tUFEdREbR9NWu5gC6b8mXjwv98xZYQQprXwCK2yiG6Y
         SqHmEPAXyWluJQWj89tsGrCRcwH4pik/+LTtDI9Od3nIMyND/IdxK57Od7PbCwG9geAV
         +p0mp2HRQCjF11LAbQTZZ8w7ltgWf0atgrsWfd6tSlAhcUWFYAgvFP85g461r78GquxC
         hZ1YCw4U2YdPeH9/Yau5EbZFcq90AjQtSQv7QczlE3N/9n5ytjn0hE3L4Sr/T871OBHG
         uAig==
X-Forwarded-Encrypted: i=1; AJvYcCUbXFzrj8I7CfHojlT/jr7AjU1Zk63vcT5+HA7A2JTBB6FwySZ+aZObdULqEUs4V0sjOgdCMVu/wrsVnjss@vger.kernel.org, AJvYcCXH4hBI72xBaGYWlJPv199JNG/LS3k3vkhBL7Y6kLqJB59H5nYVC54MdzgJpjh7w0dFWWh98BnRBdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxibHN1gjHFFTLLDtS5K9IZqrj0y+H/vuqXUe3PHJrhswMqiXie
	8+jsGQoKN8lsy4ZMQV6LeJeN38yLyFkw8nymNIcl9ktuztexUXw0dByk
X-Gm-Gg: ASbGncu/rEBeeiwQlJQFg4YNqupcXd1KCuIgZFaG4htKAcxiCMi7Wmufs+AAIEq5mwl
	tleEskm8JZspg3PM8U6MdIB/n6+gvJ3sjMGgq3XAlo48Lq7uEO+9kJhycEWKgda/8cnwKuiLZiM
	q3ZfOGseEWWupQqPmf0NbT67m+dxbYEuKJw9ZwpZC0l8EVqNoGtD3Jdo0Sx2/ClrJzEm4548AxJ
	+yuBzp6M2qWjSUPYmJY4MZYptrlr3OxHlfb04CnRHfb6rQhiW/F24jGQcbWBhmVaRLAkxCkskTs
	dfpeF9K/UI2/wQRC51Lti5okwyyYJ48c4kxAk4dpyfHWF96+SZWpfG3gvWjUCntTJw5wMC9PHUp
	w1H92lPYZ7k0zsplJnwP9SwU5z+e+gNlwgHs=
X-Google-Smtp-Source: AGHT+IE7rWI5+tEOr/AaeeGYOfydekqn+lfrFNtG7Y3qUq9lE4YzcR5PcMCX+CFbzUYnk3yLn7I1eQ==
X-Received: by 2002:a17:903:11c7:b0:246:d5b3:6303 with SMTP id d9443c01a7336-248753a2961mr75900165ad.5.1756310488801;
        Wed, 27 Aug 2025 09:01:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248cd627e4csm681955ad.81.2025.08.27.09.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:01:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Aug 2025 09:01:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: David Ober <dober6023@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jdelvare@suse.com, corbet@lwn.net,
	dober@lenovo.com, mpearson@lenovo.com
Subject: Re: [PATCH] hwmon:Update EC Chip driver for Lenovo ThinkStation
 motherboards
Message-ID: <0cf48905-f7af-4c8e-b141-07b6a351c6f7@roeck-us.net>
References: <20250807103228.10465-1-dober6023@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807103228.10465-1-dober6023@gmail.com>

On Thu, Aug 07, 2025 at 06:32:28AM -0400, David Ober wrote:
> This fixes differences for the P8 system that was initially set to
> the same thermal values as the P7, also adds in the PSU sensor for
> all of the supported systems
> 
> Signed-off-by: David Ober <dober@lenovo.com>
> Signed-off-by: David Ober <dober6023@gmail.com>

Applied.

Guenter


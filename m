Return-Path: <linux-kernel+bounces-830725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51D1B9A640
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EDD71889AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CD130C347;
	Wed, 24 Sep 2025 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0hVby1x"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694330BF53
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725457; cv=none; b=tsRnOP9wdOjowSiNbeJ6bWQqCkgOOZjvUiflqro9m5iL/RTP1fnnCI3S06Llii28y8ryauakULa6PmN+/sm2aE1Odk8iB5UqRBwIP7E1Qk0Iij2lESggaOeho/r0URZgc8RcOu38Gr6yjGW/jCxJyvl58ZicDnUHo5WfABrySh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725457; c=relaxed/simple;
	bh=E2doqv+YIgNeKi7RQMr6LDDR5lGT+rs7+hyGIA5M7A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=My5Cv+yKQ46s3wpf1KiCvYJyujE2ICSRRgHws9z2ZJW0yqlv1VF9fCXxnXixg7C6b5UwTcJ8jcgzq89Fbtbgrj8MuRMGrXs5DLbO8AKOpfdCTFLiocicojG+0M+ezbMldC0joDuTz1gqHuKhKASM3L/sIsxHXj/hemKKGj9iU2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0hVby1x; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso3726730a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758725454; x=1759330254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9q9CYpyGhg1hg4Blu/O8yok56ehpbIxkjUy+kvImGL0=;
        b=F0hVby1x5B8HURjUj+X4Ko7OqwnXWY49GSHtewi9K+tFjazUADYUJo5E1HQgMxnq+K
         B1lTyIJ5FF/pi6R9kobWMFJcdRo08HHoMjyLMJtpXsXkd67zfYvEutA92+0nniHZPAqx
         /ki1TMyfD2rIGKqK3E03kRwKz2u/iGYUICHyCD8nT/ilneBaTLxQXmUDcRVU98uU5mJq
         /ZypN6baRhw+V0DykAHYAhrldagE+mmxwz6jh6rL3rTIKq05cx49hfiqF2bpCP+dlBNt
         z52cyxh8V7tzqo2RUH6n0q0h7lxxk65HhwE4XXgdQ6GZnvS2v/iWoN9hKxKOBxK/ZvVf
         tFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725454; x=1759330254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9q9CYpyGhg1hg4Blu/O8yok56ehpbIxkjUy+kvImGL0=;
        b=WjGF+i2l66kWtRMtPcDpug4SSbovCN78YEBjGIEGcEF91DJcyGZjXJFuMasiTT67PI
         eZyZy+uwHjQXou2066B3iLVtrGrXCr1LlwI+jGHLpEZtqIMjD3p82yZqqxFcileiDFbB
         lPjOesTSoER9lsYmlqAjWgSIWTF6biN//42UHy5L+dyQLQQ4NrHvJlz5n95n4DnCqRzD
         I94zmiFlxV9T3KYJi73Og21/rvPZGMUvcyO1dmK3sci//3343hcs8kpDhlUXxwDkz3NH
         z6N19ynEtWUXQt07A9wOTjtPr1JM1oUWn6SsNJ/bkgk/mtJ4IIChZNN+8/BzRHk2JB4X
         vIAg==
X-Forwarded-Encrypted: i=1; AJvYcCW2P330Y7oF5S5j1nlqAS+0OGtrE1w033/qDeAWZON4b2KfxKTuDn/OhXUATZQ9lqA6UhHnwHtVf5mmhPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwanfgnCCQTwlXEDODBU2tky+ty9jnk/kJhFckmf1/85r8qhWMX
	zUwuT+gDHYxgzb4epIY3BNHNbY5wm0aNANjfKm7kUOfoBycsUNrAoaJ+
X-Gm-Gg: ASbGncuqhl8A865RARct584LPUjIw0MAyyZNdd1dvwBZoayz6eqTm5riGRkuyabAzGl
	thJYK51LaMFkEqVnUNWcU2yH9OnNIKEOJaZqpZK3DW+qC7p6R/F8UKXX4Kc5rCHhAb7bmLvA4Ia
	urVI/X8uvMI15T3eMBtVQGU7Fa8vd4Uo4LwPiZ/CnxWSl32mIQ1TmbgkHL/4gh/vq6o1zsfNWCA
	RbiHG9q3iyo96JY0Wn4gbwbxuYP3/qUJTAnIMEeu+J02nulCl1DNYSAJA2h7ND+XUtJI8hfMdYy
	UjNH3m1sbPKJ+GKH0C1JLaUQnKaD2z7dIId0MA03BCFUgoe9KAq5EnqgKwJYfODILZ/zXvixpgo
	R/6xoFCZmSuN5K8d6NRtbUaBN9LEiwPYDywo=
X-Google-Smtp-Source: AGHT+IF25nrYcqagXxMo0BGNrEyit1eG8T7Se4hZVxOwI/3BMWGqvLNFos9okM7lRVtT08biWgqFAw==
X-Received: by 2002:a17:90b:3fcc:b0:32e:96b1:fb6e with SMTP id 98e67ed59e1d1-332a95be2fdmr6808900a91.18.1758725454426;
        Wed, 24 Sep 2025 07:50:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bd8b215sm2681128a91.1.2025.09.24.07.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:50:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 07:50:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: pali@kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] hwmon: (dell-smm) Add support for Dell OptiPlex 7040
Message-ID: <af614bc0-3907-4fe4-8a8f-756bcca99e44@roeck-us.net>
References: <20250917181036.10972-1-W_Armin@gmx.de>
 <20250917181036.10972-5-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917181036.10972-5-W_Armin@gmx.de>

On Wed, Sep 17, 2025 at 08:10:36PM +0200, Armin Wolf wrote:
> The Dell OptiPlex 7040 supports the legacy SMM interface for reading
> sensors and performing fan control. Whitelist this machine so that
> this driver loads automatically.
> 
> Closes: https://github.com/Wer-Wolf/i8kutils/issues/15
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied.

Guenter


Return-Path: <linux-kernel+bounces-812825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5292BB53D29
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A0477B9668
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2DD2C15BA;
	Thu, 11 Sep 2025 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FXI+Xw/5"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE4E2C11FC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757622727; cv=none; b=amPUkAdhMETDZl+/fhCL5r2soG3IH62vr8RKnbrsR3rjTNgweVHz0Lfd3UsYjN5nL2B7/OeI7kVFsgcq9Pw7QmJJeM/68KqX0OOZGoPMYflxbWzyCmyUfLc01t11pcBAefIqeaHzd3GGN2V9w8OpHqNAgkExfXoO3ylA55+1xDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757622727; c=relaxed/simple;
	bh=xGbplm2EFCq46y+g87DaF0fkvZ7Ju/EyBEx5dbsOSOI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=HSTIViAztexTPXjWMac3g2+7eT9v0XwfslbRZNGtkeEgAsSjwcbDIEDl5WiFEQw1JYzDw2hTmqwZVsePpifxutF2zZWgzmoR9QWIkVyGDhEJPeVUGUykc8R3k8vxTqjrnxFe2SPz5GvCP5gTrcwLKa+3IAEoL6tkNqRvaGgQhWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FXI+Xw/5; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b5f3e06ba9so26662001cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757622724; x=1758227524; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLrHT/muhR3agQeAEW9CYBXnRqbyoXmg5paEsWlwRiY=;
        b=FXI+Xw/5n8OUnImEMlEMfhvMkJtgQZFBe1PfpA9uXVFzFGyXu8G3KLdr21DQPx7Ysr
         YtlmBQAXz69A+60/svklgAMkt8rn8N68BCGf4dRrRrQxhVQ5HdxReg2VRsKj3w3TBAdK
         cFEOrJ1Ta9huElhsJiarm++CbXey+FL4KJoEwlmd5Az5lM/FYlpREcr8JPXkWVYKdHQu
         fOpprsPcsLgl5i6jeY0bAa0OaBRCLz10HpvhcmLDhFD8a39WM1NDN/la0vlm5wIBc4gs
         USxkk1oQaOOTUDRtCPG0J6dJltO1o++hrh4ydN7R0tCbyK86ZiwnTDaLt8WT7taP5LNL
         aqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757622724; x=1758227524;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FLrHT/muhR3agQeAEW9CYBXnRqbyoXmg5paEsWlwRiY=;
        b=rOU1TmZy5o2orUEWHlFqg0CmdbQVx+PDwqvPZOm1aMvtVeVjrktOjqEbpgEsaeekmk
         p1+elOjL7eXVXPn/3Ej05PnmJ+yy0VU3Fb07xeNi08FrRIgA9QTZDqYlab3Qc/kOnueO
         M8NT81zuiuSPHCDtJebPn/KW/8GMSkOx2c1dINz5yHHoRLuP9buPKrdxUdn42EkHcjJc
         fG85bT4rUu++Rxki6aPbKuvRERItMYkEWp/99BRt3hRE/6lEB4tNple3LSLM9PH82Vf0
         Y1rbDXhPP0K7kpslFEX7fkfMbVJlR+GSQhctWFojfkz5JqUMkG/ywnq6ajWu2b7jDNR9
         bW4w==
X-Forwarded-Encrypted: i=1; AJvYcCVruQg7nlx6cueW5vrpWMo+ZDBnHZMyinMcROxQS1oDbRTR9E/l6sU3Ik/wfaQZMbuqAJugjG9x02zocrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN8xCkMvqKUVCdI8X5mz0IxJValo3MsT4JOZq/9HSSNtzsE4j3
	OOAvA73IIDfEVX4kvy5U8Klss6CfteVitS9Hjq5iQRxb8HkL3zaKGSxMMQAQZxaXOQ==
X-Gm-Gg: ASbGncsSljf2fmxPZpaD/KxWWvBDTNoOZJKgGC+9WfUjab9jCp6o1bv8+9qpz4hSxFy
	Uh1JPOS3wJJwq8embEXG9YkOANygyurpn50+S6Zacw/VT2+3KgU4ms5K5cxQi0pG3+cDSg6hCB5
	rq8c1HEv4wUhj1QezxxJwBpG5+J2P14rChO0a60kyQz1cFc8v0jnEL7ZV+7pWKrv/4NPo7QrhAX
	F9GXWlwJuoUG0hPG/TtDOiL4va004rZ23sH+9I9+8EbsvP90XbSw5Wc06jEbeiCjzbb+VVlY9mI
	FLpPvWo9GdgWXp9YNk1ZvF6PJhsCivM/DUEDJy8O/1A6Z+blPeZEfQUl5Nn3VJvTkgpC6LzFZ1r
	Jtu3y2B/bkhHHWBfAeh+BHubF9KG49FKqXMvHzUvHhCXT1nJ57xBQu3eW6MhHDM3RlFct
X-Google-Smtp-Source: AGHT+IF0l790Z4iNrZheC5yTY8eXGvQyCJA7kmfoAW0vakFuuO0FDwtJ8sg5goWQVYq5/gSOIOCgcA==
X-Received: by 2002:a05:622a:255:b0:4b3:7ec:d22d with SMTP id d75a77b69052e-4b6347e7880mr53485961cf.20.1757622724416;
        Thu, 11 Sep 2025 13:32:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-820cd703f54sm154962685a.37.2025.09.11.13.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 13:32:03 -0700 (PDT)
Date: Thu, 11 Sep 2025 16:32:03 -0400
Message-ID: <684fd2b1e3d47c3e14b74b904f233c57@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250910_1926/pstg-lib:20250910_1926/pstg-pwork:20250910_1926
From: Paul Moore <paul@paul-moore.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] security: CONFIG_LSM: LSM can depend on SECURITY
References: <20250824222800.92263-1-rdunlap@infradead.org>
In-Reply-To: <20250824222800.92263-1-rdunlap@infradead.org>

On Aug 24, 2025 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> When CONFIG_SECURITY is not set, CONFIG_LSM (builtin_lsm_order) does
> not need to be visible and settable since builtin_lsm_order is defined in
> security.o, which is only built when CONFIG_SECURITY=y.
> 
> So make CONFIG_LSM depend on CONFIG_SECURITY.
> 
> Fixes: 13e735c0e953 ("LSM: Introduce CONFIG_LSM")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Kees Cook <kees@kernel.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> 
>  security/Kconfig |    1 +
>  1 file changed, 1 insertion(+)

Merged into lsm/dev, thanks!

--
paul-moore.com


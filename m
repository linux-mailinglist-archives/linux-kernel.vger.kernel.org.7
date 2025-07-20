Return-Path: <linux-kernel+bounces-738294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8122CB0B6DB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E601892853
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCAC21D3EC;
	Sun, 20 Jul 2025 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D9wH9hWG"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98DC46BF
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753027841; cv=none; b=aJJ35bdDQoQKGnUgAk0JQwb0h23nT+xyuNOEyR1sLHHIDaxD5VTssdHDb1cqmphuiHHL2Ml3WWTK189vjTxIqmvkO8UFqF931HKbor6s1M3OYzWh58cpPSENJGu8mq6tz3fBX9S/auPBHQrT9Sj1SydPtidegtJAN8m7/ufucy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753027841; c=relaxed/simple;
	bh=bVAp0IU3/00YQDjsLOmuHxZ/tz93q+fhDOPYiZlJ1Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJGgaBBkuCpauMwABAJdAVw9IBx6cCoKOQpZppkZnjJrowBLMWPLQW4e99AvHnARsZdCjHVrFrshPVISWz4Patf/2+QtruI3zPNUJh/GqJ6OPqUMSjUKnL6vHoKajy5+vg3jug/cezaRVncowXXEoDbhN5OAnEWBDs2dgeJqzdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D9wH9hWG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so578504966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753027836; x=1753632636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pYHbCMzhPyDbLcr9MYka8itslunCze7800jlzrARAhI=;
        b=D9wH9hWGM2RGp6bu50+lGg5DibO8wrQeG5W+A2Nyfi1WAzb0lHcFUVl2VrSRgWMYZC
         uP3fGLMRNZEz9ATuzs4598VcXX/GMrT4omzyWRo3toYQ3jgaRhAD4eVkE5ImPbHI4D4Q
         bxr2XrT8Cc9W0R9BUMl6sV/uMzc1vcxHukG5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753027836; x=1753632636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYHbCMzhPyDbLcr9MYka8itslunCze7800jlzrARAhI=;
        b=spk3kFzRqdFXeLihXcWkfKVEp/PJuKbWWDiLU4Nl+N1UX5T+jDeItlTL3OavawlqYT
         t+EZPcWnTjECveIbw/y2nqYQcW3z/PtNhIPj2aGJordXmBh6PJCxLvFBFJ26pEDD9H3F
         J2RMTpmb97Wco1pHglFkhd8HYBJFXg6gSqahKvzbegyd3Ch5xOL9tTjTTwgmfr2qgsbO
         A54ICDganeLTlSKeXwMXp7cA17TmheRF4yEi41tHMdg4wztO9zdI1G/w8MO2DiB0BHJS
         nRijZUJ2IHh8iU10xrom2axNOiern+oAvOkp8n1GV8FNO26EnavlKd3AnkK+Ro6c7Xqf
         Ykrw==
X-Forwarded-Encrypted: i=1; AJvYcCVuaUNDQ8v+yRKPm6UReQAXYkf67TQ3GIo6udifun+gbSvWutHuCOwVy1Gebngbs2/rJF6T1M9QtkJibSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDbAjGKnQSUzJQJG/83JjmB80U1l5DT8n2OQUF068TtciQfvZp
	X78C7KtNA4m+PXA2jHUPrjO7ckdJUWIG5dZTVvINgtmBi9P/PlPf9HGhfjCESnO8xh5JGeHzEbv
	FABx9Kn0=
X-Gm-Gg: ASbGncvN47plPETc9Jg7rW7hbwVBw5UvZ8ZjWLCZi6hKmmIPvaxzkJ259phY4ydJw6e
	tMoMEtLsgzV2ADqn2O4MJ+UIu9bmH1xyVYSziUF4t8nW2Duhmp4ruucjk9pRZKePiL/4sllpcms
	upGSw/rmhSnmGY4hJxe53VrlhKCJ8qUDmC0+URRnCSc7+ahLGNICVvlZjhDY8r9ftxSNxmImxmL
	QV9ByMevrnYKUvs2Y9Zt1+kK+MmNSs0Yo4ZGFXsCvvPI9XwcY+a3rVluQX1Akn4+WUYdZJwldHr
	R0TudYgtHn0lZDRnkjzfFUvjSbY3lVXCsirThnanS2uIP5u6u5H+CoVXZ4Waf4gzsqCMaSl7veA
	jOTNMx7nxXCZN1LTGS7QJXUANrwrVue3xzEruHJBWtcYh9S8pEfAA3eLCnYB4bbP4ExZTwmXq
X-Google-Smtp-Source: AGHT+IHhSDEz3GBJUvHttJGtGA9PXFIrhFD28opCWvSI4iTRQRsiVy4vYrH7BxjasOBIoWttZot0Pw==
X-Received: by 2002:a17:907:2da8:b0:aec:65de:5258 with SMTP id a640c23a62f3a-aec65de6484mr1059238166b.3.1753027835840;
        Sun, 20 Jul 2025 09:10:35 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca2efc1sm514909066b.83.2025.07.20.09.10.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 09:10:34 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso6361915a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 09:10:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUExydhGFh/ubU2UFyoqxURQfV+Ee/+ngDRyNEn53Ye50pWGh3MVRVgcQuBG3dWhwG10nOK3F7sLFaPaAI=@vger.kernel.org
X-Received: by 2002:a05:6402:34cb:b0:612:ce45:3bfc with SMTP id
 4fb4d7f45d1cf-612ce4541aemr7255900a12.29.1753027834053; Sun, 20 Jul 2025
 09:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aHzI-b5Kiy_Nu6l-@kroah.com>
In-Reply-To: <aHzI-b5Kiy_Nu6l-@kroah.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 20 Jul 2025 09:10:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whOueEyfgYxgQzZvRra5dcT3TwEFAtkWmq7HJvj50PR6g@mail.gmail.com>
X-Gm-Features: Ac12FXwsjW5_eeHN_yjI-9WypTAQJPiouaWDrvrUwg516x3pBMOHzGoUiYl7k-0
Message-ID: <CAHk-=whOueEyfgYxgQzZvRra5dcT3TwEFAtkWmq7HJvj50PR6g@mail.gmail.com>
Subject: Re: [GIT PULL] Staging driver fixes for 6.16-rc6
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sun, 20 Jul 2025 at 03:46, Greg KH <gregkh@linuxfoundation.org> wrote:
>
>   - change to prevent a research leak

Auto-incorrect strikes again, lol.

           Linus


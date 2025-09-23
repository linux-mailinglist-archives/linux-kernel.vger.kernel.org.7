Return-Path: <linux-kernel+bounces-829571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17070B975E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8BB7B64A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3153019B9;
	Tue, 23 Sep 2025 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLS/7CJ2"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6648C2FB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656181; cv=none; b=PvBGqzmZzEmaxithasJ5iUNjOOV6QQOq9bhZW0BKXUHSnIqavOXjdAXgpbfkqZkePUO2cfRWV/YF/LT9E3Tdv293U3WVCVqswn0b/3tyvmXQh9JT7HjDKmlR+bRkb+pbBACBuNQHxA0tAa4dEzJzQ+Cwma/vFWz0orQ1wNZNa3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656181; c=relaxed/simple;
	bh=c3tHz3xkrAjXnLneXRnB/HG4W7YEuKrsOFMkwG9NOlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rgx6y95kfndJOIdKah22iPiVeBxfq3n2H2Zqd2gn8UYgVt4zMEUeGXxE83kStscSrpsAS0xN+f1uJyEB8DW9TrkfSFRT8bhV1MGhbOPHxxkzIfNwRI5gQQ+FDHp5hddiOG9rG0uyTSuYP1cyr7Qk/ER4XEIsy/JmaNT8qQxZtX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLS/7CJ2; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso3500358f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758656178; x=1759260978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1T4a0b30RkSl2NcIpe0lwjzr86jO2vZlKX0MUfW14x4=;
        b=dLS/7CJ2LKQZDa1BZFXiEuPRhxeXqgefHMgC9HFrxaHtxm22GjakbXqbw4VtOO8kUH
         CmIs5L8RkDCy2fQS9nrCpeVTtsp3OpZjHll4shDweygfAt7/Zh9tYYGePJJp5oC4xVyf
         sQrBEbxvOZif7EzPF+aWRenIDlfU1wOlPsnvOlQf7q8CGjAQUacDQ5QLva1UcPn4n8Sa
         evpWJajmQMyXr3Kw0C+VKRgAJ9wqHQ/xrmCl/ENFvhdcih036ryFD2hb85ZUiXb0Xo90
         g8gIOsCRSCsqYxqH0OW8uHzJFsl40J4b+rwiVPuvaCIUDzqdTQzBisUz0CmnX1V3ddVg
         F0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758656178; x=1759260978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1T4a0b30RkSl2NcIpe0lwjzr86jO2vZlKX0MUfW14x4=;
        b=QzVydeM0g+szYAPFsQGnxm4dPBihUWf00ieusz8qirQHZ6/o90JINt1yz1IZWuWHS2
         KPtvZRKmytOLj+KdDcNlhaSyofyt33i5j3URdRNJAVvkiPtlUQ4JCLjq8IKySnKVdGnU
         FLxbEu3I5ylw5gFCjZOajTPHxHo4t3/v78PKH/uBKkOSCYnXX9VyP8I+zk5M5WlHi9Ty
         nAp8fvPZoYdlSh0XZo7uJlEdHt1dCJQi4NyqJNoY0AVkGpT7Gu81Or2/HB3RxOI8gpBx
         O4Y+bLXqSQlvrfYVIIwnul+iefgwTBzNHCZE4ifXWdmpWtlLiDbkyOvxp4ctAnguKUdv
         ysOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0HoCYMR53UYI/+HaBzLQiJatyEFbSdQJFc623QKebj/2qpuWexPHgcyoTVWYAqDEcDqL3S/GxH0ESGUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytO0/sI1Nosy6Z3YyWCVLt7/LDOrGd/AhqDMu+/13iGpJankzm
	UUBZcPjesMau5HkBf2ZiDHEE6YBNgCcGrqaFbkv4x9NFNHODlneo3Cry
X-Gm-Gg: ASbGncveYT3bvPesAlKbfNMCRC/JS36K99xH5mS3qPD3QTl+Qy6llbpzJx/3eAhrvlo
	oENb6KKXpBtC/887Rkt67QvGh/kuyZmHKO0aHOMlVkI2jvlCc/WcaOBxCkTCvZZAV8D1fAjqZR9
	aBz1bdciCLoItRf4p3m/XYwGcjCi781hzfixnIMdKKriLT4IKJfoGbZRRq9yJTH88Z4bzOcLMYl
	R0E6utfkm0l8lSZUvBdu2Pi4G1qCxHeCRqPoSZ8Mthr/jtoQjOzn/W5c2XjIMeyOkwvq0h+ai/D
	5lwTrry9IWHSLG9OrU/m52GdnJWIWcTBLC0MgH8dMCKosarAnngfdRlQCg8MzbaLVZC3fkURXS4
	qXKAsiWwPKHycmQMpoSA=
X-Google-Smtp-Source: AGHT+IG6c6liV4ES0cNIrz92wbRM89A4so/bGcUTAzztWwZQiXZipp0oMWflG0SI8mHTbJhLxZ8nGg==
X-Received: by 2002:a05:6000:615:b0:3ec:de3c:c56 with SMTP id ffacd0b85a97d-405c5cccfbemr2973528f8f.16.1758656177916;
        Tue, 23 Sep 2025 12:36:17 -0700 (PDT)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbfedd6sm25526397f8f.60.2025.09.23.12.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:36:17 -0700 (PDT)
Date: Tue, 23 Sep 2025 20:36:15 +0100
From: Andre Carvalho <asantostc@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] netconsole: resume previously
 deactivated target
Message-ID: <fasu2sp2g65b4kslaj4khckmjhaocqqbloqraaqhzmuvdotjvl@swdgrbci7jft>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
 <20250921-netcons-retrigger-v2-5-a0e84006237f@gmail.com>
 <20250922165057.70eefc6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922165057.70eefc6b@kernel.org>

Hi Jakub,

On Mon, Sep 22, 2025 at 04:50:57PM -0700, Jakub Kicinski wrote:
> This gets hit in the selftest you're adding so please triple check 
> the kernel config that you're testing with.

Sorry for the silly mistake. I'll make sure to adjust my local testing to
include running all selftests with kernel/configs/debug.config to catch these
before sending the patches.


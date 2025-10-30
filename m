Return-Path: <linux-kernel+bounces-879128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A0DC22546
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE2EC4F257A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59DC33BBD4;
	Thu, 30 Oct 2025 20:39:50 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F67332EBF
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761856790; cv=none; b=Pr3AE/OeN+xmVZz67do0/7yFLyKoNoU3x21fcFU3Ko+05glnG700QQ57fcAWmiwqxcZH68i04y4Q+1Im7+AQNMn5OGODy4OpvGS0gv2HkxfSRQN+TXWoDE5/S+xhm2sCSxRcQmrTHN8ewgKSE7TVtsas05LUm6AnNAR/eaA+NFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761856790; c=relaxed/simple;
	bh=0cBBzExnjk2NDYJtxl4UIBoOwn7f/ao+YK29yiad3aY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lXdoyovkV99wlnIvBduKFJCZyrcZAabxGLdzVp7qF9ZmQWGXp4QyP4fduGxbVbzv9/Kh888jQK26bomNNZJGCnszYC2FCVn9lDbNpSwneFRgKRkF2MvUhLnjsVo4sjXGXxWQ7/lDMlP1q1zXXFrEZyOGjC2v28X9lTsOS+gr6/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a2754a7f6aso2125371b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761856787; x=1762461587;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cBBzExnjk2NDYJtxl4UIBoOwn7f/ao+YK29yiad3aY=;
        b=nWOIAr7vmZG4KjeeZ03TOCVAHE/BrJm9mQ9+pOTctfmqZEixYvc4cid7dunobk95xN
         0RreQkAu8taR0tIwdyYz/ad2PLFZRUxsMfBeik1kv3TLN0drluHpcn4MH+7Xr9VLyqNu
         gWsabdAsArjKcCjzvKo2cYfXrb3GbHkMXb7frRExWfQikUX8hAMceaPxdYJqG4rCK4Zi
         n29QGGkYmj2dLhLVXE9oIrrZElrlsSsp63Hi5goG2+5Nyb0nyQCS5OSJu9tLR6yeVza4
         zj/i1s45EYtQZY/K9QwOCYD3J4WZie5WHghv2AzJxMuXQKmNUE3cyk8HW3JUcNrxEW3S
         6PbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqpyU4gTS6YASR/FnI+o6DeE/sj6aBhEWhnisiLf3jbJOXW/SgRqTui7frN0oml0fxQqYyIIdk5KuaVyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzezo8pQvzTd8j/70nBGSuGyPaxQOh5qTF1KcK7JinhpUGXc0Mb
	oTvSvg88jpAd5tYKNCj3qIX7e3dn1Rd80dQu+s3iZVoos6r36RfWOmwz9MulQRQV1fU=
X-Gm-Gg: ASbGnculvW2MfgCx4qRGTqW31nMeM2j/LSSa8OZ6z1pbgczntDYlOpH1gdOjY7H3Npz
	wX81GSlNCz7eD3HoFAsXoeEA8kodNMfDNXu8wXaHfeUIbLfbm8GBK9cYIXs1Wg8cSCaQHA6hPuA
	2svqip9YccfLl3j29EPu+kVio+OcrMpWN5P+Z8unMsUnypxa8JIwf0Z+XJSpLyyUMhU78xavY/t
	XTYLJsNFm0oXtbRhEwolGW80y1n7k4Elx9TN6l9Rsk9YgE3+rL42qUGacf4LxClxXU4au2usHOE
	E0a3CKmkpRyj8Al79+zhIqYbPo/gVTtO0R7h87mRddD/my2xUBUer10KeViAISMovmumFXoEk4j
	0YqYV1jaN/hiayIBleUEJ5RKMpXnAsIDtsVg0HGByN43ZZm+4U49PELWooRk0PfBiElja7V4FCg
	==
X-Google-Smtp-Source: AGHT+IHNUhWGQ9QtbTuE49gdeDk8GHmdw85Ojnz2Oym2D5PVu1wHgl1Z6t3McBnk2N0znORSiSVtlA==
X-Received: by 2002:a05:6a20:1583:b0:2df:8271:f08d with SMTP id adf61e73a8af0-348ca24f710mr1429132637.2.1761856787576;
        Thu, 30 Oct 2025 13:39:47 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012d02sm20249056b3a.4.2025.10.30.13.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 13:39:47 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>, Nishanth Menon
 <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
 <ssantosh@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Udit Kumar <u-kumar1@ti.com>, Prasanth
 Mantena <p-mantena@ti.com>, Abhash Kumar <a-kumar2@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
Subject: Re: [PATCH] firmware: ti_sci: set IO Isolation only if the firmware
 is capable
In-Reply-To: <20251014-ti-sci-io-isolation-v1-1-67c7ce5d1b63@bootlin.com>
References: <20251014-ti-sci-io-isolation-v1-1-67c7ce5d1b63@bootlin.com>
Date: Thu, 30 Oct 2025 13:39:46 -0700
Message-ID: <7hsef0jf8t.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Thomas Richard (TI.com)" <thomas.richard@bootlin.com> writes:

> Add the IO_ISOLATION firmware capability, and set IO Isolation during
> suspend only if the firmware is capable.
>
> Fixes: ec24643bdd62 ("firmware: ti_sci: Add system suspend and resume call")
> Signed-off-by: Thomas Richard (TI.com) <thomas.richard@bootlin.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>



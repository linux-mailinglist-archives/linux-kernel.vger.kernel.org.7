Return-Path: <linux-kernel+bounces-731372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D22AB0534E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6ADA1882936
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5A22550CF;
	Tue, 15 Jul 2025 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mf+5vKaN"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE9319F424
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752564744; cv=none; b=hdbeZ0EQE8egAVaLLqGm0NOcE6IQsd/LHG6WH9Lp8gRUrYD+bqxsU3t/G9yhwcF/84sTmbi5FQPmkIu8Swisot/6jgocE5E5o1WgcIfUs8Tb9YKXcpVjco9c5AbewJCKG6MlF03jCs3mF+cz5E2r4FC3bMdqYMlQl56C0Z2oxtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752564744; c=relaxed/simple;
	bh=AQI7WIRMYNt/4EZ5nzKNC1IP8ShZMqu9MRHeFyVjitY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S6IrMZnN47qmN23TI4ySyaPjNn+LVgGUesLo4jWxw4aXKGpQ4QchwuHnl2kUqhAR0kqijNb8nY7FX1vFxyvjoTC7iaNiJLgjzPbRB9LNiso/j5tzz/y7i1TrYgvZl/Ah/EE7PT9JKjYIamUaQI8SXpKFQS8Tpy4Pp0QVKGH4pKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mf+5vKaN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4561dbbcc7eso5824025e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752564741; x=1753169541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X68YX07eae1/4EfsXJ1GkFNS6uv28k2b/ggRrnGNIsg=;
        b=mf+5vKaNvivlyEcpqHqrQJ6bEgeaM2sC5XN1jeXKfqU9fNnSeBMHJJPUwrx5QWgOcS
         YjajcfAZT/tmAHmpaZtZwd8YbOzxVco/kWdNHRz2yd0u3NYtdu+GZZ7zMeO/elEWsOaO
         cEhKrR2dHa2Ym28rOZoHcfQyQmiN2uWinwvjR4Kbtp4nYcd1h8XwFIQlad7y8OHQYnle
         Q/ncqj+JuCRLgEqXLA8U+FNtDQ1utuGqd7Xqmrmvd191jty+4UB2aVrsIvopQj059mVS
         697uwPXNAh0/tQJ+/CeRA1i4br6V1Vymn5QUB6/DRtJSVw8x58cjDV5IGpRx47C7RiFI
         rIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752564741; x=1753169541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X68YX07eae1/4EfsXJ1GkFNS6uv28k2b/ggRrnGNIsg=;
        b=hpb6v5PRk0Quf0MinlfTsjkXA0pnaaG48yVc5SDD0ABCNQmuOcgOJq+YkxxZxRbf3o
         QrWt+CZ2/uRGNYb/IdSgqpjCN8+meEpgljmlh1/8Aoc1JQeiymhinlz4S+4xUtpxXvbf
         7Fm09hC2wZ8rRPp8RN0IVwJQnxqfOf/YxI0Ry0GNpd1DOO1FQbPKxZ80kdH+apRoAnLH
         x3j0Cgmgq1E06GLK+wBmL3MCeWj3rjSWP413eFAvF0F1Z5A77guAsOCUCf6x3nhXKYVW
         epjqFJy36PfL1GSbfAAooCSLYBfEKH2Ie40lzFpsYyVK7BTxg4BsMnOaGnJjc40wPAEY
         6xhA==
X-Forwarded-Encrypted: i=1; AJvYcCWC/op9zHyuDsC5LmgBRrvRYR4jVsTzfWP0ABMdSS6JAOWFCY18UmgQamP7WhLYjWp6/q1Aw6Ea6GvcMKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVdj7T9DJWSffDrjlV51pz2H6BuW5dPQnr88OsPPN/2FG1nsgL
	Z75EwQKfxNWAhSa9wCJGU6vR5757VH5aqaNJz+wfF59YV09CE5ONHjV/5xskW3aft1j/d5wLrPe
	SoIpSojWmRkatmRSfpw==
X-Google-Smtp-Source: AGHT+IHMkQPaHgTPXBRPgVQUD1ZCrdyGsg7R8UpVM67Ki6uC+YPEneTBz42RdbNf5nY7zfnn6ZDy3Ga5P7Wp9lE=
X-Received: from wmbay38.prod.google.com ([2002:a05:600c:1e26:b0:456:214c:845d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d87:b0:456:2a9:f815 with SMTP id 5b1f17b1804b1-45602a9fbfcmr96110325e9.4.1752564740812;
 Tue, 15 Jul 2025 00:32:20 -0700 (PDT)
Date: Tue, 15 Jul 2025 07:32:18 +0000
In-Reply-To: <20250626073054.7706-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626073054.7706-1-dmantipov@yandex.ru>
Message-ID: <aHYEAjCuRVxwv8X-@google.com>
Subject: Re: [PATCH 1/2] binder: use kstrdup() in binderfs_binder_device_create()
From: Alice Ryhl <aliceryhl@google.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Carlos Llamas <cmllamas@google.com>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	"Tiffany Y . Yang" <ynaffit@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Jun 26, 2025 at 10:30:53AM +0300, Dmitry Antipov wrote:
> In 'binderfs_binder_device_create()', use 'kstrdup()' to copy the
> newly created device's name, thus making the former a bit simpler.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


Return-Path: <linux-kernel+bounces-892457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 193DDC45222
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 075D64E80D9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4222E9733;
	Mon, 10 Nov 2025 06:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Br9zEjbq"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D652E8B95
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757670; cv=none; b=f1ccUFIhUtMFPR+AeIfL3/IdhwaNhWBPPQbQXkH8LcofD5UV+0Uxve07dh8UAIYGI3WyysBrIeR61x+xTqbtZzh9jrv3Hh5CEq94PVi5pzhRdmlkfyRDESfXFK1E2qnn1PMJj2oSUq5dkIHkERE471ryP1EB4gNZ3LBD8+7VLfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757670; c=relaxed/simple;
	bh=U27FR47vvI/+sK8vvk3aBB/np16WyOGQoW5cBKa4vNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjwwimwNbVpgDcdPVtIIfHIBzQyAI4Ff0cLvomKX1ge0VApOz9p5Lap6yp0IhlNivTX+urEq8/Noix8mPw8YhxyER3QC4B5IjP1U468U3b6KH/6xM3+1DmkmI4UsJnotaawXQ9d1k7QEZf6SOX1yLCaTgIpwRiaXOvwCL5kdhjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Br9zEjbq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b32a5494dso465033f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 22:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762757667; x=1763362467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U27FR47vvI/+sK8vvk3aBB/np16WyOGQoW5cBKa4vNk=;
        b=Br9zEjbqG1VIXlTjsll9fsBldskDLAfNTuV9+BN4Ca7+rWfLJnxMPdqRYYoqX7aUld
         NihjEnrIk33vgYwHLVan4cBbh6YfThM+ToKjZB+HHhR6+l6XW9JmQtcIEYxlzNmA8Rci
         1QwQMgbvIE5GTs3iBPJ22QryrygoB2ZZcNYgKp8Hfc+0naI0PhCOdkBq3Hsvfi16qtH3
         MQjnBZa87Be3wg5tHSGbgwCq3rNt5ycRf/w6mxRcbhQ1oH5nnceIh83GdvQn093ZA2nH
         DsGEUHVKcK4QDVdWNagUX6d8EF1psPQUDATNQjRcCwgP3DkB84gHT5M+yT2z9qlU1MyE
         wdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757667; x=1763362467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U27FR47vvI/+sK8vvk3aBB/np16WyOGQoW5cBKa4vNk=;
        b=qCNA0VdEJrvnWSrjj8+w6lrd6b5e9YMnW5aW86r5TNmrgfpaIGDsZs7UniYfXIcplU
         l1iLYhO+FjLFuJThnOm8DX+GafUFxwxzs1q64Smx7k9Ja2P39NLQ9mkKnn0XFmN6ZFiM
         X42YPjxe7IeUeyD9zzVqg2JsflfUBaNY2EvbTeL59VV89++FZmCNbsDdDnVpGpK0RB77
         lHbXt/g0UnaXMsVsErluFGaQhrSK4wPnq8e3JYFVDltfLJBuB9cyTB7m/5jsWuRa6gLa
         +7OWYi9Ye4hClN67wXW56Y/UEa6QRO6bYvgiNcReMFd0/a3vIlxjig+EHrxWhTONV98n
         UbjA==
X-Forwarded-Encrypted: i=1; AJvYcCU99Fa6T1jAPQrmljxMqTzglmNQ5B2EPy8JdmjAxpLODtwx/JufnaLPX1TE+A6GsUQmDFFRG5ZxAhSh1+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YydTmkPykfb2P43qqXCQMGWJQs7yjC3ALBY0ZqqaokbpyRE6Y4v
	MSA7rTzORZ3NK5Esh4GzupeOmptFfk1HgRpQM+12o5QM3qChxRvWcp0k/BeHjgB/Lz0=
X-Gm-Gg: ASbGncvK/2OKZkcKX2wKb/HuHYv3CrILDD8qoO0nCqu0nzjOOaeRDiA/LnHaH9V9Ca0
	0n9EhmbSHGBCgJ7JJGDe/+ogOLqUF4/T7o9avTQpqXwr7MyOgpDhmpBgb4Qh/CaUt0MbGD7OQy+
	T4PXHk67BDpn2aEUoyGWnWGHK4GWBNTioHN4Ys85fj1pQ/v08ojNwezzQCYvfK/nxwoR5XPkftB
	Yv8lvj6Nzov+BPPp6nmXIKZlJDHnuhbLY04ekcsOn0Xp4fIxPqh/8kdhuKj9AoGVBTHGuXzjL+H
	M6p7pe0qvFoaIS/CgekjCs0HpATAkqhcM6uu+4t/iTxvDrDp9AP7ci1Jz0uRX6ALz2bDRAZpoAv
	1Kr7EStVK4LQw0UhuGt1PSWp5f7NqvzhN/0QrfkPtDIQKx26Y6N5Oq3xe2RwuVVa/1p2+S51QqQ
	ugT7hgq5b1polpokB/
X-Google-Smtp-Source: AGHT+IG87FW8xkI+HPhFc3NsIT1cI0tR3t1R9dpEVJouEeUSbLV2nxEXO/MYUxjy/6jIyUp7TqvHtw==
X-Received: by 2002:a05:6000:2a0c:b0:42b:3ee9:4772 with SMTP id ffacd0b85a97d-42b3ee96373mr151631f8f.52.1762757667400;
        Sun, 09 Nov 2025 22:54:27 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm19848370f8f.35.2025.11.09.22.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 22:54:26 -0800 (PST)
Message-ID: <c67466c0-c133-4fac-82d5-b412693f9d30@linaro.org>
Date: Mon, 10 Nov 2025 08:54:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Hello,
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Sean Anderson <sean.anderson@linux.dev>
References: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Miquel,

On 11/5/25 7:26 PM, Miquel Raynal wrote:
> Here is a series adding support for 6 Winbond SPI NOR chips. Describing
> these chips is needed otherwise the block protection feature is not
> available. Everything else looks fine otherwise.

I'm glad to see this, you're an locking expert now :). Do you care to
extend the SPI NOR testing requirements [1] with steps on how to test the
locking? There's some testing proposed at [2], would you please check and
review it?

Thanks!
ta

[1] https://docs.kernel.org/driver-api/mtd/spi-nor.html#minimum-testing-requirements
[2] https://lore.kernel.org/linux-mtd/92e99a96-5582-48a5-a4f9-e9b33fcff171@linux.dev/


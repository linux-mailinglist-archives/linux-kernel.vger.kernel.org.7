Return-Path: <linux-kernel+bounces-797558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEEDB411E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E785546753
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F80A1E412A;
	Wed,  3 Sep 2025 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OrRc3EKj"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECAF1DA60F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756862460; cv=none; b=XgZu8IATPBICtiHzu/1ZhL4cxKEvXLZsfAKzoILBVqDLiqlLvcph2ZUB2UTjhutSZkrlpiP5FUsgumyo/KZjFkel9pCrXEqWpbkiz9j3n+g/AyVA6UU+fEHzJ6GebGNRh2iqGdzAdlFt0twhIjM2lvVJ1RLZ21VlZASfa+bjhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756862460; c=relaxed/simple;
	bh=fmNcwoVhmtA3sUlBlhDFCfMAovsp+XeyfaidR5mbMq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5qcvRFx4tEz7NsyMj7oXs6HxAUfYeJ3VA66ZbD/eigkV+NdRS417sk2HSvDlVbmqqcHDUHUAfk76fbXozyKFeeZPfR/0Dw7/GdSvxFKNMdQJQzg5P0HOp4ddmI/y4IzuYKKoMkOtGgmOcAe5Mj4Qp7uRzvR4kEOl9vUWrLrbZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OrRc3EKj; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-88428b19ea9so23302239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 18:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756862457; x=1757467257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lH27iUhjx48DOCWLoiAo/kj62nUk3VhPaNmQ4WFivsw=;
        b=OrRc3EKj9QrU/2fhNmyT7fvWbbp7cS6kEAzkoaOy3T4sE4etQGiddQonCn0fL6xUnD
         XALYLT4+bfQfaMzT852em83xC4ZvPQqVMxSs8fWoQi8wqQjZcppV+Cu/NElsNVqeStt9
         9YWTpUAIzHrqnpOPgGPBz5Yr5wBphQgreH1qaP74ybB57SJnOcI53j37XwKQGMamcW/8
         g8oLOjUGYbpLAHrKi/soqEqnDniqqHFkuK/6gbBjrnR/Fx/J+HtasFovQf95KXm0yRBN
         kd9ZXt1WBbZnxDzo8T13PDquvS4D9CEMEdQ7KzQ0HKUzswbry/oGTK24SAV3qY9RW1in
         2/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756862457; x=1757467257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lH27iUhjx48DOCWLoiAo/kj62nUk3VhPaNmQ4WFivsw=;
        b=RJFWsieledl2abjMcM2ByMRfbdMcpxoPTxLD+KflqjoS2GoV/CEepQvLmUHRQJcjX3
         iXv5T3RY5B8gMYQBJXlv5mtrR1SgaHSj3hEvp+PMs8HFRG+r1RIXn5hqtEqAHRC5Dxez
         sLPG7PGPnwnhzlPOtTxj9cVxEpmtjdyqngW0qhuoxMYyYq/Ch7DQuXmx+hmJPY4Q69Zh
         h5FkWT1IPXu/f3NPUeqQAc5Cu7zDykN0evU8MG62eMgGa5odA1AvkhgtyL8DW1OSriQa
         T7Y1F4VCOenlXZJ1Vi0wxpmekYRd4XtqRl03YTwjyvJ0KvfiLm3CFNU91ln0yV1ixbf3
         1Yhg==
X-Forwarded-Encrypted: i=1; AJvYcCUvymDyEwhpfq1COrr9bVNQGZw9Y7T7M6+f9XyU145/iNZVbbqtESAMP8sZ8pPBd8wcxZZQ1zcqV/DyQTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY3PmaGF4OaOpHY72hgtODvKyw2wVRHD3llvb5PLguNf05ZGNw
	wdMgrJYDoHMqAcF6EyTb1zGz9h+CpQmdUU+QI7m6h4nNexqOHbjdjy98kfPKghPK2onZSwaRJsr
	cBu5t
X-Gm-Gg: ASbGnctf5TLbRMFd9kcpUETvwUFt+yQtmhE911u1jSxXrho2sAK25r4SYyOIyKYohvf
	kCJ2gO16dhe6fAljJg1U1/KUXUrG6ousBCbiT1MEnHoSJm8we0JUcUcs5Q/QDw5MQyf/tAjWDL0
	wdncRnK294FmcYtaCHPS2ZwuEm9bl6KonxPxu3MqEGtIVSawjjnuYyJwCI3zCrhSUduTciRPyDz
	oxEeDOOMsCnlbJYICegPFXXtJ5sgdPksCqJzqzrpEulNmb96t8Iuc74ojIs1G66emYGHsgww954
	mVomTEoZ+CFV3JSXlofZ2UMlFGm8v/ggnS8HidqZcAtebSsvzRspnSqXeCfIz/W4ujoSPzhKDR1
	IyYEw+ul+GYR+j57gmRex3ybQkQjcvESEiq4PZ8JEIy4mmJCYw36Fv+Sz
X-Google-Smtp-Source: AGHT+IHitIUUJVqzMKK8HpEQxgzwcYn/ZPrwZ6tD/9BkJMLk1eySpeUhvSyzB6hNahMhajjG+WgHng==
X-Received: by 2002:a05:6602:4006:b0:881:980d:ce93 with SMTP id ca18e2360f4ac-8871df0bfcamr2982560139f.2.1756862456737;
        Tue, 02 Sep 2025 18:20:56 -0700 (PDT)
Received: from [10.11.35.62] (syn-047-044-098-030.biz.spectrum.com. [47.44.98.30])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ecafdfcecsm3078890173.33.2025.09.02.18.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 18:20:56 -0700 (PDT)
Message-ID: <28b5e071-70f2-4f46-86af-11879be0f2a4@kernel.dk>
Date: Tue, 2 Sep 2025 19:20:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: remove WRITE_ONCE() in io_uring_create()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250902215144.1925256-1-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250902215144.1925256-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 3:51 PM, Caleb Sander Mateos wrote:
> There's no need to use WRITE_ONCE() to set ctx->submitter_task in
> io_uring_create() since no other thread can access the io_ring_ctx until
> a file descriptor is associated with it. So use a normal assignment
> instead of WRITE_ONCE().

Would probably warrant a code comment to that effect, as just reading
the code would be slightly confusing after this.

-- 
Jens Axboe



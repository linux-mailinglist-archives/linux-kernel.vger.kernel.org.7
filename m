Return-Path: <linux-kernel+bounces-797559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1A3B411E5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9840561CED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C46E1E573F;
	Wed,  3 Sep 2025 01:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Jj6Go02x"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749F78F2F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756862505; cv=none; b=Iuw7gcClyY9Re/znwNOFL/TwN0oE4PcvDvIV9Zb5BRKPZ8ieHUyDQB3labphy7wSyqPgPveh+BESExXGijPZ0j3mLjQvfy7phfUVVAsQJ2pGzDEdeSEEykA+Ta4gc7t1jXK9/Uzx0A7Z6Rh4ixDVmc9uVtS6Bk5qVnBNytZ9n1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756862505; c=relaxed/simple;
	bh=rQLNif5sl2BzEcHPDWCigKu+HqJuv/2O9dOuEdyKUT8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WLrTToB6DriDr4LrvV4tEt32Ud9HW6cpJhmqSjoR6C4Kag2pLSH/Sd/fdo7FPpYQ21A+d6ELQIfVpjpJmTCYhQ3MFnIXnNoMH0nmUA7XrUtEcaA+e0/m8lO9xVEuo34sg5i1H7Ydfukvl5235tb2CDkylhSZZyr95fHq9QCiST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Jj6Go02x; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3f0651cb8aeso53982555ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 18:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756862501; x=1757467301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjAS8byAOwIr5PFgfyLQACeUTVvKtTs0AAlpz2j48FA=;
        b=Jj6Go02xAmdqzq0pwi594P5+bM56Rr6+acOEEvq0HOXojH6h+KqqskiDxs0pn5n/gP
         1mg5obPTpR6drBtfJccI6CqYMUEzd2MnwB/u0/Psd0Zqvjm/hgzZB+ez4yfhAWK1J4xv
         Tl3QnZiswRfk/DJmwgcju9riNSE1zI4vPKMAHfZnuudFm56pXGD4Y6/iEOhB42DYMscP
         F7thwrZkPGXTKf4n506F6sGxYQuWzRqqQnKTZjWBkLEbpfMhOuE5NtaSHN6Iv3yYQbL6
         AOIwRN5dFwSatfJGdVe8Dsdcp6xM5dY4PyKon26MGt9XwfeqoRrwpRHGgK4fJgoee7MC
         Y22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756862501; x=1757467301;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjAS8byAOwIr5PFgfyLQACeUTVvKtTs0AAlpz2j48FA=;
        b=TqJXT1j1YOUAueqH/gxHis2EKWa2Lg0ReKLg2rmnlVkcK0PaJcwkC36+nPGkt2HUgL
         ijpEU87xKw9na7yJ+T1qDcS7SU/uOwQiRnQvvlEJdGMAB7Lsral+HTza0iCSPGJ4KaR5
         vIFhD7iuOcNajJmKn5sAckZ7k0loCZVh3BDxXk7J2ONl0qRdaAgwOHbV6yxBwfsVkapS
         jNoExX4wZlUHdZfCkBswq5a33I08YM9LjEaRlNoxEQEbQJmb9Nifn/yPbGbwPx4anJdl
         Kl1+lZbWvbOQ79+214vIGuRZpIXs7NJAa/MiJghhvrivXGTn8bR91PYx9zdML3pZ0sk1
         uypg==
X-Forwarded-Encrypted: i=1; AJvYcCUyP0J4sR3R7cWJGf6DYQg5yiSnDcwH1V/bbZzXOcoWKLNV3fDlBJ2tcFhHLEnCxbgeutsL0kDdA0+p+68=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuljFiF9CPFWhmgopB9YLRdDXFZ8P1ZZIECCrKfh05gdxxfV0a
	7Xz1rP+jPOPbn64kZwm25Z9h+yoizjplLmjRA5a/Zid3dMxcV0zEZuT1gj+/h/driDzJ2MvRWEj
	g42tm
X-Gm-Gg: ASbGncsipIxc6ONhqmBCCkUYPWgdi0jvTYRfDsedX9Z4GwOQ8FBhBjQfP8ajaBoXixG
	EW5mIJZGFIxk21Y9wmiqmsU+11FZhowbxAbQDzYioKpCd1iOMdv+AVw/vF7Ft3B6HkVBjFQ9jG/
	j9wY//CkfH/PBGIs6rD04flwej+e8/3Sm4WvwPrpYKncLhiLlwh4oH+RsrTBdXXVXwtAv9Jazdb
	kIO2T5G3Q6xgCCoiWgy20Q04aCyslegkblXroWAbupYB6LUEstALCZqjUjP+9a/qq4rqGYZseN6
	14r9e6ByTYDmQG9WZY0JvIVrODrX7OrmJbYNeYwekJTyLut/vdE8XXvlRiP0IvPTRuJ3l2luSEQ
	GEMMxaYXFyPhl9y8DkNJMGlHkECVe4FoLi49C+K1kIWd5MyuPvv04XGL0kO9gTK+i
X-Google-Smtp-Source: AGHT+IHP5bpnitaSPsC737EVCCHHb9hXsYOc52M1nYnXz7j2gVymoM6d5QMfMkdWCV0dXunxYJ6FkQ==
X-Received: by 2002:a05:6e02:17c9:b0:3f0:dce:2550 with SMTP id e9e14a558f8ab-3f401be27a3mr210428985ab.19.1756862501398;
        Tue, 02 Sep 2025 18:21:41 -0700 (PDT)
Received: from [127.0.0.1] (syn-047-044-098-030.biz.spectrum.com. [47.44.98.30])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f31cc0dsm3662537173.38.2025.09.02.18.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 18:21:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250902130930.68317-1-rongqianfeng@vivo.com>
References: <20250902130930.68317-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH] block: use int type to store negative value
Message-Id: <175686250047.108754.9991172148469474347.b4-ty@kernel.dk>
Date: Tue, 02 Sep 2025 19:21:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 02 Sep 2025 21:09:30 +0800, Qianfeng Rong wrote:
> Change the 'ret' variable in blk_stack_limits() from unsigned int to int,
> as it needs to store negative value -1.
> 
> Storing the negative error codes in unsigned type, or performing equality
> comparisons (e.g., ret == -1), doesn't cause an issue at runtime [1] but
> can be confusing.  Additionally, assigning negative error codes to unsigned
> type may trigger a GCC warning when the -Wsign-conversion flag is enabled.
> 
> [...]

Applied, thanks!

[1/1] block: use int type to store negative value
      commit: b0b4518c992eb5f316c6e40ff186cbb7a5009518

Best regards,
-- 
Jens Axboe





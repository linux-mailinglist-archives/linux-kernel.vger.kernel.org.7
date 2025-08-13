Return-Path: <linux-kernel+bounces-765797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903E5B23E69
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1972160DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3257C204598;
	Wed, 13 Aug 2025 02:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2W4jEK7"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC38E1FCFE7;
	Wed, 13 Aug 2025 02:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053123; cv=none; b=Y0CKm5vE41P5WeiZeiVkRWuumcBgOV5o7L5dByZQ4UvvM9C1Tac74piwnzQIChmej8wesGjiBJEXYrf7y8MclIm99K/1SvrZ1eQcqxj2e5H5IxVKXmRRAM0J1e1xc/e+nEJz3Aw7phLjGsRAZ8dG9OEpSLkhR/zGPhYpkQpsCGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053123; c=relaxed/simple;
	bh=Kvg8fvdZercb/1tUH1fx/ZCsiW65Avvhaf/buqFYuWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzOk3SdDAIcUgCyLWfXBewG+8Vhr3equBxx3p1H2NkQk1/u+ym46hj9foS5W5Ud6O1NMvvCQ70wBsfP8pseqFzpzAqOMe+2xAV7GWsctmnZAfZ3/EKSNci/zbcEz4IMrHZ72K5efCFNubnPadLeFIdvbuFYeaQHAKfJNcRJOPEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2W4jEK7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a15fd04d9so2525985e9.1;
        Tue, 12 Aug 2025 19:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755053118; x=1755657918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kvg8fvdZercb/1tUH1fx/ZCsiW65Avvhaf/buqFYuWo=;
        b=H2W4jEK7oxQIp6zLxQA7QGQ1jmL6nZ9kOQs9YvBT9InsFks/0WG3aP6Px1B6SZpDJE
         X6VJlh+GazFdGJhiSl0TN3YxfpSpd5EqkVa9kcUdH0TAh3gNsNJa1B+A51VhX5x+/JXA
         FIWjmA+sFReRwgWrky81JiO9ctMojy9Sq5cCTOQi5CMLKitT5hxUL0TqM9y7DPkzhgD/
         s3KMbyVeC3kqJl9O9AFzxZiCVy8cAR563EG6H7rv+RzR88pSYSLkSby7YzNLXRqrkKDx
         XdEW005FP84V7NkTxNDtsRHTdMhKqUSAWCWoDHLxLv5iN+eIY2L2XaOX5BkLvMh1xhJH
         8GyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755053118; x=1755657918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kvg8fvdZercb/1tUH1fx/ZCsiW65Avvhaf/buqFYuWo=;
        b=lu9mw3AtJMZ7z0kyE+d4YLMvvSVCvV/W4NqVcJA3I38xs6FP3oL9iHhi3a4PKSDgkN
         q+R7CFxv82lKNXfgcRzp4nw+WQyWdHNeOS0XO242H2zFz3Ky1wcjDwJjvmZN10hY6iGk
         Ued6u7uI9tRbU4XJVLaT9FLeB0mz+x+wNeWYP3rFtttYdMgVQS2w9urTD9/9UJg9F9/E
         2CJYfPYHp3gGV232lL9S/tukGXwOkwgWP0BrCry4TO+4DzzkYbhtuenYOua6yn/e5H4t
         Xd9Kq1ulX83LXyrForkmWAuOH8vTPd6CJhcRDMZ9DdwAfkZs7Lj+M+zr3grnnILeQDUj
         /+vg==
X-Forwarded-Encrypted: i=1; AJvYcCUAL2hWjqK958poIuzONUaCY8wjo3lsRrllHlmYCbFd28c75Hu55vaOPPUeewxJ273dAF4pFN9U3iSl@vger.kernel.org, AJvYcCWriC5PuT9fGP6UgbZLhTaMpTwvLZoQo78U0IjfDmq7tqKqKbVwZjwWomUCIN4STMB6sEep4HOly6wIj2dB@vger.kernel.org, AJvYcCXhlIe1eNlre8AAcU6gensrPIkEx9nEhtQ38hDzWjXEkmRci93b70YFh5AAlpCyh673g8HD8Cgfi7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAphTOcYgK8SpUaBLV+oid42Z+9wdduBr1vl31ec6dWSPalfmD
	89AoZOw3bWJbJrXATwAfWdobg/tKMqNpvbmhbDPli2GL/Uy94g1tR8RFr58qYvyCCGHHzueAEiK
	R3Qy2E4taLFjXm3esvPQUhl2ifVZPOTc=
X-Gm-Gg: ASbGncuD0/4/POl6+M0KDilOXstgMQx+JKUuOR8qSe0gyHAjzzNLewslDZMGb5MfVQH
	sjD/hkcDFSdvpXMz1Mzh1wM8HBD4osChKS3p/M68P70oVQieM3NAHR1E8HOy7hF3LZ8COCN7+Fw
	7xpj95k1f9MbpH9LbsWze9DjoQZb1lGbywbBhf53r9WctOodtgvkbc0hZgL4XD/f1pI8yYm0Y2e
	+TViAI=
X-Google-Smtp-Source: AGHT+IER/xoh2r0fiZY/zHhrvqqJNO6/Cga2A0F4VDogmsdOv+We2VyU1IsS8IDXJ7I5efqv8sxiKAzD1n7IC1pvaew=
X-Received: by 2002:a05:600c:4e8d:b0:459:443e:b18a with SMTP id
 5b1f17b1804b1-45a1704f681mr4589345e9.14.1755053117827; Tue, 12 Aug 2025
 19:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811173626.1878783-1-yeoreum.yun@arm.com> <20250811173626.1878783-3-yeoreum.yun@arm.com>
 <CA+fCnZeSV4fDBQr-WPFA66OYxN8zOQ2g1RQMDW3Ok8FaE7=NXQ@mail.gmail.com>
 <aJtyR3hCW5fG+niV@e129823.arm.com> <CA+fCnZeznLqoLsUOgB1a1TNpR9PxjZKrrVBhotpMh0KVwvzj_Q@mail.gmail.com>
 <aJuxuKBm9qfpVkBC@e129823.arm.com>
In-Reply-To: <aJuxuKBm9qfpVkBC@e129823.arm.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 13 Aug 2025 04:45:06 +0200
X-Gm-Features: Ac12FXx6Pc1KJl2LaFe2eqFw1_0jb589tm6uNaUFSn8Yw7SbSnihGg_Kc_aD0sw
Message-ID: <CA+fCnZdWOh3=KkM4AL1ZYfhyMhdSqgW97Rz+uxO88mMkqT6WTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kasan: apply store-only mode in kasan kunit testcases
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, catalin.marinas@arm.com, 
	will@kernel.org, akpm@linux-foundation.org, scott@os.amperecomputing.com, 
	jhubbard@nvidia.com, pankaj.gupta@amd.com, leitao@debian.org, 
	kaleshsingh@google.com, maz@kernel.org, broonie@kernel.org, 
	oliver.upton@linux.dev, james.morse@arm.com, ardb@kernel.org, 
	hardevsinh.palaniya@siliconsignals.io, david@redhat.com, 
	yang@os.amperecomputing.com, kasan-dev@googlegroups.com, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 11:28=E2=80=AFPM Yeoreum Yun <yeoreum.yun@arm.com> =
wrote:
>
> > > But in case of sync, when the MTE fault happens, it doesn't
> > > write to memory so, I think it's fine.
> >
> > Does it not? I thought MTE gets disabled and we return from the fault
> > handler and let the write instruction execute. But my memory on this
> > is foggy. And I don't have a setup right now to test.
>
> Right. when fault is hit the MTE gets disabled.
> But in kasan_test_c.c -- See the KUNIT_EXPECT_KASAN_FAIL,
> It re-enables for next test by calling kasan_enable_hw_tags().

But before that, does the faulting instruction get executed? After MTE
gets disabled in the fault handler.


Return-Path: <linux-kernel+bounces-840239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F1BBB3E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 820AE7ACBBE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE2B310652;
	Thu,  2 Oct 2025 12:40:03 +0000 (UTC)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1343101A6
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759408802; cv=none; b=aZvS+McjDEBRSyvSO85K69vsWfAFv2cbuURNt9x1ocZFMol+ZKttfK6IYTCsWeuQ+ewzdF/7+tc5MdFxltkT7fzplvKzkSras/C6L52LYyYkLPD4ezQ19dWGqdoGu/XesXelitbxYYvUHZp+FaLquXJXG78x8CCZJLPWDSPJNqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759408802; c=relaxed/simple;
	bh=7O8Q6H/V342Hk9kSuK7PF1mqEQCZDCjvYkaJgb/FMnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uou3dubJrsO1qdiND7qsPpa8Ow3lECFQRfHAAxg1noqObgYCryfY8T7vlCMu5Z6n6xnwbaxETqC72TqAzB05NmF0HuBDeFBj+QMJj9iPItpliVXKXRR1QgUkLi0OOgvcn9kAN65/ngmWovKwdbz4a/A47yCi32iBRs+euky8JKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ce093debf6so1055969137.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759408800; x=1760013600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJG7Pi+JGjs1abvLn2qtglQhq0wRNhthICu3ohkXyqQ=;
        b=jc48iNFwhAFiYzywlkxjUkeFtCzAJ92+15eezkq+pNUHcfuUySTfmL+wZISM5sCyx5
         1s88I7oHe+rFd4V/kFRS1Dpr1muKpuYWjIV9f1MqlKTZUx3CLuWaKcwA/qCZeI6QBFXe
         dbZEAeLN5ElOtXrhllo8b32pld7GMeuE1vyuzjjtvyKN7Zr63JMKgrkLmU2w2mHah7ks
         SVkEkABudJGMcxyzpvbVp1olHMmuxIOq2/edq1S1IeJPsP0HYpvSKGXj3t2qOen7lWiF
         cdoa6dB8LvqzPPf396A/nd/R4GrVjomKkGiy0+ChXyWLfnUXZn1yMCoV3XtjBiwLtJDz
         rDcA==
X-Forwarded-Encrypted: i=1; AJvYcCUu8ZoXZFDHu+PFLRaNZFszbmqjprT5zNupEHStcNjOCTM2ovrjJAbofjYhEQGqNwqW9IDJ9MIBrEOrX24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzn+cMTbPUBtJ2zuB7YqZl9+54l9oQjzJpFsWrzKMXvr2QA/HI
	rL4YQRZTnh9a+CQ9TSDp1YCy+PI9vQAVY3olP8DN+3XSqnSw6XqL4Yh/uinl7mtHjio=
X-Gm-Gg: ASbGncvn51P4MOtMDj8V8034vKu8VOy99lY/UMIl4PVSzId4ZZoVoqGW+zeQUeAZgF3
	JbEyxXi4++8Q3kHLZCYNpmTBrQd8QGbNU0V77hx6YUYCOL5AIjF2Dtqhx2Uu1h1Mxrezdqpb2tZ
	alsfbythKogGTGW96lgJP9SrKnWiz39yHFDIj5B9jC1CgerjwTcBCd3qxiAG8S8G+2zXjWALBpa
	uGKJldhv7x4CZJSy8Gs/ATT8ardAZVtLEiuAAf/VX7ZLEaLNV2QfqOtsZIeNI6az+TPqizoiItQ
	mnws0Os4ARJU8QGoSUwMSZgntGto7gLyx64wLKpGj1++Opz/njeaVucW2Kp/5be9Jd9z5U23gEo
	fhpSbA6sPJHp9fDe65CdaA4wLWTfjKij+fLa3wxyGJWxT/oCKcH1oP3GfgIPkjT24yU3UesBRD8
	cfMli7DX7U
X-Google-Smtp-Source: AGHT+IE/hkg4MtemRz6juNWZ5Wb8LYKQHpC5njg6AW+S1whxnQFqSvhRt7AtJFd3ydBEayjgSkMetg==
X-Received: by 2002:a05:6102:512a:b0:4fb:fa84:2e64 with SMTP id ada2fe7eead31-5d3fe50959emr3220745137.14.1759408800050;
        Thu, 02 Oct 2025 05:40:00 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d40c6c801csm552444137.14.2025.10.02.05.39.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 05:39:58 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5d28f9b4c8cso1265467137.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:39:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdtG3PF5uGXqTdk4HkGzyXiKqxfrsDeFmmGcxPogkS0Yuc2YffZxjDgoKq/68co7wyVqn7jKnzZw99YA8=@vger.kernel.org
X-Received: by 2002:a05:6102:390c:b0:529:b446:1749 with SMTP id
 ada2fe7eead31-5d3fe5260edmr3028987137.15.1759408798147; Thu, 02 Oct 2025
 05:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251001122326.4024391-7-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251001122326.4024391-7-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:39:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1kbS-KvD0mFXHiApd7K6K1scm94WBg-84MQPtN__h3A@mail.gmail.com>
X-Gm-Features: AS18NWB_Zolx4Yi5Ewsp7mWBmwmwJ9vX5Skmzp6rXOAIB3SYIXAxIWXsQiZ4XoY
Message-ID: <CAMuHMdX1kbS-KvD0mFXHiApd7K6K1scm94WBg-84MQPtN__h3A@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] arm64: dts: renesas: rzt2h/rzn2h-evk: enable ADCs
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 14:24, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The ADCs on RZ/T2H and RZ/N2H are exposed on the evaluation kit boards.
>
> Enable them.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


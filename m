Return-Path: <linux-kernel+bounces-775778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC11B2C4B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA011BC0A16
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064933EAE1;
	Tue, 19 Aug 2025 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PhyZ1McH"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B909F224AF9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608741; cv=none; b=XV0vlBRyfh5EYmr4oBqcA67C0x8BRCCVkpFQEycVdApqLW2kgZ6n0tR9/+UlNBugbt03iIqeCQWcgvWuYe3u8FfOrSYagm8sMlZQjRiqpQZQBMorrlXJC9ZlLU/8N+N0q8w842NcRFZydLSP8AUWX1MvjlzXk0hnu3i23+0sZQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608741; c=relaxed/simple;
	bh=TydTBW5thx9mDJs/hCsJtwVT0BXigr4SrIrrv36m4Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHUMucSqtOmNbcZ91Bf93b3dw5x38oSI0JF+lHVBpuH1F/vmONQ0FraeTnsuPPlY2tf7zGd6hMU9C9nxyhCq67Y5QTnXqnFglU7389FwY5wjmUekj6kIcoEIVqlI2exTMlSGS/J2hJQUcWKR5PD6oaHZOC+9r5Yz8VeIzCpfl3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PhyZ1McH; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-333f9145edaso39054111fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755608738; x=1756213538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TydTBW5thx9mDJs/hCsJtwVT0BXigr4SrIrrv36m4Gw=;
        b=PhyZ1McH27tO8O6wlozW0gZSbyVAYJktXK99tCbcaG8onozJzZ/VspFLD5SSTyXp2y
         2VZZSl3bd5gDM98+smiC7zNGZyy3MMrLaUKh+cJSdO5tFxkxKjaNrIdcekJMBSrMGmx8
         yQlpKk/+I9BiSMLORsBg+RKPzyEvYFZT2LL4TZpJYUV/dqOQURODLyIV9LEyjxzaXcMO
         uHC1a2A7VONB5jMa0k418Cthp4GDGgrLlgQYvUG4jS8tDOTB4VK7pGTB1M/hUbGrMDgH
         rNc42ybK4OW7Qkn7wNb6u9/xwnFJVvM8CP27sEa852SXDj0TLxVoEmGqQDPtsCvjUgx1
         2drQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755608738; x=1756213538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TydTBW5thx9mDJs/hCsJtwVT0BXigr4SrIrrv36m4Gw=;
        b=ky8NmuzpgM0DtaXqvLTzrhBAeuswlWjGxtwq/fbQ5hfhnV5QNaKV3Ae3OOBmgc1jHf
         rJk6p4LjhqZbz/Lp3mMCAAxhArC/TFGhKU0yNIMq9RwCba+zMnnvobrFp7H+M3LECmSu
         oGABc+/oAxeGgl4ccAxvdLv9NBdbna2YdP7RZDthfs+cXdtaKmmX6FDlOvkOP1mmEDlS
         GNvBoJ/+uY2hm+Rz1+8sYEEEXi9rqLHDBYaGxia4YIqWl7ln95RO8qPskOilbDnxftzj
         C+C/gG+Q3nsZ6IqMvyDyDBdz4Mja/mjeHuCqGaA+sFeW2CzMW/5RTbP050PZQiya46qW
         bmBw==
X-Forwarded-Encrypted: i=1; AJvYcCXS+WWUHaHCf7fPmV3saEQDT9dojUKc3q5+jo7Tln5Zp/m4XKjo9Xj3V8pq5nxeKCDb75j493U68nH7aUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDh50qa69SUhqJbbfOH6O9eJtoRhXhLWvpkXeCZnNtihN++KUq
	H4D2DXkHJhyldzv3sAfVDToHHSSG1HLdilbku8sXSmYODQ+mHzUUeTgnbe8rqDQQiVkVznf1ys1
	3Rxeo4ojG1NpA28riPHovibyosQ2epi+AvGfh+xNHv3TefbbcSmH/R/SiRQ==
X-Gm-Gg: ASbGncu7P/OAoXO7bdWuF8p1GJa0lDPA/XkGgP/MlF0sOiavyhYNDnvcQM6OSCH4Q8W
	hdRAORBZ20PTnRA06N7CRmE2pr8OApDPr5Hif5ZiY9NvI2399WocZYEzn5Vr1uUK5lxHB+rlO2R
	aHpv94RJnzgO3UQH0OGL11RxnhZ79UKCg/WS8YRlVHpjkpCA392Q+ApkVfvRqtzsPan4F6k+ZFY
	0qRP/hE+a3AlYOVpA6Xo0I=
X-Google-Smtp-Source: AGHT+IEpK76uxGn/DS7ICLCoTV8giPyjNjAYLxm3xST9mGFGCKp3eB6JQE/Gx6nRy13cnpDfXlqQrB6jbaGh+1eqiHk=
X-Received: by 2002:a05:651c:1505:b0:32b:805e:20d9 with SMTP id
 38308e7fff4ca-33530809c75mr7490841fa.38.1755608737688; Tue, 19 Aug 2025
 06:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9652736ef05b94d9113ea5ce7899734ef82343d1.1755520794.git.christophe.leroy@csgroup.eu>
In-Reply-To: <9652736ef05b94d9113ea5ce7899734ef82343d1.1755520794.git.christophe.leroy@csgroup.eu>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 15:05:26 +0200
X-Gm-Features: Ac12FXx42oLVZo77dClNUGC42QVr3TSxbMmRbjTF7n6R6gJYcLt9jZg72zItf9E
Message-ID: <CACRpkdaV8EA6O1x3+UpruhXEqzA5Zb_6v+DVwURvOFH+rD5Jrw@mail.gmail.com>
Subject: Re: [PATCH] gpio: mpc5200: Drop legacy-of-mm-gpiochip.h header
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 2:42=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:

> Remove legacy-of-mm-gpiochip.h header file. The above mentioned
> file provides an OF API that's deprecated. There is no agnostic
> alternatives to it and we have to open code the logic which was
> hidden behind of_mm_gpiochip_add_data(). Note, most of the GPIO
> drivers are using their own labeling schemas and resource retrieval
> that only a few may gain of the code deduplication, so whenever
> alternative is appear we can move drivers again to use that one.
>
> [text copied from commit 34064c8267a6 ("powerpc/8xx:
> Drop legacy-of-mm-gpiochip.h header")]
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


Return-Path: <linux-kernel+bounces-754455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F7FB19478
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 18:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE671893A7F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862C21F61C;
	Sun,  3 Aug 2025 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="NR6fovwV"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C06C182D3
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754237684; cv=none; b=QJJPzi03uSwnzTvICmyM/jjkcYQHzLQGfaMkDwgXNxTDpNINwaLdL5odGMGaOdMq2VBPb7F+TCKGplaP3SO8uHAIY2y6EhcaS6Cou9xb3hG7fCjmslcywVIXfsaiIfUCrO5Sr0P4M8j5VnLt2akvHuYZ0U0FXMnPooQ+0f1bgKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754237684; c=relaxed/simple;
	bh=JQpFEaDLYhO0uu/gdllj5IbvKTRqfxuInh2LybVDw4Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=syMe6BHObHz8J1nJjy9zOPbKJ76e18tM2F59fHknzrfJJruP7NTNz9AkmbL5Ay46678uzxZVSCzBDMo3egdcsKTTke+7gXKWh0bUe0rcotbP7FrvVOC5XxsxhOhFa+TFz5ai/poCi6FjVeDW1JdQIoOM8/o00gvvochNtjZjmmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=NR6fovwV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76b77a97a04so1801319b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 09:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1754237682; x=1754842482; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQpFEaDLYhO0uu/gdllj5IbvKTRqfxuInh2LybVDw4Y=;
        b=NR6fovwVoS2XvXGd5SMewVUxPmtPfehqHrD8jGPUJeaFWcM6qH3bZ34l1QD4gmITCz
         bLoSoLSiUDcsrwF4r7ueQH2RbszUM4ZdjwYxtFO52nak6xsBpf1upxpDs7JDOGdUJzWM
         I72VwN5K8/nt7RbI27QnLqvJBjasRCG7aYDoYtWCYsczQhdK21Uq1SGBQ/3q0HM8InEX
         hMqf7UOsisR0tR+9S7TaiafImd/eDMMT4sLrJb8scDaHIlCqbE75Kk/rkaDmMY6Q26DQ
         cu+iEB3cHVf2UxtHip5L8dUNo1qTnoXW3l9AxfZtlPw4+vjpE8kfUexpdRKuoD7LrTQg
         l9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754237682; x=1754842482;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JQpFEaDLYhO0uu/gdllj5IbvKTRqfxuInh2LybVDw4Y=;
        b=vwMpgFgI9bh0J7HGpjrFym6Llq+eAhmKAFdupnRQLyVDdSJ7R2HkCuKjVbLNHyeHg6
         AMYEw4crN7glMztOsH2KlEdwj9Aej8ObbGJ+GUXSx84zQ/W4CgLCEa2h1AiHut3WMNQx
         xwqX7dqdrwf0Rb2/Sk7t3cgTaKoEpeMH16MLxL1/KV0APHTmgoeIWjVTa4Pud5ULLO6G
         7fUhxyxHGaWykqtlD2vmKnoieZy1LTyn3P4VFKUHOeK1zFP+a+snMbcGdJDw6LTN+dKF
         zW6G7/9aSboRd67w1i3wWX/MXM7+s7XJiB4iUMubWEVr3Aqng5eB5x0DnIr/tBNyJHuT
         VogQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlHWztuEV+ayYphZGtssZKrdTcYlr8iOPWKhkCeJXYvxHzKkhSd9+YXd1RYqeJHj7TwQLAKFc1PHJ0HEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6NPYAWREgFWQSp9/phbaLUKdjcr5Bp9UNraBUb6keSsNHvIYQ
	NdSe5tzEOPds6J+LIX5yyM3URZZPby+nkvKe9w08JJu2AbOECBiu7ZbI8KR4yjPaNts=
X-Gm-Gg: ASbGncvcLrsaiOogfE9yYDv79zizDDGCC905A9L2ZT4UcjHiHkOMbRJkiD3mSH+XaJn
	OPbJYSS21OrLT1/FN+KHyYAnn5nZkqSYw2xqhYJmdCqi+M6bBrZTGMao2HxgrOkvVbsXp85ga76
	hKeivwAJJlYxS30SCLZTFOGUvnGH2ZDHWUB1c/NabhYjuuaUro+aAv528m+r03Z9tjuV7suKchR
	boNeCPFGsjfqoqbWMzlMRhh04/XIOSViBOSYrG8rWzLqAsinrJwmR7J48rWa3rC4vYcmm1j889g
	6Dy91Cp3oEwO9p7+OY8ldUZ3z1F/NB2mnmvtA8hrD8KM0IUCCmpC9mhDcz1ygC4Nff2Ko5TTV3X
	eac2jiuTJrBMVeCH9o2k=
X-Google-Smtp-Source: AGHT+IGEvYduDzdbwcJ7TQCIF912GvAtfZiRW2LnM75ZKQVh2Lue6+FoQSH0fMutpndDgLCvq3uePg==
X-Received: by 2002:a17:903:183:b0:23f:d903:d867 with SMTP id d9443c01a7336-24247013eefmr93455085ad.35.1754237681805;
        Sun, 03 Aug 2025 09:14:41 -0700 (PDT)
Received: from localhost ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6c62sm90444995ad.4.2025.08.03.09.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 09:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 Aug 2025 10:14:39 -0600
Message-Id: <DBSXCWOKT4BE.1RD9LVC2CY12E@brighamcampbell.com>
To: "Tomeu Vizoso" <tomeu@tomeuvizoso.net>
Cc: "Oded Gabbay" <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-kernel-mentees@lists.linux.dev>,
 <skhan@linuxfoundation.org>, "kernel test robot" <lkp@intel.com>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 0/2] accel/rocket: Fix build errors and sparse warning
From: "Brigham Campbell" <me@brighamcampbell.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250802-fix-rockchip-npu-build-v1-0-fb0f0dacb3fe@brighamcampbell.com> <CAAObsKCUs0yn=S1PzGDKu8nNnTOkxqMMYzep-QhG00X1CY3DjA@mail.gmail.com>
In-Reply-To: <CAAObsKCUs0yn=S1PzGDKu8nNnTOkxqMMYzep-QhG00X1CY3DjA@mail.gmail.com>

On Sun Aug 3, 2025 at 9:33 AM MDT, Tomeu Vizoso wrote:
> thanks for the fixes. Will pick them up. Hope you don't mind if I
> change the subject of the first patch to something a bit more
> specific, such as:
>
> accel/rocket: Adapt to changes in drm/sched API

No, I don't mind at all. Go ahead and use your editorial discretion with
the shortlogs and commit messages. I'll put more thought into the patch
subject next time.

Thanks,
Brigham


Return-Path: <linux-kernel+bounces-780349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA5DB300C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA024A22748
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7972FB62D;
	Thu, 21 Aug 2025 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmDCimZh"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532DF261B91
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796204; cv=none; b=PiuJqrjFxR47E/r5mXSo+Db4yKqT3MrJX95+jqhCKWaFCaSZI1aRPh1e3RGK9ZSD/rLR0S8zFeAdsdLudLoIKPAiiilsckUTxzguLM+isoGMxssQyu8M1qpFWvPHkbqWH2PCgfLZZHcjbEmGCP+4kzXy3hY86APCF8aW5MTQKao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796204; c=relaxed/simple;
	bh=qzyta2RpwZZkPSoINkCs6FPoiQyGdt7Ek43OoHB8SWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4yZpKpyoCjM1d3NE5ek52CP6PyH919FlTCm9SYvDavfuqRWG1h4uOZUw6xxAU+xq1hc+r9uBtWnqkjphJ1mGbt7lAjArccugidlWjvrVtg4gMgfnq+of9UsyCIbYUGCXNZav4NnL/oKXnFbP/4qBWOiBBsf0nVeeW6QWjDiRX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vmDCimZh; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55ce520caf9so1366943e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755796200; x=1756401000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzyta2RpwZZkPSoINkCs6FPoiQyGdt7Ek43OoHB8SWI=;
        b=vmDCimZh6hqMz1ZPE4+u/BlGzzptUQHoDUz3fiJIKY3PHdIT8k8eTVmjSfgEvMGYcA
         /2rVwGtMaLzDUK8PQkphMQCEImlxmUr1a9uB0AZ8MudnBOAw1zYAded2OcwBmBI8e6t8
         O+7Umtr2WK/RjkR79IX5sEcI0WeTO1wyjtOvhJx9rTA32knKCqIktfb2lv5u/tKAQPlw
         AsK7irJ8iuFX7XKiHO41QwGLk2+NgP3PcDA6CxvIkvoPhECgyZqHZaddAXKUfoW2mcwf
         i31qnLjNBupovuW7QFya9A6xSFPlQyyHQLeyKf/s9T6fiF6An5uSa5XKtZdpVnQZ+2hp
         YbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755796200; x=1756401000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzyta2RpwZZkPSoINkCs6FPoiQyGdt7Ek43OoHB8SWI=;
        b=olt+2dMucJ00vEx46vjcownr031kd25vxYOknxfAKu+jSd3sWvqZIktJn9qTDDOko9
         yf5kRbgoAR2cVY7S146pcg+m84a62oQNM93KB5s9tJDczpBBf9f1PAdDVbCO0u304EE/
         I50U/hmh51HHVboyaVSZZ7u6t+OOTHJFomt2z5qeF6eIEwkF0y/zTQq45gq4WP4OMdYz
         dm76SPSk/Bb6DDjan2TJueJJhZuaeKo7uyL2dHgJqz102ZUtMDpKHjVx/R7/h3+Tt+R0
         I2HVMRmtBexAVt+AkmMeyfxzMpkdR0kjzbCjJcEoi0phNpUJvxYrLIzVUXf6tCFCfgor
         6Bzg==
X-Forwarded-Encrypted: i=1; AJvYcCU3+0RdRei5dt7Pzh38TTzllFhQs7Do1HTB321tu6QQSkz9LpSpy07ijrEH//KYYy5suj4+LrebjgG7V+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxULijc/7+y8ZDfCOFZdKbcnsGwDXvzxGu1cF20J8g8//yAKUEk
	1REZfwAJcoWcNsZat8ZPcNHkPYUPRruhEjXEYDMt1kTB8PT3YFF3qGDL8eeUvHcN76VZf5pRYDA
	F6kN2JcBnz0LGd/qARrnCt0uo78zlNQl38Z/KOMU=
X-Gm-Gg: ASbGncvIIl4qYDTAjXu3c6zGI/20eaGntu/lMSwbmcJlMyrcpL15SFlHg+UiS7q7/1q
	5ckV8PeIVEeqwpZFiCeRSRQz2n6VK1YpN3Ze4t83V0ppuOcj4vZ/pkWx6DuFRPpaG66E/smLurw
	R5goWwZ5Q79BUt9icgSMj0ZJW2jtbQfdvH56XlDY+6Xjw/B0iRqkeJ4AqN1kyDxhfMVtf/ANREy
	2xfkgJw+f0uRn5wM+c/76OSyCiSAN2GiwbjZkiGjDU=
X-Google-Smtp-Source: AGHT+IGCtOn7tbH9t0p8srawhbiUJfL181nmv8fCMU5ZSgZahzHyg5r83rFQoVb5IzGafcrdKfDNDNBRg7nmKzntFD8=
X-Received: by 2002:a05:6512:3d87:b0:55c:d64e:f941 with SMTP id
 2adb3069b0e04-55f0ccefb10mr68135e87.1.1755796200079; Thu, 21 Aug 2025
 10:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821-vdso-arm64-compat-bitsperlong-v1-0-700bcabe7732@linutronix.de>
 <20250821-vdso-arm64-compat-bitsperlong-v1-1-700bcabe7732@linutronix.de>
In-Reply-To: <20250821-vdso-arm64-compat-bitsperlong-v1-1-700bcabe7732@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 21 Aug 2025 10:09:47 -0700
X-Gm-Features: Ac12FXzdv4nEar1SRFxGb-uqGlOF-O5VXp_mUrNfgvVnxfVbcoJVpWP9zgsBo4I
Message-ID: <CANDhNCqbZbhSLgvFYnzK0Fmu2qndQ-7qHwHmGtRcFwirgZvcEg@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: uapi: Provide correct __BITS_PER_LONG for the
 compat vDSO
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 12:56=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> The generic vDSO library uses the UAPI headers. On arm64 __BITS_PER_LONG =
is
> always '64' even when used from the compat vDSO. In that case __GENMASK()
> does an illegal bitshift, invoking undefined behaviour.
>
> Change __BITS_PER_LONG to also work when used from the comapt vDSO.
> To not confuse real userspace, only do this when building the kernel.
>
> Reported-by: John Stultz <jstultz@google.com>
> Closes: https://lore.kernel.org/lkml/CANDhNCqvKOc9JgphQwr0eDyJiyG4oLFS9R8=
rSFvU0fpurrJFDg@mail.gmail.com/
> Fixes: cd3557a7618b ("vdso/gettimeofday: Add support for auxiliary clocks=
")
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Tested-by: John Stultz <jstultz@google.com>

Thank you so much for the quick fix!
-john


Return-Path: <linux-kernel+bounces-865367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CDEBFCE47
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9779118867CD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1DC231832;
	Wed, 22 Oct 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ+Yo4e0"
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63526221FBF
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147075; cv=none; b=r5E2fU5vJmMnIzElaqPanFOTsMxXWNNcGNswbddHnCFa6Je0N+1GLRZTd0CbB8CQtbpDyKD4c2zpGNts7Ap1k2+ZwFb1TuSLKTa8VF1lmhGVzSiy7n5yzfyPwPyERfTkulT99mQi7/GFinqi4ares1Oad/tBHsrN3AB/XCegN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147075; c=relaxed/simple;
	bh=bRcLD9cxvp6AbFFd8VLs9r/lqSIYtWbZ97Gmd9tAA/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MszMT7ya0RNLBZVuVnPP4wG9STeEwVF2Fv44yqwoAl27cwV61a8cuftpu3At5yuvitYONQkk4bUlRPkZG9XcFnztUF7vVX/Uce2eeiOJ+lwcnd5us7o7eFtqgNC/FO8eDS7g3SeT7J73NOz8gfaAuf3+jJvob6j27TK6BXx6Uw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJ+Yo4e0; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63f2f1ac9feso136394d50.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761147072; x=1761751872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xJuoCga2qS1/JaA1xmqdBDidVeSNx7M/fKO2tstQfM=;
        b=HJ+Yo4e0npxFNOp2bDhpnbHHOcBp8yCTxZY9qqfXXW5mTPKp9hI25+ssBhvvYQh0UT
         JIl5cO3UJ1isCa1ktG3yNgmSMIM+Vnx9bXXqa/1EqxpuS6v/OHmzB6CuilTYT85rNcbj
         ozXoHgaLajluD0Z1XvOEFMtILTK/Ds2wdPLsoAJejGgs0d0meeEw2RK5Et20KUpouoTc
         MroWqqhJmoGb/qmeg6sF+FUlkhSxplS2LvAxVJqA069tUowAZZeAG+YpW6RqSRHdcbjm
         q3uOZSGwQBJcCBu/kSaKdCRIdyMOTRTkDh6b2lvp7GYF/ktflZAhxMIMMa8a3oHh0c94
         dIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761147072; x=1761751872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xJuoCga2qS1/JaA1xmqdBDidVeSNx7M/fKO2tstQfM=;
        b=pjMXUYDyGiY0s8vJcyLqNWFibXaFP7t4I96PDcG2jppHFFy5l/KA+90sxgItFRJ0cj
         fgWZl+J2I8hCLsSrO+HvN4dh4mzk8g5gPDQ15N6wANpjljiFo8ZembXxrRX5fDaiPNHx
         KigVePevkAdcUHxW9YNnUzvgGFsJqMHJBBn74hMn7JtbU0MJWu9fYunOjJ1M2or8/Qs7
         xriaLZQmMPF/d9J66ajG8zVW7Zp/0Ou1VaFcD0d02z2zVgv74wdfU0AeRPruaQHZhXJj
         ejFaefE9uU50TW+MRjeTsOI1mqUdXXdiM/zSmFT/G0nyyJEi4yQ4mdzj1Ir4WxkYIe25
         P0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgo+JT04gbsARwBF3uaiEbb+QiJgPfRokq5Fn1tBwXnU+FmLbejYTSuDyHKsq0l23TjsDcxjaT9XIYyoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw99s3FSVST9EOF+UuCrIzXUPXmugpZsu0P2hw2WufkZ4fbaXEp
	zJljgex3F6T9cLZsjnKeRWjbme3tF387GIs9ZGzQ+oiOoWA76LUdJl4ilsGncdUwWJb01Q7I/Qo
	6xf5zr066A3Q9Bhs1Kg3TZxKztaMMebk=
X-Gm-Gg: ASbGncvdjU1kjIQp2/VS+MOwiUoIjFvj1efq5DrUpF0xkHedakQlmq0jDKjUHEdT4Fw
	7kcMHAQuztacMJCJCnDXjJWcRpJNeunM8cWbr8fupvRHI4uwjSWOMv41KSYCrMTh/sWMh74JbnN
	LdwZRaUxQbkrRsdXkXz2nhcVQ08yxySbLgyzWR5BplzfNXZ1nqiTrSX7LGfFBCh2B4Ilx9CL1wX
	8bXeAI8i4nCOSe9jGX4yqZyEqFvvMc4kgRQVKJ8rehzQWiJZozyatcGO9T1qDdN/TQQGg==
X-Google-Smtp-Source: AGHT+IGUbnBJYGey/KPlhF0ILUMb+ChEZPFDcxuQ0cUZpZa56x6W16tKmaq5bq3hykYj3YJfbS7ovrvf2zubyB6kY/k=
X-Received: by 2002:a05:690e:1915:b0:63e:22b1:21af with SMTP id
 956f58d0204a3-63e9ae40e3amr3285054d50.0.1761147072117; Wed, 22 Oct 2025
 08:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-netconsole-fix-race-v1-0-b775be30ee8a@gmail.com>
 <20251020-netconsole-fix-race-v1-1-b775be30ee8a@gmail.com> <uaxu3wlt5jqhzibmhjy44sb5mlekdezqbt5b3p2e5zza25jcpu@uqxdynirj3lp>
In-Reply-To: <uaxu3wlt5jqhzibmhjy44sb5mlekdezqbt5b3p2e5zza25jcpu@uqxdynirj3lp>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 22 Oct 2025 12:31:00 -0300
X-Gm-Features: AS18NWBA2wxs7GEJVzMm3TivqvdbyTpstIdOmgV7cCUDz9rZ6P9UdXcmkB-Iy60
Message-ID: <CAGSyskXJXQ0DgyaX6XGxk8PF974CoM_0tA2o_MJ5WzfLhEBwpg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] selftests: netconsole: Add race condition test
 for userdata corruption
To: Andre Carvalho <asantostc@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Matthew Wood <thepacketgeek@gmail.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 8:14=E2=80=AFPM Andre Carvalho <asantostc@gmail.com=
> wrote:
>
> Hi Gustavo,
>
> On Mon, Oct 20, 2025 at 02:22:34PM -0700, Gustavo Luiz Duarte wrote:
> > This test validates the fix for potential race conditions in the
> > netconsole userdata path and serves as a regression test to prevent
> > similar issues in the future.
>
> I noticed the test was not added to the TEST_PROGS in the Makefile like o=
ther
> selftests. Is that intentional?
>
> You might also need to change the order of the patches in the series to
> make sure the test passes in CI.
>
> > +cleanup_children() {
> > +     pkill_socat
> > +     # Remove the namespace, interfaces and netconsole target
> > +     cleanup
> > +     kill $child1 $child2 2> /dev/null || true
> > +     wait $child1 $child2 2> /dev/null || true
> > +}
>
> Calling cleanup before stopping loop_set_userdata causes writing the user=
data to
> fail. You might want to move the kill and wait lines to before call to cl=
eanup.
> Additionally, shellcheck also suggests wrapping $child1 and $child2 with =
double
> quotes.

Thanks for reviewing, Andre! I'm sending v2 with your suggestions.


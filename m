Return-Path: <linux-kernel+bounces-891707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 560A8C434CC
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 22:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129E73B04BA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 21:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C10C270542;
	Sat,  8 Nov 2025 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NIt5V8vI"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6280526981E
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 21:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762635872; cv=none; b=U+/OHOEIxk+0icv+3YNL3csXrV5226WASNrBDDWG57spz2CLjI+jJmQuMv7hdIaRvdll7SZ1rGP9JkIsl4UQNn/mdTYFvzzwwrb7TQhyJIaJZ9+AOa4hfs+x71Idt0tncgzm6cYggU7i83RRgpIwsJ09N+DOmlCBDRueQ4SZULU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762635872; c=relaxed/simple;
	bh=QfBxOPKy7fDifZhi6nSzMhp9yBd8dZHhu1E69GOcGH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B12q4pYfXV4m23fhHW/7F4nLAalOqj2A9ccWQZAJvt7wEpsEwcWyNCPqQYUmQBgly0hmLXFOmRPWpiI2xBTe0MOJ4b8z2Sy6/4WAdY+OWe/QbakHDd1YsgMwUHcJWDBlNMBJsUUYwLi6o89/9EJHxyvUacrrqOL4wIOWMQ0Iu/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=NIt5V8vI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso1136906a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 13:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762635871; x=1763240671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfBxOPKy7fDifZhi6nSzMhp9yBd8dZHhu1E69GOcGH8=;
        b=NIt5V8vI8gtkwns1f02byN+rk+Uf4rfhvYku3G0xEUuGj/P/ccNfVEJZRsi31AcsyE
         JAGSSVrxKDlVfKNXl2BOjeMFwWbMmN7YCL9fvUZhr209IBYO39f3rk7npIromLXM2J7l
         o+K5200niKwKuKR+3UtV7AWAv+SawwXkBL9K3PTc5H9ZmoBuhV6Q8L0jhuSvmIql3msZ
         B115eMNTFC9sgXb98GngUZZZkhodK2yMjbi9csfI3MhMlxCkK4ux/rWOdLtGsCXkFUm+
         wc9zvnB7iKNxNt4YM9AEsN2V+kOx7W8Tuluge2zRuTjoiJz1jJCfDCL7ZFlk5JrMqUiS
         XJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762635871; x=1763240671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QfBxOPKy7fDifZhi6nSzMhp9yBd8dZHhu1E69GOcGH8=;
        b=VE17UmkjyXebQ9JMSR700iRjqC3GB76j9AYQykUPsggg7ETvHvYFuYUGmfUlDtJj8I
         1WIB01Lxz2ESz90QIoqVumHIcdfrWDm0VyZaT3KK9+TWYtgrVucrSc7FkL3XwTM3k08D
         PYBXk+AMtzuF6mVHZDZeMywNI3CnMjnIALYrjLnL7khUtdpr+3kMb+rHCkcdFzhdu5xZ
         awCEEbDZTOtWzpd4IG3uML9CeconM6dK0e49LqV3OiFEzRavGmgZQFrNRCpk+CKGYbpP
         FXgKIrHjoWeENsg3pS65xXDSI8cA1o7O8dDdkm/s7K5CTU55XTeLBD8zc3WWNTkATKmc
         zdeA==
X-Forwarded-Encrypted: i=1; AJvYcCW8o13WoLSdKxBp/DCSQJoC4lSeBDosEOmzzH3vToBgb+BALVv5YXhMTpkXHXFKF0DnaUQZqsmqcxWAZcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZg3vSr14PyusieuDj6RpaX+dUC43bIBgkbLjXnCZoxjKucTLu
	JzvPHntrfRXJgsxHPmHcrg4blgiVSt4Ee0i+/bRUf7b2ShU9Jjua6cG2T+Bv/dSOqa71caoSnjk
	2y2lKHIZqWOrG92Rxuk7icvEH1NrL8UE=
X-Gm-Gg: ASbGncvFhbwgreNVLVM+Vb2atAugSIpmMHjPloR6LGD6fRFyKUTgeDXpNEUTMqtdG4o
	UBcaqrwcfjMcHtCDt/Uxtt1XDIYyERW5q8W5Aut7ZPFqBmWisYivspBBLk8Yvn1i8NxD9Du68cv
	AtiET/dgitfbsyPKnZ799uRWL3d8L1ughsFGQFj0I84KqLLKaXz3nG9wwk25nI4abZnUZMEoG7w
	gIMEcmL/H8KNkHcOYVBYKPbkWGrOMexNfArRaFZz9Fd2UCRO/lVv21t95KDqCgdYDKqbNOA6x1E
	umxfbu3yKH2y9hiLRM32oCDoB6Xz
X-Google-Smtp-Source: AGHT+IH7CCB9+sHT4Gkgb/MZHAPPjHtlGiNAPQ/L76vDJz380AHMHqeGOPDuOGCkaP2NZNwlmUNoZ72lWfi2Lh0v9Ds=
X-Received: by 2002:a17:903:1109:b0:24c:965a:f94d with SMTP id
 d9443c01a7336-297e56df7b3mr51858835ad.46.1762635870574; Sat, 08 Nov 2025
 13:04:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031-optimize_pll_driver-v3-0-92f3b2f36a83@amlogic.com> <20251031-optimize_pll_driver-v3-2-92f3b2f36a83@amlogic.com>
In-Reply-To: <20251031-optimize_pll_driver-v3-2-92f3b2f36a83@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 8 Nov 2025 22:04:19 +0100
X-Gm-Features: AWmQ_blQKnrslPLjhIDEU0j0xcOWcQJDgXAAfDygmB-XCYvmXNGV_pkvKxIws4c
Message-ID: <CAFBinCDbx96byeCvLY-Cq2d7r4+RipUVuER57mz1zZ4fgqRd4A@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] clk: amlogic: Improve the issue of PLL lock failures
To: chuan.liu@amlogic.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 9:10=E2=80=AFAM Chuan Liu via B4 Relay
<devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>
> From: Chuan Liu <chuan.liu@amlogic.com>
>
> Due to factors such as temperature and process variations, the
> internal circuits of the PLL may require a longer time to reach a
> steady state, which can result in occasional lock failures on some
> SoCs under low-temperature conditions.
>
> After enabling the PLL and releasing its reset, a 20 us delay is
> added at each step to provide enough time for the internal PLL
> circuit to stabilize, thus reducing the probability of PLL lock
> failure.
>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> # Odroi=
d-C1


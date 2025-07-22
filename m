Return-Path: <linux-kernel+bounces-741453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2490FB0E453
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2CBAA2467
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2307717E4;
	Tue, 22 Jul 2025 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fayulb3G"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC038DDB
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753213205; cv=none; b=UWiaDeQA8sayvQQOV7OOY5yXHUBQEmX2ZMQCga7j5nNCB/32P3MepsOP6ev6AgtFIIh7xQ1kfsA7N6AWi8FewWLjFd0YjOqifKJDWQnvBYpfKXWU+3etR4kWXkwsExYEBFUFaVPGbztnqkDBOBSPLGUtpit3ajU7YMLhQ8A+pv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753213205; c=relaxed/simple;
	bh=x6v5XvDIWmKAxlKddEufmcZ7B/OpVIpM4ocRrjATlV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSYRVWclyCSY7o9A6iN6ekZQaK8h7E8qEjop4oe0Dq4zIsTxz4HsCi0O58F0GYgabS4gymiefYBjKkdnA4ov1tivGV7WdnoyPJv8IQbKhDt4UD6PzUMUKhzwQoSQcZKrwmSwM2D8S+7gwjjq7DIEoXBPcjnBv3CuB0roOTRT1PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=fayulb3G; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23c8a5053c2so56030795ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1753213203; x=1753818003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFHh26tngjjOWxvj7gs0dFekGysBV5VC2fWJw/vtwp0=;
        b=fayulb3GpmcCxnTxio4YwZqVweY/2xsyMWkZg3XlrLKO2EF41XJtgxh7cFZKm+Vnoj
         tAsXX899qhlypZ0PImZRc0HspHicrhzmJ7c+L9umfcOtX1kIOqZTJnF8T74q9tuNWpav
         uxEWNop6kZu4qkuy24wkeoJZ9lZhv1B0LxdyX1718/VQAMdxK3SOH9Nq8nf4EdVugN64
         wOdts6/Ra4JO074LOdnWo+Zm4D4A4U65tM149snmnwG5MbA+3g017Md2DnkOl9T9k2kT
         rCWYAJS33k1M8PNcBIVwrCuIdyAc0FsP6crxLP/6Mts5qVJ1kdu9FuAHfAR8+PCxcKC4
         4RhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753213203; x=1753818003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFHh26tngjjOWxvj7gs0dFekGysBV5VC2fWJw/vtwp0=;
        b=iahmLhcioGub8wD4vtJqQ8QBXAL0zCUO1tazZcOJsq6a2/6+iqSfYVvCdPXIy58crX
         o6iamXsZ0YH9FlPUEy0QyvxWwfJNhwqrQYl4OqRKfW4UqsKRRRZDpFHQy9T5yVklES8O
         gWXTuHRUIlCet4C7wkjfIwCg+hFCKFDxTqxIjw6/1HQdoZdNpYz00w6dNxeJTVSi7Sl/
         FvpwV68Z0RtMaVn5jj3kxFyQu9cnXJw8Z+D6fHDw0c6x3aQYSxHERpRi3/4p/372uTTm
         TjsNExSta10FCtAi4WeSfoZHvYYpt6zoToADGz0pMMfMz9kKSEeWAeQaZ4o0ybkByI04
         wJ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0Eo+5bs7GA/ybXuqnphXzcrK+5o8+hc/KwJ8hKIm6dX/S+DOmOuQk+AZ+gKhJ24M1oqnZH1UuDTC4gJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVGUkmKxvLjRHxJhMRv+UV3GUca4VSgrJlTunob++zCm6ToD/J
	qskMT30wjOmtAMRr7VfhjhQWwhRqczvRW8GRVkoILGxf//gc2salo/kjl+KHi3Ag3zc29xnIqo6
	wVgKYg8/sp4681aAt6Q7dqvEyZzWA3GkcoFQz
X-Gm-Gg: ASbGncu/aNOPc1LGF5SMUhPtwkTLVBzxD2uk74u9Bi43f8WpXGuc5Lcupj6G2N1/5NE
	w9R9ofMuE37kg3j0FE5EkZkZU52Kz8D13tBB14zqDcwQ689m6EX/c3kACMISOwwAVTycejm13Pe
	EIH+R7ATCAP8CMVLcpqvBSdKJT/HV3Q0uKxiKRws8Vqfwvv2j4gDJNW4PTnxOOrHP3OdYOij0Lj
	xlHDZnnJDi9RyCp9uJaLw==
X-Google-Smtp-Source: AGHT+IFIqpmViQQPAMoz9A8CgWPtW74p4X/bJekUGHNRxdcVs5bjkGSvAitsvNLAJCN+CgYdarBLE7R9a1p3Lo1pKgI=
X-Received: by 2002:a17:902:c94c:b0:234:914b:3841 with SMTP id
 d9443c01a7336-23f9821d17dmr2411785ad.39.1753213203378; Tue, 22 Jul 2025
 12:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-optimize_clk-measure_accuracy-v2-1-cb121fd57e6d@amlogic.com>
In-Reply-To: <20250722-optimize_clk-measure_accuracy-v2-1-cb121fd57e6d@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 22 Jul 2025 21:39:52 +0200
X-Gm-Features: Ac12FXzqGorcphSDKwJZcIy0MTfbMgQR4dWhRz0iZJDpFAl1w4AsnBzrEgOES8M
Message-ID: <CAFBinCAvLzDQCDh6z9soDiyq4sBXZ7XUQf3-Np4pFZTPmHN2AA@mail.gmail.com>
Subject: Re: [PATCH v2] soc: amlogic: clk-measure: Optimize measurement accuracy
To: chuan.liu@amlogic.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 8:09=E2=80=AFAM Chuan Liu via B4 Relay
<devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>
> From: Chuan Liu <chuan.liu@amlogic.com>
>
> The cycle count register has a 20-bit effective width, but the driver
> only utilizes 16 bits. This reduces the sampling window when measuring
> high-frequency clocks, resulting in (slightly) degraded measurement
> accuracy.
>
> The input clock signal path from gate (Controlled by MSR_RUN) to internal
> sampling circuit in clk-measure has a propagation delay requirement: 24
> clock cycles must elapse after mux selection before sampling.
>
> The measurement circuit employs single-edge sampling for clock frequency
> detection, resulting in a =C2=B11 cycle count error within the measuremen=
t window.
>
> +1 cycle: 3 rising edges captured in 2-cycle measurement window.
>     __    __    __
>  __=E2=86=91  |__=E2=86=91  |__=E2=86=91  |__
>   ^             ^
>
> -1 cycle: 2 rising edges captured in 3-cycle measurement window.
>     __    __    __
>  __=E2=86=91  |__=E2=86=91  |__=E2=86=91  |__=E2=86=91
>     ^               ^
>
> Change-Id: If367c013fe2a8d0c8f5f06888bb8f30a1e46b927
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
and with the Change-Id (sorry, I missed that part) dropped as Neil
suggested also:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin


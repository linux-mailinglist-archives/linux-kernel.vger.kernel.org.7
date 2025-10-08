Return-Path: <linux-kernel+bounces-844995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 911C4BC33D6
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 05:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A028D189FCBD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 03:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88FB2BD036;
	Wed,  8 Oct 2025 03:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIxnlv6m"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F2B29ACFC
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759894637; cv=none; b=L6D5XbPhvJQclNkGTHA89/TOKsqIaKptVSveDKsL5kVrK9r+Md1uS0e9PFvN48tquL++IsN676T0iD7RqqtNxEzgrH7Ls+ymcd1tRsqbyqqIP31+kFl5maLubvfB/bP92oDf3H9UzXcd9R8kzfzPfTPyFmX0TUsn5AQo94X098w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759894637; c=relaxed/simple;
	bh=Zx04ah/IYXegpf5FVcljzAJSZIUmnHslBnom7Csei1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuohtfT5lLfdERFqrZw4LPeBeDaHUUHRcXP6pP6WAI2vWSQNVRgAQRRN6E8OjVv/R5WQaKYfXcRcvi6WykUbMEehwzCk4wv0XS/kjLPHdG75dSFt7WWMEzoymKQSSy5s+ZaYrF22p9J/35BJv5W8owvkaAlWc8i6bXCu9e/4rqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIxnlv6m; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fca216e4aso1206190a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 20:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759894632; x=1760499432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zx04ah/IYXegpf5FVcljzAJSZIUmnHslBnom7Csei1k=;
        b=YIxnlv6mCJ6ehncdiXVji8DOVRDffpIvwwovJ6YMRDPAxO5DOyRfJkP8eF0sFFNiJa
         wmztyNwzya6ckbQNK1VLqfkH+AedpxEVKbPD3gUrLJGOmVAVAJE6bn7f7i+HnUPCvTVf
         gyMdKLsY28D38z6JsrJoye/ZDpWNthN2hsmpkwHPopyZkY75+eYaxj8nJVE3nzvdz/Zd
         2iCZqir2Jet0OI278ZvKdqZSmPKVNtI5gJKtAl3/w63gIrjZFC98FIrfhncVLWoMI1gg
         H3DV21yHajGyurWsR8S0Wvdovgnb/b8UM88uckQYGjkMpxrWjula9Pz8DDHPPYyhhOcA
         PB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759894632; x=1760499432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zx04ah/IYXegpf5FVcljzAJSZIUmnHslBnom7Csei1k=;
        b=VlRxwbeaEqRvfTI8h7XZjSA1eWOTUv/2fku4E4e5LU8Pcf2lAfj/YLTSl8RGXdDeR8
         O7PHsC4YNX6lOM3bOSkGOI5wgJHEw/jIGVXH/Hlv2suEuqiVx+5Bj/PZ2nbOQOlsSpVM
         zG9FAxKvjwRZu+G0QzBiIiJaUupG5QtMGCCOrVpQHx5hJxbVo6NUdMPxUnhGlM1aLE8D
         uxIZMajLL/slQJb6c9Mg9D4M5lgQnvcNWFayiHyGhAyEA+BWvtA9Qphf/6037Odx0IP8
         kLXcRAMS3DoNuoEMmIK1DX3Qlqaoruw2T3KXsmhcj4NfNN75IWytjt8eC+fwnfUGoMsN
         Gh+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWucWYqbrFhBKY8oGm8NV6Sv4UrajEPiBVfILP9dTZPH/RCP0j5qBfivqdHiJEY1R2gH3eB8JuV4dL7cbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLJPwapGqkyE545QeKL/r9I5jIo/gG+N89A1vruJ/PzDUM3/25
	IB83PWRYCrA4k3EfeRuo5T9iPd95lSh5lRYrhnTD+ZPTbGDFL6R9wHYZo7+dYTxw3a19b+sdgwL
	CQG4BRnJM4r8uOKQSCwnQ/ERgbXOI4aw=
X-Gm-Gg: ASbGnctCcFd99u0ECR/OrHG6PocQ11rhw2Qv40AeowB7/4p44e57kZkAPUXOFAgKc3o
	Opv5uL3X41lWGAPR9aBUJM+1O6i5l6GcyoYB+ACw0ZP8HTLK5bo2Vnu3Vkudm2iXqhaa+HoYmcf
	R6nJJmjBXX4hwMwIyxbgKYwFKrG4G8djevcha//g1mgOOXKZFfSrDaE9p8h/dZsNdK0Z+/scCfz
	rQk/pr3IoUapf9aQSRGWXVcdE6x3SMli2bGSAlvpX+3LDd5FWf4Kvm3O188q+pZYg==
X-Google-Smtp-Source: AGHT+IFdakwpHCbhBv8L8ewQ8YL1xFOcXFkqwuOUaP1m0nKJBrxbVsaF6mhz+pLN4b219pRES/JDwQc0A3VoDQDnZvo=
X-Received: by 2002:a05:6402:4019:b0:639:e04d:b0cd with SMTP id
 4fb4d7f45d1cf-639e04db5bdmr313287a12.10.1759894631994; Tue, 07 Oct 2025
 20:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924145552.55058-1-sidharthseela@gmail.com> <c87d45dc-d545-4359-9e2f-11e43a45859f@linuxfoundation.org>
In-Reply-To: <c87d45dc-d545-4359-9e2f-11e43a45859f@linuxfoundation.org>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Wed, 8 Oct 2025 09:07:00 +0530
X-Gm-Features: AS18NWAJtkfAkiglYcQF83q4sQMGaqHzh0wb2Unau5kJ3UCJfzcYdxQwGuDuKzM
Message-ID: <CAJE-K+A_xFPPDbPFQiOwH5nUJdrrGHxvV9xVppXWTNJ5g2bUHw@mail.gmail.com>
Subject: Re: [PATCH RESEND] clk: at91: sam9x7: Use kmalloc_array() instead of kmalloc()
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, nicolas.ferre@microchip.com, 
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	varshini.rajendran@microchip.com, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 2:36=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
> This following line doesn't belong in commit log.

This was one of my early patches. It won't happen again.

> Can you add details on how you tested this patch and also how
> you found the problem to begin with.

I used grep to find instances of kmalloc and went through the ones
with size calculations inside them.
I did compile testing, My mistake, I forgot to add request for test.
I would like to retract this patch for the same.

--=20
Thanks,
Sidharth Seela
www.realtimedesign.org


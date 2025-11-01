Return-Path: <linux-kernel+bounces-881035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C0CC2741C
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 01:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F9B188E5B3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 00:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDB0BA45;
	Sat,  1 Nov 2025 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K6ve6yBI"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695EA9460
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761955914; cv=none; b=HrMYcd88C5+bJkj+XJwl+tQ19dM0yQVlHxfHWRKefKg6WaqBFlmD0rmfE0+/g2o6agdLX0/Rk+goEm+txNaWbCNpjAnAerUzx0cTI44/DeLKojIEuHmbhZaHkCfzuVT7kbohmyxqzAsI5vD2UjUZuJ6MWndCue3YUEkKpxYgJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761955914; c=relaxed/simple;
	bh=G8GGH+DzLeaWAVjvUcIyP2G3TxJBRYYWIEMQk0YRPSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q8uFc5/YSJLpraRcKZdL8rsMOHTXf35A9cGQJ8rdOxGW4+DVjEsfQfvWXi9HFzHlNknweB0YCZcnosxkOTAoOYyg1Oqrt2OlQkHU3rim1d+OBi2KXUgHh7c+Hgg0oaiiNewzwnxd8B3hAHl0bKkQY7v7ufRJ8NtY6pnMPp6gcHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K6ve6yBI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2951a817541so21532045ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761955911; x=1762560711; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V/s4y5cuNxL8FsDBdrJWBU27/UWRqV4cJIPjop3kalA=;
        b=K6ve6yBIV8TohNaI2bQji434SV/7IFPsgmE8zpvF2pSNp70POWDtvqSRmQ9KggSPlj
         TJNwsc+KXFWcirXFz23333Sm2ODYOabtfQLJHullU4iLqtUt73DwJF6ccSgERrJIw7yI
         xZ8Ci7W2/YgOwfOb1nzNbcIaIbZUd/idpdVUrTQCy+3JBeIGWPdPIwJH2xgYKtWwuHc0
         II88akRtg5jt1uCBf1Cc4QJC8/jmTG39C1F2bGQp3psz1KnwGw5kKP5DkFBKtsroAurl
         mgz5E0NAyynsOSPKI86kUMJK5lMB9pvnangDg7qE2ikBzVDBh+RjpA/SiMVNl4YVYmtq
         vdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761955911; x=1762560711;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/s4y5cuNxL8FsDBdrJWBU27/UWRqV4cJIPjop3kalA=;
        b=fWNbgOGrTRyBuqg5dy4yjVX238WDBShuMJMjId6GIuS6tK5BoihKFmUVjDZEQmmOLH
         p7oolQEd3DyvzXPCpgOOdxJbbfbGQoGfei2mTNTptb5cCVG1pbQwZ6tKa9/R99edUS+x
         KR8H7WKhT2tYilb7qk5sduUFaONb1OI02aoYtkNS+FK1MdB31Yvf4p0F32ppC/pkmIo2
         Yt0MYWW2KqK6IydM+As6q+g2Vz22QvFA1TtOuOTiQcID1el7XjlMwc5qmHLTMVPPBOeL
         hSF0hdtvNXOM7bsUJvEiDJAFRVlEJkDHI7E8p2YSXeWWLhBdi8y09cvPGcqlJ9An4xCo
         9UJw==
X-Forwarded-Encrypted: i=1; AJvYcCXnzZL7HsfuHE2eqKSQXWsBtOLBFaHuxQYOdcm5/qL2CCLgeBPO13NwUB0rZ4tlQ7/h6/Lf4cpHkfe9hOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFvOGyiVvUYDJbbPz1T4WeTnUC+wVd7Hf3dAiMpTsdcyTDaysz
	45HD3WbGoHTVDsvAIyc7coMeuTyNFwokW8nx+dkwYswlowIJQHgHTx4MtUZcyiPW5Hw=
X-Gm-Gg: ASbGncvPSRqZFPQd2g1wZy1sK5Qs7XKw+vSeQI62J5siUQTAkXYxk2KelVqbZ5egu2b
	kwd3OsktrF/ho2nVFRsFP1RKHwQZGlksqi/yLSp5k7mxYJaa6uMGVvA7932xrfNOEuVdx1405EC
	CTX3YTQjrbaXRPPViisAIMBVMuj4W3JlZGR81kfcvzfHnqG3mp0ISrP1LsGrb95GZmPjP088MWI
	APMmo+saIzupfeDf3lYkAG+fmJ/gA4fIDOQKDVNICPdFo5vRBJgYEpSesre4wHcJ5Ai+AFXGkFm
	ZyOdAMrSH1PDRYlHWLOSSjLLnHhfX4MbH2Szj90r4QQq8ZA+bHb7PiDNh2lDk+o+17CcWBWgHq6
	r6yPvsa6Gtmitj7f3BSP31Ej/tVZnqAWtlvipe+lo7oQPY2YWIvW3xa4UmHWtXIenY9XWP1wZFw
	==
X-Google-Smtp-Source: AGHT+IEvGy47Ql2gEkm0LEbjEzwkEfQXMOVMT6a+RnXnMO8M34MlklHymKv75qF0V+sHnfNsFfGJcQ==
X-Received: by 2002:a17:902:d490:b0:295:2c88:e1c2 with SMTP id d9443c01a7336-2952c88e1e2mr45755415ad.54.1761955911531;
        Fri, 31 Oct 2025 17:11:51 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268716e4sm37151005ad.9.2025.10.31.17.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 17:11:51 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra
 <peterz@infradead.org>, Pavel Machek <pavel@kernel.org>, Len Brown
 <len.brown@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Saravana Kannan <saravanak@google.com>, Maulik Shah
 <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, Dhruva
 Gole <d-gole@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] pmdomain: Respect the CPU system-wakeup QoS
 limit during s2idle
In-Reply-To: <20251016151929.75863-3-ulf.hansson@linaro.org>
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-3-ulf.hansson@linaro.org>
Date: Fri, 31 Oct 2025 17:11:50 -0700
Message-ID: <7h1pmik3w9.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> A CPU system-wakeup QoS limit may have been requested by user-space. To
> avoid breaking this constraint when entering a low-power state during
> s2idle through genpd, let's extend the corresponding genpd governor for
> CPUs. More precisely, during s2idle let the genpd governor select a
> suitable low-power state, by taking into account the QoS limit.

In addition to a QoS limit requested by userspace, shouldn't any
per-device QoS limits from devices in the PM domain with CPUs/clusters
also be considered?

Right now, if a device is in a PM domain that also contains CPUs, any
per-device QoS constraints for those devices should also impact the
state chosen by s2idle.

I just tried a quick hack of extending you cpu_system_power_down_ok()
function to look for any per-device QoS constraints set all devices in
the PM domain (and subdomains).  It takes the min of all the per-device
QoS constratins, compares it to the one from userspace, and uses the min
of those to decide the genpd state.

That has the effect I'm after, but curious what you think about the
usecase and the idea?

Kevin


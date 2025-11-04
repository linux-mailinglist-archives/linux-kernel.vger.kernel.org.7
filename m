Return-Path: <linux-kernel+bounces-885562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFABDC33553
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084EC3A9B44
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7774B155CB3;
	Tue,  4 Nov 2025 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dgVOiRzL"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405253358D9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297619; cv=none; b=WdT3Y5sNWbHXsG+HAxY6yxkSRSKxnfmUxB+aGTNxn4F/F24pWyGdsfnePf1HlnL/bdVXBKr7Ez7y7AFwYg56PcIb3AASjvAudyecVKVjIfBDXuiZ5s+L8Tx7lS49bxmyrLGp3qXcN345bfXOnh9mWRo48s9AjdzOHypQ1uHe624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297619; c=relaxed/simple;
	bh=d26NPWY5B0QwqopCWCmqCngKo8m7gGixxk1s3JgrrVs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gn26Hn67+8bEJiIUFxBu50yCJ4Kwouk9PIjktn2v2rEwfGDhGEte4HzDpxgH92bXlDDgBAGP5hpaAZMsTswbiZkqSRCyf2jtgkiL+OQK6AfiFudymgtXj7NN3RJQf7vkjwlzFRSUbMlPpMn/8eP0R3iyEJxtj/SAVWTcq+jDFwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dgVOiRzL; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7ade456b6abso510939b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 15:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762297617; x=1762902417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBUGFvGes6ovSwe2/jP44ZHjL/4hLJHicIf8lTH0o+U=;
        b=dgVOiRzL6kyXOnweIfY10BUCDIDJuXO7QserHLyRXLE95CerlXIUOVjRwtiQeJU2b/
         +kshk+hwcEdNpEEoud//0LLPNda7JMxZhvJlfXdKx559gMfxg2skOV725hlM4O/mx4yj
         LVtjO7d44cwVj0lDgfi7ThbJ05vVfUqJdpqWR6s+Q7Zn1socsh2RQpBg1scDCS2WKG3X
         mY5UaNWsYnKgePcOUQ04EZJaIZivFBCnfYcXUcbNap983OC6JUEjzXIcdHttF7FUjgdW
         tN9iPLRnYnzotFlR77vpbrwr5t5dvdDQo/V3oR06sVx1mq3VPU84sgocFEv0MNw6uTpk
         M8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762297617; x=1762902417;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBUGFvGes6ovSwe2/jP44ZHjL/4hLJHicIf8lTH0o+U=;
        b=oIXZ9LyLvkrHU6560MLfVZ24xxBaDFgVrNq6ocEMdJ0/RyRevIowWRex3dIAjTKsya
         o1acQsi5JHOifMeiaeHzpvfZ8ET6Hd6H05IC5n02BC4zyo+xeeo7LrRKcN/cp0r1r2Nv
         UGaFMESairgCVywxSHgDgxF9bIrvSbdSr+vZdOBW4ZVQ/tXwFZcIw8NN6e+lXj17aVWi
         8UqupBqf3pe+MB+lm3YQY6ndcX8cjQQe3Qn0OKi/n7oHkDRQd/9Ehb+bjKFotdTSKCAp
         49BJe+R/O5gnyoiilW0RZL9gbFDB8gjQ+st7tSLR6Pho0DahxrcYEPljCkBLCYDSiDVG
         o9Wg==
X-Forwarded-Encrypted: i=1; AJvYcCV9aPbeI3UbfG6eypPE1u+IJ6CKqXfWNEXV0K1BcgHURPJn9wDgEM36JDL3KXDXxrEqd6LsAj7gcYqoAYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEloabfK6IFUJR8G+tfJ9PLEACS+RtkxCrCfZDSnA8rVJJt3ay
	OJOk4Ib00Dewbgv/VGGXnh7o6wHD9ozbXnK0WLQf+qy6vUeIJeGG+Ew6e02Pv2bgyhFOAB3pus/
	77ovw
X-Gm-Gg: ASbGnctfyTNMLUapqddTx4nGDy73Rn7MRe3JxDmtK4Tp9gSzueBEF7FV/pqujgVxp6F
	nc2KOi9GJu8KwEZwxtiwkv88QzGpZeGWCY7qtwDP18oPwd7EaInf1MFJRMJ9uPVSCnjJILgmdna
	5s9zbyEQpgbVE4jLS9co47zDH91XINl3By5HIcUtas7yN2PhyMpyfQ44zF77JnYt1GenTqeb88h
	1sEKyHhHZTtCOdiwkmSXXQkYXxK496JYVPNdpcvCIixtx4HutBGiy0z+EYrA9d6kRkZd5nMqbfb
	qlp/0T2oXy1OSghj2OE4Rq/mSmiU6HEmlH4iWCCFRBY3xw3enoJDjDNmI2MBC7lxOMtkMLqzDef
	qyWkEZoyHhVAr3vAPm3NRYb/oP1jl8c3OV/DenP5I8GTrciB/teTuDOFUr5IUVWznxdnl+oqdWJ
	0jyfaoxxw4
X-Google-Smtp-Source: AGHT+IEZzCr5yLCkNIU2A9c7a3a/8wKK5qvY9hQpk1frk3eObQX/JcBmBL7BTk5If13X/8QPHLJfMA==
X-Received: by 2002:a05:6a00:1496:b0:781:9ae1:1be6 with SMTP id d2e1a72fcca58-7ae1cb6472cmr1244855b3a.6.1762297617416;
        Tue, 04 Nov 2025 15:06:57 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd3824e5bsm4143988b3a.17.2025.11.04.15.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 15:06:56 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Matthias Schiffer <matthias.schiffer@tq-group.com>, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250825131114.2206804-1-alexander.stein@ew.tq-group.com>
References: <20250825131114.2206804-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/1] ti-sysc: allow OMAP2 and OMAP4 timers to be
 reserved on AM33xx
Message-Id: <176229761651.2840692.2154178445405105304.b4-ty@baylibre.com>
Date: Tue, 04 Nov 2025 15:06:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183


On Mon, 25 Aug 2025 15:11:13 +0200, Alexander Stein wrote:
> am33xx.dtsi has the same clock setup as am35xx.dtsi, setting
> ti,no-reset-on-init and ti,no-idle on timer1_target and timer2_target,
> so AM33 needs the same workaround as AM35 to avoid ti-sysc probe
> failing on certain target modules.
> 
> 

Applied, thanks!

[1/1] ti-sysc: allow OMAP2 and OMAP4 timers to be reserved on AM33xx
      commit: 3f61783920504b2cf99330b372d82914bb004d8e

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>



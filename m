Return-Path: <linux-kernel+bounces-803872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A2CB466A4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770C5583A50
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A202F3C27;
	Fri,  5 Sep 2025 22:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wwU+PRLJ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E067A29ACD7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110941; cv=none; b=DVkvKIOLmEf9n/58/COY2lhzqEib9mUpH30Qis3NnCrTswmtakqSeCQQ5rNKWi/+cwdB6TEb8mIge2zx8WpGafrfcY2kxN/A5B84HP1MjFJaFBp9V0Bs/mWOOAIE5cGwEtWKNJzlTFaYHhxhPxdkxn9y/x64xv5+MMg6tnRuW8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110941; c=relaxed/simple;
	bh=659ccuPtSirr1zl00uU5A9iv2ysWSzQ97IzY0N3/LQ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MXDu3LoGRJkU3kcFACsaDfgclMjuKEHkuJ9cvQJWIZc1EGOJLkw9Md6JXZXmwcnIvARFuy3z3LaWqpegh955h1aqEBTehe3UE4Fkuh2WrPKtDuKzeXp4rSP9ZYHbppehfHXk1gTNqy1zca3Ka0pz6e2VRsadjDUrmE6ynMihoZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wwU+PRLJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24879ed7c17so20946045ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 15:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757110939; x=1757715739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sg9V7A+vveZVwEgb6/4ZFeGTdbh9RAwHCgZXiFP+1HU=;
        b=wwU+PRLJ6cY93mx72ruoWa+plZJfmNDw0FkrC9Uc3/03PufF8FtvLY2XeuhSB7NAt3
         I2tWnWFVUPRcsxUq/PVK2UBRHRpuxjxQyfP/UQEpvy/8DSzilbQKtsbA218l09M6/w6l
         6qhW1vvgFCKC3HKhvs3ye5JaAGeNAsKf/eqvtGjE3dlZGY7TMCIx5CyIzHjSalI6yVzJ
         RG2Vvz6Md/bIq1Vl5O+F3Ai5sbhMUYLfrLGsW6ZRsw5Gh/UVFGasPqglA3KzMN8zBEc1
         eVVza+kQYfInl845IV6eOevZ0hHa3NljwUy7zE2XGTwKI/h/z9ggMrAylUEx6PjsUTcw
         HyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757110939; x=1757715739;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sg9V7A+vveZVwEgb6/4ZFeGTdbh9RAwHCgZXiFP+1HU=;
        b=m/hS39iOJqs1NZ7+CwQFSQ5fEGCrFd8RqY3OzHTVpyLeP0mEte5opFB8pl2CveKlbw
         ShWlum2cGJNwLEeVW88GPIGylBCf3Hg0FMDafQ/Wdr/0x9wS0Z9cNafYo8O73mRAsI0a
         Hlj4Z1dabt60d4+Z6SWxWnKkpn8AtaygDZK5qp8zYB3zGLp0BSofstkksAJxDBxEmyZ8
         w7BX8Ie22CtCEi31g/6eB0/6BfRubBJSlcBADv4J/osMQD6/pB897h45wQ4uwDv3pGiJ
         uIwJHxRpGLWERwdPvi5Kb6eIdRzAw4WRGyaV5AVUziZDeSewOJjxJmpNoS7OEJDKMQLy
         opGg==
X-Forwarded-Encrypted: i=1; AJvYcCWIJwJEKpkenGAKEhT12GPNJ+PCk68F1/llK1Mcg7HmpcYKwEB/uH6/ZFs1jik26jwNVM5CFSoN6XriL3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxThugD+qNxmNqcL15oXWePDQ+PDNc9uFY0xFWHFZnxUYfR9CsK
	jZ0eBVgPIylE8YNRboBtjS2+s5yAuG9Vxi115j3qkdibfpHLtaCLHIJv/smRWG2Vtb6GEqLi98q
	fEwzP
X-Gm-Gg: ASbGnctaXaWG2HKFNOFo8SXXqMyYPSklr5MkQQEO/v6X2Q+H95k4wwYIU9ujWJaLQ7/
	D0ozuICTVYp0r8r4BX4F9BEeTb9dyjlUK8rwSlem/pv5+OSPxv6XI2p12zyiVUd3ryAXppDEawx
	d4c1ZeyHTi3JneBL4CQrg4JBTfQSZmhIgZLCPlXT+JZNGaB9adgqiY35Jy2BN0PK9C1cv1X+ldT
	m5tPo1oD+osdM5JTmECt/rw1VxcNP2bS4yeNjLsrJypBUKw/V8YzgXp8JyutuUK8IUD6dI4O37x
	JPqMNPZqjuR6SaXRE+xbT14lr+P+80xaKISvCk8rQMZGkjxASLEPPU/1MRR3yR+qHCEhi/9E78G
	GEwaRRLmwRStUNcfJ/O9kgXShkaZ2J1k=
X-Google-Smtp-Source: AGHT+IEgDKOlBK6x0QOw3W3CHGpa5Cc8uz1T8qU/XEUIc8y0zuEtK7ONrjwU8Ktw48bTs0lLqjmlXw==
X-Received: by 2002:a17:903:3bc7:b0:24e:e5c9:ed02 with SMTP id d9443c01a7336-25174470d47mr3109805ad.54.1757110939089;
        Fri, 05 Sep 2025 15:22:19 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329cb6a2ec2sm13579564a91.21.2025.09.05.15.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 15:22:18 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
 Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Miaoqian Lin <linmq006@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20250902075943.2408832-1-linmq006@gmail.com>
References: <20250902075943.2408832-1-linmq006@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: pm33xx-core: ix device node reference
 leaks in amx3_idle_init
Message-Id: <175711093813.666031.2668373270360080348.b4-ty@baylibre.com>
Date: Fri, 05 Sep 2025 15:22:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Tue, 02 Sep 2025 15:59:43 +0800, Miaoqian Lin wrote:
> Add missing of_node_put() calls to release
> device node references obtained via of_parse_phandle().
> 
> 

Applied, thanks!

[1/1] ARM: OMAP2+: pm33xx-core: ix device node reference leaks in amx3_idle_init
      commit: 74139a64e8cedb6d971c78d5d17384efeced1725

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>



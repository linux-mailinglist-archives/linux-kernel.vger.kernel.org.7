Return-Path: <linux-kernel+bounces-762816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB759B20B21
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F8918C5C10
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C95D213E66;
	Mon, 11 Aug 2025 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fe4vvSYH"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0269213E74
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920911; cv=none; b=fuvf9wNyVF8oDU2INuIzpGDl3huOxBWWnOEjgXVguojyyhBMaDNgf39QFyhtBU9hKIr1BLhBsQIASB0bzWg46kGf0oEK9QHYftWKverpssBy98xivNoM4yVqGPNTfJtAonuw1SjF65RiOSzqeBi3HAvWR9Pdcq49qqghO+z4oaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920911; c=relaxed/simple;
	bh=wpWRq9lWa+DAIkUGC/99XuLhmwZ64WJqGihZA0nEgco=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PysYUWf1vf4nKZaxj6yiaYRNZEqMCndXGdiU+TFFKS4syHiqufyLc+eBOSiqSYzE7VbgFjmDJjghIq9ahNPjOLtQxbK/m09pClr+0uUv/93UjRlij1cIwjhvhiZP8wqp4e9pEZynUN3f3NblMNHx83nwakUdfUrfed6mQWWk8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fe4vvSYH; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3218283cf21so2390981a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754920909; x=1755525709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxzfqq0wX7ihIYD40/KuEi0QaM/6IHAFXiB/aKCGEZE=;
        b=fe4vvSYHMk/NGPpeXRWMtmpxIMDvqjFKAvGnVXr4GvuuD/aCPRt8CrtXGB8AH3mfdo
         oVxsbAg4B6py8w7RrW884JHVnxOHLXnEwjN+ztjAD26zHzkB76TMqBzWNTyYTFV6q6PB
         eLs6M35HoJfpzk42h66FPaDed84YaopVPPMzN1SzR8clSoG1HcqIqIBnPCBWqs+AAH4P
         uHPhna87FSznGkv7P8UzdgPD+WHxlBRbNUQhkCHcyfIJctSlVMBS9cYaVgm/iQScFO+E
         bP+z2YIMNSLe868IZec/zrXcFGIUwXqFgtE8SJaDi/qanixdaNl3waqFHpUAvp+Ei4S9
         hW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920909; x=1755525709;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxzfqq0wX7ihIYD40/KuEi0QaM/6IHAFXiB/aKCGEZE=;
        b=rnfV9+3syqZpYZK1T1w2hEN2346+QLLWRHUEktOGydxtiAZKpvdmqFXyAxV0So5vIY
         F0frIcYkmH9LFYs30KNe5gcinNgDcLmNezZ+/me0FTIEb1vGebWLnCPoV36ReO/2n/t9
         ocQGdEjYzVwcdqqg2KvA6e1HvxDOvbiCaGchrFljjJjLKyim4LuZbxcdfXm+NSW3N4Bg
         Bw+pzjp1QALHaBL6sh88+rvkXInrkg/6wY17dvIApdYf3VqUcEmXTcy/MUeXtaKXVK1c
         WwF8/4xw8ABEVOrZUN5IfShUiZqK4lAjYZcITwD4NwnkF1YODNQ0zbQAW1WVPWHfsaIa
         h9DA==
X-Forwarded-Encrypted: i=1; AJvYcCVrJoiy6DBzrMTU21RikM29nqOlSxw/Je3FklgHDKtkVlt1vI81JowK7pIWu1IGqrp3Ms+oy60ucGJoat0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8hu0Xj3YilBzKhR/e8M8jLsayBhg7hZZPfyIROHXYjEccjYIY
	ddoqJ8d9NrV2w7SXk2oDzwKZv2wpH2z5mGiRZt1W+Nk5CJBGKIit6oxbs8uAdilMlGY=
X-Gm-Gg: ASbGnctCxz4Hv8ctkJE6DhNGNPm14BrqJf58RqOuCMbBEBezA70xgF6zebZ7lW2ZPbV
	fjlNKHlQb3DbjYpoH88w+JRlEPOj2htITX/PAfgp03P1mDC6IaY4fPXS+WTb4OW8M7WtGAJ9Wrh
	FQCvR8hLTu2QXGmOJVix3VTbDaVl4DQUqQ9SqmTgAMpmdbapCmle76C8wxMV9YRhjcbUlFgQZKN
	F6Xp2Itmns/kwVTPRDUMojatwRblwIoRcxZeV0+JlADKBde0NIN2zvvreJIbm2DMg/TWKJPFrok
	OWVQDsfvIhwkbGUrpzTXnHcZh69PZ+L0a9JzeQAMnj4poBtclMcjdUAu2KK4+F0obpnjnhU0+1z
	s04e3pPvlH/5DBjs=
X-Google-Smtp-Source: AGHT+IFYAdi9oz+XX6PvaUdl2rhcqAjpMkKXAAMFn0WpQhspYxYJUYREl3sf7qAAFMAFeXroFXUnDw==
X-Received: by 2002:a17:90a:c105:b0:31e:3f7f:d4b1 with SMTP id 98e67ed59e1d1-32183c461b7mr19933233a91.24.1754920908868;
        Mon, 11 Aug 2025 07:01:48 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161259a48sm14821216a91.18.2025.08.11.07.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:01:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yu Kuai <yukuai3@huawei.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250811081135.374315-1-rongqianfeng@vivo.com>
References: <20250811081135.374315-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH v2] block, bfq: remove redundant __GFP_NOWARN
Message-Id: <175492090666.697940.8178912057347940228.b4-ty@kernel.dk>
Date: Mon, 11 Aug 2025 08:01:46 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 11 Aug 2025 16:11:35 +0800, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> redundant flags across subsystems.
> 
> [...]

Applied, thanks!

[1/1] block, bfq: remove redundant __GFP_NOWARN
      commit: 8f3e4e87b0945aeea8b5a5aa43c419f4a1b4ca6a

Best regards,
-- 
Jens Axboe





Return-Path: <linux-kernel+bounces-755386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06BBB1A5CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DF317F9F8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CC021B184;
	Mon,  4 Aug 2025 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Kntd5a7H"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517A51FDD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321006; cv=none; b=BFutpHnTw628KwoZXL7kw34QwPkVtCeq8jhRIyegRjHLkR3IVF9G12LHDaIjyO+lZM9q0S/AlrIh3bywjw9bJSBKd0gDnz96/ZxuN6bAU3DP5YRHcs3UTZyzjE4GwOzgoiFBrmOHp0cq/xNvWoDPgx0ShI0de7fuo0dNeaVq9n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321006; c=relaxed/simple;
	bh=nFoSWOWXDMGmzTUxtwhpB70Bmfd3Anx6RywJYHcDP48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dD56y2CYX7PxPOaLNIkXXruqKLSAb/SmBuXlzGRbCMIp7ZNnlABOb3ZDS3eTsRb1+8G1nV896b6Sy4vihSnEyFo6JfGrj0Fv62MPZ81iJ+kyk3C8mmpCu/DxE+eM1tlYsfEVuxTlXewMrftya86u+eU40Fb7QjEEoTj0oMJHeXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Kntd5a7H; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8818bb36b5bso38263339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754321003; x=1754925803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqdX9vSM7eNyAqBUevvRqDXoCJdSwPaqgVdWOxEJdM8=;
        b=Kntd5a7HCZ60vQ6jKwe/HzSfHEUSH6Hqsgr/+yqEQeTb7GCwkCeEzLRUAFLFPswcXF
         NXrpcquIAMfFBASjwo0qpvrMO/6MTvUBpg3KtWEWTiEzgoc3PxhLAx57pcNfAVzVoLer
         8e3qTc76S3DOaeKyI8A/J9cEXvZP5BB+mMTgYMZuonBLsFdOgI2MCZ7kSOCvm6F2qrYU
         2x12QJSQvnP87XD+TiJVEbVo5EhvfMHxQMeXWGHvX6vHoEXlV3R5qmM4dGYVecJT/e2D
         4xx7zVCzAf0ijgboihfEAzlGJnYTO1ByygHksGrhjsWEF6ljT0+bOW/LRKG1X6rx4R8z
         q8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321003; x=1754925803;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqdX9vSM7eNyAqBUevvRqDXoCJdSwPaqgVdWOxEJdM8=;
        b=fLzh536fy2gZKlRMTWkoERCB7O77WHe9o0XGY1WzYZU3N7DwkwEKI/QigWcCN42Vr1
         3Qih3TEGUctgjF2BHe8JQV4CNY6nt+UoyVH/cVqer/87bb5KE7+/LLHL989OCLWbZXuF
         NSPBe5nHUCvQt8TLSCcyJVg3JdYbXpOlRyuWF004B+gs1fuf9XGSqmRVF0kKLLMmqncp
         JsK3+xeYK+EPsb/SEaj++s8FUejD8pt1X7Vi8JzwpVY9g07CzcmjDAUVW73s+cNzsOSU
         +9DMDJCB7fqE2jd+U8FeR4eC6kRZahuffMoUiftsOXPslq3ZLk6ONJbwL7fanCPJYrZT
         t4MQ==
X-Gm-Message-State: AOJu0YzabS2JDB4z5dVWxQbY5h0QdpPy/XVY5cNr+4XX3PhLS2nE+Io9
	RuRjarb+N8rrLQQcZvWqfKTicTDTVUkvA73tKoBqgwwL7VTfFE5ktuliE1DZHhic46g=
X-Gm-Gg: ASbGnctyCtHt84hlguSCMfu1krDAqPwcI8LTmyBtz3bVNHeAwAEbcZUS+nWx4EnURFq
	U09YYxpueidEodC9IuLWpj+GnH8vTdwZICwZDDER0/CU3113y9rcduc+8xNRkqG+zd6MLo5/N9u
	J7gonCOvqa989FhE6AV61AjMuaPRu2OI0TX4qpR8UldGAxQyxJL5Cewknv9PpYbW3V+nO1WR5WH
	KP9PjGhtXpO8RnxLOK67ROJFP/13PJJgFSFfpbhLY6/mJW1m1RBr1BBZLbxzeS+qJzhw1WO9J1i
	++fIIt2daNoA9jzYxRVZSmQTS89ZqVAKaF9KNa75p4nynJPKwyl/+2ZApil4MrCce/b9QGzqcTj
	ElqR32Q/jwA+debj2/pHjTxe6
X-Google-Smtp-Source: AGHT+IFO/lBsZcG6giK2HvXNUrdqdWnLNJxiI9UMe+z+3+FeG+OeKUvDv52bgS1CZJVtM4/52xm9Ww==
X-Received: by 2002:a05:6e02:184f:b0:3e3:e732:aef6 with SMTP id e9e14a558f8ab-3e4161c8834mr200857775ab.18.1754321001188;
        Mon, 04 Aug 2025 08:23:21 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e4029a1553sm43241475ab.14.2025.08.04.08.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:23:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yu Kuai <yukuai3@huawei.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-block@vger.kernel.org
In-Reply-To: <79394db1befaa658e8066b8e3348073ce27d9d26.1754119538.git.christophe.jaillet@wanadoo.fr>
References: <79394db1befaa658e8066b8e3348073ce27d9d26.1754119538.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] block, bfq: Reorder struct bfq_iocq_bfqq_data
Message-Id: <175432100029.20578.5554580525847774271.b4-ty@kernel.dk>
Date: Mon, 04 Aug 2025 09:23:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sat, 02 Aug 2025 09:25:59 +0200, Christophe JAILLET wrote:
> The size of struct bfq_iocq_bfqq_data can be reduced by moving a few fields
> around.
> 
> On a x86_64, with allmodconfig, this shrinks the size from 144 to 128
> bytes.
> The main benefit is to reduce the size of struct bfq_io_cq from 1360 to
> 1232.
> 
> [...]

Applied, thanks!

[1/1] block, bfq: Reorder struct bfq_iocq_bfqq_data
      commit: 407728da41cd6450cec6a4277027015a75744d56

Best regards,
-- 
Jens Axboe





Return-Path: <linux-kernel+bounces-746151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A41B123B0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5236C7BAEDC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F028F6E;
	Fri, 25 Jul 2025 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tctxKcUN"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002051C860B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467693; cv=none; b=EVlMjYR7wcwuFky16DmkBnDb9OdKHtceccCf1lKwA6pg0Say6gzZ6u7wuXEHoJ0kziJJjgS8FhI1qrf5EI/4MAVdlbVmnKRLMtCkae3Jki8dWms4M/O3mf79seH4lnPtl6716auT6KgRJMsqpGc0iWDCdg/c8wZL8QwGRZdBRLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467693; c=relaxed/simple;
	bh=GIr52zleFwu2eEPwKn3CzW/cCTYb+FEUP4KL2XLJQzI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HKo/ICE4MFz1KdGOUvirPMtKpgOhMkXog3bUk0h2SNgRLxKK1AzEIfikpN+PUQAZ9STcW82Bo0rxpZLHyu0zZ6LDSpLgJdDGG4KnhggzzhvkyDs9e3RbWB9lIKvEp2K20SvtJYuaJX69ohhv2z21vuGuLnwTBn3mPjKICRUQ/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tctxKcUN; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-87653e3adc6so93676439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753467690; x=1754072490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXcKol1McKvTjcvK+Gvpwmco8x2EGt21oUQ32BuDOlQ=;
        b=tctxKcUN54M2hrNeVizfhoEWlfGbEvYeT3gcQTO0gyk3j/D9hHULNnBoxez4u1rFie
         ci3qYqRXOUMyMcIDFC1AoL35vJ9VSdSFptuPrX0/g2Uw7C+ORjwlsdYOmCWDvPJc05FW
         JHkp8VtRfOWpgIbQMXxb+mBZotCeGNsaoA6acO0k9zpb3NZAMkJHDJvyCTkGiTEQkIpK
         La3JIdkD4fpjK7FuIn1M6gdmMvx6Uoe3EFI2FyCnpW+tavPCSEmh5lQ8Lc9/MjwMSnsX
         FyUHq1iI1Fvq9k+G41zC1vIa7BAS+T8eoDQ+SuF7O+PHs625L1kAwx3H9cNLE0OsdrZ4
         KEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753467690; x=1754072490;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXcKol1McKvTjcvK+Gvpwmco8x2EGt21oUQ32BuDOlQ=;
        b=cj9NCjxSs59HREo+9tHH+kK2Ou/+Lf1CRWD2jKfrbtJX3F0pyPiQs1s8VtJi3EwLzV
         5ZNbj+RK1nINNDTlMgT5Kz52Hq8XJnPLE4C8+HXsz6fo0eiOm2WZMXAL8eQr46doakb+
         lseuhq6cFySSRqbwquYlIuppS++zH6mllzv3UPOFhcSbt26X4JKGM2kuz57BNyQfc7EI
         teEmp2U/BiDGBJUHrXUFPAQJDlQp87Z8p+om1l8LYqEK8XJ4DTQvvOUGP+J/j+rPpr6O
         hGdG4uDo+N/JRSiktuavHBchYgM1/6tOJUhKqdKtYs9tIriHpJxVKIvkpGZhpHSMyFJD
         GmdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVfBBG/gIaF/CkU6aKAo4v7r4Z/wLkgKMqOLoYBaQClSaAUtyihlSTbqEJuQpaJHJ9ZEHdw0Q2d+zTwsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbGVIBaWwMHV1jOZbwhay3H4dfp38AxBNnc6r5Tj3IW+nNDigV
	WCuuefpBV60qcjaN0JCubb0FYY6iMTvE0eZDuDj/FJbE8KUBS5hG4VE/5AwJRmkK2SI=
X-Gm-Gg: ASbGncuNlTmZzdsQ7HlNWxLUsFsVL2tA26RB1QRbJJu3QOE+ebj56Pauh0z4ctAV9Jm
	vPC250+YHG/VBm3m1xIeBJbkE4+Dx9zHmW+evD962Pji2b1Hj3OB9DDrmquvi47TzIO0woSnoLy
	RmQPefizFcwX26n0XT8Slg2I3IXe0naVoWB4bY/t9yBcQv3Fckt5vnIL37Do6QleT+UyVvb4Xkp
	qhmeZlVAVoW7OcUqY0ZirDDNetGb+4RY7AhnIwl8xj3TD3DEGaS/nZFs56afKxQMX5qrzm32sh2
	9yLedtNmthnq28uMml0R3BHVw61e5cXJXySu4qdCkWERUcOOL4Qu72PYkQxlKt4J8PesPoDOogb
	Y//lOi//C24aJ
X-Google-Smtp-Source: AGHT+IFLXYQ0jDVk1FSpHmh6JYPHrFtRg8noGavUKgAIqDPFowo9HqHWonzGQTsKS5YLFfnYaszn7g==
X-Received: by 2002:a05:6e02:2490:b0:3df:154d:aa60 with SMTP id e9e14a558f8ab-3e3c5322bdemr54633665ab.22.1753467689699;
        Fri, 25 Jul 2025 11:21:29 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508c91c9687sm107313173.21.2025.07.25.11.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:21:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>, 
 Christian Mazakas <christian.mazakas@gmail.com>, 
 Michael de Lang <michael@volt-software.nl>, 
 io-uring Mailing List <io-uring@vger.kernel.org>, 
 GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20250725175913.2598891-1-ammarfaizi2@gnuweeb.org>
References: <20250725175913.2598891-1-ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH liburing 0/2] liburing fixes
Message-Id: <175346768877.681403.14218875042208173659.b4-ty@kernel.dk>
Date: Fri, 25 Jul 2025 12:21:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sat, 26 Jul 2025 00:59:11 +0700, Ammar Faizi wrote:
> Hopefully, not too late for 2.12. Two small final fixes here:
> 
>   - Fix build error when using address sanitizer due to missing
>     `IORING_OP_PIPE` in `sanitize.c`.
> 
>   - Don't use `IOURINGINLINE` on `__io_uring_prep_poll_mask` as it
>     is not a function that should be exported in the FFI API.
> 
> [...]

Applied, thanks!

[1/2] sanitize: Fix missing `IORING_OP_PIPE`
      commit: ed54d3b7e324220f70dac48b83df4e61763bf844
[2/2] liburing: Don't use `IOURINGINLINE` on `__io_uring_prep_poll_mask`
      commit: 6d3d27bc42733f5a407424c76aadcc84bd4b0cf0

Best regards,
-- 
Jens Axboe





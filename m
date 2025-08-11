Return-Path: <linux-kernel+bounces-762817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8E7B20B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0566016A877
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ABD1AA7A6;
	Mon, 11 Aug 2025 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2QfZ/FNy"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4262E1F463F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920912; cv=none; b=CQ0pTrc66kWfYx8Luo7SxUs6lzJzON9BDRbLjbxNHdyk703WOS0SMV52nQ/P5BhbdS1j7GrbrReqsccRp/lGR+EZNJJzRJJ1cQSZBspo5gYFKeGNwCSL2CwVDPN9iVJzOs0Y2F3oNzGRlaTv24gxU3w4IHL1GGRnwBO7VjcpGSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920912; c=relaxed/simple;
	bh=GubqMgiX4ooo3bzumQQGvJZHe1W3sY603ZYnm0heyNA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I4Jv17+jMaOkm6PgpTIbDA7VupiYYdMriLgPN6WNc3k/tmijf+i5j2iTX/xigC89qdB08CiOSuzX47q2P/8ufGvmVbmAoOVQcoQZLrsXbxLzbA7zGPoNzzfbQZg8lCfor8xkWBcjTgmd9pAS0IxaVbGgpXmNM/ql/4rViDZwQwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2QfZ/FNy; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32129c4e9a4so3581524a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754920910; x=1755525710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pytqrPdqiE/DDlNNA2hijqy4loXEQIRQQTm8Sur8Efw=;
        b=2QfZ/FNy01VTK9F6bedn1l5BJ8d8VzZ+sXL9RyNp31xnveI5SyQmiZ15BomRg1zdyc
         Y5a7OHhK5//x4tULX/iA6HX2tu9qBMq4oYQZ2TN2I+WU554g90qw8NnIPXd31upnxhEQ
         e7FWEih7L4D44vbN05ef8ZXGMiXXTFUnp4WfAQmjqM8mZ5+2SX4UMZEtog34moNocy9U
         rO2oJkQt46NK4BbmpaUW5Ylr1dU8QQl++jLhSphwNnaTeVlq2a9AFH5bupvEJepvoq65
         e/0ZSgI8XVFr8hpWDRivZknbpMQ8i9xTv9N19S2+AtyRBHiXrAXDCr5wZIriEIlo/FNn
         /I2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920910; x=1755525710;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pytqrPdqiE/DDlNNA2hijqy4loXEQIRQQTm8Sur8Efw=;
        b=w2CHRNC4ppqW8LNd3YiEp7G8j5mZUnbRb+UfhBfbcBanBzHN7g+Yii9k5ypKTvESUj
         29w1IwHo3cm/8bjmLZGN/ljhSx8BMTv9ka1joMsxYhp5h8nxl8akOh5FYJVHsCYvAHE1
         9IfDxowRyJuJAD8vp1MtfNfadOHEiBDZX1mjZZB3ENbf9cXiBNvpY+BK5Vyvj2Xt0SHZ
         IpocPsr+KE9L8ahrfHxuiKgPTJ2LOqJypqDqJ8USH8MJIy1umYn0Pfy1U+1Sxt5xiqwy
         M2cB191U38b8684vEU0+7Pu7iAgwrowzkl8s/9xnLaJjXFXT3F3dqP859MjddiaHTV1i
         VhOA==
X-Forwarded-Encrypted: i=1; AJvYcCXpg3oolXQIMmQASyRz2xohS8wC9lsUBFMGOhdWUkKAlN9KWeSsqyFWIY6WxZMXek+jxb9lioIVFRRZDUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQlXzY+VJVF23nmYyILYJJ1Wae7IRvK/EjisnInd9vPIJulZtJ
	R9RdUZdltZuiaLaemu9KO7maAGQvUr+CluabPSZ/kQxHG3SxRNXBYfUvoUsfuqD35SFZzbnMRNZ
	TqprS
X-Gm-Gg: ASbGncvME8pYVzsbOvqhFTy7eA0YlMCiHzlYmDIZmxTLRI67nnQiblms3l+/HeVDrEn
	zVmZwluubwZkULZ9CnKgoaGkHxkxvSkfDeTaccGSCH62Atx18wK4CxUbggG00gkWqoMLNNxivDz
	/OCG1bPUeLGrVfA5agGHAYkX7zUka1vm4nq1qibXXfVdgdS3FuxqJtvjHph8V4TbadCAe+FSDMf
	BSqPJsH9ekPt49vUVKSIlUFFpQzvkf/qISwxiDzxz6JcaHIc4Pyy5C5YLvN6h6vZayKgm3m3vGI
	vDFW2v9cNuPTCP4RPrXFn60XXmGIHHZJlSKw12SBln965xLDeqLrXO7++u9DpgEGwRpt54Enud6
	zX8lf31dw1TJ8G6s=
X-Google-Smtp-Source: AGHT+IENlkeiAPcHAcA+87B/RRXGblT9xTDrIHRKxm4Y7guv11yoxs8qU4OCwMNXyYFXMBIOsT6igQ==
X-Received: by 2002:a17:90b:3a85:b0:311:ea13:2e63 with SMTP id 98e67ed59e1d1-32183a045c9mr17238321a91.13.1754920906362;
        Mon, 11 Aug 2025 07:01:46 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161259a48sm14821216a91.18.2025.08.11.07.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:01:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250808155216.296170-1-csander@purestorage.com>
References: <20250808155216.296170-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: check for unprivileged daemon on each I/O fetch
Message-Id: <175492090530.697940.18050903274660070529.b4-ty@kernel.dk>
Date: Mon, 11 Aug 2025 08:01:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 08 Aug 2025 09:52:15 -0600, Caleb Sander Mateos wrote:
> Commit ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue
> daemon") allowed each ublk I/O to have an independent daemon task.
> However, nr_privileged_daemon is only computed based on whether the last
> I/O fetched in each ublk queue has an unprivileged daemon task.
> Fix this by checking whether every fetched I/O's daemon is privileged.
> Change nr_privileged_daemon from a count of queues to a boolean
> indicating whether any I/Os have an unprivileged daemon.
> 
> [...]

Applied, thanks!

[1/1] ublk: check for unprivileged daemon on each I/O fetch
      commit: 5058a62875e1916e5133a1639f0207ea2148c0bc

Best regards,
-- 
Jens Axboe





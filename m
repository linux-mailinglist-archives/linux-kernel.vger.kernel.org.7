Return-Path: <linux-kernel+bounces-817662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A23B5851C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B86D1AA81C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C7D283129;
	Mon, 15 Sep 2025 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HH+hwJQ5"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0083B27D77A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963176; cv=none; b=eCyXtHegpeaka7SsonNEtlPhsQqTQTSH8+O4m+GTF8fX0AWa6U52RVzbZRF804/dkrlapFxMnEX+8YAMg4mpOkl6wqpQ6NCcFXRfPjVG7LA4LQ7sjyKVUhLJb7Z5mhWN2EEWeRqPOcMmeCK/Fc2/q5JnTs1+b866jf6k8kxhBbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963176; c=relaxed/simple;
	bh=VEorQhrKiSh+kOoEYP8er8ieBm4fIAor4IioJ8q+Xmk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bacc/ub5n25xXtdMbe0AX1q7PYQyXtGHBN3MrNScHJ0qedHWtoxPgRLHVojFptEegZnW05Ug7vZYFXJFhGuCLnh011l6nMDBdPwVT+qmErW4ryuY5MVw3KX4VRi+rX3MbVUVQBpIKzq7ksz5JoARSQgnul6g2aKw4zF1STlxxhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HH+hwJQ5; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-89366d35b81so99845139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757963174; x=1758567974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+A+shV6w4y/gajfJDsqhbYczD+1TT6ZMp9tK/fnk8wU=;
        b=HH+hwJQ5vkPy2m2qMzSW0mvGr8AGCJAZqMXhtlUF50v/PVT5Ow+l2Vs+0Zi/5tkx4S
         cB4O1hFGCctpmmu98/u8Pd9FXvrLtETSSJw8zvtAxM5+qK7MBLs/KloUOTfmZIfQCQLM
         nt7P2xNugo5+XOtv3YVH44z9imJzOBVtsie2tPdSTm5cLa78rDEVfwBuA7nAJlUQz1Gy
         L1yffM7k0aakkvwAnXnQMhLMENlwFhCABZ/z79weGkaoLdIjw9EQ3W7ZQvU7zT4vFtGH
         A/uoUguCJrnuiPVKSF8b7xEOvp96b4JZ837X0p6JfJpLT1cDV+5KvckHppu+HChuvfIY
         g4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757963174; x=1758567974;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+A+shV6w4y/gajfJDsqhbYczD+1TT6ZMp9tK/fnk8wU=;
        b=xVZHLLv90yv5qz1I6jKTH39xPuf/3kQbVUDiHDZEbo76ttL3Q1NM9rQwBZtf3J/lMy
         QrJafO67bc7oH5e/vuLpznhxUB8O25yKNN0pLc2o0tsp8ovmvuT4zbN2cobNZcPf2os2
         5lLrDrD0HarzqhMa5QP39oxCXo6IIZxUGalON88VPKeiKTbbO+oPyomu1oeHprYknsSr
         uM+x7i3pH7euEGfDaYGEJHMdKy0WA/+1TkL3isEEM7zhkS5EB/nWb5spkJB0nPpc05Y7
         +bdZW2bxHP9lKTomxJcWfOvGYqoh64YU1iVRFIoS0AvXWfe6V+JfhXtfSAngkEJLJy48
         tqyA==
X-Forwarded-Encrypted: i=1; AJvYcCV/o3JMDCtC8j6oEAzWwpu0aFEQ8tTSjuNGigRYO3d+VBbpu9vNyt4iK1qe1fZNO2FR6syD4IL+kHXh9F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYxQ5w0d3eW6HEPfcixJ94Wsd8M2J8OK4TQhcR6m/Px+xSu0RJ
	wkUerAkZlIuPVC7pknN/iifrsSwFmMaZZAE6fypeWs6mK/JHMJQKP0JFoKm+QH/3nag=
X-Gm-Gg: ASbGncsoIp3erur33zTtHwkgR2SPmt9yCWuV87l4qIgv6DPQ2CpxgCCNWtXRYjXRJ8a
	Yk/haSzIcdsvTyLvAR0QuA/IAehAqhSNl8BoEi5GvYOoM76maXR0BPKMY/X5CZ3e2aglXmy5NxM
	0VDLCE8vBTRNZDURgfXEesS3aqpvLsjZtWEoaHPBkgTYQKulBNBblBSn8NGO9rRvZqTocPC2xnL
	ZIEfoYZSp6ds6SBIpS2S2CdhDGUnMZrr6cHCj2h6ZW0WWqCFFBB2mNVeoYRdvEFO1k6wZJ2A2DE
	Sb/S4uHXfi37Xz4o0nWDmtOAroaufrZdjFf7O+o/VfTLyl/3nvUYksT9FEy/DewZBztadrzodCy
	SqqWmZ8WGvEHhRkTATh/i77KU
X-Google-Smtp-Source: AGHT+IGzEthkOI8DB+wDuSGUC9lcKPWdUobt+aBza3swXw/F5Ejv6HGcW1TFQSA+ywhVJYj2IhpzpA==
X-Received: by 2002:a05:6602:6b0e:b0:887:30f5:c96c with SMTP id ca18e2360f4ac-890330c10a3mr1565163339f.6.1757963173755;
        Mon, 15 Sep 2025 12:06:13 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f3067a5asm5064945173.48.2025.09.15.12.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 12:06:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: chengkaitao <pilgrimtao@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chengkaitao <chengkaitao@kylinos.cn>, Bart Van Assche <bvanassche@acm.org>, 
 Li Nan <linan122@huawei.com>
In-Reply-To: <20250915123307.96964-1-pilgrimtao@gmail.com>
References: <20250915123307.96964-1-pilgrimtao@gmail.com>
Subject: Re: [PATCH RESEND v2] block/mq-deadline: Remove the redundant
 rb_entry_rq in the deadline_from_pos().
Message-Id: <175796317303.265523.9738573935015342018.b4-ty@kernel.dk>
Date: Mon, 15 Sep 2025 13:06:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 15 Sep 2025 20:33:07 +0800, chengkaitao wrote:
> In commit(fde02699c242), the "if (blk_rq_is_seq_zoned_write(rq))"
> was removed, but the "rb_entry_rq(node)" and some other code were
> inadvertently left behind. This patch fixed it.
> 
> 

Applied, thanks!

[1/1] block/mq-deadline: Remove the redundant rb_entry_rq in the deadline_from_pos().
      commit: 74b1db86847cce1c0fb54d362f8f5fde3adfd41b

Best regards,
-- 
Jens Axboe





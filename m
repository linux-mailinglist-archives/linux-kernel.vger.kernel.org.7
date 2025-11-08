Return-Path: <linux-kernel+bounces-891742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14093C435D5
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 00:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988C6188CD75
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 23:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF5A2848A8;
	Sat,  8 Nov 2025 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NEv/GsMb"
Received: from mail-ej1-f98.google.com (mail-ej1-f98.google.com [209.85.218.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3C3C133
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762642872; cv=none; b=hejIRHhVrIVgSru8uX0Xjm6BW9TMP2klA/66t/0v4UMKCD9DLE13LqywRor4JUdxA0gWvFNuOJASmG4UjOckB6j5Aeb79MbNUG5GVN/W1qy3pPHi0BXTXjWcWIq9iyygtMqAUErZjdZ16jAPUuCzUN9L/e7zTUjUxvW+CQmXkxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762642872; c=relaxed/simple;
	bh=ELCrrGtrdySxwwWAm//4H4Qes1u+2MVrTViH+GLXMhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JSFLWKwuJUyYaUD2JV7RANlmD5SvbM+aWgoteUZ7+to8NXdjzQuBak9gnJ6FFm9vf1CT6bVxlkGcVdWhxftH6ujzYXhRcPPlAym9bxjT5CPZRbHIKR0iURrq7J9kyd+3PTpAvDkRor7wSft/2ULh3c8RAhVEiAaXh8/VMdbrwaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NEv/GsMb; arc=none smtp.client-ip=209.85.218.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f98.google.com with SMTP id a640c23a62f3a-b70b40e0321so37536566b.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 15:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762642868; x=1763247668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JRDSAPEErao6vhdU+yX/E1lGKcHqsrIexk2wWTATv1Y=;
        b=NEv/GsMbOH4omCoq6q9baqxkEiEHHAQuyokbP65SqbtrXn7BG6VatEAzJe3nRPja28
         PnbKChUoYOxs+kBPpsanN4KhO81p1brmUk9k0NlPXN1FG4DzaNU0z5z5mXb0c1N4FGH/
         +f+tk1wroM7HYlRIOGfRUbzeg1nnm1zFBk/sSiH14b0aesOZtZxPffks9tpgCLmwx7Ky
         Nm/kMtvi7QfaEDcwmuPJjev3Hil3VQGwSQtVffaKqwUbiWjnl8Qt1W91lmwfW80isHbU
         nv94DJGEJ+av/xqU5jISdsRzTjuz8Qz7ar+kq2GOlnIDqJgZJ9PMSsx9zJNUOBVBOVSx
         0d4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762642868; x=1763247668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRDSAPEErao6vhdU+yX/E1lGKcHqsrIexk2wWTATv1Y=;
        b=Hlf4Vu7ZRAWStEpH2bgZMElSEapP/L532pGzc0RKZAcqMZAMEobiZNQkiv9KZTOdJW
         jLqCEqsoAqtyJgIpE4s6eu1ZrSBHQW4mE88eu6xcPxf3uQqWQgF47FD+NZyva9TtcR89
         S93qbDcjbl7pAghQ2UlL3fSa5Nb29/AWTjpQcvIJ81iH4TamXRuUzu6npXR8JZUnbXW0
         hoW/ppsYDvTewni/78I4cjjBCz7xaETXmU8DFsJNxcoj4AJAB/O3H7tJnX3oB6/mgLef
         PNLpo37TPQyNcv7+2Z1GFAQff2uW8MIu8d8NDZ0e19DoaLu1me/e5pebPPdqE3rAIqia
         lAXg==
X-Forwarded-Encrypted: i=1; AJvYcCUwqRPaGdbLjITMCzKb5XWi+7bdUNZysxMmKwM+ZABfsxNKipG9xUUn3syLmNkPLC6ycfga2pldyjjyiWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz40bSNcSu3O7zEvTKFGtiJH+DBNQNWl5xruhUIQBbxIuqWqgIO
	xqsliXloU32cxRGSHf4lTiDR7m8aVW2hK7sa2lPMbQNObUQIJusI1KSCEHADAje+AmtmnsUvU5H
	sCNV6c+W3/qO9a7IQARN6oypGDzbLSE2nMAwPMkNLT9611C6AAZbd
X-Gm-Gg: ASbGncs2whKQnn/MFO+aAO/2749LJPymJ6+BkvxrxhbgC6F8rMixOWqInjYIIIVKZ9o
	aUN9h4wwA31AbryaRx8S3dKBtEkrovlPir6hDymUKCl23rMiCMLMeeeqvVwBZMvzbrUXRANkhfM
	RK4lM9aPwI+uE9J19DPM0/Ys1SpRz7dIS4jrZF8TIs/iz4DMf2/nAwpjllf3lreI8iPdP63nRjX
	Mhwl8luW9eKoP4CSSvaAbH/Lo0igR1bmVezQNCUc3V2sKpQtg7+wTgxj3Ij/kBBUIPkDrR+qSVz
	bgGYAnmS/qE/zHfhnXOMoWedbzkIKKy2Nk7Cvl+yXjw6BlOkrBKjinGTLF5zgovLWk7OPgUSkgH
	jA37JmehzWHg1I8QE
X-Google-Smtp-Source: AGHT+IEMd+m9WWXrqh8XFpPvM49jh9lbnX3DzcemwYGT2EGH+S6yj+AppF1rpNbc9Ne+H7XQyIDKrQOXg45e
X-Received: by 2002:a17:907:6d0b:b0:b72:dcdb:1320 with SMTP id a640c23a62f3a-b72e05a3090mr211515866b.8.1762642868337;
        Sat, 08 Nov 2025 15:01:08 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b72bf93b18esm102059266b.94.2025.11.08.15.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:01:08 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E6DB234039D;
	Sat,  8 Nov 2025 16:01:06 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E0A76E41BD7; Sat,  8 Nov 2025 16:01:06 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/2] use blk_rq_nr_phys_segments() instead of iterating bvecs
Date: Sat,  8 Nov 2025 16:00:59 -0700
Message-ID: <20251108230101.4187106-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Minor simplification to loop and zloop to get the number of segments
from the request directly instead of iterating over all its bvecs.

Caleb Sander Mateos (2):
  loop: use blk_rq_nr_phys_segments() instead of iterating bvecs
  zloop: use blk_rq_nr_phys_segments() instead of iterating bvecs

 drivers/block/loop.c  | 5 +----
 drivers/block/zloop.c | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

-- 
2.45.2



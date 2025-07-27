Return-Path: <linux-kernel+bounces-746972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9B9B12DAD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 05:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A98A189DD4A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 03:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402EA19066D;
	Sun, 27 Jul 2025 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1dI68xMm"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EBD191F9C
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 03:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753588340; cv=none; b=dgyx3TmM3eOmkKmobzUbNDqYdNFrVOP02z3WmELvGSUqJvzrsb2Ok94BiLGsTXocU+6mmSeG1gSAvstlM8lUK7AFxDg4NlMgCdrxr5gWt6kbgcsaX82Gsd43CDUzMq4z7ZqDKZmp7q05+27aSk6T7G3UNpRUBEj6r0ZCMO2buvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753588340; c=relaxed/simple;
	bh=1JHG4GOOANGTbrg/Pq9CKtBksECyC3XcsJy5JGI7O0o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VI/sRMdjr5Yn11LfSq5d53Hh+rDq2K3dXocC25QbpYq6TsccdZje4XWFNyBgOKolx8FPCAs8gWqfzqg3Bceb4XFA2mC0DUu1HpvjX4Ent+PHlgtlMCcRVhMH6ZxZ0qWQiD5vr2We8bIARs4LRXovYVjwQDpO25v/970ZksSCpYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1dI68xMm; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-880f2623a6dso137957239f.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 20:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753588337; x=1754193137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYUVLD27MADHs9xSeNaf2bb1XM00G8LMlc/lpAZChFU=;
        b=1dI68xMmhlVclDYGGhk8oNz7VzyVFfvImQCmMyF0oL7Mb6NfAD9ukx+wrAcrIb1ymK
         u7m4AaiAJBfqusiFrjac7dRERcZ6TXjn/Z50q5RA569TvXrSNZ8Uc+Yp9wGRBRaGNTa0
         HJpY+/EH+KFvdyWJE1YZf4Gks/jVA5XRsg29M72JjjU+X5niiGTlecOwhsf60hnW7A2y
         axqbzNOHv8pUmpfqjAyROqbf0rV/7fA2sOi6cRhRCsL6t2eYkqe9CeOiJrBMC1PMD+mr
         GASBvnOIEOCTsX2K84aC8COn644aTfpYxC+Cp9DjQjPsAH2RSY/hRspv+SoAhhaXHHnM
         IEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753588337; x=1754193137;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYUVLD27MADHs9xSeNaf2bb1XM00G8LMlc/lpAZChFU=;
        b=LoDHrDeSPPgFaFTcN/DSX34zUHl2+R6zAFhd1Jgfxp0VT6YyypPF6Im1VzIAHgqYcC
         G32oSOTU3RavHVpfi00lOoINYZdd9uzaYEDsR5gZdbxGCOkBnyQtmFDtVwiPi/OZ5AdG
         m8xh/HB7cDPjQMS1WQ8X8jhPwTlsAP9KxYDXrAvVTvR7J+YiXBwbSerTRQKc62aVbhbR
         XnlTWuV6iAKU+bBlOD04zlG/6i/THrg1NYfK7DyFng6GIqNk9cxIVweIESWcGUwfNKxF
         5wSsCa4Z9jbHvuShrIqtL2gSRAaikUCPXDFWQOHIWQt1dKpa5EidyMT366s7xp3QlrW3
         Q9Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUCkJ72aL+wRl4LfLy9hLkd/wJ0RQnvr6iEp4f9Gcoae+XFkirmQZXRfmAqcnE1F++weNmsSMJnSB7osXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCbDvencdj+7hKVFGxrVbjcNCZISaYdeu0AuIPtPMMhMI5mk9S
	O8EqSsRZSDLYgnCcNsDaHbtFZbYLMxQ4lGCwVXA0KMnSDQTlIcqPcJkzku1KSgwnkOk=
X-Gm-Gg: ASbGncuGliwyF57eQgjZMD6wzDI8/wcfeO7UZNtPRYtFv81VlyGb3FKYlbveTINDmYE
	C3DpKLQDvA5QpUgax7ti9sFzLTkHqOg9aO516XCfVN1NqpohHxWaEoeRAWfE2iC7ZlL5LFS9Lsx
	mXhOIaxhqrM3ZUp4d4fy3pT6FcsMfqHfrsj71aDjGvg9TN5gqO+nTBj5AdJVrJfBCJ1ut0+4TB+
	CuiqFl0DdebgMQXrw89kSWLXA4NEe5Ba1wKHVxM4TJ4nsyUvel+iE5KOwM9LZu2UFTgVmsc6vlz
	rjvVdxrZPxEdG1hn/HgsReXizNTmLfuyDH8/lpdfJ9st7qiERZbx6p077GpsYlsww6ksvxSO2dR
	M7ltpHB3hNIrSYA==
X-Google-Smtp-Source: AGHT+IGBTIimkD6oYqXlUVYZ8OGFVC7vrUK6Agaoi5qCK9Vo03oNYqWrSefhbqFAp017uzB4xyx3aw==
X-Received: by 2002:a05:6e02:4515:20b0:3e3:ca87:3671 with SMTP id e9e14a558f8ab-3e3ca873761mr64187895ab.14.1753588337147;
        Sat, 26 Jul 2025 20:52:17 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e3cacc8a4csm12895055ab.45.2025.07.26.20.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 20:52:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>, 
 GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>, 
 Christian Mazakas <christian.mazakas@gmail.com>, 
 io-uring Mailing List <io-uring@vger.kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20250727010251.3363627-1-ammarfaizi2@gnuweeb.org>
References: <20250727010251.3363627-1-ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH liburing v2 0/3] Manpage updates for iowait toggle
 feature and one extra FFI fix
Message-Id: <175358833617.901373.6744356763469083521.b4-ty@kernel.dk>
Date: Sat, 26 Jul 2025 21:52:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sun, 27 Jul 2025 08:02:48 +0700, Ammar Faizi wrote:
> [
>   v2: Keep using IOURINGINLINE on __io_uring_buf_ring_cq_advance
>       because it is in the FFI map file.
> 
>   Now, only remove `IOURINGINLINE` from these two private helpers:
>     - __io_uring_set_target_fixed_file
>     - __io_uring_peek_cqe
> 
> [...]

Applied, thanks!

[1/3] man: Add `io_uring_set_iowait(3)`
      commit: 56116db9c371c6d2574709476ba697c0eee59284
[2/3] man: Add `IORING_ENTER_NO_IOWAIT` flag
      commit: 6ce9ab3f928a0959b6959b939c4a7ade652abee9
[3/3] liburing: Don't use `IOURINGINLINE` on private helpers
      commit: f2b6fb85b79baf17f2c0ea24a357c652caa2d7ba

Best regards,
-- 
Jens Axboe





Return-Path: <linux-kernel+bounces-729153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C648B03296
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 20:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D140A7A22B5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E0C285C98;
	Sun, 13 Jul 2025 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Yf8eRH1j"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7C5281358
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752430133; cv=none; b=XbnLTa5SLMHOSRM9JQLJn2QYLnZJ/O4C7iqhb2+xopEYuqopQWcpclu5eJFQwXtGwj4i66xa5vr1X6MWEBbi8a7utPGhEmq0smIhpS5ceZX8hkz2WKBhkUyNCeEI+tNzo9LJ5Ip+qxFMzYwpKnpNeQ9PhvdBLx93Y7Jrv/Mc+Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752430133; c=relaxed/simple;
	bh=3Fh1PeZcco30ETILuBWIi2BGS8hfQiupvDbtZojNAI4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CSiaH8cMYCqBYAvLkbd4H72Sg78locKmJEG9NeGdMhRzuTsEarROkMc2MqVOFeO51yUWEp65cZIr1AwC3oLYIsybz6+73Hek69gXX6FYBoPQWyYQNfNxyAC+hZcspsdl2ML3tHQf+fn7jlMAvfFb7JmtTx00MRQYkgqAAW2eAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Yf8eRH1j; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e25355160dso7305085ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752430129; x=1753034929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8Krzd84YFeGI1CJREEpJPGfr83y5jJFYo85/fwPADo=;
        b=Yf8eRH1jNQsZJwGbZNnGR/omlvXdwxWhbdcpseABSs4CyEef4O1oWE1EeznJflUEUk
         yRKmKbF9AFeVmaEBlKm7gN4dotivim4pTDquAqGoHtFxv2jbModkZWxIvyNyFuuDKbGS
         U5UwRanUk0wMKh46ZDwLJYZaJBuFBabauWpjaLeDLpsg1g+W3JI/RfJAj+ooSmpZyUiJ
         lLgiI1HOASpNjNZp8TlU5izOSDhSiJ+5kuflzdLLp/YQcvTOvojoj9Q9gigMaGaUL+u/
         tbkGN/tOIxDs+x9WErXd03bbbQMhJEb/KDpSDy0UpyGzC72PhfaKMdUPvEgsUV7reNXP
         5uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752430129; x=1753034929;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8Krzd84YFeGI1CJREEpJPGfr83y5jJFYo85/fwPADo=;
        b=RXYuxjhVgq1b8cCmHoIf/jz4fIeXxTUbcjWcc0BlRVjW4DOzaqjm/Wj2fxVZEoLjce
         xZECEJiFatHLdLn3AdUozchvhot9IDhnWQX60F3aiC3j5/k8tUTDruerCP9hukyrdwbJ
         IKb8ruR5IbPMfM4WV26/mEIxYMu7touvzXELS+IJZ/tZSIfeFV1rA0DDvEOTCHPrJhS/
         eTekZvSL2eQnv7xN6oHwPt9YUxlRCq9EeSlSyR1ZsLbfCg2t19Yy9hyPYaCq9DyJRGME
         aFxlFc1hgyTDZPRfVnYw1WSu/a+J/yKojHiI9UTCDiOxaZcJETLf+s1ThpwMcHhqQDk1
         IEBw==
X-Forwarded-Encrypted: i=1; AJvYcCWC0AOKo3npIE/n4onCjyyQkN6VoWYLEiLMwBeUe6tNRxuTfC3YYftycGus5rIa7zufQzF7zVjO4xf7G/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhFcIOVU8HjVgdktwhDYzILMK4mC9uSP7ZgXjEEd+fQlrK8hzj
	i0KfHtQrUDYGMJ+PYENejmLCafOCo0EweUjWjzDqmnQC6lFa432TYer8Jw65O/hptlqoDchv8Nq
	QsqFv
X-Gm-Gg: ASbGncuX1ITP+F+6PKSZVGDXeRjmGCbkdDZnDFNXvkcrnhulvbELcciF5A9Z9b+OlXn
	cLI6lRZPq2M+L3wL56YZNwitUhh4RZw3vQb5JUT1INVcLWX7e5xg3uwAnCs4X2iSgukq3f1tXjo
	ZE6l/37zJqDyTsIW5J5kj9HtQeffk4U25XUMuDUiZ6nyUe4p2qdmzBRGWDYS5/kowDN30nOWZ8J
	6VjKLTv4hLG1EBM34nS2HbLKccG3et8DiCE31cC3ZtFOqQFOkLugM7U5is8dGmgXCnd76YrwD9X
	37BWzDdsJM8PE6IjgoPro3+4foie5l3dwjO3ryA6XM56IREURlBvEuXAsGgoQdSC0JIHR1UaSrF
	twRI1rTkf8pKoLg==
X-Google-Smtp-Source: AGHT+IF1WMbjMp82EFlXwjbKMLfCYoFk0+WZL2k8tVNfkD4nUJ+eQ3w67sNomw7XTErLdVrWCxToZg==
X-Received: by 2002:a05:6e02:3991:b0:3df:5309:e97f with SMTP id e9e14a558f8ab-3e25336832cmr121164335ab.22.1752430129280;
        Sun, 13 Jul 2025 11:08:49 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-505569cc683sm1671778173.107.2025.07.13.11.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 11:08:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: efremov@linux.com, Purva Yeshi <purvayeshi550@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250713070020.14530-1-purvayeshi550@gmail.com>
References: <20250713070020.14530-1-purvayeshi550@gmail.com>
Subject: Re: [PATCH v2] block: floppy: Fix uninitialized use of outparam
Message-Id: <175243012818.93872.4165824196717735145.b4-ty@kernel.dk>
Date: Sun, 13 Jul 2025 12:08:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sun, 13 Jul 2025 12:30:20 +0530, Purva Yeshi wrote:
> Fix Smatch-detected error:
> drivers/block/floppy.c:3569 fd_locked_ioctl() error:
> uninitialized symbol 'outparam'.
> 
> Smatch may incorrectly warn about uninitialized use of 'outparam'
> in fd_locked_ioctl(), even though all _IOC_READ commands guarantee
> its initialization. Initialize outparam to NULL to make this explicit
> and suppress the false positive.
> 
> [...]

Applied, thanks!

[1/1] block: floppy: Fix uninitialized use of outparam
      commit: cb1bdf0797acd79c53a899f72a06ab8c1ebc5bcb

Best regards,
-- 
Jens Axboe





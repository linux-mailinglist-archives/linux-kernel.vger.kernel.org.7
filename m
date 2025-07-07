Return-Path: <linux-kernel+bounces-720320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F71AFBA3E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9524E18962C5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC00259CA4;
	Mon,  7 Jul 2025 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="c1A+4F4Q"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF43195FE8
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911149; cv=none; b=SHjYIszDIr6LJ33QWD52JTmdCTKvFEzlqHgFQksYcMAIYl/AEqt0wzAS4c4sTFJk2cLFsHRU/10/0KXgs4cTe+V6GBSwImPcfE2NpqsLNm/6o6GlpW351AYVczZ3Gj+8wJ10BvK47EpigBpw0rsl+HaWiFgKfBKb37K+LLFyLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911149; c=relaxed/simple;
	bh=v2VjevhVXzh8QpTnbCoQXLZqAICMzSLG9opg9XNnQpo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sAaSr36QmxazvMrJYd6RL209sW9wyRVD0+C4zJeVEaVKjK4xpxCeknD5UcQYmbBQG4dmvhsd4mNE+c5e8sz+HoNX+dGYt6IOxqIpvWS6fndAVjIqnPRQOdVzcvnUjUWkQAg3sKfe5J3v/TQtFG2uCagTKELOTc/jJTzHHlKZ/nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=c1A+4F4Q; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3df2f937370so12661075ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751911147; x=1752515947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhZK2HlfHzmT43eXpD1PkZFU0qhnofuZXFPCZ+mclVs=;
        b=c1A+4F4Qv7G0FMiDcM5bTq4pHYctSe+JajfKiLVcqw15jWdABd3pNy/oLHY/rhefMJ
         e8Lwr+yViofDhZDqoQbRQH0aAzUsI7KKisnOKfV/thUKjlqP8kMobFhNd1PsWmcosZkt
         HHWRYVx7k8/eknlVpq467VroH8GFPF3Ds5dh24NHHdOMgcF+sVDo+ZgNLvM7zWLClP8G
         IXJ9K/WXxvSIom/bXGTHD18u31DAn+rURf+Olx+qb0HrbRA4lNJzSBCXSc+K2OLAFoJM
         4iR/qD8Tmo2Bsw0u9n34JJJ+wRL1pTvc3BGLA2gGIqZ/VFy4t4x4v3+EbcJOvlqM8zMS
         WNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751911147; x=1752515947;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhZK2HlfHzmT43eXpD1PkZFU0qhnofuZXFPCZ+mclVs=;
        b=lObpE7dcGzIzsSSQlaQsjVybHkeNKuiX7qlqqSepLmal+fbjwuVwSh4EVzPfzPQPPI
         q75Wp5d/TwAF2XVVj2ZZjlKrccNZZJkP9XNEYdjl63ut/1lI8nTWQqcbExwyjwzcjHo0
         ZWfistH7kYHOivovQIculCgI+sS6PiY0mIq7tqR4b0xczZGwjJBn8AN4lThe60AeM1LG
         wCTQavMHPSeJNOk3mYBtotRcm2BKmu8OjtIAiiUjvzMZIGqWGazVuJWCN5P26SArguBC
         Simpoxynf/9kp+LVmW2bo65p+nTlnW7uCFDWrwfxIpnAYJj9gYgA00QP1r7W5A41zkNE
         x/Wg==
X-Gm-Message-State: AOJu0YwEXzLPVDNIh8jTaHuCKNZ570EzP9ADVL6v1EAiIOnBnRgPQNfP
	YnlD9PCSeGTiowtGN4bVYNQ9QNKsMpDjZBtgBzhxSUW1h4708kg2l0qta6kGSZP1cIA=
X-Gm-Gg: ASbGncuzTBN7f0qx6UM+5vQq176YJDERwj+YUq2G0Yr+s2XiZLNUrlmgwto3gOzsQrg
	RhWuWn8iCTkD3SoMTYZtre4yj31ej6Kyt2F7BWUkbiy9sQ6kZ2LcmzqdFk3vH4JNMJ+/xMu4KrL
	dMUWhM0je44UIJY+mhhZBG3ol8LQwaoQQVSQ8jQJPPQSNhn1lXcW3BrUaLzszQW3SIVdNo+y9cw
	Rv++OpppriL8hmN4RaILKpJYZjv04sAwfzsbm3dvRc/PHxWXF8Dnn3B7PBj9ivVK4YWN87DgrVt
	Po5oPsv8UWOll9uiqa58og28rEMjLYMHzQYNvADYDVBNhgL2lXeZ
X-Google-Smtp-Source: AGHT+IF6NCJtC9aWhvRfxqn2m1pWQfWS83WIrF+2LPxTT0ePPKhktletHOeY1ElRsxWnDJLxci9SeQ==
X-Received: by 2002:a05:6e02:12e2:b0:3dd:f1bb:da0b with SMTP id e9e14a558f8ab-3e1539172b6mr6831125ab.7.1751911146968;
        Mon, 07 Jul 2025 10:59:06 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e0f9b90650sm27172245ab.25.2025.07.07.10.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 10:59:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Matthew Wilcox <willy@infradead.org>, Hannes Reinecke <hare@suse.de>, 
 mcgrof@kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 gost.dev@samsung.com, kernel@pankajraghav.com, hch@lst.de, 
 Christian Brauner <brauner@kernel.org>
In-Reply-To: <20250704092134.289491-1-p.raghav@samsung.com>
References: <20250704092134.289491-1-p.raghav@samsung.com>
Subject: Re: [PATCH] block: reject bs > ps block devices when THP is
 disabled
Message-Id: <175191114597.897893.10689486110694082166.b4-ty@kernel.dk>
Date: Mon, 07 Jul 2025 11:59:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Fri, 04 Jul 2025 11:21:34 +0200, Pankaj Raghav wrote:
> If THP is disabled and when a block device with logical block size >
> page size is present, the following null ptr deref panic happens during
> boot:
> 
> [   [13.2 mK  AOSAN: null-ptr-deref in range [0x0000000000000000-0x0000000000K0 0 0[07]
> [   13.017749] RIP: 0010:create_empty_buffers+0x3b/0x380
> <snip>
> [   13.025448] Call Trace:
> [   13.025692]  <TASK>
> [   13.025895]  block_read_full_folio+0x610/0x780
> [   13.026379]  ? __pfx_blkdev_get_block+0x10/0x10
> [   13.027008]  ? __folio_batch_add_and_move+0x1fa/0x2b0
> [   13.027548]  ? __pfx_blkdev_read_folio+0x10/0x10
> [   13.028080]  filemap_read_folio+0x9b/0x200
> [   13.028526]  ? __pfx_filemap_read_folio+0x10/0x10
> [   13.029030]  ? __filemap_get_folio+0x43/0x620
> [   13.029497]  do_read_cache_folio+0x155/0x3b0
> [   13.029962]  ? __pfx_blkdev_read_folio+0x10/0x10
> [   13.030381]  read_part_sector+0xb7/0x2a0
> [   13.030805]  read_lba+0x174/0x2c0
> <snip>
> [   13.045348]  nvme_scan_ns+0x684/0x850 [nvme_core]
> [   13.045858]  ? __pfx_nvme_scan_ns+0x10/0x10 [nvme_core]
> [   13.046414]  ? _raw_spin_unlock+0x15/0x40
> [   13.046843]  ? __switch_to+0x523/0x10a0
> [   13.047253]  ? kvm_clock_get_cycles+0x14/0x30
> [   13.047742]  ? __pfx_nvme_scan_ns_async+0x10/0x10 [nvme_core]
> [   13.048353]  async_run_entry_fn+0x96/0x4f0
> [   13.048787]  process_one_work+0x667/0x10a0
> [   13.049219]  worker_thread+0x63c/0xf60
> 
> [...]

Applied, thanks!

[1/1] block: reject bs > ps block devices when THP is disabled
      commit: 4cdf1bdd45ac78a088773722f009883af30ad318

Best regards,
-- 
Jens Axboe





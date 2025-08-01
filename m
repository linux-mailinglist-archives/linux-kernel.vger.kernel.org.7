Return-Path: <linux-kernel+bounces-752813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BDBB17B3A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036401C25775
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EEA130E58;
	Fri,  1 Aug 2025 02:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hqFvCcou"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041A2E3709
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 02:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754015643; cv=none; b=ofXK6AhA9qb+YSbY7jcR6GNJbKD2hQQKnL3giT011/bSOjv/9tobz28B8G8aOzYk4XDx0LExZlk7ALd6LuUu0csKWtdW/y3TYiunRSlnbWD9ZeHRDd0ix7qdsME3uLmgBrdNhdo151+U5zSEq07kCzyp/h50sNxi1qxL6gSJDAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754015643; c=relaxed/simple;
	bh=UGyyqzs4Wn1cD55R58vv6L2IZiV5Nltwdyx7pcAigts=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KPRVafYARRNkjrlhKyfwOtTM2EBYfEMlg+h6SfawQNGlwQtLad7GrRittHGaQJnfDDt/nUlQRSP2GnpLCT1+sxZCvmFUO42WIgt3ljF1EcvV2axX5BlbKjkFDQkyg7yNI17/Gvbp/7Y0QbVtryz1FqH43NhneG6RGPpWdzxsBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hqFvCcou; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31f2dd30823so2526305a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 19:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754015641; x=1754620441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XOHinMFhJJB3g3TKW/T9yYXxcrmnGiw5ubxEdVdHGHQ=;
        b=hqFvCcouKDBu5hhDytNF0RqaCurZmse8HyezsnPI0fkgVbjS3sfAGX2CeNnYbL8ArM
         qQ3T9/hzXWyBIGxUf6MuKAfo1jarPMNpMy4n2vXICR5RYIZ6Unr6wTGNfC6Ifk78UlOh
         +sxj/GISB3/jm4cxH2Pr3k2tnAmJ679U8kzKtc9TTxscVPF/r7l+HKBKwWszdpd8SDiV
         Z+Z2p3UPmcR7BTx0IkclIJbk3jFcHhHI3H+CZybTJc8kUrbinF1No4zXlAtkqUNIOCsQ
         uWBZkDtxI3nVSsaxAkeDV7SQ2rGbGX5/YQ2YZNWFr+Omfu4pJ0f5s6AUlQ71zzkAX2YI
         K0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754015641; x=1754620441;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XOHinMFhJJB3g3TKW/T9yYXxcrmnGiw5ubxEdVdHGHQ=;
        b=WdtcQDs7xmJ/30OAH9a4+ZTLYWEJN6She4qDLHi8FliV9t490vPK3z4L7+AB+MgH1y
         DWxJV2R2YBaspsge7k1igSxP3lGx83PvweUFidU8aVxb2iEJ17v8m3VRrFH+kjD9aRe8
         4xj9I93cL2Hpku84s2pV1W/3MCxmSlP8ji0AZC6L7Vl0oHn4JQXHmHOyp++W+yGbCKaY
         jS7EQ8fuvaOP7WOCPdkWzbG7OPwrRVK3kWFbeLdIAFsb/HUYfIr8RIVyNCUHie0WFWa5
         +PB4QrE9EWf1tZrzqcvPigBrkRhGz4RGgnAyeMjsVXSZjpzXuHNQYudaJYcRxdKtS/TJ
         6uog==
X-Gm-Message-State: AOJu0Ywg7gQ1ZiqYpdQN438bLnrr/1KSnUbQosB8WB99QPsRcHjZ6Cxi
	oT22kbTTQ/erg9OdOhgJLgbRySxg/iY9iuNGiYySBSXX3JosyDLnkudMQer6qhnbbKCmPF8g9/E
	flKHrQw+JvAx/cNmlg1YgWhodaUbggXOjrQWoNX7IlY7nrfACUodJ05fNQsGAzdY0LSxeDnr+mB
	28fW7cECMcSwkLFQHAsZig58QBPtmtUPzkZWn4ephxkdpWrTxg
X-Google-Smtp-Source: AGHT+IHqpN+SWHBJmFK7SebW5Cz1eIp7fQEY6e/HKbcIbI3Ua6i1O3Rhbd8jh1k5CT53MFPju6Jlr1w1LCz9
X-Received: from pjf12.prod.google.com ([2002:a17:90b:3f0c:b0:311:462d:cb60])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e0c:b0:311:abba:53d2
 with SMTP id 98e67ed59e1d1-31f5de42527mr13872108a91.17.1754015641111; Thu, 31
 Jul 2025 19:34:01 -0700 (PDT)
Date: Fri,  1 Aug 2025 02:33:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250801023358.562525-1-jstultz@google.com>
Subject: [PATCH 0/3] Improvements to ww_mutex test driver
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

As part of the proxy-exec work, I've leveraged the ww_mutex test
driver to help stress test the lock handling.

Two of these patches I've sent a few times without any
response[1], but after realizing the test wasn't exercising the
wait-wound class mutexes (only wait-die), I've extended the test
driver to now do both. This helps make sure there is more
confidence in any changes being made.

I've reworked my older changes ontop of that and wanted to send
them all out for consideration.

Any feedback would be greatly appreciated.

Thanks!
-john

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: kernel-team@android.com

John Stultz (3):
  test-ww_mutex: Extend ww_mutex tests to test both classes of
    ww_mutexes
  test-ww_mutex: Move work to its own UNBOUND workqueue
  test-ww_mutex: Allow test to be run (and re-run) from userland

 kernel/locking/test-ww_mutex.c | 165 ++++++++++++++++++++++++---------
 1 file changed, 122 insertions(+), 43 deletions(-)

-- 
2.50.1.565.gc32cd1483b-goog



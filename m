Return-Path: <linux-kernel+bounces-835087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBE3BA63BA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 00:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8EC189CBFA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 22:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAA8235BE8;
	Sat, 27 Sep 2025 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="R4FjYdkO"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D119AD70
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759010755; cv=none; b=eYNi7/yF2Vx/NjzKwLKE4zJVtEmbFS6T4I+eJ5xtNgVIQAobGIn4adNnE37LB7Ew4agLgYOnbrKqPBriM/04QHrN23caTtQfFfmpLI8ViVHc66mekWsGiQxVEFWLZNwco7H59HEzi7DdUsaEhUS8rI6PSB3wHbwCM2yCipD1h9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759010755; c=relaxed/simple;
	bh=8vNeaE3ZDjTNRHIXZ9X9shIb2rIV9+8Kjtkb0oL7k2A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KAtrY+1T7afla2w3pzMMO0ModtBUgiC81PTQMmY3g4ImrotIX+5SJZOA87f+qhg3beEb3zJGkS5IkwIKD5Eu7BDyombsmoiH/OuSUy72g5c7S6QOZSTeT22rf1tzP7cogNjvkP9ScllVgTh/+8+epr43O5gis6bvlssj4nu5ZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=R4FjYdkO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso20130625e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 15:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1759010751; x=1759615551; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+YScZVdusg8ohPcDjQXr0BSaq7vQkm0+q1sVUm0c5Oo=;
        b=R4FjYdkO52kZQDqDg+0v6qR6AE3YUF3aZTH6VdRoUJ0GsgrK5WWexGGwM+pTAZ27WD
         pxl27wGG1yFcCCa+d9m/HwCbWnBznsHMSULxq9JfVNUFvKc8MhLt2nv3LzCLQYWg37mc
         7CvsiiFA78aO23LeWCec9PdjTQOJ8WbwswIqWoNakhaD+0rgqU+gfJ0v6dDHAQC1HTtK
         1ArtCGycGNmaRlOMqXEVIq+oyLbTAik+vLlomMuO72LYzmcJpvfCEcmTHcXYb0jRY4Yp
         yi+4meB6M5ukRAM2VNdp/j71OUB+/EMiCCHWQSihn6Cs+BPzgGaV4GL0WhpT1Xuk8HKD
         gokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759010751; x=1759615551;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YScZVdusg8ohPcDjQXr0BSaq7vQkm0+q1sVUm0c5Oo=;
        b=NRHtOUMOhrMhxsT9bYDVY4zYwEyiaeELGqFUIITFCXBAVG8EwlBPiyFTyAERZnKohB
         TShCeiy2Nsl+PaMfBEP1ZuqPOV9ZcfPfHjJI8JLXOI3EvvvSISyPWruKCGBamx61Qof1
         WqKEkeDWBhoNqqoocu9mh1Oe7oxA6u9eo500BkeOaJvAZ+6hMgnA+0IqY9vcz2/l17+C
         Sorepnby8bgRQbdeQMiVDt+SJe/3Fh8XxgAMuTonL9H7jNfCUokrbAKVl0T0o1U/7vZw
         rRNW1X0nR8yCVOa+fmYJxVD9anYehEUFQIto/P6cwB5c3cz8OdFHUsZhmkYq/tkz7ZOT
         jEYA==
X-Gm-Message-State: AOJu0YzCsTOIqLy12GpHcMALJDs5J0FlT4INsQmXznoBHOxVg2nCJ0S6
	jVOYNvW+htCRvYvZrQ8AVW9gZR/w2X5t6/2RAdUylXuuDBCuHRfXPW36ViPz4b4VnXo=
X-Gm-Gg: ASbGncs0Obd4qvd4iuDcv3mdqPGWc7iXm6njMIUv39BiHu4CsBXt2vtGvgwlql9kNlq
	hG2tNgUF4p4HmoAGaMDbxG1Yuz39b8t8UrpVkcr70Ee0UVs6HeeV0wU9rpA1AzBwlwbOhc8661V
	bwow+ZwVW+MA+vQxPi6KK9dNQuesSVwSFa8m3xafofuJEjff1OY/jYWmt0ekY0mjHnCbUR6Pm+p
	mg7Nd3G/yTF+Oamd+QMXgQ+qt8fa96U7tZ36Ho9+BOIUt9VLCB5wC+kxcol1DcBUF45yhpMxwoO
	8uOzUhjba32rMePmGqO2okpokNv4ExFMVNMBFhDGSoauepvw5eqdO4x24jKzL7VdwdhN2OaMZmf
	x+hOayvXf3AMe1pnCXXTsqn8BBfBz5yo1E7qefU4YJaldsok=
X-Google-Smtp-Source: AGHT+IF39ZwOjmMJN4GzerlPpUvjgcREoASLtygcazg6ALTc8PUs0f9d9WxfUIrIpDoqRcsiY2+G1A==
X-Received: by 2002:a05:6000:240c:b0:3dc:1473:18bd with SMTP id ffacd0b85a97d-40e497c348dmr10387585f8f.3.1759010751427;
        Sat, 27 Sep 2025 15:05:51 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c5:7815:1301:f27:e3a8:2334:314d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb89fb264sm12463730f8f.20.2025.09.27.15.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 15:05:51 -0700 (PDT)
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: [PATCH v2 0/3] printk: Release console_lock between printing
 records in legacy thread
Date: Sat, 27 Sep 2025 23:05:34 +0100
Message-Id: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK5f2GgC/42N3QqDIBhAXyW8nqFWDHe19xghpp8/FBpasYjef
 S7Y/S7PuTjnQBmSh4we1YESbD77GAqwW4WUk8EC9rowYoR1hNMWz8mHZRQTWKl2sbgEUgsVQ44
 TiCmqEVPF7qbjg+GcoNKZExj/vh6vvrDzeYlpv5Yb/dpfvfujvlFMsGla3TLJBzU0z8WBjVHPE
 OzqQ61ivY6oP8/zA4dYQ1HdAAAA
X-Change-ID: 20250914-printk_legacy_thread_console_lock-1c27f59bf990
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759010750; l=1587;
 i=amurray@thegoodpenguin.co.uk; s=20250914; h=from:subject:message-id;
 bh=8vNeaE3ZDjTNRHIXZ9X9shIb2rIV9+8Kjtkb0oL7k2A=;
 b=6LA/ug9Pprws1cSY98o5NS6RAD9sWhJnOaOw9/0LPsXATLZ1hntL7RyYdB9N4uGn9dUvztoaz
 ytjWhpYSoE6DJa7g0fXUfGxpg3ZxC9ARA3Uu/E0z0kLAC/tDRsJ+vxw
X-Developer-Key: i=amurray@thegoodpenguin.co.uk; a=ed25519;
 pk=0SU0Q8S/uEiCdbXbXS+PvJGUCaBG1nDszD+HPU3Js0Q=

The legacy printer kthread uses console_lock and
__console_flush_and_unlock to flush records to the console which
holds the console_lock being held for the entire flush. This
results in large waiting times for console_lock waiters
especially where there is a large volume of records or where the
console is slow (e.g. serial). During boot, this contention causes
delays in the filp_open call in console_on_rootfs.
   
Let's instead release and reacquire console_lock in between
printing individual records.

Signed-off-by: Andrew Murray <amurray@thegoodpenguin.co.uk>
---
Changes in v2:
- Move any_usable=false to console_flush_all in the 'introduce
  console_flush_one_record' patch to match original implementation.
- Add Petr's console_flush_one_record() code cleanup patch
- Open code flushing implementation in legacy_kthread_func instead
  of introducing new console_flush functions.
- Link to v1: https://lore.kernel.org/r/20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk

---
Andrew Murray (2):
      printk: Introduce console_flush_one_record
      printk: Use console_flush_one_record for legacy printer kthread

Petr Mladek (1):
      printk: console_flush_one_record() code cleanup

 kernel/printk/printk.c | 186 +++++++++++++++++++++++++++++++------------------
 1 file changed, 119 insertions(+), 67 deletions(-)
---
base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
change-id: 20250914-printk_legacy_thread_console_lock-1c27f59bf990

Best regards,
-- 
Andrew Murray <amurray@thegoodpenguin.co.uk>



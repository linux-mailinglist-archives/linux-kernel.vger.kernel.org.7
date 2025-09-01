Return-Path: <linux-kernel+bounces-795042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA65BB3EC39
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3CF1A87B6B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5CC2E6CB6;
	Mon,  1 Sep 2025 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzAoshVb"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACE532F763;
	Mon,  1 Sep 2025 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744389; cv=none; b=reEcx1mla+APgB4bimEUPL4dbRNLsfpzprXLyf3d5w4U9MBM+bh8bsCKa1kEhErRhKSGYxXJEoL6UQf9yPc4vF48J+CGSsnixGrgAMbqYuXIbZ6wTJd6clRRLEXSvqGkeAYOqe/7ZaHVXoRjrj0SB+e/t4lzc4qpk7WtfWBj/fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744389; c=relaxed/simple;
	bh=1rophVMPc9vFbkXNTt483gsFy5p+uR0TnILz7vTHD8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEEoW14Xl2UfEjcXPsncdupVrxH1LqLlvr0nRhsyqx4I/UohGBoh0qTPPtetxpmHwcFboQmUYelnWlFnlNJKRFc8MPiKicy8Qe7D/mOK1NjkyM42CGh0PJ3xuSBEEr4dnJvr+5/e7Fq+Zi+/oKfzL5Y8Cl98TalWMEWGogvbKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzAoshVb; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-333f92d60ddso34675831fa.3;
        Mon, 01 Sep 2025 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756744386; x=1757349186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIl5W/bIgW8FVjVtco/bINFJvVMTa/CFL0n0N73oRmY=;
        b=DzAoshVbDn0FmJFTD9AcPp0P02DWU5zTqwBSmDQTdY34AfZQqBJmwE+5sIo1mcgUjn
         ZRaQMrYW4T1BDFYPqkVO7BxNLtuiAG7Rp03uSSrGcd71HhVf4fWjZSwIlTqxay8lGjao
         A7b5rKwVmRTP5whUGO+61t7MFpLlECfYNqMtXXnIf1maSyQiT1Nk3AyuudePrB79Pb9U
         MSpowuVPZuUWFVUnzu9Z56DS5j1nRSYkfaQ5egs7CoonK/lELI56CeHdYRAPnWYaBNHQ
         c7bke7QrUahsbt/gWFcC22GQoDszOBP3Ma7Od8Vg7RL19jmaEvIPqMmPTyj0xQG2VRwL
         NJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756744386; x=1757349186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIl5W/bIgW8FVjVtco/bINFJvVMTa/CFL0n0N73oRmY=;
        b=ZVGxlaxQNp67u1oGHifrfa5Dysng/zvOkyNdo4szxSnGC5F0kPc9K4ZQCu1Lvu+aRm
         LNGAvEoFHP2sc52RMuIiZI2ejUODoAQBHXoNmVApyxqiI5Ay7oK7GMFnEvuf73poyheM
         bSd2zYbAF5H//AYVC1LqiLGOIs/E/9bDUZ4pveTQIi19tgELCqWUQAKiDuNj4EyMN5w0
         W0pimpGw+D6Hf9JOfC3xJ9xlpbofFdMQpGrsBUtKkHOxCbKiZYqCSaekFNbmNqvWVrqI
         HTk3WoWU0XY4z3XqNNwbIyc9wY6zL9q1OTDx36KXuq9BT0KseZsescHAZVe/EWogaLek
         pazQ==
X-Forwarded-Encrypted: i=1; AJvYcCUth8CdfntfKhVffGJB+VSDm5WdzpgiHP6TjM7nDDMX8PMkx0My488zbU4QZmejDSsIwgEQUzdlZw==@vger.kernel.org, AJvYcCXZpTgWynh5Pb8DTtwwvkV00OnzE7AMS+bntilymdVfHWrQRJOoSErEWgiFyGOwydPJDysjwRJIJ36GXFfi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9UtNM/O9wwC9c8sFslshlnFXFZQOLfikLueNxX3OCHJM2CJJ8
	tTDEMvu3yhNh8gRY7EJiDKpSOUiRHRXBZ5Sp/fLNeunAId5EY7SUQF12
X-Gm-Gg: ASbGncu3KHxW/UUjcLLwwtwODAT4yaDbmG7U58gbtzSnsVuJfsXESi4lk01M+FhgnSV
	feUpPIIXEY3EtDXhySbuFa6s3iwCfEejQiAT4KmwmkLfs093N7q6Yn1J8gSnsnrpMUQyo8KvS11
	dLJvkvzXAOkJ/kL06Dsv37IlIDMv7EANOlqhPhmpL0AYCJU95W4EhTc13zqdTMODm1o6ckw5Qg6
	iQ9k0fixUH8V1woG7n4zUi/WeaNQxXbQxiJOgVmCqc6BFzqzprdtBgKv2/5UXaR+YWuQV/yAGn5
	BMF78OhavS8f4JBYKAUjGbFvrRArn4M/kpRjF/bjqAqKYp5rQ7If8u70puGHxwSr2UCnr34Ae1c
	y0a6O08mA9koErzlqqaNQkOHtt5kl4gxpJ9kHCHq6ZA==
X-Google-Smtp-Source: AGHT+IEOzCiW/l9/IwVBabZcYmD6FGDThQuo6tecUi00yi4YZaYtlLaBCrKKgYh8GWti+hodMlYjBw==
X-Received: by 2002:a05:651c:20c9:b0:336:8809:6730 with SMTP id 38308e7fff4ca-336caf88d6bmr15563211fa.40.1756744385419;
        Mon, 01 Sep 2025 09:33:05 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([88.201.206.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-336d0e78e82sm15291861fa.53.2025.09.01.09.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 09:33:05 -0700 (PDT)
From: Artem Shimko <artyom.shimko@gmail.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Artem Shimko <artyom.shimko@gmail.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Subject: [PATCH v2 0/2] firmware: arm_scmi: Minor cleanups and documentation fixes
Date: Mon,  1 Sep 2025 19:32:59 +0300
Message-ID: <20250901163304.2504493-1-artyom.shimko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <y>
References: <y>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello maintainers,

This small patch series addresses some minor issues found in the SCMI driver:

Patch 1 fixes alignment and indentation inconsistencies in multiple files:

Adjusts function parameter alignment in protocol_id_show()

Fixes debugfs call alignment in raw_mode.c for both message and message_async entries

Patch 2 adds missing documentation for the xfer_lock spinlock that protects
access to xfer buffers and transfer allocation mechanism, making the code
more maintainable and easier to understand.

These are straightforward cleanups that don't change any functionality but
improve code quality and documentation.

Best regards,
Artem Shimko

Changes in v2:

Added missing alignment fix for message_async debugfs call that was
overlooked in the initial version.

Artem Shimko (2):
  firmware: arm_scmi: fix alignment in protocol_id_show and debugfs
    calls
  firmware: arm_scmi: add missing spinlock documentation

 drivers/firmware/arm_scmi/bus.c      | 2 +-
 drivers/firmware/arm_scmi/driver.c   | 1 +
 drivers/firmware/arm_scmi/raw_mode.c | 8 ++++----
 3 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.43.0



Return-Path: <linux-kernel+bounces-755645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BE6B1A9C5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2566168644
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8C1235341;
	Mon,  4 Aug 2025 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="F6wc9oJG"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD291C5F09
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 19:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754336922; cv=none; b=UVV6oZLCWyOfEfnuIUAGh8D0ZgdX7LN7/4kAfNEW6bS3ItA5kkndS2tF4qBn8dqSkIdd3B6nSySTeN+mW/dGOQkiZf1kLrj8FOXl8kMSJDWjDewSc8cTuw6/xGCManjAc7zFLKABA7p0k/Le/Avc3NAvpOvKlW7vhLq5qwLABLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754336922; c=relaxed/simple;
	bh=dtaRe64+AqlR3pjGYRgsiZ7j/ZtnofP8nv41zy0byXw=;
	h=Subject:Date:Message-ID:MIME-Version:Cc:From:To; b=UtDOiKobJG3300y6pvxMHRenAK/CXLFqvdct8EBKZoP1K8l+u0yhv+ZpHxQPzGTC6R3ny1rK/bOw05PJgJ+mOSyeVRExOsh8lzFlcjJ7IVejvZ7bB8nmzakK1mUDAM7ccILJHqCTGokj1XS0I+pzLxsJEF7m+VUfXvJ7hLHV+Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=F6wc9oJG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76bc55f6612so4234613b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 12:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1754336920; x=1754941720; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=904ayUqwmjpVmj+ZJJt8yCDrWE+pSoeD6gDXQ0kyQ/U=;
        b=F6wc9oJGWchvlFdmU+PYJ6Aw/RJ+MvxI4yPfYYJMnpLMFojlISCRcjejVevLzZbpJM
         4b/1eKnTRiD+yZaeX11uWNYAtT1EgrbLGV8Z46VdZGb3dfzrT9jSf1LBciDuCm5F4FD/
         fu7MQYzIBqv2Mt6vFzwhirq8usubuY6jjXRH67cbVsU/neHgHe4TNMjMwH0/8O+xB4Us
         G31uOdRbN6s8KLO4OZqqJ7TJhSWcyQTO/ahQcpS0UDslls+Rxti4vDNCom2tC9YcJZ3O
         lpeNiPM9Dhwqfk2H3L5pYX5tUHTfYVoYI849aT+Ds37+4018sNpyF5B1Tj1jGoGaxpsQ
         wzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754336920; x=1754941720;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=904ayUqwmjpVmj+ZJJt8yCDrWE+pSoeD6gDXQ0kyQ/U=;
        b=WLa9DuLc5rYRWr2fvv859GVnqZZdCx6ozMijbUZo/BzBLu5gijeE+J5dr9QU9Zkzso
         elvacHFb6RgdCVdsexm4Luc83TuL1meXMxGpxZa7eh8ZtQc52kuZY5IJy3caZO1loHZE
         e0UCBQKgjbzJi4mZ88S46SwhJTPo3ZstnPrdgXrwKCpewlXvQsmP/6Ds5EZCO5v2AjAC
         PHnar9wQ3IRKk4C049gLc2us5YZytAqUzSGYNfwaoqXUfTnUrNdbaxQ74ysgpdfUzMJF
         UOW4NW016gah64CDWxS01mxusX4P4bS4OpvLfmj7LJuJ97qJD8KXUR9/uaw1oFjcZSaF
         onCw==
X-Forwarded-Encrypted: i=1; AJvYcCXg/ZXYWyS5VSbGQQa+fxwVoNdt6ayKLRJMStWSA7lLXyJe55GHOOMf0N98mNOW+LI/fIcXLJT9cHEUWag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpOhqlzZo//zhPzV+ULlCw4y9UQO5C8DxDILEcWftrmhLiGwr0
	+Uh5FZ48XbWdNlSLM9yG+vjA/lWnayIHzwmS3liE/HWzcyW5D/hcvuzSiJ8f9p4WJoo=
X-Gm-Gg: ASbGnculg2gx3dd4DGjl0jBcWecQPAeB6jrxtIc+Dxe8gviHhMkTIi99SecyKRJV80M
	S9p0xad1e15aB2E6zCi8yKWaQNu4ZawBJQnH3NESrNFQKqUjkyLNj+hRDLB9J4QOHQwE1Ta1qL9
	KbtL7RfTzT+AMjcZ3x3+aiyLXF4kX/W74p8MteD9S8fvswKHNY3edZCORWWs4tMp0TLrWjhILLh
	hAdoA0JW7+HRqfJbe1v7AuUuqbguujCDo4DBtCBhB8+dT5yNBApsaWW6HbNHdE9ezSZVCByC1tw
	jcVrJw2FEZRLxzwPFe0tjhoVeEUPE2mbkoH+g2RGFePQtB0XHICChyfLcHab6Bubwi6e6Ppxjly
	MkdaaiAKOC6aWfLvwZ5W7
X-Google-Smtp-Source: AGHT+IEqJbXqxaA1YR9/O5owyw3rl79r4HGXkOejPGbQDf/eQff1LDclhID/L8+DwGTYqoNjJoorCA==
X-Received: by 2002:a05:6a21:32a0:b0:220:898b:2ca1 with SMTP id adf61e73a8af0-2401eac06d1mr1160785637.21.1754336919674;
        Mon, 04 Aug 2025 12:48:39 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::6:c42f])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76bf77210aesm5114249b3a.113.2025.08.04.12.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 12:48:39 -0700 (PDT)
Subject: [PATCH] rv: Support systems with time64-only syscalls
Date: Mon,  4 Aug 2025 12:45:19 -0700
Message-ID: <20250804194518.97620-2-palmer@dabbelt.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
  Palmer Dabbelt <palmer@dabbelt.com>, gmonaco@redhat.com, linux-trace-kernel@vger.kernel.org,
  linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: rostedt@goodmis.org, namcao@linutronix.de

From: Palmer Dabbelt <palmer@dabbelt.com>

Some systems (like 32-bit RISC-V) only have the 64-bit time_t versions
of syscalls.  So handle the 32-bit time_t version of those being
undefined.

Fixes: f74f8bb246cf ("rv: Add rtapp_sleep monitor")
Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
This seems a little ugly, as it'll blow up when neither is defined.  Some
#if/#error type stuff seemed uglier, though, and that's the best I could come
up with.  I figure anyone without either flavor of futex call is probably deep
enough in the weeds to just figure what blows up here...
---
 kernel/trace/rv/monitors/sleep/sleep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monitors/sleep/sleep.c
index eea447b06907..c1347da69e9d 100644
--- a/kernel/trace/rv/monitors/sleep/sleep.c
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -127,7 +127,9 @@ static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
 	mon = ltl_get_monitor(current);
 
 	switch (id) {
+#ifdef __NR_clock_nanosleep
 	case __NR_clock_nanosleep:
+#endif
 #ifdef __NR_clock_nanosleep_time64
 	case __NR_clock_nanosleep_time64:
 #endif
@@ -138,7 +140,9 @@ static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
 		ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, true);
 		break;
 
+#ifdef __NR_futex
 	case __NR_futex:
+#endif
 #ifdef __NR_futex_time64
 	case __NR_futex_time64:
 #endif
-- 
2.50.1



Return-Path: <linux-kernel+bounces-830421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 022A3B999D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6EB94A1D13
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AC32FE04C;
	Wed, 24 Sep 2025 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b9qqR5hD"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BA92C21C7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713906; cv=none; b=NquHqmGaEluVWu88Nm3NOrmucJtEQg9/L613kTzroRYYLI/oIu39ozPy+4zZovuuKYESt3Ue/8x0QVFhqF49Yhwt09seFcKNJpj+botatv8P+6/nUHppfwNTGdoAqNS6Gq1TMthJPiIbeMlm4o/PDWit6mjB6V1II6DIwrdMGjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713906; c=relaxed/simple;
	bh=lJ+QK63UKKDRlNr2QKgzcHWo08FmbTRWgsBmzrgBVrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fKHmdQfPYhob5/19q5gLLImfmLGWEI2ag4hh2MIdspydIHFG+DI557LSwnbNvuw7OolUw3XeMHpQdfKfd2FknoLLK3opXD4IQWk557Ek0IE0GV1egDV6ycOZ9QtR6bPk+EHDW5rJRg4PgGFDhYOe8NIb8MI7Jx3w2SLcR2NLJG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b9qqR5hD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e1e318f58so17077905e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758713902; x=1759318702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCA5QwajlQ59UvvMinwj9VwflaDYvT24c/5GSvnh2pc=;
        b=b9qqR5hDXlkjib3ezccQvRYgrPeorjZn1+QJNLujdcQ9ggO8RGC0L9mqyhd/aqN4ju
         3+vGyc1N/WJvX9Qt93XBQxqs6keq09JG7GQqeLJQXbttMBEdBMfnL7/rqdCzU0637Q0a
         U+x/FYPJnVTusdT/t9fF37XAV41VFPUEzsno910fyzQz4ecqzjXNwMWPH+eoIoNodwSS
         TTSRCDcDLNxTtpf0lID2pdmGp/w1rWrRddU/Cuq2+4N8O32Ic4U8pnmDanK8HxXeqWw9
         zkW1j3aK+WOL612CG+2J6s48+Po+0qlSjHGufGKJ4SNskP0aFPOGvdtfH481LmEADATK
         Mu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758713902; x=1759318702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCA5QwajlQ59UvvMinwj9VwflaDYvT24c/5GSvnh2pc=;
        b=UrnpsTjlnjmqOSG3yWaXywEjs5xpbY6W8/H7ffGF0+3oqfWMHt/Nsm6o5IVhpaJ5vK
         JRACa827KSVzcHnIichjFPQssvhCwJx4jDMxLdSCeEqoqVeYfr9TaNlXiTBhhWsGSJGd
         Q3g4pNeMemzd8O6DDI5W3zj+QMuECdB0k/xP1JVvTTCTgPb+EWf7ZCRO9ZHyMrUOw8So
         VkY8xZ2ljkja3rVVuYG7ZeLfN7+io/TZbCn00UVhR8xHk3+Cgb/1ACaZdLSTFEx3m0uC
         OUhoKISmcE/fhF+24HCFVFO7MAW06WJb9Rto+YZuQiqBFox44zH8ePyIzCkua+KWRxto
         IOtw==
X-Gm-Message-State: AOJu0YyQI1T/YmzWDJy6bPPk9xMcndYbSAB+d8Q6s7iPzkrTVvPOincH
	R2GZ7ucL+cVX237dHuaRREkuyyp4nDtF6nj2wwqlVC7YDs7DYQTCEPe6bPeBiMve3ICBm24xZYq
	CZTZY
X-Gm-Gg: ASbGncuzovHOXjNtnwkPgOKP3e6go9IrrxV3ZuRIyTXdpqksMAuPLiHfUW19eNXHlFG
	X56CPLahG1NnGrSjVOi3uiuxzqI7/Rci95qiBENFxu5XYvKg8JB94JPe4hYSQf6FvvuieplWVkm
	+7ERP7mpvBHYe96xcD0LA5X3Yzg78/61pxng1e7qEibpTYvoOKsujkN0V3uZgwjd6GvvVMdBbu6
	EBlSl+Z3V+LwFPSK+aLrIQYQQu7y6ExWX5g/AurvxIIISRVntnB5t6Kphv2HYDE3v9b2/Vshi+u
	aSP7G4bnJxAqvj3hnC+5dB57/na4I5SV2pIUSKfN4+sbWAhneE65miqDmb3Uqcy21LHv6KgWczt
	JjJc4qX71C2At94CeMwrGCt0hBTJId0UBOEFows2cIQM=
X-Google-Smtp-Source: AGHT+IFf83Wibzw2MAhJv1PA22Vi+FCDsaK4BLLL7JmG2DYF16kFe+b/FtEEihOebIFxrR58Qf6U+A==
X-Received: by 2002:a05:600c:3ba0:b0:45d:d50d:c0db with SMTP id 5b1f17b1804b1-46e1d988f88mr69789865e9.15.1758713902430;
        Wed, 24 Sep 2025 04:38:22 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab48570sm27592755e9.16.2025.09.24.04.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:38:22 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracing: Ensure optimized hashing works
Date: Wed, 24 Sep 2025 13:38:09 +0200
Message-ID: <20250924113810.2433478-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If ever PID_MAX_DEFAULT changes, it must be compatible with tracing
hashmaps assumptions.

Link: https://lore.kernel.org/r/20240409110126.651e94cb@gandalf.local.home/
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/trace/trace_sched_switch.c | 2 ++
 1 file changed, 2 insertions(+)

v1 in https://lore.kernel.org/r/20250923165908.2399256-1-mkoutny@suse.com/
- cohere with code (Steven)

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index cb49f7279dc80..9ee62364d98d2 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -248,6 +248,8 @@ int trace_save_cmdline(struct task_struct *tsk)
 	if (!tsk->pid)
 		return 1;
 
+	BUILD_BUG_ON(!is_power_of_2(PID_MAX_DEFAULT));
+
 	tpid = tsk->pid & (PID_MAX_DEFAULT - 1);
 
 	/*
-- 
2.51.0



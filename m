Return-Path: <linux-kernel+bounces-841334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEB8BB70B7
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD8B19E29DA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42CE23D7EE;
	Fri,  3 Oct 2025 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Us/XTCa1"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5465D221290
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498753; cv=none; b=n2zgDbCSPvJP5Z2e4aC69YFawYgnxjMmVDSgdQTs7wJFE/MWoM9tFw+A9pAycc2mCsq+780olhDIXXx30O97wDUpGQrVcfrVgYBaG83Oc4388D46wj+m7zgg38lh8madgdRoBpaQLyVk/uUSwkIZ1UokCKwiUlar96GFfa7XFFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498753; c=relaxed/simple;
	bh=9/4IUKboS3yeSww6Pu1BgVsJcgcL3OjiuC5fyLEdPSs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FoGNHgAjtBw4uUKvYl7/xeJfw5MMLfhyEEW+DOn2ImL1dQv33YuZ5pRZvapeXm0TflL6ucsydfIdNndAjzs49wSJqcj4gIETQSBnhfmiFl43/iTJczyS3J0bAgT8Q4vf1RAjngNYCo5360+SUPWbhTM0pA2uH+pDpko37wdYsF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Us/XTCa1; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e44b9779eso9336865e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759498747; x=1760103547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VlIvMmYTYW9xFXQL0KLrUt7g4tYarY39wioQ68L5ZKE=;
        b=Us/XTCa1OO5f57OJ9mp7UfVLw97Nu/vrnz76HFt1jghnI76UvVbXhM56/tJg1ARxtV
         w1VYYoLw7ob+haTi3mFTsQ8HcY9KHggTwRnn11sjfNRU8/xptWqxPlzJJtfxE2x21f0k
         a0gEQTX3U8hjw28fkAlOCnp2kAHPzDOF/VfAxeKMitvCN33ZEo3GNfUsgI34yMW6T6D0
         6L/ZAf44nv22JrdUx1T07MpJttlveMnOzpcYp5GeKJw+OKDS8V3CvzL+Zmd4ZRZtiD6t
         pFzmqqFo8DI4FIttndWyR2hnAlhXoYb1biMb6YEpZ8s7+/46VnjYpINdGxVpefnNsanI
         lUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498747; x=1760103547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VlIvMmYTYW9xFXQL0KLrUt7g4tYarY39wioQ68L5ZKE=;
        b=gsX+rOOB7Je3H1+hJCVqlOH3fXaAu3fpdm+0pUoWVBmIvu3rxYu7i8TAnfvSAU5Xm7
         e31eLYiDnCsnU0XohWLN5poUdSUcgz1VoethdFt5DIc8Bc9gowhqjZDyvghlR9Vym/wo
         hsYh6TxEHYoiEjUS/n/Ap0eHVocBxFmbAu1kl3YLybVuvXnT2/jDgDxR4yaPE7gyJJ8n
         R4IHQkU55hkrldZG4xqayXSxGeH4xWtACPi/TYo25mNvfNeWPGjhWx4wonT67G1Jvy45
         1PPjzQj9PFBzjGccoyMOj9Z2fmmS06wlROtSDUtXqbhXtNR90rSnvBNs0cEk1iuWhdeD
         to0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfaP9vFdU0LojSwJAz9YNK6wd5YFQn8Nn7d/hLALZTjUQWHPUDkisYKt12LjQ3QEURNY8Jidrsz7DlFZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyB7TaY8OowV/I9p4XX/JeO9JtfW8FTbva3evDdb07c3mELE7D
	xCIuDNI6p/25jF2pyqSs51EbhTt0qaffgu2d+s9YhWHoYdlc3UpfhrOA9eHWAe2ciPLy9fd3pjT
	rvZc1EWFOx1mcvzOG4XsOZA==
X-Google-Smtp-Source: AGHT+IHsx8P5Vs9M8mnwbrakrOPGXjbApzSto+nkAQM4Qfn3U+7Iz7dieUnzsV71vFzwGuJGfn1Qycvc9bWbG44R
X-Received: from wmcq5.prod.google.com ([2002:a05:600c:c105:b0:46e:32e6:eb8f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b61:b0:45b:79fd:cb3d with SMTP id 5b1f17b1804b1-46e71157894mr21943305e9.36.1759498747404;
 Fri, 03 Oct 2025 06:39:07 -0700 (PDT)
Date: Fri,  3 Oct 2025 14:38:08 +0100
In-Reply-To: <20251003133825.2068970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003133825.2068970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003133825.2068970-12-vdonnefort@google.com>
Subject: [PATCH v7 11/28] tracing: Add helpers to create trace remote events
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Declaring remote events can be cumbersome let's add a set of macros to
simplify developers life. The declaration of a remote event is very
similar to kernel's events:

 REMOTE_EVENT(name, id,
     RE_STRUCT(
        re_field(u64 foo)
     ),
     RE_PRINTK("foo=%llu", __entry->foo)
 )

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/trace_remote_event.h b/include/linux/trace_remote_event.h
index a4449008a075..c8ae1e1f5e72 100644
--- a/include/linux/trace_remote_event.h
+++ b/include/linux/trace_remote_event.h
@@ -5,6 +5,7 @@
 
 struct trace_remote;
 struct trace_event_fields;
+struct trace_seq;
 
 struct remote_event_hdr {
 	unsigned short	id;
@@ -20,4 +21,13 @@ struct remote_event {
 	char				*print_fmt;
 	void				(*print)(void *evt, struct trace_seq *seq);
 };
+
+#define RE_STRUCT(__args...) __args
+#define re_field(__type, __field) __type __field;
+
+#define REMOTE_EVENT_FORMAT(__name, __struct)	\
+	struct remote_event_format_##__name {	\
+		struct remote_event_hdr hdr;	\
+		__struct			\
+	}
 #endif
diff --git a/include/trace/define_remote_events.h b/include/trace/define_remote_events.h
new file mode 100644
index 000000000000..03c9f5515c5a
--- /dev/null
+++ b/include/trace/define_remote_events.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/trace_events.h>
+#include <linux/trace_remote_event.h>
+#include <linux/trace_seq.h>
+#include <linux/stringify.h>
+
+#define REMOTE_EVENT_INCLUDE(__file) __stringify(../../__file)
+
+#ifdef REMOTE_EVENT_SECTION
+# define __REMOTE_EVENT_SECTION(__name) __used __section(REMOTE_EVENT_SECTION"."#__name)
+#else
+# define __REMOTE_EVENT_SECTION(__name)
+#endif
+
+#define __REMOTE_PRINTK_COUNT_ARGS(_0, _1, _2, _n, __args...) _n
+#define REMOTE_PRINTK_COUNT_ARGS(__args...) __REMOTE_PRINTK_COUNT_ARGS(, ##__args, 2, 1, 0)
+
+#define __remote_printk0()								\
+	trace_seq_putc(seq, '\n')
+
+#define __remote_printk1(__fmt)								\
+	trace_seq_puts(seq, " " __fmt "\n")						\
+
+#define __remote_printk2(__fmt, __args...)						\
+do {											\
+	trace_seq_putc(seq, ' ');							\
+	trace_seq_printf(seq, __fmt, __args);						\
+	trace_seq_putc(seq, '\n');							\
+} while (0)
+
+/* Apply the appropriate trace_seq sequence according to the number of arguments */
+#define remote_printk(__args...)							\
+	CONCATENATE(__remote_printk, REMOTE_PRINTK_COUNT_ARGS(__args))(__args)
+
+#define RE_PRINTK(__args...) __args
+
+#define REMOTE_EVENT(__name, __id, __struct, __printk)					\
+	REMOTE_EVENT_FORMAT(__name, __struct);						\
+	static void remote_event_print_##__name(void *evt, struct trace_seq *seq)	\
+	{										\
+		struct remote_event_format_##__name __maybe_unused *__entry = evt;	\
+		trace_seq_puts(seq, #__name);						\
+		remote_printk(__printk);						\
+	}
+#include REMOTE_EVENT_INCLUDE(REMOTE_EVENT_INCLUDE_FILE)
+
+#undef REMOTE_EVENT
+#undef RE_PRINTK
+#undef re_field
+#define re_field(__type, __field)							\
+	{										\
+		.type = #__type, .name = #__field,					\
+		.size = sizeof(__type), .align = __alignof__(__type),			\
+		.is_signed = is_signed_type(__type),					\
+	},
+#define __entry REC
+#define RE_PRINTK(__fmt, __args...) "\"" __fmt "\", " __stringify(__args)
+#define REMOTE_EVENT(__name, __id, __struct, __printk)					\
+	static struct trace_event_fields remote_event_fields_##__name[] = {		\
+		__struct								\
+		{}									\
+	};										\
+	static char remote_event_print_fmt_##__name[] = __printk;			\
+	static struct remote_event __REMOTE_EVENT_SECTION(__name)			\
+	remote_event_##__name = {							\
+		.name		= #__name,						\
+		.id		= __id,							\
+		.fields		= remote_event_fields_##__name,				\
+		.print_fmt	= remote_event_print_fmt_##__name,			\
+		.print		= remote_event_print_##__name,				\
+	}
+#include REMOTE_EVENT_INCLUDE(REMOTE_EVENT_INCLUDE_FILE)
-- 
2.51.0.618.g983fd99d29-goog



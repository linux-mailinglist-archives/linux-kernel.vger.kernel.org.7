Return-Path: <linux-kernel+bounces-590595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BE0A7D4D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 09:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239F13B0C61
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 06:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B5922E414;
	Mon,  7 Apr 2025 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DaPb9ygV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X24OgPGa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFA122D7B1;
	Mon,  7 Apr 2025 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008800; cv=none; b=Ka0fy3WtFioxsPk8eUVL2zY6JUGIK1H1NTXTBYi9+Pqsqhtz9y2+MXDmnxrWh9r0Zp6akkoVgH7HgduoT1RBeMGm0WKn1Rrb4/8HCzew1tpJoXXdll2Dzf+8MSH8dFlS5UL7jbwygNuZD76LKqAiSk3BSKeRRMPtXN8z6Wq8Hnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008800; c=relaxed/simple;
	bh=kr1493r0mCxh9Smwnzq2sT4EOgraIN/H6Zk+RSFwpBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mLZEkIJgNy3fmj+qC4bM3GUGcPCNVfy46DDVy11qmXvReu0b8RtIoaiw5jBykzcl7XxQRBEnQsRQ+wvx/jo5iBu8C/RO4IJvjaky+LAGX9xw9+u7nzaq2NLhoZn8oMzQAAnrxpbJ8NDI0M25SWxgYuj7Xyhzz/+fM23yqu6YdkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DaPb9ygV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X24OgPGa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9tNYn1A7xCJCEfyuN7DqxsUEM5cT1Wf6v4wfadNgQw=;
	b=DaPb9ygVoceu7y23NxtPhtA/1626L9zDd6Ge4IcjV3uuQ0EG9uc6Ib0x0vNreccd0JRo5N
	R1BDHL3FTsBfaMDdYHMffDpYiPPBFyJYnqkbF0x4ubiuaJ97VVcb6oX2VQK4kSVsVE5mul
	DDWCra8q8kcd2Gz/DLDJiH8/qF13mKXl96+zo2yhH583vzKPZ/NXnul1eOzzdRl29jX/aj
	uegW80nPYoWn7xKUUBAFiEAB0ANfh155cTrQv3jlpsRvM8DIZP8Z3AhNUTdsU/BmWHWEaM
	rmKvoOwIV0vJSReBsiRXElg071AtUFscW7CxxYR+xyKYZ1NLCqNqPAmIX5+e2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9tNYn1A7xCJCEfyuN7DqxsUEM5cT1Wf6v4wfadNgQw=;
	b=X24OgPGaw6uBBnj+2v9K590oczvbjqMFJvA9AKQ+CFLgExmmscTruzMxX6ZIxspAejPle8
	eqf8O8YU0Xqz+6AQ==
Date: Mon, 07 Apr 2025 08:52:50 +0200
Subject: [PATCH v2 27/32] tools/nolibc: add snprintf() and friends
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-27-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=1911;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=kr1493r0mCxh9Smwnzq2sT4EOgraIN/H6Zk+RSFwpBw=;
 b=T169iwSDEAw6NBOfISyp8FfGy70pTOpo2d0vbbH4ooZWXmB2gSDkpeRZS7m3SVrgxlcN+2R+s
 GKaaqWzQRNRDEC3ug+KAPNi8BwbFnGRewrekivT5jyR6DvLMlgmIcZu
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add more of the printf() functions.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdio.h | 55 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index b17b473bd8751a6283309178b4848e61e1683305..46bd90f96d654fadda20292baddc98358a3afc62 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -389,6 +389,61 @@ int dprintf(int fd, const char *fmt, ...)
 	va_start(args, fmt);
 	ret = vdprintf(fd, fmt, args);
 	va_end(args);
+
+	return ret;
+}
+
+static int __nolibc_sprintf_cb(intptr_t _state, const char *buf, size_t size)
+{
+	char **state = (char **)_state;
+
+	memcpy(*state, buf, size);
+	*state += size;
+	return 0;
+}
+
+static __attribute__((unused, format(printf, 3, 0)))
+int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
+{
+	char *state = buf;
+	int ret;
+
+	ret = __nolibc_printf(__nolibc_sprintf_cb, (intptr_t)&state, size, fmt, args);
+	if (ret < 0)
+		return ret;
+	buf[(size_t)ret < size ? (size_t)ret : size - 1] = '\0';
+	return ret;
+}
+
+static __attribute__((unused, format(printf, 3, 4)))
+int snprintf(char *buf, size_t size, const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+	ret = vsnprintf(buf, size, fmt, args);
+	va_end(args);
+
+	return ret;
+}
+
+static __attribute__((unused, format(printf, 2, 0)))
+int vsprintf(char *buf, const char *fmt, va_list args)
+{
+	return vsnprintf(buf, SIZE_MAX, fmt, args);
+}
+
+static __attribute__((unused, format(printf, 2, 3)))
+int sprintf(char *buf, const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+	ret = vsprintf(buf, fmt, args);
+	va_end(args);
+
 	return ret;
 }
 

-- 
2.49.0



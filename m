Return-Path: <linux-kernel+bounces-870189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3459C0A211
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 04:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC0C94EDE81
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 03:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DDF26E173;
	Sun, 26 Oct 2025 03:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnrYluF9"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651C426C3B0
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761447752; cv=none; b=q/kfsCXiDVf2DICKymgEUAHpvaEsQ6W/eGnM7YjyE3b8h7dEtcViYBnIOSzAGKHWu8464fm412rvMaT/eikOxAjK+tWzUD43qXKTDI/ZuO1edONQjhk50wE80Q2W8TUYKp2qNqWB4jKnBggKzFxwFGsr0cqDOqzQIZyP0AZrNww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761447752; c=relaxed/simple;
	bh=y3JrswmFFwfa3z/zDC2CDYfnI1obu4CnNdCVr+Dg7AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaXwSBTBbIR6kp+P7wgsJKxpm/iRBdL0QBEgVR+8UwW+TivXzbL0mGw8nO8Gkhqb3wRfEc13IYX3XRVtnaLzVDE2WSz+6YV0D93to+4uKIANALsGLa90AgYG4imyPyYGMJ8279lfNE1BDODTR4hD/V/4lllcFcfJfPby0dU3NHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnrYluF9; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-290ac2ef203so31896195ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 20:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761447750; x=1762052550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juWHQU8czMasRBNz0412OczXZVru8Gf6xZfz5dotCp4=;
        b=VnrYluF9KDdtT2/JTAZ/9NsrtFZI7+ZBeSzr7O9Bzd4G7HgqIfbnm4ewUStaatE6v9
         pTDZEYR3dJRT1DuW+WNwKANI3uB0v41AUt54Wuu7gqZcQphfJN27KtQJCnDAZZlzfWuw
         zw0qaSyXMKlOyWQsW+/DSdIzWkOZtr+O6HQTZ5hfQfELMejsQTVxiKxWGw/FZzK2frBw
         5mFKBeZ3vS7lh+Iy8gr8Qygise84KrWaWasRIz0iQ+6DtJs5v4gkV8WagGb179x0sIck
         D/sf13EZB+G8YXsltdO9dvT8ABS6654yu3NPVe6ednTPN/mec5+6uOfUmzx2oBaYwb02
         UV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761447750; x=1762052550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juWHQU8czMasRBNz0412OczXZVru8Gf6xZfz5dotCp4=;
        b=h7eIXd1yyIonEoLxh7BWXZgCpFQJsnYQ32hjCGldM45a+q3N1iAA8RvDT7eXB52iEo
         N4/keDVDfsmAbWVn3Pq0PRrTyGeBK/tl566t+LDvjAH79U0L5WW6RvqLCJkmJaLDQmg+
         qm4fd/I+yvtj9WvGyd98pHhGJEQ0c9cvPSD81wga/WUwb+F75hUud616XKd4CKKfJUtW
         C8IDJjuBk4VV46wzhqTb8p8s/K7/rOZPDwts+WER5fdBaXf5HpOxqvc+NVhVsNMOk6x/
         Wi6FNL30axgaeCHTeSPw3DDJYauSbA2lwIjlsyCKvkGW0mQRVi2TV0N1NbMRyV+1QH+S
         5BfA==
X-Forwarded-Encrypted: i=1; AJvYcCWI54wVFK8F8EFYRpWGB5Yf7mOASyvzhkhgViIppXrK3wRXRVPB/qck+zZL+mTWHOhCkFGa6UNiLT4/ONo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ZrC4lzBE1/2Bc0J5c51aOmS3cTZffGLIVFsezawxcvrf6CAq
	y2K/8cSUC+JC3a7gELIVtrmkHztbq8dkKmyhVdAuA8SCi/LWO2MtaQId
X-Gm-Gg: ASbGncvW79CpQbwmrljCmSdWBjI266XqKxzdQfGIKr2cY2bK2imAoI9QOldXQs5bg4B
	gWEnouIxVbgFD8+e5iQkgapGQngAoy9kJ8Ddw0X2ACcoPiQgCb3fDChUlE7IhJ8rpP2MujJ7xQq
	WIEIU6lFpDNcARAxOjc/w8qh2Z5RLLLaOZXHfCerm3i7MElwdiWPGmUYapb233mO24nKJfG0blz
	KcFpe+MFgihEQguaDU4HcHYC8+dxXWCgkU04PevZwESwcwEkBzn5LWRgCYSpWVsbnuxloSITDrb
	nv8jftYbLx3qOwNlMVoQ0nulJ3D9rV1QwTQA/o8gpFnwswTZc76jknhAnacrX0SA0VgwJ7Yb+Un
	gYULRSUkte20/FfpPXa+q9REtmVUQtVUltAwXwE0D/pA0a4oEHXkE+qQWT7Tkw9jVUBJtjlbZbx
	/H1PcQ9eyz1Io=
X-Google-Smtp-Source: AGHT+IGiKnFAn1QobwGb/3Ti6M3l+K7CtDol7CRzbD91xMh32PRYaXXOGaf2L+a0yHSp3kTqWIgWQw==
X-Received: by 2002:a17:903:187:b0:24e:81d2:cfda with SMTP id d9443c01a7336-2948b81bbbfmr101272295ad.0.1761447749627;
        Sat, 25 Oct 2025 20:02:29 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40b1esm38100645ad.73.2025.10.25.20.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 20:02:29 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 7/7] selftests/bpf: test fsession mixed with fentry and fexit
Date: Sun, 26 Oct 2025 11:01:43 +0800
Message-ID: <20251026030143.23807-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251026030143.23807-1-dongml2@chinatelecom.cn>
References: <20251026030143.23807-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the fsession when it is used together with fentry, fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/progs/fsession_test.c       | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 8f266d8e4b55..f78348e541a4 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -228,3 +228,37 @@ int BPF_PROG(test12, int a)
 		test12_exit_ok = *cookie == 0x1111222233334444ull;
 	return 0;
 }
+
+__u64 test13_entry_result = 0;
+__u64 test13_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test13, int a, int ret)
+{
+	__u64 *cookie = bpf_fsession_cookie(ctx);
+
+	if (!bpf_tracing_is_exit(ctx)) {
+		test13_entry_result = a == 1 && ret == 0;
+		*cookie = 0x123456ULL;
+		return 0;
+	}
+
+	test13_exit_result = a == 1 && ret == 2 && *cookie == 0x123456ULL;
+	return 0;
+}
+
+__u64 test14_result = 0;
+SEC("fexit/bpf_fentry_test1")
+int BPF_PROG(test14, int a, int ret)
+{
+	test14_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test15_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test15, int a)
+{
+	test15_result = a == 1;
+	return 0;
+}
-- 
2.51.1



Return-Path: <linux-kernel+bounces-893071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A71C467B9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648571885E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F4D30CDA1;
	Mon, 10 Nov 2025 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byzk09CR"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89C43081C5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776439; cv=none; b=a5IxmYQqJIXpYKXQLhokd2C8AOBLytez0TALMfV9VkZebVh8bvdXpbmUI+tY6BJ+sMliTGSlN2OgIpOqa64YMc+GEEL43FRgkuhG/1hrXb4H22wGRwwGGEe/kqB19K+L60sixsxRp5uT/2Al4U9SrUJQg8XsHcJWzqMn6FLRQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776439; c=relaxed/simple;
	bh=dRoo4cFVL7Ocw60j1tmLa3QBdesE2MYmaRPEaYNEQIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKe/Hta0vOPlawCD1k53nIbclAHiBEp05DuGk6GBcawVEboqUWZUL+RJxKKZzGxotiLIlUGLCWiZ1eV8tbQKzIzZftjiT8wdc54Ohi1pGvsSGzHwR5lSgdepxlxcLq1XRHAYfk++HcsWv2R7nEbcn+4Y7HHLfHjM8bOTzU0brLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byzk09CR; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7a9fb6fccabso2306404b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762776435; x=1763381235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SMXINWsiwquzf7zva0iiicsqTWZLMP3VWQae5zvto4o=;
        b=byzk09CRsyKaHmwsNsemDhOjlGaf8dlZlNUBFq5qlPopUdrDa2hYUi4E2EzAPH1VWl
         1ZiXeRb/XVwJeXN4gvOONZbNZn1+s+EobhJwT4KGn1gOAZaxYWutVhk+m002kjyFUe0F
         EqR436iVkMPNJq9O5iXrtZlmHQZ0Mv+XL/w8JaN9t5JvMBoKRJMKxh++jn9KzNt1RuMo
         +tJeCdpTCJpGP7DvALG9QRmycfRcG7zIpPmv+lw8Wa2v/qxkvyDZYmkBTRaMw4PZ9853
         ulEjFDTvqk5DQw1VuzVLjIk/K0YExuIRoSS+f6kEq72edBTBQvzuXsFokh0+5fsVhIIN
         NSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762776435; x=1763381235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMXINWsiwquzf7zva0iiicsqTWZLMP3VWQae5zvto4o=;
        b=M/RUR2PwWEnZdasncL1RDXuNfSn9WB7Yli9otzbT9yUlbbcWG0XfjgTBVkehgM4tUQ
         QPytTgEqyE7uhlh8MjlFX+rPfFEUZDwbY788xxxa++ikWlokO56FAFKEmnOvh99B6hWe
         odUvZ+OTzNdHftOfAg7amw29JRHBCLpU+85a8ahfQzgg+LUFva02FNP8WSWlxyYHHagm
         dZ0Er00RcLBMhlYNstbe6UTDkvySnV4fJA4xRwKN+LfhiHv/0KKgJBnrzv6dEnR401FQ
         6EaANKMdsl2XKhhkfqHN4DQ9GIdY7Mjdp7f9Fh21jrWC2wvV001yCNi9jLYySUySt8PO
         iKNA==
X-Forwarded-Encrypted: i=1; AJvYcCXZtQHOerzXUIqEbr0gxYUOFjhG1e1BEWe7ahURDe6OKlLeAy2yON2iRpa7MqGPGA6eNUN2O9zniCouNFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzslPgPEbJPnIGiTDVxTOJv5gNfx/pK8kiO22NPVuuT2crJnRK9
	uGL/5jEV5Gwwl/SYc082ZTn6yQN0JQS3inN4p+VUs/8DKKii4/3wur3h
X-Gm-Gg: ASbGncuh4N191MB8i2+E2yvdmWebiEmwQVDAfctR8In5Duh7RejK89+QiZl6nmaACFr
	PQjSYd3e7SjKe1PdWxAS43aqZ9Pgx8WKuGGMoS5jVtV369qgMFJbcnu/D3H169uqw8bWqG8720Y
	Bs9l29rbQuVURrpC98ZXWERE/SRkLtBqpHcZOjhk4/eRdVuUjhR23cUtUoAsC6lB1BD9Wcq8cMx
	ZfZZ12GJZLSlzOs4RV2+9WnxO0W2Ju5nmlraygc7Al18QLdKycAbNkqIIWt2WmMqXVZ75TeH2DF
	xpuKJS9R8052GfYiRfBMgFwvNWt4Qv/jkIndpeCdaRPWRVpkNtCAz+gNH82Nhtxl8A1qcrmTXiS
	1LcZ0rxy663DEg45tMlVB8UOOs5NMxFf+BglrYSwpvJztAtBIJfWv29TcW3dvQTgel002kG9kRx
	EEoUN1qfZ28QM=
X-Google-Smtp-Source: AGHT+IEhUhNrBR5qD3O1r2CNUoK+UFydKetEVVBjgOZbejdTK4keYOoTQYNPxN6cDLySB1fEFtkDNg==
X-Received: by 2002:a05:6a00:883:b0:7ab:f72e:8faa with SMTP id d2e1a72fcca58-7b226d88295mr11564067b3a.27.1762776435011;
        Mon, 10 Nov 2025 04:07:15 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17b0c4sm11779739b3a.48.2025.11.10.04.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:07:14 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	song@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: handle the return of ftrace_set_filter_ip in register_fentry
Date: Mon, 10 Nov 2025 20:07:05 +0800
Message-ID: <20251110120705.1553694-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error that returned by ftrace_set_filter_ip() in register_fentry() is
not handled properly. Just fix it.

Fixes: 00963a2e75a8 ("bpf: Support bpf_trampoline on functions with IPMODIFY (e.g. livepatch)")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/bpf/trampoline.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 5949095e51c3..3610c6db15ee 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -220,7 +220,9 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 	}
 
 	if (tr->func.ftrace_managed) {
-		ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
+		ret = ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
+		if (ret)
+			return ret;
 		ret = register_ftrace_direct(tr->fops, (long)new_addr);
 	} else {
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
-- 
2.51.2



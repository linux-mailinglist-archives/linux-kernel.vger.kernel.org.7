Return-Path: <linux-kernel+bounces-748577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87850B142FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F0D18C2B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2C228313D;
	Mon, 28 Jul 2025 20:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xlvGpxRG"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F8F27FB31
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734431; cv=none; b=fUiGzXCmcAh1ZR+WyWG62psgosItKjGnLiqpnLhbqE0W5JwUeB976eqrsZDJsxRfzwo3ciCkERDRACIu0W2tk04/IAn6fu27YOnRXB+hGA+rw6s6EArdIOOwqAHAAUDWo/Ytbzq1acZo7ywPlc4WukbmXBHqYAr/CHYJoZKbUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734431; c=relaxed/simple;
	bh=JesGM1gRUcTv/3MB/xSLNTKz18V9F2s0zvsG7n5gUtc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dz315g0dHeiVX0FKLbDjUcN5sDe09Tcl+cjg4ldeLdIJ4/YVVEMnkZ6hzv8kIukiRKwmQ7uTa6qnx3LWyml04pVtAeEfPAl19Ko1Nj2tAqD63rPtS23/maa67c3ejkeWvfAbKW0BaSdjHhnZTZISLdRd73Bz67+xqYL3IElPdok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xlvGpxRG; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74ea83a6c1bso2119864b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753734429; x=1754339229; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/P9OuxEuPdkEj87aBrhfagWzYFVg9xFywuYE1sk8uo0=;
        b=xlvGpxRGZXS+jlxXUttWmPp+dgQEKl/cBFKPJwPbRlK14P+vt1oG8hMglCaJ/J3Ps9
         KLY4/cXv6X5NcehYquUFliN3QM4vTJiq2ZMDR7GVr47TJREZ5P06mCbhhIBN2MaBDAnY
         MDj7pwSoMCblPVW5bBd8UvVfRK58Vb1n+xHoV62zwp3zkHTIg6Cn7H2AKMF0OPhglhkF
         vlgyAWxdJYzurKe+Gnam34k8b8wRv9wKeUBRTPAUKepK4NxSnXuArLpVhAqlyavSjKO2
         t8sH89XWPzehlagdkO4VB0hsfKnpoJ2PXWdc0eFfpaIbWxBq7ekQxshiYAFPoyVO3ady
         Q8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734429; x=1754339229;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/P9OuxEuPdkEj87aBrhfagWzYFVg9xFywuYE1sk8uo0=;
        b=d+xnj3429/xZ0XPiNfzqhQRotuZWpBdd0iyqYnyyeftjFHTaumOqcjpAQJZIWnsp4N
         UQvwnFeacq38zUPqo5cvrlPxCQ08e+AfCY+JH8zDIaAP6bQk1MG1Y7ZhNCzLLHsYQjnC
         IrSClCbXT/tFrp5Q6g0qa/JMAnGMuPh1WAMK126DvRHepdFTUFAHU7Pj829YqBNeTZNe
         tBWTizwKulXCLvAZvtppnA/PQNGvJ65YJDYTHnY9r+vKwl8Jm/Jc7T4lNfcjgrYJ51QM
         NmpGRlzwSYW0n/WlU0oBVf6OtXTpa/+eHuITXLrfJqm3HSbm4v3un6tCS+W1lfTrWs7z
         nnSw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ4o3PLPrshpQiACdZSYa8YhokIzOpRD1rI0LpCzoTMAobck1W35EMNWCBtVjz53TtVYHPHABdRH9U4rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYbMqjq9H4v/JZDYYLTN7EcZZO7fXm0whv5IpA0F2wi8Y86j9h
	RLnHR4Zod26Y9ffGadUPCjUbtibjU1vhKClKl8ihnso8kBxu3ab9w30it2/d1Hf9xIl1qKPZTWR
	lFGp8dqqoFp+wBbla1wN9wsOtivP2/A==
X-Google-Smtp-Source: AGHT+IEbju/KTqJoDu3swOvm0juyltSfbB5oQy9E98NyEsXpooGy1GcURFGIPbMqA42kwzScDk2+igqG1YSrUrHOrFg=
X-Received: from pfgg3.prod.google.com ([2002:a05:6a00:bd83:b0:748:dfd8:3949])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:8885:0:b0:749:93d:b098 with SMTP id d2e1a72fcca58-76339370d7dmr18845795b3a.22.1753734429174;
 Mon, 28 Jul 2025 13:27:09 -0700 (PDT)
Date: Mon, 28 Jul 2025 20:27:01 +0000
In-Reply-To: <20250728202656.559071-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728202656.559071-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=samitolvanen@google.com;
 h=from:subject; bh=JesGM1gRUcTv/3MB/xSLNTKz18V9F2s0zvsG7n5gUtc=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBntd4Xfb/rYr/f2dvXr4ne7aqdJhf232vjVXkH5pO3mQ
 +/1biQ3dpSyMIhxMciKKbK0fF29dfd3p9RXn4skYOawMoEMYeDiFICJqKoz/JX9kPjg79mjVdy9
 W5/nf5x+51DlpzPm3jGcVrsS7Jw+XCxgZDi0aOKRLxFTE+b2vGc+MalM+Nym9yy7pzguuu5V+7k 3/QQzAA==
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728202656.559071-10-samitolvanen@google.com>
Subject: [PATCH bpf-next v3 4/4] bpf, btf: Enforce destructor kfunc type with CFI
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure that registered destructor kfuncs have the same type
as btf_dtor_kfunc_t to avoid a kernel panic on systems with
CONFIG_CFI_CLANG enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/btf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0aff814cb53a..2b0ebd46db4a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8856,6 +8856,13 @@ static int btf_check_dtor_kfuncs(struct btf *btf, const struct btf_id_dtor_kfunc
 		 */
 		if (!t || !btf_type_is_ptr(t))
 			return -EINVAL;
+
+		if (IS_ENABLED(CONFIG_CFI_CLANG)) {
+			/* Ensure the destructor kfunc type matches btf_dtor_kfunc_t */
+			t = btf_type_by_id(btf, t->type);
+			if (!btf_type_is_void(t))
+				return -EINVAL;
+		}
 	}
 	return 0;
 }
-- 
2.50.1.552.g942d659e1b-goog



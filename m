Return-Path: <linux-kernel+bounces-862401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01BDBF52FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8402484393
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75EF2ED164;
	Tue, 21 Oct 2025 08:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUs+4XVI"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE332EC569
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761034141; cv=none; b=DY9vpTy2khw/S45M64if9bpWY0w+1dKRZatW5s7QbLCW9xv5UVg9QmjL4rwgh4CNcO3U3ZdvWpWzpxzYdYanMyUQ4zi13oqpsD9IbeoT7BV7k8+Ly39iPSIS75CgkZTswxA/mWjJdPHa9YjIVAAqsqq0mxlLr8bzAJk1wNtx2hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761034141; c=relaxed/simple;
	bh=FwP7RFhS/UAFSpDkb3KLcxGDte+je8FgtPNCjZxV0Ug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JcAE7NbFm3eBOEoqgk143Y+fJV5V4HaXj8/l/7iv1EGQIPoXrTQb/eKYSqfHa/CK2XXYotN6gDpzoPAd82SpzlNpoS35lWlAhjblWU5rcSO0W8qxEvFxg2rJpxqplXYfwbC7pXz42elaI7LgSvb6IZMZCfAb/DYxzVHFx1pkTL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUs+4XVI; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781010ff051so3949232b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761034139; x=1761638939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d6omVxeHPJccVZYxmUB5z3Y6O20DnvuzVWmKGSg10CY=;
        b=LUs+4XVI/m6aO9YGTf8f9xtrCYHO76qDYeUU96tPMVv1rJ/43XfmPhZ7QMP25iNse2
         0vwPUpx+F6YeXV0BuQPvarhspEtyopdT/zv+cTE87csDc7SRPn6B1voNAmQLM99a7lC/
         DvQTKEPj0DBVedrI39Z2mz29hKwV0an0ucp9/wy2bvsBbRxOtW+H7VlLW//rCFrU+CPB
         8fSwb8onz2pMqpdkkcja/RhCBgnf2Y73IR5AKAP6lu7e70l6THrmiOOpW3Z1xUkPu/3X
         cnf45MjxXg6+NMDdz4cJiH1uoAX2VtW2vESye3s+Q8SxIW89/1BKw6LPjW2DwP+mD313
         bGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761034139; x=1761638939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6omVxeHPJccVZYxmUB5z3Y6O20DnvuzVWmKGSg10CY=;
        b=FzKDT0UKbq0wQJcjy0/jzrWn5o36qcb1wqqMU/1N3hlJKosEYZbNEPvXEWpnuTQgSD
         7dWgey/pf0Nm/FDM7JSwIQXocDJmC+emVPrnV4l3E1Zrx7BTbUweyeTAFVC+VX8mSbLA
         vXeQIA/0VHRL+aeEcs7Vj4JigajfFWjVWjNKcYMOsuUMT5NKtKtDKepEZ0HJOr2+7nFm
         PKcr29wgbq6WitMeaeu4sYi0Fsh2qaAaasPTppSahEDBlK1gZOnedhl5oM3K74CnTOCO
         4V9553ZMxAxZ9yG1APzEvgUfO6JmDveXQSwDlTV9f/duHah/XuseXqkDfNrlEQ+myBKG
         RRTg==
X-Forwarded-Encrypted: i=1; AJvYcCVCLPvmUiyriUDyZioRwuihArsjVTDr2x/RRZ3Gda58kOzqRfzE3hsZRKzOg8ccoXoorBTfZloOdii37PE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMDl0c8PsfnWFtYA/w4jTf7sBjFZhUnn8xAxyFoo5h4W4HAYMD
	x75/scnO6sb5DqyKuTdrzQj0gOtUbrgA1pbi5+Vn2oPXf/PrhOcJb85G
X-Gm-Gg: ASbGncv0UAOwDheZz11uYYaYJls0H5+8ilsSjGP0Dr50C7yYmIl6HCmkj0xTtDvoftO
	ihrFkyLrWvx+I/ets5snD+hCpoi+OT4mLhon9jAe4MFXWBqfsppVDecv8/b0K56tyEUdDPi2Mxy
	B4vdOBci2JWLqby/o4tmH587D8kibSVvuAZmXvpW0cnCYvUxajuI5OUDXQQNe5UkjPoVY0MMSyR
	1MafzmLBIFVEQu+6PK/Ejw8Da1BFYY2kcSRBYX4/OIL1iRwobYlbn37+90X0uoH7ftdDXN+aAnL
	Xs9JR/3C9mIRXug7uVkLOORGr2imducylcwViTooB2mPOcN49gGvFUJi7kmwAD9EVzOR16tY0UJ
	UgVHlo7mW9bts1eJzVvz256wtlfb7LQXM6itWyV0OvXJCz6fjJouWKsHkqGgk8EkHM7LgUMIkAH
	K8H6028lEgEw==
X-Google-Smtp-Source: AGHT+IE7lHhHjkKOsMhyBiKOKtjK0j3mfs2g1/yj+Xj0Ks4LIQgWNdA1JFuNUbEDKSnI9fAu6Kipyg==
X-Received: by 2002:a05:6a00:230a:b0:781:16de:cc1a with SMTP id d2e1a72fcca58-7a220d37785mr21996238b3a.32.1761034138761;
        Tue, 21 Oct 2025 01:08:58 -0700 (PDT)
Received: from Shardul.. ([223.185.42.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff15829sm10528468b3a.11.2025.10.21.01.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 01:08:58 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
To: bpf@vger.kernel.org
Cc: shardulsb08@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 bpf] bpf: liveness: clarify get_outer_instance() handling in propagate_to_outer_instance()
Date: Tue, 21 Oct 2025 13:38:46 +0530
Message-Id: <20251021080849.860072-1-shardulsb08@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

propagate_to_outer_instance() calls get_outer_instance() and uses the
returned pointer to reset and commit stack write marks. Under normal
conditions, update_instance() guarantees that an outer instance exists,
so get_outer_instance() cannot return an ERR_PTR.

However, explicitly checking for IS_ERR(outer_instance) makes this code
more robust and self-documenting. It reduces cognitive load when reading
the control flow and silences potential false-positive reports from
static analysis or automated tooling.

No functional change intended.

Reported-by: kernel-patches-review-bot (https://github.com/kernel-patches/bpf/pull/10006#issuecomment-3409419240)
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
---
 kernel/bpf/liveness.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 3c611aba7f52..ae31f9ee4994 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -522,6 +522,8 @@ static int propagate_to_outer_instance(struct bpf_verifier_env *env,
 
 	this_subprog_start = callchain_subprog_start(callchain);
 	outer_instance = get_outer_instance(env, instance);
+	if (IS_ERR(outer_instance))
+		return PTR_ERR(outer_instance);
 	callsite = callchain->callsites[callchain->curframe - 1];
 
 	reset_stack_write_marks(env, outer_instance, callsite);
-- 
2.34.1



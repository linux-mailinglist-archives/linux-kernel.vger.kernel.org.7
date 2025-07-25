Return-Path: <linux-kernel+bounces-746316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB68EB12565
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D7416A644
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0C525DB12;
	Fri, 25 Jul 2025 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sdm1D4g/"
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95C325BEFE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475306; cv=none; b=pbwYVhXPM74lh42S9Ct7Vr4wL3G4TrIVLkvYJoduNQMAIOVLH4X7QtF5uITENwGQ0Cpjcol4aU0xc/4xtDGD1D2qSyaQie1ERCYAGlvOyFEXBYd3ktGtxnSw6jWZcKnmgZJLpVfWz7/etCutAqwR1vujLoshvuydBF59wQNJUzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475306; c=relaxed/simple;
	bh=By52Shk1UPL4GrfqyjyVCfkJNBxqdlzE+Cy88LJOfbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jr3x324FB2q1CRliU/UJWqBOy/k9bKnyvmNGr/QYxDqV+p1QLdGELl2UEtpLNMaFkfxKNpNErpENjN3AlUjflcoWyAFZZIYRImEIxX+zmaDSbLvKnOC2qAwt/Tqd7cQ7EhnPST8BU58Gr/uWLp0vR/m2yYOE35Pvr7XXqsWkWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sdm1D4g/; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-702b5e87d98so44010926d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753475303; x=1754080103; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hRd3Ypg5T3RRql/Fga2dEv1dzwKJJJhwVZRtqvAUzhI=;
        b=Sdm1D4g/ya1KfsrNkrrX08BoD385GzmzKCaYbl1+eK10Cm8hF496rlwcW50G6Ctvrk
         biOdoBS1q+gm5kDXf+iF7uibcn0u8Muxt6GKyqEif351a/dd/XSCZPZp3lj9W81Yz8bQ
         XRMCZNK7vs3YKluwytHkWoN6QmyHPL+OQgFb2c6ZO4QxErm814zgQT9DLixPEYAwNKl7
         0LcyZXdnoWsjQU225uPSDXSXv+Sq9c52YWgujmiQ9+lJf53jm+wy/jBftMUu+v0jXVUP
         6ful4FtApQ/CxS8jK7snVbzaEcKiYNrYVRQ82y6syZ31awPCP3qPw20USJBDgsJt4IBO
         mSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753475303; x=1754080103;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRd3Ypg5T3RRql/Fga2dEv1dzwKJJJhwVZRtqvAUzhI=;
        b=aVbcjtdpfMxoWTNN7WHVbJ8cw6WWZ7E68vz5M+DX6WzTR3NGgLBpHPiadv1kkEyx3x
         xFatflmO0k5WtUF5HRuIsQR2qFW09Fu2VBDKVvflUka8fPy0icvysxIkHLfCjsOWgzzA
         PoymChtji6UGdwCLk08SbY0HGHUP6rVxTZtOvpgkvVF9d3RxCSi/C2p+UvYf4a6KCxuf
         jHiWqMDEtoWV0UTQelrV9H9H9akqw7awTbNwmbfYboDO76HWIj7u/9Yx8+5nuBkwDYXq
         5EXbKKAchFSFnNQGGRWxUAkkOU/epI0LBTvURSuaZ+UW3tOEsP6wsWImvTy7zay/sDTC
         z9wg==
X-Forwarded-Encrypted: i=1; AJvYcCXtVs98y7/zXbZrdzKO28ogfap32YYx6PyIHJhqjJoZLIjVkRq1vUxAf4nhJnAf4i6StmLBLuV5qkZw54o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd6H76DETUY35lK+9yDt7y70DNZXt2eEcLkth2asW0+WYd1ktQ
	DZpzWUr8NobcNBDh4yu99q8t+RQD4r1UFjefzZi582WkFwuXd+QblXA/7RH1Dn136u7VJGMXmMQ
	Ft9E1mDzKoQ==
X-Google-Smtp-Source: AGHT+IHkhcJRypn35+rkPwHsygURzzuqfpDQ+MnD/3YOoth7To9Zk50PN2vd/p+Tmd8bCubnWQ5OFkx6kB3s
X-Received: from qvma10.prod.google.com ([2002:a0c:e34a:0:b0:6fb:482a:50db])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:485:b0:702:c4d8:ec02
 with SMTP id 6a1803df08f44-707205ea833mr47604626d6.40.1753475303439; Fri, 25
 Jul 2025 13:28:23 -0700 (PDT)
Date: Fri, 25 Jul 2025 20:28:06 +0000
In-Reply-To: <20250725202809.1230085-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725202809.1230085-1-zecheng@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725202809.1230085-4-zecheng@google.com>
Subject: [PATCH v1 3/6] perf dwarf-aux: Better type matching for stack variables
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Zecheng Li <zli94@ncsu.edu>, Xu Liu <xliuprof@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Utilizes the previous is_breg_access_indirect function to determine if
the stack location stores the variable itself or the struct it points
to.

If the DWARF expression shows DW_OP_stack_value without DW_OP_deref, it
indicates the variable value is the reg + offset itself, and the stack
location it points to is the dereferenced type.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/dwarf-aux.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 814c96ea509f..4039dbd2b8c0 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1635,6 +1635,14 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 	if (die_get_real_type(die_mem, &type_die) == NULL)
 		return DIE_FIND_CB_SIBLING;
 
+	if ((ops->atom == DW_OP_fbreg || ops->atom == DW_OP_breg7) &&
+	    dwarf_tag(&type_die) == DW_TAG_pointer_type &&
+	    is_breg_access_indirect(ops, nops)) {
+		/* Get the target type of the pointer */
+		if (die_get_real_type(&type_die, &type_die) == NULL)
+			return DIE_FIND_CB_SIBLING;
+	}
+
 	vt = malloc(sizeof(*vt));
 	if (vt == NULL)
 		return DIE_FIND_CB_END;
-- 
2.50.1.470.g6ba607880d-goog



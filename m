Return-Path: <linux-kernel+bounces-844354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4177BC1A86
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A59804F6E47
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B372E1C54;
	Tue,  7 Oct 2025 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hu4SSzBv"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FAA1CF96
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846182; cv=none; b=uY/eIo9M4TuJG6VzWgR2zdyMHOZDyiQbcTxDMUzexqdNztKV1uq6gkN1RVu5oaHGWkwdtno+IDtC+Fwl1xkcy/1nhSiU8hC4p4H++hC9AMhJzk0cUCRo1OjfLNOE/HypQvWu4xuZ+mKiNKoKr2Cpu2cbh5SFkEMrYxzk8KAHAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846182; c=relaxed/simple;
	bh=L9AjwpUsEpFzN7j3AU7eSyOdGZd8dr/4sJod2h6VzSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IkTNw0jNMRYSKmaVyEtNniX7oMwNgdUBorc+r7T/Y6aypEb2CLC22ZgMBkxlfBcbRVUTKw76LkxBj8OrAa7eWcfmtpwCeHSVVIm7etzWUXJ7158UTc9n8GEUOoPUgoPlcbN9RA4IP+YskUTaaLwZ13cMY06JUymqOMySEmpoQ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hu4SSzBv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso4805803f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759846179; x=1760450979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9r/MY5tB9klfws5MHV7V8VIaWyKsEd3V2VsHuC5/TM=;
        b=hu4SSzBvkmdnR5s1ObdqtfNpUO95dcsOwkQFEcIvNPgwL5t3JIafQVdlHNM24wlR0n
         GhXfWNUAjptW0eQnZIwUeDFRuUrlJxJWqme/xMB01dPhbe5DI6ztbE8seTNUvodD0XE+
         FkrxTYM/r32YZ7ezSU+5cvIGtPsW8EkoEuji9PcfPMp+qEDFnAioND0WHyaIA1g2gE4P
         LfjcjV5U0pN2Cu/xAHLHB4kJANfrStb9TjNYZl5MMSiq8WOQU3Zz9u6AvLNfS14zZfcD
         Nx/t6zvsrBTf/m6QhQEzQlYhz2cmTBsB1BszoJBT929IiErUrUNB24PdLYo8k71bZzxC
         oUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759846179; x=1760450979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9r/MY5tB9klfws5MHV7V8VIaWyKsEd3V2VsHuC5/TM=;
        b=M3FHQaZHJ2s6nPqWljz5NJ4lSugmx0wTmnmcnq/NNAs4H/q0FXQSLN3uIPj9tLmDLh
         bTCI/PROCk/cbYPWXkIAlNj+xsJSQeA+b1FgWJYeFN2xnXWqEygWMUE0iQHvR6f7JT4m
         yRyKwnGWswrv83UqxvrdgnOrW1M9fRDags3sMQWphNTnO5CaSigOyMPpJT8DsagerELB
         T0yRl6+rI0In+Ssrp/Zgd3ububsQfEGXkKIeyCJlMKcqKOV1MeE4+rq2oFC8eJkTQkWL
         W76OLGH7G5R9me2NiTiwCrvt/7bRlzBwB4PMW9RR1oZQc8tvsfgZ0kqAAN0YTA6aEiTj
         cwKg==
X-Forwarded-Encrypted: i=1; AJvYcCW2s3r6H9xgJYZ8cVbfEBlwDimHpEiYja3PnuxKrqDcJZ1TcWtfjXsuPHEVIN4cb6fk7sBh8h3zuxby8Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5oFTGSWL4nfgfGg2eWV6IY6SMGf0bw/JyeXbFnKrfrHrzFhxu
	2cCpz1JLz/bIPhL3F3VZnOhi3v91nbytZFplHS2qSV4ufDSz0NQ5VtfPlbdlJyURT08=
X-Gm-Gg: ASbGncsF6erZ2nJKxwHG06lTeV+V/GbeUspGlGyiMnR9k97yRZoqtFbTl55PFXU1mA7
	7CvNhZI839XE3dRyaf2R4DQycABtrnZOQCfAXDD0k42ogPp5oQjzT/9aVrUl5QKtVD9uOOzJFSH
	vJXOzLe5umFBdNXfWsfjitCMMva4qLqX9RIWFvsZxkesbDtB7kwYLEYkxiogG8Nqygly7PQ/cPW
	nto92t6uW+8oScw5zcW8pEesFbvEjtS91oH7BPajO3Q+0oh3q88IexbchnlEU2zPclLN9ov6KbL
	YSC45GJZAgADzSqLYEZrvAVtmiuRXDA07Dua+5GlcWNkmE8ko5+uc9oTJORLv1wA4ubO/1W8K+w
	fuLjmBFcZKO6LVVvZgVus0PEXRYmEBAEEDc0OVadCJppgBRgMYxtG3jr+MtlRKb/dWZ0=
X-Google-Smtp-Source: AGHT+IFxD1tOqcUqYz0RgbVWVOVy7pMAuGKke7jIHSzcw8uBab3yPJbul3Hx2YYu5Jm3wEK1oA54hg==
X-Received: by 2002:a05:6000:2507:b0:3e2:c41c:bfe3 with SMTP id ffacd0b85a97d-425671aa970mr11076591f8f.38.1759846178794;
        Tue, 07 Oct 2025 07:09:38 -0700 (PDT)
Received: from localhost.localdomain ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b7e37sm303294885e9.1.2025.10.07.07.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:09:38 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org,
	acme@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf tests: use strdup() in "Object code reading"
Date: Tue,  7 Oct 2025 15:09:08 +0100
Message-Id: <20251007140909.307940-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use strdup() instead of fixed PATH_MAX buffer for storing paths to not
waste memory.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
Applies on top of: https://lore.kernel.org/linux-perf-users/CAP-5=fV1N-j+f4GBFnDWsmoMZcz_k0U=nu1A7NZz-g4gzCH4KA@mail.gmail.com/T/#t

 tools/perf/tests/code-reading.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 4c9fbf6965c4..88408eea9e41 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -43,7 +43,7 @@
 struct tested_section {
 	struct rb_node rb_node;
 	u64 addr;
-	char path[PATH_MAX];
+	char *path;
 };
 
 static bool tested_code_insert_or_exists(const char *path, u64 addr,
@@ -79,7 +79,7 @@ static bool tested_code_insert_or_exists(const char *path, u64 addr,
 		return true;
 
 	data->addr = addr;
-	strlcpy(data->path, path, sizeof(data->path));
+	data->path = strdup(path);
 	rb_link_node(&data->rb_node, parent, node);
 	rb_insert_color(&data->rb_node, tested_sections);
 	return false;
@@ -94,6 +94,7 @@ static void tested_sections__free(struct rb_root *root)
 						     rb_node);
 
 		rb_erase(node, root);
+		free(ts->path);
 		free(ts);
 	}
 }
-- 
2.34.1



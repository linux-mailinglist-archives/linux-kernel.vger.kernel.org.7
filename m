Return-Path: <linux-kernel+bounces-839420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40795BB196B
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F8637A39DA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414E42EA163;
	Wed,  1 Oct 2025 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN32oEyS"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD542D6401
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346814; cv=none; b=GiiE9mAm6HdaASGcA1lBs14Vngn196BdQ1qpW9EYUw2RH+Da+ugu8k5d1UKzBVP9jeH5oNQ4qNjvp8hIVE2+vuhYbNZzLDFKWs5SZoH1kUHbandeVZw25z/X39M8uUUMYSPXtQrkJt0Ymh5SqaUBgguQ4jX6VAMcOl77ofVh+/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346814; c=relaxed/simple;
	bh=Cid1o0yI6anA0oMjfZ5dvYwhgQOAZ2ZDCkuXoquLJSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZNKLqPVjkn+21Qa/tJqbiKEHg7lXtIXpFdd0hj6NT76D3g6KTncPXanntSRYwd0pDWwgsqEGMTkkL3ezTXQvWRSG7OwksGphKOJDUZrqGdG2b91EBImwFeznKtGq5ntBJBsBCPWyWGGX9evUOuD2XaA+Xr70FaxNQzTjMTXWk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN32oEyS; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57a604fecb4so262243e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759346811; x=1759951611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4jfcSPGUvol/n8ObJSFwltbXIiILhsqpfoN+DLL7zw=;
        b=QN32oEySnNbALymZLth7d7dAP/49slpFL0sBEhzXGQA1UAm9nVVqf9h8eA28d6LUgj
         9BDqgB8SBLke9N/DhC/N8lAdsEdrtcZ15bXWlstB3f/9Gu7CVkW+RgxjfRUzHKLwCiSw
         t5kmtWXZc2YiHWxuNG+jqBo3fRZOXBZn7WCjKkhfpU4ZV48mcsPkptYVYKIOD1jWk2ad
         +ONY7X3QCzSaTxu948V0GQ+DA5eAIRY8Qyizbo7EDbUFalfNKOZeFeAlNWUXZ6mPzBvq
         xiozYKAef5dbwkh/NxsisrDpERmBpUxS/oTXk5HXXYtwaF4Kd7q9hIzbugVjwHpAklxR
         KLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759346811; x=1759951611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4jfcSPGUvol/n8ObJSFwltbXIiILhsqpfoN+DLL7zw=;
        b=wfK3+sSqq01G13sB+pCeV4JBA/s5iL7zDuWgP0Zm5lZe7AzMOYqNceU48mpvfer3Cu
         58Rd7tdng29r6/L00Vo2oF84jayufcb4T01rVNFsEY56bkcI3U4gBg/cnA5N2902GXNW
         lpnzG9oa6dRIjdfVUJcwJcZM21Bu6ntfz9WCn6MRIdoCxqEnwydGGxHEhQT5dHEk0qhl
         1C+bJs08UGNIWjSg/3+YmZrAq3qdr1lLB5WyJHaPJI5sdgrJ++Lov4cjkUVQ8sx+YqRM
         FV8Ml5PPq+n15/y0zswahgkv3d7nupQBJm/Y7HPNwvpLtNnQkuYFMR82bSdp2ceS0HPJ
         AjtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsulGxfX4U/nUkE49emVqy2VJ3IDeog5ahkeNtLUHkjEvuj3pRbS9CtStsjEd9EvmOBO3aVoa7zLeRZPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6pyDI/AHhfpNGYuWbAK4AOEKc2nBpcYRbRV/c7hClntcG6JHt
	8CKyhM2/zWCGcWQYgvyZ4uAiVcVcoL37UQeD7m2EP5CC4kewU0P5TkIY
X-Gm-Gg: ASbGnctq/dcCMnwOwhIG39/vIKwW+q1vJz3ku4pfQ65CJVq+ED31l+vLC9uafu8sdzT
	kcm6fsLhzYchjv3ZtbGrTpK/lT8xl0t61CpY5o6HiPRVTQTEueOTqPyiaqoEEjkms7fLeHd8eI5
	rA0yPUMWTTWg1QF31CkcCRLZxME7ilzLp+bcODU7YZdBU9ml8bg7jjngiIWmiDVwnZs6sUN4C0N
	KpZqpKaEgaQ3znL0fQ50Yx8P+YBfrVxa+nvVgI3DVr2frlLXyskyCE/SiGpIDO1US6q3bqFIvcM
	VLrrECJPxCgMZtCGJQbCkzKK+/h8JdOq9JElhlmYoLVGD1/oawfZ/Hh1otNX/0qh5+7nEHhVPfM
	rqfdbCqvgKMfP+m1dmv93y9n0CuNZ/05eKMJJa4mv
X-Google-Smtp-Source: AGHT+IEf29nqQKPfqYlqzEpEYNiDi956qj5XBnEwQXCvp6W703JnoRPSW6KZ+JL2jB5rOA++8NRQcA==
X-Received: by 2002:a05:6512:3b29:b0:577:3ccf:cddf with SMTP id 2adb3069b0e04-58af9f6cd35mr1447231e87.46.1759346810827;
        Wed, 01 Oct 2025 12:26:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0112414fsm136627e87.28.2025.10.01.12.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:26:50 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v3 02/10] lib/test_vmalloc: Remove xfail condition check
Date: Wed,  1 Oct 2025 21:26:38 +0200
Message-ID: <20251001192647.195204-3-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001192647.195204-1-urezki@gmail.com>
References: <20251001192647.195204-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A test marked with "xfail = true" is expected to fail but that
does not mean it is predetermined to fail. Remove "xfail" condition
check for tests which pass successfully.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 lib/test_vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index aae5f4910aff..6521c05c7816 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -500,7 +500,7 @@ static int test_func(void *private)
 		for (j = 0; j < test_repeat_count; j++) {
 			ret = test_case_array[index].test_func();
 
-			if (!ret && !test_case_array[index].xfail)
+			if (!ret)
 				t->data[index].test_passed++;
 			else if (ret && test_case_array[index].xfail)
 				t->data[index].test_xfailed++;
-- 
2.47.3



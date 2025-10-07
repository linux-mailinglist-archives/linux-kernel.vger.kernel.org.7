Return-Path: <linux-kernel+bounces-844233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 543A0BC15A0
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139863B407C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F9E2DECD3;
	Tue,  7 Oct 2025 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdeBzqQ9"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A33A2DC764
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839645; cv=none; b=BEDnDHdAFe+z5wHcD06DMOsXOXfe0CHAI0PRTEOFqDnCnfC0DqsEAcJ34+CQ3xcjzyk0blrMgwTAnV2eW/zF5332zlRR+gwuw3coKSU1DMMfJsbQsLa855vrG58yphUaXHXbVbX8PmfXxC1VsdHzEmDnIU83b5gFi94GGf2LCNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839645; c=relaxed/simple;
	bh=Cid1o0yI6anA0oMjfZ5dvYwhgQOAZ2ZDCkuXoquLJSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iG7rdo0XZKQkkRoenwojs8/1UtJDZXIleTFKChibV4INZIluzI+0K/XEL8gjhtKYKQC0kQbuZAoEmJjCDosEM5RFlovCwK45alSsqHR/rDCG8CKr7LsMAZSol/oVu1eNaocDsjHon5bURTFTBaVr6TNboMkZNLxRm2BD8FmEXKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdeBzqQ9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-58afb2f42e3so7376952e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839641; x=1760444441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4jfcSPGUvol/n8ObJSFwltbXIiILhsqpfoN+DLL7zw=;
        b=FdeBzqQ9hNnPYmgREQPeF8w8ypy4R9uCTr7++7HLMvvnnolexebWJiCbMaAPtgTaqf
         ViDj4DRV9yB4j2n55iRl2F1Ask2F7ezeV04HCbD7Gxlz8DTvpOWrRnf+nn4HbkFW4o69
         ibhZ4iZiLSmXF7WfCUTQ7dzSfCme5gbx7E1LD/rUyNp1hlg5aCPNC3tSeW0+ZDYROFLf
         ruFuT21FfYMAUaVkxTp//fmIENaKmpAOOWXMPhAlrx99LbdLozWFcyi9onXDTPWSuXDO
         FItJbKteGZoz7EMg77KLg8Drqu1TMuiFC1SOp/qRQCsYE6yfW7Wm/ib+Q+XF49e7ls2/
         fixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839641; x=1760444441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4jfcSPGUvol/n8ObJSFwltbXIiILhsqpfoN+DLL7zw=;
        b=cROgELhJ4776Ny2a53wjnPnQ8NmsKL4bIeO+yzd1Tsrw2RsmDsrHELzvEZAm7TmyRM
         XxXXlDPYBPG75e3MAdHdPrnHA8bYCK5H6LUODuRBA70SlqfnDMiPoC9crYlHaRlwHnT4
         vnc0GYhmufb9BtZY2VGo9laGnIVhusQx2gaurX4I0Mmxs64J6LvCytypzNemIJfN3hyl
         8iIUW35JveqT3Pa4BP502pf+uGeliTotEqo/zoMD0DlSgI8r6xVNiQ7N7JwcBMcct1aW
         5n2kvKI1Y+qV+xHP1ArRxHZZXNfsRscwO06P54z/tKWOLIr0jqjLDyj1WdyScPfUwD6Z
         yAqg==
X-Forwarded-Encrypted: i=1; AJvYcCX6TdoOPaDkR4vRESGU4L7OeQ++mFMvHr/KXvu1dtB1E5Y/X/YihQ83DBS4XQq+z7P84qrkQqb5xrUYfHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4JDsWe46qylJgt0FfCVpIb+fR73xFQg4o5b/cv9ofaY4oXuxz
	znTD4c/eidcnG0BvcOKJy7hOqU6nnO7GMe4+IuLUmvJC8v5ymAdnAfEq
X-Gm-Gg: ASbGncsWBrHhBy+n+55LDTx7Dfmzy6e5lQwP5LCYcUXnBV3zMIqtCpWgO43eoGxzqN4
	7yLFILtoGD79dcvtGuL7gRfZGwD8BENk1dHgR0ojZ+DhuL11by0chQviv9QMhJCGc6OVuivv8Ah
	gkTT62MIPqFljwyO2N5iAUbl/jGCDTq6PV9VyvtpT9SQzH3U1toSJzaHu7bh6+S4YOyUvDajwU8
	UMPR2h9BdM+nIKwkId25edW64ltbB1tlvcQFgyYRX59a0IDuoOIw+QaHmMlMlzgoerRzrPmxamf
	0Q0pID0IXidPsa8I3yHXYhivclK0xBhWWyS+/PtKTaJ3RWVUp0NvB5FXgQYF71PeFk0i/VoRdBn
	e3Yui4dI6DUmNspTivHE0OQnE2XeP5DVijs9+at7G
X-Google-Smtp-Source: AGHT+IEQc2WJmMkAe6iyXzpSe8lZAqYIAKitVP6umZ8/QxBxHKvKILqVKMjkHlA4N1ux2dZmJgZAQA==
X-Received: by 2002:a05:6512:230c:b0:56c:386b:9bc with SMTP id 2adb3069b0e04-58cb956bb11mr4722043e87.5.1759839641188;
        Tue, 07 Oct 2025 05:20:41 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01141151sm6061947e87.59.2025.10.07.05.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:20:40 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v4 02/10] lib/test_vmalloc: Remove xfail condition check
Date: Tue,  7 Oct 2025 14:20:27 +0200
Message-ID: <20251007122035.56347-3-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007122035.56347-1-urezki@gmail.com>
References: <20251007122035.56347-1-urezki@gmail.com>
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



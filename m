Return-Path: <linux-kernel+bounces-715337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 173F2AF746E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 14:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4ED189A300
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 12:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC252E54BE;
	Thu,  3 Jul 2025 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sb495AR/"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49D72D6605
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751546647; cv=none; b=NqFR2Q6eUHZqlCjhOLHBHlPbJwzwUiH6wRfdu3mVW/bi+A4lYj4+lxGzbT4LFzvhU59A4hV3eTCPRUYQhXJ2maNpMG8drQxTQarZWlv6rPcn1PztDo1ECU4JvnsCfqpM01rX8vYP1WLBN/7VO/OR4wCECJRRa1pkiJOmaNH2gKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751546647; c=relaxed/simple;
	bh=UaLKXmkrK1LIkFGOzYkyC4qFPdYmgojFnzpLAqnvnAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Emhhj8GFo6ypJNZDy1ZcwLEqxNO4jvLi7fj9NhAC2SMyu6jorA21HkXvBgvgUrWQ41oXMWVESysm2TeA53K/fWr2QTwKAxLH4mRvhQ+xDC1ipF4BxGZbW26iasK7wI0gUzHDrv1nlPKYyyioOUYRF/cYvGZF9rruRKTziRSuSbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sb495AR/; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751546640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rip0/kJiagzFkl+ZrFQ9YxQG0gOoCZvnupWJ5xbqNbY=;
	b=Sb495AR/9u9Mn99qdBtDRzSJ8wCae2Nqpneh3nrXq94GdjM9YGJVSZga4AzQ8HQTTrrAEB
	8Ih+TIgIyTut8aluTCToVDNyx6bjqO9Meif3nNMRnQ86OyO4GMucy5oyG4FqEdAkuGA0mz
	BU5kt9GjMtfUuqlP6VCqY6IXGhxu/+c=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next] bpf: Clean code with bpf_copy_to_user
Date: Thu,  3 Jul 2025 20:43:36 +0800
Message-ID: <20250703124336.672416-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

No logic change, just use bpf_copy_to_user to clean code.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/syscall.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e6eea594f1c..ca152d36312 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5208,21 +5208,10 @@ static int bpf_task_fd_query_copy(const union bpf_attr *attr,
 
 			if (put_user(zero, ubuf))
 				return -EFAULT;
-		} else if (input_len >= len + 1) {
-			/* ubuf can hold the string with NULL terminator */
-			if (copy_to_user(ubuf, buf, len + 1))
-				return -EFAULT;
 		} else {
-			/* ubuf cannot hold the string with NULL terminator,
-			 * do a partial copy with NULL terminator.
-			 */
-			char zero = '\0';
-
-			err = -ENOSPC;
-			if (copy_to_user(ubuf, buf, input_len - 1))
-				return -EFAULT;
-			if (put_user(zero, ubuf + input_len - 1))
-				return -EFAULT;
+			err = bpf_copy_to_user(ubuf, buf, input_len, len);
+			if (err)
+				return err;
 		}
 	}
 
-- 
2.48.1



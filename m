Return-Path: <linux-kernel+bounces-890447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D35EEC40139
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A729C18999AB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330582D4B77;
	Fri,  7 Nov 2025 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a2KtZcLC"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930D22BE65F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521723; cv=none; b=HRDZLm4Ug9Bu5XG9G7V/MFHro6cWd2xZwL95Es6hQdATIi9FkcEp0GIW3DgGT5q6s+pIniyG9mELYPXIEHizLvYTUl7jJlDJTVK3h66z0FCqTjme86cL/Dfj/M2Szit4iqZJlnp6X8w64WrwVIi4BMhfj8P6E1SI0ED9Tk1QzYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521723; c=relaxed/simple;
	bh=4L7rv6yqeGOWPHSVFKeIOEaE3Q/ZuzU9DV1DV+CwjXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X/jF1MFWQHh4zqL2lhzqtcdfHWuQctwXYxx7qUsqVguCuP+IzRO+m/VZcl/NxqTiFWcGk7ds/qX6369QUMuQIISsN4j5ppJxK9itpG6yNwwHBcb3sBrFHDx1hnWahaYK6/fm+8FH/3T1sreIKPiTMBJCMztITf3vz+gxJHWmbVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a2KtZcLC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47721743fd0so3528965e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762521719; x=1763126519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rh78oU/YAfiYxgzMOH8N6neb0Ycl4bYsCIiktHOalV4=;
        b=a2KtZcLCWaOX6frul9/Cha6nC2JTsffXgEBHFTXv+BV8383fQvt9N+vlkQdCbRzRAL
         d1v+pzdW0y2FLFvGg1Tf3/+lKFG7pCElIh+/0ZrpWZKzhWU3ypG+SGITqrIOJNhReNhC
         kT5TwTQPX7321nObRGqAETT/w5sU81O7kAqI1lSei4qLZJCoVtVSgi6HkeRhtQ8gYZqy
         /qNKRXer7HsDG3JrpgiqQXQKSOff8n62uJtIxmK/EF49k1xkhXXberjUIoZPjbvFdM+g
         GIWIl9de2OpFES0pddu9Kkw4eowoZIIDaJla3zJOZ22pzYSU3oJ53KPl1nYdQn/9NavX
         6E+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762521719; x=1763126519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rh78oU/YAfiYxgzMOH8N6neb0Ycl4bYsCIiktHOalV4=;
        b=hdYICPOFjkQyz1d3jwvzui97IrTB1pY5XBszTCN4tZTX4qx2NThjASfPF+OS+YT9dC
         Kt4JZugkDva9+IXiu9JlZr4E3uHHV5TsgccldbBFCC6zsLevqIqqyAzEIlL4k2UlV53c
         sDwmkuZ5ZdU99iQdcg5TmAS5OItGd5rVDFNlhJX1MgtpdzurLtswmSvVDQN2EyJ3sJ1n
         aeR5ycqVWV0OV9vLnT5RCM28pKpNhFiFt8uJOwcrpVGrVvNk6/aXz7Kv43xkZc+w68uH
         8YgjDXACFFubvvOw+FwDE9jQDFAVKoYaZJWyrDK6LY5uA+/5bl+z38n+ATRcfoaRpQ66
         45kw==
X-Gm-Message-State: AOJu0YyIwtQ1WTR5OP71FCDqgkqCFMx2dXmQXXImJmAtDgoWXAJ5d826
	2l2Rf/Tyzm9e39eZ1OZF+3USO1pXAaunAe80pIOXnPT84kNfWIMFYsexzM5Uq6qKHu7kSYfIQRV
	KwX6I
X-Gm-Gg: ASbGncu3Z16hnq8B7KN62Tmh6nLRJDkBNmyvl43/WgQAFHNlb/gavTIh+jIwbr/yq0Y
	9Wb3RFGxjNDpBSkjVec11m3imfwgoYGroCYraSnkXu8r4w5WCBfz/kT9c4ZEaZi+w1wn9lhVsBj
	tSQH3dFleKgxh+kKEt2asdahmlzshl1YyiyGk1Lh5BWlrSKHNFXzADxsA4LsKnr4BDPvhGpWGLj
	lmwTGTBmNDLxKFngjNo7lrWNz+VlBpTKc9LMkhyeu2K9KhC4rWNWKodB1BXnmqJUiTgu1gKzms0
	GagS1aTua0UvWWxG9+DjgWmBeg8bMNSCFoqzbW+omf25codXaLg5wJ3KPfP1XRCK2A+ptOObsTf
	QJOiJJOG1hHbsSTY/ANCfTy/2ltRfVSkP6RUvO40SVFk8WF2Z3Yl48N2TCwQlLTLYegal0j0bre
	yTVYoLqj7giAZKsrfqE1teW2/A
X-Google-Smtp-Source: AGHT+IHvp4tiTWB6W8q9xG6flKcD8PWFMur1F0f20dMNg3uj3iucIEZXsnCP4yN5Jix5iatncn9eaA==
X-Received: by 2002:a05:600c:a4b:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-4776bcc2c1emr24552695e9.31.1762521719525;
        Fri, 07 Nov 2025 05:21:59 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac6794f63sm5436469f8f.42.2025.11.07.05.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:21:59 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	greybus-dev@lists.linaro.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] drivers/greybus: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 14:21:49 +0100
Message-ID: <20251107132149.177327-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/greybus/operation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
index 54ccc434a1f7..7e12ffb2dd60 100644
--- a/drivers/greybus/operation.c
+++ b/drivers/greybus/operation.c
@@ -1238,7 +1238,7 @@ int __init gb_operation_init(void)
 		goto err_destroy_message_cache;
 
 	gb_operation_completion_wq = alloc_workqueue("greybus_completion",
-						     0, 0);
+						     WQ_PERCPU, 0);
 	if (!gb_operation_completion_wq)
 		goto err_destroy_operation_cache;
 
-- 
2.51.1



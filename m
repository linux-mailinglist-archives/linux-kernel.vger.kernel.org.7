Return-Path: <linux-kernel+bounces-896318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C59C5017A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7FFB189568B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7692F7443;
	Tue, 11 Nov 2025 23:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVZo9PpG"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A62F6926
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762904749; cv=none; b=mCrYgyV1SrFrzFpZm1FW7CNDJiyzLrMsyyRTfF3a7VADbal0XbRwiYjsgD++htvsyrgkUZOUmig31iCf4dJnW+cai2hLgBLZ0Zw4Qf4LDdP/yatPYGFicaDLxLnd+HKcf6sFWc0T3Arh8Tca407QTBEu40B1MNMOFc/4tB++YX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762904749; c=relaxed/simple;
	bh=ukB/kt5lU0oCOwqHtoCQZgk8ktpBo2Aczhz64AmGk+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZPnzgiPV4L5QgyJH7z0WcdIn5HrU/1kgQX6i7r1tjYuLOPgRwzZr9ly5dMwoQJn1QbrmBXIIXM4Rq0zbEEURjl9FcLUTt49m0nM4fN4OSk+beF+e7pRF06IBJvvpmZbbG/7G0VyHpQuTH5wecPCaQqEq/9kza5sQ3TEsMd6fL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVZo9PpG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso200293b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762904747; x=1763509547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p/KFseTdJU5ECuFMZAqhWIeUsRS2HXtdTI456/K37s=;
        b=PVZo9PpGnUIG7izdpHv4ud2KZwn5UQsNrup5+RDkXZ8Dsww15UlWRJmXCyCnm8cZfe
         2Z9f36wwP7RIpDSAytv4lWrkE5gA1DYJuTqESClQWEJACsTxnSi80JZcxVoWMtLsPx44
         MeQ2aPEEDn2gWyh/QngueFsVieNxmhqxShgYu1iSfsi5l2/Lj1MM4estC6oLIHs/Gh6w
         FyM4py0hXUxj0XQrsweQR6g8x70rdLA16DIWxQ36Wb6Qf3RXGfsyBC0pqgKiI2czFZ0K
         TqA/DVn/Tb/7LLaZRbjMLhKzY4SxxcZ+U23vc8R+DBxdfnmuJplGBNkMybxf/K/dqDU5
         MPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762904747; x=1763509547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2p/KFseTdJU5ECuFMZAqhWIeUsRS2HXtdTI456/K37s=;
        b=K217He2LZQslNGCCaOZsZ2Q33uA5YHSMcysHPm3ziFtwlVuEnwT1uUvReOiTZPh4gi
         D1/k3F2EjHKnsWOldUeOMLnRXVRbLx+dsDXuCe7GOSHGeEsTg4qawCZD8p322JsHSoEi
         PvT2B9t1PvkW1Nh/st8cPLsAFYLPOlusl0cjmnKmHlm1l/GIDuFDw0ux5gnwyoeoNmE4
         7o8VhEMjzw/Rr6NX7DnpjJOxpG6yrS7Tjs1m+rnZ1KKsEdc6zXaSh8puamgQDuh31tk3
         BSPj8rWbzj6z1pT1L9m/wPrJqgoYuJSRUmHxbaCZLHBsxxz60LdWOuG5zIPN51Jq48X/
         q6ow==
X-Gm-Message-State: AOJu0YwNkeVPNyi/W7eNSXcMimZx62+PC6ftqw5zAQbXCPgOnRXx3MRM
	OKqk+lOG4ayN+yJt+1yA+MRuel+rgDDG162EXy+7stMkVuznun5uOUDF
X-Gm-Gg: ASbGncuuuUGyxsolD+ZIg30bKCq+BW+tumVB+J0/Z+KgcwSVx1ya6aUq+2BPxPJ86hF
	vSpstr/eK7POyvCsiXBerFvjueb5UzIn6s2Q3rbEWCYGRhsQ9eZ7I3cXJmmBZiDrZkuzLxtYCtW
	fw6DEZzfOIRehCx3pykEWdIpBfJ8qo+jpift5li8s/wAm6PwI3QaGJ1V44QqDW0BcmhojkO4a5P
	eMHDyirPSfTQU/KUK5O/J5Up7FJhKIxj+IqboEXTzIu+eSo4/tXP9xOj+LMlga3rVTL7gQkq6To
	x9vpxPmn3ygx9tGSU8sxECs28xsiTo9r0C59u/NLAUR+udv1Nb4drHegQqb+4I3erC4gRIJ+X/Z
	Nc1upBLdyDY5ldjezx54LnPOEWQud1Zd1844CcNyaC296OS6WhRrxhyB90PG9hbmJghG0VGa3gH
	vJ8Et9/QwOuO6QbwOusPLHGdZVJVjCB4imT75rTSLofi7O09PvW3u0Gt7psW9CRJwhkTyT0uBnI
	od/F7g1lw==
X-Google-Smtp-Source: AGHT+IGide8hXCD+w4MdYBu886ZJbHoVxf5DzgOfAgFI6oOpn42bAU+zf1YX89Y9X9vGZEY4lGi5DA==
X-Received: by 2002:a05:6a20:7343:b0:33e:84f7:94f9 with SMTP id adf61e73a8af0-359090964cemr920215637.9.1762904747615;
        Tue, 11 Nov 2025 15:45:47 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf06e85bb4sm784308a12.0.2025.11.11.15.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 15:45:47 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 3/4] nvme: Expose the tls_configured sysfs for secure concat connections
Date: Wed, 12 Nov 2025 09:45:17 +1000
Message-ID: <20251111234519.3467440-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111234519.3467440-1-alistair.francis@wdc.com>
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v2:
 - New patch

 drivers/nvme/host/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..6d10e12136d0 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -838,7 +838,7 @@ static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
 	    !ctrl->opts->tls && !ctrl->opts->concat)
 		return 0;
 	if (a == &dev_attr_tls_configured_key.attr &&
-	    (!ctrl->opts->tls_key || ctrl->opts->concat))
+	    !ctrl->opts->concat)
 		return 0;
 	if (a == &dev_attr_tls_keyring.attr &&
 	    !ctrl->opts->keyring)
-- 
2.51.1



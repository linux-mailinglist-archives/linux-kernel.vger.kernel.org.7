Return-Path: <linux-kernel+bounces-758653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D91B1D210
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35DC8162C1E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 05:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C36211499;
	Thu,  7 Aug 2025 05:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Xe6/WqHp"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7994B1E25E3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 05:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754544952; cv=none; b=hoYOQGvFZxuunPACylKhaZ3oqygwZ6GRhhuiqE6/mHasS5rqorJqvAbdBeQ3emNAkQHKRPT6SDyVigfFYM7sMJt/vyx2XjhD4/cgvv3KjsWsHcNvzt+LRcrRg1Jwo7MKWMDW3ukQtVlwv3tsrj2iLXKR5t1PFDT6wEMFgglQYxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754544952; c=relaxed/simple;
	bh=SHbPesG0UHqenGAmo4nydeJuWPG9WKBwQJ78Ppc0048=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AcMC2TCfBcS9kWRLijAhVaDD2SXSm2LvF+kQrqYkgzUmqeUJuQ02Wwookl69bt6RkrCq4zo44el8sH86zOXfCV0qWO0PKvxIeA4jy6QskIjwmO2HC48W8EPqZVZl7hi1FFVaildGGqUBV42HmR0422JJ6B5O3B2srU8Djfr7l3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Xe6/WqHp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76bfd457607so724353b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 22:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1754544951; x=1755149751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QoW10+RcxtJxMxrx5pWJddPJprR6x75GK3Y5SnJ1n5s=;
        b=Xe6/WqHp0xJQgmdizMt3qukHHmbBnWm0NgENXpfUX7mx1NofvQE6Hu5W58DcM0pMgb
         em6JQj72UYrvh62jw2jaiZEeFGId+d28Pm9K2JdLG3qN44hCNGAw2Nh/HZ1qBmNbVnja
         ZBqaoUHaC0NnARLtGPYFNuyy737jRnumbIg+Kow1yafLtkYCsx/gq5/t4qKrLWcIjpNM
         dwV+nZWuiMUes4bVSMy+jFNfmZ/lAEA852kgXoAM2AT/6qqjkMQhxglHa8iltYWkEvzz
         8dQYiMVip3tRvXaAveV0M3aOJdpv1k33hgYVbjSNgWsbNHE0vd+pKQ3DtThdwcCRxmKO
         oT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754544951; x=1755149751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QoW10+RcxtJxMxrx5pWJddPJprR6x75GK3Y5SnJ1n5s=;
        b=i/afASCmk9D59a/auP+xxbtVu7zzNvKFTC0ZJ3OwaxU6fCQkbRgaqUvck3ApvaZCFA
         osb+JcHqx+XofCCLiZPzzfIgoRcNPqRLuHpaGEel6lwKi4I8LSOVYVjhrlu3e2OotR9R
         AtriSTS4T6V+pPQ2ykXUv31zBFFBwYA3h0u7G7fNYK80y/iDe9KDtzgAsaeFmoRFsh6h
         83aU2rxTgUumzTIwfqyR75e+csHtfBW8DXhYg7zgICTJDMy+BlTuSQ0ehR5kk6UujEtd
         FS3Y9BlffOSnaa2JD54lhvIJUCvrojPpEGgddY07r0jrGW+4SSBS40jX+oVOxj/rg13C
         JHqw==
X-Forwarded-Encrypted: i=1; AJvYcCW6AD2seBAzrG/dmrjh7rwsjWT7cIqElRcDvXhg7oXhxdZIxXONz2Us2jnYmoT+dslG0fIp7YZfLgGE504=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyez5Fyt/ZFQjyf3sjS7q1k53U1pfUKgpTezY13c4uoWjfZC2Y
	Kg7WJ4tvvGxdk0KK4cmtCoxb5GpgI+FGKYY36OyH67LV2KUZ7iF+5fNdwLFbRx2MN+s=
X-Gm-Gg: ASbGnct4NUuIiRW7eICgzPXrrsLV06obhimQqjqkoFAY7UifzfBeuLdSlsCf+3B8Cyy
	mctY+bfeMJ0ubsPD+tMTgweEKKGVkhWwbC9X5NEN4hpvM3V5mFs3Scu++cTJCxn55w91HOgjjU0
	d7kh2V2crQEJ6jIFYsO896FkQoS52EHum3bmKIsyaq1xdTviqLsN7dJUcWmy9recBQ5rKCbX5mN
	uMNv0yoqBhyFdpZka/6j7DqIOClu1StiT7uDTJCMYNt64EWJ/ALgBaDcA41lW2fIfxC5v7pPLrO
	H3lsInmVpsLoWjmO2tOXjXpYSkLdXAyVrAYl300Koq08X7K/v5BotM+b8jM7jznsoHA6KDLLlYH
	phqkdesImV1oFxVpIqHiyFwHwHU6OyMfZ3CEdtuY=
X-Google-Smtp-Source: AGHT+IGeyHcVUYRXGoHcwS/JcJOXNo7fQU6bAK888L0yq4XpFiifdOi5CrgPuZlMwnAPe9aSf/fYLg==
X-Received: by 2002:a05:6a20:559a:b0:23d:9fd5:9231 with SMTP id adf61e73a8af0-240315b3ba3mr8005141637.46.1754544950644;
        Wed, 06 Aug 2025 22:35:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8202:6fb0::eb28])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-76bf772116asm10978824b3a.97.2025.08.06.22.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 22:35:50 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-block <linux-block@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: exit debugfs after discovery subsystem exits
Date: Wed,  6 Aug 2025 22:35:07 -0700
Message-ID: <20250807053507.2794335-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 528589947c180 ("nvmet: initialize discovery subsys after debugfs
is initialized") changed nvmet_init() to initialize nvme discovery after
"nvmet" debugfs directory is initialized. The change broke nvmet_exit()
because discovery subsystem now depends on debugfs. Debugfs should be
destroyed after discovery subsystem. Fix nvmet_exit() to do that.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs96AfFQpyDKF_MdfJsnOEo=2V7dQgqjFv+k3t7H-=yGhA@mail.gmail.com/
Fixes: 528589947c180 ("nvmet: initialize discovery subsys after debugfs is initialized")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 83f3d2f8ef2d0..0dd7bd99afa32 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1992,8 +1992,8 @@ static int __init nvmet_init(void)
 static void __exit nvmet_exit(void)
 {
 	nvmet_exit_configfs();
-	nvmet_exit_debugfs();
 	nvmet_exit_discovery();
+	nvmet_exit_debugfs();
 	ida_destroy(&cntlid_ida);
 	destroy_workqueue(nvmet_wq);
 	destroy_workqueue(buffered_io_wq);
-- 
2.49.1



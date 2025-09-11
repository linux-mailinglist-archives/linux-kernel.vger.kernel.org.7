Return-Path: <linux-kernel+bounces-812872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411D3B53DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270F85A5B08
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F762DF134;
	Thu, 11 Sep 2025 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2KK5Qks"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D4B2DF14F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626734; cv=none; b=XR0TxfAM9iLtIDjdpXoF4lfCPMKNuoexvwfoSeRHHPQoQFsMygaRJaLkaYMEFNVb3KAsFMzZqwmtB6BCovQvms/heLNortsZMD0PgeABkK8OIFHjCEHwzgmHkg2aGWYZj3MZ31U8aeUkpZ5INwF6VCw+lRK/mLdbE2UaZPG0+2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626734; c=relaxed/simple;
	bh=xfWOQ2T373ADf+tcgIBcHrGpfWd78TIqVBMM75aiZ8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6MH5bsu/iOxmuo+uAlhKhkyHepxdUDVl7HxIOK3DhM/v3TTQpVfwGq06JGLlpFm1JLQz6Dhsx6+QcLvXj3J+C1CwHQ0P6u7mqZG9QiIxEO04r3LEYeemN4ru12udjnEcxXzfuaSxMnh79Tiiihty50j5tv1+hvhRrcU9FBUYME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2KK5Qks; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-887764c2868so99302039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626731; x=1758231531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCaJXGEEoKxacl2B/5AyBFFUSkEK+Qm7rR3SS8wI7Gk=;
        b=C2KK5Qks/dIwHmqxj2lY/TCr6bdz5h1ZjVewhg3pUiY5QVSizpAW7av8dkKvpF7rqQ
         0o88KP0aDkEmXhed7RjsK9zm5xFyQMn+FfYsLCSZFJuSxNAQCV2csrLjKlFNX48tx7Ui
         bI7P2OYC5x3xxRI2svmzTI/XoxwODzv+psPOYBsENgDbUdgNG1r3ynNX3WW08s7k6GJT
         P6tymqkmRccHlx9x3uikzZvWaxdJnlVnkuhRD8eDEGStv6B69grnEar93L+RQV5LNCRx
         NfeN5PEDnYIsxkh3eD/VtWzvPUOh2g7a8K4dk+gZlakGvjYqGq8qcVSAYKz15mjeByKK
         fdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626731; x=1758231531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCaJXGEEoKxacl2B/5AyBFFUSkEK+Qm7rR3SS8wI7Gk=;
        b=Naz34glhT8bN94DIjlvF4x3d4CFPQxtoje+mdJQqX1JW4VdG1HolFPOOzmaTB1qboJ
         jLu2cd6UZ8og/lS41ONctifJtWlEM/JiMscRAJLN+gSqCLr7T328OF1o7+FTYUm1JBcE
         ZCIx7O22i8S3sfpBhzO8PL81ViRxlZW5xaUdZevBd40rZaxAv0TdTnzsects9D6T7E6H
         Qs+rin4CBPVWE78uVKSaGxws9q//akHteEUfz44u2C8songdH1XqHKyaqFYmqFJLsXgH
         df0kq/pSuSbmC2sSx5ped/I/kSt/e/WoAZNkjHyCtR1Y4vQ4bbEZYbpqC54LIwrqsKy8
         CgwA==
X-Forwarded-Encrypted: i=1; AJvYcCU2U2JqNa5f1eIJd8Z/J511Bhh1UJUCuNAhYgmiuKokhh0McqR9DUzOaLLkT2BJPGU/jX7Z0L3z2K8VYgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR8jh8WlFe2i1ZlWdd7xE7wcKispEyZ4TEUOtu8NZcdGCQY3gK
	JznrB6lwDHPAaqriPcWGJFZdxRKmEXuV9SjSG57TIXbTt7nQz1qZc8HxzRlbWw==
X-Gm-Gg: ASbGnctmzONSSW6AeYT3XgbE09DiBEMGWML+6CPpoIHnNJlzkMUC7+zCTgOyFKKT4Rd
	5H20WbYR/IUTYSqJA8a9quu0ASVMuJVkobykvMmEhtbnnacjJTtQ+ETu4rK/NFvrf6OhshwAa2f
	pM6pB+lQqp2audsZ+Zn5AoGcl0skECW9mPzZBaw/K6F+jrswmd3yG7umGkkTwjEHGJkfGJjX32E
	WrJ3aw4TpZTT2u76+Xh7H493LdgFAYrCPBUx1TdQk+AAinz+UJKZZ0ukIN0jM165OwTaiz3/qU/
	/MkKKP0mceT7ZVXsGp5qeWvnBNqSdp0/3LurK48Utuj24DgoaConX/YkeSz2hoWV2BO8G0B7RSi
	3zRS9Cr5oKXBFK1eEmA8gHoIYx3IeWZvNQ8uuWcbZt0ZMSDbL449hn9tXJuAHttmrD18M8A7Y24
	5jYhQ=
X-Google-Smtp-Source: AGHT+IGiax82XsUothUdCl5sAN9TU31U37fERUoxmlfD7pa0eSePddsRUvkK8lkSCbEZ8kTAikGGFQ==
X-Received: by 2002:a05:6602:3f88:b0:887:773f:6c89 with SMTP id ca18e2360f4ac-89034710bf0mr122833339f.11.1757626731288;
        Thu, 11 Sep 2025 14:38:51 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:38:50 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 04/30] dyndbg: reword "class unknown," to "class:_UNKNOWN_"
Date: Thu, 11 Sep 2025 15:37:57 -0600
Message-ID: <20250911213823.374806-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911213823.374806-1-jim.cromie@gmail.com>
References: <20250911213823.374806-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a dyndbg classname is unknown to a kernel module (as before
previous patch), the callsite is un-addressable via >control queries.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it uniquely greppable.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5a007952f7f2..147540c57154 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1154,7 +1154,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 
-- 
2.51.0



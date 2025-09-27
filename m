Return-Path: <linux-kernel+bounces-834801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B254BA58D0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA5F2A7E4A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 04:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D51222756A;
	Sat, 27 Sep 2025 04:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfwaXPxH"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DE21C6FE8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 04:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758946502; cv=none; b=QjZgylk2lRPgbLf2EKBi6YNbAiYLaQ8xXiP8LDtg8DgegGJZot2Zk89/yfMSaBkK9IPSm2Bm3XnpJmGtmR3RXORnGSnSwh8BxwAMFWhD4SQUf5U5u3Vg+8yxVQ32N5HaC060Jph4kqhtbDWD139/1bwZod8/WqF0zf1jJuQx1yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758946502; c=relaxed/simple;
	bh=QkK1F0a+kzX8my9YSnIKVxkRpFz6GcOBLwOB3cM8EUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnuSIu5eTSyfaQxfQ5Y+Qn8wKQRfnUsSKUnvbPVvh7jHRGGddDKhDHINdh5tZ9WVie+ykcrTCJSwJ+OzuaXu4Ht4SGHsJXFyIQCyhDeT7N0ChFb/cjgd0SoHr+a1tMHPXI+wG+tuJCOac7fIX9ZRG6Um4RR0hZOPb78IkIVIR+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfwaXPxH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so1829626f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758946498; x=1759551298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QebA45S2Kmxb5ZKr9Gn50ibmhNW02p2JmvNbHpjCTfM=;
        b=SfwaXPxH4ykHpuQvQrlkROXMqJPL5OFOUiiVk7e8U0BgiUyFcrN2XaegF5AwEdyqDE
         +cAR5Mi9m8EAEZjZ85SGDDPtGkXTo2FD1hItq7Op2esR+obZqcavCAL6W46hTDekyahb
         7Qq2vqHvJVfNFZ1+W1gGkGHORf9BawUmjBri6S0LxbnikEiqQVsswhKNMGbRnbVd7E8z
         WWLbQRwak7A5VR3fgcUU2V3dY6PdremrMyfZI7KFTCkWq+N/g9EJu60VkuieaZEVuXa0
         XTY4rH5lqoLiQsrVAWW4t2X+QhWvkXK8l4h34Ne1CCHxW6wozRxYU62wzKBcM9t+szXC
         Qu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758946498; x=1759551298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QebA45S2Kmxb5ZKr9Gn50ibmhNW02p2JmvNbHpjCTfM=;
        b=dg9Zf+0E5UYUIuMgWItYFSH1DSJwDyZr8zM04t9vLt7VNiTQjf+CVP5nWfONZUlg/G
         RVrE+VnOejFpOkPJuL5YSFXA/HvV3tcbbPyXx6ZqhSgzEPPxXby4BuYFp45g6zfmmD1L
         EoYBwemXjdkhT71Ok3qWvdH6UItDUrX/JHxXKGqL+kvLCVa3eulcOMT09N0xPk8fRWd/
         4MwzYcIPve+QE3vsKBp2qv5BYHS/zRhrCBgU/DKYY9Wy/RQ1+zY9k8FvtwLw7fF9ITFc
         rOYNvWIT+r2NBe1I2H6jvp7gbh5xra73OVfnQz//qMJKz9CUSmgtKbKZCxx4fVuIYZt2
         TzAw==
X-Forwarded-Encrypted: i=1; AJvYcCXqM95+Gd9y9sbR0nwxohcZZ0i4N3S+n3PSUKGqh0EfKcFeneRhLR5IACaHIGxuiByz7u9rN8QX8Xy+vl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw16w4skcYoz6Z2WwGOd6Ux06I7wn9tddsnrz2t/gLnBIEUstDL
	8RcdQu9/vxRu1WUPl7yUOfs1IOTMc0FSiHkRSTLWfK6wcf044LUfSXss
X-Gm-Gg: ASbGnctJwODduppBsLWpqbz6/4R0P/lIP7qoryEDia42LF4/mw1u5lD9sRR1gPAvjwD
	F4ZwX00T8d8xzN7bAXPVJgsWIOCbRRIy/ZHqcKgX4sX3JuTwlHkjjygLypopppzYhuq2kqz5hN9
	q3Md6AKYna6V+UCT4nYChfzKfQTFq3BVDYHt3tOln13J7ocBu1uGKzy1F27UZa46iwBXbxu1cEf
	W8YnQO389LA2L1wpl/Ck4zQVDr8OT9wifNMJNCWf/zatYxPLorpNlBAF6RnDn7nrnydsfS3YSa+
	nvWhl3G/wdyFKU9ip8QgGM38Tt7VBll2s2WFUOGEsIYh65i+HYdQ5h77kThm1EAbvAre82to7oI
	lBo0ryPkGBFHZVMjHdQTx04rIZq0aEVes3d2Xpgi2
X-Google-Smtp-Source: AGHT+IG2ALooHlYHwOr8MJjdyq/V5jhItcUSlgKuJmsEuxddU94wf1KuErdmeXjr3KPewFZcuGMZYQ==
X-Received: by 2002:a05:6000:178d:b0:3ee:11d1:29dd with SMTP id ffacd0b85a97d-40e4ba3a8b8mr8495940f8f.35.1758946497885;
        Fri, 26 Sep 2025 21:14:57 -0700 (PDT)
Received: from hangmanPC.. ([86.124.200.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33105e0bsm50386665e9.5.2025.09.26.21.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 21:14:57 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: wsa+renesas@sang-engineering.com,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v6 0/3] i2c: pcf8584: Fix errors and warnings reported by checkpatch
Date: Sat, 27 Sep 2025 07:13:57 +0300
Message-ID: <20250927041400.172949-1-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aNbWejNZLYGuNvCI@ninjato>
References: <aNbWejNZLYGuNvCI@ninjato>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello maintainers,

This patch series fixes 18 errors and multiple warnings reported by 
checkpatch.pl on drivers/i2c/algos/i2c-algo-pcf.c file.

The series PATCH v1 to PATCH v4 is a response to the discussion on the
mailing list with Markus Elfring who had comments on my earlier 
submissions. 
He suggested:
 -to split my initial submission in a patch series
 -had some valid points on imperative mood usage in commit messages
 -wrapping commit message to 75 columns per line
 -change some of the commit message to point usage of checkpatch.pl
The series PATCH v4 to PATCH v6 is a response to the discussion on the
mailing list with I2C SUBSYSTEM maintainer Wolfram Sang who requested
some changes:
He requested:
 - to remove debug macros from i2c-algo-pcf.c as no code change was done
 for almost 16 years.
 - remove wrapping paranthesis from value assigned of '(0)''.
 - resolve conficts caused by debug macros removal.
 - remove also printk and dev_dbg function calls related to DEB macros.

Here is a brief summary and order of patches to be applied:
Patch 1/3: i2c: pcf8584: Remove debug macros from i2c-algo-pcf.c
This patch remove the define of debug macros and also their usage from
code along with printk and dev_dbg function calls.

Patch 2/3: i2c: pcf8584: Fix do not use assignment inside if conditional
This patch takes the assignement from if conditional and moves it by 1 line
up.

Patch 3/3: i2c: pcf8584: Fix space(s) required before or after different
           operators
This patch adds space(s) around some binary operators.

Testing:
   *built kernel and modules with I2C_ALGOPCF=m and my 3 patches applied on
   top of 6.17.0-rc7.
   *installed kernel and external modules generated by build on my laptop
   *rebooted and loaded i2c-algo-pcf.ko without i2c_debug parameter.
   *when loading the .ko with i2c_debug parameter an error is seen in dmesg
   and this is expected as the parameter was removed.
   *No success message related to i2c_algo_pcf was seen in dmesg but also 
   no failures.
   *Module loading and unloading successful.
   *No PCF8584 Hardware was available.

Cezar Chiru (3):
  i2c: pcf8584: Remove debug macros from i2c-algo-pcf.c
  i2c: pcf8584: Fix do not use assignment inside if conditional
  i2c: pcf8584: Fix space(s) required before or after different
    operators

 drivers/i2c/algos/i2c-algo-pcf.c | 93 +++++++-------------------------
 1 file changed, 18 insertions(+), 75 deletions(-)

-- 
2.43.0



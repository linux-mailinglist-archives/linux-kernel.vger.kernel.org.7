Return-Path: <linux-kernel+bounces-849072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C08BABCF257
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974A74278A3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDB5238C1B;
	Sat, 11 Oct 2025 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAmds/8Z"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237CC212B3D
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760171577; cv=none; b=q8FbDsNqzEfllavZIJKLkkdmHkR0weHYxdleu2GVJ2V1IvYjHs6DRJHxEVYuAjs2RVYmh62k4ZDyYvVOzH6MOeKcwSB3hNicni0onjQEbR8z0kbN6sT/EnzXwZxTsuJ3mSJYbXlmJNL/upmg55nR4Pdef+GqxpsZyrNotZU9DhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760171577; c=relaxed/simple;
	bh=4tmxTvNOTpOf95JJ3x7mQPqFH75GrdZlng+aNIh+4xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DjmHA9IwK5X+byaRuW4JgZPAMIp17/57sjEFXTe3gG+JEkBYQHB+gUTBbUjw+1ciAhBQtqMBIN2JrXdCdE6pSFHVARHkCQBvNDjpmpRbReTp257Ke91w/05PZkGe1OEMSVGZC5n8+pIs8Pa7dY+fiQBqqnxp1JWJaf1LxNjgesA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAmds/8Z; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7811a02316bso2001702b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760171571; x=1760776371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ta0EmFWq+bNf3nosDwmz689S/1I/sZSzXyh2AonVWo=;
        b=aAmds/8Zrqu4HcnZFV3ntoyzvWTtoEjbCCISw2w4DOmknuju4C+kBHpYfr3gbbgbzG
         2XOtVksrZ75khQC9QeDoh0qF+AKba7GJOj7sM0e4LX9oSd2EVsC2XxLS7wbCoR/tK7KT
         lqUs9pSWgVfp8gycBHbriWuwYPIqd2looq9pPYqNKOeTVTt/5P8/etg8NY9G3V1ri4TE
         EGBeYbwdwalm+2pkA3DzXDj7c9Rk9+xwvzaQ0rW+6xyWf4aVsEMa3pD27h12PVTjRkGm
         l3+ireC2qIhIiAng9QJha6eNs9m/ACH+LqISV9Vw97DoCGv9ryOCj0+de3kjynbn4nN5
         HhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760171571; x=1760776371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ta0EmFWq+bNf3nosDwmz689S/1I/sZSzXyh2AonVWo=;
        b=Kv8EM4z/m0eBJYVQpTEtG/h96fWo93lsjpwMTyqKo9Xa75T9+pA0XIllqxrojirtJ1
         yMTnQ38WUUCpinzNfRVjueZa9z08GYYeNpJDDy6e5Aj1CvIlcXLyJmHTraeT1ZpG1MUw
         GJ+kVdYB487+K7/VKToB4Vd9pSeZ4wjMvTTIarL+KXkloL3p3sVrvHjgRpgLBm85r4hM
         UAx886zAt3M5sqIkaE5x75rMw1VgIEWrGoyL2C+JqOCNeqLipMdv0+kcpTKnfK0YKuiA
         0MJIYys9x2QnTEPybVHscfyyrnfmFWnfDwYfFBXok70Jcu3qtXt/qKt34ZfuUeXrj0h9
         BKcw==
X-Forwarded-Encrypted: i=1; AJvYcCWWJKawKwc1tzIpOj29IXPOPhJrydqRIbG6h8AnZd064m4c1K5yBGXanazu9UtnUzs5ds+p9s7sy81aZ+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCxdcl3OUipfa3LK8LGCK1fEeunHkMdR4uf4P6qzu8m9fZ7LxK
	INAbm6nIRfx09hzRNAsQvWsXKhkDJn1PwB7DF7OIo1kwN6Kxp5vVfVYC
X-Gm-Gg: ASbGnctG+Q1UNYbsT65BPqPgmJvGVI/gW11OkBMHmwRreFe5VhbIF7zzVVHB+1IEauh
	3FHksaRRdpcVdLKMt/d2xo1hCZ/lpQrA5P3wGg9zpBwRk8eWqj5pu1ApmvwwObMJacf+I6rHdeV
	3ZL6o03zl5D4ZFzUeaTMG/sJ/3ev8mBhfuJHz9xO139LHfdoKtmf7sXd0vEYnUV37kreOGEzthv
	Xs1qzPYT1RxVCb/0D+KVH/oaYoDVqsosTUzGFTfTs42UrRytSeOn1QCUlUUa5PRsUEzNCYyn6RK
	sDEDO2hRzui4LBfTvsdsOw45FR7NhD9H/20Dk6rLWZSXlZVzg+vQUwiL+lhjsdeBIYuoppSuhv/
	n6oD/1YFtdXtzdFI5cv1OtkwyoA/GGlMXfsitUXpWPL27JG20ixA97U2szs44Wfm12FxQowxTAt
	cZQei0mca+8wdMhoaXSS8tTg==
X-Google-Smtp-Source: AGHT+IEr8jO/C2ScZ44WpNt6yOISZY5vZvGKUrMj1uETIsBCaWMtX1NNVkmfJdO2zBDw0rhDy4h/bg==
X-Received: by 2002:a05:6a21:6da2:b0:32a:91c6:e085 with SMTP id adf61e73a8af0-32da818334emr18113949637.11.1760171571316;
        Sat, 11 Oct 2025 01:32:51 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:2be5:a957:8629:d978])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b67acd88c77sm1292518a12.34.2025.10.11.01.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:32:50 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: heming.zhao@suse.com,
	joseph.qi@linux.alibaba.com,
	mark@fasheh.com,
	jlbec@evilplan.org
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
Subject: Re: [PATCH] ocfs2: fix stale extent map cache during COW operations
Date: Sat, 11 Oct 2025 14:02:44 +0530
Message-ID: <20251011083244.822985-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Heming,

Thank you for the detailed analysis and feedback.

After further investigation, I discovered that the ioctl call in the reproducer 
(0x40406f06) is NOT FITRIM as the syzbot comment suggested. Decoding the ioctl 
number shows:
  - Type: 'o' (0x6f)
  - Number: 6
  - This is OCFS2_IOC_MOVE_EXT (defined in fs/ocfs2/ocfs2_ioctl.h:222)

So the actual call path in the reproducer is:
1. copy_file_range() - creates reflinked extent with flags=0x2
2. ioctl(OCFS2_IOC_MOVE_EXT) - calls ocfs2_move_extents() -> 
   __ocfs2_move_extents_range()
3. write() - triggers BUG_ON

Inside __ocfs2_move_extents_range(), the while loop:
  - Calls ocfs2_get_clusters() which caches the extent with flags=0x2
  - Then calls ocfs2_move_extent() -> __ocfs2_move_extent()
  - __ocfs2_move_extent() at line 50 clears the refcount flag on disk:
      replace_rec.e_flags = ext_flags & ~OCFS2_EXT_REFCOUNTED;
  - But the extent cache is not invalidated

This is exactly what my v2 patch fixes by adding ocfs2_extent_map_trunc() 
after the move operation completes.

Thanks for your time!

Best regards,
Deepanshu


Return-Path: <linux-kernel+bounces-728891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C55B02E89
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 05:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096B7189FED1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 03:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC4A1547EE;
	Sun, 13 Jul 2025 03:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faPMQ1+x"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17F72E36EA
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 03:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752376126; cv=none; b=iFALYqu3GpZ8EA+i2oWDfsiz7RefymY5SpUIEUvOL49/D2gMW4yCKCxqbGeeCPgMolH3dq0rzLf6mYI2aYQ0jjwZdr9SgGPWw7wBcM5veAdDThlyHnQsuRgMA8cBf65tdlKq7ruvS8Q/o76H6Q4/xzW4GFaX62QlZfMhL5cK5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752376126; c=relaxed/simple;
	bh=fshDEBR2i7IBZmUt1AI9AFDY/oqyeRo+EHkhYTOXZ28=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kQR4dAjc50Z447+3VU/xdLlg7GJukpCWH2PW9v4nkCRiuUkhI+bsGn8GVU0Q5OJGVm9Xw/q8BWeyVEYRgVPxXMmahpGR/gnACYlgGbKaorEQTrP5D11l0UAP6gmv9OfPXgWSC3DEdGDUWSZ4tyxDn1bQRNFzUbtIkD0OboADB5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faPMQ1+x; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-747fba9f962so2745002b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 20:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752376124; x=1752980924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=A/PhcnKDeXDlK41TAaCBlrpWKfmPmHBfg52otSkZP+Q=;
        b=faPMQ1+xZgpGp9zXfkHx00euVP8/+jjMI5/GXsG1HpHyzx+1ET27pBiIx/qfAwkdb3
         P60VcGKzgeZn/pujzlEVlr+SdfKGmntvHzKtb4mmpabTQJsWhx0vW2QSpteE5B/xbeJb
         jt1S+KiBVcgIhYqliHbJOaZIw2NJFUZieS56VMtJ8OTA8f6yH5U4fXCCSRBqgGKXhTH2
         9VQkS7sjlJ6iAoclQtzZKT/o1MTKh7t2GmKKT+TDqCSuH7x99NqEXbcrqGlXQMLQBal9
         tcW7WkPwEfJ1BwnybXj/NzJbVv0Bb/h24KZWyOiWp2zbcxR7WUDe3kmyueT8FEMAWX0k
         2eOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752376124; x=1752980924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/PhcnKDeXDlK41TAaCBlrpWKfmPmHBfg52otSkZP+Q=;
        b=Xzo7OcqKSib03HPom4XnC6R7ScXNLZTvncNhIOYnW/LhyBwE16sbpYG4jvGAGFz3eh
         9llp5uEcg43JaRSh2L/4C+dTjyIztpnRuvkYag8AzNU7KCzLhjyu7aZVK2butRsaei0y
         5Vw15zMlktMXddRg0rnYQQj4+dCkpytcSCKRvSOdvC0zFbtsyKgpTFZxSCUl+7OSBHvx
         eQGPzyKi/JoWMDInvpqPkxoCEKA/bBgReJVkCpcIXQ4GIw3ZWPXMSkq4e1JTgM81qDVR
         UhL+IvXBlJ7BKJmtDxTdPqg/p4BSa3BjewIbkFsRxkQvl5cmOobwVYF2w9W5E8OI3s9f
         7H+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmVQGDEaEo1RBMFBiiZb3EeDMlIMBDfRer71rUfMNYcQzXqh5VV8nFhkDJa/IGyaZqEONaGs/MKVtUcxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgJUF2YYlpr65iiGFN60Lf2VfQ7LQ9HPKzsKq7hC4BlX1q+8+O
	1zy7tP3b4YINwbws9G9t0bJZ49+8fkQZHYykXJHPG0oQoRts4tLi6gm4
X-Gm-Gg: ASbGncvaPE6KJYfSdpUBq8y0KVJxhOadEA2Gx4e99Nmgbp59TzjbWlpjZQqFGf4tbz3
	QipdHxIBPxPTl56w4GcVUQYSzH4TBMeLaQa+yv/jXcsNS1kLZ3twc/FslAUjR2PnnaNaYXn9X5z
	DYy7alDKQlEe61sAoySWrATAv5uG5xlSN8hYldSqA2qq/GZ7UO/Owp67Zd2fS+DjjcbvGuaC58H
	k00FRjvLrVuXpS7PJy0Xa2bmPsnaoCn+/PN4Uv6T+/FD7RkSX7yg1ITp02/K+DOeNnK6UALh+z3
	+neR14yaF9h28H9NpLB2aPU+3PACSljnom2aYsOJckwZYcVukoibzFKugv2pZmjjpIn5bONEPuT
	8gud1m3A33Mt98WxLwhudpR5AMYcgDYlvcMoIfFkpEeRkqcs0g/CZNjdm
X-Google-Smtp-Source: AGHT+IGzyclkK5eywpOjPfviPQDuwjyLNw5/+70ZTikNMITeGItxELZn/civ3Y1/NtcKfUArmZxAqg==
X-Received: by 2002:a05:6a00:6d58:10b0:746:1d29:5892 with SMTP id d2e1a72fcca58-74eb593d0bemr12706772b3a.4.1752376123869;
        Sat, 12 Jul 2025 20:08:43 -0700 (PDT)
Received: from localhost (212.18.125.34.bc.googleusercontent.com. [34.125.18.212])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74eb9dd605dsm8108739b3a.18.2025.07.12.20.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 20:08:43 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] panthor: print task pid and comm on gpu errors
Date: Sat, 12 Jul 2025 20:08:28 -0700
Message-ID: <20250713030831.3227607-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series saves task pid and comm in panthor_group and prints task pid and
comm on gpu errors.

v2: save the task info in panthor_group on panthor_group_create, rather than
    in panthor_file on panthor_open, because, when the two differ, we are more
    interested in the task that created the group.

Chia-I Wu (3):
  panthor: set owner field for driver fops
  panthor: save task pid and comm in panthor_group
  panthor: dump task pid and comm on gpu errors

 drivers/gpu/drm/panthor/panthor_drv.c   | 14 ++------
 drivers/gpu/drm/panthor/panthor_sched.c | 43 ++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 16 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog



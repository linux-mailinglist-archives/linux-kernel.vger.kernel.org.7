Return-Path: <linux-kernel+bounces-887270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A620EC37BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E43A18C51DD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493D534A782;
	Wed,  5 Nov 2025 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QWEMI3gR"
Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com [209.85.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5AC346FB3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374518; cv=none; b=NMq79WCBy9UbJX+4dw3SvYqGU/tsBaNcA8a9NWYaaH3LVLZKRKcpojJmmM1I0lFeLrKT5AT5320KgBTgCOB0np4SYAu5eGvF4foPwZFjjQm/ESq/pmVrJL+Ms6Q+5HRMDUakwLRgkkRkJoPGuiV575bA1hIrNgclQXqtiOlg4mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374518; c=relaxed/simple;
	bh=vbqZgxt+ddV/gMkFndwkKli1Qq2AmUr3CIWnYw0YR+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWYfckifAPkikDjaaj2uF+3IFqm44EYm7wQGLw+rPT+Y7mqxRWubD9TdyB/gHNvt/CFWg6Hmn/IL7uKP55E5VKYyK6PJd2u1mnIQuEWTPFZ0gL3tzTtz8XuSqUF4owomaTAqz3bnAXSwEfwfjhi/j1ZKXQBl2dDUuKr8hHHfRvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QWEMI3gR; arc=none smtp.client-ip=209.85.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lf1-f99.google.com with SMTP id 2adb3069b0e04-59441206c1dso19810e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762374513; x=1762979313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hqzNF//smCH/wXecy4K5ISa7DPzn6oehsCzEe3RVrHk=;
        b=QWEMI3gRgbjz3pQABDpyB2MDzMBgoGlLWKNBfy1i/kcmVeV3QiM+r1NSB/ks/RNQht
         kLKIxB1cTm5fWDQHbtzQRJs7+aXnNpMLxm/Ej4VAZr5JZH9U1Ismyv7tSdYShwekhn4X
         Nj6AjvLTst0jtWZ1ehEntdMblm8NdsINDZaQaZWAVU1J9U/7B4bskexLTTgbG3bKmKty
         GQQgws/zDDN14FkjhIM37LLeBl49zY2w6Dgj4OxlaKRizmO0OmhKheluO87FS7sBGX22
         7AX5w3AbefDqD+sfbq8EzTtstuljXTI4g1lLUbTv67A+H7uNU+xBzbxPj48AG/hbNhz7
         Klpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374514; x=1762979314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqzNF//smCH/wXecy4K5ISa7DPzn6oehsCzEe3RVrHk=;
        b=h8QhGIiwDaDYll01P9nYYhL23DbBT+QmI8RUrL2mwgUNuObLkPQYyXKGoqR+Wlgqfd
         phJPWJ196IEBWJPOkD7exiRKEox8DnGDeduqw07HtjKAKmRCqbomBHeP4O6PZztLisL2
         fR1B5/oWGW013MF0V7LQIP0bfYRXqxOAavATeJ7PluJkXjThpCj6cFKvVz2fsR+OajfZ
         coUCDzWInx56AZkcoXQcthFxzkuYOv5xf8ymYepLU/sbgOR56S2NYna3pYivdaxil2Hg
         2nGVdf7lpT8RRH2iOFdsL1JsFOY4VXfL2ykX7uKiM0wIWemSZlRhw6JXVXM6pDOcHoWO
         DryA==
X-Forwarded-Encrypted: i=1; AJvYcCUIGFPux49sZlW+Pqp50Avs0FiVSXvtWYcqJImkAzSg66RrJMVB77vN1W3d8LhvBeKBreT/s2uUncbx5EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI2UunXw40gLsrZghQ+PzUq20IVKI8M1uaXZSEvD+7WSHVxFNu
	VlesWzlXlZn+iSTTpmAjUNEYBCkXUG5eOcWHykEHZXK++cy0qAM/TbxkiUGkayX+YWUwu1b5YZ2
	GV2cjbiFZgWthzc8lxrEKPSb/IC4X95I3BAQ6
X-Gm-Gg: ASbGnctKlypCoqhGlUgKPKEq/JV8Paua6sa1RIdP1K/hQVd+OS3IFR/d+dLIbMZhJi9
	bxlBDi7dq997q6dTjUZtpNJGnZFIni74QKvYOZdnentE97yZzI99ZuhvG+cRMoW2aAJ8Engv1iY
	ZwUnWMWdeabJZvU0+UzSi8mle03kmnsXzJcLItuh4zF5AOYskWPe0/FyLKJ26/89jPYKuHNFje6
	/GVmXcKrRP9dOhNTJHwF2wvNu8+DiPoSUILvr6ld1xFkyxapfqhcPbxahDLU8O5ONrdaC9xOsSd
	IiPdY/zlw2UjtXFD+y6psr5+M6sJVYdgPhTz5PsA7zU18yyjIKDKAcuTqG1md2lHdRctjB8tpi4
	DC/kgP1tBVck+2cbQUQ7F/1cJaQP8mOQ=
X-Google-Smtp-Source: AGHT+IF1qzknNMPR4sXhFbfjCjDnaAvrB84RmIyS+GxY4Bwmj8KbhDyluGDBr1gzppGHTLZrqh0wn4FE9H8y
X-Received: by 2002:a05:6512:3b86:b0:594:2d0d:a3dc with SMTP id 2adb3069b0e04-5943d7c97c2mr786137e87.6.1762374513403;
        Wed, 05 Nov 2025 12:28:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5944a0b9327sm15740e87.41.2025.11.05.12.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:28:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E5147340355;
	Wed,  5 Nov 2025 13:28:29 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 036ADE413BB; Wed,  5 Nov 2025 13:28:30 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 0/2] ublk: simplify user copy
Date: Wed,  5 Nov 2025 13:28:21 -0700
Message-ID: <20251105202823.2198194-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use copy_page_{to,from}_user() and rq_for_each_bvec() to simplify the
implementation of ublk_copy_user_pages(). Avoiding the page pinning and
unpinning saves expensive atomic increments and decrements of the page
reference counts. And copying via user virtual addresses avoids needing
to split the copy at user page boundaries. Ming reports a 40% throughput
improvement when issuing I/O to the selftests null ublk server with
zero-copy disabled.

v2:
- Use rq_for_each_bvec() to further simplify the code (Ming)
- Add performance measurements from Ming

Caleb Sander Mateos (2):
  ublk: use copy_{to,from}_iter() for user copy
  ublk: use rq_for_each_bvec() for user copy

 drivers/block/ublk_drv.c | 113 ++++++++-------------------------------
 1 file changed, 23 insertions(+), 90 deletions(-)

-- 
2.45.2



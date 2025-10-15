Return-Path: <linux-kernel+bounces-855018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C697BDFF20
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CDAB1885862
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149EB2FF676;
	Wed, 15 Oct 2025 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYRGCqFq"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2232F9DA1
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550718; cv=none; b=cZznNOoQMk+Lgo5Bv1el96dIAKFA/00el/IGXf0MxHwod6IYorGcLn9ED116huzmOjjksy6CWYxXMwUN8IZJ75pmvYvp6rlb9zZupvlSiACiAKaXpvc13F4w8V5wckc6qC6Y/6lor1rIVUrUDYOeAaTcas3XwAJWqYZDw+ilZJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550718; c=relaxed/simple;
	bh=XuNNbHSVBHo7UOOe9q58PfuYObTswPx9OVtBaqcV8EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EnIFBCNpxoBcQZO00bsiCrzSG8p+R8N3w0mdgRoky40FiOA40tOS2BBNiEWBx/jNv8grxsD6IDiNoqiMmGOsABALJvmPbDVxE/6E5QDdPIvYL9QrbTZAKNRM1WfLwznJQEE6fT+rX096vmJ6gBdlAf2k/2nQk72m7Ce2AGd6a/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYRGCqFq; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-42d857dcf92so26235775ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760550716; x=1761155516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S3JawlpBmhunERPIxfqc0Q3lq1mL7cfgmk2EmeIPepk=;
        b=BYRGCqFqNIsZKj8q3liW7OPt1eITY4xV4HjF2hYNbhLjiqRu/Xx43fK6LPD2qtTZgo
         w/xSLief4Ximzx1r2LgMcMx7987AbiKtzkycLfzTAQxh2oTs06axh1BD208Vi8vlRfep
         v5/0zEAkSacc3jC8nf++AlgsAAF/JrxI12eHKADzJXKCKGDh29vPIXpgjHMO408BraH9
         1UguqYhZMEP/Elxr7UOD9I/fVwU5OFnrz7NhfeonRoq2+biQvtCr/783c49MJO+q10Lt
         A+lGUTIM6uY5AchEEHyRqZAyKkus+sE8Vt/Khf5ooa2BAIlpWxJFENzc0THjynoYTO3O
         iaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760550716; x=1761155516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3JawlpBmhunERPIxfqc0Q3lq1mL7cfgmk2EmeIPepk=;
        b=WOGWkrmUUInHdDMxjjZpgabb7x+bmc5H6xe52VuHIVhxGH/p3rnP/8sG6w05RctB6D
         VfK4Ia3mFJ273kigbxizosf2mxoyFD9tW7nMXzNlief1AzThedFofGASow9rz4vGgzX6
         lYw7282zlujcfyrTpgsJ6lwjlyWPa4pOZAZvzAO9oW62bI4IKWbssBk5pmRUR/p2ICTD
         9W00RLdZBCBMuCHnA6tRNWqJQjZW1lMAvlweDBgi1y1x3HUoNycqS9dBkM4q2q98uofo
         ijrvIyGD0RhRCpCvmYzIgSC/TJkMXlusCBxba4cnU4ScLAtMV9dGfdTtF2qzruOsIDxy
         MYQA==
X-Gm-Message-State: AOJu0YwfebSKXt0mocm/0YCjezsjp0MED/bEkpy6AZfTG2UHjEDZDx/K
	D2UbYvlp21N2TwXvJNJ6C8gRk1O1ykCvu5ZEH484ZsKlcBhiBPXr9yw2AbF3nw==
X-Gm-Gg: ASbGnctRKu5YUE6++kZPqFFuu0eTMsJXMBC89KR4ZOlGfoscMGY/xamtACRg3Rx4M8l
	G3PT3t8GTztZFRk7UU3GPDWptPJlreMVDvcGhcjnCg4FQMQln2jSsL5tq+woNClR7xxxNVLKJeG
	1enQzt2GIeBOZJrxQN2B/HqZ3fYR7hJ/hvbCf3nvf68NDh5WlVWcx7EHBNIJtKyHC/h582ZkFnu
	9+Hkigs+42wvNbMUEYMFncJP1+BIaKxMDgNPk2yUnEAVWLeReBiaxANfWTQJPLjeo3i/qcWUd90
	MaB/8DilY7eCfQIVRtBsfw7iikvmpzSCPVuwMa5VlBtguz3heCw0ZvWLl2mhfk1uGWyWm+UoutY
	5pfsFZtKAAtlJWVhB+RPLE2C6DlsgaxphjcttK3Jh8q+0QOUwjDgLi+snJeeOBnE/BOWNwEacfN
	gySWfK6R90ZUVbD8dSyR4JMdUPgcvZlrSx
X-Google-Smtp-Source: AGHT+IGO4E9j2qvKLV7/sHy1rJtm4aIAaqEhjr50KkZfxxANYemZ1HroPkvbA8lrJ1kA/JzXWdKPZQ==
X-Received: by 2002:a05:6e02:b4f:b0:430:b4e1:bc9f with SMTP id e9e14a558f8ab-430b4e1be17mr7114335ab.28.1760550715682;
        Wed, 15 Oct 2025 10:51:55 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-430b50b692csm1194115ab.5.2025.10.15.10.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 10:51:55 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 0/2] practical auto-QA de-noiser or -E_TOO_UGLY ?
Date: Wed, 15 Oct 2025 11:51:35 -0600
Message-ID: <20251015175137.2178263-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Can I haz (in compiler.h)

  #define __no_side_effects(...)    /* checkpatch hint only */

module_param_named() if submitted now, would draw several warnings
from checkpatch --strict, on name, value (but not type).

  CHECK: Macro argument reuse '_var' - possible side-effects?

This macro allows an author to suppress that complaint, clearly and
declaratively, and strongly suggests that they used --strict, saw the
complaint, and silenced it.  So they know not to pass i++.

Do the possible QA/CI benefits suffice for the mild "hackish" flavor ?


Jim Cromie (2):
  checkpatch: add __no_side_effects() hint/assertion macro
  checkpatch: cosmetic-style tweak

 include/linux/compiler.h | 12 +++++++++
 scripts/checkpatch.pl    | 54 ++++++++++++++++++++++++++++++++++------
 2 files changed, 59 insertions(+), 7 deletions(-)

-- 
2.51.0



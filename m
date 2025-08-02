Return-Path: <linux-kernel+bounces-754141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6344B18E91
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 14:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA30AA460E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 12:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233492367AC;
	Sat,  2 Aug 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnT+qXIh"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA221E5729;
	Sat,  2 Aug 2025 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754139507; cv=none; b=rf4+Vb+3Jmdoi9sxVJJvMBQGn08B/3ja4cCZnP8dqCo9qNzadhmxHh5rVAK2/NBEU6AzqY4/Fz8iyee53KOSOZtgzZbVpR7ggbKqX+UpX/2l8/bpu5fu3us9DNz7I/RsknvkWn4JKF21yMORcZ33MrYSDJ7Ef1oIRP8p4qmVPCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754139507; c=relaxed/simple;
	bh=dzixnqijSaSmKm6FoEQyku7dfX6/WAiEOVQqa89Tx08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iS3w5XAlCYFXlt/pB//2DFWX3OCkRJpHThr3rAc4iBdQ4lHczgNxtRFbFx63H+ZyDWemktRwD9uh76Pso4Ej1inpW//8+kBtCRA1o7qQ9jnvIpIdFXz60IESYb9ZHMbjr1/eyDjp1PI+2tTwYY99EBWtjrupVoC/lYlzZVgjpDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnT+qXIh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23fc5aedaf0so20031935ad.2;
        Sat, 02 Aug 2025 05:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754139505; x=1754744305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JeF05721YVJ5pBBmgxwBbsjT0X7NTUhpkjiEAnY+Z00=;
        b=TnT+qXIhHv3nwEAqusBiB2ycPVFU3dVOX06xDzb85lSS+47eGKfWFLcCow58BOKY2q
         gmUhu7fuz70vH9hk0v+idM6k4jn4bTWbFAqyj9J3BVeM9UzAEz0mQ4Um7BZQC4lFLiyf
         32eLWY5RduiWxcwnhFYbIBnBx5XsSgU/ZNBqJNgkRqYV3pAYb6NCkvUbK5z8wPYpYSWn
         LotSGH8oxqChVrckkKuKkgxvZsKPtT1wkN1hMF7cClMaFP3ernesNgbH7toBjZGTwdws
         8/FxLSMP/4ePAjMidknL8goSLlkTyPa8W9uJN651sWMFviDL8LJj1kRcb6E+S28mQpy6
         OeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754139505; x=1754744305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeF05721YVJ5pBBmgxwBbsjT0X7NTUhpkjiEAnY+Z00=;
        b=Pr2o/jUJMrv0da/fLPFWrbce5Zd8MVH+FR5YhE6DDipdLIMKsEach+cUYOI2plT+wQ
         R94++IgBebSwt1pNbhjaHjC0w6YgrWnOENnRUgFIxIEnAdmKCpOFyuNuppr17Mjl98u4
         5bzhU06MVHBHnkUotKSTiOKMqbWB8y8Tcoj49WDoKUqPQeS42gN7apc4YILIwQ6ya0Xk
         jZED0DCSTVDee8WjCw63iCFSDb6d4Ab1Exzu3ZjsGOaaTduSPH/rYeCEv6j12EznS7yo
         NsQAerRWhtYuuuyz2XU3nAwsLlp3XL6SFbJXH5BjvDdC9d8slFJ8KRmhbv7RNxhG+HOV
         fkrg==
X-Forwarded-Encrypted: i=1; AJvYcCVeWPLxsMx19mRl3ah+xs27ySF2qS/502cg35G8ApwS9R20Ix5So4v846iPQwm1ptc1Y/HN0MS9whEN5kq3@vger.kernel.org, AJvYcCXqlSkMEOxOmWGO7YgYaIsnXQNzUusgZj1JP/4ZSjnPkOMUB0M0B9JyJF8fURQncoO6ohUMD4I3g2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9owjmL+LYlwDOF1Wi2k0B7pLjXSuu/Vh8e5WuLhgX7As2u39+
	e9jnt3rUZr4PsjkY1HBpUBH0ompdy9E/9scjTXp4vQoJ/QbHkM0akP42
X-Gm-Gg: ASbGncvO58Md3divTNcApd1wU5hryBmtTEThST9VbP4wd/WAseHs0uD5+qD/z5VhobJ
	lQL66Cn7jf525tag6rO5qTBmLzY9M2k/R3ATeP35abSUwOF/HN9wYdZWLui02VbyOtBhf9ASuDU
	lHctuPChl3FE3OVR7hpWmnr+rKkNNQR3aOjDFE4EQA8DX15t0nQdsdvbT4o7azYJ14oCeu68USm
	FZ7JDLD0G+Ab9rwyr1SPXgmK3rq66f459iQt0Y3thrO09mLVTumys59tgYJsfUfC53hsVWSamuI
	4kVxDMEIIUyEyzprcMVXIS/yVstB8aMIE5kj4Ivn7oRU0XDCOmOiDwHpahLUWNZi1jM4c9kp54X
	g0BXkoOdvwQVsS4bgB9UpWXAQuCvr0ciSmoHWy37ke0CFH8cDFA==
X-Google-Smtp-Source: AGHT+IGui/tjwdKbWTwckNP2ApRA1WN/cOeq/iRXpzfKqpbgHt6m+WPc0tkdQsIm8M16mN6hmnfWcA==
X-Received: by 2002:a17:902:dac3:b0:240:6ae4:3695 with SMTP id d9443c01a7336-24246f461e1mr44675175ad.4.1754139505405;
        Sat, 02 Aug 2025 05:58:25 -0700 (PDT)
Received: from localhost.localdomain ([220.88.57.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89a077csm66788345ad.138.2025.08.02.05.58.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 02 Aug 2025 05:58:24 -0700 (PDT)
From: Kim Tae Hyun <kimth0312@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	corbet@lwn.net
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kim Tae Hyun <kimth0312@gmail.com>
Subject: [PATCH] [PATCH] docs: update physical memory documentation by adding N_GENERIC_INITIATOR to enum node_states
Date: Sat,  2 Aug 2025 21:58:01 +0900
Message-ID: <20250802125801.10068-1-kimth0312@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While reading physical_memory.rst, I noticed that N_GENERIC_INITIATOR has not been update
from the node_states list, even though it's already added in commit 894c26a1c274b8eafbb4b1dad67e70e51a106061.

Signed-off-by: Kim Tae Hyun <kimth0312@gmail.com>
---
 Documentation/mm/physical_memory.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
index 9af11b5bd145..b76183545e5b 100644
--- a/Documentation/mm/physical_memory.rst
+++ b/Documentation/mm/physical_memory.rst
@@ -171,6 +171,8 @@ nodes with particular properties as defined by ``enum node_states``:
   The node has memory(regular, high, movable)
 ``N_CPU``
   The node has one or more CPUs
+``N_GENERIC_INITIATOR``
+  The node has one or more Generic Initiators
 
 For each node that has a property described above, the bit corresponding to the
 node ID in the ``node_states[<property>]`` bitmask is set.
-- 
2.49.0



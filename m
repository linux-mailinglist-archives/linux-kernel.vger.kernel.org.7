Return-Path: <linux-kernel+bounces-865632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C9FBFDA49
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432263AB7EA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33942D6E5C;
	Wed, 22 Oct 2025 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdEkerf2"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC5B29992E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154836; cv=none; b=Cgxkw1XRCPUwYmF4yWEWxIAyfL7Za77a6SeKdhdUtPgSoHYgrCxLw4F4dGJbiG5cb88RQk5VLagCG30KnJ3J2KgJ5Gvf3jYskapkpzOu/VSVQSkWW5ZGb+LrSw7FwQA3PjCu+0eTxUHks12Ul71OZ0nQworyRUUvslbN4x941yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154836; c=relaxed/simple;
	bh=779SzYvXK28vdkR33MSPhX4IqP8sYEvvXfcslb9itrY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DnSoGBCMbaHtfbqRwDTWomNYdKUQBctregl6MfGYaij9ondWjW9ELsIx81rHzqfPQ/2W5279PMxcsDiShvTtJChxF2l1NmL/LQ6piimkawvNK9NoZ3HdbptYFVbBLx+3AF5myDL785N0lnB0t8Zm0VSgyn0Wde9AIxCBjDrGwAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdEkerf2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-427087ee59cso805076f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761154832; x=1761759632; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4DUGFOFOtPU8soJ+4xwLLyu/aVQ6yK4V7HuhUsJd56M=;
        b=gdEkerf2EvNU6hKdv3GxmrmhvEyCVbcWHU/ykNFp718n/ocLqzydWFHxTePMmlzUae
         BZIZWyvfkifS8KfbxoOwsPfsPxJ1Y1CH+W39QuuxJiHmldcU4HnAM5+kZgoahbNBk988
         EsvOrl0sfg9IYleHF7+4HG9vm1qSV+9rqqmVEGnj5S1Cil5SlOB3F3I1x9vx+vzFTlYO
         v8cv+MhzJD1oICrRSwdcUr7roOBdGjBNPTCw5aV4Vj86RVVkKfO5ofTJRp0bDRQlAS2j
         tjexqLzDYaSBQviVb/wYDajs9rjj0WA7A5vnD8vUOHMk4Md/pG2gEjR7OcMy0KBfh8n2
         0/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154832; x=1761759632;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DUGFOFOtPU8soJ+4xwLLyu/aVQ6yK4V7HuhUsJd56M=;
        b=pdOG9fyj3iM0VFpcolVkA3nV1ooL6gXc7alYLwkE9Fx/LDKJ0qSYObZn407DdaiJBv
         TwmPlsCIzz6HOzGQzcrnbEQtE9DgOcGXubNGwH3HzfGRZv3vNRJALX/SjVwm2unDgeFV
         DtY1NXQ18mBsumRN1i5TozRe8XF1G3X1ehYLTnioT4w7L0B5cDYMOB2DvfFOA//x13Iv
         j/NhQIvLaq0R7l2lDi21Ri533+dijaDpVxS3txADQhECDWa7Yqohpzfr7aZp+Xq9L32Y
         XBTdP+TwrZQlnpWWo3BbaCHjyjS6nCxdCxBkm7iIyNUx1zHZ1Ly35I9Pgv1k0qFkxs8T
         8I8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWd5uJOgBg6JQOUWfbFdKcfBqhtQoXYVaafQ1XMWR/J4G+N2GG33sxSdX1fTH0SW/pSt+lwylFHPWJ3ClE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPQg4zGHTVta02irelTL7UBsuZjPP3IoWaS9DW4bcUhP6Hrg19
	799fr1ZoGTqFm+oAsm/mNwsU/mQLpSYiAK2KQvFsNB+3ajEyIU4E9Uev
X-Gm-Gg: ASbGncvbBxJNay6jlUL9hzBJKf0U3Ai0aMT7S5+wfPrr6Go4h04HQIOKqWXLYBHQQOz
	zM5pcvnTYsjRbSPfb8oZRD8f5FCZweoUgr8fAX0McD6c+hJ6ITi3ROSMiQN9gv+kdDqk5aKjlmY
	m4vOzIAXG6jbfpf2brAU/gUjxjFozpkmFIJaa02a/QgYr06jsOtvnWg+auYOAjMwi0Vy863xcLq
	I2evzKB9Km+G1vGq8pzrbz8acaHb9hhxs63mbO1OOKSuAKv5iYB/vCszuYLUr6rUPCdClELiTc9
	idYmx8cutr1vFGHIgLzWeMFiY0qpNqg2iYOFBXPQfGX8xtuBeADM+46qob4f/ARp7omVfGcfMBF
	O0skPLX3L9KU6AHaofw7utiDpSK9TdQ5nxlCGfffnQsVOCJUgye3OfEGslBLt8iFDiUn+5bi1Yu
	fzriN5
X-Google-Smtp-Source: AGHT+IGzW07XG/Efi2c0GlXuDGswApxgmCqHvYEH4krYltVO3d6pXoWwWzU00HilDYEPXeGjJmQNdA==
X-Received: by 2002:a05:6000:40cd:b0:3f8:dcfb:131f with SMTP id ffacd0b85a97d-4284e576e4bmr2801025f8f.10.1761154832474;
        Wed, 22 Oct 2025 10:40:32 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4a::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm25503772f8f.19.2025.10.22.10.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:40:32 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH net v2 0/2] netconsole: Fix userdata race condition
Date: Wed, 22 Oct 2025 10:39:56 -0700
Message-Id: <20251022-netconsole-fix-race-v2-0-337241338079@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO0W+WgC/x2MUQqAIBAFryL7nWCWCV0l+jBbayE0NCKQ7t7S3
 xseMxUKZsICo6iQ8aZCKTLoRoDfXdxQ0soMWmnTKq1kxMunWNKBMtAjs/M8+sGEzi7GogM2z4z
 8/dUJWID5fT9R2v86agAAAA==
To: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthew Wood <thepacketgeek@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

This series fixes a race condition in netconsole's userdata handling
where concurrent message transmission could read partially updated
userdata fields, resulting in corrupted netconsole output.

The first patch adds a selftest that reproduces the race condition by
continuously sending messages while rapidly changing userdata values,
detecting any torn reads in the output.

The second patch fixes the issue by ensuring update_userdata() holds
the target_list_lock while updating both extradata_complete and
userdata_length, preventing readers from seeing inconsistent state.

This targets net tree as it fixes a bug introduced in commit df03f830d099
("net: netconsole: cache userdata formatted string in netconsole_target").

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Changes in v2:
- Added testcase to Makefile.
- Reordered fix and testcase to avoid failure in CI.
- testcase: delay cleanup until child process are killed, plus shellcheck fixes.
- Link to v1: https://lore.kernel.org/all/20251020-netconsole-fix-race-v1-0-b775be30ee8a@gmail.com/

---
Gustavo Luiz Duarte (2):
      netconsole: Fix race condition in between reader and writer of userdata
      selftests: netconsole: Add race condition test for userdata corruption

 drivers/net/netconsole.c                           |  5 ++
 tools/testing/selftests/drivers/net/Makefile       |  1 +
 .../selftests/drivers/net/netcons_race_userdata.sh | 87 ++++++++++++++++++++++
 3 files changed, 93 insertions(+)
---
base-commit: d63f0391d6c7b75e1a847e1a26349fa8cad0004d
change-id: 20251020-netconsole-fix-race-f465f37b57ea

Best regards,
-- 
Gustavo Duarte <gustavold@meta.com>



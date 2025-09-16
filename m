Return-Path: <linux-kernel+bounces-819681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA65B5BEFA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2DE3227DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3BE2BE7D6;
	Tue, 16 Sep 2025 22:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KgbTqTF6"
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B30D21E098
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060372; cv=none; b=OM7dJvkiy9yg9hcvVVM0yT23Qu9fqZ33x/6Q/HfqPVAOOct8iYRifWEal3y0/V6UCqq4WlcJENJ+XYE4BI0yJLxH1WvOhrQQ2ShwtXWhT/czQg7EN2vdU72nPqnj17SBNboI5nuKHrFv6ljdrE9hg27+Av5tC7RJ1+MG6/OQvI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060372; c=relaxed/simple;
	bh=O6AFxv2rcQekB70jDscAE0h46bRh5B6ciyiol8NPklo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U7hDNoYZDwkgcnHiAc2v34v5G1A3CFXiP9uvPPZw/GDffmWXL98W2wsnuTt7F695A76UnmqMNnb1H2X25AJqv0UtmXrWBqiAo2RrUKSclZaxYgnvXKK9p25iVCIGT4nJCl6x6hDfP6pjhGJ8Zb2aR7lOAhm/Ucntk3p2u7fK0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KgbTqTF6; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-24457f581aeso60348625ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758060370; x=1758665170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URU8cpb810BL84te6erVF0rZVZMOdMRIWlwwvewIU3Y=;
        b=KgbTqTF6tVUPkFmJfbH2XBJ9uf3YITRO1ppHLk0ksS4pdQKHfc2MWvtwnLFzFP3Vp+
         aL9N/n1q6prjlkEoSGYCijdRqYUcLCWJrJbbG7kLDxQVZEMNlLc9VZiA1nz12WOMf7WX
         GQS6pfj7EvQvHDk3qgXkfQ0Qf+55mG9+BoJsFDPKeplOoP24kuFvsE5Kc614hoaXOO6n
         BvF3f02WRWBxw8SeKf3ffhId+j5vGhLLcJ7FuPJphZfFjOQhkStwQCYDRDp7W7O7rcMn
         IDpNEFcT+eucLg8YQWw6euo5MydBMRW3llBBjxv2ud/S63UuH+yJLii5JMDotNQEfJv1
         oWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060370; x=1758665170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URU8cpb810BL84te6erVF0rZVZMOdMRIWlwwvewIU3Y=;
        b=rEE8cZJOUHSdAFuNDC1OZ+8rQ6SvMr1uuL9Uad1ze88/gDyV4JASlRubWrj/Iwo6aM
         PDD+wILIfwyGFGnREBW8k3XMEurNmweHdkoxjfm0LHl0edtoBC2U5pBZ8THu8LP+0AEy
         zwydA/6Sv/s3Vn2sg16aS2F8mYSgGLZECAUQs8BDiBdDRZSizrGzvwAq4lL9dnKMRGZK
         B32U4Wuo9pIabM/uzyUDu46xFgFAeJtj8AoQUFBbnS5A+pYFWkETy8TFdx/aRwWsEXHN
         uP/7+Wi9qrsgqIENcg0qTIqQDOHQHc+9pYvxclSjClcjAbN7HA0ZFnnpO9IzkhZLvm3X
         H3dA==
X-Forwarded-Encrypted: i=1; AJvYcCXBmtXtcLHmsZwfCUVGUTyNWYfQjcAlmfFeoFCYmF9ZEOWYZ8eAhXb0VPlcLSWG4CgJG3TPWIsoCazUt04=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBy5oO7zl53rKzU91P2yo+I0lq0o4EAwrrsTax9a8+mb7qFwaK
	bhNac9+5h8LUSZNZIQFSkP307Q+bsLa0zXAC7jmaHP/WTyVMIV4VdYzkaiwHI6C8sb4/V/4zL6E
	IMV34i+JOXtouFR9PTTHX4STICHedpYKoHgHl
X-Gm-Gg: ASbGncvEIu4aWNmWCGVwg2iA4cJxsHYTTj47Kx/an4ydheoeQQ9IXAiOxCm9EX9x2it
	AejJyktjdEUX+PpU4o4M0qcpD0Og1nB+Mw+O4xWyqA5aUWaIqQrdSTp/qtyz0+M9U2lb4Frxk0U
	vSfR1yO8C2eHyRcxb8o2PpnDCneDdqjv82DsxlGvJbgWaD0wPxZE9n4RVypC6mCgDehvKPf3K/c
	gN6ljJ+CkfNvZGxS7XzCDqw/qc0ft1Hv09yQORiamSG/jn3VGKZK+qmteHAXtpLfDxFZgVQNnCn
	BUmZNVwD6ApIZ+4lo3JmqWjWLIJmkULzruFarIfzScfgseTF1ITA6hk7uTfVD4XEXChd/TTOcQ=
	=
X-Google-Smtp-Source: AGHT+IGhjrS0yeLgkgtHFsVSqkeM5EALRxY7xkF7ANB453NveU5cvNrdW/AhOprgzqEc6fqLFtySHktbSA6v
X-Received: by 2002:a17:902:d48f:b0:266:702a:616b with SMTP id d9443c01a7336-266702a6ed5mr129310065ad.18.1758060369693;
        Tue, 16 Sep 2025 15:06:09 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-32ed2673d71sm63225a91.2.2025.09.16.15.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:06:09 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C5CEB340325;
	Tue, 16 Sep 2025 16:06:08 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id CBA08E41748; Tue, 16 Sep 2025 16:06:08 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 16 Sep 2025 16:05:56 -0600
Subject: [PATCH 2/3] selftests: ublk: kublk: add UBLK_F_BUF_REG_OFF_DAEMON
 to feat_map
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-ublk_features-v1-2-52014be9cde5@purestorage.com>
References: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
In-Reply-To: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

When UBLK_F_BUF_REG_OFF_DAEMON was added, we missed updating kublk's
feat_map, which results in the feature being reported as "unknown." Add
UBLK_F_BUF_REG_OFF_DAEMON to feat_map to fix this.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 4e5d82f2a14a01d9e56d31126eae2e26ec718b6c..b636d40b4889d88f7d64d0e71c6f09eca17e3989 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1379,6 +1379,7 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_AUTO_BUF_REG),
 		FEAT_NAME(UBLK_F_QUIESCE),
 		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
+		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;

-- 
2.34.1



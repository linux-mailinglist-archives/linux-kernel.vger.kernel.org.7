Return-Path: <linux-kernel+bounces-895769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C47B3C4ED9D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E75A1881F72
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A691E36A028;
	Tue, 11 Nov 2025 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HQJ4mWO5"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3274D3064AE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876196; cv=none; b=uSvz9X4qTD+9LvhOLNMR+P643Plz+lgm28aTMdJOlMsp5R06pHAMH53856tUK3zTrgVgSIwE2k4mvAkPiWW6dfDGQU+2jC7hHT4iCZtXyDuBjf27XGS8C1zAXvYlU5aGBAd2VwnIdXUabWlFcJZmqO+u4iLg40zb2D3KjcGMsFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876196; c=relaxed/simple;
	bh=CqEtGAdcdC9fF+g+1J10KIaSPEMvCZFYGfAXTUffalk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NMg4o2tfzNTAg+mR3nNPcFIjp/W+8ZjzJ8+AeZNVvUG/BoBXF5KNg7I0l9ivXFNzwObMBV4O3RQqiS7auvazjDLJ/0OYoM/Wz3nSI/WLId1AAP4KstRzLU+m1ybhNGbm0u9NDmakKCoMJo3r7Wl14oApnett+HoXTyj8hW6/Iko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HQJ4mWO5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so20893495e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762876192; x=1763480992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wBOHrHOppf1AdfPIS3ZyxdiMnLLRYeZxEryWRgXkM8w=;
        b=HQJ4mWO5KdT3b6efSL/NBYrQceKYWI/EPshSUVWwECZYRWgG8FzzN+f9kdyX2g+jgm
         rx9YQqw3hoWIo1qMK/24AX4Mdj+bczviBzsjX6Ab25e5ZpD5u6YLOu0JbP4P7kKpedTX
         cYMD+TOtDTPFbQtIKubJWKaCffKhwNXei+o43rWDPKAh0uXfN0IInzPHUnLmWplAKkxE
         ou8o9gW8NxmT4oACIesT6yC9tgnf2+4i8JZkS4iXjvydKGofPcL7ZIG6hFH6bkYwQZe0
         DubRgJVUXzw+H1P99vDR0Cg0nO8ToN7YgE1nKGnCQ68Lnv8hkpvrolq5BHoRhmmGGzb4
         qI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762876192; x=1763480992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBOHrHOppf1AdfPIS3ZyxdiMnLLRYeZxEryWRgXkM8w=;
        b=J107uU3NR6v6z7ZTiO82K96BeZovv/tUU/0FUerE4abnfwVLyze7AjPpO9OiLzykth
         LVhmXNOR0dJBZxvDgSlb2oTjrwahzP8oCrOoWvOow3rxGwTxxEcToWu8askHjNDOqGP3
         a/TnzpW8z/8tqdImdfbv8SUBzUqggBexMGLblackn+54BQn5OrAjxCfGSWv2Lv+dCknp
         V1XHirzTwJnv2lMM9LmMGC2j6gpelU/+j4oqayzBXEVjaqJCK55uvAi5jrjsZ77xt80i
         gPdRNXq9fI+rcbBsCPMRQao31+MxDVV9xn2G+Us6gUvy2zuzt6SALt7CnaZvyNXcFrJg
         1Lug==
X-Forwarded-Encrypted: i=1; AJvYcCXgGr5HzbPiDlKhXvae62+xS7O+9mmzItsQIYai/vw4o8AMvbl2NwnFrz3Am4enpKvkmtNYpHes/eqQ+PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRrIlKEIV+u8HJr5z2MqO04EFopzO80tEQ2ch8T9VHjGaZqEBl
	/NJIphj52i/jauGoidKt3z2gumVPeUST2yBUXeOaGD/cSTQZCk7z35hCuSlQ7meYVx8=
X-Gm-Gg: ASbGncuOwvqkxdksy/WRr+kZIKfo4RaI6HZWHUJ6fM8DZuZL/7R4QS+fUF82pQ8g06x
	F2yabh9xuUuvQCLQWQhm2NUFva7t8kQbXLUL3fNlGIkYgLKWraQiVRJBX6wUy8rL+ZKVbPizJVH
	dDn3i+fx2HMIylFjYwV5sKJq1sgyAS8My5VZrR0tC/t+7vkqlkE4IW8AuWsTRj087M943ev9OOB
	Kt6V4JHjj3qDU7tIkebu0WQrSJmoETi8WBcAAXvIgDmNdzFkaBP9b0lKyTe+NfxjxsUU33k5E6F
	OUOVfB/pcZk3L5DgGotgS7IYOj2lNN5CcO42zpsu/7puXwX8CM4X6MXU1iPi/0n1Up1zAGmFMIX
	sqWr9bR7TzprpabO9+7+beiip3hzFm0LynRX6mjG993IaTrMDwPQZMCVIcq+flU7UirgHSrc7gy
	zI1guHqVYrk1A0DZcqm4pqoVhtFlGctEL5ZRweyuI=
X-Google-Smtp-Source: AGHT+IF3w/+X8esWpOXfnuyljikULLGSD9qW7Bkx3W/HLFcTqZLnglxnZWVL5Dg8R8MNDHTN0J812A==
X-Received: by 2002:a05:600c:3493:b0:475:f16b:bcbf with SMTP id 5b1f17b1804b1-47773237269mr93820995e9.14.1762876192518;
        Tue, 11 Nov 2025 07:49:52 -0800 (PST)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62b23csm28269916f8f.10.2025.11.11.07.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:49:52 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: keyrings@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] module: Remove SHA-1 support for module signing
Date: Tue, 11 Nov 2025 16:48:30 +0100
Message-ID: <20251111154923.978181-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SHA-1 is considered deprecated and insecure due to vulnerabilities that can
lead to hash collisions. Most distributions have already been using SHA-2
for module signing because of this. The default was also changed last year
from SHA-1 to SHA-512 in f3b93547b91a ("module: sign with sha512 instead of
sha1 by default"). This was not reported to cause any issues. Therefore, it
now seems to be a good time to remove SHA-1 support for module signing.

Looking at the configs of several distributions [1], it seems only Android
still uses SHA-1 for module signing.

@Sami, it this correct and is there a specific reason for using SHA-1?

Note: The second patch has a minor conflict with the sign-file update in the
series "lib/crypto: Add ML-DSA signing" [2].

[1] https://oracle.github.io/kconfigs/?config=UTS_RELEASE&config=MODULE_SIG_SHA1&version=be8f5f6abf0b0979be20ee8d9afa2a49a13500b8
[2] https://lore.kernel.org/linux-crypto/61637.1762509938@warthog.procyon.org.uk/

Petr Pavlu (2):
  module: Remove SHA-1 support for module signing
  sign-file: Remove support for signing with PKCS#7

 kernel/module/Kconfig |  5 ----
 scripts/sign-file.c   | 66 ++-----------------------------------------
 2 files changed, 3 insertions(+), 68 deletions(-)


base-commit: 4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8
-- 
2.51.1



Return-Path: <linux-kernel+bounces-883322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AFDC2D104
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A196188AB61
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A5B315D58;
	Mon,  3 Nov 2025 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW2D3EZL"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B8D314D01
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186780; cv=none; b=CSDY2QPl270TC7sNtcZ/0XXQPj1pGaxOeIXZZa0pNVitHjdKNpY3gmgO8UobOL/GkTezo/GYe3XdjcpuSHG0w4dRAsJm7Y2kFlAJW6H/lwHz9IHXqWRcxU1nK/2i2oKKJVt4+TYXHbcGYe6oMADjQ73TI+YzMIyzlgOKMRn08II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186780; c=relaxed/simple;
	bh=SA8YBwX6UV/exj69CxLhHvYltiFC6wLWEhuIydTpxus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XpjnAPm2mB1bnU5qgt1LgHnmGqCcf7FRRFcCRLldxPJvZJ113UYyVxF+xwHTVscZ1cyN0fJ5YntcfCiTo0rRWH8snhX0jTf40N4SLrCXxi0CXkfhhluVYC0XusYe29fX1AzQp/Hf2m8DIenQb5wEvcH3NcE9DuY849RS6UCjRzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DW2D3EZL; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88058103dcfso7176276d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762186777; x=1762791577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ncd8iftKarOftKagzkM1Xq0zcBakpgViOG8SqvFntD8=;
        b=DW2D3EZLMhCYEg7/WUS5CDUC8gjTNM77YeaSHNPHUGPmxLJ98Q0DFehyVSoO3JivoN
         k0FlfzsySn9uA6UBAmIz7qyz36z1xm94/1AswpDGs42TuGUegAQ9BEI1imKM94qQ4L6x
         zvsuXPMS3ICQR5zuYTxwWcfgoA0RT8JjkedoGFY7RH3tjVgmmlWPisRWKr1ofVHbI77g
         qYdTQSlcAd4ZGqJU/LnP1rVbSe2Bgv6TUxUAeLqIWmFhF5RBiLqgOUw4uazwICjAWERq
         17n/rS2C628cz1fr1vBKUat4a/Z91YugnM1twYt/rCfeX3Shm8Ee0VwSw/E0CP0nq17M
         +QrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186777; x=1762791577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ncd8iftKarOftKagzkM1Xq0zcBakpgViOG8SqvFntD8=;
        b=WMnZB62dHha6FCq6LOLJd6KMi4DMpN2a746B6G2sjnA49gJDniEXhMNBGeGNjj3MvI
         PFfUuOLtjOh3TiUGiDzMkda7tflOMNNusWs2+w9EB+WbTNs6AgJFOmy2c7gfdMBYi1uG
         dRJ8/pCYFQwQesAsVBM6XEjNZSOLMb+WQmwhH+bdD+gX6f9DRaHBPFWEk/4ry3uJU4Hl
         oygqe6X8wcdYlweF9gfoJPp7E1xTn8SsQYz/X5T8CrHl8CXYEzMsGRxLVPt2Mv55lmNG
         MsigvUtQDC0OuDixWF4/x/mHv39P/Wb8YHSkF/UvUez0660ByM7iAhLRnf0l7zmc5sHV
         Akew==
X-Forwarded-Encrypted: i=1; AJvYcCV8plBkqbjJkeyEpQE1pho3AJ7A0teJXcRGx0o/gN4oAFbaEjY54kGJlQUN0bMPe9VqVLlgzoynWMBlUdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygCxibo0fWj4IG4/gBnyxp7yRyGKeb8VBWxtduQaf9zvRttDCs
	rcXftTbWmqQsiF7hFsX+e0tH4RurUzsfiZWJPhyyg0g0hhoTLVojQstH
X-Gm-Gg: ASbGncvlSD/Kz8ald0xOcvfu3QyYT/NfQVcAn/AmzRTpUKfoFUxkUIYeQnLmRrnkSUg
	gMSWGObtm8QbEpnA+JxfFayO3tx2bl77wb8KHFHgXOrKVLYECfXu4mUaxFh5bRkZ4ESj9KRIyK4
	///oUCUcOJCQD5NxtqJG53j2h76fyvlfSm1R0lqncge95Beu4HTy9qkP89VKBPhBTgpRPNe7muy
	9y3op9H0iiFjTnKfyHpbUTVJMH19nzTYGBiPtHvcz1XVu5bmLXa+rpg7UmuLv5atrlqZuMZIjpk
	fIdmFbyBbwMzPLl2jPkflBLULpwF0diSVUCIJkPfUR7UfUe0YFJE+bBaF16O7F4dJKjOC92nCvU
	wXf/kE5E2Ntz4vNILmQfi9kFgmz3gBDS+r0krzvxxIxMTb20nhbr4h3BX1nuKBZMKeeH8B+kc6x
	ac54OFxXq2Wz3/KL8=
X-Google-Smtp-Source: AGHT+IEAQfamPC/d0ofEW4bGHVEQ9HHMtZbp4Q8HmqPZCWRtg8LnyQJ/AkABfg86VcVL9UWlrv5V2w==
X-Received: by 2002:a05:6214:f01:b0:785:aa57:b5bb with SMTP id 6a1803df08f44-8802f44b4b4mr155355746d6.43.1762186777421;
        Mon, 03 Nov 2025 08:19:37 -0800 (PST)
Received: from ideapad.tufts.edu ([130.64.64.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060eb3332sm4273556d6.60.2025.11.03.08.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:19:37 -0800 (PST)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH v5 0/2] rtla: fix cgroup and trace options parsing
Date: Mon,  3 Nov 2025 11:19:04 -0500
Message-ID: <cover.1762186418.git.ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes 2 issue in rtla timerlat and osnoise parsing.

1. Make -C/--cgroup option more user-friendly. Currently rtla timerlat
   and osnoise parses does not allow to specify tracer's threads cgroup
   name as `-C [cgroup]` or `--cgroup [cgroup]`. Second patch fixes this
   by allowing users to specify cgroup in the aforementioned manner.

2. When specifying `-t/--trace` before `-a/--auto`, trace filename is
   override to default <osnoise|timerlat>_trace.txt. For example, when
   running rtla as

       `rtla timerlat top -t custom_file.txt -a 100`

   when the threshold is reached, timerlat_trace.txt file is created
   instead of specified custom_file.txt. Third patch addresses this
   issue.
   
changes v4 -> v5:
   - Removed setting trace_output before checking if it's NULL in
     `fix -a overriding -t argument` patch

changes v3 -> v4:
   - Removed patch [1] as it has been mainlined
   - Resolved merge conflicts with [2]

changes v2 -> v3:
   - Combined common logic into a utility function to parse optional
     argument value
   - Removed change that removed `clear_terminal` 

changes v1 -> v2:
   - Moved removing clear_terminal from `fix -C/--cgroup interface`
     patch to `fix -a overriding -t argument` patch
   - Added clarification why to remove clear_terminal
   - Added `Fixes:` tag to the `fix -C/--cgroup interface` patch

v4: https://lore.kernel.org/all/cover.1760791697.git.ipravdin.official@gmail.com/
v3: https://lore.kernel.org/all/cover.1757034919.git.ipravdin.official@gmail.com/
v2: https://lore.kernel.org/all/cover.1755018581.git.ipravdin.official@gmail.com/
v1: https://lore.kernel.org/all/cover.1755014784.git.ipravdin.official@gmail.com/

[1] https://lore.kernel.org/all/164ffc2ec8edacaf1295789dad82a07817b6263d.1757034919.git.ipravdin.official@gmail.com/
[2] https://patchwork.kernel.org/project/linux-trace-kernel/list/?series=999703

Ivan Pravdin (2):
  rtla: fix -C/--cgroup interface
  rtla: fix -a overriding -t argument

 Documentation/tools/rtla/common_options.rst |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c       | 29 +++++++--------------
 tools/tracing/rtla/src/osnoise_top.c        | 29 +++++++--------------
 tools/tracing/rtla/src/timerlat_hist.c      | 29 +++++++--------------
 tools/tracing/rtla/src/timerlat_top.c       | 29 +++++++--------------
 tools/tracing/rtla/src/utils.c              | 26 ++++++++++++++++++
 tools/tracing/rtla/src/utils.h              |  1 +
 7 files changed, 64 insertions(+), 81 deletions(-)

-- 
2.48.1



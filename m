Return-Path: <linux-kernel+bounces-862661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C52ABF5DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13E584F6F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB1E2ED848;
	Tue, 21 Oct 2025 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV0b1/D9"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A278123D7FB
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043654; cv=none; b=blmxdD3TAFhzfmL17ZqXcYIbndwk43uUDtRZaw2Q8JQ8qSm42z/TMh4TbvOvwFxXK5yc+y4DS8o0uMLRchQqpK6BKKUb7/zHzdonYtKagSu5aXbxOiORJcs3phkQXkAyHYcU59tBYuL0baTSU7hRXtvY2qzZKjVKkyHbI9Rmfvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043654; c=relaxed/simple;
	bh=u3x+mZ9WYaMzDykMD4wrOaaWSHSxUpyWrVYfEbgeV3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eRDOgwnskmBdrod7Ak1tssns46VCGyL8j3X2xc+ewFf/vA98fr7RDtwGlK2+Q/qwfvyO2F4gzhcwb2miOpGioboWjyUVxDXg1AIvbXKiS+vLdC1oAHM8zouAexjVz/y3XEDGRqKTBOl8hBuBuRFiqRBQMrU3enQhBRvMuD/huio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LV0b1/D9; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3e8f400f79so92836966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761043651; x=1761648451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hYQSYXxT3vBEQ3060Gmkoau5FySMDvalsTXJ7MNV5UM=;
        b=LV0b1/D95OJkJLKTxOL0hM48Qp9nyNgkGGl0y2QALvRjfJOVW65LHLubfJjLT7XdKV
         yt7yWfZfGL30LuOe/jTElJFWM55nwk5w/Z1FP4li/UyJu4nB7tD+ZYByotrXkDcoJQuT
         AMf9OkW1rWNJ5Ot2/F8hMOHKzhkwc2NjyWIUeakRq7U0cclGwUv99S9QS5CsyuOnmfN9
         rh+GvZHS0597r8iYDzBP6lZCYM/KcHPdBacK14QoIJ/MAKsQBn3NekmwuuGADvdyEYPL
         T++csfR2qqXSh50+Vyy671WVM+byd8Z7ZZ8x/e+g8lsMl0eSAPNMlnXMGMlyYJggZAvw
         j2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043651; x=1761648451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYQSYXxT3vBEQ3060Gmkoau5FySMDvalsTXJ7MNV5UM=;
        b=MlvCS4vl2aKzy8TdopatIcL9WQ8K93vnc+H2RlP31O1oyFFuqBBR28NAlZNsRhzHko
         KI+CxwWPG/BDiaAzclXBORKmSN2e5RGaDR2TbYldVXScPrMKNwAJfkJHOda3vYpfi2Ic
         me8G/M1Y1zpvFxXKm29fxMPRyfYyTYd2pAxSkfezeXFHaIClHva3W0BYX6qIQ4xXPmWh
         aOjWV6Q2kVqqWpSS00+OWWxkYpD8WrLYGj/SLaxiwIEprqW3iw0lN7Gg+TJ16OyiwTh9
         PHopUnE4d4UwAEGiRBjlQvLWATgqE/egcwkwZJ1cFSYsS5lmXTzFPPCU9F5i528nEGkQ
         WKLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbqMm1d5+RRUj1cZrqZw9VArM+42kA1pJVtGWdOt0B+0F0WGB8Kq9L/aRNQuc3mdJ412u//OxCcazLpL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoy8nZjIXCxeZXFvD54jhax3qINAmmxSb6+FFR6IYevJJ2xrpM
	vBTRgiAq40RWo7hGu/b02jsJm48Jtct7/McaUiNQkrh9zqI1nzCpAKF1
X-Gm-Gg: ASbGnctqxOpj8Kd29BsV2HbA87uJEwgpvwDSpl+KUcmh/OAdog77b16sDpiXVHGyMc1
	YPa5csKAtf33cRgoI09v37D76Wpnb0x8ZfCZY1xGN7BlXh83iNb4T6aSTD3LJ4k4nHsLJVfsiUV
	858p3u2Rr96QtbzQbNfBI4Nz7UvepjCknJxviEQe68AJvn0V2iFkwQUyjPI5w4u2jtTPybVwOoK
	wRm9tVplOjIcoTB7QbMqJq+heSLr1U7nvFAjChGTdskOZIJ653p6O+rp+jWkBiYugn6kCQcrlsz
	D8mpBA8qKJ8Wk/Ws0v+OPZ4gMYNyIDCdrdAYcaw+R+XSBZ9rmfNSZ0HI2gElwynNQ0WMuybNEK2
	DiuLj9GVrE3YOGyrlq87O0cddgoR5RkcOBskrJcRbVMOi0BO6wI9MQy/RqTGEDF9DnSwL/2RpRV
	yDwFQ+/OFK1zV/
X-Google-Smtp-Source: AGHT+IEVgz7zYtsnpcehMAmhlB3OUMARV4++YtUV332nKXGeBC2HoEB9fppwF5GU/sp0jIUet5ebFg==
X-Received: by 2002:a17:906:4fd5:b0:afe:a7e3:522e with SMTP id a640c23a62f3a-b6c798e7a68mr191581266b.8.1761043650805;
        Tue, 21 Oct 2025 03:47:30 -0700 (PDT)
Received: from bhk ([165.50.73.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da2c5dsm1029123566b.15.2025.10.21.03.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:47:30 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH bpf-next v3] bpf/cpumap.c: Remove unnecessary TODO comment
Date: Tue, 21 Oct 2025 12:41:24 +0100
Message-ID: <20251021114714.1757372-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After discussion with bpf maintainers[1], queue_index could
be propagated to the remote XDP program by the xdp_md struct[2]
which makes this todo a misguide for future effort.

[1]:https://lore.kernel.org/all/87y0q23j2w.fsf@cloudflare.com/
[2]:https://docs.ebpf.io/linux/helper-function/bpf_xdp_adjust_meta/

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
Changelog:

Changes from v2:

-Corrected the new comment

Link:https://lore.kernel.org/all/20251020170254.14622-1-mehdi.benhadjkhelifa@gmail.com/

Changes from v1:

-Added a comment to clarify that RX queue_index is lost after the frame
redirection.

Link:https://lore.kernel.org/bpf/d9819687-5b0d-4bfa-9aec-aef71b847383@gmail.com/T/#mcb6a0315f174d02db3c9bc4fa556cc939c87a706

 kernel/bpf/cpumap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 703e5df1f4ef..ee37186fea35 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -195,8 +195,10 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
-
+		/* RX queue_index is not preserved after redirection.
+		 * If needed, the sender can embed it in XDP metadata
+		 * (via bpf_xdp_adjust_meta) for the remote program.
+		 */
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
 		act = bpf_prog_run_xdp(rcpu->prog, &xdp);
-- 
2.51.1.dirty



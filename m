Return-Path: <linux-kernel+bounces-861287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC11BF249F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 356E24F6B27
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3483B285061;
	Mon, 20 Oct 2025 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSZQ+0Nb"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA612773D2
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976189; cv=none; b=Fn/aUdbA7IoRlnPhkieQ0qPwotp7wxm9RR6uAaXuxyfH3edtM31QNVtc2IqcqEsO9xe6gFUWjC+0c5lX3WX1YlrEF/hhBnLK6QD6xRx8VubK0CpeTpDiMnApTJx8BCSEL0biAsMZEvLcm9NSZ8r2FFM2aL9nglI/Wuq7LPsZlpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976189; c=relaxed/simple;
	bh=5p8QM8GiyJ3VdJu3v6HqAWTAumRdDRF9TVX5rxrWIhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u8b+13XA0ODeghBpm0xgKBEdZW9CphPAcW+rIX2lcVt3eVriuMBkfjN3F+WsDcRiWU8xvNjnQZT/ECa972tHqyPgzxoU6umTdIeSHZLIoa1NFV5qyz2EfT6fJVH/lXqC/2dJ0coKmX3azntfn/ZBKADzTsaaygA9UaZabrem7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSZQ+0Nb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63c0e774250so564558a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760976185; x=1761580985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sEqKuO9xbs7T7mcjnW0UyAFwwa+u/P82jsf/ebmJ8is=;
        b=RSZQ+0NbRoXdDDj5kghqrTLTE0n738dfH+i25XWUoFMviFBQE8FYET+NCWrlrHgTZ9
         z+C9NXTwtFkWzaEgZNktFuQIET0GrMTW1QODwazG0CVJIiJJ69OvZgb3dmTQIBFumsoq
         ulV09kURZwM9jQdmSq/d59a+PRbLeN9/4G7AByj2NGXWQfdfqSEZsLmIcLtXod+KmQq6
         /RhNJahfWxwTcs8nDlfmrMJIo2x2AU2dloBkxUzXNlm6DJ28LoDLFHyoX7NMxXuLCg2S
         UQ+oPPhKmp+QETX1KP7ra7FRd/SzBLAgTegLDc+kTLrz0fUopet2+Jk5vURfL35UFVBn
         xiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976185; x=1761580985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEqKuO9xbs7T7mcjnW0UyAFwwa+u/P82jsf/ebmJ8is=;
        b=vfD5heTUJ0Nha967EPKBcw5ezwYwXBKgO+4VYifu9F/WLS4rm51LCKZcvgfjX4FoG0
         1fYP6UDBrJ/kZ4ewBfbbY9pNaAWbE01A5IgfaZI/q1ZTe8mPCKoWsIvfAW7M+9QrdTPT
         05EEbk6pBVuKRFbxEpu8QY/FJRtYkpw6Q8ifYiac8HbMe0Vy7RrMmgcqMBdVeX98w9fp
         I2iFuW0ExNxaUhFFAi7ir7DyUMK7pyuYoqmbOUQC+ylpL5lcrchgyVgO5yDLTc4+pjVo
         Hk2hym3zg0ZoJQ2/CLsAC+ZILWKPUhW8skaKC2Drzct0cxcKnvFiY/nfem57HaV/HdwG
         KanA==
X-Forwarded-Encrypted: i=1; AJvYcCW6EVJNua9t/UYi/XYNP2kkq5wigNcR+Dvzy/H8GeAVrHgVXAIG1mXSbqGM6Yo0MpImFwL+ZjSY0No1uqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLsjL3uQsNbg67vBCZsjLtvJIewGkInDrFLODiEQmBhb/nHB1Q
	i2dU4s74kf1gR6AWGhSV5FbL7WQB/9YQxWyhG4ncaSw1gX7RwzEDyTjt
X-Gm-Gg: ASbGnctBDWR7KR/tahaYmL52NkO6IJgSjA7txC3P3AC0pp7zmH++SNkv5F2AS9iLUiy
	dCLOmCgiPbYgFirvOKKrH2WVaJyOM5QzA8aPdKYaXU/qmDs31w24aUWapLSUxteD8hEULpE4q4q
	UOZSAmDeH5ETyNIUHBqVf0jZMjTzEjiDBUCJIDM76Q2eS3wyp5cLwoSCasH6uH2EaIPkbhMj1T/
	Tq4zAscrG3VeNjXDXv2Kvrll0eaILg4KHT8abbiSy0d3Z7/JFdhpz/+pg0UkzcVwxdKG98PSiow
	lThkJXJpNYElsqBDDlowQhFRcU9abcnkHq3Zt/6DK3A7/i0vOGbyaV9zmwu9TIJb+t0UDF7w/Rs
	i0mRgmB/Il0V/gZTU3I/oLlfVV4zrELN6ZMcJx+vrfs/Z7OebIEuGkyP8GVB1eorP3JHqjoFR//
	zS5cJy57bzb0XMBA==
X-Google-Smtp-Source: AGHT+IEAZ4aDtO0vMHq0WUMhe05mN+O1T+el3SwZMkFfF983mLEGTQdhOfy2UfAjoiXHE/Y4G+rEjQ==
X-Received: by 2002:a05:6402:274d:b0:63c:343:2493 with SMTP id 4fb4d7f45d1cf-63d1649c390mr29994a12.0.1760976185195;
        Mon, 20 Oct 2025 09:03:05 -0700 (PDT)
Received: from bhk ([165.50.86.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4945f1ffsm7186665a12.31.2025.10.20.09.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:03:04 -0700 (PDT)
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
Subject: [PATCH bpf-next v2] bpf/cpumap.c: Remove unnecessary TODO comment
Date: Mon, 20 Oct 2025 18:02:37 +0100
Message-ID: <20251020170254.14622-1-mehdi.benhadjkhelifa@gmail.com>
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

Changes from v1:

-Added a comment to clarify that RX queue_index is lost after the frame
redirection.

Link:https://lore.kernel.org/bpf/d9819687-5b0d-4bfa-9aec-aef71b847383@gmail.com/T/#mcb6a0315f174d02db3c9bc4fa556cc939c87a706
 kernel/bpf/cpumap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 703e5df1f4ef..6856a4a67840 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -195,7 +195,10 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
+		/* The NIC RX queue_index is lost after the frame redirection
+		 * but in case of need, it can be passed as a custom XDP
+		 * metadata via xdp_md struct to the remote XDP program
+		 */
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
-- 
2.51.1.dirty



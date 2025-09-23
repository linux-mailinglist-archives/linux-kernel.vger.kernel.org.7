Return-Path: <linux-kernel+bounces-829603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A43B976DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFBE3B6745
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B4A309EF7;
	Tue, 23 Sep 2025 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcNpm8dZ"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510B31ACEDF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657642; cv=none; b=PWu9Sc8LgIRPvFVRUgzKHdxziFlRG1c0Ovgp8s9GAAHyuywbVHNFDLSEw9JNlx4S0ydzzK/t266pDUMbyulQbMfs/C4eu0vUAmLQ+KIbFfM9NuhxltN4wyF4TLWV8RGFqVTVnk+mGFaVAGKYWCDD4gA8Uc1lfqUYnyTNvX8w2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657642; c=relaxed/simple;
	bh=DUqNL0BxXw9yb60YTESlG8jt6nJyQ3pOZOLBywKCkqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=olv9U0UEM4hrimDzkyLbTygR1JuVPtChKzmBuqOxebRkCtCeyotTUsfwKnLlqYf90Skc0X2c8Jfxfiu+mQblwWJ5bKEdRkWwF8GPu2bM+44ePIJrdIKiA8U5hB+DtNVe2CLx2hBBXme5OHdgwcr9mFmuX3mgUolHySKsXYKGqlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcNpm8dZ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6317348fa4fso404304a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758657639; x=1759262439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MMlXrZQAEQaYYcackbMrUxU4ktpxJHOJCKry2TD8zSM=;
        b=lcNpm8dZWF5OfS0HG6HWS+OcptiMhZrL5K7rWXoxiO0aYfHbsyU/vb4j/BZKPfbGDB
         nf+iZ+DO8U9onqu2AJ3rvCsoSBDcPlM3+HW9dv5hy8TknhnbSVWSheHg6jE41UDG6bOC
         sY06ZNBeBKk2KTzH2SMfYAOahulTaDuUeYyNDviGKQBPh4AuzsHncPwaFaW/bq+1Lyz0
         i9BTGA1m65P/qxGjyAwLOKNac3Bm5vv0Z4E2GXTMSSiEF463dSLINFpOY641UUcP9XUH
         Gb9FXnd5IkJbLzTzuzxYkFOtw6DcsKVAQay1fPoKtGIK6ARKIAwoqHLa8HymNyBlp++2
         WbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758657639; x=1759262439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMlXrZQAEQaYYcackbMrUxU4ktpxJHOJCKry2TD8zSM=;
        b=YGSN6IW2Ih4UUGGfuJCtJU+zyytMutnkF0gyPpnVx9eueqxF8GFqfHj1LYxAB5CqcA
         vDHLPF6XEbYnkHjxkqO+3g1eBo1LRYr4Wwky9hNaJ8yHpK+udZJRty5o+nuHKfq60lwi
         JrbsP9erzmumwvkz7VQVX76vkH7Ru883PYBbNz2xARR+hQvQJ5E4Mk1D6ZdG132i0y+B
         1jKfJ79wsJBLYIamQ8R3IbapOlA0DwpBFzUkgxphHoSsXUU0te74KzVuqF5pO5PWNlPo
         kxIRh3OjP6GAD6wm3LOM2sCBYpz91x4w/L8kOi32fzVU+1hhvcBOjrjj22VxziYjRSTD
         wGfw==
X-Forwarded-Encrypted: i=1; AJvYcCUbRSJhWmr427QNROJmHpq+syqzfBy5s5Daljk0mVYKo4FPZLqTI46Z0LN/a7xyijphVhNaeuuqvkvoGaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO0PsCniICZA6HCWvS3EgkKNQggqNVt9zoQMl8259iiMsgRmEX
	CYoNaJ+xWgJ5axNZyQS9AfiymlhS9omN3MdjA1qvN0iBKfqzMUGTegfr
X-Gm-Gg: ASbGncvB1s5N97JIOT7iJg5MWkOg19zKwQTow21LP95767KY6xcxgEbzMIbwupEDUpz
	riI5WcvxmXwi1TgTM1q2Lhrl6L1ZiIoupLqr66hS5398Iv+E5pXC1GMyLGB1ZoMYojTlSVofPxJ
	EAqqvgP8JcVvQM40HR7uW1ueUdeQGixbfiJoaQ77biAgxOJBqB5B3f+qOjXqrXOI/BQA8hs8wia
	twWDGVktJLPD/PeuBughOHOTjYOwaEH8Em2ac+l2ktzSaXpvQC5Y1iO/6z3fvap4ZWigMLbzy3j
	oAWRQKHOhh9YN562eaRx8fC1GiOTjD8KaC98Itx6USNeHSSlAR1HpBVurJdxrPMliVX2DMC1fJq
	KOMF/FDUD8kbB/kNFD+rMFn/l
X-Google-Smtp-Source: AGHT+IHN5XcNp/1KJalZXV/5R5ZCq+blsOxXx3/x4YcOoDnXFZxHCB5DKHENkTDjUloqq8JYpW2v8w==
X-Received: by 2002:a17:907:7b8c:b0:afe:ae6c:4141 with SMTP id a640c23a62f3a-b302689ce0emr142054966b.2.1758657638404;
        Tue, 23 Sep 2025 13:00:38 -0700 (PDT)
Received: from bhk ([165.50.1.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2ac72dbe92sm672074066b.111.2025.09.23.13.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:00:38 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	matttbe@kernel.org,
	chuck.lever@oracle.com,
	jdamato@fastly.com,
	skhawaja@google.com,
	dw@davidwei.uk,
	mkarsten@uwaterloo.ca,
	yoong.siang.song@intel.com,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org
Cc: horms@kernel.org,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH RFC 0/4] Add XDP RX queue index metadata via kfuncs
Date: Tue, 23 Sep 2025 22:00:11 +0100
Message-ID: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
Mehdi Ben Hadj Khelifa (4):
  netlink: specs: Add XDP RX queue index to XDP metadata
  net: xdp: Add xmo_rx_queue_index callback
  uapi: netdev: Add XDP RX queue index metadata flags
  net: veth: Implement RX queue index XDP hint

 Documentation/netlink/specs/netdev.yaml |  5 +++++
 drivers/net/veth.c                      | 12 ++++++++++++
 include/net/xdp.h                       |  5 +++++
 include/uapi/linux/netdev.h             |  3 +++
 net/core/xdp.c                          | 15 +++++++++++++++
 tools/include/uapi/linux/netdev.h       |  3 +++
 6 files changed, 43 insertions(+)
 ---
 base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
 this is the commit of tag: v6.17-rc7 on the mainline.
 This patch series is intended to make a base for setting
 queue_index in the xdp_rxq_info struct in bpf/cpumap.c to
 the right index. Although that part I still didn't figure
 out yet,I m searching for my guidance to do that as well
 as for the correctness of the patches in this series.
 
 Best Regards,
 Mehdi Ben Hadj Khelifa
-- 
2.51.0



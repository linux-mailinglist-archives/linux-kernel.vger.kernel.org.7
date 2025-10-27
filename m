Return-Path: <linux-kernel+bounces-871801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8F2C0E672
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2298F463C50
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222413074B4;
	Mon, 27 Oct 2025 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apxUIWZO"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D1A27707
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574550; cv=none; b=kOtruQAsMKqvVpQJwSnCkdlrWI6D/ZVlMA9lymjLLOI4E5Rzef5llsDDqGlfROjcXTOh3fB5JLcEe80seK/if1XXbzFjcys/ryzXfGtUQXIVKaS1JRFqWP7/g9f/v5GvQUqXo+yVH4zumzm63tCxSWO28e8JJhWrlrIDSkXKpJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574550; c=relaxed/simple;
	bh=BN0B1viip5cEGxYQ8Byw7+3n3EaaPjNb5qWKQKHhO44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8ueVOeHXqzYvssLKK3m2sCeQCZUB2Mg2NVX7waEjqnGhmzoFyhbUAAgtUFSI0FoMquHvq05Rps2FFsM6TTX2kZRMLcws4Kg5+mq5HTIQLCHd99PSlU05qgmtNWDeQWwnBpcUSxLzGzjh9GLJvbHsyu96CVk0OXqCqEtA+7M7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apxUIWZO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7811a02316bso3368021b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761574548; x=1762179348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqP/tFEEHDNzJ0xzPMLOoGVbbMkSCsGCa36SLEX5bKQ=;
        b=apxUIWZONSSbH0uCX73zg60qcHKl0lxDfcqREhnzpfoTaSxd/UN9ZLZx9sG8PSptsZ
         9wZQwtbEWiBwXtXWmQuMRZSXMcZ2pLRu9FqciIDu4GcnH15ja7Ydacv/2RqXngrlqfHD
         Y0xJtxE79XdlGdxKAmmOP+LNvSF725AdyFbZ7qhu2eTbwjhrawyYcqUVRSGFXBEvewxD
         ajZpLcLEC20oAV0+7t7aKsGatkcFkztCsKeUcmHMlBgyxAY5YefTENlpgq2OqdbqIccJ
         ufeTcNFq5oeK24/matDRkAwV1kZxKqhXVKUWArA1jFFnCNn5y4APtc1hT03ClkyyQ+/p
         8v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761574548; x=1762179348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqP/tFEEHDNzJ0xzPMLOoGVbbMkSCsGCa36SLEX5bKQ=;
        b=fmNKWt8zStKsMJPAUH3MBFDxkLkea9t3Gf8riTKAliyDnvs42ddhZFB/flwgJoFk99
         Hmgerh9S011c58QO/PsN5dKwqRn36Lmy9PV+n7o5FnyQYTiEKEe0m6h4o/V3fG/komKQ
         v/tcnJFsv/v9xT+VTb1n3sLmo3xHc25B6QPFrgWGjb/3LDVT3B6C43pdEVOOvnWOJbuq
         micI3XY4ZlVWHJf136Iq8HXb2dOMrBsZ2WFKtFuYPX6CiS2ut9shWPGDBogG4plQMb19
         2CmDPtWCCwgfKs5VRlP7x8CcZpW5nTEXvDRw4yNHa9eB8LiS4Z8Tl79Fhvc4l3VInYNy
         ilqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2OphiWDCk2MmbDPBZuoakZzy7bQg0FOwkAV32IUGHTpu/g6i+PE3Wo8lhyEL4nuwaaWYH8BIth0LPofI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOtFMhMbeqY5o/FzbHB9+Ce/9klOIGdDydH6F3dwIuWQQgKWtb
	+NLb+WIAFIy9O250Ei9VBuKjdBx6kDBzbxKru6XV86V7yVKvd4g1lRR8
X-Gm-Gg: ASbGncsroVf6XTVIbkHep00bhyD1ks/pqN9+T+H2cmqkaVq2pnXK7Z6UKXK1RsQevNp
	OSbmUzyNbnX2oN/N7brGRC3sq5B3xXJL/FB3oLsM3ERtjtoT2kL71/RGGzBfQ2n+F4qZrqIZSaZ
	qQA/G2/sHt6CIhsFbkmB9YrG+OzEvWq+jo5k2wfbfQI/Td44icgqlfST5JO1KScY4+2PTrwJbx/
	N8ww365AR+JTWM5OKu2DVn0C5Eoz2q7TRkIR0zJGnq5qbDaRJPG4iruZN4qEpXGZ9Km/vvFPso8
	yQEz0rJRXjueG5WC1R9Orh/3PAB6sj0MY9VdOvA+2wNtf3hWB8/XCSUTKYqRUx9xjnjjHtkyh8N
	1FypATKt//2eKgkFnv4SYbgVVwpvy1XWO8OHPEtSzh7LQisb7c4PWRhkM5pzipJ7kbpl8Kpac4T
	FiyxqJ9KdkYpymF2+/Y5zJfag=
X-Google-Smtp-Source: AGHT+IFsmR+a6JhgocTZ2HjeLtDvl6LPTelhCD76lVrghPUPZVlA3BMKDebbFVo6wETGuCyRFuuP5w==
X-Received: by 2002:a05:6a00:22d6:b0:781:1a9f:aeeb with SMTP id d2e1a72fcca58-7a441bbe803mr147243b3a.1.1761574548086;
        Mon, 27 Oct 2025 07:15:48 -0700 (PDT)
Received: from localhost.localdomain ([150.109.25.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41c70ea64sm6788166b3a.3.2025.10.27.07.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:15:47 -0700 (PDT)
From: HaiYang Zhong <wokezhong@gmail.com>
X-Google-Original-From: HaiYang Zhong <wokezhong@tencent.com>
To: kuniyu@google.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	wokezhong@gmail.com,
	wokezhong@tencent.com
Subject: [PATCH v3 0/2] net/tcp: fix permanent FIN-WAIT-1 state and add packetdrill test
Date: Mon, 27 Oct 2025 22:15:40 +0800
Message-ID: <20251027141542.3746029-1-wokezhong@tencent.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <CAAVpQUC7qk_1Dj+fuC-wfesHkUMQhNoVdUY9GXo=vYzmJJ1WdA@mail.gmail.com>
References: <CAAVpQUC7qk_1Dj+fuC-wfesHkUMQhNoVdUY9GXo=vYzmJJ1WdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kuniyuki,

Thank you for the feedback. I've shortened the test duration in v3.

The test is now:
- Moved to tools/testing/selftests/net/packetdrill/
- Reduced from 360+ seconds to under 4 seconds

Please see the v3 series for details.

Best regards,
HaiYang Zhong

HaiYang Zhong (2):
  net/tcp: fix permanent FIN-WAIT-1 state with continuous zero window
    packets
  net/tcp: add packetdrill test for FIN-WAIT-1 zero-window fix

 net/ipv4/tcp_input.c                          |  2 ++
 .../packetdrill/tcp_fin_wait1_zero_window.pkt | 34 +++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fin_wait1_zero_window.pkt

-- 
2.43.7



Return-Path: <linux-kernel+bounces-837292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041EEBABE01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C4E3AC253
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264162BE7AF;
	Tue, 30 Sep 2025 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="COsHEaPF"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB9729E11A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218245; cv=none; b=CMi/cyvSjU5fSTukX3Pm3ioC6NBtAv8XKDLfXizPpveRBTaZ9mHakv6hDEzQw87/2Sriq+FqmNSaaD3QUfYOQkzzpHgNSOhs2g+RWob2J5/pWLsey4197tJhXoUBHvGd8MxgcDKQoLysVFcqBfH3NFUElIq5eKrJiRs22+Looi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218245; c=relaxed/simple;
	bh=fT9soEm15HrCXq7EaWTOx+9+Z9/K99syifo6afXlc2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=d08L/EQ0jhsqD8NKrb0x98sRG0811u4l0J99oyEVm4PdUSftXReQE9ZENekkDwf0MVf07S4VfNsLopwCra7fMJekcW9MvZcym5Wk7jv5ozyWbIXKao7VmLYm5RskF4pTRdjsOhz5VgR+17EOEQONRCjHy6b5oQWXNce/AOzrecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=COsHEaPF; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so4304965a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759218242; x=1759823042; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S+GWBz0oO7f/Lmd1JETTBBhflgvMDIE2U8FWt4CXlOU=;
        b=COsHEaPFbor1d9eMRXKSFcV8jb7+hNTFfY4Gncla+qIPOYLtRY2Xu0Aogzxp3Z9X8+
         +u64oH9H0lcNjL6TESIh/cKxsVWGiBejbY9G87LH5D3SoeEAVmEqxc7FgY9raUryg3ou
         /D2P+/XUXn9cPeJx5c/I7ENQVeFI45DaxU/42L17fWHOBBnKUylB94tktez38pJLkvYz
         fgmt7Cz9hnA8RKIfrYnQNs/Da2s/6IgjYQYUC1L981OWcORMmr7vxAmz1mER0SW0rbyA
         Ssu9SK0CKcWVa820d7Jf6nBuulNvLMWpiNoSdVYP6R9smnzyps+qvMHUxJAmEYKOokx1
         VGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218242; x=1759823042;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+GWBz0oO7f/Lmd1JETTBBhflgvMDIE2U8FWt4CXlOU=;
        b=oy8+7m5R6xUIJzyEHqsAKKO8x2nBTnioMA4yJ69+ltBZdTrFn3UDg36rsb0QBVU/Sw
         C5W18qMoULKAXoAIfrfIkRRiv62eS9u43yhLGglIq9FSTr9niAZcn8IRgqrPVkS7PKP3
         G/Dh2fj9Fu9LC9Qx7UT5l59pUm3vZTiPHAONv2AIco73+P764peck1Jgc4Au+UxKI7C6
         eaXkbHtt+Jce3o01t4m9KVjdWlQNyzWSjZkiWDIc+n40VSkdARwT/3qSHAfQ+cY9dW1G
         jO1S6QnVrkcgN6I+Z2ROWgdmpw+X9unRCDg7I8iiFM8RIeeMK6yyuyZCj5Hvt5GsNi1F
         gJyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOSmz7xKH5j7Yd42k+M6nIDhECDNKVF8YpfXXx9IB1YAVG77QcBjNOMxJmsQpdWyszqks454oCWTdKaVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDs7hGMjk5cwAyKqgteLudPepQgLnfLZ4aOeVBPJ+LWC32sL6u
	gRbPAZS0lhjZJxyjupmIWHFGuND6mCgYeiDqEOE0Mlrzk+S0VJJin9s+Rz/+3Prqp2M=
X-Gm-Gg: ASbGnctJKbD5ZxaqYVexskCT/0YRAfGf0ADZJBLuFhBudGKdJOQ+wBteJu6zOvwkWvk
	l02IkW0331ABEvk5NF6MPVZsM3/g5mNRkIqSyTMcAMudhtBukXr06lWLHiQQ9NHzgL6Qr080SdB
	37UT5w+ZQDEugAbPZN01NN4RnQuYIAbjoULIP04ivZWTrD7vok3zh5ip1To6b1B10QxN/z9c7q0
	wgw5+1jx/4nYRHhUT1ah/BTNPxvm5aqcplPE+SFc3RPkBEpVbXUtEZrpoTCfV+PCmjP2BiHfPiA
	IqpjeT2OLYmUA6MGgdF4hAm4YetQ6yb3+fA00+0azuLJDA/lZhpZkH2YER/bxCxQ577W/39l4oZ
	Ia7jgJHcXY121skhZgNxebAsnul29zgTskjfY/HKuw7cq4ZAMKHEGcMCX9/K/8jLMfIccCL4sSW
	B0JsMFzGY7QYasP5hPmbqvR8k=
X-Google-Smtp-Source: AGHT+IFEbpHK7DlmslkbdpJiHFyYSOPszmOBBa9J2pFP03qYZpUo6cclFGnoot3eNpMyiKMXXRLIJQ==
X-Received: by 2002:a17:90b:38c4:b0:338:3cea:6089 with SMTP id 98e67ed59e1d1-3383cea60d3mr3829629a91.14.1759218241989;
        Tue, 30 Sep 2025 00:44:01 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-338386f577bsm3535374a91.2.2025.09.30.00.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:44:01 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: corey@minyard.net
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	guojinhui.liam@bytedance.com
Subject: [PATCH v2 3/3] ipmi: Skip channel scan if channels are already marked ready
Date: Tue, 30 Sep 2025 15:42:39 +0800
Message-Id: <20250930074239.2353-4-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250930074239.2353-1-guojinhui.liam@bytedance.com>
References: <20250930074239.2353-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Channels remain static unless the BMC firmware changes.
Therefore, rescanning is unnecessary while they are marked
ready and no BMC update has occurred.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 536484b8e52d..db8ef2e46488 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -3439,6 +3439,10 @@ static int __scan_channels(struct ipmi_smi *intf,
 		intf->channels_ready = false;
 	}
 
+	/* Skip channel scan if channels are already marked ready */
+	if (intf->channels_ready)
+		return 0;
+
 	if (ipmi_version_major(id) > 1
 			|| (ipmi_version_major(id) == 1
 			    && ipmi_version_minor(id) >= 5)) {
-- 
2.20.1



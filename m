Return-Path: <linux-kernel+bounces-834881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C53BA5BD4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E877C7AF420
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EE72D5C86;
	Sat, 27 Sep 2025 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMva3wQ/"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09612D543D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758963992; cv=none; b=scsTNXLgxVypb0HncPZnLkSR8/DyiLJOlfPNnDxXZGm3blKl3JVYq2Yz5jknOqNjwRt4KyFVKETOWmMYBPlqlPKOkqYfmbS/h8vxyyUjGovn9kXGQNYk/0mDOSKHY1eumb68TKnkAdpWbZoatsuA1+5Wj0lYsiv0ljeJAcbQmJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758963992; c=relaxed/simple;
	bh=Hr7hpNMdUF2WDaaY5qlPkxtXvsgdHXvWif6/xAXRdmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=keD5P4DolkF7Yb5k81IVUE+DUs1t3WY1xf0vr1sxNmkoGqhX7zr3Vak+5JE+uYQM1Ppcl1whUDdMT9hPlBS8VX6c5vmF0SYN9maa4X1EYWRRNkZgF6d1OmsfysurhNINedJ4w4cYSK+Wdm9vl7CYMLLMNen6y4Np8WUe+In13cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMva3wQ/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27d69771e3eso26651035ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758963990; x=1759568790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hr7hpNMdUF2WDaaY5qlPkxtXvsgdHXvWif6/xAXRdmQ=;
        b=JMva3wQ//96BzKz84QhuPelmPm37UeFl5VplGKKveVP53VXxp/HCXd9YQPDSrYRdow
         jWCzDlYBTycDqwEgo6F07AODXCh4kUwkmPDA6HmhokRe+3LXHwBp7OXBI8vRtevtSBYU
         /01iilB4L7PJSwMiHkqUVDUmGh0orHtNAlad0Lfn3WXwjz7dMfcbm9Sa4jwvh7yWZZ4W
         MfojslUAfBrR7hfyknzh2JFyP/UINjAQEIBR4lKFi5a903uPIicixb1uJBgcYRwBk6q4
         3n6UjGzRcMoeacn4UEm5Hk91ZkYh4/hqAenr9BPy9bMoF0I6+nZTma3a8zuSgEgsK2Es
         fBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758963990; x=1759568790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hr7hpNMdUF2WDaaY5qlPkxtXvsgdHXvWif6/xAXRdmQ=;
        b=i2Fw+Kj6tlfd1muxhXl0FMcEws8ti9Tw6X+OtM0l/UMKDA7O6vmr9LD518trrRyFAQ
         xCWn7jLrP9CiV6JzQJryEd6+yEOH6DNaxlyp7rw2xNqSo18do3B4HRPMNM38EFps1L/h
         ZCPEHozTjfXIgnEYNRwaU04kmgI0JAu2arxVeQoXroicCseq6+J/1r/f9T9o7x227EQr
         Z6pzxGIIdl4W3jppdPUjnZEwbZdcRMcxvyeuaHife45W8/c0NP1qIUCw5OJAEJmEXb6q
         DhNXC3w9aG90DJMxqe/WD+CEj/dbexCFjJfK2f17iqbiUJvh3HWs6PxMSeqBoXr1PXtR
         uHuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjWN7ZU9XgYKDGJrdrLg4n3i9RIvuozJOPF8zohBG/S/Q2SOSHiDSICul7dOi4IqZKnB5YauEZvLA+eV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy36m+Rv3IG2xrHR2AUf1o0cvxFa0Ou1gYnOPxfdnDOOtgqHCvj
	luFfD8B11cL8EnYw3joi9V2Bj+OEMcVLQuPlNMoc2xKeogj2ixdTJqsb
X-Gm-Gg: ASbGncv1+LK1jnyQVeS8sT4ui2/rTdf8s1FdYzIoeLY2HOxE1w3CflLOvWX2xXmTQuB
	K1nGX4cqLnhMQhSGfl3TSWslrwi9i05OTHFk8p2Vs+I7hWneuya4yomX2pR3IQbRfcl1r3pwzIw
	9ImYcHFsvpMpZ5pMReT5CuySXrMv2vxw3NECYm2n7alsSqJUQLlC4OIViayW2qNIe18GWTfFTJz
	P5rImaB0UmE+ls5Q6WEzF6w0Rdzcb7RfCaAxeGS0yBjYbOQzxrCR5rZ2dWGifX1CTgkC4kP+tUA
	ckczS60Wk7+TWpptz7iIdJ9JnkMK81JsSB2PO6vI41gRl+76UnwTwTvvluVfpfS7vEDDg1AgVcx
	16WRQpkp6WsxYJgObhVCst1OU/VwTVu+5l+Q8K1JnaNDbzfzuQqd0OwP2A6fZgy206eWDfPKYgQ
	==
X-Google-Smtp-Source: AGHT+IEdXtdZWJP39SIZQwh+ANixzmcmzBAnJe6eF9v1tcCIh+gbLm+ELiBPGPPxoTg1GHgsIuKP+g==
X-Received: by 2002:a17:903:1a0d:b0:24c:cca1:7cfc with SMTP id d9443c01a7336-27ed4acebbcmr110769605ad.59.1758963989875;
        Sat, 27 Sep 2025 02:06:29 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:ff57:4e03:384:b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6716167sm75573375ad.44.2025.09.27.02.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 02:06:29 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Fix deadlocks between fallocate and readahead
Date: Sat, 27 Sep 2025 14:36:23 +0530
Message-ID: <20250927090623.42024-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for reviewing the patch. I'll join the IRC channel to discuss the pagecache lock issues further.

If there are other areas in bcachefs that would be good for learning the codebase, let me know.

Thanks,
Deepanshu


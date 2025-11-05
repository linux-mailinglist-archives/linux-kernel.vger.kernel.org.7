Return-Path: <linux-kernel+bounces-886150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F52FC34DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 530EF501DE5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7AA2FD7CF;
	Wed,  5 Nov 2025 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDk6hTQO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9Adqmma"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F98B2FB0BD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334679; cv=none; b=kLPIOVCgra1MUzxxVwysv+ErVeYkECVpG5U4RuZylm3eSWSz9ohvlyoK4G+FaedR2R77s2BtSzbUgRp4WJJIF0jbhOBgB8FaShSfxdZqYXqZO3Zl+X/YAaqvtXWZWJsvsFoHHlkauFRDAsCiLBp0sDflTUTiiheHIBKh4wuUUmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334679; c=relaxed/simple;
	bh=WauXXc4vq9dc4m2YhCPTip3cxluiOfELkNgUqBfMKh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yzx9xmnI1ZV5CECAKpEJe0E1fJOsCQlf6L+XZFcjIvpInBfyw20QZ72jTHWW+Iz7h5oJWEJfAe377iUFF7KpOkJ00QxCzU3ipzfqCIpnkgypEA6VM56AUms0lor/T6wOzJee+bwEdsqdv8tuc8V27Fp3G/jf8KsV7JoxmAzyvps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDk6hTQO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9Adqmma; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762334675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g2LtK1WnukuglRDzUwFbcjJQDJY3v+csn/jdcjcqmx4=;
	b=PDk6hTQON5rKtxboLb441TPxgqEEtXaVApQvBixdLU9zbJ4ntK2hZOgdldedv6Y0hO5eVe
	IN+RTKdVaP0/EapUiqKJWAD3wk2J93qoY1m7GCOcMfl/Ha8GN6OwVzc7176AMauI7VWl+F
	wREND9/6xMC3sGTwbrJ9z2jpgws3xts=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-nT3zAO6rO0CusDwlWFc9ZQ-1; Wed, 05 Nov 2025 04:24:34 -0500
X-MC-Unique: nT3zAO6rO0CusDwlWFc9ZQ-1
X-Mimecast-MFC-AGG-ID: nT3zAO6rO0CusDwlWFc9ZQ_1762334673
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477563e531cso16453045e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762334673; x=1762939473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g2LtK1WnukuglRDzUwFbcjJQDJY3v+csn/jdcjcqmx4=;
        b=Y9AdqmmayJwG1DNdsivkZEqOyP1cqh+UQz79IytjaXcjK83DTIRTLdDEpGCAN/QvHh
         iaCg37kuy9RwkKmwUR3fGxpC/DOR147rOiNHiRQlFmiB7ulSXZjPFTQ2s2RYrFAw51nQ
         v9qcgJsco2siVRi1BkNaBhGlRvRmwft3hQHZuC1V6zXYlMk5v+uwSrCQg4D6Dd+1SRbZ
         RX96OSC2x1SZks49Z9lhoemrW640tq3jHAgxWkRFdkXEi79KRdjx8Ee1WuEuv0omx4F1
         lRVoPP/rNvEMcg3yontKJ8zzuMlO6tiTBMgh1aJ21ML1RF8JIWSb8q/au3SMYdxpXqXP
         +FPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334673; x=1762939473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2LtK1WnukuglRDzUwFbcjJQDJY3v+csn/jdcjcqmx4=;
        b=O/DxuOHsDfI07T7zdMl+tJpodeXtnDqpQJfo3oj26XwHTeTbuQruzTOQto8FSM64d1
         5645ptSWzLd9oAfEnonzlo1Z+/MSx6l6uziLm2Y2uC6NmVqgqqVwDLQs4Ihk4BNWEBVP
         iwbN8w7DEjbdVoYfTOdB6F4I8QN7Q11TK87OuMKQX/8ZRNTJzpHP4A+xLWqWJgGTNLX1
         kyQlLs9kIF3eRWXz7PxBQfnloZ5krWEC4UZCzlh03RMK2wH3Hrf/lTFrZb2w0Jc1dquu
         ISrNFchbq/RZE+bRVhr862ErpIJpdGS5DfWDMlmSTYJJDjhxXGde1Ae33Uys7EOz6sNf
         Sf+A==
X-Forwarded-Encrypted: i=1; AJvYcCXv3AwkMc3lJpmhUnrqSsH3CoOgngp1T0DSyDQhFM6EKITxO63ZdbU0kFNEwDeZg132dfPB6tfD4Sb7Atc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrG0/OQktlPFKtVxCm9hKwJzt06D+/jszGIOxsC+xvjigjDcOr
	K2U3abeosL6EHZS2rQ5HyCdThPAJuwFLbd+V4fDv5v5h0AzdWhAfA44l13Nm0Qm3LxQ7cctZIq8
	qpetJhym6xJ9k6+0BUxffcJ+RW377i0bRjeSp00wR+Wfm0RxKCwMXY3tt0w4ZswZUSw==
X-Gm-Gg: ASbGncsp0gTmnz3qrmePRBDlvRc/stCzN9moX4oeeTS1cgXIm327O+ZVizWaJwhvHAb
	PvzbIHwXjXoUlnpWR3CEWv6odLA/YQuAU96HkQlzRlSE9joakGDQGOk3gQeI+fnfdeyMrdoxlXU
	5bUCsIIQEY+1x8GvdfH8vdZ26ecf6xKjIKnB7/QPEtPTob7ZwrxReUthVxrPnNufykkh53VfpfD
	3/XX+wwG1JkSJV4W8WTRaA/av0WxDBWK/snVDAwJBortvm5m/fOnW9XoRkomHpolciAlxxlt66Z
	kqw0i8yBW9TgwkfMKkCQqZ4R9q4ktT94QFdVdNfJ0vz0Bm1lco8qtg0Ou+nYufvZ1FRm7uBOB1F
	7r6c9omxjRSJjsZ9xvT/R9+WLjgRqdezLqdXyY4ujDkSJcfFI
X-Received: by 2002:a05:600c:458d:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-4775ce2b680mr18306635e9.28.1762334672789;
        Wed, 05 Nov 2025 01:24:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESJSYhewgGd1RuRz8Lw12CRAo4lDeH14xio5/jvFe4PBjGaxuU2eK1GZT9oVztYInMcPwNfA==
X-Received: by 2002:a05:600c:458d:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-4775ce2b680mr18306425e9.28.1762334672276;
        Wed, 05 Nov 2025 01:24:32 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc2007afsm9389164f8f.44.2025.11.05.01.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:24:31 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: add tracepoint core-api doc files to TRACING
Date: Wed,  5 Nov 2025 10:24:28 +0100
Message-ID: <20251105092428.153378-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

The files in Documentation/core-api/ are by virtue of their top-level
directory part of the Documentation section in MAINTAINERS. Each file in
Documentation/core-api/ should however also have a further section in
MAINTAINERS it belongs to, which fits to the technical area of the
documented API in that file.

The tracepoint.rst provides some explanation to tracepoints defined in
selected files under include/trace/events/, which itself is part of the
TRACING section.

So, add this core-api document to TRACING.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 499b52d7793f..297358d26bbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26197,6 +26197,7 @@ L:	linux-trace-kernel@vger.kernel.org
 S:	Maintained
 Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
+F:	Documentation/core-api/tracepoint.rst
 F:	Documentation/trace/*
 F:	fs/tracefs/
 F:	include/linux/trace*.h
-- 
2.51.1



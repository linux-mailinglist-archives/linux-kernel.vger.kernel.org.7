Return-Path: <linux-kernel+bounces-829874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6862DB9819A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841CA1B20A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E462236E8;
	Wed, 24 Sep 2025 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIzNF5+1"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380BD2147F9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758682533; cv=none; b=ntFcKONPLvqyMTwFQKUqUp/PdwOkpAh/H73aCnQMP9JxL5s53+THYiI+RIjDrQarQGRNR7F58a+T8tRTuCXvTNnL3EhRwhH8UiSF+LK5eHOVmOd/rYnBpF6YZXB+dj20nf2ub4Do81FEOjiGSz+c+nrrOx8AKK1aszc1riy5xLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758682533; c=relaxed/simple;
	bh=bm2epe93zLMC1CmNPO/0bKANSpaCEfsZMpV2wIYXwD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZHVbnMaxOvFxjgrHea5ABPdE+zMSavHXFwhoXNKh3U73hD4MqQsumpwSMz8F9T1W/fNs2JqPMIW2lOjBgWAeyhBNQXrFToNDe9F+cUEn3/cwbomFX83/AqnTokDBgGhE1dWDsycXaALeVzJnTPaxx2FcZqUC4wcyB2rYK9INb30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIzNF5+1; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-279e2554b6fso22550565ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758682531; x=1759287331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=il0Rh6jjeeiAS7jzN7tDtV9HZWk/D2ddD41PvShuPbk=;
        b=OIzNF5+11nzpevbwtGGWzjGrA/UvUoWjcW0X8sMeAg1H+U4HRm5O3yjcIx7o0AN2/b
         XstyXFFIhSUvtlWFr3JWudVDsHNP/slQR/zA5BEMHWXgSULrW7H91KUpdMMMVRq1V03U
         q0k39WdBLreoGTophyYhpTXSnUWvFBB120TU09W8iimXmt4QMVcC7Azz1k9RQBzPZ/a/
         EaW31ecGubL+BarPSIaFtYKGiS4hS3zwPr+layZg7YAf/DT5yHFq6+Q8R45J34FtXefK
         IfnY7RBFcpBdYFgeWuQBhYa5jzpHPPkmGirIMOg76G7TLCztJYTgBcEUA+1Wwg5AtrN3
         UMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758682531; x=1759287331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=il0Rh6jjeeiAS7jzN7tDtV9HZWk/D2ddD41PvShuPbk=;
        b=a4EZeWzfaKeaxQOvru7ZQ8iVXGeo5mabyg+bA9sMufcHVMUO9H9Y89ShRsnehQ4oJT
         IrTFLdkHpZdaeIvh4+0MbE5KEJFfVkrCzv4Gl8i7/qDAjy15459z42iQmUML5/xDDBPY
         GePo77vRiMEScLZhW+Ff8beja6ySNI4mW5APv+mofaMufNPzy6b+O4tZcv/2FQCzLEoP
         jE2S2RKBV3Uy29+6GMR0Hd+/F9zV1urM6jwBX/sq+I9u7go/GswaKN3IbuCLlGhs2DER
         dK9hOk8EZb8M7oNznKpXuQaF91qmhis4zROU0cu3G82C9NU/s9dG+Auhh5FustsH5xF4
         zNsQ==
X-Gm-Message-State: AOJu0YwWp8my27RYXFIpFOswOn3bXf9eCP49Ayi/nPb1luwCOX/NRPDv
	nMDqar7yojRloLBzvpLucEwGe/12Is6Tr3Q2U3Z6/8W1jwJN9Rw6pVl2
X-Gm-Gg: ASbGncs6rPPHj23m+zqb/DJZ0hv/Nfa9tgnKji4pIHsJgXHQ1G+RBzizTJnXssUg7RR
	gRZJHuE3Y9pFcRu26K67AhDX38dd1JANIqn7QVgGdOI26+DWuIWEmNAIHpBf7AZYE8MkoUDNA+K
	2fvSDFIP6IAF2xM9G1yc1bemh50lc2JNLbSVxY78BoCnc2Uo0qnF9Fr+gHicmXfIQh0fceZHZKR
	GfpHWZPK/TtHFd8iZg5GuJKED/z/HzNMivdkVlEVFBzf1DA2pa5FnY7YgENwkLHmMkDeZ78gadU
	bpmhNjfuTPFpN5yxNgpIWew8i48SmjmPELprnUaxz8ILBmdQtKnXqMAzrUYhfuOGCYB3MqQ3W97
	5uZ2bEfJHkWFLjkAgTzHsjHZBu1YcAoZKc6b3v+EpUG2zhy9F1jg=
X-Google-Smtp-Source: AGHT+IF1meMrMvZtj8Zhw9AeG+j9x3fUMEf06X9X2JaKe3j4NHlXZzTdJGu3JBvEXaE9LIEr1DLkMQ==
X-Received: by 2002:a17:902:e790:b0:26e:146e:769c with SMTP id d9443c01a7336-27cc79c8873mr60981165ad.52.1758682531425;
        Tue, 23 Sep 2025 19:55:31 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980319870sm175895955ad.120.2025.09.23.19.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 19:55:31 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	zhanghongru@xiaomi.com
Subject: [PATCH v2 0/2] selinux: speed up avc_search_node() with large number of avc nodes
Date: Wed, 24 Sep 2025 10:55:19 +0800
Message-ID: <cover.1758633723.git.zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On mobile device high-load situations, permission check can happen
more than 90,000/s (8 core system). With default 512 cache nodes
configuration, avc cache miss happens more often and occasionally
leads to long time (>2ms) irqs off on both big and little cores,
which decreases system real-time capability.

Although we can expand avc nodes through /sys/fs/selinux/cache_threshold
to mitigate long time irqs off, hash conflicts make the bucket average
length longer because of the fixed size of cache slots, leading to
avc_search_node() latency increase.

This patch series aims to expand AVC nodes without significantly increasing
avc_search_node() latency.

This is v2 of the patch series, addressing feedback from v1.
Changes since v1:
- improve hash algorithm in avc_hash()
- define avc_cache_slots as a static variable

v1 discussion:
https://lore.kernel.org/selinux/20250905100454.685866-1-zhanghongru@xiaomi.com/

--
Hongru Zhang (2):
  selinux: Make avc cache slot size configurable during boot
  selinux: improve bucket distribution uniformity of avc_hash()

 .../admin-guide/kernel-parameters.txt         |  4 +
 security/selinux/avc.c                        | 82 ++++++++++++++-----
 2 files changed, 64 insertions(+), 22 deletions(-)


base-commit: 68e1e908cb7682db9fb7f79907f9352435a81c0f
-- 
2.43.0



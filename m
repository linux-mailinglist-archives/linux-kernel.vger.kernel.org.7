Return-Path: <linux-kernel+bounces-837753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85D7BAD1C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625AE1C74A7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEC2264F96;
	Tue, 30 Sep 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hl+oX+Zy"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88550239E67
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240624; cv=none; b=Yd2APNepKBZZj210Mu4M/GTKuNSNZS4HtE7vQFInI8edphsgk8E7j5lU2qYiomNV4fQgiIHHizSPRhT9XpLo8J9ASrxNrKBHxM3E9fsLt6AdpfF+rAOzGVPlzOpfT+3EmFFw5fYqHaNdDlg5gUT3V4zQNhltp1wisQj8cQBonUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240624; c=relaxed/simple;
	bh=qtFuKldthuDqI8ZR74+ZNU7qKNRVPEmO3MK92/BIjdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O6nW51raHF8M4XrvyE1ckIiMMDu0hYt+d4RVrIRdplyq/p7KisciK2BvVZ9EL/hvZZh+ftb55BO/yVczERa9AeZTxTrdMSAhmJFpNODtopgvuCmNyZiAsK8Zz5YD33wfX3fA3bLjIoFNW+lS1tnbeO/vFgtN3jbEMLvktrgsnhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hl+oX+Zy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso39100415e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759240620; x=1759845420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A1FGc0c7Pyt79arhBSB2ZwA4aD4/D9YDuG4eKl/UZpA=;
        b=Hl+oX+Zy3WvCpyUHjHraZQcJqU9PHzbCFmRJnnYtyo1P+lxkJ7qPOuXwzm0rV0u/P1
         PcUVxkzKpUn48ofvCohDJmvyyxQLxerh1ZOugb9GPufnNNPpiQfQ11bGc6H+cChH81cv
         t6mDRUucIxRlLFZhjcTET0O0x0uGnU5o0I2IAD34nNBA/DoSP5dja8MV0tVD/YXOCBVa
         WGeuocYRQzUjlh7P+2s48gPkMSPLsKMQ3N3Ft7zTRMKkLBTALyi4hTXnXaod6Al255Uu
         7LC6drgMvEfgC1FmAe7OytXc4lpIGy9i1Pf7EDjoo7jmM4Xyj71xOFc5U9km7mAroygp
         sfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759240620; x=1759845420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1FGc0c7Pyt79arhBSB2ZwA4aD4/D9YDuG4eKl/UZpA=;
        b=NgZUGTOVY7CssyWtYT+GqawK+loAKL7k7vmCK0na7XRufr2VgrjH1Wqh/iSI+/lA7S
         HAVh2yZ2ZmXHzB5hIQNw7qSjdHiHf9r4Ox2Cb8GbArirestiZ0l3eV9Ja4WYxf3IUTeZ
         ufrwVuYE9kJUdDRzvH4qaKApLJIFAjLd6DbTDgvWmED/Z3U0MqFsaWv2ktZJGq8/neUX
         qGcR6B4AvRBJXDKPBz826vYMfBvuFwgV7UMSS50JPZ0HLpswZSrFzNnNVGGQod4BvE/A
         Udow6X77YJsCwSANQy+WX09JhgErYjvrhm/FUKOPKC2kr4rtBZ9zbsCgsYW7bVumLbaA
         sAzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeftPfp/O+UVv3Pe9tnCJrfasZ+1IByKvWCUzAX0nNkS7SlHEEN8VvedHrVyoFgbeznRR18fZbHmnt7eE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5lB2frjMTtfQON8ianUrxWrK5LN+NJJAJGWSomW0MvkOwEPwV
	6ouyxFUY4Us4YGMh/t9yq8EAtZK3I5EKGrGe9DGvK0sqavMnkMNc1dgD
X-Gm-Gg: ASbGnctl9v+X0LOD7Jm5PHLyIb+o8q3LcQ+nsrmdkInTTvB1owVEYBgNH9bzDMBW8lm
	xFHMJH2jAZJwVRKHr7Me8X1aYwBtGeOLu5yQgb9lTip5GQGKg6uZbzpecCdjbbZfz2S606uqtOR
	iqpjlLeehGUv0EIAy/PJwOmTIkH03EH/i0LPemg9gUhaBOrrb1SE/gRt3HdrXmxxVxszWTH1JhD
	uv5nn4uuwgMsupTFCkmdQHljUK5zXqQpbf0TgyX9HS8tQ9T1E3Uq+C9K4Fta2M+qbZmvdF6Racs
	HBtRY4MfaPnQZp9Wo/tQZPpGYBYJRJM5uSAjWhcY0mMU7c9REo8i9zkYYBM31x3db0LpPtpyyrH
	UHBtKqaXyzCEl1APw7ayRvfaoVdEYqYxjuPYOxRp4XZTAvAjAxGO7nu3mNCMAVUH/XyKbFinGHq
	CvL6HBrzfNnGjCPz5v5G18TvLc3A==
X-Google-Smtp-Source: AGHT+IEl0eV+Oe9fa7cMgeQckQ/Gji3bBkOIXAKMi+nEieK0u/LUPG6fuatnTc3ieztZ20R+dNzEuw==
X-Received: by 2002:a05:600c:4743:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-46e33b2ca06mr166142075e9.32.1759240619373;
        Tue, 30 Sep 2025 06:56:59 -0700 (PDT)
Received: from osama.. ([41.238.33.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-41f0c467ecasm10062839f8f.38.2025.09.30.06.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 06:56:58 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] KVM: arm64: Remove unreachable break after return
Date: Tue, 30 Sep 2025 16:56:21 +0300
Message-ID: <20250930135621.162050-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove an unnecessary 'break' statement that follows a 'return'
in arch/arm64/kvm/at.c. The break is unreachable.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 arch/arm64/kvm/at.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
index d71ca4ddc9d1..b04c00f95944 100644
--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -43,7 +43,6 @@ static enum trans_regime compute_translation_regime(struct kvm_vcpu *vcpu, u32 o
 	case OP_AT_S1E2W:
 	case OP_AT_S1E2A:
 		return vcpu_el2_e2h_is_set(vcpu) ? TR_EL20 : TR_EL2;
-		break;
 	default:
 		return (vcpu_el2_e2h_is_set(vcpu) &&
 			vcpu_el2_tge_is_set(vcpu)) ? TR_EL20 : TR_EL10;
-- 
2.43.0



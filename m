Return-Path: <linux-kernel+bounces-819611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B23B5A3A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C6232538B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D37F2F9DB7;
	Tue, 16 Sep 2025 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBqiw5Or"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6F2F28F8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056921; cv=none; b=jBxu/8KVUeo7jbWZcIg9HV4FeZdNJznVPDIIN6yzGhUExzfHVgmUPJ9gUCWFbc7Sc4Li97nOrxYKIcCoVUObUhqL4sC7xsxWV28Rth7Z9Hz+cQnRus2RuiV07MKv3rwSXVYd1GVo4a17lB8rHdoaRIrhl6qAigZltADuRYuANdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056921; c=relaxed/simple;
	bh=EPitp67dkeS30o3szPKn6QZgJpEhFyOo+6e6g+VZ3CI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Si5SFbGl65Zc7Oabh0Sqv3foekQWSMvn4k+sKeZSk3r+nAFuy7qRINU9PE6hTO9kzgNXnEk6H66RuWUWheAL5U43ZrNwfQQCdrLaamt6KsgWEHj1dL/9FsuMQ2K+gqEsaGP+fVgLtGfvN+UVba7MdgESOPgpeG/Lhlw8+ZxsOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBqiw5Or; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-25d44908648so58272025ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758056919; x=1758661719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zp429VwRoqZJz0QZhuNSn/00UhicVBQdf9d9yD1+m0A=;
        b=IBqiw5OrT5+LqdzP5lTjIX2ShTK/B0MYedSn1gonaOuCh8/R27klS2v22wTaKgeWm3
         GbT+Izfp+krP+K59hszgiAQN0VqBZu8F/U3qlm0a+nEeUU4QoUE8reuZ2s8lIfNe+9Lk
         zGhRjmrwKtzvkc7ZXz7q1nFH/Qk5bBlj0iD1hmedsUD9Es8Dw7fFNex4jaSWNv1J+3Is
         ycAORSmz+qd0GhizMozKxGcqKuy+6/z27OnNxYeFNx2Ae1cEjmPfjOZ4nqiznR1Q/iqM
         MMVlEuDJ/XNzVyRtBK7nuPY9uNf5P1TqbIj7TsZmAL0FMlz6rNuE+x1C2AILiADlzTvF
         MTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056919; x=1758661719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zp429VwRoqZJz0QZhuNSn/00UhicVBQdf9d9yD1+m0A=;
        b=IMH5Z4ZorDKPbC9Y58ea26rBktd4SNDGp3Ha8bmpLT0oH9OaAzLeeXzi1ROVTEQ8q7
         O3pC9G57MTiawDvoNfbxOWwVanpRbAOJ/Ms0N0XSnqJEel1VEZ52fkVS1+D830w/Yrx6
         kiuN/cPQM7h34I40U19k5FU0zIwycNH/WT1pu3GR4uBvNTmNhYItbEP/mv2IuL3k7lBy
         U9HvXm7+EMYtd2JWjoa6XROcD0ISf8o5XWWLVIqn0GT7eehxgOYM7hyDGWxfbgoRfZK9
         IyJg8XJ2FaWCeJplucCMdX28fFS8n22lSQHQB2UmcHcVUIFEjZt1Fa0EOUHSgyXvdO8m
         iXsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx82aYeO/kSNu1mrmIQZp6qwekP2ynDfSqXmWb+WPYZmu0LPMjQkycsAKGOIklV7dVHFykWNf89xE3l8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6KbaYMQQwJgImHW65CqQ7N+hrmFAyZ/9tlB2YdR6txhf7Cokp
	6f1pGGFxEfZbfxt/x649nOKaXZEAUZkO0LVJHADOjeOsdC818hALmzCA
X-Gm-Gg: ASbGncvJA1HXYAQvFBqoTpvMp2+HQJgg7iW1exu4CJpx8MBn83z+LZ6qKGe5PR5obT1
	xWWMeGc/LVz1FBH2j3c21pC7ZAo8VQylv1TpbwxnX0bUlwD0xFtQdp7TnxNGcbi30ZIt8u6PL27
	S+OjJ2UYsQ/Gl2rtXW7k/txRktBtAzO7N6EC7Vrtq099v9Jwy0BxNpBVoHcV3ycSyzFV9YhThf+
	Pd6bTwuHLsqZedDrnQ6rPSBI3S9JpkTOBj2BlUJpij4zllJMc2PIMUga9J4QTbYYuPy6+iFeWU4
	p4ejWzwNtGb2fs1XDVwEpbEiLtKtvQF1v69pTAZ1HcASUsqBg9c1Clhompl4AZz5w5WY0W233dp
	fzozPA8XMLT7pxF8LrXoTbYQLHWbUyyDs65FhRIYEdXiAMYeM9Tv5vFq8p9ooXDFEjJUi+ZP5NY
	ObSwOCsHcD6w==
X-Google-Smtp-Source: AGHT+IHWb5vz3chJSBX2CcOdVpb74MMd2l9HAF0/B3oCFgO2DuURnS3/3+EQM2BpeXdo7mOMhcq0Yw==
X-Received: by 2002:a17:902:d4c1:b0:267:cdc8:b30b with SMTP id d9443c01a7336-267cdc8b588mr54724745ad.53.1758056918694;
        Tue, 16 Sep 2025 14:08:38 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-265819a61b3sm78487955ad.42.2025.09.16.14.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:08:38 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Grant Likely <grant.likely@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] drm/panthor: remove unnecessary mmu_hw_wait_ready calls
Date: Tue, 16 Sep 2025 14:08:20 -0700
Message-ID: <20250916210823.4033529-8-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250916210823.4033529-1-olvaffe@gmail.com>
References: <20250916210823.4033529-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need to call mmu_hw_wait_ready after panthor_gpu_flush_caches or
before returning from mmu_hw_flush_caches.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 373871aeea9f4..c223e3fadf92e 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -669,12 +669,9 @@ static int mmu_hw_flush_caches(struct panthor_device *ptdev, int as_nr, u64 iova
 	 * at the end of the GPU_CONTROL cache flush command, unlike
 	 * AS_COMMAND_FLUSH_MEM or AS_COMMAND_FLUSH_PT.
 	 */
-	ret = mmu_hw_wait_ready(ptdev, as_nr);
-	if (!ret)
-		mmu_hw_cmd_unlock(ptdev, as_nr);
+	mmu_hw_cmd_unlock(ptdev, as_nr);
 
-	/* Wait for the unlock command to complete */
-	return mmu_hw_wait_ready(ptdev, as_nr);
+	return 0;
 }
 
 static int mmu_hw_do_operation(struct panthor_vm *vm,
-- 
2.51.0.384.g4c02a37b29-goog



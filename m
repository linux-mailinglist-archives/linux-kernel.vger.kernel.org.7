Return-Path: <linux-kernel+bounces-732064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CD1B0615A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B4C47BC838
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403FB1F5437;
	Tue, 15 Jul 2025 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhy52LwY"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576721D5ADE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589842; cv=none; b=qdKyv/s8hTuS+PrYLG4iVhomqiY+qqCOivISD8QU5NMCJ5SdSi9wJe7GcJTHKwNq+BLKK33JWoUG667EK3PtVjUceLoX+IopViRSaGYY8X397jnP+q4ufgrrqw0vP5p4eXJV0nJgexNqZk8FJzC24IfnqcBpQ58wvDjwmP+ib8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589842; c=relaxed/simple;
	bh=Drm4yruRkxpBnloK/hD6xA/NzPWR71Wr8Q7SYQ9kym8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UVsM12XcbhaDXIiBgVkT1XqOo1CCGoiupIZaj7LovUSmMS4AsSGrmgum8ZiKmGX2TzpAavVoyar7k856qOutbia5ZUx03uiVhLQA3VBlDMoZWlna5D//HOdiP2O38+niOLt0TrY/3NqaZi3YyXpuH7s+68+WkFoZPoq4j6/io40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhy52LwY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7494999de5cso3478648b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752589840; x=1753194640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EOmgKiLTp47jsfMu4jAIxpovRWBotnDPNT5k/Df0iEg=;
        b=mhy52LwYEDGHbKgiZLXu9qLFI8pfEg9cNAcqeZfVrplBkn+PcEfFu3L+01HaPYN3k1
         MyQiQW1l/XOatz3YfNugyjQc8+hCvGq/Le1LJp62f/3kXWfRhNqZBantAsVkfDCQTEwg
         7cl8f3bGyMaRHRQmFg8/DrT7DPMCZChOMop0TmoNz9My3jjkCAa2PNUux/2+KrQBjp0D
         7wOIlTCLfX/Orkoiwf2EIFoBlVBSLjrp6nzcD/CApJI13fNseyDQxQgmJ4l4iPfeS1FA
         WyR7SN5SoYKnR+zz3Z0FDuQDmFL8ZaLE3RDwTUL9etUbfYA/mNoPE5Q4pkDv1gD9+75L
         k/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589840; x=1753194640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOmgKiLTp47jsfMu4jAIxpovRWBotnDPNT5k/Df0iEg=;
        b=fBaSrdKoWsOYR800gcnS7d4L52gC2VwiS/QyzYytJ6DSrplXORcRDncMbJk+nSYExs
         zJ9tQW4fdjXMiVBF0WM7pn1t3OpGPG6RGUVVukSWPBomCBgLFfAnPFAO1mpD38xY/oqL
         xm/FkzCS+qRKZrA8pit5azCWit2iDl8isAAzVKYGdAP8JW+SqK0FV3NuifMkv2phsIs/
         7EBHNJv3mtegTAbOCOFWMupchM+OCRL2lv6Ta/6eIlxxjNQuCtNkwuPvgRxSuAkpzqTd
         D81LjPSf7D/DqffH4bgBFaHf9L/P/s3OoxwY/lKR61V9D4RXnhwZPMIDSfY/YgLsMgm4
         p1HQ==
X-Gm-Message-State: AOJu0YyyBwIu9+hs/BygJvxlHkJofZt/cLgDHoKKLMXkyPR0wstBLDlO
	zDMRxvjnIZgjQk2BoPKCcb9HwXuD7AKOwk9VLoQfyoikwwmHtUWZzLzEWA1rjLnS7w==
X-Gm-Gg: ASbGncuCwVdMlVCYPV4V6ntQy91FyEhQjRDIDSBkv7TtjipJlmyHplxoaGjtExemFsF
	DTiuzrgI56K82Ss1bHJT8EtS4HTtYVgsCOWWQCjD0uU0I4M6fNZ/H+jOcxIvGynn46raoM8B0K2
	Nimul5wDscSPiEyhEYBntg1RzbpSUWR1JwTRw2wNbZA/m2brcbXAUoBGJD0Vffq4LeeUeUMENm/
	dRm+i2eemzFpQvG+OdKh4JxqfjyHKNpbobKmMHB5t57mjzeL4AJF+fbd8XcqZbmTotIWl0Ob9CK
	61bjvIcIaXz1NfWXzGsS8qhPSoPBkFZSSPmNMqu6/4RqYtT2Bv03he75rXGFXgYgx/nBBQdLpBr
	2yeeuZ9n7i1XFIr5hiBFKzH3vblCgrugj4XFMBcjxw3vjtESLeXInV+PNqiyXEw==
X-Google-Smtp-Source: AGHT+IHzGZsoN6zIDwNiVnC+SUmlID2r8sxiUKmBrvsF3j1N+ewSujxo5V7ddlzNDOanYkaVxlWXYA==
X-Received: by 2002:a05:6300:6199:b0:233:927b:3ffa with SMTP id adf61e73a8af0-236b6218d4cmr4595670637.12.1752589840344;
        Tue, 15 Jul 2025 07:30:40 -0700 (PDT)
Received: from max-MacBookPro.. (36-237-135-199.dynamic-ip.hinet.net. [36.237.135.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe5776efsm12106894a12.23.2025.07.15.07.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 07:30:39 -0700 (PDT)
From: "Meng-Shao.Liu" <sau525@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	"Meng-Shao.Liu" <sau525@gmail.com>
Subject: [PATCH 2/2] samples/kobject: make attribute_group const
Date: Tue, 15 Jul 2025 22:30:35 +0800
Message-ID: <20250715143035.27437-1-sau525@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The attr_group structures are allocated once and never modified at
runtime.  Also to match the const‑qualified parameter of
sysfs_create_group().

No functional change.

Signed-off-by: Meng-Shao.Liu <sau525@gmail.com>
---
 samples/kobject/kobject-example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/kobject/kobject-example.c b/samples/kobject/kobject-example.c
index e6d7fc18e..36d87ca0b 100644
--- a/samples/kobject/kobject-example.c
+++ b/samples/kobject/kobject-example.c
@@ -102,7 +102,7 @@ static struct attribute *attrs[] = {
  * created for the attributes with the directory being the name of the
  * attribute group.
  */
-static struct attribute_group attr_group = {
+static const struct attribute_group attr_group = {
 	.attrs = attrs,
 };
 
-- 
2.43.0



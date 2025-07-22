Return-Path: <linux-kernel+bounces-741557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1028B0E5BD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D143AFC80
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7A827A13D;
	Tue, 22 Jul 2025 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzvJU032"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804683C47B;
	Tue, 22 Jul 2025 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221049; cv=none; b=NdERWz4/VBKJudGpcNhaZWZw5IUvw/GJHVT3kq3XSKOUwHnyeOXoNSmWnDI/6pdRdPJ5krkd3Q1YvbbR9iYdUmF41RMBZiycS6llnWT9eLtE9Mu3KN8xcPGtdaP69/Kbeu2Mk9tC9wRUwb2S0wx/+NojCuzKQyz/EeGdgKbup2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221049; c=relaxed/simple;
	bh=WWjkvQy+zt/V8WkckZgTzTNj4r2yWPkgm39XaTjI3vo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=G+OMIbqoALOS4M46UC7/Hj8lnuxwEueOA3IKNJkXRcFCjpGRKIh8Ve8l+W2DNRSMPJqwk+S0HRwm7fhvQ2p61H498HEv6n2+i4LP+dfTClXfNAnEThFWsaQHLxLVfz1//ifV/NU7SskqmU39GfZM5U3G1mgDnDe4tUlSJJkhtDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzvJU032; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-704c5464aecso54747576d6.0;
        Tue, 22 Jul 2025 14:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753221045; x=1753825845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWjkvQy+zt/V8WkckZgTzTNj4r2yWPkgm39XaTjI3vo=;
        b=lzvJU03292tJOiN1PBAilpiINZjemuvxNcahmhImSvBj3ZmE/4fFtnXIuddOAY+5Ev
         c5kAchFYPqb4fY4zOR8QOJRiTXcTlVpELVi6Vr5j2aIHA1yVfq5my9kxursaVmCnzlnh
         UF70o446y+JTGy2kZBwMZmTozs7wA71zNEJxTM/YwPNSIgHExbY4aw+S9P1VCaOUFJms
         Bdsn2lDfxWP+ljgTOVsy4YuAshlT5SzJVN/PXcKxyK8Fitty7teBGS2f5XPd9ARz6fqT
         0WMWqDEzS/o3Wm4/B6GSkJFWtpG00BK7BSsvN55w3ZDtezJYvSHQeIUYV7zFt3+VNu86
         C8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221045; x=1753825845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWjkvQy+zt/V8WkckZgTzTNj4r2yWPkgm39XaTjI3vo=;
        b=gFEqH0kUXVwHy8f++wnFol0FzDQQLtBlzHo/S+dx902gt+AUN/cdf0O8h6kNtZnOpW
         fRjndOjg9eiYZfU2ITlzAIhugU8TH0zYDKMYjaccCtMXCITtDOw1SU5sufv5KiyMnshm
         jfZhKkt9kdE3Z9yvmEqF5aORBbNICZhG5rvS4wJK8a4yNnfefl1Tp/BOMv6ZCUrhRXRo
         QTtMLyZuX9fyIXfW9fsauDTu6BLts6eVb+At4lnV5ezhr4YtE9DMTePM/KoVGnanJx+V
         VyCXcOje4HHdHJ6t9fhEWVoKvQIzPcNMDjjiJOqzuTPWRTCNORuHM3ji4GaLzJjvoY0G
         zpfw==
X-Forwarded-Encrypted: i=1; AJvYcCUvzLG7PaV+JXxBy0bpwlPlnaxKz86/xcYX8eJQJ/xcFUFTSzKQQgiWbuOloLzSGw8V+zY4xzv17e8=@vger.kernel.org, AJvYcCV7lVxr1W7CfWCuTxN1153DMSur6d/0s0xXnSTWHjtwtYHL+nY2lHsvOwlnljeR1B4hHQMg1624OQvfb58U@vger.kernel.org
X-Gm-Message-State: AOJu0YzC5ZU5F2tbYSDFHPXfPaa7Q0gTFXQJJzRDOVn41seA2gaqyePy
	5iSG5uAna4mxLB1F5fqRqQTxIA/UyE6sIyBP/nhKr/vmVpaHxQFaxy6o
X-Gm-Gg: ASbGnct1lf9yvvdCvn5bBruWVP4wFkCmlnwLtnVxWKKWFfV6G425QeIM6gpURhdi3VZ
	S7Z+KkmuJA3psiDKrKVfdIEp4FA7JiaQ+GwLFbD+eVuaJF6ojdwMcRtH1s2YcMbArtiN6HBktsJ
	mCqMVA0DK0G9e4+IgwXhAFPUYsXoHxd8xnA2m/P253DWW7kLmUBrZha0KME1PTJnazxqzTWVjL6
	gFT39YH1jzTuR61kiYY0RmFemhQIXTkzCo+HeykCdNihCo6v5h7y9cidrk7inMdTJ06qQwIytI3
	AIkxRIStyKnUtiilrIGfhT1owHf486rk8hCwSrGdbbLL+qWY53nbO4oNYSeGXDOdTPqirS2piv1
	LyAjIaQfafRjaux4B3WDLs/Ig3G2BeUI=
X-Google-Smtp-Source: AGHT+IFDhqnHxTBRy1GPdqdDSRnEk75BJ2ySn+18CFZBIn/WQ46aiUFSORoPBZIl4vMQyAOptuWypg==
X-Received: by 2002:a05:6214:dcc:b0:6fa:bb26:1459 with SMTP id 6a1803df08f44-707006aa3f2mr13211856d6.7.1753221045327;
        Tue, 22 Jul 2025 14:50:45 -0700 (PDT)
Received: from Gentoo.localdomain ([37.19.198.68])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb49802efsm58722791cf.7.2025.07.22.14.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:50:44 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: corbet@lwn.net,
	unixbhaskar@gmail.com,
	hca@linux.ibm.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Doc:features: This file was missing shebang line, so added it
Date: Wed, 23 Jul 2025 03:15:57 +0530
Message-ID: <20250722214727.2350-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file was missing shebang line, so added it.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/features/list-arch.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/features/list-arch.sh b/Documentation/features/list-arch.sh
index ac8ff7f6f859..d34e5b4e8406 100755
--- a/Documentation/features/list-arch.sh
+++ b/Documentation/features/list-arch.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 #
 # Small script that visualizes the kernel feature support status
--
2.49.1



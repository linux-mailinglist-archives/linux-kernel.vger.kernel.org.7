Return-Path: <linux-kernel+bounces-740724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2802B0D854
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABC13B58A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79742E4273;
	Tue, 22 Jul 2025 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyH/lYsp"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C5E2E424E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184220; cv=none; b=ar+5RZ4lzdAdYeKlz9e3aJ8IKFinFH1MXqi4MNzlR6qEhw6N0kLzLDahdhiQluMiKPsGCKJlIhXiIoB9AuPSoulu1zepAHRXYbelDHIy/kq3SCMxjnIpuJ+vZYRRnpd6zninVdMZ7CUtnQl6TF2QSEO6EQ/0RZNffgN8Q1Ukiq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184220; c=relaxed/simple;
	bh=Q26tstH75NMC7+3UUwDRpAfMClBtqGsibmFm2NuRMds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WI738jmXf3UVEDIcgFOikF1NbLeFYkrT9JlpZSrr6v9d+i2/T/Kag2ssrCojHEnBcWOCSwKTbTQhnEXnCkW8j0e9Kijrr/YYRzpYBJv5FeS3xqXjRFtkwk9OeLYD17YEpBRT9jhjnNK2eneguD5+LkrMjMoiHNnSFpXRP3n5q3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyH/lYsp; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab93f24dc3so95106051cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753184218; x=1753789018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q26tstH75NMC7+3UUwDRpAfMClBtqGsibmFm2NuRMds=;
        b=AyH/lYsp4xy5fqB3NzfWIJp4xVUTcV23Z3j7caTQ3/eJdAb6KlgFTUL3c2YC52t4oD
         elZSBPMXF7skOrGaMrexBx02RA1X5Nv4jnEqKHUw6y4VGgtSVDwEWvOZ1GpLkdid00Am
         5uiXfm26xuNHZPymo+4zTHZ76ISexeWhk1J2c9clBEQrRL3ipNA5QbCtRehGzDAP/D+h
         5AY83ku4I5KLrwTZG/NUBwLBQzfy3YuaTb1Zr6iZJUxJ8olOyUqR17+Q2NT1V6pImhbV
         GF92bd2gRXrEUX9OZyoQCCxxSnLfSV5DAJuk+GuJusy0skUWeR5113JcsYYv53kfTKtf
         OSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184218; x=1753789018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q26tstH75NMC7+3UUwDRpAfMClBtqGsibmFm2NuRMds=;
        b=EV5O59wrtbJm/gi5KgwZz51OuMvUsq9wPnVpoba+fBmX8lTCPoCDxOlc6vFl/xPQe7
         YuWp/mpWhtl7zclfD6iodoRKFtFHASQBoBbfc+UTovpC+YyZ2+qcm6b4CO5nT+KRA7ie
         JKfw+dLXMZ9Nfvu/R2QIWj0Im/JrZJlhVzIwpo0e2mwaZFEt2pCXkqEyzU+/4DHuZbEl
         +Ij0sKmu6k2FH0UzwoSL40ub85xIMEP9LHOjoyXfth282wFp8eFc6hZGHqGbR/Jfe83j
         5wkyWd+FEXecknwvNERGGxN/HPQBUdLgWFk322CmoteiYo66qlS/NojVFwZNWGQXyzr0
         BxrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHvKbat0EWQio73Q5tFb+qcAY+6a7CYJ5T5Ee2qYAIYat3tpNg2AcxG+q5RvJeBRDDxcBiNq+YY8XDzos=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxhkajUiV9yBAdWV+1XED1hlnvJIwvHXqJGOKeqUOYCvGFIVo0
	ac8w6Vb3f50v9Ag7ontdUVy6m7ikY3ydtG3QMYar9/s2u3bv2txc5XGY
X-Gm-Gg: ASbGncsnamRjHm6TEhkMmcKNh2O8hbW1DqSSPybxghWDSHvDdF8/eIbX3bdeDlo65C1
	S49KMRePGVfGb8vy/X7PwKa+kda7IMzu2MCv2lJ83gZKK9L4o14q1ZhYKrOgctxom7vD8kLZ+z0
	1VedZSJ08Tw0kAmdTL9dthg1ZJvkpxMn5MPH9AFn/N5AHnovFBDfGqI27Q0JcYfQ601BSW1JywV
	vKjDEn5hqfv58MhzN8eue1/qZViKwk938QjTqTx2A53XUewN+wUOWoZ9wpHk7o8XXUSPhmBa9fA
	Tv8ZETHwdPyzqQTwvoXQMOLfFcrqVw6E3/luHQhPG/edbBAYLs1XIC/EdeViUJ9Sp8J5pu2ENjp
	Yn4+3wExQyUrzzp0qXUT00vcgA43yMFIHrw==
X-Google-Smtp-Source: AGHT+IG5bOJhmOvamQHDG91AJ3W0LZ897svqrJG98uT/KK0CM2bglb6dArG06TLMdml6b3jw5aLujA==
X-Received: by 2002:ac8:7d82:0:b0:4ab:62cc:971b with SMTP id d75a77b69052e-4abb2cab50amr304973031cf.17.1753184217706;
        Tue, 22 Jul 2025 04:36:57 -0700 (PDT)
Received: from Gentoo.localdomain ([191.96.227.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b25a18sm52457651cf.59.2025.07.22.04.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:36:57 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 02/11] Shebang line was missing,fixed
Date: Tue, 22 Jul 2025 16:46:58 +0530
Message-ID: <8b1848fb520f4bf101b6c7cc3b45e43e2fd2e658.1753182971.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1753182971.git.unixbhaskar@gmail.com>
References: <cover.1753182971.git.unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added the shebang line at the top of file.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/features/list-arch.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/features/list-arch.sh b/Documentation/features/list-arch.sh
index ac8ff7f6f859..e7124a4c3e8f 100755
--- a/Documentation/features/list-arch.sh
+++ b/Documentation/features/list-arch.sh
@@ -1,3 +1,5 @@
+#!/bin/sh
+
 # SPDX-License-Identifier: GPL-2.0
 #
 # Small script that visualizes the kernel feature support status
--
2.49.1



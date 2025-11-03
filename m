Return-Path: <linux-kernel+bounces-883335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF09DC2D292
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD6D3AB8D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546DE31D746;
	Mon,  3 Nov 2025 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n1XsnXQA"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E4531AF3D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186814; cv=none; b=Z3g+vPZohe5xRvsH2O1jUatboHrJFXu395Bg/yNxMOK8PNDAHUQ/Y3YPsoH5UxsXHsvKbBp3PjOeAu1DxyKX+tcvXWM4isGUqvO7pGCE5EFlaurJRSfyuOhd++kHsQPZM3Ba8/glJxxq4vbtwQYVzgtqoA+19tVA0tB97dHiaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186814; c=relaxed/simple;
	bh=ZfLqA4q+LlT4KDHK6OgFCUnnDeCp0/yqCM3z3y4ZAUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o0x4fgMXnhVv86Y04wICwNz96fuZam71hP3wBvMz1pxpREQktBQazTT3o1Tzu3BP4NEbf64t3IrxbybGS7udHGuC7X3smKkyOlzNet2M302G1+ouGFBxqnz7MSSnALdjnC321xPBbSSxwj/B20nGVSc4x4NtoPnbhSzVNNwxBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n1XsnXQA; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-429ca3e7245so1259034f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762186810; x=1762791610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dKMXNiGZfPIVH217MRjliLXTvp1YDgJjekxykL3Rm90=;
        b=n1XsnXQAt2p3nRKaN4HTnKPHWC569qA8uToA2McZM3UKZJU0HLJHpL+s8xp2ORO7CA
         tNfjzzjpxaTzkE50+HaZGP3+3uaMq9zijiAoSatK1Mm9sygV0nPCfq7e3/8M2EKMGB/A
         FaOg1dCWLFxG8+gOu5kWjq0mbTKmPWBp9SKiqMTpAzGy7TKK4adXM2MyeRH5bYo1xynV
         JxxQxMYvQ8n0KcHogckZHciVzIpkyLnj/n+74NuRjuGivON1k1qA2La6kfBPsGXnvAXG
         olqjcjyUSwRJCRswG0Wsbwj9E3lYkCS6bbAhzttyMWQ13INhBTiFPSFfU9GJTlhmZjaE
         RYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186810; x=1762791610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKMXNiGZfPIVH217MRjliLXTvp1YDgJjekxykL3Rm90=;
        b=LGSLA4HASv7s6sv12HjbzA2l0s9APUvQA1K7z0YgPJMMlPhtihJTc6OOgjrkIx8yRp
         +74BMsSGQImKcdpGt/GUJDo92/8/iOS6h9FKOQiqPTAliVijWmXcRyCFeO93MmSHuFaO
         Sqqw7RfQMic6S8+g2WzMb18vf4TgFI+A9pcMhApRVRaiQ8Vp9+FWz6ZcfFkj6i23H0kK
         F0wkMcxTlzoYSgfJzlf4MafjlioSEDfnznNKW7EzP58OcNY3A4YjpP7HHzGaaOVLHDFd
         KiBPCgGDQTv0JGLpZnTd2eMdDHVYbNAZH9qVWanE8YNc0znSQaB4QFXj2fRBReG9BGTr
         ir3g==
X-Forwarded-Encrypted: i=1; AJvYcCU9lxroZkp8BkayBNWhTvGX5nnT+naY8Ij9OjZoZ0QdEzXWRObJi9usyrVdQ2DB4yif5DOctGdTeDz2Um8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOGfoeL5wXG1BX6oIsdSOGFSZA+XNOMj46Rhuil4pqN6NkpwBn
	m3ZkpAAwlRKTQt9GXFSh2KY438CDP5k/GKW0/6mewPyLhEo+RO5VJASkWWVssFQA8HhLTtHnbn/
	C7jvvN4ODozV4+GF6ew==
X-Google-Smtp-Source: AGHT+IFC8uEzBjpjBcVhKIzQAVZ9PgWEyRrTcxIH5OA39bpirlxZf+DPWIWJ65wuyC7UfWssuMtt201eUDa8ubY=
X-Received: from wmna17.prod.google.com ([2002:a05:600c:691:b0:477:11b7:17fc])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2888:b0:3ff:d5c5:6b0d with SMTP id ffacd0b85a97d-429bd6723c1mr10520562f8f.4.1762186810296;
 Mon, 03 Nov 2025 08:20:10 -0800 (PST)
Date: Mon,  3 Nov 2025 16:19:54 +0000
In-Reply-To: <20251103161954.1351784-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103161954.1351784-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103161954.1351784-9-sidnayyar@google.com>
Subject: [PATCH v3 8/8] remove references to *_gpl sections in documentation
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com, corbet@lwn.net
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 Documentation/kbuild/modules.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
index d0703605bfa4..b3a26a36ee17 100644
--- a/Documentation/kbuild/modules.rst
+++ b/Documentation/kbuild/modules.rst
@@ -426,11 +426,12 @@ Symbols From the Kernel (vmlinux + modules)
 Version Information Formats
 ---------------------------
 
-	Exported symbols have information stored in __ksymtab or __ksymtab_gpl
-	sections. Symbol names and namespaces are stored in __ksymtab_strings,
-	using a format similar to the string table used for ELF. If
-	CONFIG_MODVERSIONS is enabled, the CRCs corresponding to exported
-	symbols will be added to the __kcrctab or __kcrctab_gpl.
+	Exported symbols have information stored in the __ksymtab and
+	__kflagstab sections. Symbol names and namespaces are stored in
+	__ksymtab_strings section, using a format similar to the string
+	table used for ELF. If CONFIG_MODVERSIONS is enabled, the CRCs
+	corresponding to exported symbols will be added to the
+	__kcrctab section.
 
 	If CONFIG_BASIC_MODVERSIONS is enabled (default with
 	CONFIG_MODVERSIONS), imported symbols will have their symbol name and
-- 
2.51.1.930.gacf6e81ea2-goog



Return-Path: <linux-kernel+bounces-740729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8823B0D85B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33779161DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B952E5B2F;
	Tue, 22 Jul 2025 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akeaaF+J"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2EB2E3B0D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184230; cv=none; b=cLsGp7UDGpRumG4yibRet/5e499EwzN+M55tFpddVXqlUo5NGUzxdmJsn1cDZDUZV3E6mMEzTem73ugGeNYEpakiCuXOlEelMBCcZ1xxXhwVqArw9btxshXEXO0iEZxbmUj/4Jk17pZ3pDxOb/0ltVYMO4e48IkPS2fq4P3f8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184230; c=relaxed/simple;
	bh=6Cvp6K0k7eb+BJEdejQdgoQu66AfYkis36iloeuqVAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aqqv3FyEsQXwOxc1nBsHmHq/GTn6+1mGuKUwOiLGF+flfGQQ3D753cqD01GmRGyEzdqgStnkk2+/2enkQufdtrr9hSVlZVn2AdEV//2QOWJEIhTT96AxJ9GJwifd2xhSI148hqJnPHz2ZY7DLluqr/bxqPvB6k30piY1g+FV+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akeaaF+J; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab554fd8fbso51204791cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753184228; x=1753789028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FV3DwGu4LyYhpsCsNNgJ0fMNAOQIFH4HJTpMC8n18is=;
        b=akeaaF+J7GPYE+YNHuIp6xFy3frXMg8F2A/7rYfToww/73BmLbvqz/9k+0wiLKJnmR
         ovhxKMC+671ipBKbChKR6+J9cO757u8S7FXKYJsAtLey7AMNCv0wCXc1SCOPHpFmAjdS
         92OEyugCNLi5A3nESGdAhFjF1+IEpa6aAAgU2vkchM0be7Dvqf+Uyxd3T1FxaBOVsGK6
         iq/tf53jGcqJ68dAMb6/IYdppZaFjGiBizZ00+PzUzvDV8EiJ5JgHm5HzN1FQYh/O4+D
         auvTLHItktHLeeX5NpMt8Qc17DcQIbkWiQpE6OWk2rptrOGO8dUsPCpiJCZujhhcydSc
         77Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184228; x=1753789028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FV3DwGu4LyYhpsCsNNgJ0fMNAOQIFH4HJTpMC8n18is=;
        b=UCfxEhNRB1cgAR/JG2qThQFTZTe5Ws+W7mvxiGYFODA86ocAv/f78vCoE+zgwLoV0d
         O/BZZWWV9wVqx+KHfUAuPTPwE6d9VQcqGNkvw7GBefJPR6bhT38HMlFV5nqUO/yo4aJY
         WdXN3O5GjcjxqNzOhbpgKXkLKcgx0c9MP7njYhGCnAnz3d+q+Hf6qy5Xx4/8wclSoozS
         Sw93NHxFQUBRHB2Hs9/Pr65dmKwrhXy+ZmQGELxxRkK7Fv3UTKSm+WBxvtM0et+isSYg
         qBWOHwEIJGywluynA6iyI3uLAlm5nbTAb4MeiE35SQKnQhFYJ3T873rubhw9MkSpde2U
         KLCg==
X-Forwarded-Encrypted: i=1; AJvYcCVtwxxzQyuZ24BU4BwmfpWOy+CrJcftqEhMRLdUJ2XFt05dfjtCqzcenFpihnADd6BB3r7X1g+qom9pC6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC7XLTF+YgRVPrGVYxKnlY4DelvzDkcKzzzk96Eu7Q2rlqdF29
	kgGCV5Whito7RA9o4liFAKCTQLc3b0FzGLjDGcifI5aOmfiFuW0q7lmjpP3IXV2aLco=
X-Gm-Gg: ASbGncspYF2wr0fWCwCXOwXmjiKuE7ApjbJH7gVtv+4udADlakljm/wejAVUg91+M3w
	HGWuaYAzcaOPA+MSuVm7tBYOjmrj0LHvJaWKR1A470w8c1lQpjFaiQGsPp7WuVMyJ2uDeDxKenv
	JcJJWFP11U4PpUeW2mS3Jl6HIzykEn1ccUlR/0zSdkKf1r+GyXwVL98eJlqrcgz6abwNeevFZg0
	azbVLgt6lPiHlMwtQlBnChBGONW12gJwgwPdRd28PNsvJv9/hBgA/gwUQddBj+Cb3y6C2KlzA5y
	UB+AXMrwbMLgCfIBqpNvBpNl4KK2IQbQNhxauicR2aa8XKKeU+j2AxctsvbTxvzNv4mJWhrWKKj
	bI+thFt+z3vdDuS6+tDz8U9nIx47TzMkIFg==
X-Google-Smtp-Source: AGHT+IGFYGxIbRNqzSc//jCytzE7BPrhlwDW8HhXclfP0GqoLFwgt3MjffmnE1u63A4aHv7pca25Zg==
X-Received: by 2002:a05:622a:8f:b0:494:9d34:fca5 with SMTP id d75a77b69052e-4ae5b75b3e9mr42781811cf.13.1753184228071;
        Tue, 22 Jul 2025 04:37:08 -0700 (PDT)
Received: from Gentoo.localdomain ([191.96.227.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b25a18sm52457651cf.59.2025.07.22.04.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:37:07 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 06/11] Shebang line was missing,fixed
Date: Tue, 22 Jul 2025 16:47:02 +0530
Message-ID: <8ec7905026e998b7985c7b2bdd8866932b93fe6a.1753182971.git.unixbhaskar@gmail.com>
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
 samples/pktgen/functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/pktgen/functions.sh b/samples/pktgen/functions.sh
index c08cefb8eb1f..2578e97e46ff 100644
--- a/samples/pktgen/functions.sh
+++ b/samples/pktgen/functions.sh
@@ -1,4 +1,4 @@
-#
+#!/bin/sh
 # Common functions used by pktgen scripts
 #  - Depending on bash 3 (or higher) syntax
 #
--
2.49.1



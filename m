Return-Path: <linux-kernel+bounces-740727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643DBB0D859
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12AC5623E2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E5D2E3AF7;
	Tue, 22 Jul 2025 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlS+1eIp"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6745B2E541F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184225; cv=none; b=k0R56rtYGI3EiSqAw0O7P8ayR4SlJGWBD4j34K4jClAwg+lmRBSWk6jcyYyhA54octXUyd1R5ZH620t3SOqgTiidashiTOInMQ4iafInCBekUBUzPN2AaT0ZlCyGT4iI8tALpf6q6U95ipGiuyf6shl6mlTOsMMxJu0PaFRHI5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184225; c=relaxed/simple;
	bh=Shqn/XMP4ZL4582amaaGflJfwe6h4OFdtn7BF/tS2mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M89+RW29Uqzh79jrMTK6v4H/qBTJ8MwZSzYtz4yvMs0zF1z+dzdxFU00pO5ov7ejTVK0MdLYISZFngvw3EqNydXkSXP49VBWmR8aDKV/GnifBceQ5nvDA0TyYMMlrMUnVKMK/Qc47BhdPCjTz+PsfpgIE7Gl01NhPxb4i/Inzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlS+1eIp; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab3d08dd53so48232371cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753184223; x=1753789023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Shqn/XMP4ZL4582amaaGflJfwe6h4OFdtn7BF/tS2mg=;
        b=HlS+1eIpyWxZLYg0ovVP0L6FWSsq/WllH0oF5xjAHueXzcfjl6eqN180yXvtls9qKc
         /5qaMlmCBvRS4F7P7JM/rfyO9nTu/pdp0G6Qe6ePLM79bYJAU7naksigaCb2fhStNAJH
         SyxqTZQA74fodWlDbz6xOaIIlkN0MNnyLNb5hRH+ksGbth6GlvkQTsiGDlwJa7gcELrO
         b0TyOTIiP1eiOk+7xdIr365F/70UMFkhJf7WU2LPYx2hy89WqPxT67XaqzOkySMkcjaO
         xSsGOEeUPLliUJV3GperilKKMHlu+Jw3x06zYq9NPVrqIJN2mgRBGtmrj5Ari19Cg7xm
         PgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184223; x=1753789023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Shqn/XMP4ZL4582amaaGflJfwe6h4OFdtn7BF/tS2mg=;
        b=vMUJQbgvlaB5ZuOLeHX+wBcSJaFQM5PHsnkzPAZcutfNLYaSWY8tRRSW17r9FRB6Dv
         1dFoiI8sAC0rBvlhJmL5vB4H5MnYN6C037qBe5jFU7OzdDBeNTXg2n6hTj3Yjk9LhXgx
         Q5iHbbf+GU0cSMQOGiosdO/Zfo01pq9saUfVUnFBsUNiOYh5jMxqFmPMYhbMwgfq8zUG
         oMyKIIYCOU3iOPBM8zy3inGIE+oCaQK2ojoztpokg8wBWAppA70lJL5HIyAJWQnY99fx
         SqySNOUTfjX5LX3bmAs/7dYKgLIbI/o6RXez/VKxMYTotZYqA232PIT7uUSiVHT+1iDd
         xovQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfDQveP9gOfvJzMz7Gp0wS033yEXktnc6nmO5ZOX2JDfRTPBdeXgnBPmmchNk3RFI5TWyWSZxAHpHtrNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqRzY6006Etu4LAHFL/kJz8v2SZrB7I3efIs/iU0Jq1ZSp8TR9
	cN65WT2Br5HE52Vw2RwaZk7+xVhwz583VmFOHIXAWz6y+8d8N8WHglDu0LPmNpm75Kc=
X-Gm-Gg: ASbGncslD0/+agWT+ta2g/mxbkMUc7/G8IzUci47pWsDvVosHdpvcurJfMIimB2BMK0
	Yoo/YYojtywp93rInnlHNGLiFcvDFijhmfQ9+eiENYDazqwgwYwwLcbiStSFCOyrenNfDILUSUD
	AFkgNYG8xgxzx2ebCzPAH/DvSz4GxXVWepIrBSgtJda6J0/E9nYfgPKO/0tw3oRFxgxkf9EkcFL
	CHsII7I3s+ZRoZSU/8yV0TLDRTfkQf0x/2KmGutZoKO2WCtERStue2B2eGZ8w/qmpxNovY6gYsJ
	4qND8zdu0Xt0qT0XXY71zrklEns5s0b5zzzPQ0+vG17SWlpBp+veOtYhmH6+0vWuqRwZ3gry1OE
	S7jcNv+gdDOQdgvGRehc03dvB8OslVsObRvQuNgyXG9La
X-Google-Smtp-Source: AGHT+IEpFU9iaX+0jyhnlL417ps3JyZKyLdHlxaEiGAKzBn/+sQm3TiL/cjCrIXMUXJuOmaLv0qjjQ==
X-Received: by 2002:a05:622a:1a9c:b0:4ab:6375:1ce8 with SMTP id d75a77b69052e-4ab93c51339mr349092191cf.10.1753184223304;
        Tue, 22 Jul 2025 04:37:03 -0700 (PDT)
Received: from Gentoo.localdomain ([191.96.227.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b25a18sm52457651cf.59.2025.07.22.04.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:37:02 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 04/11] Shebang line was missing,fixed
Date: Tue, 22 Jul 2025 16:47:00 +0530
Message-ID: <f33823176ba34268a912d1bce6ca2a4ab171df0f.1753182971.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1753182971.git.unixbhaskar@gmail.com>
References: <cover.1753182971.git.unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Added the shebang line at the top of file.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/powerpc/tools/head_check.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/tools/head_check.sh b/arch/powerpc/tools/head_check.sh
index 689907cda996..a9cd06958921 100644
--- a/arch/powerpc/tools/head_check.sh
+++ b/arch/powerpc/tools/head_check.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # Copyright © 2016 IBM Corporation

 # This program is free software; you can redistribute it and/or
--
2.49.1



Return-Path: <linux-kernel+bounces-863676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEA5BF8CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8761884FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5947E283FE6;
	Tue, 21 Oct 2025 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwfxeRLs"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B48727FB25
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079904; cv=none; b=UzsB2wKlGM1eGweAf72Kn3seBhyrZ84jQ+3rFlxc1DD+R44Pg4wBN1dY4TC5dcGU4H2feQuGDU3+q9g1Z0aDnNHTabITn1i1KEuSKTwjE29hJjnPDOM9PeYRG5xl5lGN51DLWbUqfTXLqNfwYjVMIRlZ9RiM5QW9Kahxo/bAixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079904; c=relaxed/simple;
	bh=+Y2Jj1GiO+s75T0TzpWNxFqw32RHNdRzBO5edrMZxrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ML4/EY/LY/uC+DhnaG0Wek7eW2ajpkAnn2N00U4T+cvDQ+5v+m2y4Zsg8n/viyo4V3J8QDoEiW8c+GYsZffUokwAV2HNdU5wMBW33RyD0iDWaybZak2OXvtf0E2O/2zAYeUpLKB19/P4KEZYJl1JLhldv9vWo0IwO+XGV1CQRPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwfxeRLs; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so5506776a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761079902; x=1761684702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ispyJRtg+4scBOZLQOW+pAI0FhDXiD6SPK31MSEUGxk=;
        b=lwfxeRLsGcfSKgEgvnQ9fAEhoH534sOWTPp3oYqgS+gpAM9yNB8s2RnOkLnc7/RZj1
         R+wq8fLXGyCe4NT2xxp89S5FZRnpgUP1tOoCAzeaHgdEnVSynfA8OqVok0Nnu5/53gO6
         Y072qQ0Ld3hqxoC7L9bFF156Uvtnb0gxRvwJmd5lL6xmEonx9QHSfGXllAY1zpTjq4Wc
         4N9f+6NX78dsFGpr3RZo3ew9bcESHUizwQp546eXE/na7ckuI73+fDA5+j/hLMzRafm0
         XoV4Z+RtF5EJcjyEmFqnkIrut6k0E4t2tgZ5GH6iOGVyMVXBROzfHBQ+bEs195v6yAUf
         BBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761079902; x=1761684702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ispyJRtg+4scBOZLQOW+pAI0FhDXiD6SPK31MSEUGxk=;
        b=g92X+2OIUqNH9bU2HuCoMpEhym1Onc+5qZrk09VnxFCOhZrk1FLZxhkseQIk3p8K73
         wslwIW2tJLQ15p7inB6+4y5cS2JHn7Ko1oRYB+yJ+3gvvOc9I5DyHe/z0FrXzXYqSJYi
         FRuBOspuSMoI/hckUmOrUVZb818Qu8iSawlwGVnVrB5JdT7PJFvttM1d5gJcvGfBRnS5
         hF4M0MNhdUuPzqa//o840+fRQftgPGJrJX5Lank/ypBcVvLcJCqfykDpaOr/l0JnYf2O
         TQggJThfx/zQn2KZEtYgvwIMKSSZzj+xvW+9lwxVZAghQaRIRzpSKV09RGTaTNXlp88q
         x9xA==
X-Forwarded-Encrypted: i=1; AJvYcCVEsmWdBCERM0HPqTzlU+KRxslwJfKlRSBoVgC39HG3FulkEySWisNZmBANR8406oFcsg9x+1XbjUOoaIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCqhaYUZUcnGM/y2Emw8nv4WuhiD8zNI6I+u/2sBRT7BCXEC/9
	m5t+hpMDPB67obF7AQGf7ZmsvlkvUTBRdwgE6IUmuCBqyVj2WzLNIzom
X-Gm-Gg: ASbGncspqrjx0eJRThgdtjeiNOb+li66cyxVJ6IT5AFXh6s8Fz/c0haXIN0OYs9mAUL
	2pGA5hO4v68eqyno06DEV2tz7XYtSR8sNVgW2qaGEzfYoL5t1AHAW4x8OS0qjNHF+X5/YJMA7JH
	DSBJfgytNgtpNwcoJrUrYw5MoFv1XG89hA3hZokm6/7Wogr62O46VLOf3SWhnqn6IH7fQLCx7IV
	ZiOn0Yfr1XzWyL6nG9uKne2yvS/mmtzWY613+atKKmI+GE7ttuTQOE5YRSAtJgEeoe+syolsRVA
	86K9ZfN9UgKhpil2Lh3fdlEymzlOK+bVSa5VBsa3Nep1oxNRSI0zIidGW3tnBCFDXuHN3tGsa+0
	SRS25gbS6QUMrRITPS3u7MV0blEZZB/fQlmMukXhjGfjbp0uq5TaLJ97YEx40d3uH+aLv/acccI
	Gc1g==
X-Google-Smtp-Source: AGHT+IE5cDGX7uh03rUXZxOZ+SUlEl4tKmukqRwyajWbA2vLSnL2ojw+WYxhnMeLzTY4g0skCcbpQQ==
X-Received: by 2002:a17:90a:e70d:b0:330:9c0b:5494 with SMTP id 98e67ed59e1d1-33bcf8e94f2mr23933561a91.22.1761079902401;
        Tue, 21 Oct 2025 13:51:42 -0700 (PDT)
Received: from skylark ([171.50.223.156])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e222d8668sm480048a91.0.2025.10.21.13.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:51:41 -0700 (PDT)
From: Amol Dhamale <amoldhamale1105@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sriram.g@kpit.com,
	Amol Dhamale <amoldhamale1105@gmail.com>
Subject: [PATCH 1/4] wifi: mac80211_hwsim: remove explicit initialization of statics to false
Date: Tue, 21 Oct 2025 20:50:23 +0000
Message-ID: <f7e299026eec46adcf76cc94b7f0eb9d34edcb75.1761078139.git.amoldhamale1105@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761078139.git.amoldhamale1105@gmail.com>
References: <cover.1761078139.git.amoldhamale1105@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style.

Reported by checkpatch:

ERROR: do not initialise statics to false

Signed-off-by: Amol Dhamale <amoldhamale1105@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 9f856042a67a..95582345cffc 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -53,11 +53,11 @@ static int channels = 1;
 module_param(channels, int, 0444);
 MODULE_PARM_DESC(channels, "Number of concurrent channels");
 
-static bool paged_rx = false;
+static bool paged_rx;
 module_param(paged_rx, bool, 0644);
 MODULE_PARM_DESC(paged_rx, "Use paged SKBs for RX instead of linear ones");
 
-static bool rctbl = false;
+static bool rctbl;
 module_param(rctbl, bool, 0444);
 MODULE_PARM_DESC(rctbl, "Handle rate control table");
 
-- 
2.43.0



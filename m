Return-Path: <linux-kernel+bounces-823515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFE1B86B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E391CC04B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033812DE6EE;
	Thu, 18 Sep 2025 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UKq2ug09"
Received: from mail-yb1-f226.google.com (mail-yb1-f226.google.com [209.85.219.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF642D94B4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224057; cv=none; b=g4LbyXKGXe6eBJT62++iDMKSCi1h6osBKrC6ttfKXVmdt8+ZJn9iS7rXa9MVwlG4rn8hZ1PupVuUdAMXX8Qyobs1XN38dncYs03jDOSHZFPBSu5QpW0tXxwnDxAQYIOlDHBmSq1TUNTVE3kGiZKl6lsqpTSY2tt28xwRYXUfDMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224057; c=relaxed/simple;
	bh=Y9/Ne8zaqdwA/LXEG0LconEi+zVGsXicyRVHEDgancw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Og3LKZLvQoODKbvWUMmrk64Uxeb6ktnMVPV+78xCloP6CxQLf+iNri4tsiG16ZoMfR6YbAxGPgZCuVpDvtZDnkSnPFLV4L/trsd4oMKi/VvRmv2RkLqliRPkKkhXyF6fnMwb0955R9oSlj7edJSYlhh5r/8YuSRwTUE8neqOZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UKq2ug09; arc=none smtp.client-ip=209.85.219.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yb1-f226.google.com with SMTP id 3f1490d57ef6-ea3dbcc5525so988634276.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758224053; x=1758828853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUwZ0WSYzRWLsV37Zv2zW5RoOF8gsqcC5qtG3FfYLLc=;
        b=UKq2ug09nECDKJ8qP52M5tEonD4ouB9EMtR+X7SlGgf8Q5ifu431/jNdxo/guiTZiL
         e6rcrF9vVt36B1VXSVd99J27eJpitA2CIRozfsKJfFd4dxujbtidpWvFNa27ls1jA+Rs
         63fZcd0W9kBh0DeAnKh7bvJ0i+PnBaid3V4aE2cotImXwL7AcsTG4PmF6pVBwa/tUNDy
         pAiduAQec/w+HLMGpfIj6Fyiqbjq6FuJMmHmhm1moADeopI51gClaamKT6dlwg62Bxn0
         3CwM3JLsWKmakrQn8vhJ3xRelgw+5vBpTrJl5cGOX9e1O9ZI5tGecMLTW89dS2ipHn+6
         /y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758224053; x=1758828853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUwZ0WSYzRWLsV37Zv2zW5RoOF8gsqcC5qtG3FfYLLc=;
        b=or9dWjhK6Ex5m/aWqJZjeKD9464Qtol/xwmubqvN8nv5PhK91QWfrMe6ZXbyaXKdZD
         cRcQRkZeMtL2/ZASAp+gOhh8fbC1Oqg8ns3ePU+UrtzgITmx8GjnlOQV9PBVbI4hWo27
         xkB4JBk+TGxcK0zELXTjuhOziXpgeMljpztUgRLgNzkyVCRfUyIJwjQDho1d23FrBTUw
         pc6T1/uHOa75zH5lnJjrDi0YsHhOyQUkMDe7+yjsMo0a/y8PPpI0amu/t8WnL+cwQIQT
         RJM+E3xXMih/+s819gA3xWC67JJdjn7Qlhv1VQSY4nCXRTjgx53WbgXoCzz0vRsiW/Ey
         2Frg==
X-Forwarded-Encrypted: i=1; AJvYcCVhLA7u3Xmw8EFoyoKPY0ELBhKkKzBBSY6gd4c8m1EAXmC05PDZyMB0TvcvTUDcB2ksQvG5Juo09ao6fvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC745o/z8TzU/FrXbkTauu62+hQxdimgTciIWGXVj9MZd6fJ48
	kqJx0vIHFFwT+BGiqrEc/6mG1EtbXb8NHKYNtm67UzeYmvMYGXWaDzf33qiWgwi0zUCmug3VUpW
	NvkICqvlzpiMppFb2JHMga26vG9HLoIUygesV
X-Gm-Gg: ASbGnctPgRIjXw6D4d7X0aoD6mvpiKi/zlAzOAbniBD8zlYXc953NdXKqRkRNsgDufO
	ryfGgMudnI1/RrBTEMfAChdbE20V4laIS4r9LCMFonig/E5O0qkqXjV2/TNO36xdS2mE8kCo80P
	EFhnM3teocXweg443U/nueh8YE3vT+rzaWfQjvpdsxL5m6gyGkoRwnfn4kCujsjEuevuz2C+9fj
	ZVpgDyvsjzGvFeynDXpcOgLsfFyvgL5/smILqR61IRXK45eSvwlVQDlSAq2YI0XhLQBH2b8bSmp
	Z8ovEzPX8MVr9aGtBlOMvEBWgwjEqhfeE4YD++oegn1dKsPgzZfwJW4MXX8VMm+M2RnHlYET/A=
	=
X-Google-Smtp-Source: AGHT+IFECpZeDDEGAhBtzHw6/PxcEE3TRQwhyGlv3EpuDKpWXDFvddkM3Bj/6+YKpS1VWGtiLzjjfhO9SUic
X-Received: by 2002:a05:6902:150b:b0:ea4:d1:e832 with SMTP id 3f1490d57ef6-ea8a867ea09mr636869276.42.1758224052816;
        Thu, 18 Sep 2025 12:34:12 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-ea5ce832831sm198429276.16.2025.09.18.12.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 12:34:12 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3432334049A;
	Thu, 18 Sep 2025 13:34:12 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 0452BE541CA; Thu, 18 Sep 2025 13:34:12 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Thu, 18 Sep 2025 13:34:08 -0600
Subject: [PATCH v2 2/3] selftests: ublk: kublk: add
 UBLK_F_BUF_REG_OFF_DAEMON to feat_map
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-ublk_features-v2-2-77d2a3064c15@purestorage.com>
References: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
In-Reply-To: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

When UBLK_F_BUF_REG_OFF_DAEMON was added, we missed updating kublk's
feat_map, which results in the feature being reported as "unknown." Add
UBLK_F_BUF_REG_OFF_DAEMON to feat_map to fix this.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 4e5d82f2a14a01d9e56d31126eae2e26ec718b6c..b636d40b4889d88f7d64d0e71c6f09eca17e3989 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1379,6 +1379,7 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_AUTO_BUF_REG),
 		FEAT_NAME(UBLK_F_QUIESCE),
 		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
+		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;

-- 
2.34.1



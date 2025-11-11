Return-Path: <linux-kernel+bounces-895040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F87DC4CC01
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC9F934F089
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBE52F692F;
	Tue, 11 Nov 2025 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+xJFJaB"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AC02F6190
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854342; cv=none; b=hLKzLUcMqjg+0yN5Fu0bOGdhJ1C1UcolheHo9VAZhEX/NuGlrs2qpNgRhSHrvfb9z0mNNdH/LA7BeW2WnSfMH5mlUrMQm1GbMe97h8YEa8bUPMsFB6OpE9TcN2Qkeg/KOscXI/gLrE4aKxbovsBZsPJGGDQhEQmNjza110ijT/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854342; c=relaxed/simple;
	bh=WXAUFpot/YOOxCt0RLHbf9z3/pZu8a+/URwWY7MqSXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EL0eYEPG+//nSqe8LDz4xqm/VoxAn1tw6mFRnh4PtvjFWZe4An1gj91ZTldwqi6rinmCpcAl+pQrlshhM2h5O5cVwOMDDc4hobaOddRzdY4pKRODDPtk5/DpZ4TbOp7i8WtBFKw//6QeOhBFjfnPeRlG0B2ObIBhw02PXmVaVgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+xJFJaB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477632d9326so30180785e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762854339; x=1763459139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ul8zTonMF1PfgvC0/yS4S7Zbq66IyVRp1d53PsJJrsI=;
        b=Y+xJFJaB4QmSi/LWu+WucX5+FAOU/PZ/Vfbfw8VW1LMzzshWfWE1Nwn+pyTnXzvQYm
         yB8iO2EsPmnKzdkNn6jbwGCh+1DB9nY4NDKxN03MTbmhwf0ufbUW0ApLcYJoiM7pQuLM
         OwBS1gUGVg+Wyh2C9p/NsluT7mfmd9jGgrZnwNXOqq3USXcA0yLvGItWL9akuc1ZbOBP
         fjbsDOerV42kdf+XmHwPqfQTWrUYXfUH7Qwq9X7KDp9kI+YxT6Rf74YXj5iEtUqbQzKz
         Wm088DIn9p7PdsQ/Jhj1sJ01nJ3JNLjN9Z0NuiCUlfVAX7ajxLD7cCrTeQKIioCZYt1i
         d0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854339; x=1763459139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ul8zTonMF1PfgvC0/yS4S7Zbq66IyVRp1d53PsJJrsI=;
        b=R3iATeJqtKUONwkkvtBwGCx+o6wJiF0B6jpXa+lOiakIcAcmnumXI98F01ELoC9F/A
         cbSOpYX3i082JYz+iuEWp/N6rmFVqKggc3VMrBN2xfg0Oi1aC65+lGtmHTrPrdGJQC4F
         PHRfbwgvhchFqY2lA1qh5Pj12tX/rmjsCJJx1TGZgRBoW2idgBVQ4fUAd4BK9eHBWYe3
         qZE80Fg6F8L9Eo1XFdNcBasg+RcP1SvmhzoSSr0MyIBexLOhq6Nbq0q47P8eFOJ2Ri9F
         HGtUPy3ExZvu6gEEWmSBy40zxszFT1crC17VxKZvzyB3UB2S0g02MvZ3xec9qs1vtsbj
         AwlA==
X-Forwarded-Encrypted: i=1; AJvYcCVcXJycwnpTgriT3ABGU7sd1ey/SA0rQOkwzz0d27UfUUJzAsNwdNC6N25B54NyFY0SMfJJQitKTJGwo8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWn2E1mHQA9I3rQ3GPM/d2TYAKVkLCd/CNFb1E+16ze13K7Dyg
	m01hi5aPGQBxXCx1PaXJdKwTX9t6gKUbJsaDGgUZtvOS1kPeNGCG+ACP
X-Gm-Gg: ASbGnct8pu/SKVqTJPI3p31r38RiBb6yveKD1lMOf6LBCd/de9W7SGGojbm88iHwzSU
	+ecLEPzMSJGSfndcvc1bYpcavM2CDzgBiCHt8dZUoYb9yFypnliKNlnL3G7cn/uJrx3zrkWGpG3
	+BIAYi0LuzgeglZHT3bFBszWdZLdUKtsQoEG+vwXFfti/cDGayaWLHUeie4OCxWRtjvjQvdRZRy
	g408RSa+Ek0LZGfluneUmkFJscDZHJDd2KMYNvvJJpCgfMW7rv63/VxIsqV/BYF7zYPNgp9bLv8
	4fkogL9iFFqukD3iJFqeTigQ2YBnSe6tfrl8uP3YVIfPYDOi4gySY2ZDqSYkR/5I8CRz1CDj14S
	+iVLhTcIuwPDCkRmaLJmW4iNbtQQeMdlJTGg0yBeiPdsopCHoCscf7BvJOP+0sJLCujO1OP5igk
	CNPFPfufb23trXN2H6
X-Google-Smtp-Source: AGHT+IFurLDdacYdLM4BSxhW0Qk0EwyuqedNG4+69GtPIYfgB+zhAdyM8uI7YczL2cY11kRPqkuO1w==
X-Received: by 2002:a05:600c:4f4c:b0:477:7f4a:44a8 with SMTP id 5b1f17b1804b1-4777f4a4945mr48804065e9.29.1762854339326;
        Tue, 11 Nov 2025 01:45:39 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cd45466sm359537865e9.0.2025.11.11.01.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:45:39 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: johan@kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH V2 09/10] gpib: Add gpib build menu and rule to drivers
Date: Tue, 11 Nov 2025 10:45:11 +0100
Message-ID: <20251111094512.6411-10-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111094512.6411-1-dpenkler@gmail.com>
References: <20251111094512.6411-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To complete destaging the gpib drivers add the gpib Kconfig menu and
Makefile build rule. The gpib Kconfig menu has been added just after
the related comedi drivers.

Add  sourcing of the gpib Kconfig menu to the main drivers Kconfig file.
Add the gpib build rule to the main drivers Makefile.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/Kconfig  | 2 ++
 drivers/Makefile | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 4915a63866b0..01602581b880 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -161,6 +161,8 @@ source "drivers/greybus/Kconfig"
 
 source "drivers/comedi/Kconfig"
 
+source "drivers/gpib/Kconfig"
+
 source "drivers/staging/Kconfig"
 
 source "drivers/platform/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 8e1ffa4358d5..d275b1526cdd 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -150,6 +150,7 @@ obj-$(CONFIG_VHOST_IOTLB)	+= vhost/
 obj-$(CONFIG_VHOST)		+= vhost/
 obj-$(CONFIG_GREYBUS)		+= greybus/
 obj-$(CONFIG_COMEDI)		+= comedi/
+obj-$(CONFIG_GPIB)		+= gpib/
 obj-$(CONFIG_STAGING)		+= staging/
 obj-y				+= platform/
 
-- 
2.51.2



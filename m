Return-Path: <linux-kernel+bounces-892842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5866BC45EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B67C3B7785
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CBB30EF6C;
	Mon, 10 Nov 2025 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BM7buIM+"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA4E222562
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770343; cv=none; b=RmR4b2uNgZ8iQ6R42LetBJEsjx4gTn+ajIs3Xy6cO+Grg0XLxfIHzKO0XDi8n8ymqXqSFpWNbuNfWNaIYh/HGqdRFILqzhY0m+wN3t9VsgSPGT9PSguG+lj9ObNQxnLmtfoNiRPpIKGWpApjTBPv/Evc9Q6y7REQbs2nJxcLvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770343; c=relaxed/simple;
	bh=Frd8hw4dYLxqNXW8oZMU3F/+0VvHIFZEWTqp90N9D5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJpTpgfLFzujUzcRpT81vUz3oJjboyk/PadImD/An+EuqN7bP+3WEIzzP6jexSaKsFsd+zYtekLYfdz2q3xuBh3fDc/d2Id5afVKmcjNt19rPkuiCSOiVMx8WFk/75H4nJwJJDDYgsIf3Eigz8lD7tt/FOzprN3zLvJ1hvuSzSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BM7buIM+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4777707a7c2so10198025e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762770340; x=1763375140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytGXTNjC8Z5iSUdVMoFae3EHPD5igwJPE1XmSPrltk0=;
        b=BM7buIM+eC05nlSLHIsxjvUBap3eOlzIpKXdhedg6UWEPGqTlbDTRlPy25e13IvAfj
         /o3ufrFUNGP6EJkKcy8suQjLhVHTUvD9ze5TPdeP7wS4xZN1U8xaP2tHWMyhZYXxgwZZ
         ji+3RFpcsisrpctYduaMX0PUrO8I6G0nGTauk5xAD9WqvLP1y5SvmAyBmHRW+5fntlFl
         T/SUV4VDk6tdMq+v17tYUHhyanFNosjoWGrjhtPgGePB7uvUAzeyb37EKQWLPyTPt3nO
         KZ649PtpX/fp9eTA2h2od3NEidYQwf85x/EaNUVfPQQFImAF55CPyw/w/yaPNmvPjPgb
         sPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770340; x=1763375140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ytGXTNjC8Z5iSUdVMoFae3EHPD5igwJPE1XmSPrltk0=;
        b=gX835NHvR/CzBjraugAelYuX1O8MW0K7e+0cEZhR8Z2XBkiSGB0IozzPrjjmhj+nER
         41GJjePCWq0MDF8T6KD15cNzmaFb5FM0TI3ZMQ6zWi0uiNaUsR8i+DNn5W8yLtcqYxhv
         BNOixivROpE6KaA1A2Hv4aQWj/z7Q3+y9SpDSUkYAD7Amuwh3Z+MQptUXWLflWg+CJAe
         k8eZF8j6K98fNB8bTqQqRDduDsZenh7QjPMiZAv5HUk9B9+Ah6jWBYPQHGn2uxWuY7Qi
         rEgEPpbk5qjA15xZPoEpPGzzxeSZVK2u6CPhpe+37loeFbKdZGXagltnvwfub0zBQ+nt
         dOcw==
X-Forwarded-Encrypted: i=1; AJvYcCWep0I689jgSFg1SHpQ8A2QPQdA3Uh4JZ40fO+RsdCvuyR2i/MPmesLhYCS+heb6WWh1YsCIT3zlq1Y2g4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8jr+yTm1s/h+DSF9ts6JoZlOmSyo+8azmt93pkZwwS4BPBNIH
	Yf23yQYV+zlyCrihDQa4ULZHYJuBhFbjUZ8VcIbSehLs2AM0Jb6KIjSrfq3NgNCK
X-Gm-Gg: ASbGnctVnjcJlo96hZE5DWWJ9ht9BCxVINzjWpnkOneS/0Tph3eFHXUZmMZT9PMh9J7
	fts9FAbuxyOXypJJACxn2AReK2N4bj2R8nJ0C9i8Xd1K3mP1Tss1Q2+lnEVzzKcKPsw/ZyxU2eA
	sZpcLkS+Pc5Y9QHdypfO9KiDqI3hVUhMBqkMw9FY6hA/Q0kzgx+83uTDhpeDs+Tk5wJLu/PSllc
	cpN3zScYTZlX/Zxh6o5E/6sFVXC6O7gwfv5rhd3RTm6yMCQ+tPeWDZU5wwEtmP4HNajWL9/Nbqf
	yjbZSXSgM4YyKvEyCBASJIvhsqcmO0IhLSLo4NAX0m4ljE3efQTrAW9YBjRofueksGZAiWzi6iN
	LN8ba5mn4mbrAGim+YgaXIuPWAG8m5BKxj6LGDfYkpgeOBjJ6aYe5QpEN9C73Q1FPDbZKVW5kfG
	eMuLZvvys4siky0fD9
X-Google-Smtp-Source: AGHT+IGs5K6nIRJvSlRanofUly7s8XfcPvPm6T/Xv6CDWDlt5Y8NVKkMCch7JYaVka+0Jp7Du4nnrw==
X-Received: by 2002:a05:600c:34cd:b0:477:5639:ff66 with SMTP id 5b1f17b1804b1-4776dcbfed3mr90862785e9.13.1762770339837;
        Mon, 10 Nov 2025 02:25:39 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777a96e7f8sm67326715e9.13.2025.11.10.02.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:25:39 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 11/11] gpib: Add build rule for gpib to Makefile
Date: Mon, 10 Nov 2025 11:25:07 +0100
Message-ID: <20251110102507.1445-12-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110102507.1445-1-dpenkler@gmail.com>
References: <20251110102507.1445-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of the destaging of the gpib drivers we need to add the
gpib rule to the main drivers Makefile.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/Makefile | 1 +
 1 file changed, 1 insertion(+)

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



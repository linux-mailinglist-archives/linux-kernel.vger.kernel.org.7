Return-Path: <linux-kernel+bounces-762770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0CAB20ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12AC18C146B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69B2218599;
	Mon, 11 Aug 2025 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrC7r+vf"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0631A1E492D;
	Mon, 11 Aug 2025 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920300; cv=none; b=cj8AUTDkwWMH0fIvgNMIAPpe56+/iXi6GOdmXu/lTdCpcMifSC1J8r+wtsZ6uOdzWTxvloaVnQcPecUgt8/BeWhZFqK6sziy1YtbScHPRmdPk08UiYLNM3jkkAHTJlHBOtVqG/yW2pIPnZm+iLQW1Ook/81OCK7F+JImxrRpLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920300; c=relaxed/simple;
	bh=WsW9yxxkWE67nB6JIFQv5v8viYACQD+qfWrPx8gpdkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S0oZpIek9fNZes62J24xo6MDinPhu1oMHnRREmq6A2JKXgMMldWwrrZRwum3zWxxcxnTjUlB73almzdejpHif3Bu6E09cGSnR6q5LQDRTZXi1MejrJzq3iLZPMe/U504MI4v0lt+4Z3LcpPqRDtk5qw9tnLfqukgjcKqABft+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrC7r+vf; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4209a0d426so4383240a12.1;
        Mon, 11 Aug 2025 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920297; x=1755525097; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lD/WrxSX1/EFla87ahcJA+QqQVIM1RkgY0PCe9xlzK0=;
        b=OrC7r+vfkCxT6jkX7Km2bFBxqufO2+DdZriUoMsg01DMzq1He5HRo18hWLnfnATfR/
         C1WpPVt5IDTYERsvf9PgVuoDCNTzHJimQrZX6yQ7RGkEUhsuLuUN/Vg3h/O0qd3L5dVS
         G6NP4dbI1m9HCOm8Ba8cBaFPhpzQXx0ytnyQOCZACC1DDaTm0UU6OtaD/tdsqkeObp+v
         S+Vc8iMcgs68ACWer1bi/tSyq/kBpGMkPyZPzPK1rChrKMIejptr3joaoSPXEwyUoptG
         qUGHnbPgORUerykm3Louj9KCdObqsF9u9UU/WhSOklJdJF/57kgYGNyAQ9CkUWGZ4x2v
         ikxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920297; x=1755525097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lD/WrxSX1/EFla87ahcJA+QqQVIM1RkgY0PCe9xlzK0=;
        b=ipy5nl04B46nRTPh87UtuhqaAFGf1Dj5DR2RGIIHPyJivEsDDTaDC6yDcQrYMAhXoV
         ajksegOGV/D+C/6ghrJItM1YUtmD4zB7ujtURDP1SVkPzsGUeQh5kaBrKFI8NDFo3Zgq
         PDZ5gGx37SKYxGTkYJl1rzF5DNfKKSeSsuSvkDMDlO3/f6XwQ3s6EgVk+2LEwrw0yaeM
         cR7CvgMbkrgoz6IYBt/9LjxzsXmYayzFjDU/ppa90wSEjYq3lv96MC96ZPEtvxPvkLS/
         vZKaa84y0Y1d2GnChkERimmvLrnWnxijXOZuaBpmfxgmqA3XYE2EzRglF1YpXdIRHNvx
         8SAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl0Wa9Xzzhl3mfK31QVX3EuXrnpwZQ3PDwSLAhlpFczzSpP3n6E9J/wJS6T/5F75mkMHbaeHXB4gQJAx3R@vger.kernel.org, AJvYcCXUzUJUFsW9ae986wGHEbhDU0cC81of+K75jzPEX48TYgYbao08iCRyi/coB41EbJSMupuzBgM7Cun+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Yil3mhDzFE0PrOTvXLyJEp9ngc2K541zfKHrWZBcWPH3pHlo
	4UXZbX1+imWv29e/KyFnm9H5h3BJDOwqVh9WlxTemPZ8TAdbpGJH0PDI
X-Gm-Gg: ASbGncuoG39OLL9IC7SeZC8dceP4DKMZNcNc0l4Q+LIr40DDlHmHngdb62oImEvKC0H
	yoBZ1L7AMdEGMHufbD/XY1hYxWZk0JaoaT/R91G8wvSRmliDufHNQdvqztTsLjd4U98mSzGcWhM
	K5+QPz/ocOGSWK+TL4QHSHwtmHBEtkdmxlwNbw/ig6gJttg/7IKeOs+/xh/3B5ALhZEfTYE5QqF
	C67v83KlZY0o64/C+rM7JSgDv/SgaXQlgsQPNlD0VZivXJZFp1kjAbelrpMgwMOqw2rvnyfqibQ
	voFAdGp14sP4eszUueYahCyiORCBjH9qCm7aYS+vPNoHl7HHHW+DyJswi5jBYtM1aAFWRZrS1jf
	for1bLhQEsBeXm8DD491bIXV/oGOycZnNjZTyYMHEH3P+ZKA=
X-Google-Smtp-Source: AGHT+IH9KDpx03ywNJvdLzBAfBlJLI4oeKmVAO5UR+drZaqVUoplxQq1MfoVtn8zvLDNwTwHUy4OvQ==
X-Received: by 2002:a17:90b:3c49:b0:321:75c1:65b2 with SMTP id 98e67ed59e1d1-32183b45760mr23917637a91.18.1754920297041;
        Mon, 11 Aug 2025 06:51:37 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm23504993a12.15.2025.08.11.06.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:36 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:50:55 +0800
Subject: [PATCH 3/9] dt-bindings: iommu: apple,sart: Add Apple A11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-nvme-v1-3-ef9c200e74a7@gmail.com>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
In-Reply-To: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=776; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=WsW9yxxkWE67nB6JIFQv5v8viYACQD+qfWrPx8gpdkA=;
 b=kA0DAAoBAcoIt6bFCCQByyZiAGiZ9VCgpq+sLCPb6h7skrPDQfu6PKhvLP5vmejwncunolc9M
 IkCMwQAAQoAHRYhBEtSeHhcl6z3nDxogwHKCLemxQgkBQJomfVQAAoJEAHKCLemxQgkx/AQAJyL
 UoiKJly1Puh26oQIp/eE1rItZVtYiLLcwoNLwy26TFIVgQpbz6CwutVT7YMNMFjKRGST/KXTVUG
 nNOAq9f+JPjb0vKn35FO3X2RTUudGt5tBsN7gP1WAuHwL50pVLUpwlr5mOmUEnPoxECo3su4Gpl
 u6D2Q+RHjZKv4m8wH223Xlww9RFi7gOYF1LDYJg0Ijn2n6NsoFB8NnSGyN4R3exhrXw3s5ByJBt
 MPiEHWglVMs29eju0clMKjW9fk8/3C/7UP+rJ00B0z7tbymKxWlf7joJREw8NY9k8DMow8DkL6e
 VXRkVr7XloyJiCxp7K3knbiafjV305yNWNHCFKyBPdySFHfSdGdac2y30TXDK2t02z0vQyE3ily
 7jGglW73k7b+fiU7tn89oiTUbdh9u4JbjrXLYuLejcmBZRpUyY4D4K+HX0mDeGy1NxIMG19xZRn
 7g8sNiuG4nsROjMUz4hvB6p8FxHhHtT9AFVtEwYn1sbtvrZSiLTKKt4PrVyP4C3OWUlkOFwFAoR
 RhLj/kT8mq0Knaubp168KQbr7/vRLh2CvOu5/HVVjNsR9hRT4u3udves1TxU/nW8kKzsc/YFt0p
 TTYNHDSVKn/R+NaPaAVYFQqZOwMjKMB9LHIgLvQsqLD9rgK8AaxdU7MR0iKg7wjOvLYTGfAXd3H
 cYc+Y
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add bindings for SARTv0 as found on Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/iommu/apple,sart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
index e87c1520fea60a2de549aa8a469fcded52e3b6e3..95d55ec688779bd52b8aef316a4c1ba7b7449574 100644
--- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -29,6 +29,7 @@ description:
 properties:
   compatible:
     oneOf:
+      - const: apple,t8015-sart
       - items:
           - const: apple,t8112-sart
           - const: apple,t6000-sart

-- 
2.50.1



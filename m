Return-Path: <linux-kernel+bounces-822880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C27B84E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A1317C9C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB88C30C0E1;
	Thu, 18 Sep 2025 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7Nu7+M+"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969F227726
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202784; cv=none; b=FsF0SHHJU7QcyP5KB8rymDZjOjdWyBbh4UUbkqmHQ72G90kj0cIlDBl/5YilPItT3whEZZUV+zm5HxxGWSRtIymnTqqSwoVgYmj/DP655829oWBU0sV3UDIxGaVHbV39IWuJRb6FU4CyOiuNAcqT0ZJgzhHieAMBVejYGfAQsX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202784; c=relaxed/simple;
	bh=4rLphEJ6YvxKj4o8BjzsZ9DbEkhXdVlfjx5rT4PWp7A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=njeQpYigPeJAx/UkkZaOGJhi8ivzCEifcrmaQ1PROVsVvUllXW98yjWBxu9xJmZSZFn3dorXlohcg0eUVRmNU1QGdw9LW79BRfMiyJZD2UMHVxIqh6+SPWQY1mtIkRe1JVAQL83LmwE3rmaeHWPltilGK+WlQu1CnxMm+8c3fTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7Nu7+M+; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ea1550f175so457891f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758202781; x=1758807581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tUzq6R01ElS3HTtPgWbGCVntoOFzLPZgUEcAtjf6XjI=;
        b=i7Nu7+M+A1/5T/JVUG8tYpFnHFRsKmiTu7nwa0cgfhgy4IxBpjeL4UsLy5QcgxplJR
         6xppwd/xAexhp+SGA9BdLiyMT78x8zGKop9ja1BBRSEUYhOl25JmdISggxMUrUGV9DN3
         KhyTFTrUItwvkH7CxldoG1T8kY47P0P/uiBDAF76DeGrpIrVYK8B+FRQI4hXcHH3XoDv
         RCXD43cFxXBRC8HJIXeTYs5xd1KHwhsScTu97frY+R0dJotzvmNl2Bx8e+ls1oByJHub
         0ji0w+rH61qH9E1GTvQRhcezMh8jfIIidVTCOGIQmhgMfuigEhZ9cqzBh/orDCzDIIrm
         wRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202781; x=1758807581;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUzq6R01ElS3HTtPgWbGCVntoOFzLPZgUEcAtjf6XjI=;
        b=h9K1SwJtskeCHYvX0VflJ0VUSAPbL9a8JeqGU30Fq1qsbFVMvoxV1sUHUkCwUpUVvP
         5g7LlY7nwbS4afOuKCAxnqvERdF7X6OlLaxXs+RrOD40u3qx1PlZD27ecG2iJl4+rgeY
         eYiy93StX04Wvrk0JIuvhzTElxHpeCdP7sS5S8LD0INp+/oAW0sDCO1r32TsAXQqdFc2
         A/78hDBTDPfZTbGrqDMjsmzOuzX4VyQGOkQ7CUVflgr/X9/iJdfZF6Lduo32ht4WjJ2r
         eK1BirAheL9cp9e88bM6VK7UBwA+KhhZIJ1bWb1XeBI9n5rnGRqn6+ndj5pAIw+jk+rw
         cAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUzQyAe5K1eKkdMdMItVA964QpnsNf3+OGf407kwlu8uEuVuDKEE8JdgTrKlCvoNSOJd1HY47sO8Wq1cs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+PhVgyXG/ghcMD93rQG0FEtd8aoZxUQieHVL6buILnvMCt2kN
	S3caQRM0w/QLlpq+iAF7Y9uOnQanDqJy2bz1Q33nXLtbofP9zEaw7/zg6csO/WlbuP8snGSx+5j
	yFfuivJRRbA==
X-Google-Smtp-Source: AGHT+IGWxG6hISC0ORtquXM/3e4vi2Estl7X1QwWr/Te+zHdg/OoFRVEgRPbtrHH15/DM9LG0wWbYwrjqY53
X-Received: from wmrn43.prod.google.com ([2002:a05:600c:502b:b0:45d:eb3b:54a0])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:430b:b0:3ea:6680:8fa1
 with SMTP id ffacd0b85a97d-3ecdf9b88c5mr5717322f8f.12.1758202780959; Thu, 18
 Sep 2025 06:39:40 -0700 (PDT)
Date: Thu, 18 Sep 2025 13:39:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250918133937.268948-1-abarnas@google.com>
Subject: [PATCH] hwtracing: intel_th: make intel_th_bus const
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Because driver core can properly handle constant struct bus_type,
move the intel_th_bus to be a constant structure as well, placing it into
read-only memory which can not be modified at runtime.

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 drivers/hwtracing/intel_th/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th=
/core.c
index 47d9e6c3bac0..ba7c8b184cbc 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -166,7 +166,7 @@ static void intel_th_remove(struct device *dev)
 	pm_runtime_enable(dev);
 }
=20
-static struct bus_type intel_th_bus =3D {
+static const struct bus_type intel_th_bus =3D {
 	.name		=3D "intel_th",
 	.match		=3D intel_th_match,
 	.probe		=3D intel_th_probe,
--=20
2.51.0.470.ga7dc726c21-goog



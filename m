Return-Path: <linux-kernel+bounces-822980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C383FB85390
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20845188B902
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDF6221557;
	Thu, 18 Sep 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVMpMRyM"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB41A5BBC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204999; cv=none; b=HnNwlhtfdGO2gOjNyyti+Hk7W+f77bxcOa0xecpNyFjy5ivBv8h+E10lTSpjOfNSTtFDNHSz0wkMRr7miuVBB/bbkidDAa7raIT7zPvgRAOTHqLBSkfAVuy7Mfc5ZxEbyZkMY9hdu5oPAttM1dHwqKwbPV/CsACXXzH36tqSPSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204999; c=relaxed/simple;
	bh=W03uBm9xWwcUmzFy0U9fwZoTKm883Iab30MWpbBy8ag=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SQXM34fsio7zwnSIVodjXLPW9WxyUdR0VdqfJKcan2WQ5bG1PftKQEbKT4Km+NPv2k/kYKjYXWJ7IZG+V/c5DrgQ7JMdsneOAfXTVrPxFnyzL3Ra/2RmiwOIctRCRTXEwhyKMD8crRNB90hzCIonvzj2zwxHDXBTqUER9QTTmaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pVMpMRyM; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45dd66e1971so9825545e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758204996; x=1758809796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4VpmXSIu+qpJvsDpO1PV+NUaPdBqqdiEw/vU8U+iM14=;
        b=pVMpMRyMX/K7R8p+A9Eft/SOCA0xJYBahm8vseIc0pvXBoI4Mj9bBK5qzMJiIvkE3V
         /uLRSkgec6CpZi1zfHIteRBdO5lnCjMKH85p9hFXR1kCYIzw6EML16f9EeQz5eo/CN23
         9v325WRl3GHReAx1PDsVxfsmQGSj2ZzAUxO6oytoDK+ILuJhmrcdw5vAH21FrB+As/kB
         Hn5/TsivqNA5sz8Zi6GYpXrGEZNSqpNeVM/f65wov0FwVfZfcYJaLf25uFNupFhr5GG+
         3HpjqMmv94mppsKr3UPqD79ZsRrPrjgbPwS9nZcxyJMWAPllSo4MoZ8/xjX5QWTkzp3o
         GGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204996; x=1758809796;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VpmXSIu+qpJvsDpO1PV+NUaPdBqqdiEw/vU8U+iM14=;
        b=Aqb5s4rN/ROSMPjRGYSZU1GXm7ULw6tUx/oEOZJvm48gGfgUmZYuxD8pUhDYKYEUvG
         ehhMVQ8ao34U/Az25UtxmsmtiBVUNHmcXr4noUI5jdyJMQDRiJ/lKTeq0tjuMzkM0kBv
         aVH1lEOm14qPtRILPl/ZkdWrsjKCJXfXTVWouUx8SG5mNMlfOCfiWzS/EX0f306NCzi6
         vdp1LKoyA7FhRdjxrsRWAWJT2CtJ93AH5MDPcPmlIpRPTKGMfoQs9u4wQ12UjOj98g62
         MoHxmOe+G7IZ4MdKv2WZX44Px2EW/9K2b61Lghi0wzEkcHHSbgrs+suUNGXlO2aeYGx7
         xv2A==
X-Forwarded-Encrypted: i=1; AJvYcCW/JboKYNWAipspnW5vTJdbtJVScfFZ6f+5+RS4x+bxxly8QxFszjF+T9S8BZhHPzea2dx+kFSufwRs7cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSSmxjDdRRS+tIcTOk+08M/76b5PW1I/UO3JrL5oM1watJyfih
	IAPKltHXUPjLE/+etxvJB93X1lvJfVEQ7fzUYIC+OjzWxIqT8T+qAC7lvnhQr2F7mIpRboAd2sj
	Fr5eO1Htjfg==
X-Google-Smtp-Source: AGHT+IFG/CG36IeKleqVuSqLctsPfpA2xFgjVVKw4opNjMh9ri6iTo2cGwDFZ3VXvHE8Jmqqc1cSa0C77UST
X-Received: from wmoi20.prod.google.com ([2002:a05:600c:4814:b0:459:d8e5:ae9d])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e93:b0:45f:2d21:cb36
 with SMTP id 5b1f17b1804b1-462074c576amr50115025e9.35.1758204996093; Thu, 18
 Sep 2025 07:16:36 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:16:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250918141633.339803-1-abarnas@google.com>
Subject: [PATCH] powerpc: cell: make spu_subsys const
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Because driver core can properly handle constant struct bus_type,
move the spu_subsys to be a constant structure as well, placing it into
read-only memory which can not be modified at runtime.

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 arch/powerpc/platforms/cell/spu_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platform=
s/cell/spu_base.c
index 2c07387201d0..733b512992c0 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -464,7 +464,7 @@ void spu_init_channels(struct spu *spu)
 }
 EXPORT_SYMBOL_GPL(spu_init_channels);
=20
-static struct bus_type spu_subsys =3D {
+static const struct bus_type spu_subsys =3D {
 	.name =3D "spu",
 	.dev_name =3D "spu",
 };
--=20
2.51.0.470.ga7dc726c21-goog



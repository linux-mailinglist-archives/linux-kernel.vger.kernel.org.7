Return-Path: <linux-kernel+bounces-761152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C220B1F500
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 16:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EE962773E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F328C2BE04F;
	Sat,  9 Aug 2025 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GVsHEoD0"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C0E2BD03C
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754750695; cv=none; b=u1KM+fnf5IVoS1B+K2fhn+7UNKMw1DT7YBxTGhov0OSsL0/diHVKjkcY7zOKW67OZSZoMmB9oA69q9J1Nn3aQxUIibOtKSyiCKUxxEkNTNNarg2+vOKKkJ73T7I6aq72xA8WAqtJTGoJjXhxVs11h0TLX5pic5SgQ1sDCypYAn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754750695; c=relaxed/simple;
	bh=//K7yi03aIfeehIyo3o5++11x5/89R6GKKbqCb302vE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ky8lu/cQixhtP25f60GZXQWLrFsq/u5zXUSCV7UgP1MvrbvuwEfoBFOqbOSaVOruDDFJX1JiEH8G+9Fj2QtLMjqfwCNel1pUiXEp3uWN1i69UQ09nzWszj/D/WU8iO66x+NhUd0by8DD/trQD6zMroImXjhLH+IHRqTYafHE/V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GVsHEoD0; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b79bdc9a7dso1769424f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 07:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754750691; x=1755355491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=62tWEcOig/dfSmII8+B6nS0fppI/7HUrUbyrKzGRZQQ=;
        b=GVsHEoD0eJ7Av15RYbiCF/4IaKH8vxee1OPlxxBLx4aMpfPi6673S928/Yb4MQJaev
         a/0xiqrJCqlXcJASYbVic8u2bvLJk7Hv7abJ/txFfK19I6Yre/KIZbIRd2vzRxZY6UsU
         l9cArTYjlq4Rz4FqM1T//27ThUf/hTVZA+1l+GbMOFyhVMiQ4FQYDZt4KVPgMaUX626H
         j5rRYFVh0BmEulqw07qpugzDeSVh2mhwoIZt7CSTwEb6hFEiH7jlNc6kVXSzqzq31tei
         8uT8WsNPKyPBiFNe1B1LAaLQQRXab67tHORPiczCqV2rXlp4VERj2YIADHq4pgDNWepd
         SFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754750691; x=1755355491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62tWEcOig/dfSmII8+B6nS0fppI/7HUrUbyrKzGRZQQ=;
        b=fSVPasuGbdrJQDfpGP5tO7QVT7p55uXL6Z9ilR7GmRMylM5ehip19KRFd2sVxdu8f/
         et+bz1OBTd4rkJsTtLjr4kGoSuqjQOhfeMLi5gQB2FAyZmVMbf8xxxKgSjKLft85heGX
         7ebFam3g9E03skZdk19T90c5yp3nKJx5qa64rTjg2OJVhm/Q9+ngDsjCelgBxrLz5wlm
         +DmPm2s1FSjRsMl3AdgvARRpwjs34D/ppEJ15jMIgFzyJKfBtW7AgGP7F+mqbr8p+siq
         +6gF1QN29yOov9DExuCLIQOGXmVaakX3JhlSVpP1NdYEs4+vz4rq0iu+KFwjLqIwVxY0
         C2jA==
X-Forwarded-Encrypted: i=1; AJvYcCWA+oxazc6FbcorYVRKjGN0WZqnncRHxU+H3tAj2ZTkNDmgvJt6EpDePam5HmYFs7wxL0TDnJJjNOglD4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT0FP8+I8VXFtF9X1ufA61IiOwj7cZVg7hDFboFPHcQBStX+oU
	TL7FzDY2rHATU0RbAO0m084aGm22Of3meOyxf/RfFJmt5WfR1LxHE4naU/BR5ue8TLQ=
X-Gm-Gg: ASbGnctdGisArYSC1sPQuzokVw2O65e21Uf7+KJA0Mo3NylCGLn+K+S7Jp4mAdzVEfM
	KbVsO+OLWcTynMrpzOv3wSmIbOnJF3kkgRcUnzg/rzYQrsJoxmhtGdYHExArA0E4Xpg7Po1zTvC
	bcBhF7lQIHtz/YMKz1vCjExrgQe09y1muti99HynOUBuwW3J0o8u9TcvoQNti+oK21GXF3g2Pzt
	TC925eGC0rae/Jroauesp5+HRlms0XpTo7xikRTdownKLAw7DjudlrSgtxHiHx+B8cJFF73KFpF
	/b28vYRxAgyOtHRAa90yLXBZJvW/CxuNU2w5466F2HGBNsc2E3oo99Eb+vqhBUJ+CG2GtjaxCW6
	BjKamIq+eE3MNGdvpNmm61gbG0/mXHn3+uGK+/7Td5MAJR7jFbDrh
X-Google-Smtp-Source: AGHT+IF+KfnqXJwt6SMkli7edNPF5N9xOPj99QcqBfM5xO8yk0mX48AaSZy6q2XkBgGjZ3eq5eqZsQ==
X-Received: by 2002:a05:6000:2302:b0:3b7:9c35:bb7 with SMTP id ffacd0b85a97d-3b900b7bd51mr5308863f8f.46.1754750690938;
        Sat, 09 Aug 2025 07:44:50 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453333sm35314164f8f.45.2025.08.09.07.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 07:44:50 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: marek.vasut+renesas@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	namcao@linutronix.de,
	tglx@linutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] PCI: rcar-host: Use proper IRQ domain
Date: Sat,  9 Aug 2025 17:44:47 +0300
Message-ID: <20250809144447.3939284-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Starting with commit dd26c1a23fd5 ("PCI: rcar-host: Switch to
msi_create_parent_irq_domain()"), the MSI parent IRQ domain is NULL because
the object of type struct irq_domain_info passed to:

msi_create_parent_irq_domain() ->
  irq_domain_instantiate()() ->
    __irq_domain_instantiate()

has no reference to the parent IRQ domain. Using msi->domain->parent as an
argument for generic_handle_domain_irq() leads to a "Unable to handle
kernel NULL pointer dereference at virtual address" error.

This error was identified while switching the upcoming RZ/G3S PCIe host
controller driver to msi_create_parent_irq_domain() (which was using a
similar pattern to handle MSIs (see link section)), but it was not tested
on hardware using the pcie-rcar-host controller driver due to lack of
hardware.

Link: https://lore.kernel.org/all/20250704161410.3931884-6-claudiu.beznea.uj@bp.renesas.com/
Fixes: dd26c1a23fd5 ("PCI: rcar-host: Switch to msi_create_parent_irq_domain()")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rcar-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index fe288fd770c4..4780e0109e58 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -584,7 +584,7 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 		unsigned int index = find_first_bit(&reg, 32);
 		int ret;
 
-		ret = generic_handle_domain_irq(msi->domain->parent, index);
+		ret = generic_handle_domain_irq(msi->domain, index);
 		if (ret) {
 			/* Unknown MSI, just clear it */
 			dev_dbg(dev, "unexpected MSI\n");
-- 
2.43.0



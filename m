Return-Path: <linux-kernel+bounces-726043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D236B00770
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742165C664C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC8C275AE3;
	Thu, 10 Jul 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGTNZfE1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2069274B5B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161941; cv=none; b=LTEvBrMJ7vhk50Be4+kuG2Lgp3By6P82ta+riMN9AgM3jDc1uhkiDeLnM268e4u2IgGYAK9KUbexFWX0u8EG2L6oadhjbkHofQvwXriN4HLQPjP7N0K0mSHTwu2KlXaTdsb9pbdmPVDw3R5zxNfxf2ixO34viWyc6LNEoBNo3t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161941; c=relaxed/simple;
	bh=sUBXa/zWwaQzbhA0N6nb1S2bsUryZEA7feCyfqq6jYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iKZfyk2ZPDOg9Qr1hrldLXFDF+67Mea3xYmSKzFsBl9+IDcEan4toT30vyYAwhO5yldEyir/6o+uVI170KGhW6iM0Z4+KY1Bv1a+gVpNvAWJrCpASva2rseehoknE0P28sjK1StZtTgxHqmwAFm++EsShv1zydiW27QkOVGIW3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGTNZfE1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752161938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/T2L82m7V5flBWy6808ID7BDGk0wf80Tfn350KAWLes=;
	b=FGTNZfE1b+2ig9k0wgZpyYJoEQp5ous1XdMihjIJrrH03wNj7HiYcJCy/JFdOh8pm5haMb
	qjsxjbf2NIV470tNEpa4RaygRb4Lt/7qdcFUrmiQ1cYPtnLCXMN25V4T8qGa5qaMmNbNwM
	F2rNmAVvfsAFnFHm92UpP2etGyKK4gI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-DH2wY0oyP7ytUDyXHdPGCg-1; Thu,
 10 Jul 2025 11:38:55 -0400
X-MC-Unique: DH2wY0oyP7ytUDyXHdPGCg-1
X-Mimecast-MFC-AGG-ID: DH2wY0oyP7ytUDyXHdPGCg_1752161934
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F4451801216;
	Thu, 10 Jul 2025 15:38:53 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.211])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C36901956094;
	Thu, 10 Jul 2025 15:38:49 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next 0/5] dpll: zl3073x: Add misc features
Date: Thu, 10 Jul 2025 17:38:43 +0200
Message-ID: <20250710153848.928531-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add several new features missing in initial submission:

* Embedded sync for both pin types
* Phase offset reporting for connected input pin
* Selectable phase offset monitoring (aka all inputs phase monitor)
* Phase adjustments for both pin types
* Fractional frequency offset reporting for input pins

Everything was tested on Microchip EVB-LAN9668 EDS2 development board.

Ivan Vecera (5):
  dpll: zl3073x: Add support to get/set esync on pins
  dpll: zl3073x: Add support to get phase offset on connected input pin
  dpll: zl3073x: Implement phase offset monitor feature
  dpll: zl3073x: Add support to adjust phase
  dpll: zl3073x: Add support to get fractional frequency offset

 drivers/dpll/zl3073x/core.c | 171 ++++++++
 drivers/dpll/zl3073x/core.h |  16 +
 drivers/dpll/zl3073x/dpll.c | 805 +++++++++++++++++++++++++++++++++++-
 drivers/dpll/zl3073x/dpll.h |   4 +
 drivers/dpll/zl3073x/regs.h |  55 +++
 5 files changed, 1049 insertions(+), 2 deletions(-)

-- 
2.49.0



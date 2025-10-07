Return-Path: <linux-kernel+bounces-844022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38962BC0D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58433BDA07
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42D52D8DA7;
	Tue,  7 Oct 2025 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="Ogs+k34i"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7C32D7DD3
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829021; cv=none; b=tAMWOdnjCZPISd4v85JsARYmU3GrQoDpW/1ga9J5UNDeLPLPAXEh+1+oDF4Cd7O48xE0gizZRru0NWjDlWFPdB2WkwdVq1G1VVbUQ3EVI4TPEY5w1WXHoAULraIemzx/fLAKPx0UtS4P4FOjBBZMuS+a2mXtmcZCbO0nW+90j58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829021; c=relaxed/simple;
	bh=vOEMENaovdm9ccCHM/8VsN0k/NdulbFSwwEhhfsljgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igo4rsdLhVQnF8k60h74zjnyS4zx5gs+3gUe3ChmbDeUVLgCAapCu8COff5o+C9vEGvCn9J8RWcrpSnyW84BJdGyro37sCv8ddXcptKH7ym8WdzFqatO8GrKrpsAvdRxI4jbn9yidyCbfbByPBKHMiiXOh9+CIgqrx7ZtS4TOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=Ogs+k34i; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f67ba775aso7936873b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1759829019; x=1760433819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkgHB/Rx6YD5mkkjItctKin/3uCiIG1rZ2SooPNG71I=;
        b=Ogs+k34iQj80mUBqXe/0tEw2JB1j4Ufz02d0zKGt+PIdWtEPkKi4iJ3qMBzwWzdvLR
         D8xkrYNWu3eUWW9IkZwn7V6oZIZ8s9h/fu4kJc3AgajMwvQR4gfv0hjyoWcFcEPE3B2Z
         AG5MHusaaPkoyNrjupGrso0hC0sAryHpT5M1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759829019; x=1760433819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkgHB/Rx6YD5mkkjItctKin/3uCiIG1rZ2SooPNG71I=;
        b=r9rrgyq54N3YmHYj9yHvSpN7YcjHss3El8JjXqMxaCfPYPAShV779z5SWtTaXm1eyE
         L1VtUXUaiJsYyOC7Cp9nITNiOzKYhLPfhHo2BvRy/+2eg820zEWwDLv+5ylCHuWQKdXJ
         wn07v92J+8KqaAAs7KH+oeufvMzvO173GMoo/1ezCuzjb2JU/HgILSA8mNpBGKUGgRGx
         Ogzm39RDHTjR/qEA3NxzkXJyqzSOokGVrc0+fVtxCWgNCXHCKkwAryKem0yZycl113lg
         pHxcKqNYi4bFN2C3grea4PD99aqkYdjTns9Nt/UPI7Izv7ctTitQWM1/Uyde1ryotWYc
         nRGA==
X-Gm-Message-State: AOJu0Yz5c4c5T7ehbj587VncGy9l3k9Kb/+Og4M5nRONcLzWuB6tAxFu
	gGps/kwbWhRXZU2+sho8ysTSP2uNsFcjSv9VO8sMFQ7dksHEI8MtJmxEK3cWQnABc4l4xBXu/q7
	fgtBliBI=
X-Gm-Gg: ASbGncvAs7Dcc6r2+6zlBh6Wrkh3idbiw494FkXstnv9DuArTL9sRlJVfdjZF9Ah7mW
	QkfDY9whjx4Gs15FvTmu8Mi1ksBpxMk8xxR2qszKSDkHu1eoQejUWvg1Q13MkCeOhBw3lOi4+jI
	Dz7QNeZks8Zn5uSpw3MXwXbQmXluJDU0ARjFu5XFOIZlILqicPi9VLczIuLQWVX0YbZSnt2gRm7
	CntD7VdT86P0eBakJV0Lot2FIkPLq+hrZSQoRA5NjSm7lac7kAH2zV4F5zPTFdGhhFdxVWsbQpD
	vvrAOS7laAyRI2VX4Lb248ESdRusFOg+YHHGneunWfsdQzIkmJl/hpLO+/UBbRAaRIjUJI4H+Vu
	ywLhU+5+9uZ6wzrw4WXy4OpQRXArniI98LRoiN2FKz3Fmwysr0AK+vdmbx9ZRDfdhip2x6IjkyN
	vLjAwbSYTI1u7s1WUkEdi2V+JMPagzF3PBnZE=
X-Google-Smtp-Source: AGHT+IEkoZ49NHDSFtXnBk2cm2DDRooGytgcNKyAOw5DMVDLSoZWdRSYe50TuAE1idLzf3WVMAfdyQ==
X-Received: by 2002:a05:6a20:958f:b0:24e:e270:2f64 with SMTP id adf61e73a8af0-32b61b30302mr20565633637.0.1759829019271;
        Tue, 07 Oct 2025 02:23:39 -0700 (PDT)
Received: from kinako.work.home.arpa (p1522181-ipxg00c01sizuokaden.shizuoka.ocn.ne.jp. [122.26.198.181])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-78b01f99acesm15123273b3a.5.2025.10.07.02.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:23:38 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: linux-m68k@lists.linux-m68k.org,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [RFC PATCH 3/5] m68k: amiga: Allow PCI
Date: Tue,  7 Oct 2025 18:23:11 +0900
Message-ID: <20251007092313.755856-4-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007092313.755856-1-daniel@thingy.jp>
References: <20251007092313.755856-1-daniel@thingy.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Amiga has various options for adding a PCI bus so select HAVE_PCI.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 arch/m68k/Kconfig.machine | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index de39f23b180e..b170ebf39273 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -7,6 +7,7 @@ config AMIGA
 	bool "Amiga support"
 	depends on MMU
 	select LEGACY_TIMER_TICK
+	select HAVE_PCI
 	help
 	  This option enables support for the Amiga series of computers. If
 	  you plan to use this kernel on an Amiga, say Y here and browse the
-- 
2.51.0



Return-Path: <linux-kernel+bounces-722229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7B7AFD6AF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B6B480DF9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B792E54B5;
	Tue,  8 Jul 2025 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="As/EO2r+"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC56B2BE042;
	Tue,  8 Jul 2025 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752000566; cv=none; b=C8DiAjORggLKQlt7v34lfTNyOxjgHEjWrHXJTZXz0gEJZFW/Rkvw2p80L0Ekm28iqbFwwl9JaY3x5laaBYb3E2ABOswIo9+r0CZ8x+69rXzO6RN/ZS5htXVctPfbWtNG7f63JZRgbFxESJh5fdWBoAvdg0mi7LFWRh1zfyp7piM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752000566; c=relaxed/simple;
	bh=quiCs4TcFWjSYct0FgDm+jHb3T4jJX3ouotFE27Bisw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKFzTH4JAW+JJvBs6fun4cavJ53f//ZJeF1CP+Z6IaaeWWmiDSoFgR/FI07bQ72QakcIDijliOdXCZFy6QZRdcvP1vkNVjHD+y8FCWCahnJ3d5eTk/tTV2b4+idT7WaOeGVgzP8eJCAT5Scw0JG3lxPy+Wlj5TLAA2vdGexKsac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=As/EO2r+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so922084466b.0;
        Tue, 08 Jul 2025 11:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752000562; x=1752605362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9nLm0vidytMMr81fZUNKWpJSt91qJ7feSxKBb+QQwU=;
        b=As/EO2r+I8YNfenSneOBifat0+mKaetR769ZjORUehgS+T9DjVTB45jQaxAwxiNES9
         gcE8U1Ayp0thN8glnyMB00/ZpZC7TMFPWwKEIYRXsxKQIFnfboQP1HNqA+iveDtt3Jxc
         BqMvtf1mUf8VfTSuIeSWf8OkZ31r9IaiC0LVpg9PUI58vxCW9ll1lampFRI5O5Ynpv43
         mS7Pb9tzMgOOldO8aPk6ieJ1x9EGeiH/N4rB5C5U5VnF3AdnWV1V3CxldPmgHeW7qPCy
         8XQghphWsJb6jYbWoIbaLhu9YTpNJ4Vnbjx3xzFuliF3pGFJ2Sv3B2ZcKyMtBzMIhoYh
         h7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752000562; x=1752605362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9nLm0vidytMMr81fZUNKWpJSt91qJ7feSxKBb+QQwU=;
        b=f0uSsQ857EjEfbfaaAFjq/JYF4ZydPHSLjr0ldP+oFb8P39h7CtsGl1HTYmIkuAeEb
         3fDWZAqNNQNGdnq+8lETh2RG9Cj0ObAGuR3fhPacw91FGLpSeD8NVnz1q+Wr3cKjB3ud
         FFjPG00VIdbxB9V9k6ATYtWyA1IIpRZbSB4H8nfIHH4+StzE8TV2xHYbHk6rXnqmWVWR
         ZfyWYDih037FEFCZVar+knkpn/rh2BHzRcrsXsTEmLcjuE8NFdmMfkps5tbfzX79eWwF
         3A4z0wBO2KqcKG0CozsYecliY12YTnPuvovLf6ZK88kKgX+D5YTJIxte4v4VSiInzSLW
         cAfg==
X-Forwarded-Encrypted: i=1; AJvYcCVAmKuAYm8/tkvqk3aP5EHTwPBMwIYwJbujMwNZMmYU1hEs5ZtI3VMb/hac9/crkGHDfQCuWhGtr/YocaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCOnbwCMwqe0+XkuNIQnbErIboi4G3+UULsDeYZ3CiRH1X24n/
	fvo2K8OVnZGHHYucFXBej3WsMn5llreM0hCNoTMgD8FIOxepVgrA8LBynYa7FCMm
X-Gm-Gg: ASbGncszNachWH9kuFKIXVBqb10mskJBjN+XTkBVuZ/Zrk2YCiafDSPQ1FYOrnO6vGp
	X0vgiAU4AlMIPxx14NUBeqzTNGoUEy9hu0H0ZnhqGC1V+hDvujaWE1Jdmmz/elxVxS+zvQfxj+y
	t0Z05S+IS/wUEg+aXI/KtQX7nvVWCjxvm5CeUc+SCgvp5wHIPGkE+YjyO0YtCLb+vnGUJQpUsKB
	36B8JEoy7qybCnSaXhFB+h/ZKR914e2G0InAny4Iw1/AKdVe5XB1PZ+WNxdIv8KHKZpOrBBK8DB
	NMaHG4lglVi+RUFBGlft20R1aozN8s3syaIr4lZ7pe+ySw9Z7fxxWhtSSJ39lH4XHqF/GXUPuJV
	sm1Yl0dzL5DjgmE2PwNCDYG/AASi2HTvSBZN3pAuzazfbqC9puF4DzLO6lg==
X-Google-Smtp-Source: AGHT+IG6bp8JI+7JW0u0eEdI3poMAzICNHShV4QrQOLxp1wBQ7XAkN8Mdy5tEI+rjGUrK6LnnHJ+ug==
X-Received: by 2002:a17:906:9f8f:b0:ae3:8c9b:bd61 with SMTP id a640c23a62f3a-ae6c6b3062cmr36468966b.12.1752000561441;
        Tue, 08 Jul 2025 11:49:21 -0700 (PDT)
Received: from Lord-Beerus.tastitalia.local (net-93-70-53-177.cust.vodafonedsl.it. [93.70.53.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6baaaedsm944884666b.173.2025.07.08.11.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:49:21 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/3] Add support for Variscite VAR-SOM-AM62P5 and Symphony board
Date: Tue,  8 Jul 2025 20:48:32 +0200
Message-ID: <20250708184841.72933-1-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the Variscite VAR-SOM-AM62P system on module
and the Symphony carrier board.

The VAR-SOM-AM62P is a compact SOM based on the TI AM62P Sitara processor,
featuring up to 8GB DDR4 memory, eMMC storage, Gigabit Ethernet, and various
peripheral interfaces. The Symphony board is a feature-rich carrier board that
showcases the SOM capabilities.

The series includes:
- Device tree bindings documentation
- SOM device tree with common peripherals
- Symphony carrier board device tree with board-specific features

The implementation follows the standard SOM + carrier board pattern where the
SOM dtsi contains only peripherals mounted on the module, while carrier-specific
interfaces are enabled in the board dts.

Tested on VAR-SOM-AM62P with Symphony carrier board.

Stefano Radaelli (3):
  dt-bindings: arm: ti: Add bindings for Variscite VAR-SOM-AM62P
  arm64: dts: ti: Add support for Variscite VAR-SOM-AM62P
  arm64: dts: ti: Add support for Variscite VAR-SOM-AM62P Symphony Board

 .../devicetree/bindings/arm/ti/k3.yaml        |   5 +
 .../dts/ti/k3-am62p5-var-som-symphony.dts     | 545 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 379 ++++++++++++
 3 files changed, 929 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi


base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
prerequisite-patch-id: 7e8493f8ed01ee319f827119ffdac7531afbbc4d
-- 
2.43.0



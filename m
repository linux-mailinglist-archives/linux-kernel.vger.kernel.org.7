Return-Path: <linux-kernel+bounces-834211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 908EBBA431A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338CB56281E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044A7374EA;
	Fri, 26 Sep 2025 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPL49Amf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DF21C5D77
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896709; cv=none; b=e1u30ypR3fW68kjt7ByuoyGy/CLTzyN/VpO08nn9a8/XbzrjOz1zX6b9V2EKC/Qb3NJ56BFD4Gt3HKEp2K02mvfYcYMMczvu4MtWw+T4kmHN+D0+MMoLcypuURffvDYCNtgVIKw+Bz59KBE8mobTRjcP+BC/8z3qrIyle5J334o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896709; c=relaxed/simple;
	bh=+8QEVlKLacGF6oQWMvQ8+O1ZZ5z5veVkKt6Pa234fzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUfLRhRUUkxSwGLvzqxdMmmesbk6DK89ePZoldx+rE13SOUF+y/FiJ3u/15A/7U4VjEJ134L94GRNKXQbWvwl4m//pU8pLeWl8ouBL9RkMQeo115iwP9ZcmtaBfADOtqG1GgzkmGn1XaKhkzm/EY2FVoKOfSvx4LkBv9Yn5kBCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPL49Amf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE44C4CEF7;
	Fri, 26 Sep 2025 14:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896708;
	bh=+8QEVlKLacGF6oQWMvQ8+O1ZZ5z5veVkKt6Pa234fzA=;
	h=From:To:Cc:Subject:Date:From;
	b=mPL49AmfZMwEDDyD1POZVGKu1cioeOc7ZfVGpVZXdZ0s6aPqAJsnW530JVLYEvrrf
	 wGUsJwzuER0YvDxVg5jvDJjgrsI0s8qOGm0uI+mUBfDjk3UE5vcaUr4+WTEkCXaZ7c
	 x6o0a6sXoK6CgsamwZabpBzhEhOXSuioACvEuYXrj4KEtqldmC7g7ILiGPS1PY0/Hl
	 cwZuM3kwEOA95P00qzOPdEuU+u0gcMu7iJ/Ynmc4zZ06sUCViVMI5t5iqeNfPtTDcF
	 6E9koTltmMTPGSz/eFUXO/PzogXwjOC/QGSbcFcOWZGUXqsg8TbWf+mX+0G/gK0Bz0
	 /MTvJmMXiSpkw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v29Nd-000000001Y2-2rmy;
	Fri, 26 Sep 2025 16:25:02 +0200
From: Johan Hovold <johan@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] soc: amlogic: canvas: fix device leak on lookup
Date: Fri, 26 Sep 2025 16:24:52 +0200
Message-ID: <20250926142454.5929-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a device leak in the canvas lookup helper and
simplifies the lookup error handling somewhat.

Johan


Johan Hovold (2):
  soc: amlogic: canvas: fix device leak on lookup
  soc: amlogic: canvas: simplify lookup error handling

 drivers/soc/amlogic/meson-canvas.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

-- 
2.49.1



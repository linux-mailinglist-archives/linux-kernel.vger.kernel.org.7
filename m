Return-Path: <linux-kernel+bounces-858182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999EFBE9378
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B5B3BCA01
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9016733971D;
	Fri, 17 Oct 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgmx+YAv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E53396E0
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711606; cv=none; b=q2JvP0YG/YBLbI7eD+1+GXvgLnM4mNHS5ZGsbYESabevrMdsY1EjbI3w345aKL+aQfEM2bQWGsZ6rEHmfP56E2zFLDLx8Q0ClKF+1S9O6Xc4nGmI2Pr0UpXEiOWd0sf+yqK3WciqQ/N+u03B454f4iQsnsC14jZJj0e1DHF6pLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711606; c=relaxed/simple;
	bh=Ayc4p7pF0DvSOAAckOeNJAfwpgI2Ts5uufW2MZg+2Gs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AfSjp/KEL3u3E6PNRBK9NA33sr3SK0EE/yPUWhJClv6dT3qtWRKz0gBqkFWgeZcg+Gv0xuNbnwAbXYK5ZGxNldT9XirI5+FajCDb0GzBFtUS/vZifjPX1PGjvucmBQkYDV91fSwbF1dp38IFwLZDanpvCrvO6NqxLZTvpalkh/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgmx+YAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5603C4CEE7;
	Fri, 17 Oct 2025 14:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760711606;
	bh=Ayc4p7pF0DvSOAAckOeNJAfwpgI2Ts5uufW2MZg+2Gs=;
	h=From:To:Cc:Subject:Date:From;
	b=kgmx+YAvCj+hOHw4GLjUSUrXaM28LAE02r5oQltCqB7IFfoayNum8yDdFAt5OR3on
	 f1p28oHZS0OfRho8q1S2MG3J4x4cpOOh4eRyUkivVta+LjwWs41yd09WuQcgqXrDBq
	 bDqYoqns7pTy5GCo1CIJrJAEuCQmvU/VACV8i5CnjtSlqNXavgcNZHJwt2KJdN5cnS
	 q18lZ8ZP8ykuGz4hyX3cgjw8+c2QxRseaS3oTgQMjYuPjMxlQJ5wMaF1vXG//3LxFx
	 1btj2678rsf1ZNQPvPf9H4j4MNd3mBASPDXUaAkXTE8dL46lq0Z3t1JvktR1DwbD61
	 PGfMAf1Wig4jA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Drew Fustini <fustini@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] soc: officially expand maintainership team
Date: Fri, 17 Oct 2025 16:32:26 +0200
Message-Id: <20251017143302.1776953-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Since Olof moved on from the soc tree maintenance, Arnd has mainly taken
care of the day-to-day activities around the SoC tree by himself, which
is generally not a good setup.

Krzysztof, Linus and Alexandre have volunteered to become co-maintainers
of the SoC tree, with the plan of taking turns to do merges and reviews
to spread the workload. In addition, Drew joins as another reviewer.

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Drew Fustini <fustini@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

Co-maintainers, please Ack, or let me know if you want any changes before
I send this to Linus in the next fixes pull request.

Sorry for taking my time again after we had decided on this at ELC-E.
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9b16f619373..74a3002bb44c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1997,6 +1997,10 @@ F:	include/uapi/linux/if_arcnet.h
 
 ARM AND ARM64 SoC SUB-ARCHITECTURES (COMMON PARTS)
 M:	Arnd Bergmann <arnd@arndb.de>
+M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
+M:	Linus Walleij <linus.walleij@linaro.org>
+R:	Drew Fustini <fustini@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	soc@lists.linux.dev
 S:	Maintained
-- 
2.39.5



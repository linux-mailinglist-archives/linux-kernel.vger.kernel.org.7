Return-Path: <linux-kernel+bounces-850280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 131D6BD2640
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2AC834A123
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8E62FE078;
	Mon, 13 Oct 2025 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLw6AU0n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6FE24469B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349293; cv=none; b=Pph8qvEMUKhHGjaN8bZ4v4s4aenil4y2d6SfpEiRuuG1uqqL/IeWvu9xPjtq9i6pls+8VHJbB5ohCPzHHvAU6eeUC12PumPb/yo+00a3dlwzF+v2T5L8S6j0gJmIE9BK3Fk8S0QYv1jtsgFqKjrqHBXQfzqfYDXff9eJsj0r9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349293; c=relaxed/simple;
	bh=3HWvriWqPjWYdNKjgCZ9ZxX7Bh8xEr5/FjvBOycsUEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCSt6BSTunDtvORwhql/MjcZKiJ/u5o/pMdQQ6ph7JbrGJ+ATR9F4qlVyyM64TwfwOSGWpp6jLGH7N1wG/PqIGYKJNg3QAhjec3XC8HTUxbza/xx5nrUcporVUmMi7jIRFBOcneo1ypaZLgPkkesXhBkLA1DA5ustEWEvVa4d6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLw6AU0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BDBC116D0;
	Mon, 13 Oct 2025 09:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760349293;
	bh=3HWvriWqPjWYdNKjgCZ9ZxX7Bh8xEr5/FjvBOycsUEw=;
	h=From:To:Cc:Subject:Date:From;
	b=RLw6AU0nzcTnEfoYHYKYL4z1GXWi4ajl5Ee9jh4N+OmK0ia5nrTTBINZkN15R9nqP
	 n9vUTvb/+e3o77nwkvdBZskdbwUhZzInJ29nlGLP8tcRKIr8ZTjRRYN0p+jLWlNLFk
	 r76cyL1GUtau6z/99aRdcA0FYtPvLnXjFRQLzrMyUoMt2K34q61JAfnZc5gROOAStg
	 lDn+Ih06QsXaBNaBo79IWyK3V3nnXhLOpsw3AHwyZFQGByrA0RCGOKJ50Qfj/pDsNe
	 N/bypMVZB+leoJJZjzp5Gw5hBdGhOgiam/pMj3TiTenhTjFJ5CW5Chs0Wr5xnDPLNT
	 7OUsc/9aBGMYw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8FGU-000000003E0-48ZC;
	Mon, 13 Oct 2025 11:54:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] irqchip: Drop unused module aliases
Date: Mon, 13 Oct 2025 11:54:25 +0200
Message-ID: <20251013095428.12369-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fixing some platform driver issues I noticed that these drivers had
unused platform module aliases which should be removed.

Johan


Johan Hovold (3):
  irqchip/meson-gpio: Drop unused module alias
  irqchip/mvebu-pic: Drop unused module alias
  irqchip/ts4800: Drop unused module alias

 drivers/irqchip/irq-meson-gpio.c | 1 -
 drivers/irqchip/irq-mvebu-pic.c  | 2 --
 drivers/irqchip/irq-ts4800.c     | 1 -
 3 files changed, 4 deletions(-)

-- 
2.49.1



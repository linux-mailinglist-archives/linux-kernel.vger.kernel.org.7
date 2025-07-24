Return-Path: <linux-kernel+bounces-743926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E066CB1059C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0B6563403
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7A32737FD;
	Thu, 24 Jul 2025 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SObbgOdZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9822494ED;
	Thu, 24 Jul 2025 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348771; cv=none; b=UwAmHWnU58Ug4Tzty+V+vtY54hvkNKX4/EjZqUfelR3OYMfTzHsiWwiob6+8Cilwo2xh9PlwzEk0lAIzLnzgiHdDwEOG/BNxBq3iSUhg/MtbzLMhN1nO+/IhDvpF8WP+jUX8KvrogBbMLNN2NELSeB1+AlaPdfR335zla9YSA8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348771; c=relaxed/simple;
	bh=k7qXbYJOhkFXKlRLvvu2s6EsqzQn9Sh5apoytnQu88c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZGNrEU7ikG6b7irFFCpjQ/sZ0sFkXQYkbNnF751GLbJ1u5woXvQ7xgM/LMidRFoZJuDXl//W9b8HUTg6xzFZWub98zWAuoffvyVqQLU1SU/XUsonc4Rj4ynit60UW2u/kcasXQQpocXFdyvD6nlNmAAJ6Wk/7PwlzexzQWSvbBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SObbgOdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8904C4CEED;
	Thu, 24 Jul 2025 09:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753348770;
	bh=k7qXbYJOhkFXKlRLvvu2s6EsqzQn9Sh5apoytnQu88c=;
	h=From:To:Cc:Subject:Date:From;
	b=SObbgOdZ60YJkCAnveiqYzcXsC8GcT9BBs08qclaB9HwTPL69AP8NWH3Ft/6gO1EH
	 hRHbS780NveYwWZrSYIyLfKPAPQhFmX6oIlpYEr+3rsI46W/G7PiaOqZhtIWH5lXx2
	 Q7QV1BxnwicRECcD0RV3hzsE6s8suhSKcOiVrtOgwJtFLGxA342V5p78WwAZnnUUsX
	 d2WWQ2W098Dmdg9vMn4Uu3rDe0mBaVXeiFAfMiNhqzEjLz1HXSOe97TVK3jF+5WUg5
	 mbv2GP1goKbz5Azhieehj5cyW9K8v1Fv7mCYtpREoSqFIhIHoSfzLnEkitrA3Spiju
	 MEO/B4EepLCbg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ues6m-000000005Ut-3XBM;
	Thu, 24 Jul 2025 11:19:25 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Bin Liu <b-liu@ti.com>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/5] USB: fix device leaks at unbind
Date: Thu, 24 Jul 2025 11:19:05 +0200
Message-ID: <20250724091910.21092-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a number of device leaks after failure to drop the
reference taken by of_find_device_by_node().

Included is also a related clean up of the omap driver.

Note that these have only been compile tested.

Johan


Johan Hovold (5):
  usb: dwc3: imx8mp: fix device leak at unbind
  usb: dwc3: meson-g12a: fix device leaks at unbind
  usb: gadget: udc: renesas_usb3: fix device leak at unbind
  usb: musb: omap2430: fix device leak at unbind
  usb: musb: omap2430: clean up probe error handling

 drivers/usb/dwc3/dwc3-imx8mp.c        |  7 ++++-
 drivers/usb/dwc3/dwc3-meson-g12a.c    |  3 +++
 drivers/usb/gadget/udc/renesas_usb3.c |  1 +
 drivers/usb/musb/omap2430.c           | 37 ++++++++++++++-------------
 4 files changed, 29 insertions(+), 19 deletions(-)

-- 
2.49.1



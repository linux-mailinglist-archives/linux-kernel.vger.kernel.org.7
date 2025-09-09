Return-Path: <linux-kernel+bounces-807782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C90B7B4A935
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61858188E1FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6932D4B66;
	Tue,  9 Sep 2025 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaVF3oBm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3675B2D3ECA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411888; cv=none; b=Vi9rb23QHhUxlF6E7gVUbzEkDGMyKDa8xYT5AbVN+JpLBUTKSTAYF1+d/g9H7EHHfka6SIYA4h5pGKckMeEGRzqtkz2l+mD6HVIvMU5x2XiaLt8lEGXyilRxbopVuE/VKbsuP6AxN54CBd6UGK31tJK4A9d2gbOiW/K7UIc00Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411888; c=relaxed/simple;
	bh=L8J+G7X3cATY+Wpwe2QZJ086a3PvYwOheYLmI2a2b/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IN70lG99Ynr5k52IgLyLqIFeCZvze41gDICvQlrSanJ9xRHpDVjQ7O+QySIQJEjcZMqAagi0CcLRTd/hd0+69oAXzlCjMVanORoWuAx93YjA0J1GcotYxiNCokA3mw7qz8Kvop9QAXgqCLK2FMbo2+oJcKTF953PedvjkN57krc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaVF3oBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB58C4CEF4;
	Tue,  9 Sep 2025 09:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757411887;
	bh=L8J+G7X3cATY+Wpwe2QZJ086a3PvYwOheYLmI2a2b/0=;
	h=From:To:Cc:Subject:Date:From;
	b=AaVF3oBmW3ZuTPgbCdu+lti3ixCelDqxQk1Q6lpUWb2bssmiSP+9qv/Wka7ekcY9n
	 a14ijqcwI2CcN9/Ag7RwMEOLFkC7IrujIjZP/FhYTU9eCa6m2KnjL1WX6xLTQT3jR9
	 V1SqlPTAarB5BgBY/hrsRyyBB6JIICnT1jEJsm7ASmnlid1z59iyP8AdUXzA4gKJOX
	 14+D0PjznyC8v7QUnB8SZUhTFqiC4fLAVimwVgt3AncJvDxzTz+ftv8+50S7dgGdU8
	 lACeti7DfDV7+XtkfcgxSRV/f3RiZh+uuttKHXqGZGOhxp/qvCguFJK5+ys1SRL9lK
	 euUCvceh7MyaA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uvv6z-000000001Su-0Thp;
	Tue, 09 Sep 2025 11:58:05 +0200
From: Johan Hovold <johan@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Roger Lu <roger.lu@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] soc: mediatek: mtk-svs: fix device leaks on probe failure
Date: Tue,  9 Sep 2025 11:56:49 +0200
Message-ID: <20250909095651.5530-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes mostly benign device leaks in case the svs driver
probe defers (or is ever unbound), but which should be fixed if only to
reduce the risk of such bugs being reproduced in places where it matter
more.

Johan


Johan Hovold (2):
  soc: mediatek: mtk-svs: fix device leaks on mt8183 probe failure
  soc: mediatek: mtk-svs: fix device leaks on mt8192 probe failure

 drivers/soc/mediatek/mtk-svs.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

-- 
2.49.1



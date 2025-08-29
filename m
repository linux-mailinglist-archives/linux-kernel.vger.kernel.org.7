Return-Path: <linux-kernel+bounces-792037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF28B3BFB5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5654C3A3ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0DB314B82;
	Fri, 29 Aug 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr8wIUjJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC88D18871F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482190; cv=none; b=uUfPaqDf0As6DCrjXlDF5M4X1iORHHfnj4ozWwDg0PslOdUf4cFyORGMC0jZ20BMbKO0RXjnfZpsUELnDJMID3tONQi628xILQW/0ViHNDdQchLWzXN6f5RUf3xPNUziDTTEsZPJdZ4ZzKBrKCfa2BD1nFv6CL8YxoJiIPFs9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482190; c=relaxed/simple;
	bh=OL18MnykJgKNptxGVWsFWM5heT58JL3lUDx8FWl25rc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dcjwCKKOv3WeVNGdpOMitJwIBcfrc/2uz0gULPODZNnOLtMOjzqEoNsg6UTMFhWhpTwOEQ33KSLGWau0P2nXSvKvNQAbGDDYElG/2HueDgx9iyvv2C4XCMLle5bmeHnWp1YPbYv4h4df3zr46qw+2V1gO5+zURzWhvKbzYHhnRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sr8wIUjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3765C4CEF0;
	Fri, 29 Aug 2025 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482190;
	bh=OL18MnykJgKNptxGVWsFWM5heT58JL3lUDx8FWl25rc=;
	h=From:Subject:Date:To:Cc:From;
	b=sr8wIUjJf5pnJ2M2UJIj5RBjHAPHeklz7zEL6AsA73nkxTTVQwJ0yYIj9PWNeRRy0
	 bEAzoPrUtlkJNZxpSYY+Oy7XaUK4hpmRZNgW1MZDM4EJLgUG8J8mYuvegsHfOwWRwN
	 +QwiHBU0gi6YIs4lLMcLznjyUZ0eoPQcpNKheUVzHIjy050cagWyxX90rQmHcHWi/I
	 9qe0mqPQKgXN5V7M3mcKt7AFOBWnKF1leOv1eOfafzS3IQONSkanK+O2DbwsPg5rg4
	 wowcN+GvtsxXBOl1omY/eK7sMtBZtAJLpEo4CS+iRcDXp8/Ix6Bamk1hZCezz3fmnV
	 0xJmiHg55LYzg==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v2 0/2] nvmet-fc: fixes for blktests tests
Date: Fri, 29 Aug 2025 17:42:59 +0200
Message-Id: <20250829-fix-nvmet-fc-v2-0-26620e2742c7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIPKsWgC/3WMQQ6CMBBFr0Jm7RimVNO68h6GRQNTaNRipqTRk
 N7dyt7l+z/vbZBYAie4NBsI55DCEiuoQwPD7OLEGMbKoFp1ao0i9OGNMT95RT8gOW+NtaSV8VC
 Vl3D999ytrzyHtC7y2euZfuufUCYk7DptR6e9pjNf7yyRH8dFJuhLKV9VnIFXqQAAAA==
X-Change-ID: 20250821-fix-nvmet-fc-1af98991428f
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

A couple of fixes for bug reports from blktests.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Changes in v2:
- rebased
- added "nvmet-fc: avoid scheduling association deletion twice"
- Link to v1: https://patch.msgid.link/20250821-fix-nvmet-fc-v1-1-3349da4f416e@kernel.org

---
Daniel Wagner (2):
      nvmet-fc: move lsop put work to nvmet_fc_ls_req_op
      nvmet-fc: avoid scheduling association deletion twice

 drivers/nvme/target/fc.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250821-fix-nvmet-fc-1af98991428f

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>



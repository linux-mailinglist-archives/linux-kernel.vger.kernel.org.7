Return-Path: <linux-kernel+bounces-877967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A07DBC1F71D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4736B422F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A29351FDE;
	Thu, 30 Oct 2025 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9rDgGzo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942C634F468
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818761; cv=none; b=pkQtjkMaRFkFRko83ZL2Ctqjmy7sm0CNMEE2FtmLlhQp7RWXwIWKmbSSwj6JHt/WYy4IF8IutyrRLxt7gLnh31sCQSn3oGjfFEqbt52ataK7sl0YYIqR9EDHAYcn6rqN0E1vUf59vE6y0rTE3bv5KbVhZjrxTZ2Z5yQPFNuWGsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818761; c=relaxed/simple;
	bh=doY/mfIsT8gI0lwCrmexGQlzegsJ2i3cFbb9dDqKg0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XVJpt2Eb7r5A75oesyXAcHKdex2qTkLFiGkaFU001ho7Ge9B3rssg68JFzx2PLSsQ7jPrrc96eMDP9Fc9njp1ZJp7o8ytlQjhXUv6SIe5HVyAqNVubJyD792dB2QrJXmtOF0ZFV1TcfVoA0q70L9jErYldERUyRR1CTcWSJ2+PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9rDgGzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C1DC4CEFD;
	Thu, 30 Oct 2025 10:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761818761;
	bh=doY/mfIsT8gI0lwCrmexGQlzegsJ2i3cFbb9dDqKg0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n9rDgGzoysc8xjHoSAmwuG+VKalr9clgrOp8DxfJG+sU3nYQEwAvnckx9Hcx1M2wR
	 L/wXyJEPq1YJTVOlqT/aFr8B3a39fawhcSqp3TxUSEl5gcKkTQoaniOofzfkYOI4u3
	 LuAVL6V7gmw9wkhs7JsJVR02/UForRV0xWHvoGqYTB4p5cnUCrFGFqiMybyz11ZGx2
	 Ii+PG8jXT74KObmsSyMPQkjA4zXKB9nVgMBbz+nOGdsAuSheqk7mvq58ZaMZeF4eMb
	 ZdT5rhfpC3OwSIKkjE/WsipxgPuYU2YU09TUGk4r2XLHOomQmHx8K7ziR2GWKfahc6
	 GkR6F2spHHyjA==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 30 Oct 2025 11:05:48 +0100
Subject: [PATCH v2 4/5] nvmet-fcloop: remove unused lsdir member.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-nvmet-fcloop-fixes-v2-4-b8d66a322c51@kernel.org>
References: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
In-Reply-To: <20251030-nvmet-fcloop-fixes-v2-0-b8d66a322c51@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3

Nothing is using lsdir member in struct fcloop_lsreq.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 4e429a1ea2bd..c30e9a3e014f 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -254,7 +254,6 @@ struct fcloop_nport {
 struct fcloop_lsreq {
 	struct nvmefc_ls_req		*lsreq;
 	struct nvmefc_ls_rsp		ls_rsp;
-	int				lsdir;	/* H2T or T2H */
 	int				status;
 	struct list_head		ls_list; /* fcloop_rport->ls_list */
 };

-- 
2.51.1



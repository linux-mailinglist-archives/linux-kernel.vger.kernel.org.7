Return-Path: <linux-kernel+bounces-741883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ECCB0EA31
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0464561856
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE104248867;
	Wed, 23 Jul 2025 05:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fy6FkpZn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1574D220F4B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753250009; cv=none; b=rqgLQdNClckFElSmHnAGCAj1DvwLYccT+dXTzTifZtPLwxjdHTHvzoNMVbeX6lyc+rbKGx4CjTqb6O8WfELMMDfMMZkEft6HxKvGSLYVhn0TvgPonsXrNxQB+ajfBtfPxpoQCumDpzj3Zy0pq/47o1nD9W/IRJHDEEV9GkVKmmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753250009; c=relaxed/simple;
	bh=g966sWWmsGRdB6+1CU+LZVfrII3EUcFbPhJpBPPWABg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dnWZwwnok33Nlt02SeBgNP6TiaQcmeeuReMcTLVGR0loV4Z5rdr59HaITUiHsp6qXLZfsFWm2Ek2SQRtZhXW9aVZXJM2H2UXp+/FcdJ6UXU+cvhUUTWbxzbiKm6dXgT3jszqwJSSlNA6xfHZAnw1Z89s63K2f0+Y6JOFJoefM4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fy6FkpZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549AAC4CEE7;
	Wed, 23 Jul 2025 05:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753250008;
	bh=g966sWWmsGRdB6+1CU+LZVfrII3EUcFbPhJpBPPWABg=;
	h=From:To:Cc:Subject:Date:From;
	b=fy6FkpZnHyMf/2H0VrSxLYCv/aRnoiDK1W+LdIEKDliufmWXK7IIPuhCGmXp9Bvqi
	 sq6YB4ItVp2ILbwA2+sSnI29Bb5af2D6s1obxIDPM4QawNfNb+m8bB5rVs62MKiokt
	 U6onllJGDt5mY/fSEQRB4nnR8/3VF53Voj5oLzQ74M5ZollS8sl5wCgAw1+UyyDbzn
	 9IWL9JBQpJKydwbz3J/GxoJ3K91cyZ9OLr00LjqYD9dRyisNpVMp5SvgmXa+ANGMwY
	 b00pPlks3es+aG3IIYbfq0FFIjNnY8c3MG3K7xxDeJDiaEx2/8lfWrT0w/pPaA0mz0
	 4twbYmjou+1Pg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH -resend] bus: moxtet: Use dev_fwnode()
Date: Wed, 23 Jul 2025 07:53:25 +0200
Message-ID: <20250723055325.1800024-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

irq_domain_create_simple() takes fwnode as the first argument. It can be
extracted from the struct device using dev_fwnode() helper instead of
using of_node with of_fwnode_handle().

So use the dev_fwnode() helper.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 drivers/bus/moxtet.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 6c3e5c5dae10..7ce61d629a87 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -737,8 +737,7 @@ static int moxtet_irq_setup(struct moxtet *moxtet)
 {
 	int i, ret;
 
-	moxtet->irq.domain = irq_domain_create_simple(of_fwnode_handle(moxtet->dev->of_node),
-						      MOXTET_NIRQS, 0,
+	moxtet->irq.domain = irq_domain_create_simple(dev_fwnode(moxtet->dev), MOXTET_NIRQS, 0,
 						      &moxtet_irq_domain, moxtet);
 	if (moxtet->irq.domain == NULL) {
 		dev_err(moxtet->dev, "Could not add IRQ domain\n");
-- 
2.50.1



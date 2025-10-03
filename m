Return-Path: <linux-kernel+bounces-841152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD4CBB65C0
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5617B4E6746
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFB72989B4;
	Fri,  3 Oct 2025 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="c2YEj1yD"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E5C2459FE
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483552; cv=none; b=k6e/xWYf9K50By9g4T/8jGSasliL9rRcJ/88TknQFGtaJF8T8ey61ug4EbkfsW/piRHeMIUT0CjW9eeCJbqd05jkngU2l7F8OWYkRAz//jQNUksJcAdUxjo560lkaIeKhB20cyXQ67MCd5NkfiS+O/AzmnKxeVnCF2orPIBjZrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483552; c=relaxed/simple;
	bh=9OeVwVEPNFQInXiBxcat8VzBfwekIUYqFDJHhYJ54tg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mpAt1MxYic/LqwXbN+VhqHl9Uy35ganUUrtvo7ywFSFE/E+vnd8bPoNaMOx381jiUzZ7LZWQHvapVVKrOwaVi93egIzYEW+qSkhbYVKy5HIyNkRA8Gk5UFvK6PGcjM5ZI6v+rWa/6YktOj+PKNOnmXuOT6wHYzYJJgF+enC/lJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=c2YEj1yD; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 88E35240028
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 11:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1759483547; bh=+E76rH5Fmcp71csrTY48yw41Ln+klncaWYnzLLl3r9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=c2YEj1yDVf7ERcxigSaiO7x3qMWUJiNb+FcBfpXa7Yz4ud+zt7qwFKaajCjADTEa0
	 LAJaViwIl3eiqgPwn+HxInqakylKGCXWcTHgcs8g19V8OEzm+dLx7piVlqeJRxad9u
	 wRW8Lw9/VE7RKarBrYBjL3ek5YLY7lkNK9uaph7VoOB5zAmP/9pTW/g/ojXatbFxIU
	 5iNvnjfgpziTznQ06AX5J1Q4gdwCOnrbBjwdEQg+raR48Y807DS5HDOvQO20/QVrb1
	 TBtlHCgY/fRQFmTHM3hr35KdROZ7dtaET5AtWDIMnuDoOOZxO52EustobFz7ECIiUL
	 UsJ3GCuNjFRtg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cdNZ268kmz9rwn;
	Fri,  3 Oct 2025 11:25:46 +0200 (CEST)
From: Shahriyar Jalayeri <shahriyar@posteo.de>
To: peterhuewe@gmx.de
Cc: jarkko@kernel.org,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shahriyar Jalayeri <shahriyar@posteo.de>
Subject: [PATCH] tpm: infineon: add bounds check in tpm_inf_recv
Date: Fri, 03 Oct 2025 09:25:47 +0000
Message-ID: <20251003092544.12118-1-shahriyar@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure tpm_inf_recv() does not overflow the provided buffer when
the TPM reports more data than the caller expects.

Signed-off-by: Shahriyar Jalayeri <shahriyar@posteo.de>
---
 drivers/char/tpm/tpm_infineon.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
index 7638b65b8..eb6dd55ff 100644
--- a/drivers/char/tpm/tpm_infineon.c
+++ b/drivers/char/tpm/tpm_infineon.c
@@ -250,6 +250,12 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
 	number_of_wtx = 0;
 
 recv_begin:
+	if (count < 4) {
+		dev_err(&chip->dev,
+			"count less than the header size!\n");
+		return -EIO;
+	}
+
 	/* start receiving header */
 	for (i = 0; i < 4; i++) {
 		ret = wait(chip, STAT_RDA);
@@ -268,6 +274,12 @@ static int tpm_inf_recv(struct tpm_chip *chip, u8 * buf, size_t count)
 		/* size of the data received */
 		size = ((buf[2] << 8) | buf[3]);
 
+		if (size > count) {
+			dev_err(&chip->dev,
+				"Buffer too small for incoming data!\n");
+			return -EIO;
+		}
+
 		for (i = 0; i < size; i++) {
 			wait(chip, STAT_RDA);
 			buf[i] = tpm_data_in(RDFIFO);
-- 
2.43.0



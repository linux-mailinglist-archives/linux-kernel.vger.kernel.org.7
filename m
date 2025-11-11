Return-Path: <linux-kernel+bounces-895328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1873C4D7EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5131F3B1A73
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2665305E10;
	Tue, 11 Nov 2025 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfUMWiw9"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AFA2E6CBB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861572; cv=none; b=W5CNad2ky6GmDf9byRdCkNWr3G3wZ70ZSGgG0GNzbM7ahrOt8EEagvn1dCaVXrTuaf4z/HRJvnJ6/+ftB4B2iRQYHn3K5PPnmsE3D983P3ST6/FGidlLCZAdUq5ji5Kltaq5EUVe74quYUBKgWErA2aY507kiOZsJ8KFIi4kHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861572; c=relaxed/simple;
	bh=QLE37qHb16MxJwLfO98cvkKdsqbnXD+8Goev9NBW4lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dh+Y7emZ/fbtvOq1DUxTsb9FEsWKyjQtrznmJsYCC3crk78mUE9Sz9q62MHKQdrop6TUe5gs0iIRss79riWnMbsiTpC3OqKltJ2zV0L5XXueJ925gcPXIt1dXQ6iI7aT9kHfHKztRd9MNyIdr08pa3HHPZajZoonXsS/1QYwE9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfUMWiw9; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b728a43e410so872083866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762861569; x=1763466369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5PjBGS/A4kqi2mZ597aONLcrFQt1TO2e84Jges2BFw=;
        b=gfUMWiw9sXpsa23MBB5TzMERB5ximkohS3RutksRwiZ3qwCif9fpUZWga1TCBbUiu3
         DPDOyesofNx1UUXwBNcM5gTCacYvfkOMYBjbkmngGwKa9FQZ/0szGvpQ867q0n1lydYF
         ApfVETCwOKieriElVgDY95cUrwXEc0jYyOsjjC5l87l8R6c7p6opXKGpfROvCSvFcVWC
         Sla84tPR8B0nAJgcmgsd85R9g41VMSkfixuV+Yt48LXnkiElSL+/qhp9E9ubIPE/ubs8
         2KRri7m1FAlW0t7KhKAnOVZxr3cMA0EZx/QHsgDhXsf0+B6MUoTeI5BpbAKIh/VO2vrW
         bfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762861569; x=1763466369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g5PjBGS/A4kqi2mZ597aONLcrFQt1TO2e84Jges2BFw=;
        b=oPuIW+M2GQvMpHJTSbaNlLyyBo3RgXNVAagvCSGz/UvDSua+QNiQXwVwdO63aRNURk
         Nii5gJqydoCxEM7FjOZimZC5RuqAj5ip/zUO556ZFJ0ql+cP7YcYQq8cm11+7eWZ2xCT
         8SJAWp/r18mxpGKvfZ9KcL18fq3WnjN+TCYjIbcC1AiUEiwOMtdNvMOElSNO6vuVg1k/
         EFt1iy+trG5UtZWYEoabISMiVC2JRNWVlqkRaDj70qJPtRWyupUJmQeAkLQf3F3nXykH
         YKUjJFpIxgDvPXPrCBk5ev6nU18LkOZIK3XHgmg+u2zWsOH44/dIIHq2gp6xNWtJBeaY
         fWkw==
X-Forwarded-Encrypted: i=1; AJvYcCUpyw9bPuc4SiTT2nxkIY+S4F4NeYxQ4gnCnUsg54qbbwIsWukap2lo50+Bzyg+hvfynqdxfbxFvFc2l9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxal2x3vFem0e5UlTALOXYeq7fpfPSSFyfN+zd1Kk07KWFon070
	3n5yLk1e7Aw5F6FQETnBExTCzLV16gSi6z6sstR1pLtNX7rnDRH8seXo
X-Gm-Gg: ASbGncuRTXqxPMkA2IaSJWah+mFvaktKPuJBFPYNXZA0rSrCo7sDfxX7U09nUhW9hQi
	AuLV4kCQPzJAA4+fE/FcqrJ9a6lvcHg9xwTH/x+wfuHNl3ep/uhsb5zk688gedXIO46lKvAB7a9
	6d6BFf6NwaGUVuP+LeSjZ2By4HQ8jPuY17b6Wu9bB31VeCn4uFl6m8hl1kbjFZOtQBvvgzKgfAq
	E0tig0xv/5tuQF8BtXNFCyZQ1RHJNhmGF/Fj+g67651bPXe+2SJ8Y7qUa5qOKOdDTzRWWBrhoub
	Q6xJyWFGzEIwv+zdoUD6NsZ62TK3PCweip8LTa8ZtsCbBbul4SqzycdD1SHgbcQxSBfBGIbyFzK
	OUhMwliJDobG4Ui4eCppZxYUdLMP38qPSFCuLcLJp2MMiuTM4bjsTc58eiPwv5R8FvKgXpC6WeX
	Tu/w6FJnM5TPz5v0ctoA==
X-Google-Smtp-Source: AGHT+IHMw+7YllRho8le91BKAe8wJ90etB++mcoL/7134mHZqS0c5es9GOuXcOqsBUjYOB7fZBdmbA==
X-Received: by 2002:a17:906:600b:b0:b73:278a:a4a4 with SMTP id a640c23a62f3a-b73278aaf46mr100831366b.16.1762861568456;
        Tue, 11 Nov 2025 03:46:08 -0800 (PST)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72fcde0779sm682374466b.40.2025.11.11.03.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:46:08 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: p.zabel@pengutronix.de
Cc: a.shimko.dev@gmail.com,
	andi.shyti@kernel.org,
	andriy.shevchenko@linux.intel.com,
	jsd@semihalf.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com
Subject: [PATCH v2 1/3] i2c: designware-platdrv: simplify reset control with devm variant
Date: Tue, 11 Nov 2025 14:45:57 +0300
Message-ID: <20251111114559.3188740-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e3c2096459bdd0c1d48c00a837cc7f8c18044631.camel@pengutronix.de>
References: <e3c2096459bdd0c1d48c00a837cc7f8c18044631.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation uses separate calls to acquire and deassert
reset control, requiring manual error handling for the deassertion
operation. This can be simplified using the dedicated devm function that
combines both operations.

Replace devm_reset_control_get_optional_exclusive() with
devm_reset_control_get_optional_exclusive_deasserted(), which handles both
reset acquisition and deassertion in a single call. This eliminates
the need for explicit deassertion and its associated error checking while
maintaining the same functional behavior through automatic resource
management.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
Hi Philip,

That works, thank you.

I also added two more separate commits to improve the driver.

--
Regards,
Artem

ChangeLog:
  v2: Simplify reset control using devm_reset_control_get_optional_exclusive_deasserted()
    * Replace separate reset acquisition and deassertion with combined function
    * Remove explicit reset_control_deassert() call and error handling
    * Maintain same functionality with cleaner code
    * Add devm_add_action_or_reset() to fully automate reset management
    * Remove all manual reset_control_assert() calls from probe and remove
    * Streamline error handling by removing goto exit_probe and using direct cleanup

 drivers/i2c/busses/i2c-designware-platdrv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 34d881572351..c77029e520dc 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -236,11 +236,9 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	dev->rst = devm_reset_control_get_optional_exclusive(device, NULL);
+	dev->rst = devm_reset_control_get_optional_exclusive_deasserted(device, NULL);
 	if (IS_ERR(dev->rst))
-		return dev_err_probe(device, PTR_ERR(dev->rst), "failed to acquire reset\n");
-
-	reset_control_deassert(dev->rst);
+		return PTR_ERR(dev->rst);
 
 	ret = i2c_dw_fw_parse_and_configure(dev);
 	if (ret)
-- 
2.43.0



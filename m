Return-Path: <linux-kernel+bounces-837668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA4EBACE05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9895817C000
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CFE2FC863;
	Tue, 30 Sep 2025 12:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTzF2xwq"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3B2BDC33
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235896; cv=none; b=sTvTy/q4NbAFdUdnNG0OkhPSiIM6z5Edbmu2QHGi/MXjDHEIP2jXq7G1QrjtW7m1InXXXG6MtHV0q3nkVVWwBlaO37jR8SqM5W3P2KWYHbvik86MUPoyY3ihTM23EzdSjX/VFztwpq80SPqTwJokChANGUVSRd6iMUJiU8ecnHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235896; c=relaxed/simple;
	bh=TRuZEMG8YWoD7AC+4GOrUJfg5Kr9NAw2G8HZG37cXV8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HrJ99NWur6cVhLMCD0374L6p/g9+l36IIqjQhEqME1FzPd4qlqaG2lMnAUZJZinS5i6SfV3kqkfbbOl8qAdiuynmiXBPZk9jPVXHZ4VyCPgBTYv3uuilgQJxEFa54pSbB+En7FTn4cCglR+golrkFSpibxtdKCri4lOPjAiiHN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RTzF2xwq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so3872276f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759235893; x=1759840693; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3qy5r7hvv1J3r6dinn0Sogr/iaDbB6XdxwCfFluXsU=;
        b=RTzF2xwqP5ucDaqwVyKuJCvbxjhr8lHVdMvDIHBUXvNEnw+CkJeDaSXZQqyi9kBB5W
         vemrsIb5U/uO3+kD7+zhkrwIzjB6hAvu9BJwCew6ZzteQwlM2Qo1fWf7Jn2Ut7l7Bc7Y
         Ck0Ffc2eVx0z5TgFqit3AR7O7kENCDcyKVWpUMoDbA9IeVF5EnHsqPPqe51o+9xqnBTX
         iJO9en09s1r3QhSo4l+EvSb1PVkh8HAcjBVI22V60MQxa6AGtsWLHQVePrY9KZsmuj7U
         /gtiLw1jaainPQ/tMx76iE9xp1ZqMsqMx/CgiC3ExlQQHkqqpxvPobSB/fFzjdPC8uut
         JV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235893; x=1759840693;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3qy5r7hvv1J3r6dinn0Sogr/iaDbB6XdxwCfFluXsU=;
        b=nIk9g5VZp5GKTJzv1xycd2AgZwCPeUtITagL7kpHlr6JoLSQMB93oYGtWqNmAFxLNS
         WFRW5ndTJaBotE5b1tgcYCFATQzFozbNcUrlj9rlaSj/tTmj+kmhCBJMwPTlE1y3Umxy
         zPJFCiRAiePWpmG8XulqPCyTJqWmKxubi9rKm7snKV+hLcEZtxNxfaIyPiVX0Ik9LvPi
         iggUB2bXCa3RgQpxTzlW1YSuvwfMv7KSMTLWqQISfqwGKW8lOh4WNqjcNIIOFjL74jJw
         5pcmToR46GhEBV60RQsEWapewl/OVbil55mlkWbF3CGYiK/5Wayoodc7/Tla+rgE5Lvk
         7LZg==
X-Forwarded-Encrypted: i=1; AJvYcCWVoFGFXsc2cyONa+MVjRydB0g2vBENhS1qMhD4QXpN7oZ0nJLC7y3Z37GtlaSvjNA/VDP/pTjTPkCmxgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3WkFi9uhE/QpBGerUuT+YGYIC/VXRBnkJHUy0zvSABFAFAHh/
	MrcWv9euZncUjfjnZrUQlhHgqmTYtezh09gBAdX1BbrnVvKYnSssxH0mcE2DkF/lDxQ=
X-Gm-Gg: ASbGnctDV0kU+4cgNF1uK2Z7bX9etF6CWbgdYKlOnDybBXDb9znSyl6vLknkBTbtZib
	Tyorlq8AY7eK9ZqAHuQfYoe+5QjYBAx61uf9LwxpUPeuMVYH6m5YRgH7+oCxn+T2sSKW7uVM3di
	tI1WmVNaLhD83owBYLPJV9cEkfzNxjK4UH+bo2qNRww9UIqxLOU+UOGDXSuVD9LUUphI5lSdD1k
	8KlLwObb6fKcBtXUl1XysagwGZNzLxYd6vtp1RgeJK80wsC+Z88OahMT69b2kD2M1jPYnfvGdyz
	5cbi3019sulQhnuEiiwehjBBxYmTria/sK/xpkihilRIABSb1bsTHfaXSADCHwE+GenEbpjcOwn
	KDdBlhveBOpIH0Gv4Efmf6nTGELN2HuvkgZQn+9oFZyndL088PJ1M
X-Google-Smtp-Source: AGHT+IF4ajsY7TSW0w2cltpeiR3Y44gTYcWo/2pv8CO+hAiKdk1ZuHmaFqdShvixe7b/cut30bzhRw==
X-Received: by 2002:a05:6000:2002:b0:3ee:126a:7aab with SMTP id ffacd0b85a97d-40e4dabf373mr19174181f8f.57.1759235893126;
        Tue, 30 Sep 2025 05:38:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fc88b0779sm22291541f8f.58.2025.09.30.05.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:38:12 -0700 (PDT)
Date: Tue, 30 Sep 2025 15:38:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Robert Love <robert.w.love@intel.com>
Cc: Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] scsi: libfc: Prevent integer overflow in fc_fcp_recv_data()
Message-ID: <aNvPMet7TPtM9CY1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "offset" comes from the skb->data that we received.  Here the code is
verifying that "offset + len" is within bounds however it does not take
integer overflows into account.  Use size_add() to be safe.

This would only be an issue on 32bit systems which are probably a very
small percent of the users.  Still, it's worth fixing just for
correctness sake.

Fixes: 42e9a92fe6a9 ("[SCSI] libfc: A modular Fibre Channel library")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/scsi/libfc/fc_fcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libfc/fc_fcp.c b/drivers/scsi/libfc/fc_fcp.c
index 16d0f02af1e4..31d08c115521 100644
--- a/drivers/scsi/libfc/fc_fcp.c
+++ b/drivers/scsi/libfc/fc_fcp.c
@@ -503,7 +503,7 @@ static void fc_fcp_recv_data(struct fc_fcp_pkt *fsp, struct fc_frame *fp)
 		host_bcode = FC_ERROR;
 		goto err;
 	}
-	if (offset + len > fsp->data_len) {
+	if (size_add(offset, len) > fsp->data_len) {
 		/* this should never happen */
 		if ((fr_flags(fp) & FCPHF_CRC_UNCHECKED) &&
 		    fc_frame_crc_check(fp))
-- 
2.51.0



Return-Path: <linux-kernel+bounces-880234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EF9C25312
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A66C4F6343
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D5634A3CA;
	Fri, 31 Oct 2025 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQR60u0X"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB852E6CA8
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915831; cv=none; b=gyO5GBcPnhFOrE5CzQGM/S0dyb2BDQgwCtIgqkFBxccmHFBNK2/UXYg3DXmNxUa4n4WPp8Bv54ifxmSlUD6kpJvEvBcUTwaBdwbmWZnGDqwrRSNAWztlqEflQCzkLXkHs9wHDJcclyLrUdJH9yiErO5Q+A0Mzcn62rkmcmlptC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915831; c=relaxed/simple;
	bh=PVe6ChdFzqsrPY5cNbPkVd3xBg+1jaFSAtH7ArWrwWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F0qfZxo+pzf7TuHEsVfu+CASTqNnurMOdAYdRKzDfbKOOeQ5jMnaLYOeP/EZrNRnqTVdzl7T21W6YGSmOY0vUjLM25kPIWLZDGY60es5M/lTI9kECG5g5xLIgpIq490PkXA/CdgmlqF/XUXtFscmLNH7lsvggOyeROUvn252ZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iQR60u0X; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47721293fd3so13018805e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761915828; x=1762520628; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mDV8O3FoSMhSVn/a5ZT560ij4xBeHKhaaWQkgweA8k=;
        b=iQR60u0XklIfO7r3iyZkrG4ta/sGjfTpM5dX3gLOJfAyXb7adaIOh8xF4MLuzI3c4S
         fMJGALstKYNs89lSobplaX0yemRVP0xsLBnKG2qOVwbdZsJQ+cq1gXuGj8gxFKJF8e2G
         tRtGgQ4b1o7gDdEd9RCV2yrmNVaUrFTXL8/1bfsXHPGeArL0oVs4KAB2Ji/vZZxp+v+Z
         5jM5BK3Uv96RpZLJJjBQ6WgNVwlrscy4+C1EO3EV1rlxnj6nnFz/BsXJYpo/tiLkrBp8
         b6gynjmbbhWXbVre49gecy+S6FHD59CjeOb0cASGNSluiOZTyRXKUc64V4NfDrFTsDrz
         QF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915828; x=1762520628;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mDV8O3FoSMhSVn/a5ZT560ij4xBeHKhaaWQkgweA8k=;
        b=Jyj7Gbyqbu6+hGyfgTA8MPfUKGqGqdB1/QfNudcqwU+qeCQIuRO6rhLf/FOA3GtMYe
         c+DkIfk8gBxvNHy49RW9ON2wiw4rhXaLSWe84ka7x0q5PG8t6g2AWTyPeZ30L/V7WXXJ
         TgAzNkIZEHe5EVmEefbI2uyOCVPJXmojt4bhGqXj1CCAWUMlI+JVL6ZfQTnfB2uDetWn
         3EtuWKbIGO0nckU4fo50iQdvbkNjRPg/kaC+tSKNqwnpk4C7krnQTsTxe7p+yY5J7tMP
         EKexfSfQUCeBVKONnwzRrpmf/Fq/vsDHysCePEa2L8FuZkHJ+RSbl6YoOfU/PPXvuvS7
         LiGA==
X-Forwarded-Encrypted: i=1; AJvYcCVbXrLu8cTEmZ+qYFFplLmxMzOmHr+zaiJCge/zR15r8wFK2x4juahXIHpIN5tmYt2QCwLADKpNqFXjGtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+bFTX4W7+5Qq+Dk2OUbUJIxgqLMgo3AG0aGeTC2wCUD2j883J
	WgDr6IfcSzEXq741koIu9jt+/1tJEmz6bpIblJxkD2uaLrgHCvx2DW1v5jKDLxU18Vc=
X-Gm-Gg: ASbGncvsIHQnB+M+EJ9S3yHgR68d0g0PUo1Q+XXqHH+qGFTdZi76evgrr9roMuziy7r
	jN/VwGCTt64bmmo38tW2sX5kzO0D6W1bPm+K3CaSYmMVz/cMuyCJk2mK8MELe0DFLEdW/IA7xro
	dTrOZc+Yi6DY8wTyZNTaMJL4qU1aryfq5KL5yt1FnPsrPRXKCjic5GpEWnLWCQVbheLR5J1OZUh
	gCtWsdv6bEaZW3eub6TdOyvUZhytoD5K5YS6aEqMfI5OEOXRPMhbf3unJJqa7idPv78Vqf79ghQ
	2F5mjMlFwzc2z2ydRp9jjHsr3kXrRA+dE87C82i64we+yyewJzXhO/wh9JaSm2b2STfjwy09jcD
	XYN0TiNDljOE1+GTr+KmFbwbCRQ9x3LLmXcvyqyY9TNjqhVLhbA2Uzrpwo/clyYGzVqgGjPdx+M
	J0Zf7CJXOb/KOPiit+
X-Google-Smtp-Source: AGHT+IG/dcwtB3BjhLCI+K3wmR+DpgBUZwEX6TgzCgzBBCTL3vH0oZwBfJnMRLLw2rYEixnMOXzTGg==
X-Received: by 2002:a05:600c:3495:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-477300980dcmr36025765e9.6.1761915827364;
        Fri, 31 Oct 2025 06:03:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4772fcf38c6sm21694675e9.11.2025.10.31.06.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:03:46 -0700 (PDT)
Date: Fri, 31 Oct 2025 16:03:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexey Starikovskiy <astarikovskiy@suse.de>,
	Harshit Mogalapalli <harshit.m.mogalapalli@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ACPI: SBS: Fix present test in acpi_battery_read()
Message-ID: <aQSzr4NynN2mpEvG@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The battery->present variable is a 1 bit bitfield in a u8.  This means
that the "state & (1 << battery->id)" test will only work when
"battery->id" is zero, otherwise ->present is zero.  Fix this by adding
a !!.

Fixes: db1c291af7ad ("ACPI: SBS: Make SBS reads table-driven.")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This is a new static checker warning that Harshit and I wrote.  It's
untested.

 drivers/acpi/sbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index a3f95a3fffde..d3edc3bcbf01 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -487,7 +487,7 @@ static int acpi_battery_read(struct acpi_battery *battery)
 		if (result)
 			return result;
 
-		battery->present = state & (1 << battery->id);
+		battery->present = !!(state & (1 << battery->id));
 		if (!battery->present)
 			return 0;
 
-- 
2.51.0



Return-Path: <linux-kernel+bounces-820842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1512B7F6E8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCD83B067B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92643316184;
	Wed, 17 Sep 2025 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtPl/jKH"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE962FBDFD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116182; cv=none; b=ddFw2N11QMXw6RjFgXvCtl/qSadXKu1iWVEL1EFQJrLsRaz6rf/qD91+Z5QvaALEWIU4bvwhbj0aCX1XGaujyxlkYfGMskb9ziFkegVDualGYhU2jwmRT8gxBofcJEZizqJUxlsEEc7sJaxCYSDn8yeEbW2YrvO6M/qrtJJRthk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116182; c=relaxed/simple;
	bh=MtQCXnttJR/RcxFaVTufRgSNP+DGHAXDkUOxfUvzCj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCZZ68NfDbuhyJVuLnIgni9nQ0kSCeQIENlyNTbnb30h4CBR20fJNFQTgp/PBHb6AEj0cm9leASi9Igw1ZPq0HtmVvpMcfixmEUu7q6/FXT/xj7d/BH3BCjnaFUUh8Wfz2XJIAxN3LW+dh26CjjrIXmh67eANHv+9a32IjyCoDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtPl/jKH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f2f7ae386so26086375e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758116177; x=1758720977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2581FwEkYAN4RKWLim2gOtzFCASxyCQN0tdBJDniyU=;
        b=KtPl/jKHyufq2LQhLEG/E20LHnN7dCtwhekkaUmpJLlDfJmtfcbxVd0yPKtOPYSryD
         MLQBfRHj0FVuXoe1pzjcUHpHF1kb62hb/5gIee4BLNTYLtKScOAuQ27oXPXoU1EPrPlQ
         UQCWwXFLPB91LAH8oDpgRfpA8HzoIWLlbZvZQhGg9Ku1ue4v/M3kmZ/+mgkRCAQ+izN4
         t6EdMFC4DE2lNt2dBYOe0vNbbnOrjhRofu3aHwL5jqDQlOTq/kAIXAAzwl6ve4fvo5X7
         aJT0d5GXce3vCH7n6rfkrrJiT/f4YUeTu198hyaKRj0Hi1tu/enI42sccs80NruztFYd
         CIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116177; x=1758720977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2581FwEkYAN4RKWLim2gOtzFCASxyCQN0tdBJDniyU=;
        b=P22eXNe9r82aB/IHw2zcqgsgs+/HgoehWhnKGM1MJ4gqClNXkcdngeADuza/DbleDr
         xwffyE4SZjtQfjfYrzZuDd8iCjeVSneagO7zWqUfr6LFmuDjPu5Ahf7crZTSjwv8ge4p
         AcaKc+ziiSPeUEyHiNCQ3w1eM6nBk86+yea5LXwi/f2CFTS+XFP94GGl6562sAIa2Y41
         D7d1t/paMf4+1zzJCu4q2SyAh36Vy5awSYF/hyx+RW6zNX4omjGx5wec36r9yJzHKA5i
         hxAaOHSrEIUoYEa0WdSQAlIh23cZYBIFlkIBi1fgWca3eUOEHJuVbfSi0Mptgn/xIOl6
         A8Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWs5O1Oo2P3jg2aCW9wPnvepgrRwpqwDr1y6V8jXig4qpLm1ePBFm9tOTafL/rxIRjSEbMxe0XS1jYWgzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZ4JiSA1jHua/FHBBQp+vcDRc/ZbxIA9oqE85q26VLX6hrcQM
	EL32avYomEsyIZKmln/SetDN8WIx+qye2x/af78KyeNfnPEg8ElvoZJCjlE1Rw==
X-Gm-Gg: ASbGncuoA1Gq+I6JI67wuq9PUmsjTGrBaOlvD4199nmM5yxpcqta2f7Bcmn+/FgO1nD
	J+lZqti3mg0FxXvO/mjSrLtXvKt9d9TDSTiivVjYKpJJwWunZC/LUFFI5Fd1h2hZv7fs7ddB3J/
	3Yc23zuKsfT+Y/WHVqLPD1LA0weoZcxLQM7ZzSQPfYlKqi8+1wSzkzmAO8Fxc7GiZ2ueN1sRVS3
	faTH+eY+FhZ2cz0R0fOZc414r3dhRlFAFNxqHxZVohsMX1ByNv55NtnUFLAKBHAWm//EFj+Cp0h
	CygrgJ9KXYqtIETSZJgXDH+oL+iHZ6pzSRQignV5EWWq/gRqZe8JrlbgDzMTvZMn2Q0Kq65cBEQ
	Giz9U+7hokwd+fbikmN4+dFAkwHuX5g==
X-Google-Smtp-Source: AGHT+IGS+zF0/zQwksQYOyUdRfb5vrA+loY0yqP1AHLYXXk/GAthk5FmNpqgANWxGaRWb7A7en8cCQ==
X-Received: by 2002:a05:600c:4fc4:b0:45d:d0d6:223f with SMTP id 5b1f17b1804b1-461fca45769mr23225415e9.0.1758116177331;
        Wed, 17 Sep 2025 06:36:17 -0700 (PDT)
Received: from hangmanPC.. ([86.124.200.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139ab391bsm38198075e9.21.2025.09.17.06.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:36:16 -0700 (PDT)
From: Cezar Chiru <chiru.cezar.89@gmail.com>
To: andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezar Chiru <chiru.cezar.89@gmail.com>
Subject: [PATCH v4 0/3] i2c: pcf8584: Fix errors reported by checkpatch.pl
Date: Wed, 17 Sep 2025 16:35:21 +0300
Message-ID: <20250917133524.85063-1-chiru.cezar.89@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250907114557.15453-1-chiru.cezar.89@gmail.com>
References: <20250907114557.15453-1-chiru.cezar.89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello maintainers,

This patch series fixes 18 errors reported by checkpatch.pl on 
drivers/i2c/algos/i2c-algo-pcf.c file.

The series PATCH v1 to PATCH v4 is a response to the discussion on the mailing
list with Markus Elfring who had comments on my earlier submissions. 
He suggested:
 -to split my initial submission in a patch series
 -had some valid points on imperative mood usage in commit messages
 -wrapping commit message to 75 columns per line
 -change some of the commit message to point usage of checkpatch.pl

Here is a brief summary and order of patches to be applied:

Patch 1/3: i2c: pcf8584: Fix debug macros defines of if statements
This patch encloses the debug macro defines of if statements in do-while
loops.

Patch 2/3: i2c: pcf8584: Fix do not use assignment inside if conditional
This patch takes the assignement from if conditional and moves it by 1 line
up.

Patch 3/3: i2c: pcf8584: Fix space(s) required before or after different
           operators
This patch adds space(s) around, before or after some binary operators
and punctuation marks.

Testing:
   *built kernel and modules with I2C_ALGOPCF=m and my 3 patches applied on
   top of 6.17.0-rc6.
   *installed kernel and external modules generated by build on my laptop
   *rebooted and loaded i2c-algo-pcf.ko with param i2c_debug=2/3/9.
   *No success message related to i2c_algo_pcf was seen in dmesg but also no
   errors.
   *Module loading and unloading successful.
   *No PCF8584 Hardware was available.
 
Patches 1 and 3 report 4 and 6 warnings when running checkpatch on them.
They appeared because of two errors/warnings on the same line of code.
But the warnings will be fixed in a new patchset that addresses fixing 
warnings.
 


Cezar Chiru (3):
  i2c: pcf8584: Fix debug macros defines of if statements
  i2c: pcf8584: Fix do not use assignment inside if conditional
  i2c: pcf8584: Fix space(s) required before or after different
    operators

 drivers/i2c/algos/i2c-algo-pcf.c | 62 ++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 23 deletions(-)

-- 
2.43.0



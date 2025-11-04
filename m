Return-Path: <linux-kernel+bounces-884798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B13D9C312D4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60995427FBF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1120C2F619B;
	Tue,  4 Nov 2025 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlYkb6KR"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2C2F3C1E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262021; cv=none; b=HGXwb30mmbf0T7Y0DppH7nieo1UfgrJI9/nbNRC1wLWCdoX7JrJyi2aVLpAmQsH82K65D02DpDTtgnM6fhfxXvmdK5+mA9nkE+HnhqthMkWR5cgZ1bRj+whEBlNLY0UKtOnKVJtDK2fzrYvxhXZFBvdt84GEDBb3eI8TJBfqIos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262021; c=relaxed/simple;
	bh=zReFbCpQpq9hx7S5OuXnYnE+WALGscFOwncxZWVvVD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dvM9krc88xRRzudYS6H5TDcGviZC+39TKuo7TKEX0Sx6gsXJHexGyjB701frlUcB1/G8Fwx2YgTYAS8yfk7QUJVmdeHGpzuTGQRvBKucul0c6uTlQn0gb/Au3kxmNLq897x2pFyD/qQdhY7S/QJKi4QaHakXMnVLDVShBKgXU8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlYkb6KR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2958db8ae4fso25471785ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762262019; x=1762866819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GQu9QKoK4tGUZ4g1byHHuUCj0MWqs0LgGabAs46ovQI=;
        b=dlYkb6KR/UW9LKWC9ves9afbFubRq69qhTidO/jqnz4jxTfSKfbh0c8pdOBPUMEpjd
         ANM/SV4e+opVC47L+0JgEz619QAnnyNk+HM5bQiVQ9sLTiS/2numzUPog15MGLruP08o
         NHeFyHy2B6Tg4lMzXyZThDP5S6whqybd3Y5s17GiCIRjStBA4wvvtnqxsam48EOYqiMb
         EGPDR8xGGxync7uy7MAPEjmW/iak2U6qLYlfDXWw8kbrzQx44e4y6xNSxc0jad/yGvrl
         nR3j5hFOXzVAYSoGiFVPqllo4D7khBoN1tjlcbOwxptjbBkMfWgUx59k3j1Ti3cRt45o
         wftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762262019; x=1762866819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQu9QKoK4tGUZ4g1byHHuUCj0MWqs0LgGabAs46ovQI=;
        b=uvlJFzW8bUJvz1ZBKo+Ab1TiKkrQdzHe1gm18MqseddKsS1mWSamFaFyWkPT/xZWHS
         SNbZh/FT8lsF/F6o6h/I511E2BPsdVTYDsh3LncUcOhBnNtZL+de813PTFNDKbfeX/AZ
         mv7E6Cs09S/ccal4OXr2sJtWTcQJlgbcAJXzSaG0139lh0qSRNiY6gELbmN0fGKvk2fI
         7xKMKP5Mwogdpz98+BctRoc9kjLsR8nZBdxBWlX85BiYFQfLJBKVVLH57zLNYkZJrKK5
         7G00iwU9WLqQsAoxex0MnZFpUzbl9nShWkVOEkpDUtE9jY7OvjSK5wQUWKemC7gWEPeF
         CMHw==
X-Gm-Message-State: AOJu0YzlM5dLhaxWTvZLc6Oe9khP+5/cFAcofZ4bqcgEH14aC5Fe1TAD
	/6JMuPnYDgbfAYHMUXbIqRXGtDvj4rE6Bs/4Fa0Omi7osfrtZOupi0QSV4LoCOaxjXs=
X-Gm-Gg: ASbGncvnF8QBEGmZ4iL3uHWHvL99sYAmtm6fivlF8IVED+Y81EAbiDH7jbq9pgG20xG
	RCaaRWRdT94p7OZ8wm2HieqKTQtqo6LtMFrperTaLVkiv3SLiQvGz05Cu8WxZGbOQ3+G+WQbdbH
	evRuCrRPYXce/uBN1JRanMbSYcgwOT1830ThU+ni9DKznjbxl0WqeLggaE6+FhRep9ms9DqxRew
	o3vpxlYLdImJaO74Z/Ih8G4kCJzxTegYS/qiq6gsdgx1tPOz7pRWF3hgUEfiFnenXnS73JUSsbp
	LmerHCylI6N8Q4bOZX5BgmBlvW2/LePS16kkd9vM3u8Ili1fG4rEhJwLRKRdUsUdwmAwrsavi9u
	s8Vm7lo7FSuTPw5c+BUSrP3UsOauB+DBuzmlcxC3nlU98QlBZhl7t04u5bMRLWimuEItkgookzi
	li
X-Google-Smtp-Source: AGHT+IHpp78yI4E7fmdg4RKErbV+vvTaqrD8H4+Tl6H9yDf3Xf2PrS+XAQqFQAashL3w1qH77cAnFQ==
X-Received: by 2002:a17:903:32c2:b0:295:5da6:6014 with SMTP id d9443c01a7336-2955da66415mr134706725ad.22.1762262018823;
        Tue, 04 Nov 2025 05:13:38 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296019729b5sm26887345ad.10.2025.11.04.05.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:13:38 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 48956420A6A8; Tue, 04 Nov 2025 20:13:27 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Integrity <linux-integrity@vger.kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: tpm: tpm-security: Demote "Null Primary Key Certification in Userspace" section
Date: Tue,  4 Nov 2025 20:13:12 +0700
Message-ID: <20251104131312.23791-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=bagasdotme@gmail.com; h=from:subject; bh=zReFbCpQpq9hx7S5OuXnYnE+WALGscFOwncxZWVvVD4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmcv91Wn2n+Py0/tO3Haeca1lyzF8xGxueOf4uY+mTxt TshKpJWHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZhIWzDD/xCPHIYmWafsYBYr mejACZNcgm5f/TxP6+qB+8r/egznCDEyPJZj/BY664JLhHKtoetF1XUlqpLRncuTn5opS+tx3BN nAQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

The last section heading in TPM security docs is formatted as title
heading instead. As such, it shows up as TPM toctree entry. Demote it
to section heading as appropriate.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/security/tpm/tpm-security.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/security/tpm/tpm-security.rst b/Documentation/security/tpm/tpm-security.rst
index 4f633f2510336b..bf73bbe66db2fa 100644
--- a/Documentation/security/tpm/tpm-security.rst
+++ b/Documentation/security/tpm/tpm-security.rst
@@ -153,7 +153,7 @@ protect key sealing and parameter decryption to protect key unsealing
 and random number generation.
 
 Null Primary Key Certification in Userspace
-===========================================
+-------------------------------------------
 
 Every TPM comes shipped with a couple of X.509 certificates for the
 primary endorsement key.  This document assumes that the Elliptic

base-commit: 27600b51fbc8b9a4eba18c8d88d7edb146605f3f
-- 
An old man doll... just what I always wanted! - Clara



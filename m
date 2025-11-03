Return-Path: <linux-kernel+bounces-882176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8F6C29D12
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316743B0708
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 01:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8B227EC7C;
	Mon,  3 Nov 2025 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwRgezbD"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB1F27B347
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134665; cv=none; b=lgszb9UHpnPb+RBEGVDHe56qchPA3ajrw/My+EmrW4xgwTyYGYlcAhr9Hfci0bC3Nhnkz53FwO1sUlFr5tBq7sMYYaTh9paEWKYIqLFGmHtXloGnG/awlhGBGUHPChREMv/h+nhQkdTVJSVQG2aJPZ6aQz5R93SFFMMY+3Jr+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134665; c=relaxed/simple;
	bh=0r/UGJ3UaHLl4TwoicvZX0eMMWSJJZ+kcuaobIcvNx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHHWtxEkgr8sarF9Ixt4naly/fWGrKyq+v11NyUxWsdiEw0CSjWy+08MwkIf/QYC2wVg9zlNStzPbnuvucksQMGokW1Nx3VFpztMghnMVzDAoV8MNOsxAc+1rnUMzJmwOVAqnia5zpdmr4Bl6hVbdrxsAucrIULcolGwsyjNqII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwRgezbD; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a9e8a15502so694608b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 17:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134663; x=1762739463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KN/frS9jg4jcQJc1DwfaOMBwxNMdwpEGRN00rohe3M=;
        b=EwRgezbDlhoWcprUkaNEHibHFGQ8dNtgj/2Q028Qf8vv5WZnvFsAkRziTvSbnXQq8/
         Q0mHrpFuqfUMj2MZKFRYGIbHJi98zM84cE1zeRISng+g9+fObEceqZs528gvxbrK/RZ8
         oFNk6Fsv8H8ph5Cbxg++0eybjG/LIBQPi1W9QTed+kRvoinB7cH2geboDc9ZaQPX6gx3
         Ns6LUfV2ZUhfIGjTGrXpGERnyS+bgJdLesSk3NRd2fm480nDgt7ykrc+YBuU+ubhJlwv
         kDd9HNikS2AMwCmfyf1siOztmltQWabtukqAHeLRWgguVSwX++3tzPt124SCAdZd4AlZ
         HptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134663; x=1762739463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KN/frS9jg4jcQJc1DwfaOMBwxNMdwpEGRN00rohe3M=;
        b=OBqtvdGk9sW9004IDJi7JcyqiRO982yTCLLdgwYv0UwLn4xRYj5hAIuJUzTq1gSPHD
         5eIjMggxBzhxDbnDKJ+tuC533OavvuXXKmTiJXfUXbB5FM5/SYAwWdcvZwFcv/g7W9aW
         5Y1FP2mWv1pqsvvtidpJAwlO4NjuGH0RFw4R71FQlRk3nbrANEuqrdC1ZxhRuPDQCzjW
         HO5VNv29S2HXBepcoOZweb6bNp+eYrlFBeXt+pgvW7xPp2oPcUla+ktRfAtnhadsay4P
         0PQ1ymDd4/adQboezn1tvhQiWkLemld1qcvxMCspcjiaJFnWVEseFOgbaVQFAeAfaugd
         0OHw==
X-Gm-Message-State: AOJu0Ywjzddxadjo/CKngzjAHUZLE2ZxfgAhqXMu1+GtefqwN4LXI8x5
	GcVX05uImk3/LN5OXn/jyzaywHMCz/lzfrpi2My2t0otdq4uGhQOZX76ORPsJk/+qx8=
X-Gm-Gg: ASbGncuZLrk25p+/gZUT5Rv+k2AzXcrfPRGW/+qfn48y7K7Kr7e9bwlbg6h5H5WTxdN
	8AOokCH8EX3AG1G5rUbBk5+mc5imhe/yuwK/2wa1BmYJaM0JmMQ1JVg8lSBf5Tv/V7uPzcSXOG/
	U1M0LFhwEwguksuEOBweju69CZbZ1yMV9JsUKX2EiruSRlE/CrkiE079ZLqpZKn6xAP28bCN9y8
	OskTyKsn1p30mI9MTN/o67fMRoaKtz2u2/BaOHQYrCGP8Zj472C4KFKmYjfA/J4rHdf3+gKUUUO
	E3rdkveqrDZl/GWYQiH+hQl3ey37zn5PfR2c2b1IU36pG7lCG9yGFSRZGMbRofXxa0qBZBBezbJ
	ec6RXImzpJ0TNqDZT7P24tLkitiS14W0LLkvvC1UO+xDKeUNlje7dCZNqiw00rZnnA23dmSTuUg
	Y3YO7F20rhK1I=
X-Google-Smtp-Source: AGHT+IGD4WRREftRM6ToUw5Q5yEFGiHtK4Gw2g6ae24ZSedhjeRUUXh9RiimnhCWPd2uKN0IPOjeMw==
X-Received: by 2002:a05:6a20:6a08:b0:334:8d0b:6640 with SMTP id adf61e73a8af0-348c9f667d4mr14767943637.8.1762134663232;
        Sun, 02 Nov 2025 17:51:03 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db87340esm9078805b3a.63.2025.11.02.17.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 17:51:01 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 09F9941BEABF; Mon, 03 Nov 2025 08:50:58 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next v3 3/9] Documentation: xfrm_device: Separate hardware offload sublists
Date: Mon,  3 Nov 2025 08:50:24 +0700
Message-ID: <20251103015029.17018-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103015029.17018-2-bagasdotme@gmail.com>
References: <20251103015029.17018-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=bagasdotme@gmail.com; h=from:subject; bh=0r/UGJ3UaHLl4TwoicvZX0eMMWSJJZ+kcuaobIcvNx8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkcnBX/m7b25d7r3tVfKtM8QcHml1VyUNKF9cw7funk7 tpoyfq3o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABP558bw331326LAFd9vrv4j 17Xb4b7jk9zE6E+z64qdjpRdOnpbOISR4dWt0xvu2HB9cqlRfZXM8HvOdof8bsNQl8i7SbuCfr7 I4gIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sublists of hardware offload type lists are rendered in combined
paragraph due to lack of separator from their parent list. Add it.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_device.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index 86db3f42552dd0..b0d85a5f57d1d5 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -20,11 +20,15 @@ can radically increase throughput and decrease CPU utilization.  The XFRM
 Device interface allows NIC drivers to offer to the stack access to the
 hardware offload.
 
-Right now, there are two types of hardware offload that kernel supports.
+Right now, there are two types of hardware offload that kernel supports:
+
  * IPsec crypto offload:
+
    * NIC performs encrypt/decrypt
    * Kernel does everything else
+
  * IPsec packet offload:
+
    * NIC performs encrypt/decrypt
    * NIC does encapsulation
    * Kernel and NIC have SA and policy in-sync
-- 
An old man doll... just what I always wanted! - Clara



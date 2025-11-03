Return-Path: <linux-kernel+bounces-882177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F3AC29D15
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E151885677
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 01:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20FA27FB18;
	Mon,  3 Nov 2025 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gz447jUx"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C81527B4EB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134666; cv=none; b=XhwUTLu5UQ6pQ4iQqdXh4gODeIMDLLCsWdYleWfpVjIDkDDZoT8x6ogBrccFIqwcWfI9q7e4kpmpmQh2Tib91rrZJcV31SXgvXo8HRWKfxRA45G46fiZi3J8FplTBGzEZbfHqltdJKYELl374sj0Ce9rsQZl/e2b92kWw2Y21J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134666; c=relaxed/simple;
	bh=jBrlYcqe70CRFPI8eWpEHN0i3WJ0kusKzZ2MB0TsxBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aU12hHStgU4SRH9UUGn7G+DhjZFQA4/yfGEu6R86RbdxhCQ3R7nJ2NN7CxEoDmPTkaGY+dhEjBJHDx4J7ySvBFB1C/E+Uy/6Z0Gm2k4qHHumLtZyHe+MIUE42tiip/u6ACiBmqAK3n4dvVvT/Lwq1roRo5rDJj6gLuLuFYYvwWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gz447jUx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-330b4739538so3897669a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 17:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134663; x=1762739463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lh5XxpkroE5dbbQU8eQ46vBGwFwM21sJCPsPPmpqn7w=;
        b=Gz447jUx34QLyxGksRc5QIYrj5C2vZMNJIAeFzz0HP2ooxu/aiVXl6ZPUIL/pq5+On
         ea6oxXMSSBX7VrSnSGLHQuuWM6wWJjVTa4CcndyXy4BgVKsl7vrQBQE2Nexq9khXNmHe
         niu6ocUJmHnc9w3BB0jbjciSWBMUuSmtXPX+A6vlODFcHirAvlbiMwABBaJIG/gmSexT
         OQlADH6aO6jspiB7HxrHvMS/3jXsDTJUPjVoRufqLWc+mBKCdBs3DqL4hgURApkter5c
         5UMeyaeBZhLowBVBEbegSwiUR1puCgbbTt8UyG1JKV27mWFwKMo2iTgs75HKn8JztXUI
         doRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134663; x=1762739463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lh5XxpkroE5dbbQU8eQ46vBGwFwM21sJCPsPPmpqn7w=;
        b=KGx9lDdv8iX4Kzwelkei7U/YtCG8BFKx2cOCaz2UetKupLr+QocoQ6rRGJXrqsJy9/
         Ayd2LhOkzAvU9Nerd1MXBCyCxa4ShWjd6N/j0STvSwOgDVPxaDIDZ+tACQuF8S4ITiPg
         I0flYSoAXKuRHcjHE5jE0c35yytmwEb92SZPpRLUTwGRO8+lRiXtuP6L4Yo992A9cqov
         8EQHgEa4bVX3X7NflqtAE5qEk3hs9WQ45LLr6bvhbKAm7aRMooS6RXmAWOdPQ3et1yFz
         IqLlBta5hTPTC4FqVnrAxG0o1mJ3PKT49rFyQlwP4XH9/NKOpUm3hoFX2zr+2m1esuEn
         XG8w==
X-Gm-Message-State: AOJu0Ywa0mo90YE6J8H4xqCm+CB3ihEbU6VEVEey/3U3sarT92eUCEo/
	LZa9jcKtNtRw8QGfWHF2rSlVC0aJgm8hj1wwJBvZG5MPTgFu8XdmvSaq
X-Gm-Gg: ASbGncvfbghsUyfXGmtPcp/sUU4pvoISQc+Pvvxpes3E/yZFB4fxVXfrC34di8GceMk
	P0QI0zo9ZystLbfs936IRAXbxBpmRdcS0Ck/qxGvhw1xfuCQj0KZaAiVk3VmWSxIhamqt1q+oCg
	Zo0oANBQ6YwuP0vrRJ+gB8DFQrWIlwCA6fZahxfseNmsSQWFhXHXSiFzVFfixtoyP9mGdK1WKk3
	v/LGT7mY3XAT+yDMFIC5LBri8MtVvTKN23mConF5Rr+3tfNvCzPjIseMqoKa3UdzS0+3eEvv6Q3
	JcYhFfc9Fh02COYW9YW2Clqz5Z052I+R+FmzT3iqsMG4pvB7yAFLMHgwelGgfN5qwJuM4bCrccq
	XpeSmtKhzKWtkQacZ7d7yHWJkke4EHA5Pt9bRVFD2sMAmwhB/oXH/dMasYMdnYur1nUiDqeZWKG
	MmDnPo+C5fpXLFrCBLCL62UA==
X-Google-Smtp-Source: AGHT+IHWBJuGJ1zWKTvkSZmeCAOVjB3t/eUUN+iIole+MPcpb/alnDn5XwGocUcD6UqDZTVGGC4/rQ==
X-Received: by 2002:a17:90b:28c8:b0:340:c261:f9db with SMTP id 98e67ed59e1d1-340c261fc52mr6496768a91.10.1762134662833;
        Sun, 02 Nov 2025 17:51:02 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34050bb62casm12814486a91.20.2025.11.02.17.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 17:51:01 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id EAFA841C0600; Mon, 03 Nov 2025 08:50:58 +0700 (WIB)
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
Subject: [PATCH net-next v3 2/9] Documentation: xfrm_device: Use numbered list for offloading steps
Date: Mon,  3 Nov 2025 08:50:23 +0700
Message-ID: <20251103015029.17018-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103015029.17018-2-bagasdotme@gmail.com>
References: <20251103015029.17018-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=bagasdotme@gmail.com; h=from:subject; bh=jBrlYcqe70CRFPI8eWpEHN0i3WJ0kusKzZ2MB0TsxBA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkcnBU7cwU/MkvfbFgUJXjzo3c9u3iYQnvP7Lbu7+sy6 3SSZu7tKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwEQs5zD8s+w5vX7N+n0z6/fH 23+TsmbK4eR6vS/R4j0bb8eClHkfLjIytAsX1P7izXa47e4tJ68ZsqNYiiM4+EPJ5Gdrrzrq5K9 iAgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Format xfrm offloading steps as numbered list.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_device.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index 7a13075b5bf06a..86db3f42552dd0 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -153,26 +153,26 @@ the packet's skb.  At this point the data should be decrypted but the
 IPsec headers are still in the packet data; they are removed later up
 the stack in xfrm_input().
 
-	find and hold the SA that was used to the Rx skb::
+1. Find and hold the SA that was used to the Rx skb::
 
-		get spi, protocol, and destination IP from packet headers
+		/* get spi, protocol, and destination IP from packet headers */
 		xs = find xs from (spi, protocol, dest_IP)
 		xfrm_state_hold(xs);
 
-	store the state information into the skb::
+2. Store the state information into the skb::
 
 		sp = secpath_set(skb);
 		if (!sp) return;
 		sp->xvec[sp->len++] = xs;
 		sp->olen++;
 
-	indicate the success and/or error status of the offload::
+3. Indicate the success and/or error status of the offload::
 
 		xo = xfrm_offload(skb);
 		xo->flags = CRYPTO_DONE;
 		xo->status = crypto_status;
 
-	hand the packet to napi_gro_receive() as usual
+4. Hand the packet to napi_gro_receive() as usual.
 
 In ESN mode, xdo_dev_state_advance_esn() is called from
 xfrm_replay_advance_esn() for RX, and xfrm_replay_overflow_offload_esn for TX.
-- 
An old man doll... just what I always wanted! - Clara



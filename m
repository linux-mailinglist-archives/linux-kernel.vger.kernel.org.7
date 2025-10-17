Return-Path: <linux-kernel+bounces-857421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DBFBE6C11
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAE919A1B02
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9B5311948;
	Fri, 17 Oct 2025 06:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/fwrg0v"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FC52236F2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683554; cv=none; b=tqTmAiDL1/NMUBNNzLwRwdn5m636UCbIjtAIcXJJJIN8k99jaYx0nN/DEkQplAwgUrF5UJgxOLuG83NluFKyixiB1Vj3e5YwPCuvUvpN2Lu9qr2/UcJf4l1WWiEe65nfSu018mmJ+eaWKDE4Eqv5qnb0Qw+P1zW89jEJzR7w9w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683554; c=relaxed/simple;
	bh=ZLH3av1Lf6WPtlvrbUqYje4yk116CuTGkXGsaAWaNvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRKXnM13v22EzALcLr6vh1+c+LDOSZJccpbpAFEsK2KnnRqCNys7YHgMibQ9JYR61auYiLs1Q2mvyUAjzRIW7xgnkaSHY0E8wDqCmsowDhCd4rhXNB6L8/s9R08fujjgc31CPLgzTzxbGcxJflImVoHM98dVt693CH98OL5Xh5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/fwrg0v; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-78118e163e5so2408829b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760683552; x=1761288352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdshIMlRNJU3RJEsxCqgBNsG9buJVWf/bkHbjQKkwss=;
        b=P/fwrg0vpZ1aNbMdSmU+PzI9lcPE9RK8OnNQdK6PwctUsC0pGjMxtffYJR0acuLE6y
         MzuslzCfODLPbiLeeDoaRjC7s2G2RuKSdItJIyZ/A+EtwCIPjgH/epZAjF9HfHRHyYfJ
         C2v3ufCVDXfmM7YfugwoKXWqkfuu5e1nbaTNETykVyctQwL6dJIDOPt3B1431PpkHAL4
         pLhmsbyxHSNkXP5y1NudfU4gSCZvvggiYY6MryPEIs8R7UxQjb1u8L6KOZv9BiFut0/c
         wkFIVUX6qzdjjEiS4V3iEy/WRHP8M9KZFc2aQ4+xz7S+VIZBZY7S8rhnknOE21SbRIY4
         lVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760683552; x=1761288352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdshIMlRNJU3RJEsxCqgBNsG9buJVWf/bkHbjQKkwss=;
        b=riCWMgnXD24uITiEpjSZbgRStoti1/eB0QqiOFOSUNoZX0ep83kQRCw1vkOJYfe0jH
         BALGA/cAZu8QlMhMTugcdD41bxZhtR5DId+kVWKN9YLikK4F472qGwcNq36S1auwebXA
         ISknsojn+fXidWQCejxyvxZL690O/nSP+qvGw/8ALGf9/Kc3OCUOtzVOiTwlYASRQHBg
         KMSGegDKufbO1zoi+PB99ERR2c6IkDt3VVcp/aRzhMVyEP3YCHhkVkaUm+6A1pysX2ws
         Rp9UeT7tXqyHouPwiAQN/6+JnKeHDjr0XZkFWbFzpuhnpXg/tBZm6b2mQF7ME2SeYdpH
         HsZQ==
X-Gm-Message-State: AOJu0Yzm5n6R1xM9xPx6rY5N21TwRZBKt6A1wTY4LgIs033rBaEnpQh0
	kigHuOGWThFXDRRHoVWjXLYQlJ9ULaTosuUTSvmoWwoHzKFiSpRgQCDR
X-Gm-Gg: ASbGncu5VJawysoHI0BM7a6+63R6oqyqTcVATqIdZ9MzLCquFQeRM5uG8q5mjdstF5b
	07JJm5S1QZXbeDdJMezpMYo29XeyIOJNHFlWZ1QI98xlImLTD4ggddn5j24avqqeq3F8zdLiFdj
	T8tNBaTA/PW+jGMxmDBgp4N45bDr4QMim7tw1z6J82szWT1AkA4vW5qV1Ic+cGwCHQfsSnAi6LW
	hIB0/+p5iPJ2eDHuSjcCUCsy873c21GqEzG622MfybIffzm3QCH3yCVc9xkpDFh7PFsiV3CDPHK
	vjV/jgW7kMPxcbATR/5eso+rcNnaUZ3BsJt5VUylm6ZswLjR/qsvB0WIJ8d1i8ZtePS03CTZU2S
	Xy8qQ2CWTJLXAZWUffyIr0w0LEOEwT36Qg22GOnkKtNyqXYD8LUAyg2jBteyXxZ3cmx9spx6SEW
	bLMf4=
X-Google-Smtp-Source: AGHT+IFsyPzxxs80uuv3DSh602TaCVol8BZqwzAMzN7CXGrpFxd3J3/c9RZiykQ01q/KKGXKyCcwJA==
X-Received: by 2002:a05:6a20:1a83:b0:334:a854:64a7 with SMTP id adf61e73a8af0-334a85464afmr2701069637.3.1760683551802;
        Thu, 16 Oct 2025 23:45:51 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e1336sm24360687b3a.59.2025.10.16.23.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 23:45:50 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8DDBB4528ADE; Fri, 17 Oct 2025 13:45:44 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	linux-hams@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andreas Koensgen <ajk@comnets.uni-bremen.de>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 1/2] net: nfc: Format userspace interface subsection headings
Date: Fri, 17 Oct 2025 13:45:25 +0700
Message-ID: <20251017064525.28836-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017064525.28836-2-bagasdotme@gmail.com>
References: <20251017064525.28836-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1301; i=bagasdotme@gmail.com; h=from:subject; bh=ZLH3av1Lf6WPtlvrbUqYje4yk116CuTGkXGsaAWaNvY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkfnxw0OmArXbRC9PMe94q9n9c7ap7WabPsXVqmpbzxn eKEmI66jlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExEWYHhN+veBwWaHtFtX3e0 2MplFO4LLtaoYb2uUJa+rVSUa407J8M//d2GPot45n/8N23t461REzO/b5U4Ptf0Z/5b2blue5p EeQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Subsection headings of "Userspace interface" is written in normal
paragraph, all-capped. Properly format them as reST section headings.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/nfc.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/nfc.rst b/Documentation/networking/nfc.rst
index 9aab3a88c9b298..40173500614332 100644
--- a/Documentation/networking/nfc.rst
+++ b/Documentation/networking/nfc.rst
@@ -71,7 +71,8 @@ Userspace interface
 The userspace interface is divided in control operations and low-level data
 exchange operation.
 
-CONTROL OPERATIONS:
+Control operations
+------------------
 
 Generic netlink is used to implement the interface to the control operations.
 The operations are composed by commands and events, all listed below:
@@ -100,7 +101,8 @@ relevant information such as the supported NFC protocols.
 All polling operations requested through one netlink socket are stopped when
 it's closed.
 
-LOW-LEVEL DATA EXCHANGE:
+Low-level data exchange
+-----------------------
 
 The userspace must use PF_NFC sockets to perform any data communication with
 targets. All NFC sockets use AF_NFC::
-- 
An old man doll... just what I always wanted! - Clara



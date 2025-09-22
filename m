Return-Path: <linux-kernel+bounces-827010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D13EBB8FE13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA78218A25FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425E22FFF89;
	Mon, 22 Sep 2025 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG6vfFvI"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F182FE575
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535044; cv=none; b=N6AleUgZi4AKmVhcbDamURY1Qyl4FsureVa/6AQED2hWlnw5aqXhzTcpVdacp+u1lBzjs4zQYctU7NaCuC6o52ALeQvFzr8mxjVs2Dnskr6HXztbOb55dzxadeZZd94Vt/KfHkJQ0K0v8+auI63vkxjKxic5ZRi3fMPO3gJ+tko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535044; c=relaxed/simple;
	bh=kmQ+U8Enw1LU4PehAdujiEV2CtRVJfOvPpSqaxAbVhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJITUVcmLO8S9aectIL/v9rR95vSiqLnsavPdIDYMTwwQO/N13aokMX4Rz7Yq5gyqPESfMVNijA9iJ5pDffYMKCNceOHVW4cm3uz071IkKXj5DB51wGgIX8GtPvU0Jp0sjVeOS114dlZd911t8402ScgBOiG1SIjPu0TVu6FiUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG6vfFvI; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3306eb96da1so2653628a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758535042; x=1759139842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeB3FT7O6G7iODwiTHw497b3MyFZuWsXQP1LvFOC/Bk=;
        b=dG6vfFvIE1MRHIvxLMW0PTtStGICfLiXpkzT/CjoaD8ZLOAJ6AHleyaQ0u828lW9+g
         Jf1ulaz7C8QUM0+VE7b+j2S+wYlsfro5/sp0cZlwczfBMN0T1bTpDM804XkvpUdZ8g2M
         X50S0R1v+TUOxmjQYxTuQpbLRMDd+PnU21VTGu0AKUc9Z3p57TaIXiBGp8sn4126UzFk
         HUqBzXJPSlBHjQUMrn8PDw7ZmwQwK/+k1hd4MFIoUHqSFatQFbGtiZhfZN/exi1/piTg
         w0eoXX260LF3tQHWZl+jFPhwwpD891yVvbW2PEWYvIMw4GEE8P36Qpw0MOXCj5C/Ekv8
         rWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535042; x=1759139842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeB3FT7O6G7iODwiTHw497b3MyFZuWsXQP1LvFOC/Bk=;
        b=InnpuZr8kNKd9hXrnaeBG1wcT1rI7aFERTg+OQjZ5MjO14atMoiqMfDqBWaGCD5kNq
         GhK2gcS2cZXfXbTdiC9u6JU0GuDtwZY8pgM7USNgE4kD8mKdLv5IqgmXuuu5nXdlF4oF
         aLW93BUPeIZ8ZrlPpssU2T7+BaH7wPouu2ZPJjyXUEcaovRuVe8CCICh6QdfiAYnDl+/
         o8607LhENvQf9riXma7WGqPI1+JZZD8qpVkAHMOqQ0nwowAc37/5UR9gvPaWc/it95C0
         FUyeik4UZFz7ED389mD7TeosM/WfjRs36Wn9or5oQQW11DbQgtgw/6EqIrzsEQUA8o7J
         ZYCA==
X-Gm-Message-State: AOJu0YwwZJwfQdojCICCP0JC61D5p9vfl++uedhBeDZHlkUu1IVoxnXE
	aLPNZinO7cxWenYtoQy5kUhrUi6VL56A0BeFlJx789j5enJ/rwfwmCVyNXOl/Q==
X-Gm-Gg: ASbGncuxte8c7YTTZX9EIQvvfPRYhnk67JQpfnq6jKpKRwv99rHN5S+4wngXQaSc7mw
	iwOyatErvqsOL2i6nDoUr6kB4Z1dNC+lmfE7bBQU3vgWri3LtrqQRbG9mGdy79qQvelMkJzrOKj
	RejMKY68LodcZC+0KVigmRU1/+tGGVu4AXJkvKw2HNowtL6zn6t72VAe7U5Bcm+1TNJgAoaoni2
	0Y+LawSfmpBsD8gsfTq1Gpf32CuWPuk7MvKEmJGhTaIM5QGlGNzAZoHAmc2WXCIL319FlH9Etqn
	HP3Sp7vLScaPFdm2zl/VAxgM0/JQPBMfwCjQ8MWscYqNFwbw9GyK1yX7CcrB4Ybia1Zqi9IxWXG
	0yaw3PhSiGXRgGv6R4SxREw==
X-Google-Smtp-Source: AGHT+IEoygJmzEYO44daSPyeFaTBpaCMbE2ZfuMa7RzKKwvhLfvLaCA1dISw2KFcv2rO+bW3GUDBuw==
X-Received: by 2002:a17:90b:3888:b0:32b:c9fc:8aa2 with SMTP id 98e67ed59e1d1-3309834c048mr15642705a91.20.1758535042341;
        Mon, 22 Sep 2025 02:57:22 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306db47817sm6030258a91.4.2025.09.22.02.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:57:19 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C0AAF41A2EDE; Mon, 22 Sep 2025 16:57:15 +0700 (WIB)
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
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 1/3] net: dns_resolver: Use reST bullet list for features list
Date: Mon, 22 Sep 2025 16:56:46 +0700
Message-ID: <20250922095647.38390-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922095647.38390-2-bagasdotme@gmail.com>
References: <20250922095647.38390-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1221; i=bagasdotme@gmail.com; h=from:subject; bh=kmQ+U8Enw1LU4PehAdujiEV2CtRVJfOvPpSqaxAbVhE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkXZbb+nzixgEMs8fhJifu7PA9GTpZYkve3Sq1e+PPhp LifCgyPOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRJeqMDP+ro2fO17gVnPi0 cOlZm9xHHPOWui84fJ5Tfs9BKbZ2BxuG/yXLjHJv5bzO1o5f92za1Wlfb296waOufrCSt2Fe2xK 242wA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Features overview list uses an asterisk in parentheses (``(*)``)
as bullet list marker, which isn't supported by Sphinx as proper
bullet. Replace it with just asterisk.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/dns_resolver.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/dns_resolver.rst b/Documentation/networking/dns_resolver.rst
index c0364f7070af84..5cec37bedf9950 100644
--- a/Documentation/networking/dns_resolver.rst
+++ b/Documentation/networking/dns_resolver.rst
@@ -25,11 +25,11 @@ These routines must be supported by userspace tools dns.upcall, cifs.upcall and
 request-key.  It is under development and does not yet provide the full feature
 set.  The features it does support include:
 
- (*) Implements the dns_resolver key_type to contact userspace.
+ * Implements the dns_resolver key_type to contact userspace.
 
 It does not yet support the following AFS features:
 
- (*) Dns query support for AFSDB resource record.
+ * DNS query support for AFSDB resource record.
 
 This code is extracted from the CIFS filesystem.
 
-- 
An old man doll... just what I always wanted! - Clara



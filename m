Return-Path: <linux-kernel+bounces-875496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BBDC19103
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3808535581F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1FD332EBB;
	Wed, 29 Oct 2025 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mwexq6nr"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7956B322C80
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726401; cv=none; b=HTZRmCgiUq+6sD/ha3QkVot7Ifndb+sjzgbPefaT7sRj0ocZseqmG+nzTQoKnthdeHf7z6/586JVslcE2C8BuM1wy/US9L0SwLUAhcVliURebt/OnKfEcpvh4+YPWCgdHf3SwkiyIrACYsrNLIRDSHlYEZlMDQaKGwDayp7G6ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726401; c=relaxed/simple;
	bh=iwYylQ8AuV4Dwv48M1+UsyJjpTEomPIpnnYBgnEaLEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaWgtVB7r5gIe3QTpq/N3YowkWWuX8BpYvsASq/Sm79EN6bZePMWt2F2tV731UP6IuCKWl8lZPMKhsYyCeoBLYAMuDVaSEf3O2a7PRft2sVEKN7Iquxw7ieNsnqHXjgQBPOeErlsqLberD+RrgE4i+5R5T6zQwRKhEc7QKGZd6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mwexq6nr; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so710836b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726400; x=1762331200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWLMkuBEjPNHOX1jtcXuUOzSLXt4OK/n+U6maOQyI/U=;
        b=Mwexq6nroam4j/AVv6x33k7EOtq66tL0llBbYjbSzj9/bzhqsQYkd04oIHfA1+Iy1/
         NlF5BbLHsnW4arOqX4gxBiOCOKyWZQqdENvVm1TVqRSlz36LLF+C9s0zQpsiy3iDN5r4
         pifDlX0dTpu2R361MvoHjgfAG/opHZ7qC1389R+hMcNuGc6/gHzBJ0xvtI2vpKC2yc9o
         H19nvoAl+VG4QZotasOMDHI2+WK2oNHF/aT7/AEFrLfsvoqJ8wAQQJWBm7xmmiKhYHre
         hfGJBkfKjh/9uidZqb6teA0c7+Ggh7IC+egdor2qdANxPpZxicHJAnIVfEexkyNFFcR6
         8FFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726400; x=1762331200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWLMkuBEjPNHOX1jtcXuUOzSLXt4OK/n+U6maOQyI/U=;
        b=pNLbSEqsEM0UXw9dZncoslAe1gO3xv+S434AHiPXmsubwFNQC8KdDMwNRl8ZqvtD6v
         a6hgG9NEvXOl3ON8+P7uATO9KJsz5k8LhQWV2BzCTfm95JzH9rZ5BUCAZtuj01Ys+XEa
         SVO9M8FDCZLwvhuQgNmw0qT8Gjw23b7isP5NEKKCoz5K5xtDcnkNFSTLNcTjJtyyyqBD
         8FvMGzgFwvp/aEgHaegjuNbbi6tumNaqiIHZs2ff+SnkFvwTi4zdK8jjrbnbDB3jvxzT
         X6F6wC2FDrwylRXoD4NDeXfpAbjz1nPiPBgzkfbvBQaVoKaMud1C7SrDeOTuDEwpzndO
         2owA==
X-Gm-Message-State: AOJu0Ywm2i8pgQc1f3AVZqTKrp/4WzL+yu9kCn5Lp/nrU5l5fJbMLgBk
	wSELI+Y68CaedQGTBNuJ+VmXir+bbA+tSIWwxGuMgzGKF+qN/Fepdttv
X-Gm-Gg: ASbGnctmSKgj+Et2abdnp9g5U+CAy4L1hcax0lnBuwG03BwNA7bDxmO0SxU++iAX6+7
	mvRZf6zInha2rbnLsadty1Tvsc+3pZKuEl5RcB4XsRC+R7KZc3IkZLJd4YT+H/IT1jaWlSgd4L5
	b+FeEbGo3sohC1zN6dkdS0zN2M0Agk5RLP9Wk1MYxKufIyZGWwzIpqDUxDZn9WlLHcS8Yw8+FiS
	KhuKdsEFj30XJWmLO6HCGBB0fD1B/1whsQAODeBHwIJ/oylnfyg51jxjUATtsEhag9fJUfYSi21
	tefK2P1ELFCN/l2Q9nphLSuhm8aoWHjdAHoprlWd1xNz+H/P557TQDK/JY23/8TSRjXzLfl3F1u
	KNWOi58KcSiizwUaxP5Vw7QH2xu46dlgj+bXmsRT/vB6Y6yW8e2YgzMmb9+JXdtxr/gWJqXqVLA
	5Tzh8eEBqkwvJ0DTBq4731Vg==
X-Google-Smtp-Source: AGHT+IFVPQNroTDXnGwGmdI4qVP/vYNEi7i6hJaoqjIk6/GCV39T3NC2T1TRLTj4se14ABHn/IHX7g==
X-Received: by 2002:a05:6a00:130f:b0:77f:43e6:ce65 with SMTP id d2e1a72fcca58-7a442cc2c03mr6582791b3a.0.1761726399703;
        Wed, 29 Oct 2025 01:26:39 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41402e570sm14326342b3a.15.2025.10.29.01.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:26:38 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id BF4CC41FA3A8; Wed, 29 Oct 2025 15:26:19 +0700 (WIB)
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
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 6/6] MAINTAINERS: Add entry for XFRM documentation
Date: Wed, 29 Oct 2025 15:26:14 +0700
Message-ID: <20251029082615.39518-7-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251029082615.39518-1-bagasdotme@gmail.com>
References: <20251029082615.39518-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=770; i=bagasdotme@gmail.com; h=from:subject; bh=iwYylQ8AuV4Dwv48M1+UsyJjpTEomPIpnnYBgnEaLEI=; b=kA0DAAoW9rmJSVVRTqMByyZiAGkBzymgretmajEH8Gt4qs6FZhwcqEbXXScnAOlKIf01L2iEJ oh1BAAWCgAdFiEEkmEOgsu6MhTQh61B9rmJSVVRTqMFAmkBzykACgkQ9rmJSVVRTqMvwwD/Z5O5 PPrnPq81NjHLoWYI8Yx0P+6QRHzuZpcnCK+3HJMBAKApdR5dLHiz6ANWO1EodYtf3Z0vGB9tRZn B1HdrDGUN
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

XFRM patches are supposed to be sent to maintainers under "NETWORKING
[IPSEC]" heading, but it doesn't cover XFRM docs yet. Add the entry.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d652f4f27756ef..4f33daad40bed6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18041,6 +18041,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git
+F:	Documentation/networking/xfrm/
 F:	include/net/xfrm.h
 F:	include/uapi/linux/xfrm.h
 F:	net/ipv4/ah4.c
-- 
An old man doll... just what I always wanted! - Clara



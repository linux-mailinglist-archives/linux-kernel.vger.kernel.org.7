Return-Path: <linux-kernel+bounces-881201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B69C27B33
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117071A25535
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8676E2D838C;
	Sat,  1 Nov 2025 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2fT6k+o"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC32D63F6
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761990489; cv=none; b=ak38lA+JwDeM1HXo5qx+NpAjF/WUFk2uDfDUqUlrQOsU6a6RUOn2e4x2GnblFM762/8xE4SWbHruesL7dXl0sd9YpKbDJ7paCIpqQPNFXrNFIBxnkecyOThMTcVQaDTzv34L0mlnrXI9l4xmPyEghLxTBZVlhGThdLk/V0mOBxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761990489; c=relaxed/simple;
	bh=xYbBu2fMf0do2Y8PFkgmZ44ePl1qKHbhlD2bXGI6s6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRTIDnMYE6CjfuvWPr0pf+m6ZcybyLIwVFlHS/4juALyyD4Z1EzJImFe4pCOMDJelwf2dk8uLyfPdXWmTiWPPdg+R2b7ksvh7xYB3TxWrkIKwcR0KIk8ChyWrd8D1EWqyCR/kJw+OvEYobjUS42aNUjLmetg119G/+t+Yi738DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2fT6k+o; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-330b4739538so2997310a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 02:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761990487; x=1762595287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDAfAMTS/DdBYBQoTuWYXo0/wYkGq/INrH1coTZQ7c0=;
        b=g2fT6k+oZRO33cDif/qtBO0hUpagFP88NJv7YeIcoz6wEmPQC8Fkz5Xh//Jf/BsZpD
         yjKMc5EOBrLPG1TtvBWSEtYMUMJ33HQpbsoXyR6Oco+3eDzZRVGyzZiSnCHe1mWdSwdq
         TGPnWj7YZ1ZfFNy+zRGfNK6ZZteKZ5CvG0wkrLhxfhMB3hQDtYHPAhqGhBV9iyVGJODQ
         q2mYkbMORflXRV5F0YdyMXrMv17VGVj9lWOzIfzl1O2ARTVYdzWqLs2ipqmTsU6Isqu+
         UhBmkjOXq5TJhLmexmpRsniCMkH5VLh5H1VfcvVKbaFtvdqM8w5QeT/DW70lEI9x1rpR
         DUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761990487; x=1762595287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDAfAMTS/DdBYBQoTuWYXo0/wYkGq/INrH1coTZQ7c0=;
        b=g5Lqac9Z29qh9tz7eysxENEd8IiQqGwRBImjwlgUtbdG6/tfGPc2a4N4hfNqx+nREx
         redi84bDr6Lu5gqpYc0XznuvC0PwL65XOs1Z8stUxD5yKZveatEl3qt2tz0dMQUtTfgb
         SgZtv3/I3SmTdO4g2O2Yc/aq1bU9Vm5N3KOsg71HqFnGO9+ywCV5HXFAFSbjUn8wcZUK
         SJt9OiOez/ZPikIsZ8f2JftwuYUX4ZU8sHTtRxDaYIW+os3ArEa0xy0XpIp7tfzHZaNU
         srVFQFC0zmnnCLIPm6Nw8lALU88UcDBSuH48YJbiYLOof9R64Rw9PIfhnqOlABy//pa6
         7G0A==
X-Gm-Message-State: AOJu0YwLR0WU+4c4Gui7tlG+xoR0VC5tdOHXZgCa8hjQWVZg846Oro41
	1U4BkTeyQUXMeN0MYiYpm+2yszMMJN1Ch08lwr17zdCmNKq/5xC9jHua
X-Gm-Gg: ASbGnct7at4u6fvKGvx3Bm6TUGWTDYGIhAQ7kGDafECUucLSluZX54tfo9gsumufqNA
	IxTdTmA7d+qVHNq4KAazADsFg75sQdQKf7C2Bkl7g8S5TSH1EEKXpWwfXaH9oPkcwdT3VOu2W/A
	Ngs00AV3A0Qcvc7uyRZHxb0S438E8Y4atmy9IPLr4DqRQUG7bm0YLZwLW+mVsYA/sYP5dblwbco
	Yuu1MUKVXlNK5iOhNs5ejjg3TXIUDZqQamVw1ZnnChjU6Aw3mkMPCav6riLwgayd0bUAQ6tpsaM
	tES0y7YOGskHKYLT7S+F5g2ajOcp7E6R+05Ktu26IPy1P69zVsR9IzhUlG90HFfvSDXuRwKQ8+q
	bEKaf6uARR/bfJrsCaMweGycgy66Xmwg3jK4EfEUhKkZfmkStteQHTX5WMpnEX/tkt8I/UZV2zL
	0dqpQkFT0NDu0=
X-Google-Smtp-Source: AGHT+IGy1cfZoCwULFLYqE6Bb4moe4uWpY+1tqcKqVLgBJzC6ePt7PtJtSMS5a4wl0/9ag5xmaq1CA==
X-Received: by 2002:a17:90b:388e:b0:340:7f2b:3e33 with SMTP id 98e67ed59e1d1-34082fd9d6amr9568347a91.16.1761990487435;
        Sat, 01 Nov 2025 02:48:07 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407f28fe27sm2913985a91.5.2025.11.01.02.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:48:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 028DE42229A6; Sat, 01 Nov 2025 16:47:57 +0700 (WIB)
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
Subject: [PATCH net-next v2 8/8] MAINTAINERS: Add entry for XFRM documentation
Date: Sat,  1 Nov 2025 16:47:44 +0700
Message-ID: <20251101094744.46932-9-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251101094744.46932-1-bagasdotme@gmail.com>
References: <20251101094744.46932-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=870; i=bagasdotme@gmail.com; h=from:subject; bh=xYbBu2fMf0do2Y8PFkgmZ44ePl1qKHbhlD2bXGI6s6k=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJms1/IS30YlyQdeeefsdyyyIUi2ScFp/n2boy4bDJ++c vDY4XW1o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABMp12NkOLTuH3cC+9Ic75nq nhmql56nLqmPn1HWynJ4ub6j0vfsOoZ/VgUsHxc1P1ooG1Cg077nzM21FZmbzMoq8//pTp++/OZ pRgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

XFRM patches are supposed to be sent to maintainers under "NETWORKING
[IPSEC]" heading, but it doesn't cover XFRM docs yet. Add the entry.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ab7e87462993b..6d2906b2600376 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18051,6 +18051,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git
+F:	Documentation/networking/xfrm/
 F:	include/net/xfrm.h
 F:	include/uapi/linux/xfrm.h
 F:	net/ipv4/ah4.c
-- 
An old man doll... just what I always wanted! - Clara



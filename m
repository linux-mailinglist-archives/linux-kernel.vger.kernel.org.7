Return-Path: <linux-kernel+bounces-847262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D96BCA61B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D871219E74CE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50863242D8B;
	Thu,  9 Oct 2025 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcjPQAnr"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0950F23B61A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031187; cv=none; b=HoxjU+rEM9Yl34Ddlcv0NzF4xsAXREpfolTj/GsvXNuXG4z9CmObw4aXDS4GlT7Vofr9MiO+huzhKeh3sslIQVGoMZXGksTHDAsNnutzk4XcOCtSD5IBSQNhvuzaXwTkath1sQ6I7B2oH4Peu4WZwKUwaUS/gDwFI9gD3dRjsWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031187; c=relaxed/simple;
	bh=9vAUJTKDsrddX0ECgsQNxyK2CN2AgssZKpAoBZkq1Vc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nfcuq3d2YbS2b2dwiqxKN0OZ25HSEf1rpdTUoIsnnME4VXViTfbdG1BSZ8f3sO8GwQJkA158u1ishBdXnZ5TnOSeyJWTPFieC8CahZRlCA6tbdXK1FSbRmiQoiDLtgcVfEmiFEYXAtnPfoUHQVmfLi9t9XO9GrRaQzvru3swRPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcjPQAnr; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5818de29d15so1456636e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760031183; x=1760635983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pLxztCZhFqGeufXzkuXXus/JxbN+hE9UN/bbCDJgNrI=;
        b=VcjPQAnrGgVLeBRfC+uuXGk9pbzHCz+TJp+w3cYNpnU0m8UPJy6bEP8hXrxK2eIM/q
         iCzmNuIjzPH/NF3o987LmRNMcmPBiwhaeWtF6rYhzZK+TMltB59RykpDq3+MJ6AsyiCb
         mfa6J0Jqx7t9SLw8elKeYanX6DmmM64op0Isq71miJrarJPwitzOxZ9ns5FyN+A2wmID
         7iisjgbsvW4XK6na7u0YUt/ET4Lhpmr63SmF89zbwle2su0ylDTnQvfqIqvbp2SvlxUH
         R0j0rVJ8FuirNgR3EhUfnaTvOYVzpNMLnxq87Z1CLxZJvgsWlKXMWWFL4TAAp/RC7weK
         iSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760031183; x=1760635983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLxztCZhFqGeufXzkuXXus/JxbN+hE9UN/bbCDJgNrI=;
        b=ZP56+RdoDI0UIrD9pOgLlYxiZNzB1e72YTaXSLZLWH2KW//5/2N7r7OAUNSZLQtqdg
         McrEcEmfNYFAxsdyty0hms98OPIlIwom4mpH7z/tk/FgJU3iS2YBZG/IFgg19piQ7z1X
         sMnlZuVOB1zfs/ESuRrQFPxExsj4vdEJkjxmDRu+AYyf4tOECm7dWcID7kO6hPshvFlG
         7uZBH3aekna7OHGie7Q/SRO0AsIFXKLoZ+mEiy7JZikuAOVPY6GE7fys8u7ErP70EqgN
         W7MYY/osaBiFOTzHjSsm/nKwI3DgGKPEDJvF8BLUwHnhPmP4M5cHTT7/DwLOIfoKmkhb
         oQ+w==
X-Forwarded-Encrypted: i=1; AJvYcCXg9+nisWh1SzpOeyamdvmRSzxCTg9AjYBvs1Us8hXm1pP8PdRS+MwIPkjuQJcRmyIec9S+KCY7/6X02PE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzExbGIH4IANwuAK34oVKkeXVpaDOo/XNcIFdGOr5jQIVmjmJIf
	28xUiRv4UA6U9yQwNkTmCo1PFvyj03SJ6NDr4EnZL1WnxPxNIsRQxWvE
X-Gm-Gg: ASbGnctvQ44Yhfpmh+P2ROpnq84X47tDs615kLUwDn+QtTd324DrU5fLunw7kV0DZJP
	k3yBZ35KsfCVij1IbkeDrUn9Furq4VioMnt8XELRXNNiF5nd7kGZgFSfsE6Gzw+NvchCEBe9UG9
	S9d+P5GHohc8m1vmjuUvjwOXCw87/83m5tKyVAlVjuRUl7id2X3ldj7ksw5XXDNTOJ3uHk3rW4b
	1TdVflsa30hEhAumaGIB4DkGY4bHIqZhwsNyrz7XKDwVfbLrYixfOeuIJH1Q89W4x452mY4dCoC
	hftjEHmQ3uORNImdz56w7I1ipB0hIYNkM3wTr7Vaho9KQ3B65a+x2i9inO6EdNPamXugFrQf/Ql
	R9OibWmUcvP1QB5ruv+53rmlHDYPfgg442/JhpyejQBRe87HGqDGUvp5ULGE2o98y37vXvuaGGw
	==
X-Google-Smtp-Source: AGHT+IEvKuMOdYtRvPFBMg7RxLA8EnqpMsXl9d+MHkhe21lfjfclec1AQfTv2w3cGrLhXn53i9/gXA==
X-Received: by 2002:a05:651c:982:b0:362:95d5:3858 with SMTP id 38308e7fff4ca-37609cf837cmr25479361fa.3.1760031182940;
        Thu, 09 Oct 2025 10:33:02 -0700 (PDT)
Received: from home-server.lan ([82.208.126.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088577c1bsm26239e87.106.2025.10.09.10.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:33:02 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Alexey Simakov <bigalex934@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] sctp: fix null derefer in sctp_sf_do_5_1D_ce()
Date: Thu,  9 Oct 2025 20:32:49 +0300
Message-Id: <20251009173248.11881-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check of new_asoc->peer.adaptation_ind can fail,
leaving ai_ev unitilialized. In that case, the code
can jump to the nomem_authdev label and later call
sctp_ulpevent_free() with a null  ai_ev pointer.
Leading to potential null dereference.

Add check of ai_ev pointer before call of
sctp_ulpevent_free function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 30f6ebf65bc4 ("sctp: add SCTP_AUTH_NO_AUTH type for AUTHENTICATION_EVENT")
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---
 net/sctp/sm_statefuns.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index a0524ba8d787..93cac73472c7 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -885,7 +885,8 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 	return SCTP_DISPOSITION_CONSUME;
 
 nomem_authev:
-	sctp_ulpevent_free(ai_ev);
+	if (ai_ev)
+		sctp_ulpevent_free(ai_ev);
 nomem_aiev:
 	sctp_ulpevent_free(ev);
 nomem_ev:
-- 
2.34.1

I already have sent this patch from another email, but
he wasnt applicable since company mail server corrupt
it.


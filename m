Return-Path: <linux-kernel+bounces-856055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F71BE2EED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92201A63FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424B83451B3;
	Thu, 16 Oct 2025 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b="cvE60C3D"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B61343D7F
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611693; cv=none; b=fqLvU4FkZWkatPMRrC2sdi2T9+XtvnUleWlMCq4LoaZEyTKkRyHRMzag8QQOHaCTvazURDcXcyiMCsEseMOOW7GhtfK5ghfEoyw1M6GfC4JwEOaW7u4SegBMzEP9vbJQyVHzr0KfWj2rot9kCfMyFiL8rO/uM5l25x9Z/5cX9gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611693; c=relaxed/simple;
	bh=Vai3/5mXUk3m0FpPR7C5HtKBEkwbvUE6m2tIfTpywf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gb22PJA8IjmvXpMo8zS/+KI/VatjClg9OR5mR3uzxjZ5H/dsCuobkryEzuA6+/RGWYAubNrcuwaQE1eFkiowvthhLd0UJ7QUXFTcOavFbX5csDI/V2+1AaS0gZgDjtHS7qPi33ZyifZlqxxs1l+VEO9BYEWgC8SZCOXWnbyGbz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io; spf=pass smtp.mailfrom=vyos.io; dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b=cvE60C3D; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vyos.io
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e42deffa8so6343255e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vyos.io; s=google; t=1760611688; x=1761216488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSPV9AzBq9pw4Fv1WhOpeCc+InkklHxwfYwRGxtUKjs=;
        b=cvE60C3DFX4y7L9IC3YnW3PHe0dKXP2BmldViINck+3iqtEKFUGZx4dYKGyh3wT+Qe
         lCDMh48KaO1P1NMM3Jp1eoR+8pILH5eT6w0TUWaADBPP8QArL1dpqLHrcs+5BunfRIFP
         4Lpg9GZi8ocsK4M4YM4Csap5Gaa+Uis0gj5hKsOdu4JuNZVxP5Z/Ni9rmlAXfuBqf6jp
         DsK7ZxFIbX4FcjvI4VZUHChiUBaG7WidRJjtrkGqxLkacpm7a0bLqtythGvsIzEJ2+Te
         aKacVT4fXjco4HzBZ3nd3bG/yPc6wDZb8IjPcTOFRrt+0cfk5Ywa7ACKcsZRQW3QrCMG
         I2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760611688; x=1761216488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSPV9AzBq9pw4Fv1WhOpeCc+InkklHxwfYwRGxtUKjs=;
        b=PJQrLWVNaAzfDCIg0duOWL3YsXjV99L9zfaEODQGR9nOhY6J8A9awXloTfCELDJWh7
         GzcEm9ySl2jb1Shl8UKoAgt0dtovzyQuqnSH0AVBa9ElBJDW+1aUxNFfHTnwU+M57ilh
         bf/3+ZdFjEerJTanfRrUYpDD7kTKLtgPwLndDyReW6N/m7g9mJJbruDnqccnYhy8xhUq
         jPHRRzPHtTvdvzg9SZ1c8mEPE8/9d/lsnvusrsyWlS7gvePVNId39XOgqr4sQSwqB1sl
         bKC2Sxzgzwl2pbWGsP4PTqOJZgH+yznDkVvKjPyr/6elhQqC98iZ2bmI1aNBZYa6BjN+
         c5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjHGoyPF/gPXHzrRsr4Xqqqg8WApOhPy/Uc00N42Nqe9sbaUErhKmoeT7zp9hhKb/Dama/ZSN3L4/sYRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5EW6xP5snjuU7aGefOmNMZmj37/Wts3yNBgosylsoioqHNkKJ
	20yNtX+/oBJWQkh+OaSySTZxQZKzfEuX8ODShVv7WcRTYuACq6vzMhV6WUg3joc/STI=
X-Gm-Gg: ASbGncuP82oyfBkcpif7fzJg676GbN8UqzXEpGn+MIenFYgZvfqReofTP4G3s0D9vF2
	LY5FMzJScB2FtzcCBMrL5OF2vtAgBnkRtZDzM40qjHS9Aj/t7laastyIXd+cRbNN4aiD8WeDMcu
	TuEcsMd+NhZAnVjIlGviAUxBr4fzUK/jevtHXtWUMx5vIZnJysUx8nBRmiu6IFcS9ktNZ0Tyu2J
	yOUybpwEdDyby1SontdBzs+hhe+mJUQ0kLu57qAlIcPqD9Pk0dZh9xO2w9IZ8tg5j5YqH6isqz7
	GDbI3T2Tfageo77SLUWolj+SZranZfIZZsDmXdmJxsSp6M7b0Qr+xaKR3Ng5cBmnE4213WlmD8F
	WrwXDD8EKqADbohn2hKQLoexUBFfcxzY3WaqQhk4UpuGsgFjU5K2aBoyDrtD6AZPsrrugTgeO0w
	wfJsYBiThK0ZY4nVZvqfdkUaT0UgFVlqhxVWdWZNINwPgAyNLp
X-Google-Smtp-Source: AGHT+IFqjy8uQiCs0gAcUHUVVI+lGBAyvoChddSQYZFbSWwhwHhgv7ATDM7DOPjRfdHKUNXdqdAqVg==
X-Received: by 2002:a05:600c:3e87:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-46fa9b17df1mr270864595e9.34.1760611687717;
        Thu, 16 Oct 2025 03:48:07 -0700 (PDT)
Received: from VyOS.. (089144196114.atnat0005.highway.a1.net. [89.144.196.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ff84cbb7sm2729374f8f.23.2025.10.16.03.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:48:07 -0700 (PDT)
From: Andrii Melnychenko <a.melnychenko@vyos.io>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] nf_conntrack_ftp: Added nfct_seqadj_ext_add() for ftp's conntrack.
Date: Thu, 16 Oct 2025 12:48:01 +0200
Message-ID: <20251016104802.567812-2-a.melnychenko@vyos.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016104802.567812-1-a.melnychenko@vyos.io>
References: <20251016104802.567812-1-a.melnychenko@vyos.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was an issue with NAT'ed ftp and replaced messages
for PASV/EPSV mode. "New" IP in the message may have a
different length that would require sequence adjustment.

Signed-off-by: Andrii Melnychenko <a.melnychenko@vyos.io>
---
 net/netfilter/nf_conntrack_ftp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_conntrack_ftp.c b/net/netfilter/nf_conntrack_ftp.c
index 617f744a2..0216bc099 100644
--- a/net/netfilter/nf_conntrack_ftp.c
+++ b/net/netfilter/nf_conntrack_ftp.c
@@ -25,6 +25,7 @@
 #include <net/netfilter/nf_conntrack_ecache.h>
 #include <net/netfilter/nf_conntrack_helper.h>
 #include <linux/netfilter/nf_conntrack_ftp.h>
+#include <net/netfilter/nf_conntrack_seqadj.h>
 
 #define HELPER_NAME "ftp"
 
@@ -390,6 +391,8 @@ static int help(struct sk_buff *skb,
 	/* Until there's been traffic both ways, don't look in packets. */
 	if (ctinfo != IP_CT_ESTABLISHED &&
 	    ctinfo != IP_CT_ESTABLISHED_REPLY) {
+		if (!nf_ct_is_confirmed(ct))
+			nfct_seqadj_ext_add(ct);
 		pr_debug("ftp: Conntrackinfo = %u\n", ctinfo);
 		return NF_ACCEPT;
 	}
-- 
2.43.0



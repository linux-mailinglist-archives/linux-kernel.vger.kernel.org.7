Return-Path: <linux-kernel+bounces-866649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A67B8C0058C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E19F19C2AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9F930AAD7;
	Thu, 23 Oct 2025 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkJU1aEY"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED1C30AAD4
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761213147; cv=none; b=PM9GVQH3Ld7gt6rpGUK0VKEuMSN16+NvFjxsQe9AGdLRny+BaOLuiNUIrrPqM6QDuocUEQYVRKahS0MA7lEY8GYtgA4peYpvprbOqpkj1go4hSTvsRX+RU9QKKSbrYzG8k6JuZ2mZy1OOxRmCACVPGWH3QmNBxd/qFzi7XOGSec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761213147; c=relaxed/simple;
	bh=YgxDyRN4ofYBe5Adc/skKfZKavkw9WdqKOsDqlZOpfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EmbHl1TrltfXRcT801UoFiW/gM0Ncun/1aDX8oJ8rzGhmuHbc58QD1ylSAU75Bk/TACcR7+8IKGZLzIn7Yn9aeEIEdsjUW6SVa6kgLUp75Zr6FGIPHuz5hd7efY4vLwi6CKeY4eV92nNbzOnS/dVQmyZP6LAeK6/hvB07nepVmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkJU1aEY; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33bdd2b3b77so127686a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761213145; x=1761817945; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kycvQORLzyv+m6c4IfN7Tc5J35vHVuRL3jrZaefms2E=;
        b=UkJU1aEYYGi3k3k4ie54xn8nyzW6MItzaI89KDXtnt4pRbmYAHetVLlZ3u47v5U+Ak
         D7J3Xl3tyqptSLw9+dtlcK1lXTnukkftJjxwD28Bw7vi0mG8l4HWnjXaxDuOJkyzvkkq
         DXOt+zzMaQXZv0BLHFmplYrnsk7vjlaaM2KsBf7YxnxKrcqIy6cA5Fux73mfxzygr5Cc
         6YOaRB9hEYnKxRELrsBU+hm1JI82b5kxz9co7xwZGF4rR0zK0CdUzW4MHXK2h8GT+akc
         COSguI3WsVXm/KWzH++jLkctqRVGNAOkWMGm2sjw3wBVHNOWndQpvA+FqIXu4VcM2kaW
         PHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761213145; x=1761817945;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kycvQORLzyv+m6c4IfN7Tc5J35vHVuRL3jrZaefms2E=;
        b=crSpdA+6knLAtPp7SlkYe0BEZ27QeYOkA6wYivACDsPB+QhA1XqcI+5u1PbLoB8FdL
         ajHy3+ZueeJaxJbyFhMkCKi9y4A0Bc/S6APfjlhZpbWTL6KOMPvxW8t1F2A5zkkhzgHD
         n+WWPr4E4Y6wsfxW3y+FPgNNblhQf9iY7uV9QV6H/Y3M+vois/BU0TH0x7cngatI23t3
         LPIDSPojcPs7tj50kQixZnOttXoyIcY5cWKfblG6nuUaGKPNGnYoywUZSLssWwE6bNhH
         fQ7cMRztJmP44wMB1gGSzlMbiLg04dGYHuC1stHHdlURktGBH2QtYy1Sc4R6B8E8fUwr
         gjBw==
X-Forwarded-Encrypted: i=1; AJvYcCVnZiZxil+1HKa9iJ6go2Jbh8tiFTsF292LSHedhfWtyc+1k+CyK4lQnJgf6vaoL/pnVx4JomaRrkNryLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxER/gvKA+JkvFNjAjPh+2hcPpus8iRSpkQXPXOMkSCU5bkPlpb
	7scDHstU4ISFFC9DFPNT05mlsO3Vn2++U5NCH0Q+XD3kQl52GEeeApFF
X-Gm-Gg: ASbGncshLO9mq6EHWTB09TSQrhq3+7QxvLSWVHxKbI8dzdLYYu636IZmhNQdfCO4oMI
	tfZF7GG7uAg+4fAUxG+uSNl/PhUwB4P9B8s93XGOFQW8NS8uuT1S8p4hxpPyExkixkyqZGHCvUw
	b7D3MRIDR/aCZyv+CwW+7QEAljJvWPjYxDqe4JPVmi6oQ1mBnJzpyvrGYSvG0yWB5CZtC7yX0Ik
	0F3Zdm0Pxx7635mENVAKuMXgc0K5Rwr6TBx6wQ0dzfwuWV/hrRZ5Ai7Z61Rv8H3hEPsDF+nMjkk
	PVQCMZvjCukhNGgSdj7n7sTpdB6nR67wQV8G7nLh7Mp/oKxFI9gRXM7AP2vKetglokuwQWQ6LS6
	zydwDCDo+BYq0u0VlVNiDJxgRaD7pcCOtsm25ONi/2Qwu6ubIbXjwiNP1PTSX51i99nkatJLN1I
	XZodhEyhhQ6ljJCUERbfGm1gg3X2cjyPy4kFWPlPFVwg==
X-Google-Smtp-Source: AGHT+IEtqGW4IiwBCRAkhLR4GgJO5Ha3iipzwFeyZXwIB20yXWTxUWvqYd9qkwRwxN+A8Z4KoCOQ8A==
X-Received: by 2002:a17:90b:4f8d:b0:32b:9416:3125 with SMTP id 98e67ed59e1d1-33dfabf9ec3mr6477574a91.7.1761213145330;
        Thu, 23 Oct 2025 02:52:25 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:c919:de72:c3d6:19e5:82a7:de6e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff37afesm1832177a91.1.2025.10.23.02.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 02:52:24 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Thu, 23 Oct 2025 15:22:17 +0530
Subject: [PATCH] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-kmsan_fix-v1-1-d08c18db8877@gmail.com>
X-B4-Tracking: v=1; b=H4sIAND6+WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNj3ezc4sS8+LTMCl1zixRTI/MkS0szgyQloPqColSgMNis6NjaWgB
 e8LkUWwAAAA==
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
 syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com, 
 Ranganath V N <vnranganath.20@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761213140; l=1717;
 i=vnranganath.20@gmail.com; s=20250816; h=from:subject:message-id;
 bh=YgxDyRN4ofYBe5Adc/skKfZKavkw9WdqKOsDqlZOpfg=;
 b=N+rGD+nOzg05+/WRyPSDnt/qkxsarHxN2Fxy+Jq7bpfYDwKG3zvwRzAwCjrv0D7KU6nhMwFMC
 d0XDaYHELDiAysN3t522buK9pj9ALp94ylS8sj95gk06940Z2BRmkLy
X-Developer-Key: i=vnranganath.20@gmail.com; a=ed25519;
 pk=7mxHFYWOcIJ5Ls8etzgLkcB0M8/hxmOh8pH6Mce5Z1A=

Fix an issue detected by syzbot:

KMSAN reported an uninitialized-value access in sctp_inq_pop
while parsing an SCTP chunk header received frma a locally transmitted packet.

BUG: KMSAN: uninit-value in sctp_inq_pop

skb allocated in sctp_packet_transmit() contain uninitialized bytes.
sctp transmit path writes only the necessary header and chunk data,
the receive path read from uinitialized parts of the skb, triggering KMSAN.

Fix this by explicitly zeroing the skb payload area after allocation
and reservation, ensuring all future reads from this region are fully
initialized.

Reported-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
Tested-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
Fixes: https://syzkaller.appspot.com/bug?extid=d101e12bccd4095460e7
Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
KMSAN reported an uninitialized-value access in sctp_inq_pop
while parsing an SCTP chunk header received frma a locally transmitted packet.
---
 net/sctp/output.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sctp/output.c b/net/sctp/output.c
index 23e96305cad7..e76413741faf 100644
--- a/net/sctp/output.c
+++ b/net/sctp/output.c
@@ -602,6 +602,8 @@ int sctp_packet_transmit(struct sctp_packet *packet, gfp_t gfp)
 	skb_reserve(head, packet->overhead + MAX_HEADER);
 	skb_set_owner_w(head, sk);
 
+	memset(head->data, 0, skb_tailroom(head));
+
 	/* set sctp header */
 	sh = skb_push(head, sizeof(struct sctphdr));
 	skb_reset_transport_header(head);

---
base-commit: 43e9ad0c55a369ecc84a4788d06a8a6bfa634f1c
change-id: 20251023-kmsan_fix-78d527b9960b

Best regards,
-- 
Ranganath V N <vnranganath.20@gmail.com>



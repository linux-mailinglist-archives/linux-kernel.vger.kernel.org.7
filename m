Return-Path: <linux-kernel+bounces-749091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C29B149F9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC49173DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFCD27F736;
	Tue, 29 Jul 2025 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M0z4PYdV"
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4D827F4C7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777118; cv=none; b=N1tyV13j/+G6Zl/7PMV9JF02aC+SqUIS0cyJoDiIi1LgppfgZY2gECYgIvQRx2kt++mpc71U/rO7yXNNoL9ecvqSVjAva5vAPlKrTAqR1cik+GhbSN6d1dlzPd0fh/ttufhC3oKhZ9SyGyFiPM5Igs9xJEKlnaN3UsN2Od4W6B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777118; c=relaxed/simple;
	bh=WqAMXnO3CFtQMH4IisFPkpdqBXrvgGC1WEBwGpo/6hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEWOPwL+QHvZvH86hnt1RpMmYjd9ZFNy79dxkKOwt2qXoD3P2h1wp4O0gWK5js+qo0y838ftu5myPqJB3jzocpISfPfYUDjL/t8CmTOjX+02t79S2bfAF1e84ZZ5WHVFyLdaoVyzEckq4dQOgOtDHYzEjKf4//NdSOSaG28gPik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M0z4PYdV; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3b7834f2e72so1609283f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753777115; x=1754381915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7j3RLSONhtR9vvz/PBFiW+M/eUBIkWPbGSZi7oyQpL8=;
        b=M0z4PYdVqln5D5jcSuOoGJ9tkTBMqF/Kz43ti0MPOX0niQV9oBYMY+JINhyhRIEm6E
         HBscf0a2NXJpEXXgTVYD0Ik+sair73rO/jBD60Cr2rmz1ASp8ut03u34oboWdHkYWNGN
         scqhkOKBxBx+LHHzaMJ5gsmcCZAuV1xWGoCsBgldYExZ33LQ5XJjeij5qrFQHfAR3Qqe
         zpZPkq8xku58tCgAi2Z2QFQpfLnN/pJOZ6Zdsb7kUx5GnoJs80wePTVsvnE2wcMa41nI
         qUVswUHpOsImVpKZRgAnzXu7vhKDlih6RENBGS9iMQKVPfnSJfOJaUuj5Ty3aB7Difr8
         7s6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753777115; x=1754381915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7j3RLSONhtR9vvz/PBFiW+M/eUBIkWPbGSZi7oyQpL8=;
        b=eQtyDeZaY+oFnUpfnX6srn6NL08aUxWACdHJaUayBqQCfDVIgjuypZ2CC+Ck7OQnVv
         gVGX0nJrg8qQMu/vWqREexq47w4BdyEc0WenC1UNh7cOYoi6X6kKgetuzt3lO5dyXpzv
         UqfeE28GDh3kYthB/bgZIB6SsdHXCjzgbPC6KbPRJPY0Z7hAY+7Xwv5pdWCCaSubyQVQ
         c04GQZcLvQuWNkJmyx3je+dYafdcv307Zoq/KYg1CJB6uXBVaFAColvaElGhegzV7OoZ
         /jkttuBaAuMRBHEfrPO5GFBMwkCik+8Vl0UyJapVP1eFVVm/8P2WfZ+Wyxdt0GPL2ZSE
         H/Ew==
X-Gm-Message-State: AOJu0YxjTg2z+DOkmMU87/NiockEXRYbe5/bSrbamDRpxxQTJtOu/+Bb
	w4sZT/n/Xo9CXfox2eOlTWdYMuW0OYlYWWPSoSaQcnDVdoI3qRo4khUMLM09EmwLC40=
X-Gm-Gg: ASbGnct54QBJJ5OADAQIrt7daxUj1mottxTgd26TVIDTdJOnBk9VblG4q84akfSxxWV
	8SYGE8yrf1iuppRMqfhNF5AxqfiATU0yy55sT+rXdox4ktJhExV68PYAma7N27tjUhiLYJsQhN9
	yoS9glposS9dy5XfHDEyzZLZHuyEgcZtkVB29EUYQcrpanlNFhqs1tHpspzEpWjHJAwWEhnORjA
	5uLlRNRkOYI/Urdlfj/e6yYIgnuyWb2E3Zku3PpM+yTesSvn1ht72B1spL61+nQwL5ouQME7nGu
	dPhVKAwl4CyUVceCrSq3B4JU+BKRuuvgGd3OdvxoTbFHeRtcBZAnczMjY7FAZFoMUK3s+aaayw8
	42J1hHwo7Hs3zXBDl1IqWNdP02XANYwPg
X-Google-Smtp-Source: AGHT+IEx3aLd7yArtasrzvQ6pR6knJe6YFy4h7dKUJ+e+94mhRmWfiJnzk7+DMiFTUafZ65nF9Otyg==
X-Received: by 2002:a05:6000:26d2:b0:3b6:1948:c763 with SMTP id ffacd0b85a97d-3b77673282amr8199781f8f.22.1753777114625;
        Tue, 29 Jul 2025 01:18:34 -0700 (PDT)
Received: from localhost ([2401:e180:88a2:4c10:c47b:26d3:8f9b:63])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23fbe31023asm71494305ad.24.2025.07.29.01.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 01:18:34 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	cve@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	=?UTF-8?q?Jo=C3=A3o=20P=C3=B3voas?= <joao.povoas@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH vulns 2/3] add a .vulnerable id for CVE-2023-52735
Date: Tue, 29 Jul 2025 16:18:23 +0800
Message-ID: <20250729081824.85105-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729081824.85105-1-shung-hsi.yu@suse.com>
References: <20250729081824.85105-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jakub mentioned the vulnerable commit being c5d2177a72a1 ("bpf, sockmap:
Fix race in ingress receive verdict with redirect to self") in the
syzbot thread that found this issue (see link).

Link: https://lore.kernel.org/all/87k021m8an.fsf@cloudflare.com/
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 cve/published/2023/CVE-2023-52735.vulnerable | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 cve/published/2023/CVE-2023-52735.vulnerable

diff --git a/cve/published/2023/CVE-2023-52735.vulnerable b/cve/published/2023/CVE-2023-52735.vulnerable
new file mode 100644
index 000000000..d7bac065f
--- /dev/null
+++ b/cve/published/2023/CVE-2023-52735.vulnerable
@@ -0,0 +1 @@
+c5d2177a72a1659554922728fc407f59950aa929
-- 
2.50.1



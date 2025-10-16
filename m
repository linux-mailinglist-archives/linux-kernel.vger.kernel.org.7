Return-Path: <linux-kernel+bounces-855839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CECBE2756
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4BA3A95CE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33373191C0;
	Thu, 16 Oct 2025 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtbPb91F"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE6306484
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607597; cv=none; b=SJMvOCOXsPLq2yByyRF1x7A6GLUaNFcB2wglpy+nRktKm8yFtS/K/ZsngB2hnB61omX5cexPGWG0Li0oKVPUcj2khx9H8yCQ62ob1EwERlaeg3BE5Ql68jKjtoTLZRWFAvmJV9r4qfJJtQGQWLaBlf8HwywI3/AtDfRWAqFbyHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607597; c=relaxed/simple;
	bh=q8o2NQ6L6LFGbktB7GVrgV59ZquhP2NAXmS5kWpAIwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5QXYvqq6RlS7jzNmqw2a6e896Py3X7JlmxThuwVevb861gm4ISEtGCzxX8Il5+UirgRYeS+wsSLEMObXe5av8ogDHRmIvH+18XLxaXsjiFEXZdmym0o8zwoCgRFjF1nLTm3yLcbzk4DPtR56Y+UuDsgFf7InaOMND+PjLO8A7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtbPb91F; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-271d1305ad7so8627975ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760607595; x=1761212395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=++wbAo7zmbNRe4mjezio8SQcxYljBZGJ4IngYV8TGHU=;
        b=UtbPb91FtdAPVaz5Sgg6m36fx1IY4vjfL95TkB6br/YBoD38piNZ10ido5L+1u124S
         7nWL1ApeL9W9rnHC1SCqRIgV14sv2X+hf5yNw2FIjP+dZZfxYGpi/1mZPf4CW/zK5Wsb
         aquMtpLIWurcR1i7WTI8LyQbXXRRNgEb+rp3RVK2Rc27k9cuc3oOEzos2oZihxxJmGJw
         AX1jLjv5yhm3PZgBQOpqmwwLGFuMK7Q+GPhHmNx8iiv5cKfjRJcJzkBMu7IRbTQvH9VZ
         0g/Dsxmt7xZoGXG0LeIF5QYPas9kLb6908h0gQOnHOrNPiM/cSMcCnO7X/fRvdguEQvb
         b2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760607595; x=1761212395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++wbAo7zmbNRe4mjezio8SQcxYljBZGJ4IngYV8TGHU=;
        b=LYwvduecD49gC15pc0yKOCGKQ5DMczJXrF0ZMRQOwMfy2s7L/hSKkcpUUmjKanKark
         hLBourvXDFl83YeI8aZoMoV1JZtUEiQJxiyYqdygRLJisxtRpoJeLOG1n98XmVUV98YN
         seDapx9nWnQLFvddwCdGi9bjau1SS/jkF6yU+v9FMhbggvpyf/AzGOdmq9eYPTJmDcru
         qaCVqd9yAnFjJNo/szBvgtdLcxJd8dEdhi6RwVSygFO6huhfIZ+2M8UIKqSfo9r7p7pH
         E0VCAYvXOJzdgpVvsShLTVL1hmjouQnKEgpEM6IWbGcHoM/5XgeF2lfQUej9apcgh//7
         adQg==
X-Gm-Message-State: AOJu0Yyi5A2N/1U+O35djzwCi1xvdLDdCwzvgQHo6GO3k0BPMWmFRTFV
	uVED3jtcuzHwjSaZCBUqFJBIbwEkY1myMywA8BkWyu817xX9wnVbtmag
X-Gm-Gg: ASbGncsUttduIosEBWYtU6YKXy9NcdETm3Jd5WBXJZDi82lQhVfraKCzKoXr/I3s7Hq
	Br054+a8RUTotfTeSutkIVhKy4aZJhXdskpd0hlxopqx3FyUOzM7eJmenN0h6tUJNTV/cJD8Z5d
	Z5Z1br6qf0Y/aArVvMv9ppKFHOnDN1em9cl5Oze3rEkbXjejUd3Kj4B8Pd0k+1xLEv4ycFn9jgE
	Uvl/5S3EKikqmZPZNHB5uwrcbOPq4zITbcW+shRnOPLk0gvV2M4qvq32+qTnUgRX/YiefSbmTIv
	LkKWoRzyfeiPBKi4JdZ0RQR/gWR8ux82mhTGZ2w8dqzEV2B1LKy8IrQd0DtVHu/F59wq1Fpe7SE
	7s1CqmP45XgwEZNLEeTsvdb5NkFHbll//aR7jqo7LH2RbHwrdTEIRJA/cXCjcx9Pp6kRLoIjHVM
	z0I+LlLPyXTRm+tw==
X-Google-Smtp-Source: AGHT+IFS9M80syPYksgqDJ9tQreitknkpLZF7Qn/IO4egCYd5QwU4i8pmScawukphLNSoU9cfWZVbw==
X-Received: by 2002:a17:903:fa6:b0:28e:cb51:1232 with SMTP id d9443c01a7336-2902735656dmr418798465ad.3.1760607594899;
        Thu, 16 Oct 2025 02:39:54 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7b068sm23648445ad.53.2025.10.16.02.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:39:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C21B640C0938; Thu, 16 Oct 2025 16:39:51 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Krishna Kumar <krikku@gmail.com>,
	Vasudev Kamath <vasudev@copyninja.info>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net v2] Documentation: net: net_failover: Separate cloud-ifupdown-helper and reattach-vf.sh code blocks marker
Date: Thu, 16 Oct 2025 16:39:37 +0700
Message-ID: <20251016093936.29442-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687; i=bagasdotme@gmail.com; h=from:subject; bh=q8o2NQ6L6LFGbktB7GVrgV59ZquhP2NAXmS5kWpAIwo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkf9uy3WLhuyaq1HtsLPD0S5BTeHpR563FPYGKS+g5J9 afcm4697ShlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEbLUYGXb7L1v9myunTaJd Y245e1rqQV1Th7TFzlZBB74r7t160o/hn84SxeJ2roD+cAvh17H5fTOefklL2nRi+ZZi/uB+574 JLAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

cloud-ifupdown-helper patch and reattach-vf.sh script are rendered in
htmldocs output as normal paragraphs instead of literal code blocks
due to missing separator from respective code block marker. Add it.

Fixes: 738baea4970b ("Documentation: networking: net_failover: Fix documentation")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v1 [1]:

  - Place code block marker at the end of previous paragraph (Simon)

[1]: https://lore.kernel.org/linux-doc/20251015094502.35854-2-bagasdotme@gmail.com/

 Documentation/networking/net_failover.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/net_failover.rst b/Documentation/networking/net_failover.rst
index f4e1b4e07adc8d..2f776e90d3183e 100644
--- a/Documentation/networking/net_failover.rst
+++ b/Documentation/networking/net_failover.rst
@@ -96,9 +96,8 @@ needed to these network configuration daemons to make sure that an IP is
 received only on the 'failover' device.
 
 Below is the patch snippet used with 'cloud-ifupdown-helper' script found on
-Debian cloud images:
+Debian cloud images::
 
-::
   @@ -27,6 +27,8 @@ do_setup() {
        local working="$cfgdir/.$INTERFACE"
        local final="$cfgdir/$INTERFACE"
@@ -172,9 +171,8 @@ appropriate FDB entry is added.
 
 The following script is executed on the destination hypervisor once migration
 completes, and it reattaches the VF to the VM and brings down the virtio-net
-interface.
+interface::
 
-::
   # reattach-vf.sh
   #!/bin/bash
 

base-commit: 8d93ff40d49d70e05c82a74beae31f883fe0eaf8
-- 
An old man doll... just what I always wanted! - Clara



Return-Path: <linux-kernel+bounces-854215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40575BDDD71
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80E1583204
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293DE3195E1;
	Wed, 15 Oct 2025 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOsnOk01"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E731A574
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521520; cv=none; b=baUtHyXA4cPUcrOZb6iHa9mT3WFN8bIkDNd8cslHKPfM2w/ckaM4bl5rgGDhiwKvB86203pNz5m73j7ZCjdS24LK6LAOGbb9VoTdzSTFKCoKWjzKwKrc/gJP+IQJitynczOD7rigUZG8k4XJTlzoLSzpXLxAOnqZioWHyEauXb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521520; c=relaxed/simple;
	bh=JDk5XmJ2D1O7l1i+HH5E85dfIbinCpywgSIc5C2DbME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A/7Udl5dEU0AhuHTqmIeFfo99dcNRRpEMN7bbtOMdR8klvzI6/4b0/0YKzSYow5yDDegbM7Nl5rWLBZWT1sHqZtqfClJm9SXlBAOmdGDRpjtNOseQyKdAYD0WckWkcsTHKS97Ekso4rgN+Fo1kV8BsLCsSTBlWOQmQqnF4wytWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOsnOk01; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-269af38418aso73452035ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760521518; x=1761126318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bkuDo8Bgn//bjknb8Sc5XnshE8ax9lRnDzc2RFU/M9U=;
        b=FOsnOk01UHx3xLjcE7c5mRYanphQoNdAiDWiOGUUaJRvtJE+dQ6bBtArtJ/sYyxZah
         abqa9qS9YrlB/ITYmkxVGeHInhgq+RQzL92ZdbGknskAjNYGa4hs26wZlj3BT3PHc+Q4
         M9mYKsJttWJMMRoULtgrGDEeucwVmnjZ3zC92doAj4Y61ftgDXIDtBrc3GDJVStSKXgW
         5CDedeVp3PFm4KT6xKTeG+KYExeviUYQupnwdrT6NEGCs+qMhHaCqldhIzAlofhekGlw
         B7wgIsfO9slmQJsQjLQ7ls0m5GOIKe6CNkUEWXEXsd1fCz1HCJBmZf6+nM0ZdgWNprOl
         IXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760521518; x=1761126318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bkuDo8Bgn//bjknb8Sc5XnshE8ax9lRnDzc2RFU/M9U=;
        b=vV4wtUJBXOu+uAb1Yu0Y8hpb02cv7X7iHOwES6mqUNO1KlmOLEmB9MRiC2g1LaED4M
         JgZWA3NZkG2XM2NNiLzQtgr46tQ4zU9KkeG4v1vlwTy/dHuhYU5Nzv7yhgt181nlslgq
         sRTp1Dz1LUq19Dpn89OfyBlmfd3TKNFWqkyX1u+BJQchC7ak7UDcQZBXrl6P4sulBzBP
         N48np6qfQhiw1TK2Ec7C8G3/WDk7epc2wk5hy6XHfsH43gJEc4UCuuk6iLhfnFNckXPd
         pR1jodrtQjeirEMo0qxuJ2+v+BL1hPV0A62k/QotdRbbVj41V0rYTE2Oyr4TxVx4MgZt
         zp7w==
X-Gm-Message-State: AOJu0YxU0i9Yyjfcjv5/Dig6GDuP00LN5uy1Is2vIn7/6ngPSjfnI2nb
	4N9QuRMsyav9ICSofQwtTxzLxPsoayrK+bx13DSyXEGl34F9PBEZ9N33
X-Gm-Gg: ASbGnct/iQu0wBiB27Xuw3uwaG0BwZAJ+9BaiCCLKFTN41wnRtCX9WOYPHQlbuIHqSd
	hEkQVFBioW8kNR7U0EwFxfpXFxrQEBPSzft8cnonT7AjdY8KiTZoxedh566OgALDeWqU71/nYDM
	/PzXJn5zaYG3ltHWYdEYirLn4ynOoPp8mkkYLvgE2aVxLeLukEhVAMWpTephKEl2qGJmBpZIk6u
	2j8EQqjf3LTHuam3+ALY75D9XQf9T4hnKjjXTaDXaqSKiVsGFRa0LVTGl1x65PgMHZa7AsCS1Xk
	fOJNiVRlLuQ/GZVsTBr5Lrp25UZAqnrbs6CU96pDPbnOTSw2HV5oVI2apvukRcZn48JCkasuzQy
	Rvk2uMvSHUmtOQuuB9p3hMSsx+qOAg30CcXE/9pHld+Ms9pUU+RPkXwc=
X-Google-Smtp-Source: AGHT+IE30XdXUjOh6i/Q5dBdxAGcm0ev32OA+D/R2WfdMEVK8VgYMqFT0iFGbeO/kztIN46bqJVLhA==
X-Received: by 2002:a17:903:1b64:b0:262:9ac8:610f with SMTP id d9443c01a7336-29027374b16mr312217565ad.22.1760521518349;
        Wed, 15 Oct 2025 02:45:18 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3ffsm18796888a91.1.2025.10.15.02.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 02:45:16 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9488F452891F; Wed, 15 Oct 2025 16:45:14 +0700 (WIB)
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
	Vasudev Kamath <vasudev@copyninja.info>,
	Krishna Kumar <krikku@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net] Documentation: net: net_failover: Separate cloud-ifupdown-helper and reattach-vf.sh code blocks marker
Date: Wed, 15 Oct 2025 16:45:03 +0700
Message-ID: <20251015094502.35854-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=bagasdotme@gmail.com; h=from:subject; bh=JDk5XmJ2D1O7l1i+HH5E85dfIbinCpywgSIc5C2DbME=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnvc1Yv6zRzXPB0ltFXbWmbb8IGVpwWOr8VVzwUD+qr4 3X1/zeno5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABMxOsrwP9NGXWvhS9Wzz7vE zN5VHpp38mpznsf2H5Y77vk6ajxYUMrwvzznszX/yYRMw7WlxyRvaqysDso6ln3S7JiG0q/0EBd WZgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

cloud-ifupdown-helper patch and reattach-vf.sh script are rendered in
htmldocs output as normal paragraphs instead of literal code blocks
due to missing separator from respective code block marker. Add it.

Fixes: 738baea4970b ("Documentation: networking: net_failover: Fix documentation")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/net_failover.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/networking/net_failover.rst b/Documentation/networking/net_failover.rst
index f4e1b4e07adc8d..51de30597fbe40 100644
--- a/Documentation/networking/net_failover.rst
+++ b/Documentation/networking/net_failover.rst
@@ -99,6 +99,7 @@ Below is the patch snippet used with 'cloud-ifupdown-helper' script found on
 Debian cloud images:
 
 ::
+
   @@ -27,6 +27,8 @@ do_setup() {
        local working="$cfgdir/.$INTERFACE"
        local final="$cfgdir/$INTERFACE"
@@ -175,6 +176,7 @@ completes, and it reattaches the VF to the VM and brings down the virtio-net
 interface.
 
 ::
+
   # reattach-vf.sh
   #!/bin/bash
 

base-commit: 7f0fddd817ba6daebea1445ae9fab4b6d2294fa8
-- 
An old man doll... just what I always wanted! - Clara



Return-Path: <linux-kernel+bounces-829849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E74C2B980B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18D64C2C73
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4121B192;
	Wed, 24 Sep 2025 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7NFvb7/"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECE115C0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758679604; cv=none; b=TOPhCnu+SuWAIWQK1aRP6Mk8BZ/ueB7l33nXXapBLQ9KGxDSCpZXkTuctpoamMCg0jUKNUYWDHfg0kxZzoEUtD8yP5cr95zVUW/0p+WfL/Qi3NfosMvOK6sojc+Ki9KRlCoWNu1MINrm6N9kjpM+5z2PaYMlEAgCp3aCEoW+Vi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758679604; c=relaxed/simple;
	bh=zKlZGWoOmkq/pBFpjZDZhK0vM9ul0Y8n1dGY0HTd8EM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bpP3x1Ew1eliv7Zo1snhli47g/pFO48K3KaFTRuVhubXvxB7K5QlYHxDSdrDr29Y9U14KCrFBwHF+MUTDoWNrKBIAjxp8RmFbCaWYLHP1OIypRl0BFAx6IE7bMHHr2vGc8J+8dylMYdToGaDw86+ALxemEjekLBF1hg7pXQTIQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7NFvb7/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso4195500a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758679602; x=1759284402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TTpEMsMEIs3fjA8nsBcCzWer07tvcAO2S5Gxt6Xbj7g=;
        b=H7NFvb7/twYqyOncBE0BVVPwxw6fjLRta8iNaSk9Hm+QyB5LR8O8TLPwzPYa4Wgn1A
         PgActhJGw1mgTHUeDlNiGtRYAZx7tiGnEl1F8VMhCbNrzrapXFuqkrQ6Fd1ycM2XXmM7
         JAGSv9DK0vQYo6eTzTZ69iadX6qmgSRqprb5rFAPRs9XiG3l6W6fGE7hUeSWTg/bqHWq
         5BvYH0Z7kFqMjv6XWvuCqcU/HSjqPvjxbG9bG8MkvQ0XoK6+sFDY7XbiRx6IrNGu/HjW
         NJ9DtgaMmZjagePBwh9zzk1JRxPqwmqorNRd5Sw+QdBxeCz5Iv/s6MSBLRv12xzNrOgN
         JKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758679602; x=1759284402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTpEMsMEIs3fjA8nsBcCzWer07tvcAO2S5Gxt6Xbj7g=;
        b=vVzKHBXtQugiM7GAhQfLShdDv8A2p4Hfm1HThWcmrSJjdEVExTtKAmL8HP6DmeN8O5
         1S0w14rFkF+vVqZBeGGMFIAt54Z484UfGBep7hcFgysjX/G3uizdpYTdH8JuX0sREA8w
         n6akFKA92+PInYWT+8Ok2K0OLSQVslATKQKNhFxWTKwIXrQgQrFqJkJ0Zr8+2UhSMjZ+
         /27VL0Iy3CCX+IAADdreMeTkDL7qJW4/oUOZM6hPjPbY7gp5I2eTGL3ISELdGOa9ZnBP
         CyEeTDyBur9+GEDIqdyF/AXsKxi7uNB5Hka9xdPhT2DokDmZQ58LvTrpJlweONDpQthE
         MYtg==
X-Gm-Message-State: AOJu0YzINhLfgL87XiVlE6TNJFZdqoo/Y7RX5L2h9+gnOoS6FrDJUlBh
	3oIScdcSLYE2e7YJMoa08aTDLfkaH75Cgf0TTIqhCwzVrJFg6gHhcttx
X-Gm-Gg: ASbGnctfej+HqFnSQT/EtBQKSDwUBo2Ake3Ockk7oQpx326N22JM4ZdBp1qqd+zWqmC
	kAV8ijdfwlp7TOL3yq2Ue42Bzt9/pwyeh4+udAy58Yln1HUz7cGKUZgouNBTWaLW3rxIG5Pj0sF
	pBMqy5jpzpfl71pDK1QE+HxfxThCylA/Lw8+g0irnStluRNGJUpYLEmbIGtAbK/9cvNdJLYppXU
	PMSjZKG5VgGjznfI2C462woc++Abw0k5+dgfVBTjU04wIrxRjJGdO/Cru6kPYrG8cPEaaPbxTBg
	AIvnAeoYiCjsIs0f77acH+xWFhbI/FuLee2to4ackym4ouNDQZ+trSqMtipptKNUkd4TAFgnAts
	NzcNG1iMl3WY3cmXh+7i/xw==
X-Google-Smtp-Source: AGHT+IF+tyYKZIXuXEet4Qn27ecJRbXmLmmKIAg+V0vsKXZxS07Fv8voBpsRFqNeRMVZK0GpM0AM8w==
X-Received: by 2002:a17:90b:2e8d:b0:32e:d015:777b with SMTP id 98e67ed59e1d1-332a96fd52fmr5444528a91.18.1758679602327;
        Tue, 23 Sep 2025 19:06:42 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bd90327sm542825a91.3.2025.09.23.19.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 19:06:41 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 57CDA4206928; Wed, 24 Sep 2025 09:06:39 +0700 (WIB)
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
Subject: [PATCH net-next v2 0/3] dns_resolver docs formatting cleanup
Date: Wed, 24 Sep 2025 09:06:22 +0700
Message-ID: <20250924020626.17073-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1013; i=bagasdotme@gmail.com; h=from:subject; bh=zKlZGWoOmkq/pBFpjZDZhK0vM9ul0Y8n1dGY0HTd8EM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmXAxPEa4J6WdkPl4VO3MDBwF/7Lj3S5qnLnWbFBwG9G +60W7p0lLIwiHExyIopskxK5Gs6vctI5EL7WkeYOaxMIEMYuDgFYCKzDRn+WWV5O6XO2La9yjnL 5OLPG/dcbRJC3572XSrc6906Xy6ghZFhzyXe6aeEl6+X0jaf1Nqa2XS8eqrX2ulPtQ3dwj5uZOb iAAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here are reST cleanups for DNS Resolver Module documentation. The shortlog
below should be self-explanatory.

Enjoy!

netdev maintainers: Given the tight timeline before 6.17 release is cut
next week, is it still feasible to merge this series to net-next (targeting
6.18) before it is closed, or should I repost it once net-next reopens for
6.19?

Changes since v1 [1]:

  * Apply proofreading suggestions (Simon, [2/3])
  * Collect review tags (Simon)

[1]: https://lore.kernel.org/linux-doc/20250922095647.38390-2-bagasdotme@gmail.com/

Bagas Sanjaya (3):
  net: dns_resolver: Use reST bullet list for features list
  net: dns_resolver: Move dns_query() explanation out of code block
  net: dns_resolver: Fix request-key cross-reference

 Documentation/networking/dns_resolver.rst | 52 +++++++++++------------
 1 file changed, 25 insertions(+), 27 deletions(-)


base-commit: 312e6f7676e63bbb9b81e5c68e580a9f776cc6f0
-- 
An old man doll... just what I always wanted! - Clara



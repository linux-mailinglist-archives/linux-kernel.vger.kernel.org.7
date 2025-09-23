Return-Path: <linux-kernel+bounces-829135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270C4B965F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C187B3B2CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84322263F38;
	Tue, 23 Sep 2025 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWZ1yUND"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55BC946A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638395; cv=none; b=XJ/bfUbLvBhKe2nsOF/TcBBbU3a9K5PmeQbgOS7nA9oqkfblAck8Po3uNbfvFeltE/km76CVu22eukzg9WDwY//EcyjLKnt3pFtAXdXlmocPhRc0FQ06JHstcjzVVW31aUcakghtIDvza8H54j3/FgE/j6ynFBA5ogP/2hU9p6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638395; c=relaxed/simple;
	bh=j9EbXoSuWTRW4S13uHojnmdjX60lsDhKsm/Ff+KWPLU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=up6yVypCDqtAOfn4uLNNMTkhudb5Co7Ylx0PiAAan1FyisIauyqZscQyRYBiefiEDZo/H27xOjIbMcZ/WYoRo0VNBdNu0guUtHjJdgbUjoUOSNt6fNuR8Zb4FKIN5pCMCvKTaKNeYhsgBhV6uGlVAttxmiSwOxiUlPqFJD+LTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AWZ1yUND; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758638392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DxQDp0IDyzApp/052cL0s/7veaxFSTNbvA8rR+FrLW4=;
	b=AWZ1yUNDAHWqNbFmv+hU+88kgDpUwTWsRfld7FRG3pKhxt0DRsK5WcbGB3s0ZyZSP90ZUi
	7WqzjlBMEstLyipM1/jFsgbebjjZxo5+nhYAKAQJJD26UXXi9O6ItyGX1jS8dOaWQs1GtF
	iFD63MyaOUTQoLWqbV8wrhNviqB82IQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-m7YXmmf_OE-pLwj1kO_GKQ-1; Tue, 23 Sep 2025 10:39:51 -0400
X-MC-Unique: m7YXmmf_OE-pLwj1kO_GKQ-1
X-Mimecast-MFC-AGG-ID: m7YXmmf_OE-pLwj1kO_GKQ_1758638389
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-84f13fb5b5eso302967785a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638389; x=1759243189;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxQDp0IDyzApp/052cL0s/7veaxFSTNbvA8rR+FrLW4=;
        b=eV5c18viAfBfhvJP7QQIW+4Dr1KQHVSVNi2w80twxQByXiGd18RsjsY/nDn/BjORuN
         fjZVAnOvucCCM2/sN15l3H7Dsp57xguWZRmGfJIgZZAQLOfPE9Rw72lmcmeFOUqT6PLB
         tDbvoqJCWi9JftQ1rIRtVCPsnAj7NtlpCXbY0HDk8j5ZmY6o3Jh6n238HmcCjdipwNIB
         oejXhtqAsmQt5Smt5E74npbnQUGWdjRD3e0WjK62c4f4bseOUm7HGui4xdic7jRGZjTN
         WFTarr80rYKqXwcaWl5bmVrvqDSvrsXzEKT+TbiZAoDu6JZESVUk+Md3LcJ4rLor5BM3
         cy+g==
X-Forwarded-Encrypted: i=1; AJvYcCUchluYnfo0ZRpBhE4oiY99MLR6C+0Cqvma7BlwA7Z0ax4tvd/OWw8jBRfMu1Gt6yrh+N7MVaVJhaDWevQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFTrs71Ih0j6iU8OmuF8UFxebIgVgYN1LxHV/sSvlK76LLBokp
	Do3i5kOsanyESGCslKOYJ7exHlOO5oOJoGYsmTrYhtafdFqHesQJPXmjGmDyPuIjgK5KAyWkxcN
	ntf2diYbieXJLC/5l6X202o3Xo/NrSbrZMeevMTQAvIoo+6z5JaLTwAraH+h+Ie9/iA==
X-Gm-Gg: ASbGncuYA8csKRbzHO0iv29SCusysoOMzzkMQoj4iV+IGCaG+6Pa0PdQjNkI6b0cMBW
	Iumr0iNjwmlGxYvDAaDj6jfS1nZlOVPRhsZ2LwSJDv30wkSolSG/mCMXAQjU4zHQIZboEtEbdth
	BHB+z3Xznha3Vgppu89vQe1snSZfbhiKf0Xl1c0p4gxJIJn7jZI3CoDBBRbU3Cp+XDwMQTv9TCp
	IDjgqdRUfP+xssm3+BTGXtA+JvtqjVz8xXPzhKKRzRp/McDMJEDfJXw7Lw+uNWWCIGW9syD9GIf
	JZ343m+PFV/ibKzefEFrKDBecIpMzjZ+PUW6J/Gos1zqi7Axg1eXVC7B1opcCMKwS6t94OeioJ/
	k43i9LnU6muJR9im2F7yB1r4/erLB4k52GiSDWeE=
X-Received: by 2002:a05:620a:29ce:b0:850:4384:d1b1 with SMTP id af79cd13be357-851693f2eb4mr325778285a.4.1758638389245;
        Tue, 23 Sep 2025 07:39:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbl6Ccgcfq4My26UrD2QnlIWNInrCEn8gh2opFWhE6oWFWO0OrXhCproHe9Ov0haqvkJ0S1Q==
X-Received: by 2002:a05:620a:29ce:b0:850:4384:d1b1 with SMTP id af79cd13be357-851693f2eb4mr325773985a.4.1758638388561;
        Tue, 23 Sep 2025 07:39:48 -0700 (PDT)
Received: from [10.175.117.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84f2f6f3c25sm230272985a.49.2025.09.23.07.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:39:47 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH RFC v4 00/12] clk: add support for v1 / v2 clock rate
 negotiation and kunit tests
Date: Tue, 23 Sep 2025 10:39:19 -0400
Message-Id: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABex0mgC/12NwQrCMBBEf6Xs2ZWYNJp4EgQ/wKv0UJLVBLWRb
 ChK6b8b6s3jm2HeTMCUIzHsmwkyjZFjGiq0qwZc6IcbYfSVQQqphRFbdI87FuLC6JNjVE5Zs9O
 WrDVQR69M1/hehBc4n47Q1TBELil/lpNRLdXPt5H/vlGhQKHbnrw23nl1yORDX9YuPaGb5/kLu
 AnkWLIAAAA=
X-Change-ID: 20250806-clk-tests-docs-3c398759e998
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4232; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=j9EbXoSuWTRW4S13uHojnmdjX60lsDhKsm/Ff+KWPLU=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDIubdSeIBrsmMct/3jx1pPsej5Hpnpwi93N4ea5a3B0z
 sWD71vEO0pZGMS4GGTFFFmW5BoVRKSusr13R5MFZg4rE8gQBi5OAZhIUCzD/9TcIBc2g1P3n/1u
 PxMbmVDPtfTKt62ZPPe3tIUIHnDezc7w372MzWKK3Yq1NicLq3VqDifoLV1w3IXzF8+Tp15vL/q
 pcAIA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

The Common Clock Framework is expected to keep a clock’s rate stable
after setting a new rate with:

    clk_set_rate(clk, NEW_RATE);

Clock consumers do not know about the clock hierarchy, sibling clocks,
or the type of clocks involved. However, several longstanding issues
affect how rate changes propagate through the clock tree when
CLK_SET_RATE_PARENT is involved, and the parent's clock rate is changed:

- A clock in some cases can unknowingly change a sibling clock's rate.
  More details about this particular case are documented at:
  https://lore.kernel.org/linux-clk/20250528-clk-wip-v2-v2-2-0d2c2f220442@redhat.com/

- No negotiation is done with the sibling clocks, so an inappropriate
  or less than ideal parent rate can be selected.

A selection of some real world examples of where this shows up is at
[1]. DRM needs to run at precise clock rates, and this issue shows up
there, however will also show up in other subsystems that require
precise clock rates, such as sound.

An unknown subset of existing boards are unknowingly dependent on the
existing behavior, so it's risky to change the way the rate negotiation
logic is done in the clk core.

This series adds support for v1 and v2 rate negotiation logic to the clk
core. When a child determines that a parent rate change needs to occur
when the v2 logic is used, the parent negotiates with all nodes in that
part of the clk subtree and picks the first rate that's acceptable to
all nodes.

Kunit tests are introduced to illustrate the problem, and are updated
later in the series to illustrate that the v2 negotiation logic works
as expected, while keeping compatibility with v1.

I marked this as a RFC since Stephen asked me in a video call to not
add a new member to struct clk_core, however I don't see how to do this
any other way.

- The clk core doesn’t, and shouldn’t, know about the internal state the
  various clk providers.
- Child clks shouldn’t have to know the internal state of the parent clks.
- Currently this information is not exposed in any way to the clk core.

Changes since v3:
https://lore.kernel.org/r/20250812-clk-tests-docs-v3-0-054aed58dcd3@redhat.com
- Update clk_core struct members (Maxime)
- Add v2 rate negotiation logic and additional kunit tests
- Drop clk_dummy_rate_mhz() in kunit tests; use HZ_PER_MHZ

[1] https://lore.kernel.org/lkml/20230825-pll-mipi_keep_rate-v1-0-35bc43570730@oltmanns.dev/
    https://lore.kernel.org/linux-kernel/20230807-pll-mipi_set_rate_parent-v6-0-f173239a4b59@oltmanns.dev/
    https://lore.kernel.org/all/20241114065759.3341908-1-victor.liu@nxp.com/
    https://lore.kernel.org/linux-clk/20241121-ge-ian-debug-imx8-clk-tree-v1-0-0f1b722588fe@bootlin.com/

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Brian Masney (12):
      clk: add kernel docs for struct clk_core
      clk: test: convert constants to use HZ_PER_MHZ
      clk: test: introduce clk_dummy_div for a mock divider
      clk: test: introduce test suite for sibling rate changes on a divider
      clk: test: introduce clk_dummy_gate for a mock gate
      clk: test: introduce test suite for sibling rate changes on a gate
      clk: test: introduce helper to create a mock mux
      clk: test: introduce test variation for sibling rate changes on a mux
      clk: test: introduce test variation for sibling rate changes on a gate/mux
      clk: add support for v2 rate negotiation
      clk: test: introduce negotiate_rates() op for clk_dummy and clk_dummy_div
      clk: test: update divider kunit tests for v1 and v2 rate negotiation

 Documentation/admin-guide/kernel-parameters.txt |  15 +
 Documentation/driver-api/clk.rst                |   3 +
 drivers/clk/clk.c                               | 201 ++++++-
 drivers/clk/clk_test.c                          | 694 ++++++++++++++++++++----
 include/linux/clk-provider.h                    |   7 +
 include/linux/clk.h                             |  20 +
 6 files changed, 835 insertions(+), 105 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250806-clk-tests-docs-3c398759e998

Best regards,
-- 
Brian Masney <bmasney@redhat.com>



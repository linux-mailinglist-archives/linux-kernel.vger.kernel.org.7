Return-Path: <linux-kernel+bounces-765061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E93B22AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BBB916D5F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37362EBBB8;
	Tue, 12 Aug 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikpkSsUZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4D9280CC1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009657; cv=none; b=EY4hKgcZ7vs3bewaNQgGPn/csbBJTbfu1ffcxGckFTXIuq99Hyu3C8QInyHxbJJlcf6eIBQHdyFW1JwsehtIB+O4zVJRt3reIOLvKgrvdfIJlK++4nwqZdOWp6/I/ApXvxFbceaZPSRowu2CbTKiSWkQKgjWqOwbr0sBI/n71+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009657; c=relaxed/simple;
	bh=O1BKycRGNthSYb0ohF0X4SEMZkG88dk2jx+ATr4R8SY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nCUGtgxjCGYO7Bx/uOJRjjXgKKSpRGTDsDlmDcGWxMBrEQR//CN5kMHxb0zLOLX0T6VU5KWyRycW5wGNMRNLBUaFrNdH1eDBFcCEz662qpFigIwmQMLk446H5NNvkhPD42/T4jCcfclNYxI3JM+0VimpGn177JcTC2Gi525B0fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ikpkSsUZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755009654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GrtlWkPykP2UGhEYZ1mlITFEOfhFQseir/1q2h/KuPs=;
	b=ikpkSsUZ5q2xoM6sfGwAicxXBYQv5PqzXIL4qkiD2O3cwu0JNGYDiAkJDXtcXKIhI90gg0
	CCM3Iyy9eWsX2gMQvAedrIpbSyxJ73QYhCilYPHpYemBnZN7+4bPADLqijWzJ/ro/RlU15
	f2YPMu/2+/OikydgR0AwOQubVLuVL1E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-4T_W1NVgNQmQ9OvJVJuHFQ-1; Tue, 12 Aug 2025 10:40:52 -0400
X-MC-Unique: 4T_W1NVgNQmQ9OvJVJuHFQ-1
X-Mimecast-MFC-AGG-ID: 4T_W1NVgNQmQ9OvJVJuHFQ_1755009652
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4af1a20cbcfso146406851cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755009651; x=1755614451;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrtlWkPykP2UGhEYZ1mlITFEOfhFQseir/1q2h/KuPs=;
        b=TfVy3/Lz3CEctIQ3z2BK6es+d8WHGTT4JnVWhiy7jywagTpEUgi9x9+vhd4GGVZ8Kl
         eTxXNJv1yUtmNVkhIF4gp6fz6JoS5HW6n26g/tAIx8aRAQ9+JyoIpQT3yUL4x2+qjA8Z
         1dh0PgpOckfh6mHibGwNexyWeKZFBEIw0uB/ssQUvl6yBmIRMbj0ndKvZpd0FsgKZHrO
         7hALKazzC0djJLNzmQ93vGnx/RHP55A1TjDDtQcfKaWFHc3muVmj5q3zxkrD6GujUTnq
         4CIax69Gt424t4ygw2MIpkkjMGPHK7ou0YHq243RXqgFApDKjYhs78DpdKm1nkViH6bv
         7ObA==
X-Forwarded-Encrypted: i=1; AJvYcCUobH+jzogT4GXDEMw3depyZi9OSdLjZIQ1kdmdHgwUJadR8utTEmE0wBqcZl8OX9oOvM6c1xKBdeweMrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOGm91sisUIdme0IsOS9dyEw06X4JQU66iJUs3uWerZXaI/a1+
	0nNHcAW2xTcvBfZS3Mg1gfyjJCXMQfgebNh8MIGM8JZBZGZOTUFvrPokhwDZnyZE2urTt2CAUNc
	jlE0oMgDAb13tBNSQ4nyxs9KA6cNmUq2xCaFvrdNwXIPU/LJ0rW9AKDNg8UtfUHTqSj9cnBCRUn
	GaK4UqvdAo5HO00+RVoGEXVThi/WT2t7zAvTgTYC3SD6fBPY29orA=
X-Gm-Gg: ASbGncvDAsRFscbt8EZsnLZAZQlljEdjAE5SIBPGvhRpL5PTf7mQ5+IqZ2Iuc8MfPJe
	SuhXm9v64gZBm7Fm7bJPW9oaSrwj78PLgAYd2f4D5KDTTvfRDWSyu1aMLJzuzjWJ8s6YFZ8b4RJ
	saJGildOlU+dzyyrMLSFVEPDwcpNsLxfu3EAQqT4Add1kl7CCKMwMEz5Mn35he1fOi5WPNUVXM8
	QdqwAg9Z9e45hHrr5fFKx2nF+BT7aRhWrYgx63coUoZ7q2ZXG7k+mZb281t+uHEH5EsDxvsm9fD
	CxzZLOLX1A2Zj0FAhHPXgPhB19VWG1TmqzOHa1qGvCfBBQJErWQn5BgDY6JFZGSKxw1iDbpQNx3
	zdg==
X-Received: by 2002:a05:622a:424d:b0:4b0:8ac3:a388 with SMTP id d75a77b69052e-4b0ecbe0220mr54542211cf.19.1755009651030;
        Tue, 12 Aug 2025 07:40:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJjQ2WPo3VYUQRWF+jr5lSqQVnMnzVYSgVHk64lWJXULfngTJRBQVPkwUKVYUa2Jx1W0rdMA==
X-Received: by 2002:a05:622a:424d:b0:4b0:8ac3:a388 with SMTP id d75a77b69052e-4b0ecbe0220mr54541511cf.19.1755009650235;
        Tue, 12 Aug 2025 07:40:50 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0aa1efe78sm76186821cf.8.2025.08.12.07.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:40:49 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH v3 0/9] clk: add kunit tests and some documentation
Date: Tue, 12 Aug 2025 10:40:30 -0400
Message-Id: <20250812-clk-tests-docs-v3-0-054aed58dcd3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF5Sm2gC/x3MQQqAIBBA0avErBsQxdKuEi3CphqKDCciCO+et
 HyL/18QSkwCXfVCopuF41Fg6grCOh4LIU/FoJW2yqkGw77hRXIJTjEImmC8a60n7x2U6Ew08/M
 P+yHnD7fRrtpgAAAA
X-Change-ID: 20250806-clk-tests-docs-3c398759e998
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755009649; l=2947;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=O1BKycRGNthSYb0ohF0X4SEMZkG88dk2jx+ATr4R8SY=;
 b=T7Unh4WiIdFvx62ErZ3kQ1ReqmvhteFdVWsKujqYSX2E1vKD+ePlNyx/rUwfDjXSEkUFzJoLT
 khDkX2wlCpuChekvUTQ+na5TBBONHUFUItozo2mIWySt3nX12pcjXYS
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

Here's a series that adds various kunit tests to the clk framework,
and documents the members of struct clk_core. These tests are centered
around inconsistencies and limitations in the clock framework that may
lead to some clocks unknowingly changing rates during a rate change of
their siblings.

The intent of the clock framework is to keep the siblings clock rate
stable during such an operation:

    clk_set_rate(clk, MY_NEW_RATE);

However, it assumes that the sibling can generate that rate in the first
place. In many situations, it can't, and it leads to numerous bugs and
solutions over the years.

https://lore.kernel.org/lkml/20230825-pll-mipi_keep_rate-v1-0-35bc43570730@oltmanns.dev/
https://lore.kernel.org/linux-kernel/20230807-pll-mipi_set_rate_parent-v6-0-f173239a4b59@oltmanns.dev/
https://lore.kernel.org/all/20241114065759.3341908-1-victor.liu@nxp.com/
https://lore.kernel.org/linux-clk/20241121-ge-ian-debug-imx8-clk-tree-v1-0-0f1b722588fe@bootlin.com/

We intend to fix these issues, but first we need to agree and document
what these shortcomings are. These patches are meant to do that, even
though some will be skipped as they are currently broken.

Changes since v2:
https://lore.kernel.org/linux-clk/20250528-clk-wip-v2-v2-0-0d2c2f220442@redhat.com/
- I left out my patches for changing the rate change propagation in
  the clk core so that parent rate changes are negotiated with all of
  it's children (and below). I will post a new version of that logic at
  a later time once I finish some more cleanups. The changes that are
  coming will make it so that the skipped tests in patch 4 of this
  series (div_div_2 and div_div_3) pass.
- Make divider clocks one based (Maxime)
- Text updates to clk_core kernel docs (Maxime)
- Convert from KUNIT_ASSERT_xx to KUNIT_EXPECT_xx (Maxime)
- Minor documentation updates to tests
- Drop rate constants and introduce clk_dummy_rate_mhz().

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Brian Masney (9):
      clk: add kernel docs for struct clk_core
      clk: test: introduce clk_dummy_rate_mhz()
      clk: test: introduce clk_dummy_div for a mock divider
      clk: test: introduce test suite for sibling rate changes on a divider
      clk: test: introduce clk_dummy_gate for a mock gate
      clk: test: introduce test suite for sibling rate changes on a gate
      clk: test: introduce helper to create a mock mux
      clk: test: introduce test variation for sibling rate changes on a mux
      clk: test: introduce test variation for sibling rate changes on a gate/mux

 drivers/clk/clk.c      |  55 +++++
 drivers/clk/clk_test.c | 611 +++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 575 insertions(+), 91 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250806-clk-tests-docs-3c398759e998

Best regards,
-- 
Brian Masney <bmasney@redhat.com>



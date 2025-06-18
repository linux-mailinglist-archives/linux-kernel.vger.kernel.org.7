Return-Path: <linux-kernel+bounces-692881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22713ADF82E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 22:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9F23B5E05
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 20:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C9421D3D9;
	Wed, 18 Jun 2025 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c+ndTP98"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B193C21CC49
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 20:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280179; cv=none; b=BjEU4bOjKFCqwJ/pSYTMNPiKUY0FoxqMYGmynK51RgN3J0YbAxaKLYL8jJFVr64RjDmirUlNQ8LXwuSrEHGO/4bYZVqYMkHR7jLzDnFvWI52ybJ0TfWnJJUVVnbpL6Z+2kP7mha0e65TyHvvvQOXRNdjFIASMczhn429ofE0pJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280179; c=relaxed/simple;
	bh=yPuRJawzEWJ1EyGIWK1zT50vZKMJKo73qria//lQPcc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p2E/1FHUkB7JeiAXvDoycuEpgmN9t1hqXHvDktWpn0GS1jRFcPyJbs6VRXSctBuySSTrp/G/essSnXNTCp7J/pW0kuGZ45yzXxjNuBJBOepyBCLQsYfP7FrnJ0zpP52zjFQKfztJ2mmXTUTsAXLrGsW0r9TTpy5iptVK9kJPXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c+ndTP98; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7394772635dso54621b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 13:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750280177; x=1750884977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mgEMhBGnSzoypEISslS/Kxa6JMNk8Qvu76svdRFkeqI=;
        b=c+ndTP988uqDrlxPPwYGFNBSFUR3l0RfkzD/PPmMrdRN/CyS65CMsHZaJYf096zQur
         3g0g5ypbJozgtEkf9kmhxAg/9v4X0cNl+vg2prNwmTCd7OD3DQeOHiTdgt8zaoaOr0sL
         a2GytWRurqrGs8snCBq59yalgfWBYZxILt+7FjI5OX4iIth9IeKp7QFHuL0bIw20mXCn
         XFzo5Ka2fKVckRZLTTNMqENjBver40jSYF+NYppqsNKsrjBFTs8hnOWzApKMZu0iQSrW
         rR3mjleyEbdhrYUFpyKdjXwHWCgygLng7Iz4hfiMBV/8VjWFvq6VBH6MbzTpr9IvXFAU
         4zrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750280177; x=1750884977;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mgEMhBGnSzoypEISslS/Kxa6JMNk8Qvu76svdRFkeqI=;
        b=naJhdQtM0Z/lggvioKVkJHVZ6jW6L0MlAhwkQzZ8IlQfT3yq2f6tiGf01TDmy36cDH
         H68C7v0Q4slzsX610cSf2jn1MK7wEqkRY3VvbkkEQ/9nD5dkyRoDOa5dTinE962ETgsu
         CFa1qox7r5TnDScXU0JChCwmrgWNZpsk5RIeOK7KPYLLx9IoGuEC51GjGpr8cQVBKNpD
         p7VqQuqOAEzMNZmkDn8Tdbr0Vvn5N+3oi3dfWUy8v0SUXtUZ1aVHc1HxqE8LLYV+cIZg
         41TiXTjWGsqm0+x8CateZPQigjJFlm+0t0sbX5mxAzhx+WcBMGMar3B5RYETfCrdl5A5
         zKOg==
X-Forwarded-Encrypted: i=1; AJvYcCWewDbWPtSwDHJP4qK9v7erIhHy2Dwzs1QKEcgRExs/UTLUo8MioGZIeaEEVreDQ6ksl2Bb2/urNBfet9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YylL7ImwE8vudLJhOiG1t/MoSLB1nGZifjCjZAOuHBqOrViz7ML
	g8DvhV/8HaFJs0SdSelFEBUqjkWI2BBLedq3XQ70vqGOMldnwxMqWoW717FnpW7O5vaGJUhBcyw
	AaX3NmyFteg0Tj72hMsd9MslZEw==
X-Google-Smtp-Source: AGHT+IGdAVb11hevfXclChQEtCUtIDcLel0+esqPqUojNt899+GV78+G2AgxOj7MIf4OWrM+5N7MZSNtAetIGbCT4g==
X-Received: from pfbjo8.prod.google.com ([2002:a05:6a00:9088:b0:748:fb38:1909])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1aca:b0:736:ff65:3fcc with SMTP id d2e1a72fcca58-7489d03355dmr28313713b3a.16.1750280177074;
 Wed, 18 Jun 2025 13:56:17 -0700 (PDT)
Date: Wed, 18 Jun 2025 20:56:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250618205613.1432007-1-hramamurthy@google.com>
Subject: [PATCH net-next 0/3] gve: XDP TX and redirect support for DQ RDA
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	ziweixiao@google.com, pkaligineedi@google.com, joshwash@google.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

A previous patch series[1] introduced the ability to process XDP buffers
to the DQ RDA queue format. This is a follow-up patch series to
introduce XDP_TX and XDP_REDIRECT support and expose XDP support to the
kernel.

Link: https://git.kernel.org/netdev/net-next/c/e2ac75a8a967 [1]

Joshua Washington (3):
  gve: rename gve_xdp_xmit to gve_xdp_xmit_gqi
  gve: refactor DQO TX methods to be more generic for XDP
  gve: add XDP_TX and XDP_REDIRECT support for DQ RDA

 drivers/net/ethernet/google/gve/gve.h        |  27 ++-
 drivers/net/ethernet/google/gve/gve_dqo.h    |   2 +
 drivers/net/ethernet/google/gve/gve_main.c   |  42 +++-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c |  77 +++++-
 drivers/net/ethernet/google/gve/gve_tx.c     |   4 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 236 +++++++++++++++----
 6 files changed, 314 insertions(+), 74 deletions(-)

-- 
2.49.0.1101.gccaa498523-goog



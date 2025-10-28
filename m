Return-Path: <linux-kernel+bounces-874294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 949C6C15F36
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03EFA355839
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA5C346E6C;
	Tue, 28 Oct 2025 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erq408jN"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058F346E68
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670308; cv=none; b=cpc6zUpBXz9IplNha8hUfZxnYdrYrycwJwPXXbyVqLn/wHQFRmojx6jKJwB4Qj6IU58R5ZKtE1jT51qMj3Evt2P3qeBEcSS21JnLHT/NGPuD2aRO/PDzUYPrlDWHeSozdxw5DYYA8YJZvHJSykVUy1rIE2WG8EzlG6qjNUqzDno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670308; c=relaxed/simple;
	bh=SaHXQvdh2UGDjNMvQuSgMOQm+hQXIPvqzOzIWG/Ij6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PSwJn0dVqjYhnMQ/yAgXd92x/u/iTjXdCkG7Ns7poWH45Fu/D2lG9MhsJzYMzP1EDnVeksR3+QMnEc7h58lm3nczQ8l8coB8pw7Vn93pB3ywskfNBAMQtJTqrBi2LNBesvQ5ND427BdpgbPY6ddCG+/uYRpFd7JUoncqIDN/k9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erq408jN; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6cfffbb1e3so4528339a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761670306; x=1762275106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TW6r50dwFdVWTwN56Kmq0E/zepcTiRFAnQQGIUFFOlY=;
        b=erq408jNv16Q9doD68JdqRULGj1p/PJAq6kgs+7DNFb/2HUz2sy0LnfyRRv0P0bm3k
         dxYHRY+k+mueEy65NNEvsEMIWODJrFQ6b6CPZtrIybITzscqMoy0FJSJp7xmokmHqCHq
         XIsEwlbIobxNqZcfLPzQfcq5CQRyryaklmK12QD/aN6Kt4gOvnRHOmIRH7mg6JYSZ0gy
         QmR9KO1idaWteW1zdAPBG4aEQ2PmT7uLRbFNs9E4wguhPkNtmvzhnOgnEJGBSxywkTQa
         g+O3DIw8fIzrU3ablHN5pRcqsJ3g1AHg6BHnS73OmoShJKatRvhd+8EdSaKolqyDewk9
         MzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670306; x=1762275106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TW6r50dwFdVWTwN56Kmq0E/zepcTiRFAnQQGIUFFOlY=;
        b=F9oRwOvWQ+q8w4YIw6SMyuY59vo3yWX1uLPg8VYvOj6EAYMbMfKHyZe4UER2a1vCq0
         V00AWcj9aaosd+K/cBY+6SMxlu5rA63prrIfBsyaeUPLKGZqV6uT2avyexd9zWHZWjvb
         /Eum67WgAvTR0GN2iRN6/eJGkmqAsmuNPpW6+qeZCM9NWmMHCwNFVE72eNNge0BcvWv6
         ujWlat6zgnWlMNQkD+a/bgGjwXZ3pAW+lwpZrImeR11yVjMP0aeHhWqLSePPbjyP2HQX
         GMuzCDvTPzrXkQAZtHQLwh3JNKZbfdl/3vmDcy4QJSph5M1RmBZEOlPkCvF/LyPVaAe0
         GseA==
X-Forwarded-Encrypted: i=1; AJvYcCWW2rkSHRK5rqrBzpC7AuNpo8lX0GdbC19BkTo4XX6J2/7QQ2XBGFoJJm7RStrv6b1xcOrOaNKWPTAtA0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5h52Vqpjh/eGxatP2j6/gszus5YbLWdSAgHVvn4OS7mDMGp6h
	AwXtOLxBTKXFQQdL3T99DiuZsaOGMaZOgVS/vO3dYpKrf+EfRh4kumazpCc36obY
X-Gm-Gg: ASbGncskkptt+jFTxt9qWbkx0CBFuzl+3fzD9itIEMlNDnFAh9koPDIXyVacyZ08XDO
	cQFfrSwWh9DENHHRo+Th18fxtj8ZO6duVyqmN0hGlJ42dLbLxC4dQLETc5rmT3vktUt7hcRjkPb
	d5gtmK2N/xdSwIXE2IhryJmmC3/zf6m1wV9ySI/R7NPCe1nIFtzCB3GwgfAaN3HAIwFl6PSB5oY
	TyFbn8eIPnH22QBAUvyS2SAcyLcLfvqL9MDO4YOVUy5Kizkg9YBONoTjEvSxsH31HRv2m64dQIy
	sMla+EbPdIN7z6p6soZ1xIZhKjZPqasUksZdqbtzvZGyj0zUA2mKX8Ki3YloquVOjVgi8R2Ls9H
	kD1aPl74whpvJUho7nvaNQtVnhEKPUG9+9LnzebLci4/atfGjWT5RsWTbxv1M0mdi9a5byZfhht
	lVPXrKH8wgNtCv40yWLuKlRQ==
X-Google-Smtp-Source: AGHT+IFa+t0T9JhACfecPKraiGSJrNfChEEfsYiWyHTAHA4vmk2NppgRgurHVrK/RhTfdJWkTbdROw==
X-Received: by 2002:a17:902:e5cc:b0:290:56e7:8ca9 with SMTP id d9443c01a7336-294cb6916bemr53051615ad.52.1761670306208;
        Tue, 28 Oct 2025 09:51:46 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:77f0:168f:479e:bf92:ce93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498f0be0esm122123665ad.96.2025.10.28.09.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:51:45 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/5] Add XSPI clocks and improve divider clock handling for R9A09G077 SoC
Date: Tue, 28 Oct 2025 16:51:22 +0000
Message-ID: <20251028165127.991351-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series introduces support for the XSPI core and module clocks
in the Renesas R9A09G077 SoC. It also enhances the existing divider clock
registration process by utilizing device-managed helper functions and
ensuring proper propagation of rate changes to parent clocks.
Additionally, it adds necessary clock definitions for XSPI0/1 to the
device tree bindings for both R9A09G077 and R9A09G087 SoCs.

v1->v2 changes:
- In the fifth patch, added a custom divider clock type for XSPI clocks
  to enforce hardware constraints on supported operating rates.
- In the fourth patch, added Acked-by and Reviewed-by tags.
- Added three new patches 1-3.

Cheers,
Prabhakar

Lad Prabhakar (5):
  clk: renesas: r9a09g077: Propagate rate changes to parent clocks
  clk: renesas: r9a09g077: Remove stray blank line
  clk: renesas: r9a09g077: Use devm_ helpers for divider clock
    registration
  dt-bindings: clock: renesas,r9a09g077/87: Add XSPI0/1 IDs
  clk: renesas: r9a09g077: Add xSPI core and module clocks

 drivers/clk/renesas/r9a09g077-cpg.c           | 186 ++++++++++++++++--
 .../clock/renesas,r9a09g077-cpg-mssr.h        |   2 +
 .../clock/renesas,r9a09g087-cpg-mssr.h        |   2 +
 3 files changed, 174 insertions(+), 16 deletions(-)

-- 
2.43.0



Return-Path: <linux-kernel+bounces-857532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D59BE7089
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DD994E15C2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C656262FD9;
	Fri, 17 Oct 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IOIcl56y"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4127C1A0BFA
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760688170; cv=none; b=Nbl+6QdZWlPT3Ta8UlfMx+RFbxUg3FYIbbNxPkXwNxRKQlCVhayz6F3zKzr7F2SK3yEAOZxops8WvZqT2Akb/HQvpqOzSlv1epvJCK6kfZw8eIvJ32i7cK56NjwecMzk+H6yCkbO3UWblM9KfKuE9FGawBwedA0Ln/j74hV/P7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760688170; c=relaxed/simple;
	bh=+Zz86raGXQ4tEA6M4IJ4q4AZu+RYhIAQ0gpsL4WG+Og=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GhoVcA4rTN8u+iNU3HEmdZn7NO8HUV7eVVrh2VYm4KXtkHxC9Md6goO6gD3lwxPGmzjElNQDWtPHJAf+2IvJS+m9yhS43+AVOfLlKEHZglF5lgMCKqEa8nBS+APX3cESloJdSi5V51x7m9UX0Ydk69cxX1wWVMZIife1+NfxCd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IOIcl56y; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee12807d97so1513780f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760688167; x=1761292967; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g6jUScl2NITZ+PoGEq7AwOuZFPu/G6TgC/xMdzTqEyA=;
        b=IOIcl56ypedoZC49+uSoe3y1328eMGiPMbrWp5qmwmZqUG6bxn+xEXJ3KeA3B2H7eE
         elb3UWhXa0C4aaeD/hudbPo7sxeRtKcS4xb8vthzqTQB1hlqXYlxUS8++MKSAvNweHjQ
         wPa/jXLvaVZQQ/O4K5D7o6Wujk/f/ZCEo8eOEDqlWsu2ygqJNdV72uwjsMoETpX/shsD
         bW/7ar9zyM12sywZ94gT5SDQDyntvEK96oMib7PU+g+3O/L1XkVl8LzFxwxOWMdLkbHo
         HQ64ygdN7nl3OjeJrgvigRGXSOZlMVgxV2x8nL1E36k+bx8aNVv39sOCPLpXIqlPbxv3
         kK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760688167; x=1761292967;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6jUScl2NITZ+PoGEq7AwOuZFPu/G6TgC/xMdzTqEyA=;
        b=HGgqP/kyq3TqAkX0I/gThX81o1eZgZK9DS+mOmZi0FnbO1+eSG48IMUqzZqoLPAnqP
         zNa6O4w86jU7DquPOE/ncynsDWPXXEpvRhorn1N5/25R3qtG4qg4U3zDXZXdKpXEBsl5
         YYn3ffIfyborRQk3pQYHtG7pZi5w0Zwl5VZDRQ6DreIFw3giYZOVYGkStOajsMnfwtWu
         GFpmT01ZPotQTO1N/wnUYt7AhSSGgJwK41no8yVhQfkX8QywH6+VzwO3SGeQYvLAOCDw
         6/PAPsW9hdWmgcYP6f9b+X1+m8SOTQtycR+qIWzY61o4guo5w9NaNahFMTkRUIJtAIBw
         j87Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmYBFX/PK6MvP32iabv9gjO8cWst9GVWt04JO3AjiEMVDLJf+haPqO1rCCY+k1sIG09nK05cpNxPihT1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws6wtha3So0dVYWhimhXvJFNQC7c91lC2wuNgpRxk+8ZIfgHo+
	SL6LNGexoY8xpaRcAa8hQ1Z04PMim1+IcKjBry1FmOGBKK4YI2d3LXK7ROe3qXobXB8=
X-Gm-Gg: ASbGncuwwCBkjfBF07JyehvY7bTRvwSJfN7q65iDbYokC8gJhXmI5ONyBCqCfll669u
	WJoXlbzMuukNbZFCrVDW7fkHqQzkdenDbfbCqY9vZ4RQ73TDnu+cpu8D/icv5QPy0Da7BdKKk+t
	LL5WDk8zESjLoJ/eY3CnsJdzGL7cC5WFjnQk3oW/DM13+5wy6t4dXG662e8dRFAhe6/yez4Xph1
	nvjySdp8dGG+EmFBJsLFqmxAFmtSEah6rp4EbGGkNa55Ru3iZlo+3p6e6EmHLC+6UP+hvTE6QHN
	W7TMl1A4ZGdq1jvWFH5Skdf3/bNQ8Rd4As02cpgxcv4pKOSah+ohvEAXJ5N8tP7ecw/2RVE1NF6
	ulGoSVUiXbgNcAm6hbaSnHyPxICeEKicDA86WBMg1ngt6d8MuknC/sy9Oo5aSXWUh0hwMZds=
X-Google-Smtp-Source: AGHT+IH+3cqatsdxr7KnVnzTd2G0piwrqv+5MDST6gZ033Fz0Y9dVGarFXa+3uevs+8omXzS46lViQ==
X-Received: by 2002:a05:6000:470a:b0:425:8577:9cd4 with SMTP id ffacd0b85a97d-42704da392fmr1867346f8f.54.1760688167461;
        Fri, 17 Oct 2025 01:02:47 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:6c59:a281:27c9:93a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42708bcea1bsm1082308f8f.14.2025.10.17.01.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:02:46 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/2] reset: remove last remaining user of the legacy lookup
 and drop unused code
Date: Fri, 17 Oct 2025 10:02:40 +0200
Message-Id: <20251017-da850-reset-lookup-v1-0-362a309a9f09@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACD48WgC/x3MQQ5AMBBA0avIrE3SVqS4iliUGUyISotIxN01l
 m/x/wORg3CEJnsg8CVR/Jag8wyG2W0To1AyGGVKrbRFclWpMHDkA1fvl3NHHlxhyZCluocU7oF
 Huf9p273vB/I6i0xkAAAA
X-Change-ID: 20251017-da850-reset-lookup-eca37d2d7d9b
To: David Lechner <david@lechnology.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=+Zz86raGXQ4tEA6M4IJ4q4AZu+RYhIAQ0gpsL4WG+Og=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo8fgieyvnPPpUx87hUI3kShF3FIW7747ARrkfT
 z88AlKReOGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPH4IgAKCRARpy6gFHHX
 cuK8D/sHa0OZJF7j3ijUfnr6NiZoBEgUXeJHwvw37LgQUgRWVv0/8SZFl+jBB+6bjTQEnMB9eup
 UJh15hLQ/555Xc7KSC9MZSB1MAkmn8sPcagTXxoXZyedkGYaV1Kt/FScT41ZevjQUcfOTcOwy7y
 FjzDf/FtNSrkDlenP3Qotm1mBsNkdmli/nvVwzobKmzLNz5g3w9A/ZzB7h8glS6U0aFQXK3VUbi
 LfhTX1T1uy2rqNdJ/zH3+qWp74gMfzd1QsSagblV0n0X55mDNV8YIeInblU3y8LGkXWgY5EKzJA
 EPlJuNX40GaS4mKc2g8qGrXs81rhMsMPz65l4b7yW9dsdZy5T58QYbfohTF1O+0Z/MZZqBnD/Tw
 tMkctzQrLlsWlKMPlVQWyC3K0QDajWAxILY3U3XN8JtV1Fi+Op8mOD9AItrG48p9BKiD1YJsWID
 5Zf6X0yDGOb3bVAI9RHchmqpiZSzBgKVypIHTDkpkadWTjYcptyUENp95Q79hKBlHX8kujtfSNu
 tqskZtlwF0cMY+gNfx6pLllr0SXmVEnmVWW7RsneVUQR8Vb3nUnanz8OSjcUgGtt/wfJaeHoDDk
 qhtFwkKKviq40FsS9ALv0YGspPt2v8fWmHRvSC4BuAT81PTGYo014wHFI1p87ue21ofX5pdLQrr
 VhqLB7qM+s0YXZA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

The TI DaVinci platform is the only remaining user of reset platform
lookup. Except that we no longer have any legacy, non-DT boards in
mainline so we can now safely remove it from the PSC driver and drop the
legacy lookup support from reset core.

The DaVinci clock driver doesn't see a lot of traffic these days so I
suggest a simple Ack from the clock maintainers and routing it through
the reset core for v6.19.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (2):
      clk: davinci: psc: drop unused reset lookup
      reset: remove legacy reset lookup code

 drivers/clk/davinci/psc-da850.c  |   7 ---
 drivers/reset/core.c             | 120 +--------------------------------------
 include/linux/reset-controller.h |  33 -----------
 3 files changed, 2 insertions(+), 158 deletions(-)
---
base-commit: 2433b84761658ef123ae683508bc461b07c5b0f0
change-id: 20251017-da850-reset-lookup-eca37d2d7d9b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>



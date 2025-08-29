Return-Path: <linux-kernel+bounces-790922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F34B3AFCC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7869E188FD59
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632CB1DB122;
	Fri, 29 Aug 2025 00:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0t+9GC6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C191D61BB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427922; cv=none; b=F1praw7Kpn4XrlMIo08kDkMjW4uEtwC1UIf1xOBrs5zI7I5lEmeHmQCR4aEY9cCkLP1FKY1u3GUl8Rj0yvBpvDfjRIpa4u8cn/ESBs7Cr9Rs+Cd2Mct+6zIvs5jaSuBEy392H9WYxf8iqB0l+F6CgW8Og1oVIhYGqyN+bVZ6xEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427922; c=relaxed/simple;
	bh=qOHN+W3Wz6uTZsr/RwMmfVYf0YXCACp4YcP7f8Cqg6U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lrHSAMaJAxaPr9Z1Gxm/mtRljTFN3ZfHKOywISWhTotinTe1uze2so4q3j7qOGyiOYIfau/uXToUPwcwNj/V+aAEri2sBHfpEehmaiPaD6yg50CP4V2ggTFgXR+pUR0n9Hjwx6lXBhY624wEePYJ6JzMcx2qQFFjLjSRkvaOYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0t+9GC6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756427919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8rqunLN033sFAkyGdyaLYf8O7m070HCgXqjcGrGgaTc=;
	b=X0t+9GC6MoI0PLs/HRu/PxT+/AY4xABaaScSagmhPOusllB28RY8IWK3ypJwlUkOTOB1Qr
	714SLQy7zv6d2N28AkfP04ZtcKt1BtESlHrarkzmouELJWpPMfLtvLBr7PGUJE7b+EMZ/c
	wqFX+NeSFVSEoj8W3knQsb1FI6x1njw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-fcxyXxBnM7qIvmQDfaxd-w-1; Thu, 28 Aug 2025 20:38:37 -0400
X-MC-Unique: fcxyXxBnM7qIvmQDfaxd-w-1
X-Mimecast-MFC-AGG-ID: fcxyXxBnM7qIvmQDfaxd-w_1756427917
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b2ffba8809so27363831cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756427917; x=1757032717;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rqunLN033sFAkyGdyaLYf8O7m070HCgXqjcGrGgaTc=;
        b=gQkBlgtV4SZPOEYNK4y4aoyR/OXOJmz/zyDGeq5R3ECwyikIADSnul5eXESAtkaSs1
         YNm2tOOjFB7kXoCK8+VX3h4ultMMh/C+0MVhf2dNAllDNOmKA0I4PD5h14xWQo3elRK7
         2kh16SbfUYObXHLJqMyVkoGCV9heBQDleDhBnsQsT9HuxHME4PSKktTZjuVjVr7ElGPZ
         GSIq7agxwRPWZK2z14CofViPezyeF9q7IL6j/OOzzTI9TkMRDvVvQOwKQZWsEltslS4I
         dLK3u9vRBWk387yixrx6eM/Kj6I3nsE0o1kOtfOL6zqikVS6HQjXCEK8h6Bc2WsQyXtE
         8lhg==
X-Forwarded-Encrypted: i=1; AJvYcCU2HAtGkwOfb7gqn/UHmeADJsj/pDbHtdFcdhTr6eJpUhVZVpquRo7PC9NiDlJXWmrU9zHJHuyfWheSKb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVZ/3CJaj4/4WJnISzYKsnisi0Yo3LqQLv8c0rsfJYyp+PwcyQ
	mL3ePEc7JkUfzzN5uLF7ziIgZP1aoJQTpuac+MuxJOvvvyeSwCU9rYmyFCNLytmUERLiRe3lbsl
	26uUamsKfS8Q5zouIkGPo4di0PXXqhVp1bBybbYqrOaGbt0ctCGqNf5NIiv9K5MRV4Q==
X-Gm-Gg: ASbGncuFQgaCKPcXOIfuPwPMAPfvRpQ8dfjvPUyeKFE3MfALaVVHRDktnNuEbYidoQI
	IuDOXHvJSxcNAhiz51nYMFclf6luMMNNHgljclja6NEjZlaKWJGYC5Pi1G67XjXwlnUMi8RLkAa
	GcWldzBS928nocoW3D2FgQWNMnmgLIMmJggRxAPBm2FlyZtdE5asEp5h3oAAOgExZCKAE3tnO6x
	BO6oPTzQcwJd4/fg+2TY6BEPBos/a1rhC6nnnLVneYeP9XKf+g0kh7dLw7oPs+L2jmpslO/S+MA
	Wqtp8gSibQ7F1i7OcuViVEGlFiyF/QT4cABWjos7Bhf4m16sHNpkIPrrLmyTPICGfgJRAFyT8vX
	LaIlvr3MTTWW82rcUJI4uHYeIz/C761KsaA==
X-Received: by 2002:ac8:5acb:0:b0:4b3:7ec:d22d with SMTP id d75a77b69052e-4b307ecd715mr29164881cf.20.1756427917032;
        Thu, 28 Aug 2025 17:38:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrNg2tdKhgAQRayLc8LgRw9eIVhmfPzttivKDw9wQ2+vibEJMjJFoedzMgEqufDrqQJ1tp1A==
X-Received: by 2002:ac8:5acb:0:b0:4b3:7ec:d22d with SMTP id d75a77b69052e-4b307ecd715mr29164561cf.20.1756427916486;
        Thu, 28 Aug 2025 17:38:36 -0700 (PDT)
Received: from [192.168.1.2] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70e6264141asm5588696d6.65.2025.08.28.17.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 17:38:35 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH 0/8] clk: convert drivers from deprecated round_rate() to
 determine_rate()
Date: Thu, 28 Aug 2025 20:38:19 -0400
Message-Id: <20250828-clk-round-rate-v2-v1-0-b97ec8ba6cc4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHv2sGgC/x3MQQqAIBBA0avErBtIQdCuEi1KpxoKi7EkiO6et
 HyL/x9IJEwJ2uoBocyJ91ig6gr8MsSZkEMx6EabxmqLfltR9isGlOEkzBq9GpVVk3E2OCjdITT
 x/T+7/n0/tcMa8mMAAAA=
X-Change-ID: 20250828-clk-round-rate-v2-c1b181f598d9
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Bjorn Andersson <andersson@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Andrea della Porta <andrea.porta@suse.com>, 
 Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Brian Masney <bmasney@redhat.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756427914; l=2337;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=qOHN+W3Wz6uTZsr/RwMmfVYf0YXCACp4YcP7f8Cqg6U=;
 b=2DUui3a8WkDmdWMGxKa0tpZlU3l9oMHhpwiGjtyJgflCFJnuf9oCUJ5nnO47Aeh60KidBjjhF
 owMBgQLSuwVBuDusC8N4CQta4YOJg/XwS432e14Efcrlr58u+ubkwbg
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

Here's a minor v2 to my larger 114 patch series at
https://lore.kernel.org/linux-clk/20250811-clk-for-stephen-round-rate-v1-0-b3bf97b038dc@redhat.com/
that only includes 8 patches where a v2 was needed. To reduce the noise
in everyone's mailboxes I'm not including the other 106 patches that are
still valid. I will supply a 'b4 am --cherry-pick xxx' command on the
other cover letter to exclude the patches in this series.

This series has no dependencies and can be applied in any order.

Changes since v1:
- clk/rp1: Updated to avoid merge conflicts based on what's already in
  linux-next.
- clk/sophgo/sg2042-clkgen: Removed &*
- clk/sophgo/sg2042-pll: Updated comment from round to determine rate.
- Removed unnecessary space after cast on these drivers:
  - drivers/clk/nxp/clk-lpc32xx.c
  - drivers/clk/x86/clk-cgu.c
  - drivers/clk/zynqmp/divider.c
  - drivers/clk/qcom/clk-alpha-pll.c
  - drivers/clk/rockchip/clk-half-divider.c

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Brian Masney (8):
      clk: nxp: lpc32xx: convert from round_rate() to determine_rate()
      clk: qcom: alpha-pll: convert from round_rate() to determine_rate()
      clk: rockchip: half-divider: convert from round_rate() to determine_rate()
      clk: rp1: convert from round_rate() to determine_rate()
      clk: sophgo: sg2042-clkgen: convert from round_rate() to determine_rate()
      clk: sophgo: sg2042-pll: remove round_rate() in favor of determine_rate()
      clk: x86: cgu: convert from round_rate() to determine_rate()
      clk: zynqmp: divider: convert from round_rate() to determine_rate()

 drivers/clk/clk-rp1.c                   |  58 ++++++++------
 drivers/clk/nxp/clk-lpc32xx.c           |  59 ++++++++------
 drivers/clk/qcom/clk-alpha-pll.c        | 136 ++++++++++++++++++--------------
 drivers/clk/rockchip/clk-half-divider.c |  12 +--
 drivers/clk/sophgo/clk-sg2042-clkgen.c  |  17 ++--
 drivers/clk/sophgo/clk-sg2042-pll.c     |  26 +++---
 drivers/clk/x86/clk-cgu.c               |  35 ++++----
 drivers/clk/zynqmp/divider.c            |  23 +++---
 8 files changed, 201 insertions(+), 165 deletions(-)
---
base-commit: 8cd53fb40a304576fa86ba985f3045d5c55b0ae3
change-id: 20250828-clk-round-rate-v2-c1b181f598d9

Best regards,
-- 
Brian Masney <bmasney@redhat.com>



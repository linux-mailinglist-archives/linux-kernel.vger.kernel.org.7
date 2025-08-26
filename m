Return-Path: <linux-kernel+bounces-786593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E97B35ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523091896DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C1F2F0671;
	Tue, 26 Aug 2025 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEXcsR/1"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50375283FDF;
	Tue, 26 Aug 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756210187; cv=none; b=mpSLnKTjHFcIcrxEQ8fDAcSTMQyGUEDibkj8gA94NZForMTmhcRzZO3jnZDz9kkzv5oaH5IJCEBQjpMEgUwphPmWjloLSyy5cNMfZIeC8Lc216FAqA4V/ePuAH57z8Df7gKLot8QsoaC79axKckRDTXX2xPQkhaAu/rFOWZ8jRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756210187; c=relaxed/simple;
	bh=Bw7BnPCmbOFL5LNbBdy2vjQjegS/SZRZkp5SZgnFQR0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hMCp/4a8ImkW2tbIaxR0BTcGN4/oZiA5GBp0eC7BJsLdlqbLZPOlB+tlyTwBCQoNjMyR/pebO7Juc0/yJaSqUqswoIk3PIcb+T15bXvhhVclzKOsm4L54ieIj0lepcfvDhZ1hJ6u7mFZSC6k5pE3w/ETq13OPxY9bC1QIMp+QDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEXcsR/1; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3252589a4afso3303501a91.0;
        Tue, 26 Aug 2025 05:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756210185; x=1756814985; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QMh6zEQZL3iNnuj0oodrCX5vuHjr614t/lFt4njww8Q=;
        b=IEXcsR/1NUSOeJrDrJUprnkCMGyKpVIMjqz8iJwa91c/ThEWV826nCd0nGMPS/Xs3+
         zJnH7MJe1MgNBEmTcpeBjozO1VfVZBlP3lC7Ih4blACyl7Pnx53lqx+hkpDqnkM4zn5F
         2ay6yEGZM1rAtJQ0xNmt5Hi9tyy3ys+3LE3IviriCbsj1eoS61ZgFl3mcO8ACoT1/Mx0
         De596nMbh8S0cRdYD7qC5JrR2tBifEU33nT3VYqci43c+rq9IcWehkutpFG/Eiy4CdFk
         63OlIWQQ3A1gW/aVcufhp4MdhH3zSosLPmcY95MNbGLkmLoao5tW5MZZqAZ/6wnyW4/0
         51wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756210185; x=1756814985;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMh6zEQZL3iNnuj0oodrCX5vuHjr614t/lFt4njww8Q=;
        b=SiWCU0JPouBzQ0iueDCOIrP/8xGIaOH1KGRXW5BcMHaaIQQQP7nLXmqkqvIKJLDqr1
         r4F1a3jvaX8f/PW84ReuOqHv9tmjdRBLGHKyrQkV6u+h3tsIXenk+SrnkLyifIhIytQo
         rtN66nXIOlKUavhm65c+BNv1vSGBXiAa0+hYhCYttQpyidJ31jrBxwHaqxUpachrUqrZ
         P0XcPDmhJyKAeSpIim+esx8Cv3eOq5AYXKz88ugXBq/KItSSuzDCmOSGQVFfiReCRPyp
         1dbgWyeDQxcfJFanIvmNl67qkO+BCScGN/u0xdffNAi+y2pQXNAdpGEpI7OM7j7livj2
         ybtg==
X-Forwarded-Encrypted: i=1; AJvYcCUxnFsUvtzDtR4q5k1D68TZgRay8XOYnH0h4353WCac9M67m1S7YK2QqDErgWIuUvagBUUiunAVtoz6UcPD@vger.kernel.org, AJvYcCVGhNW/oTAo59YKdM4eNnKev3vOjE4yAp8i2vAz5Lt3GYi2Dj2gBnkDy2EdbFwXTcno9RwmzbYHcujt@vger.kernel.org
X-Gm-Message-State: AOJu0YzDzE3W4Aso2XcI9TM6zleEnKir2D3AIvZy41SFVJOrraUU8r3r
	kkGEsFv71Jbzt8huSZwgzX8pVMqLFptiaZh4jVnhzQS7Mj6IpZd3AKNDw6JxCG2m
X-Gm-Gg: ASbGncu8np6E0lOrkVEv3UxeHjrTb+nCJCgLnnf/b/o4GA2Rta4kpslE4iLID0vX2Jj
	ZWzR4RUSoch0BHTzUhWaLzgmkV5DySBXvRgOiqu4IfSykAuewanea8os5G6zzVXsKRgfTHo8whZ
	VPgr9jodvYhdRfCqYAD9fXPaRAA/k2oFm4G+W05k05haMfiPVCEY17w6qEIqT4qNpScCdrWeRNP
	F3yB4C3rF1Ar6Cli5OgXixmEV+ump7WGHPkXFdT44tVQTo8blMBHij4xXBzkoZrbOl97jMlza++
	UfqNxcotWT8bRLetS7wdMPn5O9L6C1N+Yh6oWA7zwizRTKyE3yk1wsSZ+go6ekEdydxLDLaQdrH
	c/MIeSceG6W3P2hbXPXeZ8TCBEftAjrdJc/W1lw==
X-Google-Smtp-Source: AGHT+IF2JhoGLDdpcCyhYB5vKEXb+Oohh9jsfi2DZc9ihpiSA5Lpn8KkTerrgxEkmQDoa3FYE1QOXQ==
X-Received: by 2002:a17:90b:1649:b0:321:4182:2b9e with SMTP id 98e67ed59e1d1-32515e37410mr19456614a91.12.1756210184854;
        Tue, 26 Aug 2025 05:09:44 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-327565d3924sm619966a91.13.2025.08.26.05.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:09:44 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v5 0/4] Add support ANS2 NVMe on Apple A11
Date: Tue, 26 Aug 2025 20:09:11 +0800
Message-Id: <20250826-t8015-nvme-v5-0-caee6ab00144@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOejrWgC/13OQQ7CIBCF4asY1mIYCu3UlfcwLhCGlsS2phiiM
 b271LigLh/J9w9vFmkOFNlx92YzpRDDNOah9ztmezN2xIPLm0khtUCB/IECNB/TQLypjPLWGam
 dYxncZ/Lh+Y2dL3n3IT6m+fVtJ1hffxmAMpOAC06+tVIIapRpTt1gwu1gp4GtmSRLuvlBkpnWu
 lZoHWBL4p9WBZXbq1WmoIyCBo3zNf5TVVK9oWq96r1Fjy1cayrpsiwfLFL75lUBAAA=
X-Change-ID: 20250808-t8015-nvme-73a4fcda25dd
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2956; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=Bw7BnPCmbOFL5LNbBdy2vjQjegS/SZRZkp5SZgnFQR0=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoraP8K0/t+Xa1jn6vOgxkYaOQoVIcUzHLULZy0
 slUDQBPlgWJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaK2j/AAKCRABygi3psUI
 JOAcD/4uapZ8pDC/dkHhGkAbW3Q5a7lulD46kXjfXY5qKn6oJXvKjVzdkW6yszmNQMkoM04uoAO
 bMzhG/N34H2LaFgNJZOJYyO2u+dSy7Uw7LjhYhGQmY7ZMIOuXmOY8AUx92hx2pnS1qMBzkJy1zv
 wIPA/UEIxv1hkPQkMfybuqXUSe4TM1W30RCeO021Jxavf4HyEcs1MuI7qv1rvkFncIfHJv6B5+w
 jnxYUaaloqZdUXeLtBly+X+W85VQLPwM0ssZJsyuBfb8dI/36efEkew1anJB0UK4uyyiN4w1qtD
 l0jA2e+HjvouspwRqO0l5mwR73mvmUOe/XARYJq0bjqIlXmTtw13zz7NqK2lp5ZvxG7V2Fxtbsu
 QzZm0pgqyeI6mYRTLRxtw6Yc9EwLart1UXlGcpfViZbpipvj3ek375hW5SLvK/FqoAlJfxQqABL
 DdkghX4nVpfgCaJHztrklJ5lIgmg4rPE5gRvMD8cud8Vc/u7wNxetklHCgAGOWMxXxaHNMBGWk6
 vvqtnUjABr7k7DnDAR2kaXqwBSdOAPlq6mw2wdYXTPZ4FUrP+3U0PvPFfrvB99hQK73Ga5d+b8J
 1YFZe3Gn5cPr6Qw/ohMS/Hgxld/TxJBlEyEk+C4V/G0ep/vHp2DCsUhAc91HRlLTRrp5cb7ufN0
 Cglzjhr4vPJSQZw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Apple A11 SoC comes with an NVMe controller that is similar to the
NVMe controller in M1, but less customized. Notably, it does not
have NVMMU or Linear SQ.

The controller is wired to an older variant of the SART address filter,
and uses an older variant of ASC mailbox, so add support for them too.

This variant of mailbox is also present on Apple T2 SoC.

This series has everything required to support NVMe on Apple A11 SoC.
However, due to RTKit protocol version support limitation, it will
only work when booted with at least iOS 14 iBoot.

Tested on A11 as well as M1 Pro (to make sure nothing broke).

SART and mailbox patches from previous versions has been applied.
Patch 1-2 adds support for the NVMe controller found in Apple A11 SoC
Patch 3-4 adds the required device tree nodes.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v5:
- Add back krzk's r-b for the nvme bindings
- Link to v4: https://lore.kernel.org/r/20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com

Changes in v4:
- Remove the remaining added long line in drivers/nvme/host/apple.c
- Drop already applied SART and mailbox patches (based on top of
  apple-soc/drivers-6.18)
- Link to v3: https://lore.kernel.org/r/20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com

Changes in v3:
- Update comment about enabling NVMMU and Linear submission queues. It is
  required since T6000 and much of the comment has been removed as it was
  stating the T8015 (A11) code path as a possible alternative.
- Make sure all the code changes are within 80 columns
- Simplify apple_nvme_submit_cmd_t8015()
- Remove unnecessary cast of of_device_get_match_data()
- Use direct function calls for command submission
- Use existing enum in apple,sart binding when adding the "apple,t8015-sart"
  compatible.
- Link to v2: https://lore.kernel.org/r/20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com

Changes in v2:
- Remove bogus command_id decrement followed by increment in apple_nvme_handle_cqe()
- Split apple_nvme_submit_cmd() into two functions for t8015 and t8103 since these
  two code paths were not sharing much code.
- Link to v1: https://lore.kernel.org/r/20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com

---
Nick Chan (4):
      dt-bindings: nvme: apple,nvme-ans: Add Apple A11
      nvme: apple: Add Apple A11 support
      arm64: dts: apple: t8015: Fix PCIE power domains dependencies
      arm64: dts: apple: t8015: Add NVMe nodes

 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |  15 +-
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi          |   1 +
 arch/arm64/boot/dts/apple/t8015.dtsi               |  34 ++++
 drivers/nvme/host/apple.c                          | 197 ++++++++++++++-------
 4 files changed, 181 insertions(+), 66 deletions(-)
---
base-commit: 58b28ca2e6697d7c4b2c31d9d6dc1f71cd356553
change-id: 20250808-t8015-nvme-73a4fcda25dd

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>



Return-Path: <linux-kernel+bounces-802533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A4BB45350
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0049458376A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EC626E70C;
	Fri,  5 Sep 2025 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="DBvEtHxq"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DEA2571CD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065034; cv=none; b=bb3FqL8Xumo2oI7fwdxc/2BGzRYztKjArG+ljQ7RiI6MjUkjU+Kenz7RAClbgFKLRT1JlR/CgXwFqqds6ass7IKpE6k8DJwUcAVtuuhC5C5Jln+pl7izryFnKI5VgedsIvvChP+ezEMppj2fboX/qX2nb1fSRTabKdJC4REE5uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065034; c=relaxed/simple;
	bh=RTPsdkCFfnLmyInrG49mTTXU5L76Gna1kznw6oY/wDk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GCLwH5LKSE7d+1+JUoCae50mGy20uZuPDsrb+uPpim41EvtqCBDf6xAkc36GukzGyIHW1wSFQTpar6d/8UrRFNL8yTizDvnFBkrRKkx/hRIwnSTeV9M+bSFXPkWn+1sNnIRijjjsKyKmH4amdKd8XPBVX4yKPWnTKWSIrnd9Wh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=DBvEtHxq; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b043a33b060so309563066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1757065030; x=1757669830; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R9NnNfOCAMTA83aYrtuoiXCktxRcKZ08QSFQdBsWLtc=;
        b=DBvEtHxqe/7SfICMPVVvIdMFJcBWkwHQ6VEC4z/CxgVaeZCJwlaCxiP5tvLZUvyz9W
         WL3nfJ7q8BGZpign1nDv7KjXzqdS4MvwmTaPNw5U7MzjH5MIke7vTs5Xw8YdJuR5iQiZ
         Fx6WGgNwVVCPgbu02PcfnCPk4sBpIjXYiQHti73ZS6ocDNYZTbRaD1lSmx0Y7ALSUAjO
         +kj6IJSfC7FQ0t2WuBVgT+Xr/DmtmCbqkKQjaAUqSJOWpnKyj0T920cOjR01I71EQuZh
         GkUnQOxENO7fP8ytIMUSABsv396S6MHG5TIgUyr9Nm0qzJj2L/SGMf8w6BUMOSi6tDUC
         vttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757065030; x=1757669830;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R9NnNfOCAMTA83aYrtuoiXCktxRcKZ08QSFQdBsWLtc=;
        b=HAjxYovuPh6fPsRKLaVX0PhllVDQWG/00QdxApb2GooWQFmsKAMKm2I1dIcG0CLXGi
         XA8Dpal8n3cn1Js+tPaued7Oi+Dgcq1sgrgbxujEUv19Ro1O/2Za8FXIvBR42/HqFpom
         3uvts+lhvLp1Z8GzHAJo5OJKwQeBzHCXGYMR7FSeRAzTPA599ev6NTmymWYD9wkjcM2t
         Vx6buTj+mgJIuI5oSS3e/+FKB0VCl/G5HKXXhjPYx/3Bs6FgTNWsucdKfMxg+kbm2hmQ
         LGxn1QPGTYP+WKY3B94H64B/5bka74lhew+9pfb18E3HEHNJKm31HFYMk1RRXAa0Qaxm
         AeDg==
X-Forwarded-Encrypted: i=1; AJvYcCUHM02MDETbvgqLDva+BMqcxvaKOuYy6JxPSpDmnXQEeji3GTVJG4hnc57ZGyp58wgnvomzVDTTYPAJd9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrGZFn08hhG7JH15aZsOtlBhyPP5nn348RUIOqAmRHKls1tv35
	laKvLlahY7epjP7kVpfbmftkjEytPR5lsNzsVFXLIOzRPsPFWUONhEllHUrbMoWhDh4=
X-Gm-Gg: ASbGnctR6qDO1sO7IMVyvg1RCrl2bJ97ruiJSXNFpXmV2J/lNmgY0YtAH3reYsqd+/8
	Vs4UZVFifpLSbcFe5Yxf0a8inl1B3W1al8gFFTBA4mFf3NhqIwJQPKSsgfAuO4N9ghKC1yrv/nr
	00GF6eSnhEFk2xR9Mh/2LSTKbLDavfTBoNl/hEWN170IqoItDHs5y4capWwEUSk833YuWs40rr8
	cmkU9p4SdpLeS4GqJPIv2/LPnMx4Xeev8oDgsW93RH+VBOK8ZNeugA/KFME4RtSVHj1u5sIudrD
	ASQWszoG3Ot2inF543oEc0RaJAu3+ptTksQGgavLotC5k82NMTL3/prKoXwvjvhlWsHzCD0PUDI
	thZnxOVz9m3QPiyEh9rxLbnFsPpw3nkzt17v/TVl5dUzVcbo/ptSQnaHA5jgZtfVM/8KZiR6Kzc
	8D/7XdTOJ+HBCfLsicSeSJG9YDletrwKHSKJ8n3Lgt
X-Google-Smtp-Source: AGHT+IFxXBCnigd6h1KizUdRn6cZoOPa+Q7FC3pfXM5C1+LnIdkZX5aLZZHVlU7YnErzTOtvjkV/nw==
X-Received: by 2002:a17:907:3f95:b0:afe:677e:a61d with SMTP id a640c23a62f3a-b01d8a32731mr2039911966b.6.1757065029590;
        Fri, 05 Sep 2025 02:37:09 -0700 (PDT)
Received: from [172.18.170.139] (ip-185-104-138-158.ptr.icomera.net. [185.104.138.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0416842ffasm1361597866b.38.2025.09.05.02.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:37:09 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v4 0/2] Add support for remoteprocs on Milos SoC
Date: Fri, 05 Sep 2025 11:37:03 +0200
Message-Id: <20250905-sm7635-remoteprocs-v4-0-9e24febcb246@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD+vumgC/23QzW7DIAwH8FeJOI/JfJOe9h5TD5CYhUNCBixqV
 fXdR1NNm6Yc/7b8s+wbKZgjFnLqbiTjFktMSwvypSPD5JYPpHFsmXDgCjQHWmajhaIZ51RxzWk
 olMl+dFqCld6SNrhmDPGyo+/nlqdYasrXfcfGHtUfTh1xG6NAjYBRe8UMQ3wLLuZ1Sgu+DmkmD
 3LjfxlzyPDGQHCK2WB90OMRI34ZA/0hIxoz9FJ47I1mFv4z9+fFGT+/2vfq82ziXUHa+nOsp27
 BS6X7kh5Um7h/A0Dd3Yx3AQAA
X-Change-ID: 20250620-sm7635-remoteprocs-149da64084b8
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757065028; l=1311;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=RTPsdkCFfnLmyInrG49mTTXU5L76Gna1kznw6oY/wDk=;
 b=2yh8gNt59VqOsDTFoF5XoFdBlo+xAos8OTUTbeSkPePQUK+SR7VQkDK0odO+wpes3HyfCzQM9
 om3op9hlSZlAS2fzK5kVhnWC787LXOMOojHKVlyX8JOhHuqc/ghOgDp
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the bindings and driver for the ADSP, CDSP, MPSS and WPSS on the
Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v4:
- Rebase on linux-next to fix conflicts
- Link to v3: https://lore.kernel.org/r/20250709-sm7635-remoteprocs-v3-0-c943be976180@fairphone.com

Changes in v3:
- Rebrand SM7635 to Milos as requested: https://lore.kernel.org/linux-arm-msm/aGMI1Zv6D+K+vWZL@hu-bjorande-lv.qualcomm.com/
- Replace additions to two different bindings by one new binding yaml
- Pick up tags
- Link to v2: https://lore.kernel.org/r/20250627-sm7635-remoteprocs-v2-0-0fa518f8bf6d@fairphone.com

Changes in v2:
- Update default firmware names from .mdt to .mbn
- Link to v1: https://lore.kernel.org/r/20250625-sm7635-remoteprocs-v1-0-730d6b5171ee@fairphone.com

---
Luca Weiss (2):
      dt-bindings: remoteproc: qcom,milos-pas: Document remoteprocs
      remoteproc: qcom: pas: Add Milos remoteproc support

 .../bindings/remoteproc/qcom,milos-pas.yaml        | 201 +++++++++++++++++++++
 drivers/remoteproc/qcom_q6v5_pas.c                 |  24 +++
 2 files changed, 225 insertions(+)
---
base-commit: 87a9e300217e33b2388b9c1ffe99ec454eb6e983
change-id: 20250620-sm7635-remoteprocs-149da64084b8

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>



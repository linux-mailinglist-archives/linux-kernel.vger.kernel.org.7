Return-Path: <linux-kernel+bounces-852516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A980EBD930A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8850E421C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE575310654;
	Tue, 14 Oct 2025 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7GSFaR7"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC47310645
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443262; cv=none; b=MobW9VWGyszGuzAw7IwSWYd8CG6w7BeUNS72MuQU4fgrYlMzxAh9oLerg6jtSfaYcy18N39+6dMgHzBRl0y7h+TaUuAV7hqI8XtTz0kqE6zjhdwDFfEVYCT/GKpR8qZtmH5gbefxeFwDsdS29sKrbJnmDtWT2r7UZZeG5LdMLxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443262; c=relaxed/simple;
	bh=uN3j84qVqwGAIGTb9j/2yqr2sDVtx6YN0tEWF9Jvojk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rIlFDzC1cGtoV9T5QhD6igI2SykX85L1ITMEyiJIzSX9MD63GOc+dEOJKdxkH3YNUVCQ7wU+UV1Ythothyv69+N/P2anmDqAMwS9SuRP8R133Xv/bUIm2Y2fd8+jhKn6Hj02RIQjPQee3pu99XlrZtI8es8go0PGqitmsDPIftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7GSFaR7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-279e2554c8fso53070795ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760443260; x=1761048060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HfQvU/Mw0ZJ9zXdFjFYOYgKDAzyRq42k4wpeXF58tTM=;
        b=L7GSFaR7gb2OfJkDA4xvLXhiIiGssUh0nasehM97C95R4TgbacdTuVpoAI4cZe2+6o
         JlgP4LsZK61xHmz+b5AceeZ158wFnrk0TcNQ8JIxk8JEypC+aH3MKE5aoMLQSn5d7DZH
         fLGTvp6e4npV7Xk+ks/GwCnstlMR9WY9lCmUUJEEHx4y6WmuLhYx2Ck3sfaxMTq/E5EJ
         ws4vlvptrvMPnxt+VRp8s2ZUaydYI3Waq0ZrOuFLjEj8jVfuwORqe4T8g4N5U+sJM3uN
         oMhpEnacke0EttimPpYTTj0pxIJJMcabm3U/WPZjlJ0FtvqMNiol5QAyKuKKsxQDjgdU
         lbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760443260; x=1761048060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfQvU/Mw0ZJ9zXdFjFYOYgKDAzyRq42k4wpeXF58tTM=;
        b=dcxHqHmeCK+ZrtpFbsyh4gt2ZBUfhAcKn7BsdqL66yxpVwFz3NBAxDgvkTNHRp0n1I
         9irDrn3faVRqKde6O1oTUF3nxd5MEm1ElfDmhQTi9PovqbCdMaT7UfultKZ+rj04C93c
         eNPIqMyspaMnS+dqYVYz/f8cd/iZq2/2akxURsOK27D2sVlw8BI78nfsv6X8/aEf317k
         WHEFg0RxebYnA+E2eh+famCAeex8qUmJadttLEmnLA6GYAUJW2wMdqILuoZkzrorrivZ
         w/4Js1tu8eLRtuxG+w98PxE++B72Lc9MYBbCHbKaownhRDgmxa+z/qNDNOClac0WT9V0
         v7UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGPGfIipwHNNfyfGGQsI5bMVz6kGms90o7PbvVMr9cfgTXYK5ZzcLYyQHNznghsdCs6GtSv2W0yKYfnFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB7kHjAvQ6X/GoFadgP48u+bfYqmvv19e1/ytlq1o3j05edPqQ
	DtWhhqcLG7Zk2mz9VZk5MYKDl+gQIynqCM6zZIyHbkLm8KtNRlwrHd9vaj9jdw==
X-Gm-Gg: ASbGncud0cktKXdxWNcKfKvihpw953m64fIXn+zuRyaDFjChOXQg2vwdtTtqRWYczNg
	XPZH7YRCRQ/e30wzGOqGeyya9ZAfCKU3R81wWhOetFSFt5yp+RS8xHzITWe2tKYPOMox4JELpi2
	oQZ3WjWAVSgCROo3zIXtF0MCHtilR560dQ6Z7YOf+CW1rMizvpfGwurT/a8alhb7F5rqo+BLsra
	edG8xWzpE1pa7wt6auGPZxBLe20Kg8q5LvAFaQk886fiJFsrenaT/6ro/EFflzvEbc/XT45PImm
	RsEpESW0xXJhpHwLM9SucOiFFIQA8VIiqRwjO7tHdVhb7dMGPINLwgkHTu7u/q8J/Icgyrsj1RW
	NFV4DE4lTxp/1H5qJckYLZH1kPF6wXu//mGXBV3WYZgqzVk7Gh2BMy2okR47+t9fDyD/o+qXHEL
	fqaQ==
X-Google-Smtp-Source: AGHT+IH486qcRovkqj8k+jx5/8Be1KR6VJnxAwKeZA3VTvXsZl4TixfjYjdYR8UW/lEQ03HUbeQrEA==
X-Received: by 2002:a17:902:cecb:b0:268:baa6:94ba with SMTP id d9443c01a7336-290272ff553mr358576505ad.53.1760443258985;
        Tue, 14 Oct 2025 05:00:58 -0700 (PDT)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e39727sm161651525ad.51.2025.10.14.05.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:00:58 -0700 (PDT)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andersson@kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: konradybcio@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tessolveupstream@gmail.com
Subject: [PATCH v3 0/2] arm64: dts: qcom: Add support for QCS615 Talos EVK platform
Date: Tue, 14 Oct 2025 17:30:47 +0530
Message-Id: <20251014120047.1914756-1-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This patch series adds initial device tree and binding support for the
QCS615-based Talos EVK SMARC platform.

The Talos EVK is based on the QCS615 SoC and follows the SMARC
standard, consisting of a SoM and a carrier board. The SoM integrates
the SoC, PMIC, and GPIO interfaces, while the carrier board provides
peripherals such as UART, USB, and CAN for evaluation and development.

---

### Changes in v3:
 - Addressed comments from Dmitry regarding USB1 `dr_mode` and added a DTS comment.
 - No functional change in bindings file.

### Changes in v2:
 - Renamed compatible to "qcom,talos-evk" (suggested by Dmitry/Bjorn)
 - Merged enum entry with existing `qcs615-ride` block (suggested by Krzysztof)
 - Fixed subject and commit message to use imperative mood.

---

### Patch summary:
1. **dt-bindings: arm: qcom: Add Talos EVK SMARC platform**
2. **arm64: dts: qcom: Add support for QCS615 Talos EVK board**

---

Best regards,  
Sudarshan Shetty  
Tessolve  

---

**[PATCH v3 1/2]** — `dt-bindings: arm: qcom: Add Talos EVK SMARC platform`  
**[PATCH v3 2/2]** — `arm64: dts: qcom: Add support for QCS615 Talos EVK board`



Return-Path: <linux-kernel+bounces-764268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643BEB220B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE223B83B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89D72E2647;
	Tue, 12 Aug 2025 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZjqN9U0F"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A482E1C4C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986978; cv=none; b=q8p5Td2GEE/VhuvpN9ZBkxq4m1nuVetogL9AbQErserl6yyf7Lxa0P4MyY8o4pmUPkinAEsKlyXay6f3vveRnpdZDmA4oQE9RZ3+4sS+Ofsh5es/ZUyxem0RMHX2dWO/Qyp0547X8HiJzuQYMXoEq4HFV94kbN9YjQgk7wZlyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986978; c=relaxed/simple;
	bh=TAEw9Vy6BRL3byMXMYu0czaehf27KHedk3DNslAh27g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=keHiWyLf1+YaewGDBKINEQ6vk8ja4WewsNd9eA/k8tnvbYin6q2yiRMhZmHz1Lt2Xby1lvulm947+5U/UeZcAKjJgF1/MabBRSdy8hcibFxXNN29qA4p3IYfXSGCVm84UsaZZsFRyGybdXD8RwOJNXBYBoKMnvtcblA7GvtACYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZjqN9U0F; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74264d1832eso6407927b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754986976; x=1755591776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/xlzRvcOIe5uZJVNBnGirdjO76cMyvVWGXGiatQ/nHs=;
        b=ZjqN9U0FVkKK8U8u5V2SQJLh+vARtGH3tAc2thz1nbjZYuZM0JinHCcU9aSYSwc2y7
         xL13t3YenM4C6e/uMrcUS0qvO/SpxunRd2CTVa3OmLplEoo8+ot888cMdSngqoZHeFS+
         IdV3NSKxth1PcNNcZASu0b20x3q1f+18Y01YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754986976; x=1755591776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xlzRvcOIe5uZJVNBnGirdjO76cMyvVWGXGiatQ/nHs=;
        b=g/ii8H9ARUxVRGxwJuudflvbwQxau7u/4qy3epTqjBYTPCEG3o99zOSnc5h93rhCqg
         oBOVSzx6qIEH+F7rXqGRlw85S5gIVaCH9QTrYrvvJCqEqbS2Wbq49cYF3KmDNpDZMUxA
         pKpGyKNsziWIMn5/ZLHJGsOtXlvq9YjazCl9e2iMRowfCT4VX9pwHyk2sbzbxAAsk/96
         MZq49vpJlWTuKwl5dOhAwqatcpnIKjeHv7coa73V3BGsVOQYZWfde31cphuOYIkZxmu+
         WPrarvIBLwVM1unsPSAqNHm70pSYx5Vi+3Xec5RmUzU9ItqoatssaPNhy+vkgcPpT0bB
         Y/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUXgtXue8ZZvaux0+M0VBtpWZpCEmMF5JFnNMzLYWdUIQ4oUTCF9QDw2p+kJ7TDbAnKOM8sFqf2LpKZMPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWEEo+VV0e4PxzHCJZiJaVQsnpHQYlqcdDi8TVP8zyWFq02GR8
	h8Sm4CVdNW6uzPQzX4HiXhe+FhmlwHkASyAc6CidhT9S73PPUiKWTYVRL/pVN+Fddg==
X-Gm-Gg: ASbGncto8NG/LYIk7A/WzFtBKB/7gRdNa7c6MPX7XyFrYHIK4PBYa/26M/mWKVIrCbn
	k3sRx/2W3JoghbeKoeFmDnBg5DUAAhbk4G3qkOqhjk/lLbuQAmpuNNvdhC+wkj9bJI3hE2bkfZd
	Lezvlc3Nfb0iRoUa5Huek0LRRGl4hpFhuwhlIs0DrXZL03WJfHd/8VkM0TptfmPwuD19/JgqGn0
	ELjuFGhMeSRskqPOPLKQw/aoI11uhtOQEzpcRFKqV/j8OzpVWNZAJY9L3f8wBfBUs7rwdU6Ccu/
	TB5ygSXWd6N8uKsQzjft6gTrrIPvIVfwAes9oh+ibIfigu2XAugcIv5ZYjqt4YMlx+lvWBYImBZ
	n21BSfn8KhamuJkYczQ+nbmPZgWs+B0+cDxe58g+f5ndlC2Ao54g=
X-Google-Smtp-Source: AGHT+IFX7Zal6yVLOBzv98XnS+Txo+CZD9saoFkysJ5NCQWdHrViyTyhkikmljjnQK3y4IYljKOUDg==
X-Received: by 2002:a05:6a20:3ca5:b0:240:1de:8bdb with SMTP id adf61e73a8af0-240551e9484mr24248092637.30.1754986975975;
        Tue, 12 Aug 2025 01:22:55 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:8e8:f5ef:865c:a4fa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf77210aesm22722064b3a.113.2025.08.12.01.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:22:55 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Hubert Mazur <hmazur@google.com>,
	Sean Paul <seanpaul@chromium.org>,
	Fei Shao <fshao@chromium.org>,
	Xin Ji <xji@analogixsemi.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/2] drm_bridge: Add HDCP support
Date: Tue, 12 Aug 2025 16:17:57 +0800
Message-ID: <20250812082135.3351172-1-fshao@chromium.org>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Doug,

This is a refreshed series to add HDCP support to DRM bridge.

This v8 revision is based on [v7] and rebased on top of next-20250731.
Note that v7 includes 3 patches, while v8 has only 2. The rationale for
this change is provided below.

In this series:
- Patch 1 registers the content protection property to the bridge
  connector if a bridge supports HDCP.
- Patch 2 sets the HDCP bit in the ANX7625 bridge driver.

Both Patch 1 and Patch 2 were previously reviewed and acked (sort of,
see [ref]). The Reviewed-by tags are carried over as there are no major
changes in v8, except for the rebase.

The third patch from v7, which was specific to the ite-it6505 driver,
isn't included in this series. Discussion on that patch had stalled, and
it was later reverted in the downstream ChromeOS tree, meaning no
manufactured Chromebook devices in the field currently use it.

As a result, I think we can only focus on the first two patches which
have already undergone review.

Please take a look. Thank you.

[v7]: https://lore.kernel.org/all/20221123100529.3943662-1-hsinyi@chromium.org/
[v6]: https://lore.kernel.org/all/20221117110804.1431024-1-hsinyi@chromium.org/
[v5]: https://lore.kernel.org/all/20221115062835.3785083-1-hsinyi@chromium.org/
[ref]: https://lore.kernel.org/all/CAD=FV=VoF5PyeNWX+4_3sseyRemZVsr5WtQVeg-8mhfgm40w3g@mail.gmail.com/

Regards,
Fei

Changes in v8:
- rebase on top of next-20250731

Fei Shao (2):
  drm_bridge: register content protect property
  drm/bridge: anx7625: register content protect property

 drivers/gpu/drm/bridge/analogix/anx7625.c      | 1 +
 drivers/gpu/drm/display/drm_bridge_connector.c | 9 +++++++++
 include/drm/drm_bridge.h                       | 4 ++++
 3 files changed, 14 insertions(+)

-- 
2.51.0.rc0.205.g4a044479a3-goog



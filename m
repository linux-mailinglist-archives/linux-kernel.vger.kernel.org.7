Return-Path: <linux-kernel+bounces-859255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA5FBED25D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2852A5E492C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968BB220F2C;
	Sat, 18 Oct 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WoqNj1vv"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E889147C9B
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760800678; cv=none; b=iajQqG0SQs2rpO4erOS5YFOuAuCFO5eDJmDXU5vDfdWdDEwFZ6chwwcc5aImVqUv9Ca5tHZryJYbyUIorMNqMLN9MAIkkXxzO+HHcok2Sd5vFPbx6LmwRfPN8aSuV5HiplNT4Eoqj1LFgj/D2LxIebrADqZqmRRjUFeqA9uz3Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760800678; c=relaxed/simple;
	bh=x6/C+W0ev66cJOkQGcDArPIfHmcYnap34xevhw4XIHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AW0jOLp36YHQIEtPdGTS8voatXfB9r/I82q0ETGGoBCq1S2d+kF1vIAiuATp4AtdvvlHXmWUqDZXiT+iQuNibWZDHJhUWiEoB8BUXePrwylGx8HVTD5Blg6Z4ys280efQKdIvVYMrtkezuqkCjqWLxWkXvblxsMCOH5TsQf0Dmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WoqNj1vv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b48d8deafaeso620373566b.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 08:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760800675; x=1761405475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ew9YL3RtLpgvCJCr95BVG1hvaIAcGvrHDBjaFRKpI44=;
        b=WoqNj1vvmuCiUNsEi3WwqOeZt1Q8YtiNYqaVcDuThJ9Z6KYtXZRnU6TvdHhApAotqQ
         uXgo+cBZirgY31QWXOUJdYZh0CTDCimbGfIMGv1FoZ6+zHq5CjT/q/PmdzBij/3ajFDx
         t9LlgNKmSl7wCNtzVvFbMfoJpIRUGfDgGOsDGitm7NtVsMGGZXU309HisZq3S/CMTPxu
         kOLBT3sLaiYzp0y97xlKePFsyZ9Ia4hGnl7RfZ/Pz6nu6038degb+mb08FU25Krg6gIb
         /sTdgngdzJlVochtw2l0QYd+I0Amc1wQj1rcwa5OymBOxXmyLGQF8Ml8VFmPuNk69sG+
         N3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760800675; x=1761405475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ew9YL3RtLpgvCJCr95BVG1hvaIAcGvrHDBjaFRKpI44=;
        b=GM1XISAT3NmzKnA6p6ey6jWAZS8c2vU78WVTCEzQ2I/MxiT28F7+9NdalAjyL5AGju
         dEHcL1W+17bxflXb6w18RM81DxmaebdKwKizw7/zjRbfX5jPBL0tdVb13W+FotXd1+IX
         IxB1fM8bv5pBFNGiukHvOaQvwi+etCaqeAA9YS2NcwwH81JbgWTUZTJEpSxqditwHM8C
         IFGCxdBhkcp7iUnm+09tOu6hbfq6DDS2Y3gVYFx3H3x7v4B7N0iG2sx6lCDQQPuksGfQ
         BQqLiO/wREQAqvesTgzHLqEnANIbPG0H2GGndcVhT5Ql3UTaBIcnh+2+Uq+rG1I5DRyQ
         YUCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp5gMPfXwnam9Oji875KtEPVXpJ0hF11t5JZWHmTCtHOz7DLqweZi1kF67omWKGXkdVgaCWifuFBqQFb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6WINCwmIl7ZFsBj3EWGm1C576xbuQKmdKJvW3NS5lWFfF3gOX
	rmp9OtC4gkVQ6cbqAq6gyolvGmo3UsQLSAVyD6VK6zUxvgtcJhmEw3sB
X-Gm-Gg: ASbGncuuFLt0sf951PtOhZu53qqyFyD0omcJz5FTJxhnzLHM3ndcN08MZb00vMZG9zf
	Ew9puNero7MZ5tY0ltI2wkNSV/YuDhhkAyO7hw2RsmaGMlea9D7ImEc3ZxiwprbjCyzkrBbrkWL
	hxFW9xgfyZwqUVZe+jhTyV+bcKTaHsfoeLMYZ/wEUhFkXlW515RF0SNuVM7EzuMcYf5j/B8Rpz8
	yltFYDhBiKaHZ6ZplMOteWL/0qptgTUMEge4Vv4R9QZ3s22ekFZ0HOhVoU1yr/mmIQ139VCCjq+
	6TZOlJAfzY14ktM2djA4yo5+BS9CBg+wRgMgobJ8C2Gi+8a1iv8cZJDBpC8FJ9WXH2Oo9Lu+EtU
	642CTxFOl6iJJm2IFfWn/n1TNf91NE4bX2QriQdHlMUuSvnV2CL54aqDcEwNn0gkSeAZLe15gtk
	CGeIeS5yLmO7sdLt4RI4glQlEctDqf/5cVblrT4bZymn2g1C9N1l0MpJI/BLrt+sk=
X-Google-Smtp-Source: AGHT+IEw2BzaFoZ9fFDkZJgW0JYRl3LByJCBHqcBzxe0EifgHlnwJtpG8O//r2K45ZSIzB3CABQVQA==
X-Received: by 2002:a17:907:7f21:b0:b04:2ee1:8e2 with SMTP id a640c23a62f3a-b6473b4eb20mr769376766b.36.1760800675263;
        Sat, 18 Oct 2025 08:17:55 -0700 (PDT)
Received: from tycho (p200300c1c7311b00ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c731:1b00:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036846sm259983366b.54.2025.10.18.08.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 08:17:54 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
From: Zahari Doychev <zahari.doychev@linux.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	ast@fiberby.net,
	matttbe@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	zahari.doychev@linux.com
Subject: [PATCH 0/4] tools: ynl: Fix tc filters with actions
Date: Sat, 18 Oct 2025 17:17:33 +0200
Message-ID: <20251018151737.365485-1-zahari.doychev@linux.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch in this series introduces an example tool that
creates a flower filter with two VLAN actions. The subsequent
patches address various issues to ensure the tool operates as
intended.

Zahari Doychev (4):
  ynl: samples: add tc filter add example
  tools: ynl: zero-initialize struct ynl_sock memory
  tools: ynl: call nested attribute free function for indexed arrays
  tools: ynl: add start-index property for indexed arrays

 Documentation/netlink/netlink-raw.yaml | 13 ++++
 Documentation/netlink/specs/tc.yaml    |  7 ++
 tools/net/ynl/Makefile.deps            |  1 +
 tools/net/ynl/lib/ynl.c                |  2 +-
 tools/net/ynl/pyynl/lib/nlspec.py      |  1 +
 tools/net/ynl/pyynl/ynl_gen_c.py       | 18 ++++-
 tools/net/ynl/samples/.gitignore       |  1 +
 tools/net/ynl/samples/tc-filter-add.c  | 92 ++++++++++++++++++++++++++
 8 files changed, 133 insertions(+), 2 deletions(-)
 create mode 100644 tools/net/ynl/samples/tc-filter-add.c

-- 
2.51.0



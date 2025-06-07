Return-Path: <linux-kernel+bounces-676613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A743AAD0E85
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jun 2025 18:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D995F3A43CF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jun 2025 16:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0FC20A5DD;
	Sat,  7 Jun 2025 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I49aWw+F"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53762202C3A
	for <linux-kernel@vger.kernel.org>; Sat,  7 Jun 2025 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749313282; cv=none; b=bGQdWMh85e2C83xXLkWh0lALoN5EJ68X8z9pJXL+IDTECN9OUexdsMjvIc1zhvpnNiQVZRPiKl0beDyXIsyoK2Pdb+R062uTK/eIXm9RUGbU5mdGsPaCzI6u5CPshBXwQsx03HCQw4EhLnHv9SFqFx21B8rFooJHSCI69QwUG9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749313282; c=relaxed/simple;
	bh=B9B8CL00f5okZzseXePU8fDMvR6p/T1oTFKZDQLR6dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VvkKfGCAvL2HCYqAREEknJqIytD+cIqb9yg+BqMTsXOWA2LURNoZZ8cE3kbYlacE9ZOzXcy6C/SIoqUy549Ni+n1DVQX7DNL5nnSXSSzqL5BpOtl8Qujob7qaei29AcO04V7JT5O++c4lIRu+ijs1MSKmz/1U+Jo7T0uTTpooXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I49aWw+F; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so2451174f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jun 2025 09:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749313277; x=1749918077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E4rQelngGKehQALYMiJrfMrYjtUVNtoEIJLttLq/RFs=;
        b=I49aWw+FUyQah5BlokoW8IQjH/fTLcf5bFz5vPmItcvjJMFG0Apsl9tpSdq3i9F6wY
         c6DftSp8HXcZh00pyuk+WqV+KS9p7aUhO4eEFVBR4+sUR16g60kHJ+eROXWwe43KN9j9
         PEow/x6h1f3pl7AxhXH8AcvGdF+GqFqXG2+5iqv8Lhw4t08sCa6gbmqSv0w6vpaOC3ZS
         BtCn8vUVTByKKs/qrGoIPNkWwsmZfH55ws6ugVL18FnjUM8YRCpzx2FMlyYwpJegz3gr
         pcM7bUQ/rxLSAI57F2fBRZhpbhNhFpX12PmRQDx/xtuso533l9P2mlWpBRTXQaUWTg8q
         4Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749313277; x=1749918077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4rQelngGKehQALYMiJrfMrYjtUVNtoEIJLttLq/RFs=;
        b=Yh1I3Iv7A0IBqRm3/gVJODlDt05f8E7TSBpogp1x0v3MvtsRcSQS4seokgiL7bwWcY
         OGZCzhvUBHaOLH8jJIxMIcM7/XMW2aHirZz7cO8Vbd5XV8tOL88eOzx8m3wl564Ih4zk
         g3qVHDAnNf1DlDU4+hDYI8E2Uv/7cbR1uKME9FGsH2P+Kmc3qzmDXLQFnVf8+75U8v5E
         nbBkBBYowgmoFeJ2QblW8FX8ikbgHqp1teuYRklRdsUhjG+N6rKMmtcK9g3DJQODkjVA
         dc40N9Di7HgRmQaX2mUMhouWvy497YSaw+FTSfvRytt/X6aNvcyFFWy8OijEO8NveKkx
         PROg==
X-Forwarded-Encrypted: i=1; AJvYcCXVZfCzzokfLZa+ieuy4ZnylCj437Dit1xgZYGcuQZEkCKLacg+CVx3WPYK0WQbWG4safrGwq5d10pWhmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRnXhZZHQoAoRDLVIhj4ebhmTIlZFh2CxPAvk7EgwGQny89K+k
	2WrxheRC/UNiTXLg0q+7JzQeiLLchl4obRgum5sc58zu6MHyWKQyNNMoW+9gN20qeEs=
X-Gm-Gg: ASbGnct5ZDqi63WQwnAaVB7d9LWAg9Ep4zW+0BaEdNOk2oUcN9MN5yyc/+8S1CcLvm8
	SPo+Gwwv8eKR7gbqFyi8EUQ4Xy4u0/oUW8z5Ij9knpiJjnJFe345D695X2U4VlQVsR+8fvZVcGF
	YGXfqznoJN2eo1czAn2qmZUzo4/4lcL0vpk6u4SUiCKB9nrzq5n10xq8egfqjfqRAncAZO6DVcF
	EFXzgmUXS4DuMpRgAacLEre26RoxwKAJX5As3ocgCvw1QSH9D9/ETRTxZbvteAj6hlZu2DZZQpG
	ICzquzIjw2GpcBj/5szWbqQMZAdrNjUexJyfUfl5AJl8Ukyy6YV1BRWIowt3R7LC6SIB8EV8RJ7
	/rppfVw==
X-Google-Smtp-Source: AGHT+IEMUd1rojejMaAVMOnFhwaC8vasaKBxpW0zK+VFaSmb4+qfkjNz3jQgXGGgXstDEhktYuTK/w==
X-Received: by 2002:a05:6000:2913:b0:3a3:5ae4:6e81 with SMTP id ffacd0b85a97d-3a5319b1941mr5726232f8f.8.1749313276676;
        Sat, 07 Jun 2025 09:21:16 -0700 (PDT)
Received: from zovi.suse.cz (109-81-1-248.rct.o2.cz. [109.81.1.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5324364f1sm5088096f8f.58.2025.06.07.09.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 09:21:16 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] module: Fix memory deallocation on error path in move_module()
Date: Sat,  7 Jun 2025 18:16:26 +0200
Message-ID: <20250607161823.409691-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch is an actual fix. The second patch is a minor related
cleanup.

Petr Pavlu (2):
  module: Fix memory deallocation on error path in move_module()
  module: Avoid unnecessary return value initialization in move_module()

 kernel/module/main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)


base-commit: bdc7f8c5adad50dad2ec762e317f8b212f5782ac
-- 
2.49.0



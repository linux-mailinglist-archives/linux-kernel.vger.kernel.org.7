Return-Path: <linux-kernel+bounces-849095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FFCBCF313
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E731119A1585
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E592820C004;
	Sat, 11 Oct 2025 09:38:29 +0000 (UTC)
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4120D4FC
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760175509; cv=none; b=aZXyN/s98tG6XTbzX97xdxeKTvkkg4imYLev0zfdDJZhFh2tWy/bndvZ3TKZIm08y8QV5pV9+0JdZody14HZjVNXODNvSudiujUpmT/DXdPRmU7BgPDQCszTF9k2WDxmWKfbu85k1Jqm1lpaQv7V4jX6O/pg0OS4MX+CowMEfb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760175509; c=relaxed/simple;
	bh=x/IANdHnirSfy25Eg8bf+YmXVYic0ATSD6NoWbj+IUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EF0vmQNtw269qipb6xX52xUGXF1BFwbfLyLQPjsFLuiqEu8fYaoIJLn5Cu5jAj496DBVe9AuYhDTpOYKoeryp3czVn6xGo4or5FOBNzJ3B9DRbCqQNtLRoyvkn5tMUlahGxrfkZE9gpt+0Fl/D8VLd+AJpwo+JsZ16QwmrEBu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-3383ac4d130so2538830a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 02:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760175503; x=1760780303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YU33It05OlNEOWRANGcDm5LAEtMKVzFh/5VL6Jq8yQ=;
        b=aGdLnjGFDrIoRuQNN1nFYADvPf4jAVQvNKzNPAY459jeVTZE/RMbvEUZtOzNiWQ+XT
         jtgXIcNZZQ2UUenBnR7D+esDvlAO0YM8gL9nuZzdHtRqp+R2lk7ntG+7XwYptMkhpFi3
         +O0aFq/GP/tgRuo0m/C/1Wte1dekkGslaxIWTx8p1MBqS3Tx09WC/bp45an4vk2AGENF
         sUSzNscBqF4uOe6KwQcWOaA330C2WeEFEog5zJLxZH4CaYV8WSZcfN0ViMzVO/Ca/Jkf
         Nq4a6C12atzO+3ntzyL8KHyRGbJ5lVcXEiiUxi0Bd6qixUkq35NnlqT7kdT/zTep55TQ
         jvlg==
X-Forwarded-Encrypted: i=1; AJvYcCU9OOZjKs7cVrDoTuGIuYOLG5RoG3fJh+o27thkTl5dV2DtHKsqS74oINeed4ucPiYGc2mvpfYX5sNGM7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQppQfljuMBghUE6P57H5z/4CqrE25sgm9Xb2PxCGCs8QmjvY
	xy6rNw/g78BWQY7myJSIuY8cha+nmAiEBMXFI4FXUVERFKNb+Tf3Bth84AnTB1gcjr4=
X-Gm-Gg: ASbGncu5mXWKd++aYMbKE0SocTpfY6a9YK+GAS/zu6BHBMXr6mLBo7w8eo1753ougVV
	Le4Cwnt9lbF4cauGGpu9UFInusEDqRS/UT0Msg9FIlQp8N0+5DHgEOYRNAIwH/BwczmJxVxUr5U
	DDvkRJEcVI601ZmdS6Fo/FiKxsfHaE5AOzfn5zhZD3RabiVo0vQ/Bow59IA+zMN+GRXofk+KbYO
	b2AJHAmN6/QJHLcEGOc4JsRu+vYRrpEHK6Lc2ceKvHu3Qx9xJgL6mm71K3tbGx2xsmcUqM4MltW
	cCZNmYjqmomZThNonvMcKQM6Mmmtq4mCfQqEJYYmJN7ies6sLd/Cgob4bepBQmiI+a7usnAB8KR
	NTgvkNgy01vzEIXiLYgzvU/K2Kt+tl43YqlH8am4GXpq8UW9cCGY09uWbCUNduEnH
X-Google-Smtp-Source: AGHT+IGgH1yiJzi1hj2dSBqILgcFzc1H2Am1PfdYaYlo5dUsiGGN3A4V5FZLefX6yVx3VtZ1xQuf7Q==
X-Received: by 2002:a17:90b:3ecb:b0:336:9e78:c4c1 with SMTP id 98e67ed59e1d1-33b5111580emr22759105a91.15.1760175502983;
        Sat, 11 Oct 2025 02:38:22 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b6262df70sm5663168a91.1.2025.10.11.02.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 02:38:22 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH RESEND v3 0/2] PM: hibernate: make compression threads configurable and support dynamic crc arrays
Date: Sat, 11 Oct 2025 17:38:06 +0800
Message-ID: <cover.1757680816.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is v2 of the series to make hibernate compression/decompression
threads configurable and improve scalability.

Changes since v2:
- Reworded commit message to avoid "this patch".
- Introduced helper functions alloc_crc_data() and free_crc_data() to
  avoid code duplication for allocation/freeing in both save and load
  paths(patch1).

Xueqin Luo (2):
  PM: hibernate: dynamically allocate crc->unc_len/unc for configurable
    threads
  PM: hibernate: make compression threads configurable

 kernel/power/swap.c | 82 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 18 deletions(-)

-- 
2.43.0



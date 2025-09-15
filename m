Return-Path: <linux-kernel+bounces-816017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C5AB56E40
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5167177C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62EA2F2E;
	Mon, 15 Sep 2025 02:21:35 +0000 (UTC)
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FAB1E2834
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902895; cv=none; b=VME0fWiUGYo8FRanVMCC+iKs26C0DCzjA6Hj1f8XqYDnFDFQ12SeR7Kx9cjY2ueN6GWfZazEV2VTWdFpUQLmHcA+1t2IkObUb1XTK7uMvW27S4qFMBIgoMWHeGS41gP6TJaxCWeEz19bf0MaYwju2Kx3lUKFOEkGj+uGzeLOYCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902895; c=relaxed/simple;
	bh=x/IANdHnirSfy25Eg8bf+YmXVYic0ATSD6NoWbj+IUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PDlFcy+/+Z+Pbmp2JIbRgmIzWmei1zXjXF37AOnvievoH5fOdWm77cBMSHgaY/SV0p8hYXOpIoHBtBvPE9fhnPX6p51YHarHBMc2Xe5962efL9TCk5OMjqHTT5Z8d/yDYIIQFaTiGTux7js3JEKwIARslw3XGIGTn7EO6SZp+Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-32e372c413aso471137a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 19:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757902893; x=1758507693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YU33It05OlNEOWRANGcDm5LAEtMKVzFh/5VL6Jq8yQ=;
        b=wQZO51F6uYOrTGMUNGHDCFqLs45izjx1sVOSjjRZ2uCD0eDylpMVBSibJeJ/oN3oYx
         YYyV2sdw1q1A70gerxiA1kRgsB6WqYEcwdV81Xc8uygNq0BmD9qX8QSQcCyHFCiaCMv1
         /+OqBfL4bttzYdNy+mPX9mElhQcTXBJs5o8MbKfIFrebRRffqz3BPthon7Xz/ZqqTfJD
         kJElGN9acz9ioELs74gtEvmRPv64Xl1+IoEMINT/qPoi4PpDqrhPFr7lUrdCe5tqHNAK
         kyDZl+okMvmVWlcIFn+jHcWGd1nrfnaiWc8r3hFWpYQ1Tl5MGOwWD8c0iy+N8x6xRG7y
         V8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCX/t+AyjQ3ZNqFqp+VsCbt0hW2RKDlMfmwqzzMAHKxDkMKq+jsVc4SE3xH4HExMfZlHKL9dEitPBQ1xMwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUeTNmTOTLCtjzZuuBzOweWz8WHPeIoRi/Ky8qtKQZ7/eWzBHS
	nXejTMSDfLbexhjdQ79f5Iufm8k2UYzVdhVUxTFF4xLSXHKBdKjNRlc+
X-Gm-Gg: ASbGncsaCEqLCjYw4RUPJvsmPGMvKWZRwum6aAVcS1xL6cXy0nDI8ULRWhSaCLVI3z7
	DF6Ar4ZWVJqnNnVShFFe+hYp9BDe84CpBCtHQKOYbRVzS5EHE8tbXxqLIrbSNxF6A+/xovOjkZB
	Nm9tIWPKvjEWmLWJFeyM4SDFN4kyHpd3mxvC63WpIfixOo13zsAk4z6nBGkevBzCo2f2G03T01e
	qk0WlO9eNpIs/2xb8O2HV0tSSdH1n/RQaGBRKOncnjEgpzPFZppvT2ENhgkLRUkFDdDVFGllmhk
	ODaaKbIVmYA9wuai8Nufut9eQAGQzVwVWTP+wte6wZp3jMXpw5qM3cKtirQNLgAN0bqS3ZQNB+w
	nVVzQhW882FD6VqVvZirJw9ZNrrJAgKHh67P1fopWgx65
X-Google-Smtp-Source: AGHT+IGoDBrZTOWfaO19a8IWNyoVcq8K2UvZOhAA3snYtgNnKlHO6QRhX3OoNjwAJ0wg7EP17ym+LA==
X-Received: by 2002:a17:903:11c3:b0:23f:f96d:7579 with SMTP id d9443c01a7336-25d260795c7mr112469885ad.37.1757902892939;
        Sun, 14 Sep 2025 19:21:32 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([39.144.194.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32e37005a82sm2969607a91.16.2025.09.14.19.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 19:21:32 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v3 0/2] PM: hibernate: make compression threads configurable and support dynamic crc arrays
Date: Mon, 15 Sep 2025 10:21:23 +0800
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



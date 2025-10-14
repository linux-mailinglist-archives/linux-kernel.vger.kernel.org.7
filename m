Return-Path: <linux-kernel+bounces-851967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9311ABD7D51
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3256A421830
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C2E30AACF;
	Tue, 14 Oct 2025 07:14:32 +0000 (UTC)
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC6230AADC
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426071; cv=none; b=SfE2OjwDh5nMNW9o2IVrWfpbQvtzncJ+vK1WndSJQHvOUahqxdohRNV2ythkTqMFkHnbF3/fb+L+b8ksOlp5/XyJcQGP9qjc8OaIdnyGqEdIfoAQCFFTs2QElwoNJcsn2JltpyxaBnhAd7Sjui1VYxby+8k3SV2Mo7KV+PWnT0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426071; c=relaxed/simple;
	bh=sSEQUz4N1vC51QgVF/J8wPV6nb8fqvjIzqiU8S/1ebk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YgdrHOTtmKDtj+qnsaLxiCU1BzpzHzJlgWEbwNNnGfesbWdYB6y0rRuWvhLuE4YdBiUfofsVHiNOgC9gOiXBvpytFsYXCCHw7yfnnT4xLcSt/Iz1+Rk2Iwgt6O4bpAqLWFrhxRnanjaUHZN6h5N4niXekkDHykTWCn3O2DL6l6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so4476668b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760426069; x=1761030869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdAzSUy8ZgocF90WcjHBW2VOon+JtEmmbYQOKZDMVVk=;
        b=lbIqM39yWIp1ADHTyBD9zDcb95poeqDp+nMDCPY493oTSQ+H2a6zGFGR1bOlXhoE6n
         4mRUJI1YwLKSAlqtjYLhwPQKsaN7QnvwgzQc+mn+ezewXwNOL52QvCjyn8Yxqn7L4UIm
         6Ig7pLv3+tcTsVIosudWnuYbt4HtI7MxweWueD3ImBjsg7sJUAmWBKHs1RXDMIDgFHB2
         LyD8mu04uJLl924GNHTvEi0uk2gLKx+2fcnGZAkuDh/nEKJf24Z0s85B8yKHaNdbUEbF
         YZrhK+kylOC8WNjjyedZNHQqi3lre20JXCml4unT6vu2WRrMoM7HiXRlGHTQdNkf1DjU
         0awQ==
X-Forwarded-Encrypted: i=1; AJvYcCWATST36w9cHZt6AVKNLvSa7JplNB7+RXOnE4LznTnf8imMuwigTsnvUXIA38My7vKWL8wehXa14iXxYIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYpWaBOu8KFwjPpqnlCZhfUFVKfxGtZn67Gc5Z3HXoxOh22Zcr
	FZn7SfdnwDoagkcvwVwJvCw8Zk2mlAGHntHhoC3GAKhHv78oKwO0x+P5
X-Gm-Gg: ASbGncsZbFVq6ZCfLB72PqZGRC4YbZm0zvm49joNmgIhQefd7N8Sve5mW/eywshNmHD
	GrBwvdso2s/M8SNVK6M/EakZseHdk8HZO80S6V/68uske1Jw9ggCwAh8ZVx3E6Rnb/WkYzy93f1
	flqhmaGaPOrxUC2jRUFVRiLAYZsoYp3AeW3TrxGOwMi71fFEFNHPNRxqV6t7oQGo0gofl0juTpc
	Abhm2a8GvhtIvhCQyT1Sj3epUjgDne4u8rCxZZDF1qtd/g19es0RgdwRHfDZR9g/n0bStMxARbe
	mQStyhqFh1nQSdA8rSToCXe1WwSnlWK3XAHzKHffLho/gJmqHJ+3t6KYF6fztpvXVvelKnQGmDx
	dDWayHXaCTnOG/n4fUkUy2wZW1PJJY1rOFGTX1KYpcK+bO2HcIar/XeMrAMxoAJxRKO+Z9FUinV
	PA6uwjJwwHOw==
X-Google-Smtp-Source: AGHT+IHBUJxkuPQvjDi0tp4Ni9gQZbWJEugoilSleeEqEKswyN6LQweepoV6GTvNet5iaQOUSLpvcg==
X-Received: by 2002:a17:90b:38cf:b0:32e:d011:ea0f with SMTP id 98e67ed59e1d1-33b5139fcabmr33135818a91.25.1760426069124;
        Tue, 14 Oct 2025 00:14:29 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678de09cb3sm11937092a12.18.2025.10.14.00.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:14:28 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v4 0/2] PM: hibernate: make compression threads configurable and support dynamic crc arrays
Date: Tue, 14 Oct 2025 15:14:16 +0800
Message-ID: <cover.1760423687.git.luoxueqin@kylinos.cn>
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

This is v4 of the series to make hibernate compression/decompression
threads configurable and improve scalability.

Changes since v3:
  * Only patch 2 was updated: When an invalid `cmp_threads` value is provided,
    fall back to the default value (3).

Thanks for your feedback and review!

Xueqin Luo (2):
  PM: hibernate: dynamically allocate crc->unc_len/unc for configurable
    threads
  PM: hibernate: make compression threads configurable

 kernel/power/swap.c | 82 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 18 deletions(-)

-- 
2.43.0



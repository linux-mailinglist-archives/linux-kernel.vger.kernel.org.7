Return-Path: <linux-kernel+bounces-791681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C7FB3BA18
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60F65648A7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B94C2D5A10;
	Fri, 29 Aug 2025 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lohRpZi3"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C0F2D29BF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467885; cv=none; b=guMMndI7D/dLGRWyQJYr38d1A5wNbs0uSNNMssekSNPK5o61EHoe97BJ7Gu25eiNzTjd/bdIZfpmA59+gWiBehIVvxXnN+soZLdQc6b25Ax0Me/m5McRq7mao2vf/MANrU7glCuZFflflQk9yQxtyAgUtES2ft+spq4tYKTD11I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467885; c=relaxed/simple;
	bh=kgtogH9KMkzrZk98RjmNH637rW/ogKm01RrcZ0x0Ed4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O9ZmjEG8Fz9Whq9vy+IKua3Ay2e9NwUt6GlNCIn2IS+YetgwgnlKdRwRLrpGxgwKr03vESRRPQ9AKW3eQzj0D4C/uE4zKHCqbqUjlWLOiITzy9cJ4VwgWSkpQ0exT07tP90HC/Ejmuigh+0ozWIAXL2vBANEUuXKupe+XiV6YxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lohRpZi3; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f42dcbf4aso1957228e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756467882; x=1757072682; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NYFEjS97w6k9aJ9qSpZ2i0GrDJhEZpwYJ/gSKtJjiaY=;
        b=lohRpZi3u5P717idNRWS/jhb/CGjNRXIm1AXPntT7TBUtcDdl6AgU0alHSG5mJ/oAW
         inzMj5NpWb7N3xKrA0pY/THdmV68OyH4c+jfQvjS59gBwqj/QB08qVSIyu+7conIZWWj
         nFHFoxkL5LHOLF+Eqlesil79v2OGISG+sMP1TlYgM2T8MdrpPmaleFtW3iqlaK++JmHR
         4Pv+EIFVP/hKeO9T6rsaY3Bzjn6NcECbRCSq6m5ohHVPbrTZKaQpPSsQVf1jhitDb2c9
         D1shXy1pCQqICnv7Hns979MV2UlZomTSc/OJuk4BfJ6mBSTkfAcxjRmohmiBjIyTiHZF
         1NWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756467882; x=1757072682;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYFEjS97w6k9aJ9qSpZ2i0GrDJhEZpwYJ/gSKtJjiaY=;
        b=r1jEGntJ6Lz86ZrODXSYQ0qNt8az+64ZoohiOBoEWipViEAAiTq2ucZhWSJ6ZDk5CV
         k/OCdh5yppXlr4veg3EwXlzlEx8VplpsATMsBFKJOkJilOQ5zzzN4jOijaRzs5zAYpQc
         iEOnkziQUNjLsHa1pJjcHEL7Sb7vNMm4/ap6W4nsOsmEBWset98smzGW36YvgfgXyXy4
         Y4bOvfukdwUkw3Ceaguy4weD2Zxh2c41MJpowrZOrWSWZZgEuT1F91zMoSfy8G/n9BGU
         SYaR57EAIpqugemcDYhBzCWVWjMAtAwjbxf8xGbuUIwZyQ6JkZggOWMR+O2Ny56Ic8Un
         18+Q==
X-Gm-Message-State: AOJu0YwN+UkLGAUU4+xfznw0wt1r38OyDQFnR1SPj/UUSbgltfzP2RlQ
	iVnzV41Zrt/WD5hF1D7sTtfhUu2kfcAkolQwErUJf7Egsi3aZFnCVb9ToUctg4MFEvE=
X-Gm-Gg: ASbGnctjfxL6Rdnmvz0GHC3MD2Lv4QEw0jMqbFl+SbMRvlLilGhHXBLgSUEWAHkKwzh
	SR+XlTpLOnVdxDkzW0dzwbmdEHq/A/tzd4sZlRA1xFpDvTwSNwxChjq4nwVFedG8CNrmMOASO+S
	N6Ak3aKjZrNKzg4EdLw+3SHw/iVvxfJjuqQlp7NRYlVrdvLW2oNWHrvxTxtRMXxXfyeYzY9APFT
	spQ/qqoYlYJBePdGfKCmah/eMWsSYQGmxynakWwHtya+DlwC2vC7cKczmEvPgGCd2/kBo/8LbJa
	mkclw7XmdSx2M9bMycIUNkUj6A+sFf0od/UgofaJfIGS877B3QFgv3x6Yp+8zWuC48WbdcWf9Y6
	PQmPP41VL3mJPdyckx+Rvl82qf7fRE+9g
X-Google-Smtp-Source: AGHT+IGnEbXMN1WVX/jWRB0dcBZuNXIC1IpWZ0S8MP6TGxiRzhzgPMsPfwiQzUYaRA6WU0ZV/K1KvA==
X-Received: by 2002:a05:6512:31c6:b0:55f:65ef:eb12 with SMTP id 2adb3069b0e04-55f65eff890mr1401957e87.46.1756467881765;
        Fri, 29 Aug 2025 04:44:41 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f67a4c612sm581162e87.146.2025.08.29.04.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:44:41 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/2] mm: task_stack: Stack handling cleanups
Date: Fri, 29 Aug 2025 13:44:39 +0200
Message-Id: <20250829-fork-cleanups-for-dynstack-v1-0-3bbaadce1f00@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKeSsWgC/x3MwQqDMAwA0F+RnBeoAcHtV8YOsU01OKo0UxTx3
 607vss7wCSrGLyqA7KsajqlgvpRgR849YIaioEcNa6lJ8Ypj+i/wmmZ7RaGPdmP/YjkmroLkZi
 EoQRzlqjbP39/zvMCOJzJfGwAAAA=
X-Change-ID: 20250829-fork-cleanups-for-dynstack-2051bdf2a2ea
To: Andrew Morton <akpm@linux-foundation.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

These are some small cleanups for the fork code that was
split off from Pasha:s dynamic stack patch series, they
are generally nice on their own so let's propose them for
merging.

This will go through Andrews tree I suppose.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Pasha Tatashin (2):
      fork: check charging success before zeroing stack
      task_stack.h: Clean-up stack_not_used() implementation

 kernel/exit.c | 23 ++++++++++++++---------
 kernel/fork.c | 10 +++++-----
 2 files changed, 19 insertions(+), 14 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250829-fork-cleanups-for-dynstack-2051bdf2a2ea

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>



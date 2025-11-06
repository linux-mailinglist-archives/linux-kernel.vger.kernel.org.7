Return-Path: <linux-kernel+bounces-887728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BA2C38F67
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 04:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B95484EAE5C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 03:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E84B2BE65F;
	Thu,  6 Nov 2025 03:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a07vZEBP"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F7281724
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 03:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762399631; cv=none; b=SmCTTQa3ZjOVOYDWxo+isAc2vWVcEeO8VFfN3zvgWxiyVoug1u/41fyG9fX9pPjeqqAu0SCsLTt5KhXSMEcsLtqgZ2uClICLZWxRzLrBTUsHD5Ie5a5rjwnvFb+aqY8r6qI69dD6hKpLRGffbrU6OHgZ6GZwJoN3O731/Y4FXL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762399631; c=relaxed/simple;
	bh=Jks7fGYYzGOeBIKB9GVZJA0Ykyx0wMCEDZIJIjlJkuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l3mfrwhZY26G7q5IZz96bsgK8z1G/tk/0Jjo9i3d6JzjbhINz9WfOL/jK2oc+Z7r6m2/t4gDoUiDkcBKX4gzE+mpqnKmppEDhGCWz+cNG7/ciEUy2a+39DL9smv34PdfeaBjMFAAEeSraUqoKNAibxIME8HGsG6ek9JG4P0J+80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a07vZEBP; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ba488b064cbso375944a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 19:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762399629; x=1763004429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cQbG73vR/maKnivzNekMCroa15w6TUmZKDia2GDu6EM=;
        b=a07vZEBPeem8BveR2Fkj5vg5hqpOjlQOPE5NfssrLUGlUmzMKY4eX7bx+XrD50XPhu
         p7C7Li1HNBSfhPwQC0+zqLX7+Rf4cz72/ScfYrfKZ5/taeqTinEeo2UOKa/T2fkZd5Td
         43fODWvgSmKT1FT038O0z6P/0++tbe2nnfh0ZCJn3islr41VDJhnZ83ZXtyuZiDH+Te5
         ZPXNgW5LjI3jwAOI29PIWBuOyCoaDsDUKZdeQPxiP/GBq/rgpqx8Dfk3/Zk/hDD4Th3N
         7d4r04GHcFbPf5uXnEypujJxhES952tP5FRAss2RyRNwXytbK2IDKSfDVNIsdOaI0Npp
         tlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762399629; x=1763004429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQbG73vR/maKnivzNekMCroa15w6TUmZKDia2GDu6EM=;
        b=GmaObgsbUsp5pcqHfzkPEkCmuTuhawfpM9WcjnWbz/mXElFwtw+b5Gjs2GHkfhZSOH
         S30gAv+uTH7o6iAnLIQtcFW3P2a8bjR/1e6kBGfsWEQkybe2OGIOpId1CIhhLzRZev+j
         JiVbrCHd/0zxq6DALCkjY9sV+xhu9dG9i/fqM075Mmm7vMB1hJOPUP13TgBXF9V2bAQE
         izGrr5geVIlEr+hOQ77hoXBfovr7e4ncW4L9EyyS9ss1qfnC0QFoFrHU2PusghM+67MA
         exWqrnIK76uHRWS63IqGde5/fv7GVVIx4F8LCA/Ed/tuY45rvzwRsTqOs6Tan9cadGs0
         aMGA==
X-Forwarded-Encrypted: i=1; AJvYcCX9aY4DN9hIkFUra/hjNOTGEwUWV6l287cyb//UEEwozsK0F76ERcp7aoTUdjotJP+u9NzTMmCHs8BQv8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqvjKZd+IdBDQiY5qs+EQk4Aj3FH/yhnCl1PDfDoDiwvxX08RM
	lZOldPmGqtvhgIgHpExyEHwcul9mzNIRGbhXV/T8J7XjkF7L51L0F5aK
X-Gm-Gg: ASbGncvlMCe8eIp2UZs26gxMh/RXDaSicH0ZbI7ZzlFOXrT0HpaOI+RRanC811S1kiN
	lwb1frIBWpmSzLynW+lDIdq6ca5t/pCKbCqbkyfDL+X+uyvUV6biReVaaVEifC2Y+51G5Fp1qrI
	tBF4gTx2qW7JcX6KCAdOgoskJGuM25L5xjAda2pBRwazVhpl5VinftOwt3H/qmJQd53ryZuJCQ2
	fhSHmPS8FK2HO6AY//6BppRWy7aZdoxvc1eOu6l7l9yphd2ch0Wj3Cuk+f/JDmsPtz8PqZDTcVz
	TX5n+IgOV1UH16ivApXOjVzAbB09GFGadZkZuWD+fvYwPJcz5a3uWXFjYaG8+B4JJ1Lbu23Kzqp
	ZRHX/7k9H6GpwqvebMnB2JlwwVfqlTkKgyuUXPECS9OEO/IrTJ2yho6MzbGIlAcPrR888fT6wHs
	cRRfk9v4M=
X-Google-Smtp-Source: AGHT+IGvCmdntUY0Q27xoUj/FCIY7RWkXkF33HiosN+JCRvCro1pRY+CM6E9xlPE7AKejK4iJ0oWUQ==
X-Received: by 2002:a17:902:cecd:b0:269:91b2:e9d6 with SMTP id d9443c01a7336-2962adb61b9mr89349615ad.46.1762399628640;
        Wed, 05 Nov 2025 19:27:08 -0800 (PST)
Received: from LilGuy ([2409:40c2:1293:c74c:19a:68a4:cef9:246e])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29650c5fdb5sm10538845ad.44.2025.11.05.19.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 19:27:08 -0800 (PST)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org (open list:HUGETLB SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Subject: [RFC] hugetlb: add memory-hotplug notifier to only allocate for online nodes
Date: Thu,  6 Nov 2025 08:56:41 +0000
Message-ID: <20251106085645.13607-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch is a RFC on a proposed change to the hugetlb cgroup subsystem’s
css allocation function.

The existing hugetlb_cgroup_css_alloc() uses for_each_node() to allocate
nodeinfo for all nodes, including those which are not online yet
(or never will be). This can waste considerable memory on large-node systems.
The documentation already lists this as a TODO.

Proposed Change:
    Introduce a memory hotplug notifier that listens for MEM_ONLINE
    events. When a node becomes online, we call the same allocation function
    but insted of for_each_node(),using for_each_online_node(). This means
    memory is only allocated for nodes which are online, thus reducing waste.

Feedback Requested:
    - Where in the codebase (which file or section) is it most appropriate to
      implement and register the memory hotplug notifier for this subsystem?
    - Are there best practices or patterns for handling the notifier lifecycle,
      especially for unregistering during cgroup or subsystem teardown?
    - What are the standard methods or tools to test memory hotplug scenarios
      for cgroups? Are there ways to reliably trigger node online/offline events
      in a development environment?
    - Are there existing test cases or utilities in the kernel tree that would help
      to verify correct behavior of this change?
    - Any suggestions for implementation improvements or cleaner API usage?

Thanks,
Swaraj Gaikwad <swarajgaikwad1925@gmail.com>

Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>


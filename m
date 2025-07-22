Return-Path: <linux-kernel+bounces-740548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4B3B0D593
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE8F1709FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AF22D7805;
	Tue, 22 Jul 2025 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="g63L2QrV"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233223644F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175720; cv=none; b=KLbH2R0gvmXb/z2PPriTthr2lWBdGFnYuE/4fz0WWtpxic3a0Hnn5rw9UqM7Lu7MZatnfiqD4YtzvpJdqhZX6+LJffdbTeUHa964D74GjvwqHpzPgYB9fttYTeBxbcPCdSm6t53ZsrtDfKZI1sR7J8EtAJQwMfbH4NSTFFRH/eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175720; c=relaxed/simple;
	bh=MdWshbce3XUzAERPh+DbFtCFVpzrXq2WR7/dSR+x+10=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=NXcTQjyw7WsZBUyUtFFPvV9bOybjL4U7d7ZalPn4QPaTdWkin2hmST7PIXi1/EyzLwQKu45y6YSN5fzDVGsKo22y8YWNY8+qj2y9WBL4fyk/Q7vNhDkRac6Bb+6ZLHECXzrTQJXIF82u/FlqOU0560+8Onh3IUUCCYelSfNGQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=g63L2QrV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74b56b1d301so3439083b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 02:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753175718; x=1753780518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sDpd/9R1FbFO45b0pyVOCvmilI+82TcVxnKdkYIR8qQ=;
        b=g63L2QrV71D1KPI5bRt4z8FkpiWo8Yatj0L3DcTcX12l48cYpuk4587C9YL+aq6OkD
         z0Eyh8dXoMYBWcttbD4LWfYwvPeUx1XJYOzhhDqneBepWA7zHZGcICMENo2+aLfQgbei
         /SCSahw+Crn0B3/O4A1b3cZn6ksqpvZ1sy/+03asKrMqhy5QZbwcHly/UGLAU4KolOl3
         gEMku751a3gl9lpEevk6mSkd1DlWRO7YZnGAxNZ3SvS39U/PXTU6Z+OwXx1K7xO3U4xj
         uihJtgzlwxElvTPJtPnJg8q/R8XCgWOagr78tiKbhdnzOvi8WqMuROVC0nr3qAqRqDDW
         9XgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753175718; x=1753780518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDpd/9R1FbFO45b0pyVOCvmilI+82TcVxnKdkYIR8qQ=;
        b=Q7jk44tJP+5vrPQOiOn3KBtzgY3wPqW4umXHVlEZB9fPNMNRrRcFcM2WosYavAEIr1
         9rVxmx0kGAtX/IQoGtz3SzvyggnmO6ga53AoizDpCo29cC0Ybv7sV8GxLn8Yp3kyMjV5
         rfp23Mj7dIWAxUZucVLiozxnKX6ef2Er9oXmdOhVttgY5C7LQctuUstK1eM+7bFY15qY
         TMkBs8l3FSl65HMvwHjCmCq97FVQ+2i4JZtjcIkzHAJzA/GT0WWGxP+zwUGGLbZ6DWUk
         h/TuZ7Ag4Mv8kl1ML6zLvV/we+Fg3Eywsst/OuwwVH09HyK6uKc9le4RapVjyZGrjf5N
         L9nA==
X-Forwarded-Encrypted: i=1; AJvYcCWrExbZJ/eibBHtBOJzJGjfZJVT3vCCLMUWcrWxJK3lDZ/sP2RbR8GWow/OWMKW/d9IVYmLP0w7geML6MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxasUCKBiaQ9LelTjSgA+9OiMXE/1HG8ej1+6ywNicMQV9kPYGd
	lYsgP5z2Cw4G4nF8xP71bql+OlyyczDket3kWdsLF2PoctzoGqdBlL8UPy82hPxG78I=
X-Gm-Gg: ASbGncsTboD6+RDL8TFlS3qCzyHgsObW0KPEQr6/aEFfHuqZ+0TGJy6Ewe6jjiZiGIt
	ICs8LG+UCy6mNlv8MXOqn0aT22Gzlrx+LswECkLulDMmabYXe+McBZqFxgay+2JR++pwBYE95u8
	rvQFmY8CrkIs/sk5BYjTzkW6eydkr2etOVsQjis71dqbsHMIc4+Di40ApU7bqbdvYLwAmNQQTQH
	pd+41TdLPX3m+IdkTV7uzd9apmVKCCKpZuQlDAAMwWXh6bqcyBueO85Ya8FoHD29eS26j3ipkZg
	7GFrA+PhrrMLUT91iUSogVRQs+XyW5KqSnYizU4sxvXho8rB+8MEG/TTLNjkc/oOAsyxZ9GzhRn
	oOKE7mES7s0R/W0h5AE1XZdO4O5Bh4rlgWxIBBMS/CqN8Mmim4gJqMXEj
X-Google-Smtp-Source: AGHT+IFdLWXKtYtTpg9kzQmOA7PQCO4tbUE9up/LbFHwS0ttZD0Bn895xLmmJwWm4I3jiNDzOrHtgw==
X-Received: by 2002:a05:6a00:2d19:b0:749:14b5:921f with SMTP id d2e1a72fcca58-75724a8ac06mr32920614b3a.18.1753175717942;
        Tue, 22 Jul 2025 02:15:17 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e2008sm6676900b3a.30.2025.07.22.02.15.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Jul 2025 02:15:17 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	anshuman.khandual@arm.com,
	kas@kernel.org,
	ryan.roberts@arm.com,
	cuiyunhui@bytedance.com,
	samuel.holland@sifive.com,
	namcao@linutronix.de,
	willy@infradead.org,
	abrestic@rivosinc.com,
	yongxuan.wang@sifive.com,
	apopple@nvidia.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] introduce ioremap_wc()
Date: Tue, 22 Jul 2025 17:15:03 +0800
Message-Id: <20250722091504.45974-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compared with IO attributes, NC attributes can improve performance,
specifically in these aspects: Relaxed Order, Gathering, Supports Read
Speculation, Supports Unaligned Access.

When I replied to this patch (https://lore.kernel.org/all/CAEEQ3wmVPrZ6s8msM8RgcyZePGhXM1ikYMc5wW2n8q3Bf90EVw@mail.gmail.com/),
I found the author's email address was invalid. So, based on this patch,
I made slight modifications and resubmitted it.


Yunhui Cui (1):
  riscv: introduce ioremap_wc()

 arch/riscv/include/asm/io.h      | 4 ++++
 arch/riscv/include/asm/pgtable.h | 1 +
 2 files changed, 5 insertions(+)

-- 
2.39.5



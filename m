Return-Path: <linux-kernel+bounces-766838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39142B24BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0797B1962
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBAA2EACE0;
	Wed, 13 Aug 2025 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeoIYhiQ"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BDC21256F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755094949; cv=none; b=kQPKRIADLLxBXH5y/4dFtj3Tp3xjg7wVacFCOP2f8q42x0fHEfXk8F0Rp0xKOE82iXwpEZptlWLNg1ueu38rfmyUVC9xOEaGgPtOSureXtDXR7S8pJ+KxttC1R2zK1O43aToNmSUNk1YVURAi7oL1McByPWN1c4DwNgqSL1ZnsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755094949; c=relaxed/simple;
	bh=I3zhKnPXVCN+rDGHqaiHVdYKoNhXl4LMIQEhK5RIz3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjyWQ3J0ysv27jWro54agT3XtEaAKseZT7XayMd1uHFB2NcmS0+tGYN4UYybSF2h1BrzgthMDjk13wuhCuoxoKROFJeULzU+erIiPnQAETEB5gJXqbvsjamC10YKlB51foioWWLXUQK/xIf3w+LBiCQDteHlicVnrskSwEmzpAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeoIYhiQ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61867b0238bso2045781a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755094946; x=1755699746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3zhKnPXVCN+rDGHqaiHVdYKoNhXl4LMIQEhK5RIz3g=;
        b=GeoIYhiQUSJ679Vhh9x+5/U7yI7P/uP+f56Qf9XFb1Ir6eqESl2XR4hPGbK+aZHSM8
         yW3Hw6hYJ1VqNaqsVYuynufWE7FiMVnfHORD/bZtgxmuTeEQ20BTLn2Z+NJNnkjfABAl
         cBAMCFWzldh+Jb6SgUbMHptOtU1OUetXK4m6tvk/cCDX/BCkWYW0uIkW2Y6L3vEfUJMd
         UPda5pGF8JANLEB5sM0k0qL29PC7Kwc8iQu8E98nzkCNq8rlnhQhKkFq0B5b/sPJaRdv
         ias1BccROXJkf5MA7qgB1Nfa7iFjntvfB4sCvEcZfcj9Km28LvreulmyvL/EL4ghYspS
         HZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755094946; x=1755699746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3zhKnPXVCN+rDGHqaiHVdYKoNhXl4LMIQEhK5RIz3g=;
        b=phkXqnZdmk5bKcw6I3/HOZOzeyrZafmvlJyf1BTlWsNnZCKL/CXrpgUA/TSEwc4mBx
         kssWa/9DW+Q+GlUGj8FHPiNsL/b3CkmLVdPj6/+iu1gTC/oIaE/IM8RA927Gs/VYQyfd
         4nRdnuCcYkfiJM7xepKd+7B90rPEAwZAeAeWErhoFOTcNVjX/2sIV+qTqv/wJVr0aXBU
         dbj2Piw0ujoDEcB+hrErfVcy3i7kAlFa2t5px/9JmlHARZGJ1mDfj3XxWyvZB0Pml3wJ
         AA6zZaNEkfvTz1Abhm2eMjasLT6VTsZKUDsmDBD2xWxADY928/JuUf8NuSlqjyO6SZ1a
         ZboQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI932kLFMUTWnYEWAf0igqQHzSNDPzhC8JBXVKCD1JGyROdIVuAamdFk5bt4wZhpQ68G8Fb8G3CPOX4aE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Xu8cBbQhyxdyZY0/juKYmFgr3cjthTZh1evolZYyLs3d4Q/i
	yw0nx5FwWjqpmTEiWWvGPbAll4M4pWf0kisxkFjzRS+TbrhCqWk7ckcE
X-Gm-Gg: ASbGnctCR2CgudIDixjz4mraBFZgy1wHCXPEAVDUZk/MrGeC2hS7/37YJxxjMvPBjK2
	2BMITb9hcUbmUB+WH/G5RhkST76ITbkFbq/JW1VfapJVfg+uKTQjkSsml2JqyqkU0O7gPdtzaaQ
	A4RFlPhy35JLcsTMaZeTPcq0wSLlJEreCwh9EF2lmq/u/NR60759AnhA9tUwq2TfDh88uuXVU+u
	27akq7fL7qwLon8Omx2zpSy67f2oryCB6CnnjdzMLBRtq39qgKJi/W0mFQK2Se4+ac6/efas0z9
	V+G9FueaksTyQ2oR8y4c4efx3OChvEBu6p5rgYKy/bnmqNhFPkM0YTq8j7lFIRBCiRmoTV/W5Qy
	gscUrkxukBWGrxhk+5X78NJyAIpQ2EQ9aitXyBi6KOOA/itkrvM6hdXy5oQtzdsljj1sKPI0e1a
	3P6p5vnZ9aP3FPrX/ac6xO1A==
X-Google-Smtp-Source: AGHT+IHkXtBylUaHsaOMTkc9f78w42rpUDkiXVnMpYMEZCIbdmmZT1W2KxX3ov9gPJY3ufrbfqKVeA==
X-Received: by 2002:a05:6402:35c5:b0:617:d155:bc9d with SMTP id 4fb4d7f45d1cf-6186bfd2c9bmr2388609a12.21.1755094945947;
        Wed, 13 Aug 2025 07:22:25 -0700 (PDT)
Received: from yuri-laptop.homenet.telecomitalia.it (host-79-13-129-3.retail.telecomitalia.it. [79.13.129.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6186bfee29csm1503811a12.15.2025.08.13.07.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 07:22:15 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: juri.lelli@redhat.com
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	linux-kernel@vger.kernel.org,
	luca.abeni@santannapisa.it,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	yuri.andriaccio@santannapisa.it
Subject: Re: [RFC PATCH v2 00/25]  Hierarchical Constant Bandwidth Server
Date: Wed, 13 Aug 2025 16:22:10 +0200
Message-ID: <20250813142210.45530-1-yurand2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aJyb143HTlGqCBeo@jlelli-thinkpadt14gen4.remote.csb>
References: <aJyb143HTlGqCBeo@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

> Would you mind sharing the baseline sha this set applies to? It looks
> like it doesn't apply cleanly anymore.

The patchset should apply cleanly on top of commit "Merge tag 'sysctl-6.17-rc1'
of git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl", with sha
4b290aae788e06561754b28c6842e4080957d3f7 .

Have a nice day,
Yuri


Return-Path: <linux-kernel+bounces-841218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F29FEBB686C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 13:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7DD0834538F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 11:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E912EB848;
	Fri,  3 Oct 2025 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV9482hx"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7FB280A56
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759490334; cv=none; b=ce0oKIZWINb19KNa5K1o6IwFbeRg6cCWk2qzusiUFJrFLPnselYH/pV7WuXqRcE3WgQh+NTVl9+6NvJTL7g09OgKIjJ2EVQSpz6rF8D/+8CSxh3OJJrioX2gn78+a4orvDS22D53m6KTMzc6G/S52HYgkuGFsL+Hpc7ybZtmNJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759490334; c=relaxed/simple;
	bh=mijTNK5Yw+LI/oEznaqwyWIA5pV+z1Y8+nK9/FYHTK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lpttuv0TF0VUTftEBU0dDwLpsSsRB4E1Duqxw/OwiNxrhfSnLEntCeSJyzbkoH+Cdx+CLLzQ0HepqsusyM7wrqqnYcIaD0KjB/+bHRNz3mkKuFF80UD6+SFjQNNTgGyUc61jTuZmwAHR4wJK4dM6XqKDtWYQE5yjLu4cfYqoTiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JV9482hx; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7810289cd4bso2165856b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 04:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759490333; x=1760095133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SNBkS+Hm39wTU6+E0QoP///fT8wlA6nV1YT5ebANpjQ=;
        b=JV9482hxTPVi3ZlvQcpdWsqWweY2cex0hJ63l5rM8o2QdRQiQPEEAk/FeK+r3lh+0j
         6iOrTrOYNwO2EbWMRmPKDz3Y7MJLM+vu5A+vgBtF0Tb7w2uq+KtGAgZYyYnYqpYl8wQG
         0ezuG/sUt0h/p94OtmivDoMBfG9M3vcC5fYt015ffIWXKyQbBfRhxhh2ZZsJXzGFJvra
         44mnU8Py/iU1ehuHOk5EFpllnhrs/Ngsg4XVMiTBpb0BjljZ1g4nCKTTtY7pEUrRz1iG
         1qQQp93aAQvSMFfULIcq9xn6UrbGM0TTZsAakyrx54Br+S3kBiGN3gY5VYrETpNHxPHv
         0ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759490333; x=1760095133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNBkS+Hm39wTU6+E0QoP///fT8wlA6nV1YT5ebANpjQ=;
        b=NiZShxw7N7Lfo3L+MGoxRqj5Div27yrDcz1THp2CiFC0UwRMz4x0AFMotOy8R9l2Hh
         U8wDrnBoxTOuIRXQDXKWYneaBV/gaahVGzC3u1nxLsL9dcJOu/BkTT8lBtiLeUPHDW4b
         DVVo+HtORY2AKVgDly2vWnIWzi+8hOHaOmH3I58Xv2iiqg1r3VwNqvWloRNFysYk1AWL
         iruStKwheu+p16z75KoY1wmbtv71bM1dylkkOWgw514gO/USkOuFQMq9tmBqqbUmtnRB
         GvAJF1qMUeWZNO3r7tirHsetL8EJhnrL1Wu+aw31Up74cWhrLnM6XluD0Vk+sQ1S0DYt
         Wzyw==
X-Forwarded-Encrypted: i=1; AJvYcCVgGdl8jZ2RRq3FkSKS0xhBlAtlCEV7yMmH0z8BEARs19Ww9QFzgOGt2wYkJ/e/qsTXhNBDpN/sRWGtmpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjwsioleftcGtyso+Suw4YRSzVa3eZdiNNB4mc1Umx2qhlZ6h2
	z+H0SvAGDKEJx70Jn/Hp87RKFxeblFiGfRBwbAtAUK3TDwk+FZjgDusA
X-Gm-Gg: ASbGncsDh87l4mCJCOEey4AH1S2vnbdQMst1XtjPto+BeGezur63VN3CsIuq/5W4Px5
	G1PJIrSyHuRfot7CpXIB0gHQlD+Kk/ii1l9yVPqEXbPBtQ4zKvrZLwavDx/6A6cuy/eas55HrDR
	vylt0Gd2Wcop1MqNoPr5bc54Htk1q1pfbdWy3pMyMFvKSFLRInBj1pM3Wj4DTbZTpEySc/tQj7u
	p6zY0zZXk2GLGmfOhh9x3fFv9FLdwvQmOyZwCFjmOkvn8T+cxbcpcv/90LdHN3g2+GcmXG7Vue2
	WxnTDri9Do124U09lswawvvkcBteGWBAejjchfOER/BPayxEW/tAtoxgoWz138QwX/B+NchLptW
	UpZrVmVDup25RKrTaB79elN7ICZdOIWjzcTbBTqsxXbIXupAlVBsCs48hi4HL7Wy93sxPZhyWsq
	MGSNzPcp/k2ArDcp7dA/GNSfMCH6TpWrP5dFhV
X-Google-Smtp-Source: AGHT+IGlEts1uXX8hfnzNImW+xFZigVYA6diCbhcx8vs+L489uXPgFFo8L2wxrFd1Q8SGxzM/7FJ0w==
X-Received: by 2002:a05:6a21:6d86:b0:2f9:48ac:c8ed with SMTP id adf61e73a8af0-32b61dfb944mr3753683637.1.1759490332568;
        Fri, 03 Oct 2025 04:18:52 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:38c3:a5e9:d69a:7a4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b020537e0sm4696767b3a.56.2025.10.03.04.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 04:18:51 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: broonie@kernel.org
Cc: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com,
	Aishwarya.TCV@arm.com
Subject: Re: [PATCH v2] hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list
Date: Fri,  3 Oct 2025 16:48:44 +0530
Message-ID: <20251003111844.2784806-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi Mark,

Thank you for the report and bisection. I see the hugetlbfs-madvise 
test is failing with unexpected free huge pages count.

I'm investigating why the VMAs skipped in my patch aren't getting 
their pages freed properly. I'll analyze the test code and work on 
a fix.

I'll follow up once I understand the root cause.

Deepanshu


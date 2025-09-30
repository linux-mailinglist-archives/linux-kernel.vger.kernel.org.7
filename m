Return-Path: <linux-kernel+bounces-837589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 394EDBACADC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78753BF9FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14E52F656B;
	Tue, 30 Sep 2025 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0oI2xL0"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C502F533A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231589; cv=none; b=EKUJ1InF3heAE3SvECbxITB30mSUmFpKUw6qV3C7xZISznD1q51KZ3D734jLO0ryarz2lxtf6YdQH6e8bGI8rLaOlJeXLNMABh4woYtb6ZKavhdbGBLMzmJ07MF4q8OyZER8FrDU1JkKl6dkvOwlvpRr20mZYgK7V4URjO7J/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231589; c=relaxed/simple;
	bh=88UnKCpF6MxQ1cu6WVwEGFyyE1Je9LgE7sckZgm0yd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z1Fb/Qed1isUnlvBtMdBJcWw1kHsqQZBFlMZevTM3Py8gB9Lu3phjafI6wpKa0CQmB7oQsSinWnWmOWt0vAGDLNOnR9s36PVDyXEzrGkgiD0kv1jIpWFnehlYe5gZsCqzDnyOjvBSFp2cchLUO1zbP0IMjy8BpUVV5r2g8vijrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0oI2xL0; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3305c08d9f6so4409663a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759231587; x=1759836387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P9IwW8fBNe/WatIswEV5cRIvCyIrYoaIZmzkXfi+U+M=;
        b=F0oI2xL0HkN0oFd8A+AdajM+KDCrDoWFmU35Ns7KLLcRuMOwIdjYVnoSMVGWoZmrkU
         jrLyvDVpKNzbwkGSeSDKd7wOWpRxwzY5srk3ItsejvCO3zVZrza0W5+ZE59/9REkNVj9
         E96Bg319LqDmTekbhWGAk89hW76CXE2t6XANQak44khT/XbFhLjmAeCsuw0kZFYwLC3y
         lFuieXQHKR8JnElKIbo+KBLFkqOecm2olETwcAbSNkmwWTDhICHwR8T35ZXqJY5xb6jx
         sHzRDgrRHqCduwhJ4azet2WgVA8iohO4cBtCQAAWxwmVFKIL8gDZZcQ495DccpH6JSBa
         fJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759231587; x=1759836387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9IwW8fBNe/WatIswEV5cRIvCyIrYoaIZmzkXfi+U+M=;
        b=gA+35kN49xv5aWdWKQxoIwTw+olAulAzAjLA8BBqEunD9+unOTSPb4yqOMpm7TIT6z
         RpBFCbbgBs97jXDkr4L+cUCKRxHTshO9D443wnQkAuwR+QpnQKu1YQQYF2Eg+4iHk9N6
         bcdW0fN8jIAokrqltwT/zRAwCULG6g3u+0JBDVY2vlICKanRy7RNkTFY5rEAi5tnAaZ3
         gw1G7lOorQcImcVkV8ZTfD1VManFd3X7npDbc27r/Mg35MuQ8TBiC3j/iKVu/n9sOKlm
         B0kNWEfXb2eOEWAgUfLg/08rWTfCoqFjYVhL32Ia8kTwuqHm45AvgBcuAS2c7CgOyl/o
         92UA==
X-Forwarded-Encrypted: i=1; AJvYcCUUYW5SV9LGdT7EGnLgHSg0/18S55DUd9rcPWJKNl6juu8G77JLe/bHlEMx4Fg9NVJfJ9oXa0BduD0fz2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu2u2aWCtVJOeiKXxCg8IQnfEhghVnXBYXoHIQBTcslwQsjmLb
	d8izOKVa8/YSbaCb6ORe0Sg9Grw2SWpuGCH8TQZAdCwC5zA4cOo2wTmY407A6o6/Fqs=
X-Gm-Gg: ASbGnctO7MEinjOr38WpKpQWlY63Eii1jLaIFymnLNHMJPhRAD5BZijifoJ+4B1H9EI
	Or02G0XAF3TvBw5RRfn3Up3FWJDstgIwq9dae7u7wLgVeuezBZUqEkGTurO/fovMfT/IcMoy/TJ
	Wl0qufbAhmBFqidICOSRoGtEc7fWXjM+EHGAqJI+kORtMjqRhOm5QI4hXrHbWqwsLCBRJNFLagN
	+8IMqwPcMyB/6crkgv1ALe1hYCOoU8//yWQal1inRIBIIxNbU5UcC9EgW3nbaj79gO5yyuu6GoT
	4ec5FPF0CJntqt1WaChcAXror43JPlMsHqWh059/rmWV5kuNSiKBCMfLFZur1gIlRRFexRLjxzB
	CHQKuqi0UZGrTBJNcA5Xrmk80ZSeZDXBrtiZ4kwqu9WDKqfTKMQ1UZ8zMFWXTekLBqXqS4+1vLr
	FNQjafpyQOH8P3gKb2pJYnxj4C3OQ=
X-Google-Smtp-Source: AGHT+IEejJp7M8pvyHkDoEM8HxGwNSyE1S0ljFnpN2sGTpbOtXw3LhX7D7Pd5NxiL/nh4tbvz5Y2kQ==
X-Received: by 2002:a17:90b:1e02:b0:330:c522:6138 with SMTP id 98e67ed59e1d1-3383ab5884bmr4652896a91.8.1759231586947;
        Tue, 30 Sep 2025 04:26:26 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:91c7:6bc1:acf5:6b87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c52eee5fsm13801582a12.0.2025.09.30.04.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 04:26:26 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
Date: Tue, 30 Sep 2025 16:56:20 +0530
Message-ID: <20250930112620.315028-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Zhang Yi,

Thank you for the clarification about checking flags directly versus 
ext4_has_inline_data() return value. You're absolutely right - since 
I'm checking the flags themselves which don't change after being set 
from disk, the check can and should be placed right after 
ext4_set_inode_flags().

I've sent v4 with the check moved to the earlier location as you 
suggested. This placement is indeed more logical - detecting invalid 
flag combinations immediately after reading them from disk.

The patch has been tested by syzbot and confirms it fixes the issue.

Thank you for your patience and thorough review that helped identify 
the proper fix for this issue.

Best regards,
Deepanshu


Return-Path: <linux-kernel+bounces-829828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3189BB97FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3882E6D21
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D1D1F3B85;
	Wed, 24 Sep 2025 01:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhsrL4Jz"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A314E14B953
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676910; cv=none; b=eolRHgvmYX381XhV8/+QbrRbWwsJvtNj9n5jxhLnb5tLaTGDP2YXD5P0wwhL+rTxTMKTmwNA+GpdV9OG07XrKKsbaUabcKgf9habF9KKPLMj2O/f8Wd5ZT2yeolG5+1eXBNmW2Eg8KUWLNeEBgvrObo/pNdept4kDU9czzQOl2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676910; c=relaxed/simple;
	bh=bjvA8fGI7JwRYl6g5GmNHPGgmo0MORD6QycaS7qPMk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3VoSbU3PFSGOozDz7BM1EhOedwH+grhg2hKq6qoZjeaL+SYf+QpuldwntPp4OAjgdwU171eIfXYRBvblI8F+4Az/BjLSVq3FAuLRLG5BqfyFpQ9q8Qiqo/MR13dHxlMRZWqZhkVeUgXF8Tv0Hrh+kHmJeQCSE6C6EISR3eKoK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhsrL4Jz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-244580523a0so72881055ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 18:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758676908; x=1759281708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sO5HRgNy0x9UUMS9KISqgLEyBw2+6jY6BB1GoUPd7WU=;
        b=bhsrL4JzwU1Q9Orj8zgk1312iA2VTb4/95dKWJfnb+IB23X73r3eT+R9Rnv58Kk2Sb
         O87pi6SVZ7pyUEmIum2xd7XEUmnRt2W3zTiMNBx0NQAfuHmGiHBfkOJLq61wkSWXwg+8
         2O3nqoLePr99bR8TRM982ydY/Tt08HoRp7Ef9xjvTc80K9VZw7zSj8KEUc7SpFMkqH8K
         9aU9wjxmb/XHadHb7Kt6b0DKJOe0ygT2iGIzklsIlPfF6l1GY4AqCnC2D5Nri99b9PXi
         d8hIz0DhzbfGwX1QnWg2645JtWvo5C2cue0W56FGc17IO12alKM3y1IhpSHI4c94gIIN
         9M1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758676908; x=1759281708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sO5HRgNy0x9UUMS9KISqgLEyBw2+6jY6BB1GoUPd7WU=;
        b=rykt38QUZOTI7oCJZFsqZdNtMCuz0+V/oGguUjLHrQpqpCwwKoDLbXJtVrc1E6z5oW
         jJJ0le/b5xOWqTSnfXowRho1Er3hqCVBPBk1Ju0Oev9GRX8dadFloPVsc/2wQdO96s2P
         P2LfQsacvzGQd8wPPN9SqFXAJ6OoPco2SZ5rHGs6SeNe5XQARJ6j9rujGU5qPHoLMqGt
         UH8HmolPl6eYp3S20FRm9kd2hgoeYEBpO8n3HYJpe+Xsdddy4X07A+4v+BZwKMOjP0sr
         bmlEsYeaQbkxsBYiD6uQxRILIHDfrCsUKoAakVQZgLyC2zStbsUX5mBI2p3ZFzF7yzN2
         2o/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVW1qFrDqszQIxwVjJ/7yfwNC6zwIdwmPFrI1xFj3RjGpu+mypmrCNpw7G0jPs5tuitgSRcTlyKBretvbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy77uYNUinZhp/H2GeSZYRP5OoO+AWRKBvfmmDLFNS7siLrI2a8
	PUBoZ5w2mppvhnTPujSS8jV6CoQdkJAEYNWqnOLZlVGBBoNNRihimoDW
X-Gm-Gg: ASbGncvO7ku5fHG5TY7IlMzM2ZA6XZY7AzX1Wec4yBD2AZ64ZySMpR1n8mcso/3IeGC
	gNdnLScdGvwCDVgDExvNIgFpo4DT3awCbtrrpWPE/q0RP+KTGTctN+IRV1xC93+sqrz9A1qcq6D
	KbDWWlLAIzNGRjYE/Npuq4e9mAoVpilhuoVORS0971sxnsf7CibY2VLicNiTSbe5iEOaaIDyMtO
	PjrG/5aS+NwoNBcDsAhFybGmA9k10uTaWb7yZaI0YeLOOl1VMGfJbWyvy6S+O9/LvATwc9PE28J
	59RdD8Ry+JcAYWwqdvsXHI5xvx/+gdYLPM9ZILKUR6RUAyBMLs1efJRVD3nur7GMXXPCYLu2YAr
	dbWTkz0g7kdwZaAVCkeW3KDmLWMTZU6bpP/c0c+OqU4G2OOF9AUrYlhzHZXYFBHFV3ug1fBmN3m
	rJnA==
X-Google-Smtp-Source: AGHT+IGnZhuY/0g8lnXz+Z/YLAJosROMUYlrw7/UXNLQAe97Gu6XpKqxgllMke/LklTZYR9SHyju6Q==
X-Received: by 2002:a17:903:288:b0:24c:784c:4a90 with SMTP id d9443c01a7336-27cc0fa8735mr62779735ad.1.1758676907949;
        Tue, 23 Sep 2025 18:21:47 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:a860:817b:dcc:3e4a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016da85sm172933315ad.50.2025.09.23.18.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 18:21:47 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: adilger.kernel@dilger.ca
Cc: tytso@mit.edu,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: validate ea_ino and size in check_xattrs
Date: Wed, 24 Sep 2025 06:51:42 +0530
Message-ID: <20250924012142.1096152-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the feedback on the e2fsck coordination.

You raise a valid point about the complete repair workflow. I'm happy to work on a corresponding e2fsck patch if that would be helpful, though I'd appreciate guidance on the preferred approach:

1. Should I proceed with the kernel patch first and then work on e2fsck, or would you prefer coordinated patches?

2. For the e2fsck side, would the appropriate fix be to:
   - Clear e_value_inum when e_value_size is zero, or
   - Remove the entire corrupted xattr entry?

I'm new to e2fsprogs development but willing to learn the codebase if you think it's valuable to have matching fixes. Alternatively, if there are others typically handling the e2fsck side of ext4 corruption fixes, I'm happy to focus on the kernel patch and coordinate with them.

Thanks for considering the broader user experience - I hadn't fully thought through the repair workflow.

Deepanshu Kartikey


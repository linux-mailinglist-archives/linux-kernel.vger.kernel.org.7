Return-Path: <linux-kernel+bounces-776924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8885B2D315
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BFE1BC40AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F121243374;
	Wed, 20 Aug 2025 04:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCHeH+W/"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D658258EE9;
	Wed, 20 Aug 2025 04:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755664481; cv=none; b=jkKH3Y95Q/XIEzzihAcE3OZx1c6zl1UdOTx2htCvDqcJab9SIw7pMIAYrLNYwOMtx0kVEV7zB04r4b64C1De5ce1zZtO6ymZsTWNzBEBkuOiSLJaOfI9tOnqlENd1ivsgNj5+dOWljTQylw1DpHxFAhbrykXymrINBdAydFia+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755664481; c=relaxed/simple;
	bh=1YeFmIIpqckeiU5NMS7nnNpFzX3lE0cdhFLXDBSyjmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kS6MicIWdFNo6oxS2v4ZNxcbQAY2yVh9KO0S39ARiTtY5EvuJMtJuuzVuLnu8AQZ79G7CdVNch1kpqBgp9pV9JYSIdS2IjfamK4MbJb0hT5bJBJrFOZ9ekOlnd0rR5adUG1Kq1PGp2Bhtz6d/ScBJF5vJZ/QxVyqoXB3LIhL4mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCHeH+W/; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2ea6ccb7so4528823b3a.2;
        Tue, 19 Aug 2025 21:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755664480; x=1756269280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TTJAhFagm4xZdBY0qvCgrvMP8buEhoobwDciNY3Wj6w=;
        b=MCHeH+W/Pr2bp7fyXCfI5t3eGrcy1M6ABKrxKlN6DI0ZQzOVDJuAEYZFB2S2+EnmUo
         wiujbWpLDsOw9BLDDIghqYN6T5AAUPce3HLAPFPdRcRPBBLthHthTMOeu4xjfhQ4LCd9
         VJIc37yop5h8VNywAWjSpAcCJEm79fUUn5OuPHxGdo65Ae+kAyTbkbMuiNShbtTcMOkV
         3dxRBUW3o60SyZ9QG0iTae7oEsabIfi10bQlDl54x02RrTU2ejL5E8O0+z8P6CdGlRwo
         Fnx0SsM4xdm1WDEZ12N9LdIpnXLItcPlSVK6e5DHTmdTdTwDIeE6TB3yj5SyimTvPLoH
         fXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755664480; x=1756269280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTJAhFagm4xZdBY0qvCgrvMP8buEhoobwDciNY3Wj6w=;
        b=fjz0adyw/Co2jCbaYI2APwt9/zKfpNILi0Q/PfHBEe6+xpri0uXRuytPIOu7sEmerL
         7PXjOSV9LHVw7b4+CRvypqtCoQgvMNdZwv6ZrBiMzRIivF5cMVXkO1U6AMg+gwLjdvRX
         ZGzLHud8cy/X9S1mPk4+mQeFS8+7rvAfPMM+DgosVV1+UgtRcBjhNGFZumQVPN+esx8/
         imBH9OysVHElruCGrNcPpIZEKQMfaAOk2OhiJhNko4AxvR+BtMGOqS06FTdFx582gWoP
         299WuzO3qHZzndXf8Tg4rSiJrju4s1kjLigPgmoPw7Q9zoiyUjm6Qkk9EG1zx04W4yWJ
         XAEw==
X-Forwarded-Encrypted: i=1; AJvYcCUh0un9fUnw9K2NjO4vb+fsz8RK9ACA+croKrRAZSuhQ95aihRa9VAJxdiG9jonPkpddGHr9I4cMP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrQgLK0dpHinKvCKpZ54wkG0jqMKFdKfAdX9MzlOAMAm8+6LK9
	FsW/eURSo2JzgqfZI9DMjx9urwipbI+nPJ6KC39wNrS2LnijPd8cBzxw
X-Gm-Gg: ASbGncuJjq8SzAmaykVnEJb0E0tlYv+NvkZUv4rrGTQwlG1DDVzQ+kLMziIvjT+eUmA
	nSv6rG1CArUDr0N6RrI90L5uDQjM9TffynKEKglWTnvmMs/TKiUJgyIl8gPJUK9xDkuzZjUPt7f
	iG3ZRkATJxyLb4lxlSNuB1hNMJRTbYlnBgMUdZgPDkyTA5OyUwlFfcZ9Z02T3LTa1fNEPvqI72y
	yV6OshqJiBM+cFAfrCz0KXzYSMJx9H+tHx0BEYJ1ODCdx7Y6PzuG0eqXRmro3u0dzpDYHxXsM1i
	qafQxWJEGs0dE2Wx5dj5DuYl7f1cpAQTChJ0yyvuHhxctZTC8tfdAcSYO2OXjT6gxxeO3Mh7Uh2
	ZJc3Lmhw1i+njVQa0eMJiuw==
X-Google-Smtp-Source: AGHT+IGuGwomy2t/lnkvzOkQfUGyUDRAElqgYIuRb+Qkfx8/mw8d45XT8gZ/QDWISpdBNTf8K08SbQ==
X-Received: by 2002:a05:6a20:9147:b0:240:1dca:d13d with SMTP id adf61e73a8af0-2431b9f7ab0mr2747454637.43.1755664479710;
        Tue, 19 Aug 2025 21:34:39 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d107ecfsm4026901b3a.26.2025.08.19.21.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 21:34:38 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 00D4742B408B; Wed, 20 Aug 2025 11:34:34 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux F2FS <linux-f2fs-devel@lists.sourceforge.net>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Daeho Jeong <daehojeong@google.com>,
	Yuanye Ma <yuanye.ma20@gmail.com>,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 0/6] f2fs: documentation formatting cleanup and improvements
Date: Wed, 20 Aug 2025 11:34:26 +0700
Message-ID: <20250820043432.22509-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=784; i=bagasdotme@gmail.com; h=from:subject; bh=1YeFmIIpqckeiU5NMS7nnNpFzX3lE0cdhFLXDBSyjmo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlL/Td8LdsnMq374B/Zfad9PzpJGv97u1PPqfylYFZW+ YLm+HDHjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEyk1Jfhr+gEa7sPZz8YKcqf fHXyx4R5OfvWLnxu9aZQ40fv+dKVVpGMDPM1FvXXajSUNiRFHDdTU3tY3XZzxreM/dv6Pjho5/Y /ZgUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here are documentation formatting cleanup for f2fs. This also includes
docs retitle at the end of series ([6/6]) as a bonus.

This series is based on docs-next tree.

Enjoy!

Bagas Sanjaya (6):
  Documentation: f2fs: Separate errors mode subtable
  Documentation: f2fs: Format compression level subtable
  Documentation: f2fs: Span write hint table section rows
  Documentation: f2fs: Wrap snippets in literal code blocks
  Documentation: f2fs: Indent compression_mode option list
  Documentation: f2fs: Reword title

 Documentation/filesystems/f2fs.rst | 88 +++++++++++++++++-------------
 1 file changed, 50 insertions(+), 38 deletions(-)


base-commit: 37c52167b007d9d0bb8c5ed53dd6efc4969a1356
-- 
An old man doll... just what I always wanted! - Clara



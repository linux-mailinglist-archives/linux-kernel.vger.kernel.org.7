Return-Path: <linux-kernel+bounces-840546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C58CFBB4AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6341119E3478
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDBC26E153;
	Thu,  2 Oct 2025 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNq6weki"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C21523E25B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425825; cv=none; b=UJyiWMgHsG67KdYWO4yM7JZFUfwKGD1kXJRCcOAnlsv0e66p80sNtGRsQ1z39tZUO6NHoXgGpRvU/zoXgsOZHn6l8xX/GUQVXwozTjk2HEOA/slv/B12kPLJ4ggm4ZaOWnzqr6lIMSz3Y9VO7Mr1Bqj6+0FBUiBboKS7U1X4yg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425825; c=relaxed/simple;
	bh=x77oe2biKEfFvbXW7uH+81l8m9eVb5yiLxZ4AFDD4Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FG9J2luRG7f6d5LdlDNpJ77JxqrBKJyttD45scWnrRPB41my4s8j5N9ALSK1zy4tmW38lSQDqM4klrvxACvocFd1AHC3gvVtaCOpGWx3o2MC6RNF8OsjTlO7YnTD0NyCZMj+CsQ0cnW+dF2jgSUJWlSPf78GKxFG9Mxu0MLgQPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNq6weki; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-85cee530df9so134752885a.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425823; x=1760030623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zv8ZzeTp9smeQ7eHz1EIDl2Qbijx7uNellK7A4jjeo0=;
        b=NNq6weki4kb06RzyGZMMn2b34vLmfz6XzwMCAP9X0FKj2cILIA7WZsvY4i5XWNrgRq
         PqW6qYfGNDp7x1aVKkwAenKGvA1EdYoNB9tfnqQ9F8P3wCsylGtE8sCGLcQBYaT45i5a
         1AHFYb15DYa1V+6EkTlmiLc9SiHIkIrNxbnkYFoL1A4jDIe/8j12uX7LRNXlamgzeeLE
         NaAKdZTa3wwGa2U8xG1J+ILZzAgqU07r4/9irBZLsOwvvHd/tZe1rWvFDUWYnt6D1oIv
         Ymb71CuaqMz0nMrKa2b5wFeybNcocfZJ48kzvRdpXwXkUBqYofRpTew93M6p98Cr39Ly
         +Ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425823; x=1760030623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zv8ZzeTp9smeQ7eHz1EIDl2Qbijx7uNellK7A4jjeo0=;
        b=ctSoBqMCLDRLIDuTSuM2YdPBusd/OAsx9ZLcUIsgOMWRSzmQ2Hs69V/4usEmVzFuSz
         P+FaUrGHZhRgkszfWDjPdYkJOjBJEq2Qma5yINFQS9PWZwmTQNM+9j+z7u+htdwCoEl4
         am/E/ZjdBjg83Uq4V/Xzyw7PQGmiwT+Ogy6CIUOueL9sgfYsS8b8QUolQiEItoHPfaop
         Bru4ICo4DYHskqDxMS0qEtm/YA+aebKugVPT3Yv6XTPBtuFt/iw6kekfQZlbY5x+mJOu
         wkb221OlSwdHxo6izQ2j+JQI3SM1v4tgYmvlcaqOTIcvBVCnjm/QkxYZORhi7ztZRGa2
         i21w==
X-Forwarded-Encrypted: i=1; AJvYcCWpKkCBdmepqYCMkC2k09pNzbXxS1fOFpfSa0miEBlVt5+UTVCF7GB2OFhsUyfxIwY7CFs8VrtaKtOZnDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwKI15vlMUcyzMlLx+fbfZUFj6m/GipFJGX1AHoAgOJh5pO+qo
	83j4dFVr2LuWTxXElQMTftU9nhKbS1xOhzQ08YQih1ELOqUDSCoa6ELPN15msQ==
X-Gm-Gg: ASbGncuW7yOzvf5IfmjvbxwSes8mF8cKtTJM0tYc8v1kdhRA5kJZ1vNgP8MO652g8th
	qXY+EvAwE1bMIZKBvUo0av7OoWtB0Lk8bEo805EtxgOnZztZbmW1GlISZ0pF4gFcAUKUh6VOt1O
	rQfzk/kHhzGHGYmKijSsYFJ57BGphMHuuxS52HU733g+pYgK3i5e+0Yys3jHYInRuV5rMfGiveV
	heLqhANQmzEgyJ9ueqIQ17sijJn1xnJVIxejq9GxrNEPtQDo/kdd2ff7KVg2PcHAA56KhEaDSZG
	nBOjhKyONGU+ElR90REBOU1GEo3d1p1KLlGYtIAvTUNKv88nFTEVF+HnoYPZtTZgw9GmccuETgX
	J3zfxsoZ0q64dBZNu7rvIDERczGT0vZaZfhpMDuEQEMUTbewPYdcFsiu+tZWgZY+EKT/z2I72xM
	M=
X-Google-Smtp-Source: AGHT+IHzNsQcFPuCSBLjY1AJhdI+hSKrTYaEx1F7y7XFfxSnOzuNHB3JdsSlVBSXSTx9sb4wBIYFXA==
X-Received: by 2002:a05:620a:3182:b0:866:a24e:2eba with SMTP id af79cd13be357-87a3a252e77mr32861285a.46.1759425822050;
        Thu, 02 Oct 2025 10:23:42 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cbd3d9fsm24504971cf.32.2025.10.02.10.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:23:41 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v4 00/16] staging: rtl8723bs: rtw_mlme.c mechanical cleanups 
Date: Thu,  2 Oct 2025 17:22:48 +0000
Message-Id: <20251002172304.1083601-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series includes 16 commits that clean up and improve
the style and formatting of the rtl8723bs driver in the staging tree.
The changes address spacing issues, indentation, comment formatting,
blank lines, and minor code clarity improvements.

No functional changes are introduced. All commits adhere to the Linux kernel
coding style guidelines to enhance code readability and maintainability.

The patches have been tested and are ready for review.

Changes in v2:
- Resent series as one properly threaded batch
- No content changes

Changes in v3:
- Rebased onto latest origin/staging-testing.
- Dropped the “remove unnecessary braces for single statement blocks” patch,
  which created empty-if (comment-only) blocks; feedback noted this was wrong.

Changes in v4:
- 04/15: add the missing space after '*' in a block comment (per review).
- 16/16: new patch to remove pre-existing trailing whitespace error in
  IsInPreAuthKeyList() comment lines.

Link to v3:
https://lore.kernel.org/all/20250929065000.1010848-1-vivek.balachandhar@gmail.com/

Vivek BalachandharTN (16):
  staging: rtl8723bs: fix spacing around operators
  staging: rtl8723bs: remove unnecessary space after type cast
  staging: rtl8723bs: fix overlong lines to conform with kernel coding
    style
  staging: rtl8723bs: align asterisk in block comment to fix formatting
  staging: rtl8723bs: fix logical continuation style by moving to
    previous line
  staging: rtl8723bs: fix indentation to align with open parenthesis
  staging: rtl8723bs: adding asterisks in multi-line block comments
  staging: rtl8723bs: remove space before semicolon
  staging: rtl8723bs: fix excessive indentation in nested if statement
  staging: rtl8723bs: fix unbalanced braces around conditional blocks
  staging: rtl8723bs: remove unnecessary parentheses in conditional
  staging: rtl8723bs: add braces to all arms of conditional statement
  staging: rtl8723bs: fix line ending with '('
  staging: rtl8723bs: place constant on right side of comparison
  staging: rtl8723bs: merge nested if conditions for clarity and tab
    problems
  staging: rtl8723bs: remove trailing whitespace in rtw_mlme.c comments

 drivers/staging/rtl8723bs/core/rtw_mlme.c | 417 +++++++++++++---------
 1 file changed, 251 insertions(+), 166 deletions(-)

-- 
2.39.5



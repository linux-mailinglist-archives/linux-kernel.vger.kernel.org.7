Return-Path: <linux-kernel+bounces-724621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EA9AFF4F2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6594A59B9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F2A23E226;
	Wed,  9 Jul 2025 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkB+GIeH"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC5C21B1AA;
	Wed,  9 Jul 2025 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101386; cv=none; b=GAloACN6utgFfVkTYy48FkMx9f8jzMFHYx+oXNjQZKWo8LPUPylarM/1JyfiFd57OqYP3hw1z/6CKZVPdYEu5mRyToNafS2nhUSE2Ox6Wj/eUuNHIY4KEGphA5VTK2Cq3jM3LmLyCKycDScvHjdfhgD/VZmdg0d0qnb1+HwQsKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101386; c=relaxed/simple;
	bh=abdeyNY06bLr5ofp6kh/r/nr+1F+Do4kyjKV4NCjQpk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j+/2uSteM3/UIup32TqZdIpAEB7+aj0qFKZYPSJO5LYT9KgOoNd+izTt+MTEccsCJ5yzgfKwjk8VmrUcJJ9rx0w/XMtNtrnSRkkHnXZQsIqHh6BrPOIKiXmqUyH1Uthg2UyH1ce9fQ7ZZ1xJgCyfulLOk/wRO0CdL/92c6eHA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkB+GIeH; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-700c7e4c048so6991336d6.3;
        Wed, 09 Jul 2025 15:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752101382; x=1752706182; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwH0EZwwIXhh3DbBFiPYAueo5h5phsMNUGEWPkl+g1c=;
        b=bkB+GIeHA39OlqU7u79EMCNFhh6NQa/xR5o8luC3NeouPxtZpkbEBIKNMkAEjVVXB8
         HmxEG07t1BbKRyg5KR/+KbLbC8gi1nGwATHreqKquCOxfTvw10Uv7lfyLWCrG+nFx1OP
         Y164eqdZ+vxZvJsmYKJrPYCulfTg4otY0VV9nfOWaPBd3GqjyDTn/w2CQg2KnN2DyJ7y
         2bbitxuSjqgecj4JxZAklgFErJPYoHxqFuFJ0QoQB15AhogzkRp+3R5UJ1RegFk3kMkj
         8Q9YXCT3q92l6VLefssi+fOPTdcCnGw1Uw11i0Ps55EmdM5hCSVZPJHGQbYGrJ0QapUC
         rI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752101382; x=1752706182;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwH0EZwwIXhh3DbBFiPYAueo5h5phsMNUGEWPkl+g1c=;
        b=pFEiXsamKdm41ThQZOu1kMBBSVL3lZt625+THhQ7jdY35FSnQwDYwrzg7CmIU5DNv0
         +R48nyI4qokCBIuvJ7nwXPPG/BuSYGVhf120yjDcW3ygD+QIyLRcfJw2qOfF8q+GS5B6
         KViFzdhiz+RyK95xIsCGjBt2GPqvcJ7XH4X4zdkFGv2IbOfROiXW3bgStM+3T6FXCpAA
         99viy+s9/CbtDQF3GMpRmqJsI9hBC9iAwSOuFxTGCZVs3Tzc0j1V0KtRYaCk7glvaltB
         4byG5WlzZDyRwhaJOlxanTXlnejNHDAD41qpOxnboUPIcxLFImqg45Hzszt5Q4eev7Hr
         fM7g==
X-Forwarded-Encrypted: i=1; AJvYcCUvtUuzqI3SWPBgUIk1CJxb53er183c2XjKrpKu3/xEFXE3S7GVE09XSprlpCPYozWK4Wd47BTwJhI9CZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztYVDa2TrOZXPJ7iuzV/tk9FmmQxXX2gZuroEvazEhMJQ5KfXb
	Id4qnzWFk5UuI2ydnHHGPn17yQZO+zxlsAf/s4DTnTa99qN/3ZTmlAZH
X-Gm-Gg: ASbGncslC6UMX5TdEQCW0SUgIzAfa4ZH4RAB0Ak92koI2RQ49vK6P84QDBLwNG9J06A
	lavjFihb1BzHOg68VBy7E12e4sKQ7NY9fzSKzHYZXkyQu0V1ui5eqEsgdjkmxFixcsvs/Z5Ak1i
	UsEQPTYqXf/A955ytFCRvQvLqaQDQIYbxUHkhPTG2InKwJ9TuwzpNewnySiDkpzKPof6x4rXS2e
	47dXhBaBQGINfTfGPn/5/hSyew2as8FG6bBGXHxmDCdqriNbfbrc5lXTrn2qUzMNdh7XQoDPo4R
	pDcovejfH4D/o7n8TTWJmjDmFudnAKqaK/ITMw6Ejb3w3hiodjkkba+3/e1KHSadNTgL
X-Google-Smtp-Source: AGHT+IGKnKz3LSaGDY2Ao9Ot2VXVHEB6ietOe148pojhFApAhPAT7zhzpZ/cDLrRyVRGZ7iRif+oBQ==
X-Received: by 2002:a05:6214:29ee:b0:702:d7e2:88b7 with SMTP id 6a1803df08f44-70494e7190bmr22838586d6.6.1752101381953;
        Wed, 09 Jul 2025 15:49:41 -0700 (PDT)
Received: from [192.168.1.156] ([2600:4041:5c29:e400:5085:1d69:8814:72d4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70498090248sm1025986d6.90.2025.07.09.15.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:49:41 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 0/2] rust: init: remove old workaround
Date: Wed, 09 Jul 2025 18:49:33 -0400
Message-Id: <20250709-init-remove-old-workaround-v2-0-a3b1be8fd490@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP7xbmgC/43NQQ6CMBCF4auQrh3TDhHElfcwLBo6wkTokBarh
 nB3Kydw+b3F/1YVKTBFdSlWFShxZPEZeChUN1jfE7DLVqjxpGvdAHteINAkiUBGBy8JDxvk6R3
 YirqqbpC00SoH5kB3fu/xW5s9cFwkfPavZH7rX9lkwIBtEF2JZXl2eO0ny+Oxk0m127Z9AfJzt
 ynEAAAA
X-Change-ID: 20250709-init-remove-old-workaround-a6ec6792e010
To: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752101380; l=750;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=abdeyNY06bLr5ofp6kh/r/nr+1F+Do4kyjKV4NCjQpk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKZA7gDrGy/F/weTqKCO2QGnsm4WsFLsEWC0S0R2NAypxCUlMjcv5+UY0mC6P6se5uC4JEXLyau
 Yi+O1tGKqwwo=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

The first patch just enables compilation for these doctests, since I
accidentally broke them in v1 of the second patch.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Add a commit to compile the doctests.
- Remove a bit more.
- Link to v1: https://lore.kernel.org/r/20250709-init-remove-old-workaround-v1-1-a922d32338d2@gmail.com

---
Tamir Duberstein (2):
      rust: init: compile examples
      rust: init: remove old workaround

 rust/kernel/init.rs | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)
---
base-commit: 2009a2d5696944d85c34d75e691a6f3884e787c0
change-id: 20250709-init-remove-old-workaround-a6ec6792e010

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>



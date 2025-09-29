Return-Path: <linux-kernel+bounces-835835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989CDBA82F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CEF1C09F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777D72BEFE3;
	Mon, 29 Sep 2025 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj1Dsmkr"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1111F4617
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128619; cv=none; b=rEa11phwz60slZ2isvYk6osAXmhbANXPNV25/aFxyVZPgiA3Dv06IKwvT8EKfsvsHTQ3cNuscPpq1Ge55YnIini/uktZsHlDolzmyjxd2xXt9neq7f7eK/3O/gcXdd8zuZSqgOLpp3wAfPBOKsbKQmwCCFI4zQkQtkYWeGNkzhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128619; c=relaxed/simple;
	bh=9/bFU8Or9MIPvPe/HjO+mDZvzYEwKhcuIx6caKlsxGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ODPXGG3GNDH0M9rri6dpjknwzcqxb5F4MqKPTIaejnyg4tykqc9xABtzDiuUQlEHjW8mPoAuVfDDfmZuv72To893obcdRB5lF4LYNGV7q5fR+2QK/AjP6/z32ZA+R4nMd6lZMcLQADzZn+TENd7ENUvEPPCUgON+eE6WQGNjxK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hj1Dsmkr; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-855733c47baso625109385a.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759128617; x=1759733417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wYq5mD20gIgYqOzTdX1OPc1yjCmK6OIcJvyWHLb0NrY=;
        b=hj1DsmkrKpSOdlkbTCWI+LE4vJQjAkYlQT4mCMIWJ+BEfdhM+x2yDCgiArpJXIaKUJ
         51hOCvJn32iOGtGo9QpMg2llpeCcbAQ5HNt6cnH0QQuow0FvNXS50tsaFVoMtZsW1UpX
         Qez5VfptmOsSUXllx+3WFhRGM4PPZIkLUF17sXa7fz5cTv2Q5V3caK02I8GOJc5DhacW
         /rliybU6GGLn/AO3taWyrBRDeWJVwEzyNCQ1tKjj4DANCZfgx2C5twwHTzPsf4eFZS2o
         S91fRUzBGwJo3yswpUOQElHYqWaTNWe1J+8JYFNCV5wwYBKI1m5t5zNyzj4TNmpi9V/5
         Q+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759128617; x=1759733417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYq5mD20gIgYqOzTdX1OPc1yjCmK6OIcJvyWHLb0NrY=;
        b=mD8OK1/Nsb3nfUEEGzR42UOtHZlTWyM4nkWtLEelbquO5/Z+M4C5Fe1MmbYPJZs6WB
         WjJjKw+0nz+KE/jIxu7CK50oLSw0UklKtJXTahOF4XXAEp+cABrrJprPXiwWIG1OyzUh
         LxbvQaHjFsdHgq28JQ5mMyMHL2FmSe8P22DiTr1+XvGWtn9KEAqC7F4IsTtoY2oibSVD
         OVed9aJ3rQmRirHfeur5E1L3EjqCRK2aKXZ9Z30n9VYsIy9BXQU7Yqx4Rq5TZiOqhrUL
         iTBEVLuAtEtTJ8RiPYjFhNRq04hXGFRmwsvZ/xtCOOM+fzJz3iw1NoqjvyoOuDjIxF+x
         o9EA==
X-Forwarded-Encrypted: i=1; AJvYcCWVqb20uLFHmLhgrWC0/zsh84q5e1IxqZT6LxhmZCoJlpkf2TKtOjBQewX9TSfmCvf8ttvMD/6RCQJ3hkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+dj+J15HbhOlsiFzXUxksO2y+hLYbAf7xXv08yBG5IKBp/iD0
	tqU9Ia8lqQN3jqt4YPu1e5cHuhtJYFv1oU5X73FQAy1VNLFVF6SyuK7UUlWWSw==
X-Gm-Gg: ASbGncuZt5KY4RSTpiuC7GzE0kSqN5HeK1PJRKupnBUGx57QqSn0tbVeKZ9zeCpHlbw
	iHux9m/q+Bu6MkTmWaO7gfJfrMlu2fnrv7wPUq68P/TIydcgnKyJ90MoiF8SHwtDx5h6Hk34/JB
	NdmCPDi/P3gHMd4LnhFr148UPTaj70eicrFvvEJdRNwZ2TOFyvIQqKg4QpK4SEvyNMCkVM2SWNV
	YlTFJZWIMKcqkxnuvOcpA5Q26RxBbU/EK2skF9a04YQITCd9UQNf8Wuq6QHfUvEAk+4zwfwsmIU
	US1d/P8Ys9nCqV5Lvcg0uU5cCQFJkz7Ts82cvochus+fKjJqFDrJyNXj3UdMY3V/V9JQqFGC3UP
	ULPNa6PPsWNvI4pukWyBtxURE1b5RU65eznzK72mkbJRUqsuVolJyp+BmOOEpGA==
X-Google-Smtp-Source: AGHT+IEmjI+X10xcSGINliKtCzItrc2T9H3twnC5pclEPJThf1OcdekBoBk5YsszkVNNagtTTDd9iA==
X-Received: by 2002:a05:620a:7118:b0:85f:82c1:c8b1 with SMTP id af79cd13be357-85f82c1cb96mr1601940485a.46.1759128617052;
        Sun, 28 Sep 2025 23:50:17 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db10874bb9sm69517671cf.24.2025.09.28.23.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 23:50:16 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v3 00/15] rtl8723bs: cleanup and style improvements for better readability
Date: Mon, 29 Sep 2025 06:49:45 +0000
Message-Id: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series includes 15 commits that clean up and improve
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

Link to v2:
  https://lore.kernel.org/all/20250904021448.216461-1-vivek.balachandhar@gmail.com/

Vivek BalachandharTN (15):
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

 drivers/staging/rtl8723bs/core/rtw_mlme.c | 415 +++++++++++++---------
 1 file changed, 250 insertions(+), 165 deletions(-)

-- 
2.39.5



Return-Path: <linux-kernel+bounces-820726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B208B7E9AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 754E37A513F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF17328989;
	Wed, 17 Sep 2025 12:52:17 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F76930CB39
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113537; cv=none; b=nMnhqb5htYFuzLA/uSBQ7ia/7k6yZa9zrHRFXtnfehdhB2fgiZJjvRrzEOQ3SWZsA/rc5AAB5x3EQxwaBKLEc0A6rPT9UfGXS68t95Gnns6c4+hKaqf/YkF6u+aFbzQqQ+AQpGx/s39qSiVZAQD/UqV1ogS7lbCjkPZ2JQa8n2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113537; c=relaxed/simple;
	bh=z0CqdaKtG3FXMT+SGr/8fspurJp6wIxXOOHn9NBLkew=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KOZ4n4u8uZ9kHJO4/+Z4mMKUSPS6iyHnnpSx71O2gt9Gr21QcsiSEnRscqUvy8wVquQ1iwmkNunkIoz2AiM3nYLVzR8e/XPWbM4T6BpRDIA/vtyq5O7g5yxuFyxQFZu8DT1tmaiPDy8y3Mea2FVDLLoSPou0LLn11GssbkrMsVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b07dac96d1eso136516266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758113533; x=1758718333;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Fwe6Jox9lvYBGadLqyIGGqu9khZAUVhT2PK4Qt0Hm8=;
        b=RXbk5czfBpvX6ut0e3iY1NIcDeuq4ys7H9r9ZYDNv0H3niEdH/LedvwanNXj6lY1+V
         gE7NtBrVlIBtzdHC42sfu1Zerf7yV4Yo/3CSfo6ixKtXYmrNIcI8TNbiwQvNSd04d0cV
         PmVPVQgCW8mjYg2EnXkawiB4ASGZYnWVGHvo8Qb0ZJbknU8gpJWvd1CkWPuZi7yvPIz6
         2KR6bArusiWfZfxqJrzs0hOnDApSJOxS6C3EDjlfkUwzfTGwDMmxuQmPW0GUi+AgWlxz
         G2I/gU9KEAuM52kKODBundyLpgvH8nVF1z3vtwrivEF8uh7wdSiNi0L7+mugjud0l/JN
         EmHA==
X-Gm-Message-State: AOJu0YxLL9jax3fLhpOmRHIub+Dhecj5H/s+6kDkqd9Hr44Dan91aQAz
	qWTBtWriyaMFA6cOQGldVie3TMp8PIudf/jn91Q75I3kYW1hBsVt13Da
X-Gm-Gg: ASbGncs5UELel7hCNmPnIJiQtNO9C1tcTbotOD8CNtdmuIDZwdS59/uKwyZ/QIZ/rq0
	Syw3ZH8YT0cgYmQU8PTokgGwcyaGKGGSJSBYSlOk5iU8ywJZzCcJ5mDkeJbargC2jKHPhypQwAJ
	cH9QVXbh8+btQd7+Miw0caZO1p8VpahobEOG/EY2RsJFr68ivDyzZC/UZd4sGIUk2pVNGE5Yv0E
	RF9kfDp+s+yVxnuMo409Wqr8XACfcwF6Ovi4LPumnBc+79DlnYclMkOGtc6WpvSxjBtoh5YVF5U
	QlrMIPFpcj38UitF4I25wKvHXXK0zHu1LXYu9ZQnS1Nr0GoTxkZFM+taiF+OYbmH4/YtyWps4Ag
	NaVTgVbqfsQgJbFOfQaDFkqsg
X-Google-Smtp-Source: AGHT+IEapc8hSIjb349hAjbQsB4lVpp+5A+aiu4G8+6KZFoS/VpkK60FcM7fDOTphXJBAbk8gn9SUg==
X-Received: by 2002:a17:907:d78a:b0:afa:1d2c:bbd1 with SMTP id a640c23a62f3a-b1bedda96f0mr250991266b.30.1758113533179;
        Wed, 17 Sep 2025 05:52:13 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:45::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b19a4c2d3cfsm210880766b.26.2025.09.17.05.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:52:12 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net v4 0/4] net: netpoll: fix memory leak and add
 comprehensive selftests
Date: Wed, 17 Sep 2025 05:51:41 -0700
Message-Id: <20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN2uymgC/33N0QrCIBSA4VeRc70TTtPNXfUeEbHpWQmhoTaKs
 XcPdlU0uv7h+2fIlDxl6NgMiSaffQzQsX3FwF77cCH0DjoGggvFDRcYqNgYcrzRucRUHomwHa2
 QI+9tbwxUDO6JRv9c0SMEKnCqGFx9LjG91tFUr+mfOdVYI5dWc62VackcHA2+D7uYLqs3iU9jv
 2kI5KiaRpFTzkqtfwz5aahNQyLHtlG2GWlwsv42lmV5A2ng6BRCAQAA
X-Change-ID: 20250902-netconsole_torture-8fc23f0aca99
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=leitao@debian.org;
 h=from:subject:message-id; bh=z0CqdaKtG3FXMT+SGr/8fspurJp6wIxXOOHn9NBLkew=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyq77SqEFfQYQIeE0oilLdana10QcJmXq1NYfh
 0NII2YzuHGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqu+wAKCRA1o5Of/Hh3
 bTiXD/99+CjULWfW0x5zaGcailnXvJJh/yLySYqlL+wAw/wRoxS0kGxDVpTJjxwcJpQjyyO47fI
 tikEHJ8t6RewkSEHO4UCDvZM5+ex6aCY8zzi1Gg2hjP/pUX+cD4djQAiEFLKkB7bJKpJpiqTtwv
 oSsUQTC9D1F2fWZ8zwnPVEXw4v6w3H2+CHfQCv1kqYkzm7rT3Xyxrjs7DuKEKbnk8r4zBCsUu28
 HfmJQMfDrvUhaC3fvZKCznwvE/0Vg8RqMEXCrYHxib08YVm1LZRGN0cLhW2E1YJLxxiZJQAMiqs
 2XMXGTs0/AbUqLvViHtBNWoIcW5PXMH3gpzQbJLaSIc8vdKZCdxOOzKZS8eYnF8Sy7HF90QECcv
 LJ2tuQGPREaU7FRKOUeTlveuJv/+7fZtJw4ACW9CbS4fUim2y5M4bjN221I1/rI4Z8e+VPwRAha
 ou20Y29IymiHjqBM2MrxKcNafaVjL8d9cZnU7c0EBUAaMfp0OJedlZpRsyD6sywjKjsPy0cRLFh
 Tn7A1VEls/sqj6GKwhhgjJsb/+uytRprX6fU9MRg3hM7ZZCoDtPvgCfkzHc4p3W/4Ecn1Sy2I9O
 qa5nhL9CuxeLakwRKjaB67gF+UH4F0tfIQPxWIvM3GNeevYfYjSZ/tnXHnzRr/CFsY0hRa5+Px0
 vOPvPH/y11fEKYA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Fix a memory leak in netpoll and introduce netconsole selftests that
expose the issue when running with kmemleak detection enabled.

This patchset includes a selftest for netpoll with multiple concurrent
users (netconsole + bonding), which simulates the scenario from test[1]
that originally demonstrated the issue allegedly fixed by commit
efa95b01da18 ("netpoll: fix use after free") - a commit that is now
being reverted.

Sending this to "net" branch because this is a fix, and the selftest
might help with the backports validation.

Link: https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/ [1]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v4:
- Added an additional selftest to test multiple netpoll users in
  parallel
- Link to v3: https://lore.kernel.org/r/20250905-netconsole_torture-v3-0-875c7febd316@debian.org

Changes in v3:
- This patchset is a merge of the fix and the selftest together as
  recommended by Jakub.

Changes in v2:
- Reuse the netconsole creation from lib_netcons.sh. Thus, refactoring
  the create_dynamic_target() (Jakub)
- Move the "wait" to after all the messages has been sent.
- Link to v1: https://lore.kernel.org/r/20250902-netconsole_torture-v1-1-03c6066598e9@debian.org

---
Breno Leitao (4):
      net: netpoll: fix incorrect refcount handling causing incorrect cleanup
      selftest: netcons: refactor target creation
      selftest: netcons: create a torture test
      selftest: netcons: add test for netconsole over bonded interfaces

 net/core/netpoll.c                                 |   7 +-
 tools/testing/selftests/drivers/net/Makefile       |   2 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 197 ++++++++++++++++++---
 .../selftests/drivers/net/netcons_over_bonding.sh  |  76 ++++++++
 .../selftests/drivers/net/netcons_torture.sh       | 127 +++++++++++++
 5 files changed, 384 insertions(+), 25 deletions(-)
---
base-commit: 5e87fdc37f8dc619549d49ba5c951b369ce7c136
change-id: 20250902-netconsole_torture-8fc23f0aca99

Best regards,
--  
Breno Leitao <leitao@debian.org>



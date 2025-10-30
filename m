Return-Path: <linux-kernel+bounces-878235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC04AC2014F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61BBF3479F7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C2D34028E;
	Thu, 30 Oct 2025 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biz7aGwJ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356172FBDE3
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828597; cv=none; b=anhzVb38+QKQf2kQ1fpv8X8SGMsx84Mr/NqtpF/NbCt3AEeWRu/5H/ZUJTRyhNs0nZcN1zibREY1ySBHTHZGzxqoHM76C6pXbFSb0Tm2jR06EaM8wwgodot4J8txT67bl7UkooDQljFWIse2WGkBE285DSg+V7HPSZJhBMYlxWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828597; c=relaxed/simple;
	bh=pl2Dax7X8Q2Kn2J5L1Qv7Q75J13hklW936GDEM09W0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mPVnQMNCAYBZBbQuiMgnXbZUCDbIaaRdVGsui8NeJ4NigDF1EAHuS5+Re3aBOM7ax8opV/rwVkFfdl8XNhyE8CgZsFVAI7dAEAv/stedZJIDoeyyv94QPQqbIeJA19I6LP/ghhoM2h/IUqrnKz27YdpKyJdYi9UQF/Tmo66IFLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biz7aGwJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-269639879c3so8707395ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761828595; x=1762433395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wMUkyUpK3qsMRsq71Jgy8aRMQN0C5fUI1+KxForyRw=;
        b=biz7aGwJPjM/t9shv/+KlX2eHVgmkzw1NlWrPQEC3XwQkuwNCUvzrqb02qDuoDoJni
         LnXVEZ7fjxS9/jWHO9BvWH3j2O64exRqFnU+MjYoxYdtUfU6x+aK0aKhtG/NWXzl+EUj
         P3rzI+MKxkF4/jfu2XQ7I8lNH+AoP8stQuMNZPX2k7GcsPLtIhkPS6H66aUE0yD71GJH
         9kRRPOxzSwc5x+JoJKS7fnX+rI3oqonb1v8YkRoXGK5vXD3W14J/DcOgweNZeFHXya9p
         ZM+VnQHBlOhZs0hykKSEk2Sy4T5CYf9RaWAno8vC3m3mB3+ZRi+uUMdd1bRtOSDX2FiF
         PJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761828595; x=1762433395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wMUkyUpK3qsMRsq71Jgy8aRMQN0C5fUI1+KxForyRw=;
        b=ACo1H0UiRXPRcRNUDziuIW2sKfKKBpk+Lik3Z27WZBkuo+qS6dCU9RLUd2Ug4OTCnV
         H/0nbxG4NOah674gh3wGdOnqGSChJTrQpZFEVMOMT0/E5sE1NYaJ+q50mai19H63fnwx
         t54Ho3zcHXGVl/pK/D6RDQAZmbMy4O+HSUbi6mmdLQMq0vulVna4Ix+dlCZAv6qPlAQQ
         fS88vufTJBUTo/qcgk03cz/UK2IngGqTH3GbS4uMfWi5C1crr5/J6F0Q98XjA+2FmicT
         yrNlCEXjMWpSnkAjPVNk/SSMtHhBOjq+jIqNrOGgDXEI791WBZFswpV2m+5eoaOJJcTS
         QGSA==
X-Forwarded-Encrypted: i=1; AJvYcCWaooqu+bZP3hv30U8VcZ7FTv6NM4/S2q3+N+JSIMJCmYs8OK9ukbPV7Obn3ZPWr4wVRKKqtFuzEZih+/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa2lLFsy0oLqX/yJVOzJp7bS0yD2FguYTIW2E5gy8hi6QCymv2
	Yv2JFPwWXpXLjmmihUin6+Berb6OmT7wdRWD+Hk1cENE+1rAQX0cmveW
X-Gm-Gg: ASbGncui9bQv05kDzUiTRc3XmOZtSRnEF9u8n8nzm1kyDt/JhhxRIm3xQQIMjIdwkbk
	dFtE/QlqAt1l2ujKbek3uP6EkgS1tm+sVAFlBX6jTb8zsJBoq2fW7l1krufJpPk10DIP1gd1D8V
	vkiho7qraUd7i1LtxAYML+iQCqIc7lpvXI6WAzLDzxoasOGUEWaeuo1Mn+GJYxejGyf+kj75pP0
	syGzrziBUviRMcmSaSKwdHcmMkJanOB2h+BZrfB70qtGnxTIO85fq3DzyneSj3oGuXDsHdnZ8Zu
	bkXEppgXWyHuDRG4MBCy6vKtyJePZbrrgU0PCrAckzgJN51fVYvKoasUwE9WV5ZTKw8FXh/iX3D
	g2M7VUsEpp+8IUgAeNCMcXIBEmXY8+03oshQSsaCoP5drh7051qBAQsyPrc5f0d2zUBph3fEze2
	p0ikLMn0zwu5+C
X-Google-Smtp-Source: AGHT+IFqMiF+448NAGIOILZt5S2gDNl6+/qjfqm3OgH1RKZRoe6AgVc3Kgh8Qko6BWtweiYRhF+MNw==
X-Received: by 2002:a17:902:f708:b0:290:a3b9:d4be with SMTP id d9443c01a7336-294dee128c3mr80435845ad.24.1761828594891;
        Thu, 30 Oct 2025 05:49:54 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([123.124.147.27])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7127bf47a1sm16719123a12.10.2025.10.30.05.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:49:54 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: kory.maincent@bootlin.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	r772577952@gmail.com,
	sdf@fomichev.me,
	syzkaller@googlegroups.com,
	vladimir.oltean@nxp.com
Subject: [PATCH v3 0/1] net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()
Date: Thu, 30 Oct 2025 12:49:46 +0000
Message-Id: <20251030124947.34575-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030111445.0fe0b313@kmaincent-XPS-13-7390>
References: <20251030111445.0fe0b313@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kory,

Apologies for the resubmission (v3); I forgot to add Reviewed-by tag in
the v2 patch.

v3:
- Add Kory's Reviewed-by tag.

v2:
- Fix typo in comment ("driver" -> "lower driver")

Best Regards,
Jiaming Zhang

Jiaming Zhang (1):
  net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()

 net/core/dev_ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.34.1



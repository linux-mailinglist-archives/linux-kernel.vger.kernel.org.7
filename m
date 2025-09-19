Return-Path: <linux-kernel+bounces-823949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C70B87CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 939237A4070
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F7423C8C7;
	Fri, 19 Sep 2025 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEmagdtO"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1256B34BA2B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758252441; cv=none; b=j9N2e40nVcSD2M59cr1JFa6HJ6cU7+K6wl8d7THyeewvjNZBJidDE2pQKI4e8w5PaAQfVxxV+L2wDq5RrkFv3XuP9dQyR/QP99SwTFjCatmecgFPK937GRhcjHAzr1fTgOuLT5prcZ8+v1Tbw4UA93Z80l6dY/WWPu9fuwOGasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758252441; c=relaxed/simple;
	bh=ZerVmqXt9l3Aqdd35/y7qBTENLgT5swoQxUW4H0GSyY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tV8QVdklqL4Eh9n65iQe0VgqH5W4NNnDE6XtqX8KGO1PuFUsGEt9aCAw8LQoniYNdz9G5hszmKXmRfgmWTux/y8git6cxUnQerF/uQwZbmq3CFbbak1jax40JiFKEvlU6/OZhSmIiEUl0BQl1613QWYRuBJJMijsQr+pYDJnQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEmagdtO; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4f87c691a7so2510316a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758252439; x=1758857239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZlPyHh38EjXI6wOwhUFgcUHg4QlQm9+iktOtWZSXbZA=;
        b=AEmagdtOZS4noNZcHoAPW0X+BSTSdCAW9ytMa0ztyB3GGk5/X/qScy/f16HW+YSya/
         WWwJ4vzfR7rIXSvDs6yHwWKTACORTM1ErCrJjmtriPAIXzrYefclxsD+mwuFZVSAFH+d
         d4jNH9Xu7Yxj9xWb+f681UTEy3eKKkrriJPYWZp8YXdIHkyCTZY02LJ4c7pw01HQw0fe
         17k7pY4Tg4o83icJht6DeFf7Fc9pk0OfE/FuFku8bsp85v6qJfQm+p9y7jmT4//oAviC
         NqF/yp3R6Q7UYtze8eV7peJHwuVOiWHACfwuj4yXf0MmB7KhdUkiyCXZUs01GIJtBLBh
         2myQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758252439; x=1758857239;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlPyHh38EjXI6wOwhUFgcUHg4QlQm9+iktOtWZSXbZA=;
        b=eaG5VjfTB/5Sc4oalNZpMz6VwVvUA21v27y5mLDfN71b96Z4Lm+HX/Mqf8T83u8N2M
         YtBg424tiyiEYArwJP3t1abv9WkUkVfbFPy8Mc/T4t0CQ9rMSUZo3E+KKK25wG+Q39P4
         xwkGEObrD3+dbGoQiUHYsEki4FAieuP5SlToHkJVm7y3nxyx+90ckFOJSKghW2vZZp53
         OnOj097G4168ugEafLUp8asjJYwWX75JeHhCkoqQ9uuGUnc4C/AEy9lRguWt9eqDZQJk
         ZICeYVroPNDl73gyUnCuNKYTo1l9FPFUKjxqZ/8WJiF4IBaoOF5roc6/NODcQhfmLq4f
         mzJg==
X-Gm-Message-State: AOJu0Yzqz6Gs5AB6ZCIreJUP6VQj/W3RYsVRyXKQbFXvESedSN4HCj4G
	uBflGgMEuoCnqJvidvm6caSmM0Db7wAb75xrIxSj2r8X71eNYVufMsduG+Iu3cCX867bdIRyboD
	qzTl/ohq2smBkrOfMYkVQ+OSb2w==
X-Google-Smtp-Source: AGHT+IGiAiZfNxQh3Iu4yV+3sd9bOXM1iJU8BJZUvXZzSAEeCW1GsX9PzSBz49WpnCY8S8GfZxjg0sdh64IaRAZC3Q==
X-Received: from pjbsp15.prod.google.com ([2002:a17:90b:52cf:b0:329:ec3d:72ad])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9189:b0:24c:48f3:3fd2 with SMTP id adf61e73a8af0-292610628f0mr2820491637.24.1758252439355;
 Thu, 18 Sep 2025 20:27:19 -0700 (PDT)
Date: Fri, 19 Sep 2025 03:27:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919032714.948213-1-joonwonkang@google.com>
Subject: [PATCH v3] mailbox: Prevent out-of-bounds access in of_mbox_index_xlate()
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com, peng.fan@oss.nxp.com
Cc: linux-kernel@vger.kernel.org, Joonwon Kang <joonwonkang@google.com>
Content-Type: text/plain; charset="UTF-8"

Although it is guided that `#mbox-cells` must be at least 1, there are
many instances of `#mbox-cells = <0>;` in the device tree. If that is
the case and the corresponding mailbox controller does not provide
`of_xlate` function pointer, `of_mbox_index_xlate()` will be used by
default and out-of-bounds accesses could occur due to lack of bounds
check in that function.

Signed-off-by: Joonwon Kang <joonwonkang@google.com>
---
 drivers/mailbox/mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 5cd8ae222073..5bccdf27d6ab 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -476,7 +476,7 @@ of_mbox_index_xlate(struct mbox_controller *mbox,
 {
 	int ind = sp->args[0];
 
-	if (ind >= mbox->num_chans)
+	if (sp->args_count < 1 || ind >= mbox->num_chans)
 		return ERR_PTR(-EINVAL);
 
 	return &mbox->chans[ind];
-- 
2.51.0.470.ga7dc726c21-goog



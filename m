Return-Path: <linux-kernel+bounces-822798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC19B84B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735005423BE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA23303C9F;
	Thu, 18 Sep 2025 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ilbaT5s5"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB772D3207
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200160; cv=none; b=UegdcoyCbHRFs0khVmLQvaAseT4DCZ13iGYZgCjmCXmhcbgyO9oGf9ntB2Q2qpIkgLCJq0ySFR8ECXdHseZSBk7eUcQP9Z6S5q+BA8AY3EHasPlfeziOJvGmOWWWw17egwC3gJerbbgSfDtdEY/2U1zzeytjGJRZtdk/VjCzJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200160; c=relaxed/simple;
	bh=XR6Yjezpbu2Iu/8Sj/hrWpqtAsKti68tXObL7pMnNwo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ebyi2aebhDoVzBgW07Hw2gYjzKK8mrejsfan3zzvdLLbWiNBSeHrdniFDRYOpPXlQ0AVGBEbK5tSpasQhkWYKNpzFybXsmR6DSFY+2Es2zEWDpN+UAQenk1MFqUdhgC3xOiDuYxKitaLbMsHWgNzBAVQn5ROHnoytxKECQ4GIFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ilbaT5s5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-269af520712so1354515ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758200158; x=1758804958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a17M9AJtW8sYIaQgAVR9YA+SUDk6kYciylAWtglEbis=;
        b=ilbaT5s5MSo6AStOJZfc4HbwNJ/mgHh8R85UzRpeuYeBVygFwbTwwFJ0LagcX+PVui
         LIyAAHxmkfMdwjIfJTDo2qSvHp1ZuYxd8Isxx9bSB1HLV55AwjGLXS6J5ZFyuqmzMCLh
         pA3FCn+IvTulMDuBADyFJ/SLeFll/iLJxPoMYYlA7uV47UF4HGRhvSyzW7802odoO359
         Ju/xqmtKbCUVLjc24GIOVsGPBPqAEL2viCK5QLFnYwgYnwWgwcNYtSZu3Ql5FNBPDgID
         0QhFBxxt5p28rjVUXgw/Rwe6DE9JlO7AMpNG3qofDqAFr1RsJf11ManfGPDDqX+rsVyS
         kpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758200158; x=1758804958;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a17M9AJtW8sYIaQgAVR9YA+SUDk6kYciylAWtglEbis=;
        b=HzTPjk7rMiSrk6MllFtqkUQXYWQCIz0jHL9FgnyXBzz3a3PTbO5g2hJTNqhEb8FdEn
         kH5QAlZV36OUZi5IhdPPujlv7jcRWYfDhcW1aqstmAuJRzEKxYwbPPwEakIiukfwFzCR
         HSvtFzuQCWkJVNNCxpMCiYWK2RziwNe4BS/lFk7FnXSrVt/KWf0DIIHfsghxL/j9aEb1
         C2RX+PSYS9QD1m/cPiJqJI9rqvjbgSfTC0rMeYAr1y39/qpAR10lJUJgVeT9fvsrklle
         rqMlhRR0G0kULcp4qDZenurG0YwMQ6RbdHAMYGXTgph7phl/H3DjEXrpIj4RV7jXov/s
         UnnA==
X-Gm-Message-State: AOJu0YzJGIP3gj8VlfFD72QX3jbcRwn1ysBuOPwJn1x/xpxcr8MUwfJE
	UDKc0J0tBEwr60bnI1gsJzj7+PlpJ22EgLjixS2OfEfZoUKaeMBBmwjQkufsp29zvmtD5BgAuqk
	/FB9KKut+6FCzAimSeiWXQhPY6w==
X-Google-Smtp-Source: AGHT+IF7UxkrwWs5SBZRLXWN/b0pLNjU1dxOsBC1jq3TJVXfb5p1mZ7A0UYkUYl0U/QNMKkvgJn5JJkzs3KQflez7w==
X-Received: from plbjz6.prod.google.com ([2002:a17:903:4306:b0:269:7076:8c40])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:fa4:b0:24a:8e36:420a with SMTP id d9443c01a7336-2698aa45676mr33810075ad.40.1758200158457;
 Thu, 18 Sep 2025 05:55:58 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:55:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918125547.380088-1-joonwonkang@google.com>
Subject: [PATCH v2] mailbox: Prevent out-of-bounds access in of_mbox_index_xlate()
From: Joonwon Kang <joonwonkang@google.com>
To: peng.fan@oss.nxp.com, jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, Joonwon Kang <joonwonkang@google.com>
Content-Type: text/plain; charset="UTF-8"

Although it is guided that `#mbox-cells` must be at least 1, there are
many instances of `#mbox-cells = <0>;` in the device tree. If that is
the case and the corresponding mailbox controller does not provide
`of_xlate` function pointer, `of_mbox_index_xlate()` will be used by
default and out-of-bounds accesses could occur due to lack of bounds
check in that function.

Below is a problematic control flow when `#mbox-cells = <0>;`.

```
static struct mbox_chan *
of_mbox_index_xlate(struct mbox_controller *mbox,
                    const struct of_phandle_args *sp)
{
    int ind = sp->args[0];                                      // (4)

    if (ind >= mbox->num_chans)                                 // (5)
        return ERR_PTR(-EINVAL);

    return &mbox->chans[ind];                                   // (6)
}

struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
{
    struct of_phandle_args spec;                                // (1)

    if (of_parse_phandle_with_args(dev->of_node, "mboxes",      // (2)
        "#mbox-cells", index, &spec)) {
        ...
    }

    list_for_each_entry(mbox, &mbox_cons, node)
        if (mbox->dev->of_node == spec.np) {
            chan = mbox->of_xlate(mbox, &spec);                 // (3)
            if (!IS_ERR(chan))
                break;
        }
    ...
    ret = __mbox_bind_client(chan, cl);                         // (7)
    ...
}

static int __mbox_bind_client(struct mbox_chan *chan,
                              struct mbox_client *cl)
{
    if (chan->cl || ...) {                                      // (8)
}
```

(1) `spec.args[]` is filled with arbitrary leftover values in the stack.
    Let's say that `spec.args[0] == 0xffffffff`.
(2) Since `#mbox-cells = <0>;`, `spec.args_count` is assigned 0 and
    `spec.args[]` are untouched.
(3) Since the controller does not provide `of_xlate`,
    `of_mbox_index_xlate()` is used instead.
(4) `idx` is assigned -1 due to the value of `spec.args[0]`.
(5) Since `mbox->num_chans >= 0` and `idx == -1`, this condition does
    not filter out this case.
(6) Out-of-bounds address is returned. Depending on what was left in
    `spec.args[0]`, it could be an arbitrary(but confined to a specific
    range) address.
(7) A function is called with the out-of-bounds address.
(8) The out-of-bounds address is accessed.

This commit prevents the issue by checking the array bounds.

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
2.51.0.384.g4c02a37b29-goog



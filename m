Return-Path: <linux-kernel+bounces-819153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FEDB59C27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBEC3323FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0658B22689C;
	Tue, 16 Sep 2025 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xau5HxIZ"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7991223DFB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036923; cv=none; b=qcc0J988KoTr0DerfX8Re+/EIHKoBEflO35VgzAzsgbS0hOpj1xjGWx8BFSuKmfFPR7k+Eg6iQb+E66wcrxyAF6TaGMMHgM0SkZM/r86s9vCFxw2Lq9r8YggmR//Z+BNFi+7tPmO/jtbLqaM4sXt16WoInRDm+pOrLKhyVPlsbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036923; c=relaxed/simple;
	bh=6zTQEV0E+915a6464ff3czOn+7oJmma7dZvYvemvxlY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eLYsgdn+E4DWNLeVaSpnIn3ArPvPIZkUk2VVhqDYjv1o8rjzWl1wbQiJ911u347nrtQ/LrH8Jw4xHqqcMOwCrKCXo2pqaWSJ3UN7a/pdjI7eeLuMMijmIQlpAJf7KF2WxdJsDrBqNWeBX3X3VwFegKCDEv1a1l6VMicCORik+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xau5HxIZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-25d7c72e163so86630615ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758036921; x=1758641721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gAKAvKxpPdesn+u6ttysrjOSdxxejle04LvehHO032I=;
        b=xau5HxIZx2RIg1jskw1fsg73Zk9SRu1Ha92MJwumPNqmdoXaFMoqMMef3cHO5RiiQw
         m6qn1L/SpHf72URKJ0comT0IBI/DdN4XuWh5zMCd7hxdcnxG9Z1naGgWoH+nvnIlpIXX
         +7NDUgHw2crr9jM++2Ei6XyuxXGuab7Z03LhvA6cPH4S4wloicJsP+1u29CU8r9IKoU1
         ZFVSEJpOwoyx0vgnnnWOP9GyOpDUDDlH+j8BUNWBj1c5f3S2txBO/cJv1IJ3Y/tp5lGq
         eftIOWxl+5/nio9nDyhA1nokFgAPplfbw8hmwAq3UEpOpR1c8MMpythOms2zU2eIyVg6
         4RjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036921; x=1758641721;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gAKAvKxpPdesn+u6ttysrjOSdxxejle04LvehHO032I=;
        b=lFr5pp23xl7eh5n+rUrq/K5wQBszdNfWVqyS9rx+9SWBbr3+HObqC/0/EuVn8hfFV7
         CZ0jMCdFpphQTv+/7pGujEiftrJYHVCxJiVQlcAnAA+GtVhUeItLYi/fzCz/fM9yoasd
         zb6droMErQi7X/3TbnQN5RGoXlrOc1Lhp1Dfr3PYXf91GrNXjfysMG9eEVB1nTSEH79K
         UzsInn5Hrr8VEE7pnoNtm2QOdgSCqKEOF8+KoNB/kBQhLH6ybKTgEZ7XDIkfMVmPC4AB
         1diBbpmJSOdY78uJbbeep2cQwOaI5y4+vE1dcZU9RBWlNyII95xFlnBzCF8qa58kgApg
         Ut/w==
X-Forwarded-Encrypted: i=1; AJvYcCW4XmpT97tAQiuGEFcnbshuzYysnu3QM9MNqo/p95+6aNzwoBkBiTxK3goLx+Lq5EsUHZ3m3imzatrbtv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Ke9WXMUTIIMKEypDWwd434XsIO8pEYq+nb41eaHCgEuXwJb5
	jnAcablU51qcjwIqRWhGhefYjZQxt0SHqRaOAfQHz+ZjC16TV7VHH2Vm9QImsU9k46xvPBw8iRf
	U1EdawVSJHWaE9qHxpJgzrCs4hA==
X-Google-Smtp-Source: AGHT+IFhCXyJaHeqGMmzsifmaRw7NODFeSIFT8bUU0evbmSTuva83EyAEtsyRepGeM8xx++I7wl/n5ITD8hXm2rYcg==
X-Received: from plmc23.prod.google.com ([2002:a17:903:e97:b0:262:4136:e18])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3c2d:b0:25c:b543:2da7 with SMTP id d9443c01a7336-25d2528c254mr190651275ad.9.1758036921112;
 Tue, 16 Sep 2025 08:35:21 -0700 (PDT)
Date: Tue, 16 Sep 2025 15:34:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916153455.2527723-1-joonwonkang@google.com>
Subject: [PATCH] mailbox: Fix undefined behavior in of_mbox_index_xlate()
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org
Cc: Joonwon Kang <joonwonkang@google.com>
Content-Type: text/plain; charset="UTF-8"

Although it is guided that `#mbox-cells` must be at least 1, there are
many instances of `#mbox-cells = <0>;` in the device tree. If that is
the case and the corresponding mailbox controller does not provide
`of_xlate` function pointer, `of_mbox_index_xlate()` will be used by
default and undefined behaviors could occur in that function.

Below is a problematic control flow which results in undefined behavior
when `#mbox-cells = <0>;`.

```
static struct mbox_chan *
of_mbox_index_xlate(struct mbox_controller *mbox,
                    const struct of_phandle_args *sp)
{
    int ind = sp->args[0];					// (4)

    if (ind >= mbox->num_chans)					// (5)
        return ERR_PTR(-EINVAL);

    return &mbox->chans[ind];					// (6)
}

struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
{
    struct of_phandle_args spec;				// (1)

    if (of_parse_phandle_with_args(dev->of_node, "mboxes",	// (2)
        "#mbox-cells", index, &spec)) {
        ...
    }

    list_for_each_entry(mbox, &mbox_cons, node)
        if (mbox->dev->of_node == spec.np) {
            chan = mbox->of_xlate(mbox, &spec);			// (3)
            if (!IS_ERR(chan))
                break;
        }
    ...
    ret = __mbox_bind_client(chan, cl);				// (7)
    ...
}

static int __mbox_bind_client(struct mbox_chan *chan,
                              struct mbox_client *cl)
{
    if (chan->cl || ...) {					// (8)
}
````

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

This commit prevents the undefined behavior by checking the array bounds
and matching the types of the argument for correct filtering.

Signed-off-by: Joonwon Kang <joonwonkang@google.com>
---
 drivers/mailbox/mailbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 5cd8ae222073..6ed53868c83d 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -474,9 +474,9 @@ static struct mbox_chan *
 of_mbox_index_xlate(struct mbox_controller *mbox,
 		    const struct of_phandle_args *sp)
 {
-	int ind = sp->args[0];
+	uint32_t ind = sp->args[0];
 
-	if (ind >= mbox->num_chans)
+	if (sp->args_count < 1 || ind >= mbox->num_chans)
 		return ERR_PTR(-EINVAL);
 
 	return &mbox->chans[ind];
-- 
2.51.0.384.g4c02a37b29-goog



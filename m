Return-Path: <linux-kernel+bounces-741001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C02B0DEB5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF253AC5166
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E49723AB9D;
	Tue, 22 Jul 2025 14:23:47 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A3195
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194226; cv=none; b=qRSKhNgyvkercc/lEB7JtvIEn0YvB6k7C1imnUkfWa5ehV/fYQ5yQMsR5YvKzv9NsLyC13/Ls983HR1g+p1PUS/EnMLduRD9otHlb+zQ5UjOzw14Rf0jjloFlBXp1Q8vVhjCR9OtQ310sryM5CG+P8a/cJdjdFePXPqoj/Cu9jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194226; c=relaxed/simple;
	bh=6HMmRzV3Vv3TzxnjFgwzgMzd6L8joE5nHO4prk28S/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ff+8J+A0NHDhft2AGIbS7GlD4rYpu1qpWjwpYZI+r5pvkvi9H0sAIbz/QjKtoFu/7hsEnpIF/JPK5a/pykpHx1UKORN8R2kMgupZdO0DOTfe6R2pheZJg+9st7kJrGgactK27P42jSEOHBysn9tEjbfqqXeLKtkQgwmrYmma2HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 009731A044A;
	Tue, 22 Jul 2025 14:23:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 5FC372001E;
	Tue, 22 Jul 2025 14:23:41 +0000 (UTC)
Date: Tue, 22 Jul 2025 10:24:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, apparmor@lists.ubuntu.com
Cc: John Johansen <john.johansen@canonical.com>
Subject: Re: Lockdep warning for non-static key in apparmor code
Message-ID: <20250722102413.52083c6e@gandalf.local.home>
In-Reply-To: <20250722100413.117462d2@gandalf.local.home>
References: <20250722100413.117462d2@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: tstywm9r9h4xms6bpc8um9j9o66e3g36
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 5FC372001E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/zZ/aSobjVQGUAd7jsEcxZrvkd+kE9VrQ=
X-HE-Tag: 1753194221-783310
X-HE-Meta: U2FsdGVkX1/+pY7V+uD2DWTro7Xrm4Z/iaDwMTZKKDCdKCgWn1d0TDWd6kLTDrJFBsUAS8nw6VCtsUCuDg+v/0aBKfLR8lTYaOw8OtMjPUW7Xetl4pPxe028btGvv4a+0JajdyLcfZbB+q3EcatWiGDRh1jw16YUIppc49Bjtv4/P2J10d5XJwD9QWTp2rCKYOyHomdYkmF+uvfAuupU7nbq/PhkzdrkFpH3cRpdyoRS8OGnSPtiVzVcgdVqYyMqJRwPr+fEc4fBFKYEhEmZY0m3SXvMNQEg9QGGNU+OJe1OZFEXyhkMVOwIBJ/xGOpbO0we7MAAaKtEd2iw+xD/HHdeT4l+gjs0rgCbnjf8cNJgYluLP2iPrHhJieX7qbD4

On Tue, 22 Jul 2025 10:04:13 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Booting latest linux-next, I triggered this warning.
> 
> Looks to be associated to apparmor. Was there an allocated spinlock not
> initialized properly?

Yeah, you don't initialize the spin lock. Is there a reason you commented
out the spin lock initialization in 88fec3526e841 ("apparmor: make sure
unix socket labeling is correctly updated.")?

--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -508,7 +508,6 @@ static int apparmor_file_alloc_security(struct file *file)
        struct aa_file_ctx *ctx = file_ctx(file);
        struct aa_label *label = begin_current_label_crit_section();
 
-       spin_lock_init(&ctx->lock);
        rcu_assign_pointer(ctx->label, aa_get_label(label));
        end_current_label_crit_section(label);
        return 0;
@@ -1076,12 +1075,29 @@ static int apparmor_userns_create(const struct cred *cred)
        return error;
 }
 
+static int apparmor_sk_alloc_security(struct sock *sk, int family, gfp_t gfp)
+{
+       struct aa_sk_ctx *ctx = aa_sock(sk);
+       struct aa_label *label;
+       bool needput;
+
+       label = __begin_current_label_crit_section(&needput);

+       //spin_lock_init(&ctx->lock);
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+       rcu_assign_pointer(ctx->label, aa_get_label(label));
+       rcu_assign_pointer(ctx->peer, NULL);
+       rcu_assign_pointer(ctx->peer_lastupdate, NULL);
+       __end_current_label_crit_section(label, needput);
+       return 0;
+}

-- Steve


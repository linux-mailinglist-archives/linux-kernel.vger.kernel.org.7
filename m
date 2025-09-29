Return-Path: <linux-kernel+bounces-836616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B19BAA2C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB3316B6B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514C8304BC7;
	Mon, 29 Sep 2025 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qdwLl96+"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A022D29C7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759166935; cv=none; b=mywEJWizmywUG1BECM/tsCqAhal+iXmpAbd1Bh/apKP1pzy8h00kqyR9SdaT4T9X6ZOjksDOUZiVH7RgrNIirU+a1DBzJuQ7zjRqhTK8KzmNywN+MPWOJLydjlUsZWAKeJT2GCzr4BvRDQ7BS4ZnZhfIYK2e3UTEeoClyTIyCM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759166935; c=relaxed/simple;
	bh=TU1+KKcikkkLjZS/wSy3MRVptcZvum7r3LS6KuJtDTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iV4XFw/juplg201g6oIyLR5BuUqklUkjAjzCa5Qy1zZySlkSZnopN3hN01I61P+No3fQxQXqNG3xdnVYlO2CKvSKYFnVsyBc9+XgymJDLtcq3ChAgtwgklUkYSvCseCg8pmUNMFjdcHbywcDmvog/ZuYTQA3/vX0dv0TxoIHzqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qdwLl96+; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57abcb8a41eso601e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759166932; x=1759771732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhKpPku9iPtRnpJMr9y5imP2rZWCpDDnfk1JiYa7Yr0=;
        b=qdwLl96+TF/Z5rbKvLRYUrChe64682ulE7cHcjKn4i2xSSqMCGgXKlXSVyrHbpWTaw
         soLotDpOwq/5z7ZccSbMhm5i+2+W3dE+AogCjspuWN+cLeLDdf8VfEkHGXsMbYa3aEri
         hTi7tpU84WFcB2PkWh9D4TKZjOsBrM84IXA49JdhyF16GVFun40/CRwJ1wGd2P5Hkdrw
         gteA4taIyzNCueVGiH4NUDOmtE7sqlkEs2AQQ2x1Tqefj/QHEzP7PhcyKloaGv8XJFyj
         r+6HV/4IIwuiByHcpMeUJoYJXmKKlFEXHAqCFgp8tNvTyDy5NL/uxZMZPJwunFD4V5ur
         Rzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759166932; x=1759771732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhKpPku9iPtRnpJMr9y5imP2rZWCpDDnfk1JiYa7Yr0=;
        b=nlS4CAYibapv4Wq5zTdai25SBj40XARjv37gzdWGDepDwM3RNU4OMF1Y5u0ICkz8jD
         f2UF3fANKXGSnDzl95ljiX3iwlGJTqXTae4P1SinygG9rMQ+/Rxxf+IaXTBlAUPCqJbY
         giQxCUVs/On163iHhoR8FpwdjOX0Fmy7HGDRcCtxEJbDWyI3pWEnshhVweZGNJJpeQ2Y
         Eax/Jb0O23V4OmSyYfExkBW/E2K4nKa3x5tz09FL8UJeDGHQ4yn1OixWJphqaR3sHZSQ
         tfRKlLEdufliky1BP/eB6M8aoUwBZt3FcGoI9Wb+LUCqIrqTS+NAhSrgi8FNTnEsisSY
         NIbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlAytTLbcIqzPhSeicGHj2hGEwwJO6q/sfgcveWE4q54Z6joIO0TbECfZyRjLePGy9gT3g3rQIHl2BCHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzupLw7LjTNPOGy/kQp6xBidqxSS1OIrElFs03L+66/CKxWCh23
	ZKztJ8O8fgNaWWIs2U9tR2nEEWxD4qkoLTyybQVmbjI1eqccGTtmS+8eAOGlcoh+bRMEmx+ecEm
	IeZt6yp0QXglB+Nu9Mf5AVGqaOwKqtGM7+R/A98Es
X-Gm-Gg: ASbGncvsYhi25FzYAc1v+80udb8/N9TN5oOZH1wbG3BzpN7mDNkoIlyaujAQMrjIF6H
	WeVqavcRizlxeawVlVhwXeQYMOwlmRl9ZeJfFrBMvi1gn6renIcwnMVyzBmmh/qEa+Xlvr72WgR
	JgJSPaDhF3k4tdT2XE9kY6omSuS3nZM8IQV8naBdHbU+i6yZ9Wa5ZpdHtZr7iCWPfiGZit8Mj9T
	pVEEV2XvcnGNxEAoMd0uGjAAxYtS2q3ljglEZ4cyRU3rL2DLD43pTg=
X-Google-Smtp-Source: AGHT+IF99d/3kb3Gk5B+kwnd34oyoZWkh3LmdLYeV5VseYbT35wyGBmZXsSZRWmJJqcSu7tB1vRN/cw05D0b8aZfkW4=
X-Received: by 2002:ac2:533c:0:b0:579:fbe5:4467 with SMTP id
 2adb3069b0e04-58a70558192mr34157e87.4.1759166931717; Mon, 29 Sep 2025
 10:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926035423.51210-1-byungchul@sk.com> <aNau1UuLdO296pJf@horms.kernel.org>
 <20250929014619.GA20562@system.software.com>
In-Reply-To: <20250929014619.GA20562@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 29 Sep 2025 10:28:39 -0700
X-Gm-Features: AS18NWAe7i2Wt2VA7cP32l13mdSbxortudnDpG4vSLEkGRbB2jnfYA_HeBXsCYE
Message-ID: <CAHS8izOK=Y1TWyA6XV05d9i3D8xnhGcX2R-sZBYJXiVsE-RM9w@mail.gmail.com>
Subject: Re: [PATCH net-next v3] netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()
To: Byungchul Park <byungchul@sk.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel_team@skhynix.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org, toke@redhat.com, 
	asml.silence@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 6:46=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> On Fri, Sep 26, 2025 at 04:18:45PM +0100, Simon Horman wrote:
> > On Fri, Sep 26, 2025 at 12:54:23PM +0900, Byungchul Park wrote:
> > > Changes from RFC v2:
> > >       1. Add a Reviewed-by tag (Thanks to Mina)
> > >       2. Rebase on main branch as of Sep 22
> > >
> > > Changes from RFC:
> > >       1. Optimize the implementation of netmem_to_nmdesc to use less
> > >          instructions (feedbacked by Pavel)
> > >
> > > --->8---
> > > >From 01d23fc4b20c369a2ecf29dc92319d55a4e63aa2 Mon Sep 17 00:00:00 20=
01
> > > From: Byungchul Park <byungchul@sk.com>
> > > Date: Tue, 29 Jul 2025 19:34:12 +0900
> > > Subject: [PATCH net-next v3] netmem: replace __netmem_clear_lsb() wit=
h netmem_to_nmdesc()
> > >
> > > Now that we have struct netmem_desc, it'd better access the pp fields
> > > via struct netmem_desc rather than struct net_iov.
> > >
> > > Introduce netmem_to_nmdesc() for safely converting netmem_ref to
> > > netmem_desc regardless of the type underneath e.i. netmem_desc, net_i=
ov.
> > >
> > > While at it, remove __netmem_clear_lsb() and make netmem_to_nmdesc()
> > > used instead.
> > >
> > > Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > Reviewed-by: Mina Almasry <almasrymina@google.com>
> >
> > Hi Byungchul,
> >
> > Some process issues from my side.
> >
> > 1. The revision information, up to including the '--->8---' line above
> >    should be below the scissors ('---') below.
> >
> >    This is so that it is available to reviewers, appears in mailing
> >    list archives, and so on. But is not included in git history.
>
> Ah yes.  Thank you.  Lemme check.
>
> > 2. Starting the patch description with a 'From: ' line is fine.
> >    But 'Date:" and 'Subject:' lines don't belong there.
> >
> >    Perhaps 1 and 2 are some sort of tooling error?
> >
> > 3. Unfortunately while this patch is targeted at net-next,
> >    it doesn't apply cleanly there.
>
> I don't understand why.  Now I just rebased on the latest 'main' and it
> works well.  What should I check else?
>
> > When you repost, be sure to observe the 24h rule.
>
> Thanks!
>

Additionally net-next is closed:

https://lore.kernel.org/netdev/20250928212617.7e0cbfe4@kernel.org/

Changes targetting net-next need to be sent after the re-open. RFC is
always welcome.



--=20
Thanks,
Mina


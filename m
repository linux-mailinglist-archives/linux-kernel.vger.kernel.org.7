Return-Path: <linux-kernel+bounces-818855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20C5B59734
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099FE32220D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1657BFC1D;
	Tue, 16 Sep 2025 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEkZwyTf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE030F535
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028519; cv=none; b=QV5AWxtwYxTfihPismiim9H++rOzjofqzj2WwPkxMhs82n+PsMQVjbZLNNHzS1TPS7/vz5uvRms1wE9J+23R0MumhI4Tn5QdsHBT8/t5BfRGRYCmHj+eoc7x1P5aclV4PPjtJYLf6w8AbplhA1/9eXSj+ReERlkMwLlX5YXaEfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028519; c=relaxed/simple;
	bh=CFNU9J4akqLpC+4ufj0IXFbsTGHn/fYlRnS55Ajz+Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgSCfVz06mvxhn9PD6cIVf717f4kuEjrG5qN8DKZ86werW0MLI/FT9pl7dA2mL3fK27ZutHOMBA4N2G1oycXmaQwzB3hAWmd/FHBvsZVfHqFEfeQiRqrmTAfdRukAGjSTYaLjIPhGqKMAaxauTyZUgDih519ziY61sF3ZjzXWJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEkZwyTf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758028517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFNU9J4akqLpC+4ufj0IXFbsTGHn/fYlRnS55Ajz+Tg=;
	b=PEkZwyTf4Ar5FkTB/aFT7C3yvOgvSnkvxAwY7czlwYDNVjJjtMPcYnR6DxcmbheRLkkG7x
	QCQ2Gs10q6nyYEKp2MGkdEvpHBoIv4f8NeQvJJWiDa6gbCL+pA/UmWX9Muw/fryNiOP2gy
	M77/EXqtHk4aNgSL6e1YxWvmXj89H6o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-7HQGRdzxO8aOOWxkJ8sbIA-1; Tue, 16 Sep 2025 09:15:15 -0400
X-MC-Unique: 7HQGRdzxO8aOOWxkJ8sbIA-1
X-Mimecast-MFC-AGG-ID: 7HQGRdzxO8aOOWxkJ8sbIA_1758028515
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-afe7b40b15fso548617466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758028514; x=1758633314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFNU9J4akqLpC+4ufj0IXFbsTGHn/fYlRnS55Ajz+Tg=;
        b=CRXM+is6MEGsVl9hasr0U1ihk6wygZTF3D2mOVbLbN5Lfk64TXMmd1BieP+fZyzGN9
         XV2MujwynDNqHnVDFlR7K1SxV13WNZRlKE4zSXMaLXIZB72nkIjn78+BG71dMK6TjzQe
         H1sP11bjme0PtAetfM/S7/4A7PVPEjAxRpXZC4RzR/PVQEPJ8Pdgm9r4/ZJ65RXIkQya
         Ggdharmf0uq8/nmBci9kfRC5NIFuc/dxKd5APT4ezEkODATPcYB6jx+RXJN/TaFSgMdH
         V7u/u9kr2eaNKPQhJxKhWJUGNbgtqd9Uc3/qNrtsoxODagPdXJoaVP0pUZ8Yhy9ATApQ
         qmiw==
X-Forwarded-Encrypted: i=1; AJvYcCVrqfZv9Cl6NKoajIawItdFFf2JmeLTNZy5qmer1RRS7FP1TP6wJn9wWQ8tJj8FGEsnvKZM2vGPVW73wtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoMJiy+MuS2zEmD27KhJKNsvklCaV3GvDW+Bid+I/P5P1e11ey
	ltx9RWMId+McrE1UpXKDiW3K0QAi9n5XSN8MigsWfcyTElxfrEa66KnlchnfwEK5xs+DDhaeYDQ
	k91gU85NsN3MtJ2PhVDNPCC7NBqXWqFAZj5GzlHKELBXQ/R+U7jOG3lmbknPbVrwurk+CHnawrM
	lcByWGyld+MroU7DCjKxooAd1nJZJSUTZ14J/r4SMw
X-Gm-Gg: ASbGnct9XLI6C8VyTV86z/HoBmqdV3bsq5vmsc7+ol8z7P/h2325ctCnQp66WPzv/Nn
	zVVlERS11WfekFiWjleo/2TTzSK2EhQYjx029XpwjK32Yn/McQQi8Q5XLI1wfqy8W8wsWWIAcLn
	OwUO3inyQLpaIDXUmbPfA=
X-Received: by 2002:a17:907:6e93:b0:b04:563f:e120 with SMTP id a640c23a62f3a-b07c3a701e3mr1534969966b.53.1758028514527;
        Tue, 16 Sep 2025 06:15:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+BigIFv5ET4lzWam5rtJcyPE/Kp4vz+0aQgQ0Q9cVQP1nN06SCjVFvH6Jkzzub/uEvI9gCSLh8aBvLjiEIoY=
X-Received: by 2002:a17:907:6e93:b0:b04:563f:e120 with SMTP id
 a640c23a62f3a-b07c3a701e3mr1534966666b.53.1758028514107; Tue, 16 Sep 2025
 06:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915181101.52513-1-wander@redhat.com>
In-Reply-To: <20250915181101.52513-1-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 16 Sep 2025 15:15:03 +0200
X-Gm-Features: AS18NWCjp52mBkr4kl6nNsC7R-KHcGjXkKQGi2ybfsO1XhfaQkh8bnHJyUJxXxk
Message-ID: <CAP4=nvSHeGEmP6sLBLK==pwEHw4SnvFOhVYiSnWC-DYBPoepfg@mail.gmail.com>
Subject: Re: [PATCH v2] rtla/actions: Fix condition for buffer reallocation
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Chang Yin <cyin@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Gabriele Monaco <gmonaco@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 15. 9. 2025 v 20:11 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> The condition to check if the actions buffer needs to be resized was
> incorrect. The check `self->size >=3D self->len` would evaluate to
> true on almost every call to `actions_new()`, causing the buffer to
> be reallocated unnecessarily each time an action was added.
>
> Fix the condition to `self->len >=3D self.size`, ensuring
> that the buffer is only resized when it is actually full.
>
> Fixes: 6ea082b171e00 ("rtla/timerlat: Add action on threshold feature")
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
>

The blame goes entirely on me for getting confused by my own naming of
the fields. Thank you.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas



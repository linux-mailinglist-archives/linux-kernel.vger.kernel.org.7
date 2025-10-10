Return-Path: <linux-kernel+bounces-848095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2231ABCC818
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBED6408917
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1109828314E;
	Fri, 10 Oct 2025 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YTf6CEsu"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6AA26CE1A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091558; cv=none; b=lM6xsACVaygIc39ch4NppKfPDD/i0YjhUbJoLos+3OL6H3+49OXnG93SHCmhnY1/Ily28i8RusUPQpVb3Gj68lwusN+LakWnmVHDdVFurq+mwtYB73YQO4t5mUfS2yF9Skd96BgKr3LySZCYKJck7/S1+bqriVC9AOJKYQi9SDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091558; c=relaxed/simple;
	bh=BlH2HB/zjYtMuFQ8q6r5muySIedlSg2wfz3PXl4AABA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRSzhwatP967ZfnkMv1e6oxa2mhnchXUHjvdx6MBj0sOVkzV7/l//Ff0eqyKAOo3sdMFq4YFFRspeQUPAjljWG7i1hFZeYskZQD5StOsrcBNNnhOuNjS5qIsvP4T59EF5e5w1S8I0TtTxV7ivFoktwyXXUmdP5hsJQmWBALO9xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YTf6CEsu; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-36bf096b092so17879431fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760091551; x=1760696351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmFRzgl9uXYgp03GRaYVce/s/7CUNVixGBo0j+ip+Kc=;
        b=YTf6CEsu04abBADMnXKYVOEqNX7wNVk2BjfFyw5r2fHAI4mQDZQKgFDWKp1ECLI5LY
         TwnBmrX7Kauuziaa/Qxn7PZnq53Kkf7w2TZ+8CdNQq/Mc58ERGoL2n5TPEklL9W3OIGk
         9xvsroa32J5ggoKxN7JyJGplHYy6lU+zP5fqELHtluxEGPATu9snipTl8FqJO3j5RCMk
         w4rytuack9SlcxDTB0is6b0VmTprnXKKTaoVrImmbuwEqMZjI7XvyZulVDdteehDt0RQ
         jFEEoSlsjdlBQeP6imnf/p2fF8vr5bxbTqD52kgIp9CQhr62h+6JTaf3b/+IPi5taxG5
         J1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760091551; x=1760696351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmFRzgl9uXYgp03GRaYVce/s/7CUNVixGBo0j+ip+Kc=;
        b=h61H1Q+XApB1QQnP2wPMlPp/Qe2DOWo8oHvtSa8hCTTg32nbsd4WrlczQVKoalXVft
         i7OR6ti+KECRD4zXZZ/+4PVK5Q2Igb34eok/0nvBGdwcO4ZpGQtyvaRCUXNgS3ALKwZF
         rdqeCj9ATm6lI1KrbHZU+rqLpEl7h3LVMvk5sAcE/blPg9wqWWEP5YM9rPtY8qqgFg4a
         TsmwRrCtqKsZ4itoocJHjcfuNl3GX1VppF72OHcAR+hs3+LSeciD5TrfBNQVK/UoKlL7
         sWzu2BRX2qsKFNHl1LbX2k/nUlPdvgkH51SAX2AIrXkIV6QzDmHteZECR3/0qFrrUHAo
         8uWQ==
X-Gm-Message-State: AOJu0YzI02DW+imB7HlA1OzT3gtNCkRRpM6stcpxaFs5ygA7SJzwJJZI
	6zMyWqcli98ygNQYumPqcY8JeORKg16R+c6SvrtBgQ+NXiZo88MuIOu3ux39BNmjsSiYMxkauu6
	ranrBQ7PMoqAIMAXdIz76v8vO8Iss1jO2qSNLd6fSBOWqHl2LWO72
X-Gm-Gg: ASbGnctVTGZHcSeXFNEStn+svEX9O+FCO7gnXil5BTuDUFyxkNn3osbyz2i+jsOSaLq
	r7lgp/b+GyRlSF7+YN6XqR+fdcE2DnukEM0ZBFQuzafOKfsrbpnO+ynjN11RPOmP7BKNJLzHfm/
	UI76eAPjWharuaR7bmy955DO4u3O9YfBbGYMrXX96qwgDu3gMPQ6zXVPFG+iheobtyp8mMUV4Bq
	VjRdMNqc+T6XNAkTivQOBsuK4fD/AE8WklJ6l0/kzye0xZPJHWZpAd/ywk=
X-Google-Smtp-Source: AGHT+IHyHVojHIHw+umUP3MHexawcGpAaz8R7mHqAp71CbtRNFJzB7tpvww3ZNnHl0Xhyv5XYBPXP/grZmTc40bDiD8=
X-Received: by 2002:a05:651c:1586:b0:355:b3ec:11e2 with SMTP id
 38308e7fff4ca-37609c9caddmr29643721fa.8.1760091551017; Fri, 10 Oct 2025
 03:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905091116.110314-1-marco.crivellari@suse.com>
In-Reply-To: <20250905091116.110314-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 10 Oct 2025 12:19:00 +0200
X-Gm-Features: AS18NWCM1XRwxbkPRH3p-TGZG4y0BJM84TX_xRyiepfD0SSF0zuwBHYDirh55Yg
Message-ID: <CAAofZF7-adtv+GOBdRfs4XCCj3Wwj-hoyF8uOX19zP=gyw6teQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] umh: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 11:11=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> Marco Crivellari (1):
>   umh: replace use of system_unbound_wq with system_dfl_wq
>
>  kernel/umh.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Gentle ping. :-)


Thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

